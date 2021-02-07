#region License
/* 
 * Copyright (C) 1999-2021 John Källén.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#endregion

using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace Reko.Core.CLanguage
{
    public class CLexer 
    {
        private readonly TextReader rdr;
        private readonly StringBuilder sb;
        private readonly Dictionary<string, CTokenType> keywordHash;

        public CLexer(TextReader rdr, Dictionary<string, CTokenType> keywords)
        {
            this.rdr = rdr;
            this.sb = new StringBuilder();
            this.LineNumber = 1;
            this.keywordHash = keywords;
        }

        private enum State
        {
            Start,
            Zero,
            DecimalNumber,
            OctalNumber,
            HexNumber,
            RealNumber,
            RealDecimalPoint,
            Id,
            StringLiteral,
            StringEscape,
            Eq,
            Plus,
            Minus,
            Star,
            Slash,
            Percent,
            Ampersand,
            Pipe,
            Caret,
            Bang,
            CharLiteral,
            CharEscape,
            CharLiteralTerminate,
            RealExponent,
            RealExponentDigits,
            Lt,
            Gt,
            Shl,
            Shr,
            RealExponentSign,
            Dot,
            DotDot,
            Colon,
            LineComment,
            MultiLineComment,
            MultiLineCommentStar,
            HexNumberSuffix,
            DecimalNumberSuffix,
            L,
        }

        public int LineNumber { get; private set; }

        /// <summary>
        /// Keywords used by the standard C language.
        /// </summary>
        public static Dictionary<string, CTokenType> StdKeywords { get; }

        /// <summary>
        /// Keywords used by the GCC compiler.
        /// </summary>
        public static Dictionary<string, CTokenType> GccKeywords { get; }

        /// <summary>
        /// Keywords used by the MSVC compiler.
        /// </summary>
        public static Dictionary<string, CTokenType> MsvcKeywords { get; }

        /// <summary>
        /// Keywords used by the MSVC compiler for Windows CE.
        /// </summary>
        public static Dictionary<string, CTokenType> MsvcCeKeywords { get; }

        public CToken Peek()
        {
            throw new NotImplementedException();
        }

        public CToken Read()
        {
            if (!EatWs())
                return Tok(CTokenType.EOF);

            State state = State.Start;
            bool wideLiteral = false;
            ClearBuffer();
            for (; ; )
            {
                int c = rdr.Peek();
                char ch = (char) c;
                switch (state)
                {
                case State.Start:
                    if (c < 0)
                        return Tok(CTokenType.EOF);
                    rdr.Read();
                    switch (ch)
                    {
                    case '!':
                        state = State.Bang;
                        break;
                    case '"':
                        state = State.StringLiteral;
                        break;
                    case '#':
                        sb.Append(ch);
                        state = State.Id;
                        break;
                    case '%': state = State.Percent; break;
                    case '\'': state = State.CharLiteral; break;
                    case '&': state = State.Ampersand; break;
                    case '(': return Tok(CTokenType.LParen);
                    case ')': return Tok(CTokenType.RParen);
                    case '.': state = State.Dot; break;
                    case ',': return Tok(CTokenType.Comma);
                    case ':': state = State.Colon; break;
                    case ';': return Tok(CTokenType.Semicolon);
                    case '/': state = State.Slash; break;
                    case '<': state = State.Lt; break;
                    case '=': state = State.Eq; break;
                    case '>': state = State.Gt; break;
                    case '0':
                        sb.Append(ch);
                        state = State.Zero;
                        break;
                    case '*': state = State.Star; break;
                    case '+':
                        state = State.Plus;
                        break;
                    case '-':
                        state = State.Minus;
                        break;
                    case '?': return Tok(CTokenType.Question);
                    case '[': return Tok(CTokenType.LBracket);
                    case ']': return Tok(CTokenType.RBracket);
                    case '^': state = State.Caret; break;
                    case '{': return Tok(CTokenType.LBrace);
                    case '|': state = State.Pipe; break;
                    case '}': return Tok(CTokenType.RBrace);
                    case '~': return Tok(CTokenType.Tilde);
                    default:
                        if (Char.IsDigit(ch))
                        {
                            sb.Append(ch);
                            state = State.DecimalNumber;
                        }
                        else if (Char.IsLetter(ch) || ch == '_')
                        {
                            sb.Append(ch);
                            state = ch == 'L' ? State.L : State.Id;
                        }
                        else
                        {
                            Nyi(state, ch);
                        }
                        break;
                    }
                    break;
                case State.Zero:
                    if (c < 0)
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString()));
                    switch (ch)
                    {
                    case 'x':
                    case 'X':
                        rdr.Read();
                        ClearBuffer();
                        state = State.HexNumber;
                        break;
                    case '.':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealDecimalPoint;
                        break;
                    case '0': case '1': case '2': case '3':
                    case '4': case '5': case '6': case '7':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.OctalNumber;
                        break;
                    case '8': case '9':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.DecimalNumber;
                        break;
                    default:
                        if (IsIntegerSuffix(ch))
                        {
                            rdr.Read();
                            state = State.DecimalNumberSuffix;
                            break;
                        }
                        //$BUG: F suffix.
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString()));
                    }
                    break;
                case State.OctalNumber:
                    if (c < 0)
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString(), 8));
                    switch (c)
                    {
                    case '0': case '1': case '2': case '3':
                    case '4': case '5': case '6': case '7':
                        rdr.Read();
                        sb.Append(ch);
                        break;
                    default:
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString(), 8));
                    }
                    break;
                case State.DecimalNumber:
                    if (c < 0)
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString()));
                    switch (ch)
                    {
                    case 'e':
                    case 'E':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealExponent;
                        break;
                    case '.':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealDecimalPoint;
                        break;
                    default:
                        if (Char.IsDigit(ch))
                        {
                            rdr.Read();
                            sb.Append(ch);
                            break;
                        }
                        else if (IsIntegerSuffix(ch))
                        {
                            rdr.Read();
                            state = State.DecimalNumberSuffix;
                            break;
                        }
                        else
                        {
                            return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString()));
                        }
                    }
                    break;
                case State.DecimalNumberSuffix:
                    if (c >= 0 && IsIntegerSuffix(ch))
                    {
                        rdr.Read();
                        break;
                    }
                    return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString()));
                case State.RealDecimalPoint:
                    if (c < 0 || !Char.IsDigit(ch))
                        throw new FormatException("Expected digits after decimal point.");
                    rdr.Read();
                    sb.Append(ch);
                    state = State.RealNumber;
                    break;
                case State.RealNumber:
                    if (c < 0)
                        return Tok(CTokenType.RealLiteral, Convert.ToDouble(sb.ToString(), CultureInfo.InvariantCulture));
                    switch (ch)
                    {
                    case 'e': 
                    case 'E':
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealExponent;
                        break;
                    case 'f':
                    case 'F':
                        rdr.Read();
                        return Tok(CTokenType.RealLiteral, Convert.ToSingle(sb.ToString(), CultureInfo.InvariantCulture));
                    default:
                        if (Char.IsDigit(ch))
                        {
                            rdr.Read();
                            sb.Append(ch);
                        }
                        else 
                        {
                            return Tok(CTokenType.RealLiteral, Convert.ToDouble(sb.ToString(), CultureInfo.InvariantCulture));
                        }
                        break;
                    }
                    break;
                case State.RealExponent:
                    if (c < 0)
                        throw new FormatException("Invalid floating-point number.");
                    if (c == '-' || c == '+')
                    {
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealExponentSign;
                        break;
                    }
                    else if (Char.IsDigit(ch))
                    {
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealExponentDigits;
                    }
                    else
                        throw new FormatException("Invalid floating-point number.");
                    break;
                case State.RealExponentSign:
                    if (c < 0)
                        throw new FormatException("Invalid floating-point number.");
                    if (Char.IsDigit(ch))
                    {
                        rdr.Read();
                        sb.Append(ch);
                        state = State.RealExponentDigits;
                    }
                    else
                        throw new FormatException("Invalid floating-point number.");
                    break;
                case State.RealExponentDigits:
                    if (c < 0)
                        return Tok(CTokenType.RealLiteral, Convert.ToDouble(sb.ToString(), CultureInfo.InvariantCulture));
                    if (ch == 'f' || ch == 'F')
                    {
                        rdr.Read();
                        return Tok(CTokenType.RealLiteral, Convert.ToSingle(sb.ToString(), CultureInfo.InvariantCulture));
                    }
                    else 
                    {
                        return Tok(CTokenType.RealLiteral, Convert.ToDouble(sb.ToString(), CultureInfo.InvariantCulture));
                    }
                case State.HexNumber:
                    if (c < 0)
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString(), 16));
                    if (IsIntegerSuffix(ch))
                    {
                        rdr.Read();
                        state = State.HexNumberSuffix;
                    }
                    else if (IsHexDigit(ch))
                    {
                        rdr.Read();
                        sb.Append(ch);
                    }
                    else
                    {
                        return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString(), 16));
                    }
                    break;
                case State.HexNumberSuffix:
                    if (c >= 0 && IsIntegerSuffix(ch))
                    {
                        rdr.Read();
                        break;
                    }
                    return Tok(CTokenType.NumericLiteral, Convert.ToInt32(sb.ToString(), 16));
                case State.Id:
                    if (c >= 0 && Char.IsLetter(ch) || Char.IsDigit(ch) || ch == '_')
                    {
                        rdr.Read();
                        sb.Append(ch);
                    }
                    else
                    {
                        var tokenId = LookupId();
                        if (tokenId.Type != CTokenType.__Extension)
                            return tokenId;
                        EatWs();
                        state = State.Start;
                        sb.Clear();
                    }
                    break;
                case State.CharLiteral:
                    if (c < 0)
                        throw new FormatException("Character literal wasn't terminated.");
                    rdr.Read();
                    switch (ch)
                    {
                    case '\\':
                        state = State.CharEscape;
                        break;
                    case '\'':
                        throw new FormatException("Empty character literal.");
                    default:
                        sb.Append(ch);
                        state = State.CharLiteralTerminate;
                        break;
                    }
                    break;
                case State.CharEscape:
                    if (c < 0)
                        throw new FormatException("Character constant wasn't terminated.");
                    rdr.Read();
                    sb.Append(ch);
                    state = State.CharLiteralTerminate;
                    break;
                case State.CharLiteralTerminate:
                    if (c < 0 || ch != '\'')
                        throw new FormatException("Character constant wasn't terminated.");
                    rdr.Read();
                    return Tok(wideLiteral ? CTokenType.WideCharLiteral : CTokenType.CharLiteral, sb[0]);
                case State.StringLiteral:
                    if (c < 0)
                        throw new FormatException("String constant wasn't terminated.");
                    rdr.Read();
                    switch (ch)
                    {
                    case '\"':
                        return Tok(wideLiteral ? CTokenType.WideStringLiteral : CTokenType.StringLiteral, sb.ToString());
                    case '\\':
                        state = State.StringEscape;
                        break;
                    default:
                            sb.Append(ch);
                        break;
                    }
                    break;
                case State.StringEscape:
                    if (c < 0)
                        throw new FormatException("String constant wasn't terminated.");
                    rdr.Read();
                    switch (ch)
                    {
                    default:
                        sb.Append(ch);
                        state = State.StringLiteral;
                        break;
                    }
                    break;
                case State.Dot:
                    if (c >= 0 && ch == '.')
                    {
                        rdr.Read();
                        state = State.DotDot;
                        break;
                    }
                    return Tok(CTokenType.Dot);
                case State.DotDot:
                    if (c >= 0 && ch == '.')
                    {
                        rdr.Read();
                        return Tok(CTokenType.Ellipsis);
                    }
                    throw new FormatException("Token '..' is not valid C.");
                case State.Colon:
                    if (c >= 0 && ch == ':')
                    {
                        rdr.Read();
                        return Tok(CTokenType.ColonColon);
                    }
                    return Tok(CTokenType.Colon);
                case State.Eq:
                    if (c >= 0 && ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.Eq);
                    }
                    else
                    {
                        return Tok(CTokenType.Assign);
                    }
                case State.Plus:
                    if (c < 0)
                        return Tok(CTokenType.Plus);
                    if (ch == '+')
                    {
                        rdr.Read();
                        return Tok(CTokenType.Increment);
                    } else if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.PlusAssign);
                    }
                    else 
                    {
                        return Tok(CTokenType.Plus);
                    }
                case State.Minus:
                    if (c < 0)
                        return Tok(CTokenType.Minus);
                    switch (ch)
                    {
                    case '-':
                        rdr.Read();
                        return Tok(CTokenType.Decrement);
                    case '=':
                        rdr.Read();
                        return Tok(CTokenType.MinusAssign);
                    case '>':
                        rdr.Read();
                        return Tok(CTokenType.Arrow);
                    default:
                        if (char.IsDigit(ch))
                        {
                            rdr.Read();
                            sb.Append('-');
                            sb.Append(ch);
                            state = ch == '0' ? State.Zero : State.DecimalNumber;
                            break;
                        }
                        else
                        {
                            return Tok(CTokenType.Minus);
                        }
                    }
                    break;
                case State.Bang:
                    if (c < 0)
                        return Tok(CTokenType.Bang);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.Ne);
                    }
                    else
                    {
                        return Tok(CTokenType.Bang);
                    }
                case State.Ampersand:
                    if (c < 0)
                        return Tok(CTokenType.Ampersand);
                    switch (ch)
                    {
                    case '&':
                        rdr.Read();
                        return Tok(CTokenType.LogicalAnd);
                    case '=':
                        rdr.Read();
                        return Tok(CTokenType.AndAssign);
                    default:
                        return Tok(CTokenType.Ampersand);
                    }
                case State.Star:
                    if (c < 0)
                        return Tok(CTokenType.Star);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.MulAssign);
                    }
                    else
                    {
                        return Tok(CTokenType.Star);
                    }
                case State.Slash:
                    if (c < 0)
                        return Tok(CTokenType.Slash);
                    switch (ch)
                    {
                    case '=': rdr.Read(); return Tok(CTokenType.DivAssign);
                    case '/': rdr.Read(); state = State.LineComment; break;
                    case '*': rdr.Read(); state = State.MultiLineComment; break;
                    default: return Tok(CTokenType.Slash);
                    }
                    break;
                case State.Percent:
                    if (c < 0)
                        return Tok(CTokenType.Percent);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.ModAssign);
                    }
                    else
                    {
                        return Tok(CTokenType.Percent);
                    }
                case State.Lt:
                    if (c < 0)
                        return Tok(CTokenType.Lt);
                    switch (ch)
                    {
                    case '=': 
                        rdr.Read();
                        return Tok(CTokenType.Le);
                    case '<':
                        rdr.Read();
                        state = State.Shl;
                        break;
                    default:
                        return Tok(CTokenType.Lt);
                    }
                    break;
                case State.Gt:
                    if (c < 0)
                        return Tok(CTokenType.Gt);
                    switch (ch)
                    {
                    case '=':
                        rdr.Read();
                        return Tok(CTokenType.Ge);
                    case '>':
                        rdr.Read();
                        state = State.Shr;
                        break;
                    default:
                        return Tok(CTokenType.Lt);
                    }
                    break;
                case State.Shl:
                    if (c < 0)
                        return Tok(CTokenType.Shl);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.ShlAssign);
                    }
                    else
                    {
                        return Tok(CTokenType.Shl);
                    }
                case State.Shr:
                    if (c < 0)
                        return Tok(CTokenType.Shr);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.ShrAssign);
                    }
                    else
                    {
                        return Tok(CTokenType.Shr);
                    }
                case State.Pipe:
                    if (c < 0)
                        return Tok(CTokenType.Pipe);
                    switch (ch)
                    {
                    case '=':
                        rdr.Read();
                        return Tok(CTokenType.OrAssign);
                    case '|':
                        rdr.Read();
                        return Tok(CTokenType.LogicalOr);
                    default:
                        return Tok(CTokenType.Pipe);
                    }
                case State.Caret:
                    if (c < 0)
                        return Tok(CTokenType.Xor);
                    if (ch == '=')
                    {
                        rdr.Read();
                        return Tok(CTokenType.XorAssign);
                    }
                    else
                    {
                        return Tok(CTokenType.Xor);
                    }
                case State.LineComment:
                    if (c < 0)
                        return Tok(CTokenType.EOF);
                    switch (ch)
                    {
                    case '\r':
                    case '\n':
                        EatWs();
                        state = State.Start;
                        break;
                    default:
                        rdr.Read(); break;
                    }
                    break;
                case State.MultiLineComment:
                    if (c < 0)
                        throw new FormatException("Unterminated comment.");
                    switch (ch)
                    {
                    case '\r':
                    case '\n':
                        EatWs();
                        break;
                    case '*':
                        rdr.Read();
                        state = State.MultiLineCommentStar;
                        break;
                    default:
                        rdr.Read(); break;
                    }
                    break;
                case State.MultiLineCommentStar:
                    if (c < 0)
                        throw new FormatException("Unterminated comment.");
                    switch (ch)
                    {
                    case '\r':
                    case '\n':
                        EatWs();
                        state = State.MultiLineComment;
                        break;
                    case '*':
                        rdr.Read();
                        state = State.MultiLineCommentStar;
                        break;
                    case '/':
                        rdr.Read();
                        if (!EatWs())
                            return Tok(CTokenType.EOF);
                        state = State.Start;
                        break;
                    default:
                        rdr.Read(); break;
                    }
                    break;
                case State.L:
                    if (c < 0)
                        return LookupId();
                    switch (ch)
                    {
                    case '\'':
                        wideLiteral = true;
                        sb.Clear();
                        rdr.Read();
                        state = State.CharLiteral;
                        break;
                    case '\"':
                        wideLiteral = true;
                        sb.Clear();
                        rdr.Read();
                        state = State.StringLiteral;
                        break;
                    default:
                        if (Char.IsLetter(ch) || Char.IsDigit(ch) || ch == '_')
                        {
                            rdr.Read();
                            sb.Append(ch);
                            state = State.Id;
                        }
                        else
                        {
                            return LookupId();
                        }
                        break;
                    }
                    break;
                default:
                    Nyi(state, ch);
                    break;
                }
            }
        }

        private void Nyi(State state, char ch)
        {
            throw new NotImplementedException(string.Format("State {0}, ch: {1} (U+{2:X4})", state, ch, (uint)ch));
        }

        private void ClearBuffer()
        {
            sb.Remove(0, sb.Length);
        }

        private CToken Tok(CTokenType type)
        {
            return new CToken(type);
        }

        private CToken Tok(CTokenType type, object value)
        {
            return new CToken(type, value);
        }

        private CToken LookupId()
        {
            string id = sb.ToString();
            if (keywordHash.TryGetValue(id, out CTokenType type))
            {
                return new CToken(type);
            }
            else
            {
                return new CToken(CTokenType.Id, id);
            }
        }

        private bool EatWs()
        {
            if (rdr == null)
                return false;
            int ch = rdr.Peek();
            while (ch >= 0 && Char.IsWhiteSpace((char)ch))
            {
                if (ch == '\n')
                    ++LineNumber;
                rdr.Read();
                ch = rdr.Peek();
            }
            return true;
        }

        private bool IsHexDigit(char ch)
        {
            switch (ch)
            {
            case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8':  case '9':
            case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': 
            case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': 
                return true;
            default:
                return false;
            }
        }

        private bool IsIntegerSuffix(char ch)
        {
            switch (ch)
            {
            case 'u': case 'U': case 'l': case 'L': return true;
            default: return false;
            }
        }

        public void SkipToNextLine()
        {
            for (; ; )
            {
                int c = rdr.Peek();
                if (c < 0)
                    return;
                char ch = (char) c;
                rdr.Read();
                if (ch == '\n')
                {
                    ++LineNumber;
                    return;
                }
                else if (ch == '\r')
                {
                    ++LineNumber;
                    c = rdr.Peek();
                    if (c < 0 || c != '\n')
                        return;
                    rdr.Read();
                    return;
                }
            }
        }

        static CLexer()
        {
            StdKeywords = new Dictionary<string, CTokenType>
            {
                { "#line", CTokenType.LineDirective },
                { "#pragma", CTokenType.PragmaDirective },
                { "auto", CTokenType.Auto },
                { "bool", CTokenType.Bool },
                { "char", CTokenType.Char },
                { "class", CTokenType.Class },
                { "const", CTokenType.Const },
                { "do", CTokenType.Do },
                { "double", CTokenType.Double },
                { "else", CTokenType.Else },
                { "enum", CTokenType.Enum },
                { "extern", CTokenType.Extern },
                { "float", CTokenType.Float },
                { "if", CTokenType.If },
                { "int", CTokenType.Int },
                { "long", CTokenType.Long },
                { "register", CTokenType.Register },
                { "restrict", CTokenType.Restrict },
                { "return", CTokenType.Return },
                { "short", CTokenType.Short },
                { "signed", CTokenType.Signed },
                { "sizeof", CTokenType.Sizeof },
                { "static", CTokenType.Static },
                { "struct", CTokenType.Struct },
                { "typedef", CTokenType.Typedef },
                { "unsigned", CTokenType.Unsigned },
                { "union", CTokenType.Union },
                { "void", CTokenType.Void },
                { "volatile", CTokenType.Volatile },
                { "wchar_t", CTokenType.Wchar_t },
                { "while", CTokenType.While },
                { "_Atomic", CTokenType._Atomic }
            };

            GccKeywords = new Dictionary<string, CTokenType>
            {
                { "_Bool", CTokenType._Bool },
                { "_cdecl", CTokenType.__Cdecl },
                { "_far", CTokenType._Far },
                { "_near", CTokenType._Near },
                { "__asm", CTokenType.__Asm },
                { "__asm__", CTokenType.__Asm },
                { "__attribute__", CTokenType.__Attribute },
                { "__cdecl", CTokenType.__Cdecl },
                { "__declspec", CTokenType.__Declspec },
                { "__extension__", CTokenType.__Extension },
                { "__extension__extern", CTokenType.Extern },
                { "__far", CTokenType._Far },
                { "__fastcall", CTokenType.__Fastcall },
                { "__forceinline", CTokenType.__ForceInline },
                { "__in_opt", CTokenType.__In_Opt },
                { "__inline", CTokenType.__Inline },
                { "__int64", CTokenType.__Int64 },
                { "__loadds", CTokenType.__LoadDs },
                { "__near", CTokenType._Near },
                { "__out_bcount_opt", CTokenType.__Out_Bcount_Opt },
                { "__pascal", CTokenType.__Pascal },
                { "__pragma", CTokenType.__Pragma },
                { "__restrict", CTokenType.Restrict },
                { "__ptr64", CTokenType.__Ptr64 },
                { "__signed__", CTokenType.Signed },
                { "__stdcall", CTokenType.__Stdcall },
                { "__success", CTokenType.__Success },
                { "__thiscall", CTokenType.__Thiscall },
                { "__w64", CTokenType.__W64 },
            }.Concat(StdKeywords)
            .ToDictionary(de => de.Key, de => de.Value);

            MsvcKeywords = new Dictionary<string, CTokenType>
            {
                { "_Bool", CTokenType._Bool },
                { "_cdecl", CTokenType.__Cdecl },
                { "_far", CTokenType._Far },
                { "_inline", CTokenType.__Inline },
                { "_near", CTokenType._Near },
                { "__asm", CTokenType.__Asm },
                { "__asm__", CTokenType.__Asm },
                { "__attribute__", CTokenType.__Attribute },
                { "__cdecl", CTokenType.__Cdecl },
                { "__declspec", CTokenType.__Declspec },
                { "__extension__", CTokenType.__Extension },
                { "__far", CTokenType._Far },
                { "__fastcall", CTokenType.__Fastcall },
                { "__forceinline", CTokenType.__ForceInline },
                { "__in", CTokenType.__In },
                { "__in_opt", CTokenType.__In_Opt },
                { "__inline", CTokenType.__Inline },
                { "__int64", CTokenType.__Int64 },
                { "__loadds", CTokenType.__LoadDs },
                { "__near", CTokenType._Near },
                { "__out", CTokenType.__Out },
                { "__out_bcount_opt", CTokenType.__Out_Bcount_Opt },
                { "__pascal", CTokenType.__Pascal },
                { "__pragma", CTokenType.__Pragma },
                { "__restrict", CTokenType.Restrict },
                { "__ptr64", CTokenType.__Ptr64 },
                { "__stdcall", CTokenType.__Stdcall },
                { "__success", CTokenType.__Success },
                { "__thiscall", CTokenType.__Thiscall },
                { "__unaligned", CTokenType.__Unaligned },
                { "__w64", CTokenType.__W64 },
            }.Concat(StdKeywords)
            .ToDictionary(de => de.Key, de => de.Value);

            MsvcCeKeywords = MsvcKeywords
                .Where(de => de.Key != "__asm")
                .ToDictionary(de => de.Key, de => de.Value);
        }
    }

    public struct CToken
    {
        private CTokenType type;
        private object? value;

        public CToken(CTokenType type) : this(type, null)
        {
        }

        public CToken(CTokenType type, object? value)
        {
            this.type = type;
            this.value = value;
        }

        public CTokenType Type { get { return type; } }
        public object? Value { get { return value; } }
    }

    public enum CTokenType
    {
        EOF = -1,

        None = 0,
        NumericLiteral,
        StringLiteral,
        WideStringLiteral,
        RealLiteral,
        CharLiteral,
        WideCharLiteral,

        Id,
        LineDirective,
        PragmaDirective,

        Ampersand,
        Assign,
        MulAssign,
        DivAssign,
        ModAssign,
        PlusAssign,
        MinusAssign,
        ShlAssign,
        ShrAssign,
        AndAssign,
        OrAssign,
        XorAssign,
        Eq,
        Ne,
        Lt,
        Le,
        Ge,
        Gt,
        LBrace,
        RBrace,
        LBracket,
        RBracket,
        LParen,
        RParen,
        Shl,
        Shr,
        Colon,
        ColonColon,
        Semicolon,
        Comma,
        Star,
        Slash,
        Percent,
        Plus,
        Minus,
        Tilde,
        Bang,
        Dot,
        Arrow,
        Increment,
        Decrement,
        Pipe,

        Auto,
        Bool,
        Case,
        Char,
        Class,
        Const,
        Default,
        Double,
        Else,
        Enum,
        Extern,
        Float,
        Int,
        LogicalAnd,
        LogicalOr,
        Long,
        Question,
        Register,
        Return,
        Restrict,
        Short,
        Signed,
        Sizeof,
        Static,
        Struct,
        Typedef,
        Union,
        Unsigned,
        Void,
        Volatile,
        Wchar_t,
        Xor,
        _Atomic,
        _Bool,
        _Far,
        _Near,
        __Asm,
        __Attribute,
        __Cdecl,
        __Declspec,
        __Extension,
        __Fastcall,
        __ForceInline,
        __In,
        __In_Opt,
        __Inline,
        __Int64,
        __LoadDs,
        __Out,
        __Out_Bcount_Opt,
        __Pascal,
        __Pragma,
        __Ptr64,
        __Stdcall,
        __Success,
        __Thiscall,
        __Unaligned,
        __W64,
        Switch,
        While,
        Do,
        For,
        Goto,
        Continue,
        Break,
        If,
        Ellipsis,
    }
}
