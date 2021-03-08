using Reko.Core;
using Reko.Gui;
using System;
using System.Collections.Generic;
using System.Windows.Forms;
using Reko.Gui.Controls;

namespace Reko.WindowsItp
{
    public class FakeUiPreferencesService : IUiPreferencesService
    {
        public event EventHandler UiPreferencesChanged;

        public FakeUiPreferencesService()
        {
            this.Styles = new Dictionary<string, Gui.UiStyle>();
        }

        public IDictionary<string, Gui.UiStyle> Styles { get; private set; }

        public System.Drawing.Font DisassemblerFont
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                UiPreferencesChanged.Fire(this);
                throw new NotImplementedException();
            }
        }

        public System.Drawing.Font SourceCodeFont
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public System.Drawing.Color SourceCodeForegroundColor
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public System.Drawing.Color SourceCodeBackgroundColor
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public System.Drawing.Size WindowSize
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public Reko.Gui.Forms.FormWindowState WindowState
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public void Load()
        {
            throw new NotImplementedException();
        }

        public void Save()
        {
            throw new NotImplementedException();
        }

        public void ResetStyle(string sName)
        {

        }

        public void UpdateControlStyle(string list, object ctrl)
        {
            throw new NotImplementedException();
        }

        public void UpdateControlStyle(string styleName, IControl ctrl)
        {
            throw new NotImplementedException();
        }
    }

}