From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: BUG: iasl segfaults
Date: Sun, 20 Jul 2003 11:26:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2znj9giln.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On a Redhat 8.0 host (glibc 2.3.2):

[11:24] tnuctip:/tmp/toshiba/acpi>iasl -d dsdt.toshiba 

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

Loading Acpi table from file dsdt.toshiba
Acpi table [DSDT] successfully installed and loaded
Could not open output file
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
............................................................................................................................................................................................................................................
Parsing completed
Segmentation fault
[11:24] tnuctip:/tmp/toshiba/acpi>



[11:24] tnuctip:/tmp/toshiba/acpi>gdb --args iasl -d dsdt.toshiba 
GNU gdb Red Hat Linux (5.2.1-4)
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux"...
(gdb) r
Starting program: /usr/local/bin/iasl -d dsdt.toshiba

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030522 [May 23 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

Loading Acpi table from file dsdt.toshiba
Acpi table [DSDT] successfully installed and loaded
Could not open output file
Pass 1 parse of [DSDT]
Pass 2 parse of [DSDT]
Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
............................................................................................................................................................................................................................................
Parsing completed

Program received signal SIGSEGV, Segmentation fault.
0x42047cb7 in vfprintf () from /lib/i686/libc.so.6
(gdb) bt
#0  0x42047cb7 in vfprintf () from /lib/i686/libc.so.6
#1  0x42134ee0 in _IO_2_1_stderr_ () from /lib/i686/libc.so.6
#2  0x0807152a in AcpiOsVprintf ()
#3  0x080714de in AcpiOsPrintf ()
#4  0x0806da58 in AdCreateTableHeader ()
#5  0x0806db3c in AdDisplayTables ()
#6  0x0806d910 in AdAmlDisassemble ()
#7  0x0805294e in main ()
#8  0x420158f7 in __libc_start_main () from /lib/i686/libc.so.6
(gdb) 

--J.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
