From: Parrenin =?ISO-8859-1?Q?Fr=E9d=E9ric?= <Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org>
Subject: /proc/acpi/battery empty on a samsung V20
Date: 13 Dec 2002 18:51:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212131754.gBDHsmt02104@cnes.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,


I have posted this problem already to the acpi-support mailing list, but
even with the help of Gunter and Derek (thanks again), I cannot solve
it.

ACPI seems to work fine on my laptop, except the battery and ac status.
The related directories in /proc/acpi exist, but are empty.
There are no messages related to battery or ac in my dmesg.
Note that there is the same problem with apm : suspend mode works (apm
-s), but the battery status is unavailable.

Perhaps a related problem : I have a interupts conflict.

My dmesg follows.
I would be happy to assist with any information you need.

	Frederic


lspci:
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev
01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5
(rev 01)
00:1f.6 Modem: Intel Corp.: Unknown device 24c6 (rev 01)
02:03.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
02:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 81)
02:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000
Controller

DMESG :
Linux version 2.4.20-1mdk (quintela-JAOzawC1ADxn+L6o72McsUEOCMrvLtNR@public.gmane.org) (gcc version
3.2 (Mandrake Linux 9.1 3.2-4mdk)) #1 Tue Dec 3 21:24:49 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f6e0000 (usable)
 BIOS-e820: 000000000f6e0000 - 000000000f6f0000 (ACPI data)
 BIOS-e820: 000000000f6f0000 - 000000000f700000 (ACPI NVS)
 BIOS-e820: 000000000f700000 - 000000000f780000 (usable)
 BIOS-e820: 000000000f780000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63360
zone(0): 4096 pages.
zone(1): 59264 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f68a0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0f6eb074
ACPI: FADT (v001 SEC    DRACO    01540.00000) @ 0x0f6eff64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0f6effd8
ACPI: DSDT (v001   SEC   DRACO   01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=2.420.-1mdk ro root=305 quiet devfs=mount hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1695.027 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3381.65 BogoMIPS
Memory: 247808k/253440k available (1302k kernel code, 5116k reserved, 491k data, 140k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000000
CPU:             Common caps: 3febf9ff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 1.70GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021115
PCI: PCI BIOS revision 2.10 entry at 0xfd994, last bus=3
PCI: Using configuration type 1
    ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE31
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3)
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3)
ACPI: Embedded Controller [H_EC] (gpe 24)
ACPI: Power Resource [PFAN] (on)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: BIOS setup was incomplete.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03172ec, I/O limit 4095Mb (mask 0xffffffff)
hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=2432/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 113k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 140k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 22:00:44 Dec  3 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Setting latency timer of device 00:1d.7 to 64
hcd.c: ehci-hcd @ 00:1d.7, Intel Corp. 82801DB USB EHCI Controller
hcd.c: irq 3, pci mem d007b000
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd.c: restricting 64bit DMA mappings to segment 0 ...
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1. 0
hub.c: USB hub found
hub.c: 6 ports detected
usbdevfs: remount parameter error
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
Adding Swap: 522040k swap-space (priority -1)
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: CDRW/DVD SN-324B  Rev: U100
  Type:   CD-ROM                             ANSI SCSI revision: 02
    ACPI-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
    ACPI-1103: *** Error: Method execution failed, AE_AML_NO_RETURN_VALUE
    ACPI-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
    ACPI-1103: *** Error: Method execution failed, AE_BAD_PARAMETER
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Fan [FAN0] (on)
    ACPI-0323: *** Error: Handler for [Embedded_control] returned AE_BAD_PARAMETER
    ACPI-1103: *** Error: Method execution failed, AE_BAD_PARAMETER
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
ohci1394: $Rev: 578 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0105000-d01057ff]  Max Packet=[2048]
ieee1394: Host added: Node[00:1023]  GUID[0000f04120001f68]  [Linux OHCI-1394]
hdc: DMA disabled
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:00:F0:6E:31:1A, IRQ 3.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
