From: Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Toshiba 1005-S157
Date: Thu, 1 Aug 2002 23:01:06 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020801225000.O9054-100000@Grayswandir.cygnet_hq>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Using kernel 2.4.18+acpi-20020726+swsusp9, the laptop starts and generally
runs fine.  The battery status functions seem to work fine, as does swsusp
and some event reporting (ac status, lid and power buttons, after some
judicious changes to the files in /etc/acpi/events).

There aren't any fan or thermal files/directories in the /proc/acpi tree,
and sleep did not work prior to installing swsusp.

Following is the dmesg output, note some apparent error messages relating
to acpi.  Does this make it seem that the DSDT for this laptop needs to be
over-written?

Thanks,

Phil

-----

Linux version 2.4.18 (root-vaMWjHiOTZx8gPQs3r+Vhu5xAlW/YhjH@public.gmane.org) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #5 Thu Aug 1 15:43:45 GMT-5 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
 BIOS-e820: 000000000f6f0000 - 000000000f6ff000 (ACPI data)
 BIOS-e820: 000000000f6ff000 - 000000000f700000 (ACPI NVS)
 BIOS-e820: 000000000f700000 - 000000000f780000 (usable)
 BIOS-e820: 000000000f780000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63360
zone(0): 4096 pages.
zone(1): 59264 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 TOSCPL                     ) @ 0x000f7080
ACPI: RSDT (v001 TOSCPL   RSDT   01540.00000) @ 0x0f6f95e9
ACPI: FADT (v001 TOSCPL ATW02    01540.00000) @ 0x0f6fef8c
Kernel command line: auto BOOT_IMAGE=linux-2.4.18 ro root=307 BOOT_FILE=/boot/vmlinuz-2.4.18 resume=/dev/hda3
Initializing CPU#0
Detected 1063.149 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2123.36 BogoMIPS
Memory: 246748k/253440k available (1375k kernel code, 6236k reserved, 421k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Celeron(TM) CPU                1066MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20020725
PCI: PCI BIOS revision 2.10 entry at 0xfd97a, last bus=2
PCI: Using configuration type 1
 tbxface-0099 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:.............................................................................................................................................................................................
Table [DSDT] - 594 Objects with 57 Devices 189 Methods 17 Regions
ACPI Namespace successfully loaded at root c030b59c
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:.........................................................
57 Devices found containing: 57 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:...........................................................
Initialized 11/17 Regions 0/0 Fields 33/33 Buffers 15/15 Packages (594 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:01.00 not present in PCI namespace
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:00.00 not present in PCI namespace
pci_bind-0191 [05] acpi_pci_bind         : Device 00:02:00.01 not present in PCI namespace
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28)
schedule_task(): keventd has not started
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
 exfldio-0110 [26] Ex_setup_region       : Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
 acpi_ac-0082 [11] acpi_ac_get_state     : Error reading AC Adapter state
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C3)
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
lp0: using parport0 (polling).
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK1517GAP, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 29498112 sectors (15103 MB), CHS=1836/255/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel 830M Chipset.
agpgart: detected 8192K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] AGP 0.99 on Intel i810 @ 0xe8000000 128MB
[drm] Initialized i810 1.1.0 20010616 on minor 0
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 08b8, PCI irq10
Socket status: 30000010
Yenta IRQ list 08b8, PCI irq10
Socket status: 30000006
Resume Machine:   Resuming from device 303
Resume Machine:   This is normal swap space
Swsusp beta 9r1:  kswsuspd starting
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 546200k swap-space (priority -1)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hde: IBM-DMDM-10340, ATA DISK drive
ide2 at 0x100-0x107,0x10e on irq 3
hde: 700560 sectors (359 MB) w/96KiB Cache, CHS=695/16/63
 hde: hde1
ide_cs: hde: Vcc = 3.3, Vpp = 0.0
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
PCI: Setting latency timer of device 00:1f.5 to 64





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
