﻿#region License
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

using Reko.Gui.Controls;
using Reko.Gui.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Reko.UserInterfaces.WindowsForms.Forms
{
    public partial class TextEncodingDialog : Form, ITextEncodingDialog
    {
        private TextEncodingInteractor interactor;

        public TextEncodingDialog()
        {
            InitializeComponent();
            EncodingList = new ListboxWrapper(listEncodings);
            this.interactor = new TextEncodingInteractor();
            interactor.Attach(this);
        }

        public IListBox EncodingList { get; private set; }

        public Encoding GetSelectedTextEncoding()
        {
            return interactor.GetSelectedTextEncoding();
        }
    }
}
