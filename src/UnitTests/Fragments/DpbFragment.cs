#region License
/* 
 * Copyright (C) 1999-2020 John K�ll�n.
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

using Reko.UnitTests.Mocks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Reko.UnitTests.Fragments
{
    public class DpbFragment : ProcedureBuilder
    {
        protected override void BuildBody()
        {
            var dl = LocalByte("dl");
            Local16("dx");
            var edx = Local32("edx");

            Assign(edx, Word32(0x0AAA00AA));
            Assign(edx, Dpb(edx, Byte(0x55), 8));
            MStore(Word32(0x1000000), edx);

            Assign(edx, Word32(0));
            Assign(edx, Dpb(edx, dl, 0));
            Return(edx);
        }
    }

}
