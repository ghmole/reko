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

 using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Reko.Core
{
    /// <summary>
    /// Oracular information provided by user.
    /// </summary>
    public class UserData
    {
        public UserData()
        {
            this.Procedures = new SortedList<Address, Serialization.Procedure_v1>();
            this.Calls = new SortedList<Address, Serialization.SerializedCall_v1>();
            this.Globals = new SortedList<Address, Serialization.GlobalDataItem_v2>();
            this.Heuristics = new SortedSet<string>();
            this.Annotations = new List<Annotation>();
        }

        // 'Oracular' information provided by the user.
        public string Processor { get; set; }
        public string Environment { get; set; }
        public Address LoadAddress { get; set; }
        public SortedList<Address, Serialization.Procedure_v1> Procedures { get; set; }
        public SortedList<Address, Serialization.SerializedCall_v1> Calls { get; set; }
        public SortedList<Address, Serialization.GlobalDataItem_v2> Globals { get; set; }
        public List<Annotation> Annotations { get; set; }

        /// <summary>
        /// A script to run after the image is loaded.
        /// </summary>
        public Serialization.Script_v2 OnLoadedScript { get; set; }

        /// <summary>
        /// Scanning heuristics to try.
        /// </summary>
        public SortedSet<string> Heuristics { get; set; }
    }

    public class Annotation
    {
        public Address Address;
        public string Text;
    }
}