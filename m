From: "Jim Sweet" <js9204-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: No thermal information reported
Date: Fri, 14 Nov 2003 10:10:09 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Law9-F60bbSzNZb4UA200006fa3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

Hi,

I'm posting this query to acpi-devel as I had no responses after posting to
acpi-support a fortnight ago.

I would be very grateful for some advice and/or assistance regarding ACPI
and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
very limited experience with Linux internals, and none with ACPI. I have
read all the HOWTOs, etc., that I could find, and I have looked through the
list archives.

I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
motherboard; it's OEM and neither MicroStar nor HP can/will provide me
with a manual. When the PC powers on, the fan (I think it's the CPU fan
rather than the PSU fan) is extremely loud. However, as soon as WinXP
starts, the fan slows down and becomes quiet. Using a stock 2.4.22 kernel,
the fan remains very loud.

My objective at the moment is to quieten the fan under Linux without
exposing the CPU to the risk of overheating.

Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
and the fan speed, I have found no way in WinXP to get the same information;
all I can do with regards to power management is to configure the effect of
the power button (I should point out that I am a Windows novice). This leads
me to wonder if on my motherboard any thermostatic control is hard wired,
and that no thermal information is exported by the BIOS to the OS.

Using the 20031002 ACPI patch, the fan speed goes quiet during the boot
process. However, the acpi driver does not seem to recognise/support any
thermal interface. E.g.

[root-4GxjHshgciw@public.gmane.org CPU0]# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
[root-4GxjHshgciw@public.gmane.org CPU0]#

Pressing the power button, however, does register as an event, so ACPI
seems to be working in some sense.

My question, then, is this: could it be that my motherboard/BIOS simply
won't provide an interface for getting and setting thermal information, or
is it instead that my kernel is not interpreting it correctly?

Any guidance, advice, pointers, etc. would be gratefully recieved. I've
included below the output of 'dmesg', 'biosdecode' and
'acpitbl /proc/acpi/fadt'.

Regards,

Jim Sweet




Linux version 2.4.22-acpi (root-4GxjHshgciw@public.gmane.org) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #2 Tue Oct 28 08:51:17 GMT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7db0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f6a00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 247756k/253888k available (1547k kernel code, 5744k reserved, 586k
data, 136k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-rtna1MG0WIs@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=1
PCI: Using configuration type 1
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control

Methods:.................................................................................................................................
Table [DSDT](id F004) - 467 Objects with 43 Devices 129 Methods 29 Regions
ACPI Namespace successfully loaded at root c0349e1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
0000000000000428 on int 9
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 29/29 Regions 1/1 Fields 17/17 Buffers 13/13 Packages (475
nodes)
Executing all Device _STA and_INI
methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340015A, ATA DISK drive
blk: queue c0372520, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63, UDMA(100)
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem d0052000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 02:06:47 Oct 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-GVG1yU1pZJ0@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
Adding Swap: 1118840k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-HSk6yHqwR8E@public.gmane.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ed011000-ed0117ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000394af6]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CDRW/DVD SM-348B  Rev: T503
   Type:   CD-ROM                             ANSI SCSI revision: 02
IA-32 Microcode Update Driver: v1.11 <tigran-bvGu1uGVzUk@public.gmane.org>
microcode: CPU0 no microcode found! (sig=f29, pflags=4)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0189000, 00:0c:76:63:dd:b6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel(R) 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : cc6b2e60
memory : cc6b2ea0
memory : cc6b2ee0
memory : cc6b2f20
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.

# biosdecode 2.3
SMBIOS 2.3 present.
         Structure Table Length: 1152 bytes
         Structure Table Address: 0x000F0000
         Number Of Structures: 40
         Maximum Structure Size: 98 bytes
ACPI 1.0 present.
         OEM Identifier: IntelR
         RSD Table 32-bit Address: 0x0F7F3000
BIOS32 Service Directory present.
         Revision: 0
         Calling Interface Address: 0x000FB970
PNP BIOS 1.0 present.
         Event Notification: Not Supported
         Real Mode 16-bit Code Address: F000:C3F8
         Real Mode 16-bit Data Address: F000:0000
         16-bit Protected Mode Code Address: 0x000FC3D0
         16-bit Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
         Router ID: 00:1f.0
         Exclusive IRQs: 3 5 9 10 11
         Compatible Router: 8086:7000
         Slot Entry 1: ID 01:08, slot number 1
         Slot Entry 2: ID 01:09, slot number 2
         Slot Entry 3: ID 01:0a, slot number 3
         Slot Entry 4: ID 01:0b, slot number 4
         Slot Entry 5: ID 01:0c, slot number 5
         Slot Entry 6: ID 01:0d, slot number 6
         Slot EntrI would be very grateful for some advice and/or assistance 
regarding ACPI
and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
very limited experience with Linux internals, and none with ACPI. I have
read all the HOWTOs, etc., that I could find, and I have looked through the
list archives.

I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
motherboard;
it's OEM and neither MicroStar nor HP can/will provide me with a manual.
When
the PC powers on, the fan (I think it's the CPU fan rather than the PSU fan)
is
extremely loud. However, as soon as WinXP starts, the fan slows down and
becomes quiet. Using a stock 2.4.22 kernel, the fan remains very loud.

My objective at the moment is to quieten the fan speed under Linux without
exposing the CPU to the risk of overheating.

Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
and the fan speed, I have found no way in WinXP to get the same information;
all I can do with regards to power management is to configure the effect of
the power button (I should point out that I am a Windows novice). This leads
me to wonder if on my motherboard any thermostatic control is hard wired,
and that no thermal information is exported by the BIOS to the OS.
think
Using the 20031002 ACPI patch, the fan speed goes quiet during the boot
process. However, the acpi driver does not seem to recognise/support any
thermal interface. E.g.

[root-4GxjHshgciw@public.gmane.org CPU0]# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
[root-4GxjHshgciw@public.gmane.org CPU0]#

Pressing the power button, however, does register as an event, so ACPI
seems to be working in some sense.

My question, then, is this: could it be that my motherboard/BIOS simply
won't provide an interface for getting and setting thermal information, or
is it instead that my kernel is not interpreting it correctly?

Any guidance, advice, pointers, etc. would be gratefully recieved. I've
included below the output of 'dmesg', 'biosdecode' and
'acpitbl /proc/acpi/fadt'.

Regards,

Jim Sweet




Linux version 2.4.22-acpi (root-4GxjHshgciw@public.gmane.org) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #2 Tue Oct 28 08:51:17 GMT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7db0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f6a00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 247756k/253888k available (1547k kernel code, 5744k reserved, 586k
data, 136k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-rtna1MG0WIs@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=1
PCI: Using configuration type 1
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control

Methods:.................................................................................................................................
Table [DSDT](id F004) - 467 Objects with 43 Devices 129 Methods 29 Regions
ACPI Namespace successfully loaded at root c0349e1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
0000000000000428 on int 9
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 29/29 Regions 1/1 Fields 17/17 Buffers 13/13 Packages (475
nodes)
Executing all Device _STA and_INI
methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340015A, ATA DISK drive
blk: queue c0372520, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63, UDMA(100)
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem d0052000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 02:06:47 Oct 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-GVG1yU1pZJ0@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
Adding Swap: 1118840k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-HSk6yHqwR8E@public.gmane.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ed011000-ed0117ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000394af6]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CDRW/DVD SM-348B  Rev: T503
   Type:   CD-ROM                             ANSI SCSI revision: 02
IA-32 Microcode Update Driver: v1.11 <tigran-bvGu1uGVzUk@public.gmane.org>
microcode: CPU0 no microcode found! (sig=f29, pflags=4)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0189000, 00:0c:76:63:dd:b6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel(R) 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : cc6b2e60
memory : cc6b2ea0
memory : cc6b2ee0
memory : cc6b2f20
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.

# biosdecode 2.3
SMBIOS 2.3 present.
         Structure Table Length: 1152 bytes
         Structure Table Address: 0x000F0000
         Number Of Structures: 40
         Maximum Structure Size: 98 bytes
ACPI 1.0 present.
         OEM Identifier: IntelR
         RSD Table 32-bit Address: 0x0F7F3000
BIOS32 Service Directory present.
         Revision: 0
         Calling Interface Address: 0x000FB970
PNP BIOS 1.0 present.
         Event Notification: Not Supported
         Real Mode 16-bit Code Address: F000:C3F8
         Real Mode 16-bit Data Address: F000:0000
         16-bit Protected Mode Code Address: 0x000FC3D0
         16-bit Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
         Router ID: 00:1f.0
         Exclusive IRQs: 3 5 9 10 11
         Compatible Router: 8086:7000
         Slot Entry 1: ID 01:08, slot number 1
         Slot Entry 2: ID 01:09, slot number 2
         Slot Entry 3: ID 01:0a, slot number 3
         Slot Entry 4: ID 01:0b, slot number 4
         Slot Entry 5: ID 01:0c, slot number 5
         Slot Entry 6: ID 01:0d, slot number 6
         Slot EntrI would be very grateful for some advice and/or assistance 
regarding ACPI
and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
very limited experience with Linux internals, and none with ACPI. I have
read all the HOWTOs, etc., that I could find, and I have looked through the
list archives.

I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
motherboard;
it's OEM and neither MicroStar nor HP can/will provide me with a manual.
When
the PC powers on, the fan (I think it's the CPU fan rather than the PSU fan)
is
extremely loud. However, as soon as WinXP starts, the fan slows down and
becomes quiet. Using a stock 2.4.22 kernel, the fan remains very loud.

My objective at the moment is to quieten the fan speed under Linux without
exposing the CPU to the risk of overheating.

Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
and the fan speed, I have found no way in WinXP to get the same information;
all I can do with regards to power management is to configure the effect of
the power button (I should point out that I am a Windows novice). This leads
me to wonder if on my motherboard any thermostatic control is hard wired,
and that no thermal information is exported by the BIOS to the OS.
think
Using the 20031002 ACPI patch, the fan speed goes quiet during the boot
process. However, the acpi driver does not seem to recognise/support any
thermal interface. E.g.

[root-4GxjHshgciw@public.gmane.org CPU0]# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
[root-4GxjHshgciw@public.gmane.org CPU0]#

Pressing the power button, however, does register as an event, so ACPI
seems to be working in some sense.

My question, then, is this: could it be that my motherboard/BIOS simply
won't provide an interface for getting and setting thermal information, or
is it instead that my kernel is not interpreting it correctly?

Any guidance, advice, pointers, etc. would be gratefully recieved. I've
included below the output of 'dmesg', 'biosdecode' and
'acpitbl /proc/acpi/fadt'.

Regards,

Jim Sweet




Linux version 2.4.22-acpi (root-4GxjHshgciw@public.gmane.org) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #2 Tue Oct 28 08:51:17 GMT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7db0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f6a00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 247756k/253888k available (1547k kernel code, 5744k reserved, 586k
data, 136k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-rtna1MG0WIs@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=1
PCI: Using configuration type 1
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control

Methods:.................................................................................................................................
Table [DSDT](id F004) - 467 Objects with 43 Devices 129 Methods 29 Regions
ACPI Namespace successfully loaded at root c0349e1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
0000000000000428 on int 9
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 29/29 Regions 1/1 Fields 17/17 Buffers 13/13 Packages (475
nodes)
Executing all Device _STA and_INI
methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340015A, ATA DISK drive
blk: queue c0372520, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63, UDMA(100)
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem d0052000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 02:06:47 Oct 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-GVG1yU1pZJ0@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
Adding Swap: 1118840k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-HSk6yHqwR8E@public.gmane.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ed011000-ed0117ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000394af6]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CDRW/DVD SM-348B  Rev: T503
   Type:   CD-ROM                             ANSI SCSI revision: 02
IA-32 Microcode Update Driver: v1.11 <tigran-bvGu1uGVzUk@public.gmane.org>
microcode: CPU0 no microcode found! (sig=f29, pflags=4)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0189000, 00:0c:76:63:dd:b6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel(R) 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : cc6b2e60
memory : cc6b2ea0
memory : cc6b2ee0
memory : cc6b2f20
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.

# biosdecode 2.3
SMBIOS 2.3 present.
         Structure Table Length: 1152 bytes
         Structure Table Address: 0x000F0000
         Number Of Structures: 40
         Maximum Structure Size: 98 bytes
ACPI 1.0 present.
         OEM Identifier: IntelR
         RSD Table 32-bit Address: 0x0F7F3000
BIOS32 Service Directory present.
         Revision: 0
         Calling Interface Address: 0x000FB970
PNP BIOS 1.0 present.
         Event Notification: Not Supported
         Real Mode 16-bit Code Address: F000:C3F8
         Real Mode 16-bit Data Address: F000:0000
         16-bit Protected Mode Code Address: 0x000FC3D0
         16-bit Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
         Router ID: 00:1f.0
         Exclusive IRQs: 3 5 9 10 11
         Compatible Router: 8086:7000
         Slot Entry 1: ID 01:08, slot number 1
         Slot Entry 2: ID 01:09, slot number 2
         Slot Entry 3: ID 01:0a, slot number 3
         Slot Entry 4: ID 01:0b, slot number 4
         Slot Entry 5: ID 01:0c, slot number 5
         Slot Entry 6: ID 01:0d, slot number 6
         Slot EntrI would be very grateful for some advice and/or assistance 
regarding ACPI
and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
very limited experience with Linux internals, and none with ACPI. I have
read all the HOWTOs, etc., that I could find, and I have looked through the
list archives.

I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
motherboard;
it's OEM and neither MicroStar nor HP can/will provide me with a manual.
When
the PC powers on, the fan (I think it's the CPU fan rather than the PSU fan)
is
extremely loud. However, as soon as WinXP starts, the fan slows down and
becomes quiet. Using a stock 2.4.22 kernel, the fan remains very loud.

My objective at the moment is to quieten the fan speed under Linux without
exposing the CPU to the risk of overheating.

Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
and the fan speed, I have found no way in WinXP to get the same information;
all I can do with regards to power management is to configure the effect of
the power button (I should point out that I am a Windows novice). This leads
me to wonder if on my motherboard any thermostatic control is hard wired,
and that no thermal information is exported by the BIOS to the OS.
think
Using the 20031002 ACPI patch, the fan speed goes quiet during the boot
process. However, the acpi driver does not seem to recognise/support any
thermal interface. E.g.

[root-4GxjHshgciw@public.gmane.org CPU0]# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
[root-4GxjHshgciw@public.gmane.org CPU0]#

Pressing the power button, however, does register as an event, so ACPI
seems to be working in some sense.

My question, then, is this: could it be that my motherboard/BIOS simply
won't provide an interface for getting and setting thermal information, or
is it instead that my kernel is not interpreting it correctly?

Any guidance, advice, pointers, etc. would be gratefully recieved. I've
included below the output of 'dmesg', 'biosdecode' and
'acpitbl /proc/acpi/fadt'.

Regards,

Jim Sweet




Linux version 2.4.22-acpi (root-4GxjHshgciw@public.gmane.org) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #2 Tue Oct 28 08:51:17 GMT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7db0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f6a00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 247756k/253888k available (1547k kernel code, 5744k reserved, 586k
data, 136k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-rtna1MG0WIs@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=1
PCI: Using configuration type 1
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control

Methods:.................................................................................................................................
Table [DSDT](id F004) - 467 Objects with 43 Devices 129 Methods 29 Regions
ACPI Namespace successfully loaded at root c0349e1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
0000000000000428 on int 9
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 29/29 Regions 1/1 Fields 17/17 Buffers 13/13 Packages (475
nodes)
Executing all Device _STA and_INI
methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340015A, ATA DISK drive
blk: queue c0372520, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63, UDMA(100)
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem d0052000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 02:06:47 Oct 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-GVG1yU1pZJ0@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
Adding Swap: 1118840k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-HSk6yHqwR8E@public.gmane.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ed011000-ed0117ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000394af6]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CDRW/DVD SM-348B  Rev: T503
   Type:   CD-ROM                             ANSI SCSI revision: 02
IA-32 Microcode Update Driver: v1.11 <tigran-bvGu1uGVzUk@public.gmane.org>
microcode: CPU0 no microcode found! (sig=f29, pflags=4)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0189000, 00:0c:76:63:dd:b6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel(R) 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : cc6b2e60
memory : cc6b2ea0
memory : cc6b2ee0
memory : cc6b2f20
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.

# biosdecode 2.3
SMBIOS 2.3 present.
         Structure Table Length: 1152 bytes
         Structure Table Address: 0x000F0000
         Number Of Structures: 40
         Maximum Structure Size: 98 bytes
ACPI 1.0 present.
         OEM Identifier: IntelR
         RSD Table 32-bit Address: 0x0F7F3000
BIOS32 Service Directory present.
         Revision: 0
         Calling Interface Address: 0x000FB970
PNP BIOS 1.0 present.
         Event Notification: Not Supported
         Real Mode 16-bit Code Address: F000:C3F8
         Real Mode 16-bit Data Address: F000:0000
         16-bit Protected Mode Code Address: 0x000FC3D0
         16-bit Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
         Router ID: 00:1f.0
         Exclusive IRQs: 3 5 9 10 11
         Compatible Router: 8086:7000
         Slot Entry 1: ID 01:08, slot number 1
         Slot Entry 2: ID 01:09, slot number 2
         Slot Entry 3: ID 01:0a, slot number 3
         Slot Entry 4: ID 01:0b, slot number 4
         Slot Entry 5: ID 01:0c, slot number 5
         Slot Entry 6: ID 01:0d, slot number 6
         Slot EntrI would be very grateful for some advice and/or assistance 
regarding ACPI
and the 2.4.22 kernel. I am a unix kernel devloper by trade but have
very limited experience with Linux internals, and none with ACPI. I have
read all the HOWTOs, etc., that I could find, and I have looked through the
list archives.

I have a new HP Pavilion A309uk desktop with a MicroStar MS-6577
motherboard;
it's OEM and neither MicroStar nor HP can/will provide me with a manual.
When
the PC powers on, the fan (I think it's the CPU fan rather than the PSU fan)
is
extremely loud. However, as soon as WinXP starts, the fan slows down and
becomes quiet. Using a stock 2.4.22 kernel, the fan remains very loud.

My objective at the moment is to quieten the fan speed under Linux without
exposing the CPU to the risk of overheating.

Although the BIOS (Award V6.00PG) has a menu that shows the CPU temperature
and the fan speed, I have found no way in WinXP to get the same information;
all I can do with regards to power management is to configure the effect of
the power button (I should point out that I am a Windows novice). This leads
me to wonder if on my motherboard any thermostatic control is hard wired,
and that no thermal information is exported by the BIOS to the OS.
think
Using the 20031002 ACPI patch, the fan speed goes quiet during the boot
process. However, the acpi driver does not seem to recognise/support any
thermal interface. E.g.

[root-4GxjHshgciw@public.gmane.org CPU0]# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
[root-4GxjHshgciw@public.gmane.org CPU0]#

Pressing the power button, however, does register as an event, so ACPI
seems to be working in some sense.

My question, then, is this: could it be that my motherboard/BIOS simply
won't provide an interface for getting and setting thermal information, or
is it instead that my kernel is not interpreting it correctly?

Any guidance, advice, pointers, etc. would be gratefully recieved. I've
included below the output of 'dmesg', 'biosdecode' and
'acpitbl /proc/acpi/fadt'.

Regards,

Jim Sweet




Linux version 2.4.22-acpi (root-4GxjHshgciw@public.gmane.org) (gcc version 3.2.2 20030222 (Red
Hat Linux 3.2.2-5)) #2 Tue Oct 28 08:51:17 GMT 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
247MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 63472
zone(0): 4096 pages.
zone(1): 59376 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 IntelR                                    ) @ 0x000f7db0
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f3040
ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000001) @ 0x0f7f6a00
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2400.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 247756k/253888k available (1547k kernel code, 5744k reserved, 586k
data, 136k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch-rtna1MG0WIs@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xfb9a0, last bus=1
PCI: Using configuration type 1
tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control

Methods:.................................................................................................................................
Table [DSDT](id F004) - 467 Objects with 43 Devices 129 Methods 29 Regions
ACPI Namespace successfully loaded at root c0349e1c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
0000000000000428 on int 9
Completing Region/Field/Buffer/Package
initialization:............................................................
Initialized 29/29 Regions 1/1 Fields 17/17 Buffers 13/13 Packages (475
nodes)
Executing all Device _STA and_INI
methods:............................................
44 Devices found containing: 44 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 2.88M AMI BIOS
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST340015A, ATA DISK drive
blk: queue c0372520, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=5169/240/63, UDMA(100)
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
ide: late registration of driver.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 146k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem d0052000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:1d.7 PCI cache line size corrected to 32.
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 02:06:47 Oct 28 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-GVG1yU1pZJ0@public.gmane.org>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
Adding Swap: 1118840k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1010 $ Ben Collins <bcollins-HSk6yHqwR8E@public.gmane.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[ed011000-ed0117ff]  Max
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000394af6]
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: SAMSUNG   Model: CDRW/DVD SM-348B  Rev: T503
   Type:   CD-ROM                             ANSI SCSI revision: 02
IA-32 Microcode Update Driver: v1.11 <tigran-bvGu1uGVzUk@public.gmane.org>
microcode: CPU0 no microcode found! (sig=f29, pflags=4)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 1x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0189000, 00:0c:76:63:dd:b6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
ip_tables: (C) 2000-2002 Netfilter core team
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 196M
agpgart: Detected an Intel(R) 845G Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : cc6b2e60
memory : cc6b2ea0
memory : cc6b2ee0
memory : cc6b2f20
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability
40a1.

# biosdecode 2.3
SMBIOS 2.3 present.
         Structure Table Length: 1152 bytes
         Structure Table Address: 0x000F0000
         Number Of Structures: 40
         Maximum Structure Size: 98 bytes
ACPI 1.0 present.
         OEM Identifier: IntelR
         RSD Table 32-bit Address: 0x0F7F3000
BIOS32 Service Directory present.
         Revision: 0
         Calling Interface Address: 0x000FB970
PNP BIOS 1.0 present.
         Event Notification: Not Supported
         Real Mode 16-bit Code Address: F000:C3F8
         Real Mode 16-bit Data Address: F000:0000
         16-bit Protected Mode Code Address: 0x000FC3D0
         16-bit Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
         Router ID: 00:1f.0
         Exclusive IRQs: 3 5 9 10 11
         Compatible Router: 8086:7000
         Slot Entry 1: ID 01:08, slot number 1
         Slot Entry 2: ID 01:09, slot number 2
         Slot Entry 3: ID 01:0a, slot number 3
         Slot Entry 4: ID 01:0b, slot number 4
         Slot Entry 5: ID 01:0c, slot number 5
         Slot Entry 6: ID 01:0d, slot number 6
         Slot Entr

_________________________________________________________________
On the move? Get Hotmail on your mobile phone http://www.msn.co.uk/msnmobile



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
