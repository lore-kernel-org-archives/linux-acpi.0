From: Carsten Rietzschel <cr7-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: S3 problem: No PCI-interrupts after resume
Date: Sat, 19 Jun 2004 23:47:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406192347.27053.cr7@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vRL1AELOjI4pmXW"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_vRL1AELOjI4pmXW
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm trying to get S3 Suspend to RAM running on my KT333CF-Board.
But after resuming: USB, soundcard, firewire + eth don't work (read as: no 
PCI-devices except IDE) . In proc/interrupts I saw no interrupts for these 
devices were incremented after resume. 
Kernel version is 2.6.7 with acpi update from len 
(acpi-20040326-2.6.7.diff.gz), but same for older versions of 2.6.x.

I've read the howto (http://forums.gentoo.org/viewtopic.php?t=122145), and 
tried to fix my DTSD. I extracted the DSDT and iasl gave me these warnings 
and my fixes:

dsdt.dsl-org   294:     Method (\_WAK, 1, NotSerialized)
Warning  2026 -                     ^ Reserved method must return a value 
(_WAK)

my fix:
        Return(Package(0x02){0x00, 0x00})

dsdt.dsl-org   324:             Store (Local0, Local0)
Error    1013 -                             ^ Method local variable is not 
initialized (Local0)
dsdt.dsl-org   332:             Store (Local0, Local0)
Error    1013 -                             ^ Method local variable is not 
initialized (Local0)

fixed with:
        Method (_MSG, 1, NotSerialized)
        {
            /* Store (Local0, Local0) */
        }

        Method (_SST, 1, NotSerialized)
        {
            If (LEqual (Arg0, 0x03)) {}
            If (LEqual (Arg0, 0x01)) {}
            If (LEqual (Arg0, Zero)) {}
            /* Store (Local0, Local0) */
        }
    }


dsdt.dsl-org  1571:                 Method (STM, 0, Serialized)
Warning  2019 -                               ^ Not all control paths return a 
value (STM_)

fix:  
                    Return (TMD0)
<--- I don't know what to return here....

Full dsdt-files are attached. Just search for "cr7" to find my fixes.  I don't 
know if these fixes are correct, I expect they aren't. Iasl now accepted my 
fixes. I recompiled and tested (with  acpi-dsdt-initrd-patch). No luck.

I also tried acpi_os_name="Microsoft Windows" or "Microsoft Windows NT"  (as I 
could read in the dsl-file, search "_OS"). No success.

Please could you have a look at my "fixes" and tell me what to try next or 
which infos you need ?

Sincerally,
Carsten

--Boundary-00=_vRL1AELOjI4pmXW
Content-Type: text/x-log;
  charset="us-ascii";
  name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.log"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333] (rev 80)
	Subsystem: Giga-byte Technology: Unknown device 5000
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Memory at c0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Capabilities: [80] Power Management version 2

0000:00:0b.0 Ethernet controller: Intel Corp. 82541GI Gigabit Ethernet Controller
	Subsystem: Intel Corp.: Unknown device 1176
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at db020000 (32-bit, non-prefetchable)
	Memory at db000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at db040000 (32-bit, non-prefetchable)
	I/O ports at d400 [size=128]
	Capabilities: [50] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at db041000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e400 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
	Subsystem: Giga-byte Technology GA-7VAX Onboard Audio (Realtek ALC650)
	Flags: medium devsel, IRQ 7
	I/O ports at e800
	Capabilities: [c0] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2861
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at d8000000 (32-bit, non-prefetchable)
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Memory at d4000000 (32-bit, prefetchable) [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0


--Boundary-00=_vRL1AELOjI4pmXW
Content-Type: application/x-tbz;
  name="cr7-dsdt.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cr7-dsdt.tar.bz2"

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

--Boundary-00=_vRL1AELOjI4pmXW--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
