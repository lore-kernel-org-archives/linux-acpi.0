From: Andreas Kerl <andreas.kerl-lg8xjlp1sE8@public.gmane.org>
Subject: Compaq EVO N800c acpi
Date: Sun, 25 Aug 2002 11:38:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D68A58F.5070107@dts.de>
Reply-To: andreas.kerl-lg8xjlp1sE8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I've got a Problem with this Laptop and it's chipset (i845m) .
It's now stable working with 2.4.20-pre1-ac1 (dma enabled).
acpi is working but it only tells me if ac-on.

I think I need an acpi patch against 2.4.19-ac4 because it's the latest
stable ac-patch (A.Cox says) with the support of my chipset (newer
versions are buggy with IDE drivers I think).


I testet 2.4.19 with latest acpi-patch.
There are some more things in acpi then in the ac release (that's nice :)
but what I need is a working power-management (suspend to ram and wake
up)and dma enabled.

Or must I wait for a bios-update that it works?



Here are some messages:

#dmesg
BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
     BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
     BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
     BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
     BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
Advanced speculative caching feature not present
On node 0 totalpages: 131024
zone(0): 4096 pages.
zone(1): 126928 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 COMPAQ                     ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  12549.00544) @ 0x1fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  00000.00002) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 00000.04097) @ 0x1fff64c3
ACPI: SSDT (v001 COMPAQ   CPQMag 00000.04097) @ 0x1fff65d1
ACPI: MADT not present
Kernel command line: ro root=/dev/hda4 hdc=ide-scsi vga=794
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1794.230 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 514984k/524096k available (1411k kernel code, 8724k reserved,
479k data, 152k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20020815
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: Power Resource [C140] (off)
ACPI: Power Resource [C154] (off)
ACPI: Power Resource [C158] (off)
ACPI: Power Resource [C15B] (off)
ACPI: Power Resource [C164] (on)
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D0] (off)
ACPI: Power Resource [C1D1] (off)
ACPI: Power Resource [C1D2] (off)
ACPI: Power Resource [C1D3] (off)
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
PCI: Found IRQ 10 for device 02:0e.1
PCI: Sharing IRQ 10 with 02:08.0
PCI: Sharing IRQ 10 with 02:0e.0
PCI: Sharing IRQ 10 with 02:0e.2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
ACPI: AC Adapter [C11A] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [C000] (supports C1 C2 C3, 2 performance states, 8
throttling states)
ACPI: Thermal Zone [TZ1] (51 C)
ACPI: Thermal Zone [TZ2] (47 C)
ACPI: Thermal Zone [TZ3] (16 C)
vesafb: framebuffer at 0x48000000, mapped to 0xe0810000, size 65472k
vesafb: mode is 1280x1024x16, linelength=2560, pages=24
vesafb: protected mode interface info at c000:561f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: (ide_setup_pci_device:) Could not enable device.
hda: IC25T060ATCS05-0, ATA DISK drive
hdc: DW-28E, ATAPI CD/DVD-ROM drive
~



#acpi -V
No support for device type: battery
        Thermal 1: ok, 45.0 degrees C
        Thermal 2: ok, 45.0 degrees C
        Thermal 3: ok, 16.0 degrees C
     AC Adapter 1: on-line



echo 3 > /proc/acpi/sleep don't works


Regards,

Andreas Kerl












-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
