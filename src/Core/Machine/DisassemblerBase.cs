#region License
/* 
 * Copyright (C) 1999-2020 John Källén.
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

using Reko.Core.Lib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace Reko.Core.Machine
{
    /// <summary>
    /// A disassembler can be considered an enumerator of disassembled
    /// instructions. This convenience class lets implementors focus on the
    /// important method, DisassembleInstruction.
    /// </summary>
    /// <remarks>
    /// All methods and properties that are specific to the instruction type 
    /// <typeparamref name="TInstr"/> should go here.
    /// </remarks>
    public abstract class DisassemblerBase<TInstr, TMnemonic> : DisassemblerBase, IEnumerable<TInstr>
        where TInstr : MachineInstruction
    {
        public IEnumerator<TInstr> GetEnumerator()
        {
            for (;;)
            {
                TInstr? instr = DisassembleInstruction();
                if (instr == null)
                    break;
                yield return instr;
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        /// <summary>
        /// Disassemble a single instruction. 
        /// </summary>
        /// <remarks>
        /// Implementors should make an effort to make sure this method doesn't
        /// throw an exception. Instead, they should return an invalid instruction
        /// and possibly spew a diagnostic message.
        /// </remarks>
        /// <returns>Return a disassembled machine instruction, or null
        /// if the end of the reader has been reached</returns>
        public abstract TInstr? DisassembleInstruction();

        public abstract TInstr NotYetImplemented(uint wInstr, string message);

        public virtual TInstr MakeInstruction(InstrClass iclass, TMnemonic mnemonic)
        {
            return default!;
        }

        public abstract TInstr CreateInvalidInstruction();

        // Utility functions 

        protected static Decoder<TDasm, TMnemonic, TInstr> Instr<TDasm>(TMnemonic mnemonic, params Mutator<TDasm> [] mutators)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            return new InstrDecoder<TDasm, TMnemonic, TInstr>(InstrClass.Linear, mnemonic, mutators);
        }

        protected static Decoder<TDasm, TMnemonic, TInstr> Instr<TDasm>(TMnemonic mnemonic, InstrClass iclass, params Mutator<TDasm>[] mutators)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            return new InstrDecoder<TDasm, TMnemonic, TInstr>(iclass, mnemonic, mutators);
        }

        protected static MaskDecoder<TDasm, TMnemonic, TInstr> Mask<TDasm>(int bitPos, int bitLength, params Decoder<TDasm, TMnemonic, TInstr>[] decoders)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            return new MaskDecoder<TDasm, TMnemonic, TInstr>(bitPos, bitLength, "", decoders);
        }

        protected static MaskDecoder<TDasm, TMnemonic, TInstr> Mask<TDasm>(int bitPos, int bitLength, string tag, params Decoder<TDasm, TMnemonic, TInstr>[] decoders)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            return new MaskDecoder<TDasm, TMnemonic, TInstr>(bitPos, bitLength, tag, decoders);
        }

        protected static BitfieldDecoder<TDasm, TMnemonic, TInstr> Mask<TDasm>(int p1, int l1, int p2, int l2, string tag, params Decoder<TDasm, TMnemonic, TInstr>[] decoders)
        {
            return new BitfieldDecoder<TDasm, TMnemonic, TInstr>(Bf((p1, l1), (p2, l2)), tag, decoders);
        }

        protected static BitfieldDecoder<TDasm, TMnemonic, TInstr> Mask<TDasm>(
            Bitfield[] bitfields,
            string tag, 
            params Decoder<TDasm, TMnemonic, TInstr>[] decoders)
        {
            return new BitfieldDecoder<TDasm, TMnemonic, TInstr>(bitfields, tag, decoders);
        }

        protected static BitfieldDecoder<TDasm, TMnemonic, TInstr> Mask<TDasm>(
            Bitfield[] bitfields,
            params Decoder<TDasm, TMnemonic, TInstr>[] decoders)
        {
            return new BitfieldDecoder<TDasm, TMnemonic, TInstr>(bitfields, "", decoders);
        }

        protected static ConditionalDecoder<TDasm, TMnemonic, TInstr> Select<TDasm>(
            Predicate<uint> predicate,
            Decoder<TDasm, TMnemonic, TInstr> decoderTrue,
            Decoder<TDasm, TMnemonic, TInstr> decoderFalse)
        {
            var fields = new[]
            {
                new Bitfield(0, 32, 0xFFFFFFFF)
            };
            return new ConditionalDecoder<TDasm, TMnemonic, TInstr>(fields, predicate, "", decoderTrue, decoderFalse);
        }

        protected static ConditionalDecoder<TDasm, TMnemonic, TInstr> Select<TDasm>(
            (int, int) fieldSpecifier, 
            Predicate<uint> predicate, 
            string tag, 
            Decoder<TDasm, TMnemonic, TInstr> decoderTrue, 
            Decoder<TDasm, TMnemonic, TInstr> decoderFalse)
        {
            var fields = new[]
            {
                new Bitfield(fieldSpecifier.Item1, fieldSpecifier.Item2)
            };
            return new ConditionalDecoder<TDasm, TMnemonic, TInstr>(fields, predicate, tag, decoderTrue, decoderFalse);
        }

        protected static ConditionalDecoder<TDasm, TMnemonic, TInstr> Select<TDasm>(
            (int, int) fieldSpecifier, 
            Predicate<uint> predicate,
            Decoder<TDasm, TMnemonic, TInstr> decoderTrue,
            Decoder<TDasm, TMnemonic, TInstr> decoderFalse)
        {
            var fields = new[]
            {
                new Bitfield(fieldSpecifier.Item1, fieldSpecifier.Item2)
            };
            return new ConditionalDecoder<TDasm, TMnemonic, TInstr>(fields, predicate, "", decoderTrue, decoderFalse);
        }

        protected static ConditionalDecoder<TDasm, TMnemonic, TInstr> Select<TDasm>(
            Bitfield[] fields,
            Predicate<uint> predicate,
            Decoder<TDasm, TMnemonic, TInstr> decoderTrue,
            Decoder<TDasm, TMnemonic, TInstr> decoderFalse)
        {
            return new ConditionalDecoder<TDasm, TMnemonic, TInstr>(fields, predicate, "", decoderTrue, decoderFalse);
        }

        protected static ConditionalDecoder<TDasm, TMnemonic, TInstr> Select<TDasm>(
             Bitfield[] fields,
             Predicate<uint> predicate,
             string tag,
             Decoder<TDasm, TMnemonic, TInstr> decoderTrue,
             Decoder<TDasm, TMnemonic, TInstr> decoderFalse)
        {
            return new ConditionalDecoder<TDasm, TMnemonic, TInstr>(fields, predicate, tag, decoderTrue, decoderFalse);
        }

        /// <summary>
        /// Creates a sparsely populated <see cref="MaskDecoder{TDasm, TMnemonic, TInstr}"/> where 
        /// most of the decoders are <paramref name="defaultDecoder"/>.
        /// </summary>
        protected static MaskDecoder<TDasm, TMnemonic, TInstr> Sparse<TDasm>(
            int bitPosition, int bits, string tag,
            Decoder<TDasm, TMnemonic, TInstr> defaultDecoder,  
            params (uint, Decoder<TDasm, TMnemonic, TInstr>)[] sparseDecoders)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            var decoders = new Decoder<TDasm, TMnemonic, TInstr>[1 << bits];
            foreach (var (code, decoder) in sparseDecoders)
            {
                Debug.Assert(0 <= code && code < decoders.Length);
                Debug.Assert(decoders[code] == null, $"Decoder {code:X} has already a value!");
                decoders[code] = decoder;
            }
            for (int i = 0; i < decoders.Length; ++i)
            {
                if (decoders[i] == null)
                    decoders[i] = defaultDecoder;
            }
            return new MaskDecoder<TDasm, TMnemonic, TInstr>(bitPosition, bits, tag, decoders);
        }

        protected static MaskDecoder<TDasm, TMnemonic, TInstr> Sparse<TDasm>(
            int bitPosition, int bits,
            Decoder<TDasm, TMnemonic, TInstr> defaultDecoder,
            params (uint, Decoder<TDasm, TMnemonic, TInstr>)[] sparseDecoders)
            where TDasm : DisassemblerBase<TInstr, TMnemonic>
        {
            return Sparse(bitPosition, bits, "", defaultDecoder, sparseDecoders);
        }

        /// <summary>
        /// Compact way of creating an array of <see cref="Bitfield"/>.
        /// </summary>
        /// <param name="fields"></param>
        /// <returns></returns>
        protected static Bitfield[] Bf(params (int pos, int len)[] fields)
        {
            return fields.Select(f => new Bitfield(f.pos, f.len)).ToArray();
        }
    }

    /// <summary>
    /// Base class that implementes <see cref="IDisposable"/> and the  type-agnostic <see cref="EmitUnitTest(string, string, string, string, Address, Action{TextWriter})"/>
    /// method.
    /// </summary>
    public class DisassemblerBase : IDisposable
    {
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        ~DisassemblerBase()
        {
            Dispose(false);
        }

        protected virtual void Dispose(bool disposing)
        {
        }
            }
}