using Reko.Core;
using Reko.UserInterfaces.WindowsForms.Controls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CoreProgram = Reko.Core.Program;

namespace Reko.WindowsItp
{
    public partial class DisassemblyControlForm : Form
    {
        public DisassemblyControlForm()
        {
            InitializeComponent();
        }

        private void DisassemblyControlForm_Load(object sender, EventArgs e)
        {
            var random = new Random(0x4711);
            var mem =   new MemoryArea(Address.Ptr32(0x00100000),
                Enumerable.Range(0, 10000)
                .Select(i => (byte)random.Next(256)).ToArray());
            var seg = new ImageSegment(".text", mem, AccessMode.ReadExecute);
            var segmentMap = new SegmentMap(mem.BaseAddress, seg);
            disassemblyControl1.Model = new DisassemblyTextModel(
                new CoreProgram
                {
                    //new Decompiler.Arch.X86.X86ArchitectureFlat32("x86-protected-32");
                    Architecture = new Reko.Arch.PowerPC.PowerPcBe32Architecture(new ServiceContainer(), "ppc-be-32"),
                    SegmentMap = segmentMap
                },
                seg);
            disassemblyControl1.StartAddress = mem.BaseAddress;
        }
    }
}
