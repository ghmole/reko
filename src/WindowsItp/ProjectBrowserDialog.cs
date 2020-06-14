using Reko.Arch.X86;
using Reko.Core;
using Reko.Gui;
using Reko.UserInterfaces.WindowsForms.Controls;
using System;
using System.ComponentModel.Design;
using System.Windows.Forms;

namespace Reko.WindowsItp
{
    public partial class ProjectBrowserDialog : Form
    {
        private ProjectBrowserService pbs;

        public ProjectBrowserDialog()
        {
            InitializeComponent();
            pbs = new ProjectBrowserService(null, null, new TreeViewWrapper(treeView));
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            var mem = new MemoryArea(Address.Ptr32(0x12312300),new byte[0x1000]);
            var imageMap = new SegmentMap(
                    mem.BaseAddress,
                    new ImageSegment("code", mem, AccessMode.ReadWriteExecute));
            var sc = new ServiceContainer();
            var arch = new X86ArchitectureFlat32(sc, "x86-protected-32");
            var program = new Core.Program(imageMap, arch, new DefaultPlatform(sc, arch));
            var project = new Project { Programs = { program } };
            pbs.Load(project);
        }
    }
}
