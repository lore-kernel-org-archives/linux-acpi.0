From: Felix Seeger <felix.seeger-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI stops screen output
Date: Sun, 13 Oct 2002 13:07:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210131307.56582.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jurij Smakov <jurij.smakov-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi

Some time ago 
[http://marc.theaimsgroup.com/?l=acpi4linux&m=102382455317408&w=2]
I posted a problem with acpi and my vaio notebook.
The problem isn't solved yet and I hope this infomation helps.

The problem is that linux stops the output on console during acpi startup.
Now I am running 2.5.42, no output, but it starts up and I can get some 
information with ssh.

btw. acpi works fine, at least the information I get looks good:

# acpi -V
     Battery 1: charging, 100%
     Thermal 1: ok, 62.0 degrees C
  AC Adapter 1: on-line

I added a '#' to the */ ... */ comments in drivers/acpi/pci_root.c to enable 
debugging.


First here is lspci -v for my graphics card:
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics 
Controller] (rev 11) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 80de
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
        Memory at f8000000 (32-bit, prefetchable) [disabled] [size=64M]
        Memory at f4000000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Capabilities: [dc] Power Management version 2


Here is some console output:

Oct 13 12:43:53 vaio kernel: Linux version 2.5.42 (hal@vaio) (gcc version 
2.95.4 20011002 (Debian prerelease)) #2 Sun Oct 13 12:31:13 CEST 200
2
Oct 13 12:43:53 vaio kernel: Video mode to be used for restore is ffff
Oct 13 12:43:53 vaio kernel: BIOS-provided physical RAM map:
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 
(usable)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 
(reserved)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 00000000000e5800 - 0000000000100000 
(reserved)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 0000000000100000 - 0000000003e70000 
(usable)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 0000000003e70000 - 0000000003e7f800 
(ACPI data)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 0000000003e7f800 - 0000000003e80000 
(ACPI NVS)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 0000000003e80000 - 0000000004000000 
(reserved)
Oct 13 12:43:53 vaio kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 
(reserved)
Oct 13 12:43:53 vaio kernel: 62MB LOWMEM available.
Oct 13 12:43:53 vaio kernel: On node 0 totalpages: 15984
Oct 13 12:43:53 vaio kernel:   DMA zone: 4096 pages
Oct 13 12:43:53 vaio kernel:   Normal zone: 11888 pages
Oct 13 12:43:53 vaio kernel:   HighMem zone: 0 pages
Oct 13 12:43:53 vaio kernel: ACPI: RSDP (v000 PTLTD                      ) @ 
0x000f73e0
Oct 13 12:43:53 vaio kernel: ACPI: RSDT (v001 SONY   U0       08193.00297) @ 
0x03e7b89c
Oct 13 12:43:53 vaio kernel: ACPI: FADT (v002   SONY       U0 08193.00297) @ 
0x03e7f720
Oct 13 12:43:53 vaio kernel: ACPI: DBGP (v001   SONY       U0 08193.00297) @ 
0x03e7f7a4
Oct 13 12:43:53 vaio kernel: ACPI: BOOT (v001   SONY       U0 08193.00297) @ 
0x03e7f7d8
Oct 13 12:43:53 vaio kernel: ACPI: DSDT (v001   SONY       U0 08193.00297) @ 
0x00000000
Oct 13 12:43:53 vaio kernel: ACPI: BIOS passes blacklist
Oct 13 12:43:53 vaio kernel: Sony Vaio laptop detected.

[...]

Oct 13 12:43:53 vaio kernel: ACPI: Subsystem revision 20021002
Oct 13 12:43:53 vaio kernel:  tbxface-0099 [03] Acpi_load_tables      : ACPI 
Tables successfully acquired
Oct 13 12:43:53 vaio kernel: Parsing 
Methods:.................................................................................................
.........................................................
Oct 13 12:43:53 vaio kernel: Table [DSDT] - 479 Objects with 48 Devices 154 
Methods 17 Regions
Oct 13 12:43:53 vaio kernel: ACPI Namespace successfully loaded at root 
c049d09c
Oct 13 12:43:53 vaio kernel: evxfevnt-0074 [04] Acpi_enable           : 
Transition to ACPI mode successful
Oct 13 12:43:53 vaio kernel: Executing all Device _STA and_INI 
methods:................................................


! < From here I don't get any output on screen >


Oct 13 12:43:53 vaio kernel: 48 Devices found containing: 48 _STA, 2 _INI 
methods
Oct 13 12:43:53 vaio kernel: Completing Region/Field/Buffer/Package 
initialization:...........................................................
....
Oct 13 12:43:53 vaio kernel: Initialized 11/17 Regions 5/5 Fields 23/23 
Buffers 24/24 Packages (479 nodes)
Oct 13 12:43:53 vaio kernel: ACPI: Interpreter enabled
Oct 13 12:43:53 vaio kernel: ACPI: Using PIC for interrupt routing
Oct 13 12:43:53 vaio kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct 13 12:43:53 vaio kernel: PCI: Probing PCI hardware (bus 00)
Oct 13 12:43:53 vaio kernel: Transparent bridge - Intel Corp. 82801BAM/CAM PCI 
Bridge
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Oct 13 12:43:53 vaio kernel: pci_bind-0191 [04] acpi_pci_bind         : Device 
00:00:01.00 not present in PCI namespace
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.HUB_._PRT]
Oct 13 12:43:53 vaio kernel: ACPI: Embedded Controller [EC0] (gpe 28)
Oct 13 12:43:53 vaio kernel: pci_link-0223 [13] acpi_pci_link_get_curr: Blank 
IRQ resource
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9, 
disabled)
Oct 13 12:43:53 vaio kernel: pci_link-0223 [13] acpi_pci_link_get_curr: Blank 
IRQ resource
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 9, 
disabled)
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9, 
disabled)
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
Oct 13 12:43:53 vaio kernel: pci_link-0223 [13] acpi_pci_link_get_curr: Blank 
IRQ resource
Oct 13 12:43:53 vaio kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 9, 
disabled)
Oct 13 12:43:53 vaio kernel: isapnp: Scanning for PnP cards...



You can see the output from acpidmp/acpidmp DSDT | acpidisasm/acpidisasm here:
http://www.halux2001.de/disasm.txt

hope that is enough.

thanks
have fun
Felix


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
