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

using Moq;
using NUnit.Framework;
using Reko.Core;
using Reko.Core.Serialization;
using Reko.Core.Services;
using Reko.Core.Types;
using Reko.UnitTests.Mocks;
using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Reko.UnitTests
{
    [TestFixture]
    public class DecompiledFileServiceTests
    {
        private Program program;
        private Mock<IFileSystemService> fsSvc;
        private DecompiledFileService dfSvc;
        private Procedure proc1;

        [SetUp]
        public void Setup()
        {
            var arch = new Mock<IProcessorArchitecture>();
            arch.Setup(a => a.Name).Returns("FakeArch");
            arch.Setup(a => a.PointerType).Returns(PrimitiveType.Ptr32);
            this.program = new Program(
                new SegmentMap(Address.Ptr32(0x00100000)),
                arch.Object,
                new DefaultPlatform(new ServiceContainer(), arch.Object));
            program.Filename = Path.Combine("bar", "foo.exe");
            program.Name = "foo.exe";
            program.SourceDirectory = "bar";

            this.fsSvc = new Mock<IFileSystemService>();

            this.dfSvc = new DecompiledFileService(fsSvc.Object, new FakeDecompilerEventListener());

            this.proc1 = Procedure.Create(arch.Object, Address.Ptr32(0x00123400), new Frame(PrimitiveType.Ptr32));

        }

        private void Expect_FileCreated(params string [] expectedPathComponents)
        {
            var expectedPath = Path.Combine(expectedPathComponents);
            fsSvc.Setup(f => f.CreateFileStream(
                expectedPath,
                It.IsAny<FileMode>(),
                It.IsAny<FileAccess>()))
                .Returns(new MemoryStream())
                .Verifiable();
        }

        [Test]
        public void DfSvc_Write()
        {
            program.Procedures.Add(proc1.EntryAddress, proc1);

            Expect_FileCreated("bar", "foo.c");

            dfSvc.WriteDecompiledCode(program, (n, p, w) => {});

            fsSvc.VerifyAll();
        }

        [Test]
        public void DfSvc_Write_CustomFile()
        {
            var customSourceFile = Path.Combine("src", "proc1.c");
            program.Procedures.Add(proc1.EntryAddress, proc1);
            program.User.ProcedureSourceFiles.Add(proc1.EntryAddress, customSourceFile);

            Expect_FileCreated("bar", "src", "proc1.c");

            dfSvc.WriteDecompiledCode(program, (n, p, w) => { });

            fsSvc.VerifyAll();
        }
    }
}
