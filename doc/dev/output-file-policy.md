## Output file policy

Large binaries generate large outputs. When those binaries were developed, they consisted of multiple files. It would be useful to divide the massive decompilation output of a large binary into small files. This makes navigation around the file simpler.

If we're lucky the program symbols or debugging information, we can use the information to rebuild the files. If we're unlucky there is no such information, so we have to use some other arbitrary criteria. The intent of this is to provide users with output files of a manageable size without overwhelming them, with the option of reorganizing them manually at will.

There is a one-to-many mapping between `OutputFile`s and each `Procedure`. Users can specify `OutputFiles` and then assign `Procedure`s to output files. Any `Procedure`s that aren't explicitly assigned to an `OutputFile` are subject to an `OutputFilePolicy`, which uses simple heuristics to 
An `output file policy` is an object that can be asked about what file a `Procedure` belongs to. 

Currently, explicit placements for data objects hasn't been implemented, but it would follow along the same lines. Each data object can optionally be assigned to an `OutputFile`

A high-level description of the partitioning criteria follows. 'Item' means either a procedure or a data item. Given an executable `foo.exe` or plain `foo` (for ELF files):

1. If there is user metadata for file placement, describing which file the item belongs in, obey blindly.
1. If the procedure was mangled in such a way that a C++ class name can be recovered, use the class name as basis for the file name in which the procedure should be located. For instance, the MS mangled `?Method@Class@@YAHK@Z` should create a procedure named `Method` in a file named `foo.Class.cpp`
1. For X86 16-bit binaries, because the segments are small (< 64 k), it is sufficient to generate a separate file for each segment. Given segments at address `0800:0000` and `1BAF:0000`, the code/data in those segments should be placed in files `foo.0800.c` and `foo.1BAF.c` respectively.
1. If the file format consists of sections, such as `.text` or `.data`, then the names of those segments should be used when partitioning the data. Thus, a typical ELF file might generate the files `foo.text.c`, `foo.data.c`.
1. If no section data is available (e.g. stripped ELF files), then place the decompilation products in separate files based on the segment offsets from the base. For instance, and ELF file with a load address of `00100000`, an executable segment at address `00200000` and a data segment at address `00300000` would generate the files `foo.100000.c`, where procedures would be stored, and `foo.200000.c` where the data objects would be stored.
1. If a segment exceeds an arbitrary size, say 64 kiB, then it is further subdivided into chunks such that none is larger than 64 kiB, to make files more manageable. For instance, if an ELF file has a `.text` segment that is 180 kiB, it would result in the files `foo.text.0.c`, `foo.text.1.c`, and `foo.text.2.c`.

### Advanced features
The limit of segments to 64 kiB is arbitrary. This could be adjustable by the user in a GUI property sheet.

## GUI
The user interface needs a view to indicate how files are partitioned. Let's call it the *Output file view*. It needs to be a treeview, because users might want to group files in folders etc. 

The user interface would need to query the `OutputFilePolicy` for such procedures that have not been given a placement, to generate the tree view. Items in the tree view whose placements were declared by an explicit user action need to be indicated by a different glyph from items whose placements are 'automatic'. Users need to be able to: 
1. Select one or more items and specify their placements. **Idea**: select procedures in the procedure list, select "Copy" and then pasting into the "Output file" view. If a procedure already had a placement, it will receive a new one.
2. Remove the placement of a procedure; property page of the procedure?

## Usage

When a binary is loaded, an "empty" `OutputFilePolicy` with no user customizations is loaded. When a Reko project is loaded, the empty `OutputFilePolicy` is augmented with user-provided placements from the `User` property of the `Program` database.

When assembly language is generated, the `OutputFilePolicy` is consulted to obtain a partition of all known `Procedure`s and data objects into separate `OutputFile`s. For each OutputFile, generate an *.asm file, and then render the `Procedure`s in some order (for simplicity assume address order.)

### Methods

The `OutputFilePolicy` has the following methods:

```C#
public (string filename, Procedure proc) GetProcedurePlacement(Procedure proc, Program program)
```
Given a single procedure, provides the placement for it.

```C#
public IEnumerable<(string filename, IEnumerable<Procedure> procs)> GetProcedurePlacements(
    IEnumerable<Procedure> procs, 
    Program program, 
    string fileExtension)
```
Given a sequence of `Procedure`s and a `Program`, returns a grouping of `Procedure`s within each file. The `fileExtension` is appended to each output file.


