#region License
/*
 * Copyright (C) 2020 Sven Almgren.
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

using Reko.Core;
using Reko.Core.Expressions;
using Reko.Core.Operators;
using Reko.Core.Types;
using System;

namespace Reko.Evaluation
{
    /// <summary>
    /// Rule that matches (0 - (EXPRESSION == 0) + 1) and generates (!EXPRESSION).
    /// This is a solution for a very specific sequence of instructions.
    /// 
    /// Example x86 assembler:
    /// neg ax
    /// sbb ax, ax
    /// inc ax
    ///
    /// Example result:
    /// turn func(0x00 - (-MyVariable == 0x00) + 0x01) into func(!MyVariable)
    /// (With the help of UnaryNegEqZeroRule)
    /// </summary>
    public class LogicalNotFromArithmeticSequenceRule
    {
        private DataType? dataType;
        private Expression? expression;

        public bool Match(BinaryExpression binExp)
        {
            if (binExp.Operator != Operator.IAdd)
                return false;

            if (!(binExp.Right is Constant rightConstant) || rightConstant.ToInt64() != 1)
                return false;

            if (!(binExp.Left is BinaryExpression leftExpression) || leftExpression.Operator != Operator.ISub)
                return false;

            if (!leftExpression.Left.IsZero)
                return false;

            if (!(leftExpression.Right is BinaryExpression middleExpression) || middleExpression.Operator != Operator.Eq)
                return false;

            if (!middleExpression.Right.IsZero)
                return false;

            expression = middleExpression.Left;

            dataType = binExp.DataType;

            return true;
        }

        public Expression Transform()
        {
            return new UnaryExpression(Operator.Not, dataType!, expression!);
        }
    }
}
