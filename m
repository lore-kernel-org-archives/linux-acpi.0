From: Dominik Bartenstein <dom-K271P2BsTd0@public.gmane.org>
Subject: IBM Thinkpad A31 | 2.4.22-pre5 + acpi patch
Date: Sun, 20 Jul 2003 22:47:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307202247.47579.dom@wahuu.at>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z/vG/0XdDKppibx"
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


--Boundary-00=_z/vG/0XdDKppibx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Thinkpad users,

I have tried the kernel 2.4.22-pre5 with the newest acpi patch. Unfortunately 
it does not work for the IBM Thinkpad A31. The last known working kernel was 
2.4.21-rc1 + acpi patch, where at least the battery state worked correctly.

Does anybody know why the acpi does not work properly? Are there any other IBM 
Thinkpad users out there having the same problem?

Greetings,
Dominik Bartenstein

p.s. I am running a pretty recent version of the IBM Thinkpad BIOS. 

--Boundary-00=_z/vG/0XdDKppibx
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-linux-2.4.22-pre5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg-linux-2.4.22-pre5.txt"

Linux version 2.4.22-pre5 (root@jonas) (gcc version 3.2.2) #2 Wed Jul 16 19:56:31 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ff70000 (usable)
 BIOS-e820: 000000002ff70000 - 000000002ff7e000 (ACPI data)
 BIOS-e820: 000000002ff7e000 - 000000002ff80000 (ACPI NVS)
 BIOS-e820: 000000002ff80000 - 0000000030000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
767MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 196464
zone(0): 4096 pages.
zone(1): 192368 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 IBM                        ) @ 0x000f7060
ACPI: XSDT (v001 IBM    TP-1G    00000.04192) @ 0x2ff72e37
ACPI: FADT (v001 IBM    TP-1G    00000.04192) @ 0x2ff72e7b
ACPI: SSDT (v001 IBM    TP-1G    00000.04192) @ 0x2ff72f2f
ACPI: ECDT (v001 IBM    TP-1G    00000.04192) @ 0x2ff7df86
ACPI: BOOT (v001 IBM    TP-1G    00000.04192) @ 0x2ff7dfd8
ACPI: DSDT (v001 IBM    TP-1G    00000.04192) @ 0x00000000
ACPI: BIOS passes blacklist
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda3 append="hdc=ide-scsi"
Initializing CPU#0
Detected 1798.507 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 774704k/785856k available (1465k kernel code, 10764k reserved, 487k data, 104k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
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
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
PCI: Using configuration type 1
ACPI: Found ECDT
schedule_task(): keventd has not started
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
schedule_task(): keventd has not started
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.AC__._PSR] (Node c18508c0), AE_TIME
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._STA] (Node c18503c0), AE_TIME
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node c18506c0), AE_TIME
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_PR_.CPU_._PPC] (Node c184eb80), AE_AML_NO_RETURN_VALUE
ACPI: Processor [CPU] (supports C1 C2 C3, 2 performance states, 8 throttling states)
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1121: *** Error: Method execution failed [\_TZ_.THM0._TMP] (Node eff4e400), AE_TIME
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller, 00:D0:59:CF:10:21, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
blk: queue c032ad00, I/O limit 4095Mb (mask 0xffffffff)
hdc: DW-28E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=5168/240/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0098, PCI irq11
Socket status: 30000006
Yenta IRQ list 0098, PCI irq11
Socket status: 30000006
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,3)) ...
for (ide0(3,3))
ide0(3,3):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 104k freed
Adding Swap: 1028152k swap-space (priority -1)
usbdevfs: remount parameter error

--Boundary-00=_z/vG/0XdDKppibx--




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
