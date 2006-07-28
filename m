From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI Errors for Dimension 8250
Date: Fri, 28 Jul 2006 09:44:27 +0200
Message-ID: <1154072667.4302.247.camel@queen.suse.de>
References: <4be0d0b30607251754t1bd64bbs65b344023b34997f@mail.gmail.com>
	 <1153980560.4302.138.camel@queen.suse.de>
	 <4be0d0b30607270650i67bbcf79vef46b4a957331e9f@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:17885 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932580AbWG1Hla (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 03:41:30 -0400
In-Reply-To: <4be0d0b30607270650i67bbcf79vef46b4a957331e9f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Altobelli <acocaracha@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2006-07-27 at 09:50 -0400, John Altobelli wrote:
> Thanks for the rely,
> 
> Here is my acpixtract -l dsdt.asl output:
> 
> Signature Length  OemId     OemTableId   OemRevision CompilerId CompilerRevision
> 
>     DSDT    8794  "DELL  "  "dt_ex   "    00001000    "MSFT"     0100000D
>     FACS      64
>     FACP     116  "DELL  "  "8250    "    00000008    "ASL "     00000061
>     SSDT     167  "DELL  "  "st_ex   "    00001000    "MSFT"     0100000D
>     APIC     108  "DELL  "  "8250    "    00000008    "ASL "     00000061
>     BOOT      40  "DELL  "  "8250    "    00000008    "ASL "     00000061
>     RSDT      52  "DELL  "  "8250    "    00000008    "ASL "     00000061
>     RSDP          "DELL  "
> 
> Found 8 ACPI tables [20060324]
> 
> I have also attached my dsdt.asl file, which is the output of the
> acpidump.  The acpixtract was able to create all the dat files, but I
> was a little confused when it came to copying the table to the dsdt
> file.  I simply copied the above table to the bottom of the dsdt.asl
> file and tried to compile, but it still gave me an error:
> 
I wanted to add this to the end, but I better start with this:

!!! IMPORTANT !!!
Do not override your DSDT if it is not really necessary.
If you really should identify a bug in kernel or BIOS that you can
workaround with overriding your DSDT don't be comfortable with that,
please open a bug at bugzilla.kernel.org and assign it to the ACPI
component.
Be aware that the ACPI code is not static, but parts are generated
specialized for parts of your hardware. If you e.g. exchange memory,
update your BIOS or whatever YOU HAVE TO GET RID OF YOUR PATCHED DSDT
BEFORE.
!!! IMPORTANT !!!


First do just an:
acpixtract dsdt.asl    (better call it acpidump as it includes the dsdt
and other tables)

Your BIOS has one DSDT and one SSDT (the *.dat files, they contain the
plain AML byte code as provided by your BIOS for the OS).

then disassemble them:
iasl -d DSDT.dat
iasl -d SSDT.dat

You now have the disassembled readable ASL tables (DSDT.dsl and
SSDT.dsl).
If there are cross references (objects declared in DSDT and used in
SSDT) there is a param -e to use another table to create External
statements correctly. This is important if you want to recompile the
disassembled table correctly later. However, there are no cross
references in your tables, ahh yes one but it gets resolved correctly
with my acpica version.

You can now read and modify the ASL (*.dsl) files and recompile them
later with:

1) For inclusion into initrd
iasl -sa DSDT.dsl
iasl -sa SSDT.dsl
The relevant output file is called DSDT.aml/SSDT.aml.
A separate kernel patch is needed, most (all?) distributions have
already compiled it into their kernels, use google to find how you can
add the patched DSDT into initrd for your distribution.
Advantage: No need to recompile your kernel.

2) Compile it to statically compile the DSDT into your kernel
iasl -tc DSDT.dsl
iasl -tc SSDT.dsl
The relevant output files are called DSDT.hex/SSDT.hex.
You should already be familiar with kernel compiling if you start to try
this. In the section PowerManagement->ACPI (or similar) in the kernel
config section (make config, make menuconfig) there is an option where
you can point to the *.hex file to let it compile into the kernel.

There was a patch to also override SSDTs by compiling it into the
kernel, but this is not mainline AFAIK... Hmm, I think I have to ask
separately for it most people won't read all this...

Forget about including the SSDT into the DSDT that gets to far now, the
SSDT might still not be recognised if you C&P it into the DSDT and your
tables just compile fine with acpica-unix-20060608 (and probably also
later) iasl compiler.

This is what I did:

trenn@queen:~/dsdt/dell_dimension_8250> mv /tmp/dsdt.asl acpidump
trenn@queen:~/dsdt/dell_dimension_8250> acpixtract acpidump
Acpi table [DSDT] -   8794 bytes written to DSDT.dat
Acpi table [SSDT] -    167 bytes written to SSDT.dat
trenn@queen:~/dsdt/dell_dimension_8250> ls
acpidump  DSDT.dat  SSDT.dat
trenn@queen:~/dsdt/dell_dimension_8250> iasl -d DSDT.dat

Intel ACPI Component Architecture
AML Disassembler version 20060608 [Jun 22 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

Loading Acpi table from file DSDT.dat
Acpi table [DSDT] successfully installed and loaded
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
...........................................................................................................................................................................................................................
Parsing completed
Disassembly completed, written to "DSDT.dsl"
trenn@queen:~/dsdt/dell_dimension_8250> iasl -d SSDT.dat

Intel ACPI Component Architecture
AML Disassembler version 20060608 [Jun 22 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

Loading Acpi table from file SSDT.dat
Acpi table [SSDT] successfully installed and loaded
Pass 1 parse of [SSDT]
Pass 2 parse of [SSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
.......
Parsing completed
Disassembly completed, written to "SSDT.dsl"
trenn@queen:~/dsdt/dell_dimension_8250> iasl -sa DSDT.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 22 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

DSDT.dsl   666:                 Method (_S5D, 0, NotSerialized)
Warning  1097 -      Unknown reserved name ^  (_S5D)

ASL Input:  DSDT.dsl - 2909 lines, 98366 bytes, 902 keywords
AML Output: DSDT.aml - 8560 bytes 360 named objects 542 executable
opcodes

Compilation complete. 0 Errors, 1 Warnings, 0 Remarks, 227 Optimizations
trenn@queen:~/dsdt/dell_dimension_8250> iasl -sa SSDT.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 22 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

ASL Input:  SSDT.dsl - 77 lines, 1447 bytes, 10 keywords
AML Output: SSDT.aml - 153 bytes 9 named objects 1 executable opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 14 Optimizations
trenn@queen:~/dsdt/dell_dimension_8250> less acpidump
trenn@queen:~/dsdt/dell_dimension_8250> iasl -tc SSDT.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 22 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

ASL Input:  SSDT.dsl - 77 lines, 1447 bytes, 10 keywords
AML Output: SSDT.aml - 153 bytes 9 named objects 1 executable opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 14 Optimizations
trenn@queen:~/dsdt/dell_dimension_8250> l
total 484
drwxr-xr-x  2 trenn suse    288 2006-07-28 09:12 ./
drwxr-xr-x 69 trenn suse   3864 2006-07-28 08:57 ../
-rw-r--r--  1 trenn suse  43663 2006-07-28 08:58 acpidump
-rw-r--r--  1 trenn suse   8560 2006-07-28 08:58 DSDT.aml
-rw-r--r--  1 trenn suse 294082 2006-07-28 08:58 DSDT.asm
-rw-r--r--  1 trenn suse   8794 2006-07-28 08:57 DSDT.dat
-rw-r--r--  1 trenn suse  98366 2006-07-28 08:58 DSDT.dsl
-rw-r--r--  1 trenn suse    153 2006-07-28 09:12 SSDT.aml
-rw-r--r--  1 trenn suse   5186 2006-07-28 08:58 SSDT.asm
-rw-r--r--  1 trenn suse    167 2006-07-28 08:57 SSDT.dat
-rw-r--r--  1 trenn suse   1447 2006-07-28 08:58 SSDT.dsl
-rw-r--r--  1 trenn suse   1755 2006-07-28 09:12 SSDT.hex


YES! Even the DMA name clash is fixed...

I do not expect a bug (I may be wrong) in your DSDT/SSDT.
If you could explain what your problems are we may come to some kernel
bug unrelated to the interpreter (does "dmesg |grep -i acpi" show
errors?). Also try the latest kernels...
If you just want to play with this stuff, go ahead, but be careful if
you override your ACPI tables, better only do this temporarily.

    Thomas

