﻿#region License
/* 
 * Copyright (C) 1999-2015 John Källén.
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
using Reko.Core.Configuration;
using Reko.Core.Services;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Reko.ImageLoaders.MzExe
{
    public class NeImageLoader : ImageLoader
    {
        // Relocation address types
        const byte NE_RADDR_LOWBYTE = 0;
        const byte NE_RADDR_SELECTOR = 2;
        const byte NE_RADDR_POINTER32 = 3;
        const byte NE_RADDR_OFFSET16 = 5;
        const byte NE_RADDR_POINTER48 = 11;
        const byte NE_RADDR_OFFSET32 = 13;

        // Relocation types
        const byte NE_RELTYPE_INTERNAL = 0;
        const byte NE_RELTYPE_ORDINAL = 1;
        const byte NE_RELTYPE_NAME = 2;
        const byte NE_RELTYPE_OSFIXUP = 3;
        const byte NE_RELFLAG_ADDITIVE = 4;

        private LoadedImage image;
        private ImageMap imageMap;
        private List<string> moduleNames;
        private NeSegment[] segments;
        private ushort cbFileAlignmentShift;
        private ushort cSeg;
        private IDiagnosticsService diags;
        private uint lfaNew;
        private ushort offImportedNamesTable;
        private Address addrImportStubs;
        private Dictionary<uint, Tuple<Address, ImportReference>> importStubs;

        public NeImageLoader(IServiceProvider services, string filename, byte[] rawBytes, uint e_lfanew)
            : base(services, filename, rawBytes)
        {
            ImageReader rdr = new LeImageReader(RawImage, e_lfanew);
            diags = Services.RequireService<IDiagnosticsService>();
            this.lfaNew = e_lfanew;
            this.importStubs = new Dictionary<uint, Tuple<Address, ImportReference>>();
            if (!LoadNeHeader(rdr))
                throw new BadImageFormatException("Unable to read NE header.");
        }

        public override Address PreferredBaseAddress
        {
            get { return Address.ProtectedSegPtr(0xF, 0); }
            set
            {
                throw new NotImplementedException();
            }
        }

        private bool LoadNeHeader(ImageReader rdr)
        {
            ushort magic;
            if (!rdr.TryReadLeUInt16(out magic) || magic != 0x454E)
                throw new BadImageFormatException("Not a valid NE header.");
            ushort linker;
            if (!rdr.TryReadLeUInt16(out linker))
                return false;
            ushort offEntryTable;
            if (!rdr.TryReadLeUInt16(out offEntryTable))
                return false;
            ushort cbEntryTable;
            if (!rdr.TryReadLeUInt16(out cbEntryTable))
                return false;
            uint crc;
            if (!rdr.TryReadLeUInt32(out crc))
                return false;
            byte bProgramFlags;
            if (!rdr.TryReadByte(out bProgramFlags))
                return false;
            byte bAppFlags;
            if (!rdr.TryReadByte(out bAppFlags))
                return false;
            ushort iSegAutoData;
            if (!rdr.TryReadUInt16(out iSegAutoData))
                return false;
            ushort cbHeapSize;
            if (!rdr.TryReadUInt16(out cbHeapSize))
                return false;
            ushort cbStackSize;
            if (!rdr.TryReadUInt16(out cbStackSize))
                return false;
            ushort cs, ip;
            if (!rdr.TryReadUInt16(out ip) || !rdr.TryReadUInt16(out cs))
                return false;
            ushort ss, sp;
            if (!rdr.TryReadUInt16(out sp) || !rdr.TryReadUInt16(out ss))
                return false;
            if (!rdr.TryReadUInt16(out cSeg))
                return false;
            ushort cModules;
            if (!rdr.TryReadUInt16(out cModules))
                return false;
            ushort cbNonResidentNames;
            if (!rdr.TryReadUInt16(out cbNonResidentNames))
                return false;
            ushort offSegTable;
            if (!rdr.TryReadUInt16(out offSegTable))
                return false;
            ushort offRsrcTable;
            if (!rdr.TryReadUInt16(out offRsrcTable))
                return false;
            ushort offResidentNameTable;
            if (!rdr.TryReadUInt16(out offResidentNameTable))
                return false;
            ushort offModuleReferenceTable;
            if (!rdr.TryReadUInt16(out offModuleReferenceTable))
                return false;
            if (!rdr.TryReadUInt16(out offImportedNamesTable))
                return false;
            uint offNonResidentNameTable;
            if (!rdr.TryReadUInt32(out offNonResidentNameTable))
                return false;
            ushort cMoveableEntryPoints;
            if (!rdr.TryReadUInt16(out cMoveableEntryPoints))
                return false;
            if (!rdr.TryReadUInt16(out cbFileAlignmentShift))
                return false;
            ushort cResourceTableEntries;
            if (!rdr.TryReadUInt16(out cResourceTableEntries))
                return false;
            byte bTargetOs;
            if (!rdr.TryReadByte(out bTargetOs))
                return false;
            byte bOsExeFlags;
            if (!rdr.TryReadByte(out bOsExeFlags))
                return false;
            ushort offGanglands;
            if (!rdr.TryReadUInt16(out offGanglands))
                return false;
            ushort cbGanglands;
            if (!rdr.TryReadUInt16(out cbGanglands))
                return false;
            ushort cbMinCodeSwapArea;
            if (!rdr.TryReadUInt16(out cbMinCodeSwapArea))
                return false;
            ushort wWindowsVersion;
            if (!rdr.TryReadUInt16(out wWindowsVersion))
                return false;

            LoadModuleTable(this.lfaNew + offModuleReferenceTable, cModules);
            LoadSegments(this.lfaNew + offSegTable);

            return true;
        }

        public override Program Load(Address addrLoad)
        {
            var cfgSvc = Services.RequireService<IConfigurationService>();
            var arch = cfgSvc.GetArchitecture("x86-protected-16");
            var platform = cfgSvc.GetEnvironment("win16").Load(Services, arch);

            var program = new Program(
                this.image,
                this.imageMap,
                arch,
                platform);
            foreach (var impRef in this.importStubs.Values)
            {
                program.ImportReferences.Add(impRef.Item1, impRef.Item2);
            }
            return program;
        }

        public override RelocationResults Relocate(Program program, Address addrLoad)
        {
            return new RelocationResults(
                new List<EntryPoint>(),
                new RelocationDictionary(),
                new List<Address>());
        }

        public class NeSegment
        {
            public ushort DataOffset;
            public ushort DataLength;
            public ushort Flags;
            public ushort Alloc;

            public uint LinearAddress;
            public Address Address;
        }

        void LoadModuleTable(uint offset, int cModules)
        {
            var rdr = new LeImageReader(RawImage, offset);
            this.moduleNames = new List<string>();
            for (int i = 0; i < cModules; ++i)
            {
                uint nameOffset = rdr.ReadLeUInt16();
                if (nameOffset == 0)
                    break;
                nameOffset += lfaNew + this.offImportedNamesTable;
                var rdrName = new LeImageReader(RawImage, nameOffset);
                byte length = rdrName.ReadByte();
                byte[] abModuleName = rdrName.ReadBytes(length);
                var moduleName = Encoding.ASCII.GetString(abModuleName);
                moduleNames.Add(moduleName);
            }
        }

        void LoadSegments(uint offset)
        {
            this.segments = ReadSegmentTable(offset, cSeg);
            var segFirst = segments[0];
            var segLast = segments[segments.Length - 1];
            this.image = new LoadedImage(
                PreferredBaseAddress,
                new byte[segLast.LinearAddress + segLast.DataLength]);
            this.imageMap = image.CreateImageMap();
            foreach (var segment in segments)
            {
                LoadSegment(segment, image, imageMap);
            }
        }

        private NeSegment[] ReadSegmentTable(uint offset, int cSeg)
        {
            var segs = new List<NeSegment>(cSeg);
            var rdr = new LeImageReader(RawImage, offset);
            uint linAddress = 0x2000;
            for (int iSeg = 0; iSeg < cSeg; ++iSeg)
            {
                var seg = new NeSegment
                {
                    DataOffset = rdr.ReadLeUInt16(),
                    DataLength = rdr.ReadLeUInt16(),
                    Flags = rdr.ReadLeUInt16(),
                    Alloc = rdr.ReadLeUInt16()
                };
                uint cbSegmentPage = Math.Max(seg.Alloc, seg.DataLength);
                // Align to 4kb boundary.
                cbSegmentPage = (cbSegmentPage + 0xFFFu) & ~0xFFFu;
                seg.LinearAddress = linAddress;
                seg.Address = Address.ProtectedSegPtr((ushort)((linAddress >> 9) | 7), 0);
                segs.Add(seg);
                linAddress += cbSegmentPage;
            }

            // Generate pseudo-segment for imports
            addrImportStubs = Address.ProtectedSegPtr((ushort)((linAddress >> 9) | 7), 0);

            return segs.ToArray();
        }

        bool LoadSegment(NeSegment seg, LoadedImage loadedImage, ImageMap imageMap)
        {
            Array.Copy(
                RawImage,
                (uint)seg.DataOffset << this.cbFileAlignmentShift,
                loadedImage.Bytes,
                seg.LinearAddress - (int)loadedImage.BaseAddress.ToLinear(),
                seg.DataLength);
            var x = seg.Address.ToLinear();

            AccessMode access =
                (seg.Flags & 1) != 0
                    ? AccessMode.ReadWrite
                    : AccessMode.ReadExecute;
            imageMap.AddSegment(
                seg.Address,
                seg.Address.Selector.ToString("X4"),
                access,
                seg.DataLength);

            var rdr = new LeImageReader(
                RawImage,
                seg.DataLength + ((uint)seg.DataOffset << this.cbFileAlignmentShift));
            int count = rdr.ReadLeInt16();
            return ApplyRelocations(rdr, count, seg);
        }


        public class NeRelocationEntry
        {
            public byte address_type;    // Relocation address type
            public byte relocation_type; // Relocation type
            public ushort offset;          // Offset in segment to fixup
            public ushort target1;         // Target specification
            public ushort target2;         // Target specification/
        }

        // Apply relocations to a segment.
        bool ApplyRelocations(ImageReader rdr, int cRelocations, NeSegment seg)
        {
            string module = "";
            int ordinal;
            Address address = null;
            NeRelocationEntry rep = null;
            for (int i = 0; i < cRelocations; i++)
            {
                rep = new NeRelocationEntry
                {
                    address_type = rdr.ReadByte(),
                    relocation_type = rdr.ReadByte(),
                    offset = rdr.ReadLeUInt16(),
                    target1 = rdr.ReadLeUInt16(),
                    target2 = rdr.ReadLeUInt16(),
                };

                // Get the target address corresponding to this entry.

                // If additive, there is no target chain list. Instead, add source
                //  and target.
                bool additive = (rep.relocation_type & NE_RELFLAG_ADDITIVE) != 0;
                Tuple<Address, ImportReference> impRef;
                uint lp;
                switch (rep.relocation_type & 3)
                {
                case NE_RELTYPE_ORDINAL:
                    module = moduleNames[rep.target1 - 1];
                    // Synthesize an import 
                    lp = ((uint)rep.target1 << 16) | rep.target2;
                    if (importStubs.TryGetValue(lp, out impRef))
                    {
                        address = impRef.Item1;
                    }
                    else
                    {
                        address = addrImportStubs;
                        importStubs.Add(lp, new Tuple<Address, ImportReference>(
                            address,
                            new OrdinalImportReference(address, module, rep.target2)));
                        addrImportStubs += 8;
                    }
                    break;

                case NE_RELTYPE_NAME:
                    module = moduleNames[rep.target1 - 1];
                    uint offName = lfaNew + this.offImportedNamesTable + rep.target2;
                    var nameRdr = new LeImageReader(RawImage, offName);
                    byte fnNameLength = nameRdr.ReadByte();
                    var abFnName = nameRdr.ReadBytes(fnNameLength);
                    lp = ((uint)rep.target1 << 16) | rep.target2;
                    if (importStubs.TryGetValue(lp, out impRef))
                    {
                        address = impRef.Item1;
                    }
                    else
                    {
                        address = addrImportStubs;
                        string fnName = Encoding.ASCII.GetString(abFnName);
                        importStubs.Add(lp, new Tuple<Address, ImportReference>(
                            address,
                            new NamedImportReference(address, module, fnName)));
                    }
                    break;
                case NE_RELTYPE_INTERNAL:
                    if ((rep.target1 & 0xff) == 0xff)
                    {
                        throw new NotImplementedException();
                    }
                    else
                    {
                        address = segments[rep.target1 - 1].Address + rep.target2;
                    }
                    Debug.Print("{0}: {1:X4}:{2:X4} {3}",
                          i + 1, address.Selector, address.Selector,
                          "");
                    break;
                case NE_RELTYPE_OSFIXUP:
                    /* Relocation type 7:
                     *
                     *    These appear to be used as fixups for the Windows
                     * floating point emulator.  Let's just ignore them and
                     * try to use the hardware floating point.  Linux should
                     * successfully emulate the coprocessor if it doesn't
                     * exist.
                     */
                    /*
                   TRACE("%d: TYPE %d, OFFSET %04x, TARGET %04x %04x %s\n",
                         i + 1, rep->relocation_type, rep->offset,
                         rep->target1, rep->target2,
                         NE_GetRelocAddrName( rep->address_type, additive ) );
                   */
                    continue;
                }
                ushort offset = rep.offset;

                // Apparently, high bit of address_type is sometimes set;
                // we ignore it for now.
                if (rep.address_type > NE_RADDR_OFFSET32)
                {
                    diags.Error(
                        string.Format(
                            "Module {0}: unknown relocation address type {1:X2}. Please report",
                            module, rep.address_type));
                    return false;
                }

                if (additive)
                {
                    var sp = seg.Address + offset;
                    Debug.Print("    {0:X4}:{0:X4}", offset, offset);
                    byte b;
                    ushort w;
                    switch (rep.address_type & 0x7f)
                    {
                    case NE_RADDR_LOWBYTE:
                        b = image.ReadByte(sp);
                        image.WriteByte(sp, (byte)(b + address.Offset));
                        break;
                    case NE_RADDR_OFFSET16:
                        w = image.ReadLeUInt16(sp);
                        image.WriteLeUInt16(sp, (ushort)(w + address.Offset));
                        break;
                    case NE_RADDR_POINTER32:
                        w = image.ReadLeUInt16(sp);
                        image.WriteLeUInt16(sp, (ushort)(w + address.Offset));
                        image.WriteLeUInt16(sp + 2, address.Selector);
                        break;
                    case NE_RADDR_SELECTOR:
                        // Borland creates additive records with offset zero. Strange, but OK.
                        w = image.ReadLeUInt16(sp);
                        if (w != 0)
                            diags.Error(string.Format("Additive selector to {0:X4}. Please report.", w));
                        else
                            image.WriteLeUInt16(sp, address.Selector);
                        break;
                    default:
                        goto unknown;
                    }
                }
                else
                {
                    // Non-additive fixup.
                    do
                    {
                        var sp = seg.Address + offset;
                        ushort next_offset = image.ReadLeUInt16(sp);
                        Debug.Print("    {0:X4}:{0:X4}", offset, next_offset);
                        switch (rep.address_type & 0x7f)
                        {
                        case NE_RADDR_LOWBYTE:
                            image.WriteByte(sp, (byte)address.Offset);
                            break;
                        case NE_RADDR_OFFSET16:
                            image.WriteLeUInt16(sp, (ushort)address.Offset);
                            break;
                        case NE_RADDR_POINTER32:
                            image.WriteLeUInt16(sp, (ushort)address.Offset);
                            image.WriteLeUInt16(sp + 2, address.Selector);
                            break;
                        case NE_RADDR_SELECTOR:
                            image.WriteLeUInt16(sp, address.Selector);
                            break;
                        default:
                            goto unknown;
                        }
                        if (next_offset == offset) break;  // avoid infinite loop 
                        if (next_offset >= seg.Alloc)
                            break;
                        offset = next_offset;
                    } while (offset != 0xffff);
                }
            }
            return true;

            unknown:
            var svc = Services.RequireService<IDiagnosticsService>();
            svc.Warn(string.Format("{0}: unknown ADDR TYPE {1},  " +
                "TYPE {2},  OFFSET {3:X4},  TARGET {4:X4} {5:X4}",
                seg.Address.Selector, rep.address_type, rep.relocation_type,
                rep.offset, rep.target1, rep.target2));
            return false;
        }

    }
}
