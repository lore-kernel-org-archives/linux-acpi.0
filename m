From: Ricardo Ferreira <pasquinade-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: near 100% cpu usage by keventd on a toshiba 1410-604
Date: Sun, 12 Jan 2003 14:27:55 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301121427.55920.pasquinade@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello

When I install your patch ACPI works "great" on my toshiba laptop. the=20
included toshiba module is able to set the lcd brightness, and everything=20
else seems to work fine.

the only problem is near 100% cpu usage by keventd :( (seen in 'ps aux' aft=
er=20
boot)

I unloaded everything I could (init=3D/bin/bash pci=3Dnoacpi at the command=
 line)=20
and the problem remains so I'm sure it's acpi's problem. (btw, If I use the=
=20
standard ACPI from 2.4.20, ACPI works fine (if I uncomment a couple of line=
s=20
which stated my BIOS as being on the blacklist) - except with this version =
of=20
ACPI I don't have access to the toshiba module :(=20

I tried snooping around, but writing a 0xff to /proc/*_debug (don't remembe=
r=20
the exact filename) produced too much output and I was unable to get back t=
o=20
the console (geeezzz) C-M-Sys_Req-b was the only way to restart it :P

I found a particular dmesg line interesting (I'll just post everything rela=
ted=20
to ACPI):

ACPI: Subsystem revision 20030109
PCI: PCI BIOS revision 2.10 entry at 0xfd4df, last bus=3D5
PCI: Using configuration type 1
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
=2E........................................................................=
=2E..........................
Table [DSDT] - 666 Objects with 65 Devices 183 Methods 7 Regions
ACPI Namespace successfully loaded at root c033f4fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successf=
ul
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
schedule_task(): keventd has not started=20
Executing all Device _STA and_INI=20
methods:...............................................................
63 Devices found containing: 63 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package=20
initialization:.............................................
Initialized 4/7 Regions 0/0 Fields 18/18 Buffers 23/23 Packages (666 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0a.00 not present i=
n=20
PCI namespace
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0a.01 not present i=
n=20
PCI namespace
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:0d.00 not present i=
n=20
PCI namespace
pci_bind-0194 [05] acpi_pci_bind         : Device 00:02:07.00 not present i=
n=20
PCI namespace
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
=2D------------------------------------------------------------------------=
=2D-------------------------------------

Notice the line
schedule_task(): keventd has not started

could this be the root of all evil?=20

Something I didn't find in ps aux and I thought odd was that there was no=20
kacpid (or something similar) running. shouldn't there be something?

Tell me how I can post more usefull information.

Thanks in advance
Ricardo Ferreira=20



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
