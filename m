From: "Soenke Schwardt" <snowball2-Mmb7MZpHnFY@public.gmane.org>
Subject: ACPI20030122 + USB on Sony Vaio FX601
Date: 19 Feb 2003 23:09:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <w4s7kbvexdo.fsf@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi !

I've got a problem with my Sony Vaio PCG-FX601 (afaik the US model
is called FXA53).
USB works only partially. New devices (webcam/mouse) which are plugged
in and out, are correctly recognized but the devices do not send any
data. Mousemovement, clicks or the webcam produces no interrupts for
usb. (I think the system configuration is 100% ok because booting with
2.4.18 with extremely old acpi patch (200204??) works perfectly)
Currently I tried a fresh 2.4.21-pre4 kernel with acpi20030122 patch
and had the same problem with 2.4.20 and acpi200212??.
'pci=3Dnoacpi' or 'acpi=3Doff' is no solution because irq routing by bios
is broken.

Any ideas how to get it working?

Thanks,

 S=F6nke=20



root@mobile:/proc/acpi# cat info=20
version:                 20030122
states:                  S0 S3 S4 S5=20

root@mobile:/proc/acpi# cat /proc/interrupts=20
           CPU0=20=20=20=20=20=20=20
  0:     393428          XT-PIC  timer
  1:      13836          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          2          XT-PIC  via82cxxx
  8:          3          XT-PIC  rtc
  9:      10251          XT-PIC  acpi, usb-uhci, usb-uhci, Texas Instrument=
s PCI1420
 10:      45413          XT-PIC  eth0, Texas Instruments PCI1420 (#2)
 12:       4669          XT-PIC  PS/2 Mouse
 14:      31201          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0=20
ERR:          0



--=-=-=
Content-Disposition: attachment; filename=log.txt
Content-Description: syslog

Feb 19 21:42:41 bluebird /etc/hotplug/usb.agent: Setup usbcore for USB product 0/0/0
Feb 19 21:42:44 bluebird last message repeated 3 times
Feb 19 21:42:44 bluebird kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Feb 19 21:42:44 bluebird kernel: Inspecting /boot/System.map-2.4.21-pre4
Feb 19 21:42:45 bluebird rpc.statd[282]: Version 1.0.1 Starting
Feb 19 21:42:45 bluebird kernel: Loaded 17056 symbols from /boot/System.map-2.4.21-pre4.
Feb 19 21:42:45 bluebird kernel: Symbols match kernel version 2.4.21.
Feb 19 21:42:45 bluebird kernel: Loaded 323 symbols from 14 modules.
Feb 19 21:42:45 bluebird kernel: Linux version 2.4.21-pre4 (root@bluebird) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Wed Feb 19 21:27:20 CET 2003
Feb 19 21:42:45 bluebird kernel: BIOS-provided physical RAM map:
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 00000000000c0000 - 00000000000d4000 (reserved)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 000000000ff00000 - 0000000010000000 (usable)
Feb 19 21:42:45 bluebird kernel:  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Feb 19 21:42:45 bluebird kernel: 256MB LOWMEM available.
Feb 19 21:42:45 bluebird kernel: ACPI: have wakeup address 0xc0001000
Feb 19 21:42:45 bluebird kernel: On node 0 totalpages: 65536
Feb 19 21:42:45 bluebird kernel: zone(0): 4096 pages.
Feb 19 21:42:45 bluebird kernel: zone(1): 61440 pages.
Feb 19 21:42:45 bluebird kernel: zone(2): 0 pages.
Feb 19 21:42:45 bluebird kernel: ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7710
Feb 19 21:42:45 bluebird kernel: ACPI: RSDT (v001 SONY   K5       01540.00000) @ 0x0fef9a90
Feb 19 21:42:45 bluebird kernel: ACPI: FADT (v001 SONY   K5       01540.00000) @ 0x0fefee4c
Feb 19 21:42:45 bluebird kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefeec0
Feb 19 21:42:45 bluebird kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0fefeee8
Feb 19 21:42:45 bluebird kernel: ACPI: DSDT (v001  SONY  K5       01540.00000) @ 0x00000000
Feb 19 21:42:45 bluebird kernel: ACPI: BIOS passes blacklist
Feb 19 21:42:45 bluebird kernel: Sony Vaio laptop detected.
Feb 19 21:42:45 bluebird kernel: Kernel command line: BOOT_IMAGE=Linux ro root=306 resume=/dev/hda7
Feb 19 21:42:45 bluebird kernel: Initializing CPU#0
Feb 19 21:42:45 bluebird kernel: Detected 1100.064 MHz processor.
Feb 19 21:42:45 bluebird kernel: Console: colour VGA+ 80x25
Feb 19 21:42:45 bluebird kernel: Calibrating delay loop... 2195.45 BogoMIPS
Feb 19 21:42:45 bluebird kernel: Memory: 256732k/262144k available (1310k kernel code, 4960k reserved, 531k data, 68k init, 0k highmem)
Feb 19 21:42:45 bluebird kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Feb 19 21:42:45 bluebird kernel: Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Feb 19 21:42:45 bluebird kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 19 21:42:45 bluebird kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Feb 19 21:42:45 bluebird kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 19 21:42:46 bluebird kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 19 21:42:46 bluebird kernel: CPU: L2 Cache: 64K (64 bytes/line)
Feb 19 21:42:46 bluebird kernel: Intel machine check architecture supported.
Feb 19 21:42:46 bluebird kernel: Intel machine check reporting enabled on CPU#0.
Feb 19 21:42:46 bluebird kernel: CPU:     After generic, caps: 0383f9ff c1c3f9ff 00000000 00000000
Feb 19 21:42:46 bluebird kernel: CPU:             Common caps: 0383f9ff c1c3f9ff 00000000 00000000
Feb 19 21:42:46 bluebird kernel: CPU: AMD mobile AMD Duron(tm) stepping 02
Feb 19 21:42:46 bluebird kernel: Enabling fast FPU save and restore... done.
Feb 19 21:42:46 bluebird kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 19 21:42:46 bluebird kernel: Checking 'hlt' instruction... OK.
Feb 19 21:42:46 bluebird kernel: POSIX conformance testing by UNIFIX
Feb 19 21:42:46 bluebird kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
Feb 19 21:42:46 bluebird kernel: mtrr: detected mtrr type: Intel
Feb 19 21:42:46 bluebird kernel: ACPI: Subsystem revision 20030122
Feb 19 21:42:46 bluebird kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=1
Feb 19 21:42:46 bluebird kernel: PCI: Using configuration type 1
Feb 19 21:42:46 bluebird kernel:  tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Feb 19 21:42:46 bluebird kernel: Parsing all Control Methods:.................................................................................................................................................................
Feb 19 21:42:46 bluebird kernel: Table [DSDT] - 558 Objects with 45 Devices 161 Methods 21 Regions
Feb 19 21:42:46 bluebird kernel: Parsing all Control Methods:
Feb 19 21:42:46 bluebird kernel: Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
Feb 19 21:42:46 bluebird kernel: ACPI Namespace successfully loaded at root c02ef53c
Feb 19 21:42:46 bluebird kernel: evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
Feb 19 21:42:46 bluebird kernel:    evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
Feb 19 21:42:46 bluebird kernel: Executing all Device _STA and_INI methods:.............................................
Feb 19 21:42:46 bluebird kernel: 45 Devices found containing: 45 _STA, 3 _INI methods
Feb 19 21:42:46 bluebird kernel: Completing Region/Field/Buffer/Package initialization:.......................................................................................
Feb 19 21:42:46 bluebird kernel: Initialized 17/21 Regions 16/16 Fields 27/27 Buffers 27/27 Packages (561 nodes)
Feb 19 21:42:46 bluebird kernel: ACPI: Interpreter enabled
Feb 19 21:42:46 bluebird kernel: ACPI: Using PIC for interrupt routing
Feb 19 21:42:46 bluebird kernel: ACPI: System [ACPI] (supports S0 S3 S4 S5)
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb 19 21:42:46 bluebird kernel: PCI: Probing PCI hardware (bus 00)
Feb 19 21:42:46 bluebird kernel: Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 8d & 1f -> 0d
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
Feb 19 21:42:46 bluebird kernel: ACPI: Embedded Controller [EC0] (gpe 1)
Feb 19 21:42:46 bluebird kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
Feb 19 21:42:46 bluebird kernel: ACPI: Power Resource [PCR0] (off)
Feb 19 21:42:46 bluebird kernel: ACPI: Power Resource [PCR1] (off)
Feb 19 21:42:46 bluebird kernel: schedule_task(): keventd has not started
Feb 19 21:42:46 bluebird kernel: PCI: Probing PCI hardware
Feb 19 21:42:46 bluebird kernel: PCI: Using ACPI for IRQ routing
Feb 19 21:42:46 bluebird kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Feb 19 21:42:46 bluebird kernel: Applying VIA southbridge workaround.
Feb 19 21:42:46 bluebird kernel: Linux NET4.0 for Linux 2.4
Feb 19 21:42:46 bluebird kernel: Based upon Swansea University Computer Society NET3.039
Feb 19 21:42:46 bluebird kernel: Initializing RT netlink socket
Feb 19 21:42:46 bluebird kernel: Starting kswapd
Feb 19 21:42:46 bluebird kernel: Journalled Block Device driver loaded
Feb 19 21:42:46 bluebird kernel: ACPI: AC Adapter [ACAD] (on-line)
Feb 19 21:42:46 bluebird kernel: ACPI: Battery Slot [BAT1] (battery present)
Feb 19 21:42:46 bluebird kernel: ACPI: Battery Slot [BAT2] (battery present)
Feb 19 21:42:46 bluebird kernel: ACPI: Power Button (FF) [PWRF]
Feb 19 21:42:46 bluebird kernel: ACPI: Sleep Button (CM) [SBTN]
Feb 19 21:42:46 bluebird kernel: ACPI: Lid Switch [LID]
Feb 19 21:42:46 bluebird kernel: acpi_processor-0899 [19] acpi_processor_get_per: Unsupported address space [127] (control_register)
Feb 19 21:42:46 bluebird kernel: ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] Integer: 0000000000000CB4
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] Integer: 0000000000000CB4
Feb 19 21:42:46 bluebird kernel: ACPI: Thermal Zone [THRM] (52 C)
Feb 19 21:42:46 bluebird kernel: pty: 256 Unix98 ptys configured
Feb 19 21:42:46 bluebird kernel: Floppy drive(s): fd0 is 1.44M
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] Integer: 0000000000000014
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test2
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ----------------Notify BATD
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] Integer: 0000000000002FD3
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ----------------Notify ACAD 0x0000
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird kernel: FDC 0 is a post-1991 82077
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird last message repeated 2 times
Feb 19 21:42:46 bluebird kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Feb 19 21:42:46 bluebird kernel: 8139too Fast Ethernet driver 0.9.26
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xd080b800, 08:00:46:5a:9e:36, IRQ 10
Feb 19 21:42:46 bluebird kernel: eth0:  Identified 8139 chip type 'RTL-8139C'
Feb 19 21:42:46 bluebird kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
Feb 19 21:42:46 bluebird kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 19 21:42:46 bluebird kernel: VP_IDE: IDE controller at PCI slot 00:07.1
Feb 19 21:42:46 bluebird kernel: VP_IDE: chipset revision 6
Feb 19 21:42:46 bluebird kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb 19 21:42:46 bluebird kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 19 21:42:46 bluebird kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
Feb 19 21:42:46 bluebird kernel:     ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
Feb 19 21:42:46 bluebird kernel:     ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
Feb 19 21:42:46 bluebird kernel: hda: IC25N020ATCS04-0, ATA DISK drive
Feb 19 21:42:46 bluebird kernel: hda: DMA disabled
Feb 19 21:42:46 bluebird kernel: blk: queue c0307f40, I/O limit 4095Mb (mask 0xffffffff)
Feb 19 21:42:46 bluebird kernel: hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
Feb 19 21:42:46 bluebird kernel: hdc: DMA disabled
Feb 19 21:42:46 bluebird kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 19 21:42:46 bluebird kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q20 : test1
Feb 19 21:42:46 bluebird kernel: hda: host protected area => 1
Feb 19 21:42:46 bluebird kernel: hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=2432/255/63, UDMA(100)
Feb 19 21:42:46 bluebird kernel: hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Feb 19 21:42:46 bluebird kernel: Uniform CD-ROM driver Revision: 3.12
Feb 19 21:42:46 bluebird kernel: Partition check:
Feb 19 21:42:46 bluebird kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Feb 19 21:42:46 bluebird kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 19 21:42:46 bluebird kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb 19 21:42:46 bluebird kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 19 21:42:46 bluebird kernel: TCP: Hash tables configured (established 16384 bind 16384)
Feb 19 21:42:46 bluebird kernel: GRE over IPv4 tunneling driver
Feb 19 21:42:46 bluebird kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb 19 21:42:46 bluebird kernel: IPv6 v0.8 for NET4.0
Feb 19 21:42:46 bluebird kernel: IPv6 over IPv4 tunneling driver
Feb 19 21:42:46 bluebird kernel: kjournald starting.  Commit interval 5 seconds
Feb 19 21:42:46 bluebird kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 21:42:46 bluebird kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb 19 21:42:46 bluebird kernel: Freeing unused kernel memory: 68k freed
Feb 19 21:42:46 bluebird kernel: Adding Swap: 128484k swap-space (priority -1)
Feb 19 21:42:46 bluebird kernel: Adding Swap: 289128k swap-space (priority -2)
Feb 19 21:42:46 bluebird kernel: EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
Feb 19 21:42:46 bluebird kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
Feb 19 21:42:46 bluebird kernel: Real Time Clock Driver v1.10e
Feb 19 21:42:46 bluebird kernel: [ACPI Debug] String: ------------------------ _Q09 : test
Feb 19 21:42:46 bluebird kernel: Via 686a/8233/8235 audio driver 1.9.1-ac2
Feb 19 21:42:46 bluebird kernel: PCI: Setting latency timer of device 00:07.5 to 64
Feb 19 21:42:46 bluebird kernel: ac97_codec: AC97 Audio codec, id: ADS72 (Analog Devices AD1881A)
Feb 19 21:42:46 bluebird kernel: via82cxxx: board #1 at 0x1000, IRQ 5
Feb 19 21:42:46 bluebird kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb 19 21:42:46 bluebird kernel: ip_conntrack version 2.1 (2048 buckets, 16384 max) - 292 bytes per conntrack
Feb 19 21:42:46 bluebird kernel: kjournald starting.  Commit interval 5 seconds
Feb 19 21:42:46 bluebird kernel: EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
Feb 19 21:42:46 bluebird kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
Feb 19 21:42:46 bluebird kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 21:42:46 bluebird kernel: usb.c: registered new driver usbdevfs
Feb 19 21:42:46 bluebird kernel: usb.c: registered new driver hub
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: $Revision: 1.275 $ time 21:34:16 Feb 19 2003
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: High bandwidth mode enabled
Feb 19 21:42:46 bluebird kernel: PCI: Setting latency timer of device 00:07.2 to 64
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: USB UHCI at I/O 0x1c00, IRQ 9
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: Detected 2 ports
Feb 19 21:42:46 bluebird kernel: usb.c: new USB bus registered, assigned bus number 1
Feb 19 21:42:46 bluebird kernel: usb.c: kmalloc IF cfb0afc0, numif 1
Feb 19 21:42:46 bluebird kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Feb 19 21:42:46 bluebird kernel: usb.c: USB device number 1 default language ID 0x0
Feb 19 21:42:46 bluebird kernel: Product: USB UHCI Root Hub
Feb 19 21:42:46 bluebird kernel: SerialNumber: 1c00
Feb 19 21:42:46 bluebird kernel: hub.c: USB hub found
Feb 19 21:42:46 bluebird kernel: hub.c: 2 ports detected
Feb 19 21:42:46 bluebird kernel: hub.c: standalone hub
Feb 19 21:42:46 bluebird kernel: hub.c: ganged power switching
Feb 19 21:42:46 bluebird kernel: hub.c: global over-current protection
Feb 19 21:42:46 bluebird kernel: hub.c: Port indicators are not supported
Feb 19 21:42:46 bluebird kernel: hub.c: power on to power good time: 2ms
Feb 19 21:42:46 bluebird kernel: hub.c: hub controller current requirement: 0mA
Feb 19 21:42:46 bluebird kernel: hub.c: port removable status: RR
Feb 19 21:42:46 bluebird kernel: hub.c: local power source is good
Feb 19 21:42:46 bluebird kernel: hub.c: no over-current condition exists
Feb 19 21:42:46 bluebird kernel: hub.c: enabling power on all ports
Feb 19 21:42:46 bluebird kernel: usb.c: hub driver claimed interface cfb0afc0
Feb 19 21:42:46 bluebird kernel: usb.c: kusbd: /sbin/hotplug add 1
Feb 19 21:42:46 bluebird kernel: usb.c: kusbd policy returned 0xfffffffe
Feb 19 21:42:46 bluebird kernel: PCI: Setting latency timer of device 00:07.3 to 64
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
Feb 19 21:42:46 bluebird kernel: usb-uhci.c: Detected 2 ports
Feb 19 21:42:46 bluebird kernel: hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 1 connection change
Feb 19 21:42:46 bluebird kernel: hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 2 connection change
Feb 19 21:42:46 bluebird kernel: hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 1 enable change, status 300
Feb 19 21:42:46 bluebird kernel: hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
Feb 19 21:42:46 bluebird kernel: hub.c: port 2 enable change, status 300
Feb 19 21:42:46 bluebird kernel: usb.c: new USB bus registered, assigned bus number 2
Feb 19 21:42:46 bluebird kernel: usb.c: kmalloc IF cf49e300, numif 1
Feb 19 21:42:46 bluebird kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
Feb 19 21:42:46 bluebird kernel: usb.c: USB device number 1 default language ID 0x0
Feb 19 21:42:46 bluebird kernel: Product: USB UHCI Root Hub
Feb 19 21:42:46 bluebird kernel: SerialNumber: 1c20
Feb 19 21:42:46 bluebird kernel: hub.c: USB hub found
Feb 19 21:42:46 bluebird kernel: hub.c: 2 ports detected
Feb 19 21:42:46 bluebird kernel: hub.c: standalone hub
Feb 19 21:42:46 bluebird kernel: hub.c: ganged power switching
Feb 19 21:42:46 bluebird kernel: hub.c: global over-current protection
Feb 19 21:42:46 bluebird kernel: hub.c: Port indicators are not supported
Feb 19 21:42:46 bluebird kernel: hub.c: power on to power good time: 2ms
Feb 19 21:42:47 bluebird kernel: hub.c: hub controller current requirement: 0mA
Feb 19 21:42:47 bluebird kernel: hub.c: port removable status: RR
Feb 19 21:42:47 bluebird kernel: hub.c: local power source is good
Feb 19 21:42:47 bluebird kernel: hub.c: no over-current condition exists
Feb 19 21:42:47 bluebird kernel: hub.c: enabling power on all ports
Feb 19 21:42:47 bluebird kernel: usb.c: hub driver claimed interface cf49e300
Feb 19 21:42:47 bluebird kernel: usb.c: kusbd: /sbin/hotplug add 1
Feb 19 21:42:47 bluebird kernel: usb.c: kusbd policy returned 0xfffffffe
Feb 19 21:42:47 bluebird kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Feb 19 21:42:47 bluebird kernel: hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 1 connection change
Feb 19 21:42:47 bluebird kernel: hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 2 connection change
Feb 19 21:42:47 bluebird kernel: hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 1 enable change, status 300
Feb 19 21:42:47 bluebird kernel: hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
Feb 19 21:42:47 bluebird kernel: hub.c: port 2 enable change, status 300
Feb 19 21:42:47 bluebird kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Feb 19 21:42:47 bluebird kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Feb 19 21:42:47 bluebird kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb 19 21:42:47 bluebird kernel: eth0: no IPv6 routers present
Feb 19 21:42:49 bluebird automount[555]: starting automounter version 4.0.0, path = /net, maptype = file, mapname = /etc/auto.localnet
Feb 19 21:42:49 bluebird automount[555]: Map argc = 1
Feb 19 21:42:49 bluebird automount[555]: Map argv[0] = /etc/auto.localnet
Feb 19 21:42:50 bluebird automount[555]: mount(bind): bind_works = 1 
Feb 19 21:42:50 bluebird automount[555]: using kernel protocol version 4
Feb 19 21:42:50 bluebird automount[555]: using timeout 300 seconds; freq 75 secs
Feb 19 21:42:51 bluebird kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Feb 19 21:42:51 bluebird kernel: parport_pc: Via 686A parallel port: io=0x378
Feb 19 21:42:51 bluebird kernel: lp0: using parport0 (polling).
Feb 19 21:42:54 bluebird kernel: Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
Feb 19 21:42:54 bluebird kernel: Linux Kernel Card Services 3.1.22
Feb 19 21:42:54 bluebird kernel:   options:  [pci] [cardbus] [pm]
Feb 19 21:42:54 bluebird kernel: Yenta IRQ list 0808, PCI irq9
Feb 19 21:42:54 bluebird kernel: Socket status: 30000006
Feb 19 21:42:54 bluebird kernel: Yenta IRQ list 0808, PCI irq10
Feb 19 21:42:54 bluebird kernel: Socket status: 30000006
Feb 19 21:42:55 bluebird cardmgr[628]: watching 2 sockets
Feb 19 21:42:55 bluebird kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Feb 19 21:42:55 bluebird kernel: cs: IO port probe 0x0800-0x08ff: clean.
Feb 19 21:42:55 bluebird kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
Feb 19 21:42:55 bluebird cardmgr[629]: starting, version is 3.2.1
Feb 19 21:43:06 bluebird nmbd[685]: connect from 192.168.1.100
Feb 19 21:43:13 bluebird postfix/postfix-script: starting the Postfix mail system
Feb 19 21:43:14 bluebird postfix/master[717]: daemon started
Feb 19 21:43:14 bluebird sshd[730]: Server listening on 0.0.0.0 port 22.
Feb 19 21:43:15 bluebird xfs-xtt: ignoring font path element /var/lib/defoma/x-ttcidfont-conf.d/dirs/CID (unreadable) 
Feb 19 21:43:16 bluebird usbmgr[755]: start 0.4.8
Feb 19 21:43:16 bluebird xfs-xtt: ignoring font path element /usr/lib/X11/fonts/cyrillic/:unscaled (unreadable) 
Feb 19 21:43:16 bluebird kernel: usb.c: registered new driver hid
Feb 19 21:43:16 bluebird kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Feb 19 21:43:16 bluebird kernel: hid-core.c: USB HID support drivers
Feb 19 21:43:17 bluebird /usr/sbin/cron[763]: (CRON) INFO (pidfile fd = 3)
Feb 19 21:43:17 bluebird /usr/sbin/cron[764]: (CRON) STARTUP (fork ok)
Feb 19 21:43:17 bluebird /usr/sbin/cron[764]: (CRON) INFO (Running @reboot jobs)
Feb 19 21:43:18 bluebird kernel: mice: PS/2 mouse device common for all mice
Feb 19 21:43:18 bluebird usbmgr[757]: "hid" was loaded
Feb 19 21:43:18 bluebird usbmgr[757]: "mousedev" was loaded
Feb 19 21:43:18 bluebird insmod: insmod: vmmon: no module by that name found
Feb 19 21:43:18 bluebird insmod: insmod: vmnet: no module by that name found
Feb 19 21:43:18 bluebird modprobe: modprobe: Can't locate module char-major-119
Feb 19 21:43:18 bluebird usbmgr[757]: class:0x9 subclass:0x0 protocol:0x0
Feb 19 21:43:18 bluebird usbmgr[757]: USB device is matched the configuration
Feb 19 21:43:19 bluebird usbmgr[757]: "none" isn't loaded
Feb 19 21:43:19 bluebird modprobe: modprobe: Can't locate module char-major-119
Feb 19 21:43:20 bluebird su[1059]: + ??? root-root 
Feb 19 21:43:20 bluebird PAM_unix[1059]: (su) session opened for user root by (uid=0)
Feb 19 21:43:20 bluebird fetchmail[1060]: starting fetchmail 5.9.11 daemon  
Feb 19 21:43:28 bluebird modprobe: modprobe: Can't locate module char-major-119
Feb 19 21:43:28 bluebird VMware[init]: /dev/vmnet8: No such device
Feb 19 21:43:36 bluebird kernel: [ACPI Debug] String: Temperature decreasing: _Q81
Feb 19 21:43:36 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:43:36 bluebird kernel: [ACPI Debug] Integer: 0000000000000CAA
Feb 19 21:43:59 bluebird kernel: [ACPI Debug] String: Temperature decreasing: _Q81
Feb 19 21:43:59 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:43:59 bluebird kernel: [ACPI Debug] Integer: 0000000000000CA0
Feb 19 21:44:21 bluebird kernel: [ACPI Debug] String: Temperature decreasing: _Q81
Feb 19 21:44:21 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:44:21 bluebird kernel: [ACPI Debug] Integer: 0000000000000C96
Feb 19 21:44:48 bluebird kernel: [ACPI Debug] String: Temperature decreasing: _Q81
Feb 19 21:44:48 bluebird kernel: [ACPI Debug] String: Current Temperature is ----------- 
Feb 19 21:44:48 bluebird kernel: [ACPI Debug] Integer: 0000000000000C8C


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dsdt
Content-Transfer-Encoding: base64
Content-Description: dsdt

RFNEVIxTAAABxVNPTlkgAEs1ICAgICAgAAAEBk1TRlQNAAABEBNcX1BSX1uDC0NQVTABEIAAAAYI
T1RNUAugDBBOIlxfVFpfCFRQTF8L0gwIVEFDVAuqDAhUUEFTC8wNCFRQQ18L9A0IVFBUTQugDAhU
QlNFC6wKCFRWQVIRCAoFACAfDB+MVFZBUgoAUExDWYtUVkFSCgFDVE9Ti1RWQVIKA0NUSFlbhUYc
VEhSTQhfVFNQCigUC19DUlQApFRQQ18USxVfVE1QAKBMFFwvBV9TQl9QQ0kwUElCX0VDMF9FQ09O
oEsSXC8FX1NCX1BDSTBQSUJfRUMwX0VDT0twT1RNUGGgTQ+SWyNcLwVfU0JfUENJMFBJQl9FQzBf
TVVUMIgTcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LYHAKB1wvBV9TQl9QQ0kwUElCX0VDMF9CQU5L
cFwvBV9TQl9QQ0kwUElCX0VDMF9DVE1QYaARe2EKgAB0VEJTRXdhCgoAYaEMcndhCgoAVEJTRWFw
DUN1cnJlbnQgVGVtcGVyYXR1cmUgaXMgLS0tLS0tLS0tLS0gAFsxcGFbMaANkpVhCzAOcE9UTVBh
oQdwYU9UTVBwYFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LWydcLwVfU0JfUENJMFBJQl9FQzBfTVVU
MKALk2EKAHBUUFRNYaRhoQakT1RNUKEGpE9UTVAUC19QU1YApFRQQVMIX1BTTBIMAVwuX1BSX0NQ
VTAIX1RDMQoCCF9UQzIKAxQkX1NDUAGgCGhwAVBMQ1mhB3AAUExDWYZcLl9UWl9USFJNCoFbgERC
T1IBC3gDCgFbgQtEQk9SAURCR1AIW4BSVENQAQpwCgRbgRJSVENQAQAQQ01TSQhDTVNECAhcX1Mw
XxIKBAoACgAKAAoACFxfUzNfEgoECgEKAQoACgAIXF9TNF8SCgQKAgoCCgAKAAhcX1M1XxIKBAoC
CgIKAAoACElEQkYRAwpACFVCSDERCAoFAAAAAACMVUJIMQoASEEwNIxVQkgxCgFIQTIwjFVCSDEK
AkhBMjGMVUJIMQoDSEEyMoxVQkgxCgRIQTIzCFVCSDIRCAoFAAAAAACMVUJIMgoASEIwNIxVQkgy
CgFIQjIwjFVCSDIKAkhCMjGMVUJIMgoDSEIyMoxVQkgyCgRIQjIzCFBJREUKAAhNUFNYCgAITVIw
QQoACE1SNTIKAAhNUjVBCgAIQklSUREFCgIAAIxCSVJRCgBJUl8wjEJJUlEKAUlSXzgUSwpcX1BU
UwGgEZNoCgVcLl9TQl9HU01JCohwCgFcLwRfU0JfUENJMFBJQl9QTzE3oEwEk2gKAXBcLwRfU0Jf
UENJMFBJQl9QSVJTYaIwkpNhCgBwAVwvBF9TQl9QQ0kwUElCX1BJUlNwXC8EX1NCX1BDSTBQSUJf
UElSU2GgEpKVaAoDXC5fU0JfR1NNSQqBoBGTaAoDXC5fU0JfR1NNSQqFcGhQSURFpAoAFEYNXF9X
QUsBhlwuX1NCX0JBVDEKgIZcLl9TQl9CQVQyCoCGXC5fU0JfQUNBRAqAhlwuX1NCX0JBVDEKgYZc
Ll9TQl9CQVQyCoGGXC8EX1NCX1BDSTBQSUJfVUFSMQoAoEwEk2gKAXBcLwRfU0JfUENJMFBJQl9Q
SVJTYaIwkpNhCgBwAVwvBF9TQl9QQ0kwUElCX1BJUlNwXC8EX1NCX1BDSTBQSUJfUElSU2FcLl9T
Ql9HU01JCoKgF5OHXF9PU18KJ4ZcLl9TQl9TQlROCgJwaFBJREUQQgtcX0dQRRQYX0wwRACGXC8D
X1NCX1BDSTBNT0RNCgIUGF9MMDUAhlwvA19TQl9QQ0kwTEFOXwoAFEgHX0wwQgBwDSBMSUQgIE9Q
RU4vQ0xPU0UgAFsxgFwvBF9TQl9QQ0kwUElCX0xQT0xcLwRfU0JfUENJMFBJQl9MUE9McFwvBF9T
Ql9QQ0kwUElCX0xQT0xcLwRfU0JfUENJMFBJQl9QTzE3hlwuX1NCX0xJRF8KgFuAVkdBTQAMAgAM
AAoBW4ELVkdBTQFWR0ExCBCI1wRcX1NCXwhNWU9TCgAUL19JTkkAoCiTU0NNUFxfT1NfDU1pY3Jv
c29mdCBXaW5kb3dzIE5UAABw/01ZT1MUEU1JTl8CoAaVaGmkaKEDpGkUCVNMRU4BpIdoFCFTMkJG
CXJTTEVOaAFgCEJVRkYRAmBwaEJVRkakQlVGRhRHBlNDTVACcFMyQkZoYHBTMkJGaWFwAGRwU0xF
TmhlcFNMRU5pZnBNSU5fZWZnoiSVZGdwg4hgZABicIOIYWQAY6AGlGJjpAGhCqAGlWJjpP91ZKAG
lWRlpAGhDKAGlWRmpP+hA6QAW4IPU0JUTghfSElEDEHQDA5bgoFsA1BDSTAIX0hJRAxB0AoDCF9B
RFIKAAhfQkJOCgBbgE5CMDACCgALAAFbgUQFTkIwMAEAQAhHQUJBIABAH1MySzMIACBFQURECABA
DUNQRjIIAEgGR0FSVAgAGEdBUFMIABhHQVRUIABADkFHUEMgAEgFUzJLUggAQBxBUE1ECBQJX1NU
QQCkCg8IQ1JFUxFMCAqIiA0AAgwAAAAAAP8AAAAAAUcB+Az4DAEIiA0AAQwDAAAAAPcMAAD4DIgN
AAEMAwAAAA3//wAAAPOHFwAADAMAAAAAAAAKAP//DAAAAAAAAIACAIcXAAAMAQAAAAAAAA0A//8N
AAAAAAAAAAEAhxcAAAwDAAAAAAAAEAD///f/AAAAAAAA8P95ABRACF9DUlMAikNSRVMKRlZNQViK
Q1JFUwpOVkxFTnlWR0ExCglgcmAM//8LAFZNQVhyYAwAAAIAVkxFTopDUkVTCnZUQ01NikNSRVMK
glRPTU13XC8DX1NCX1BDSTBFQUREDAAAAAFgcGBUQ01NdAwAAPj/VENNTVRPTU2kQ1JFUwhfUFJU
EkoRCRIeBAz//wEACgBcLwRfU0JfUENJMFBJQl9MTktDCgASHgQM//8HAAoAXC8EX1NCX1BDSTBQ
SUJfTE5LQQoAEh4EDP//BwAKAVwvBF9TQl9QQ0kwUElCX0xOS0IKABIeBAz//wcACgJcLwRfU0Jf
UENJMFBJQl9MTktDCgASHgQM//8HAAoDXC8EX1NCX1BDSTBQSUJfTE5LRAoAEh4EDP//CgAKAFwv
BF9TQl9QQ0kwUElCX0xOS0EKABIeBAz//woACgFcLwRfU0JfUENJMFBJQl9MTktCCgASHgQM//8O
AAoAXC8EX1NCX1BDSTBQSUJfTE5LRAoAEh4EDP//EAAKAFwvBF9TQl9QQ0kwUElCX0xOS0IKAFuC
hxwCUElCXwhfQURSDAAABwBbgElSUVICCgAKiFuBRwpJUlFSAQBABFJWSUQIAEgfAAJFVVNCAQA9
RkREQQJMUERBAgAERkRJUQRMUElRBFNBSVEEU0JJUQQAEAAEUElSQQRQSVJCBFBJUkMEAARQSVJE
BABABERNQTAIAAhETUFBCAAIRE1BQggACERNQUMIAEANUERDMQhQREMyCFBEQzMIUERDNAhFWEZF
CEVQM0MBRU4zQwFFQUNGAUVNQ0YBRVNCMQFbgkUSTE5LQQhfSElEDEHQDA8IX1VJRAoBCF9QUlMR
CQoGI7geGHkAFBtfRElTAHAAXC8EX1NCX1BDSTBQSUJfUElSQRQmX1NUQQCgGpNcLwRfU0JfUENJ
MFBJQl9QSVJBCgCkCgmhBKQKCxRPBl9DUlMACEJVRkERCQoGIwAAGHkAjEJVRkEKAUlSQTGMQlVG
QQoCSVJBMnBcLwRfU0JfUENJMFBJQl9QSVJBYKAolGAKAKAVlGAKB3RgCghgcAoBYXlhYElSQTKh
DHAKAWF5YWBJUkExpEJVRkEUSwRfU1JTAYxoCgFJUkExjGgKAklSQTKgFJRJUkEyAIFJUkEyYHZg
cmAKCGChCYFJUkExYHZgcGBcLwRfU0JfUENJMFBJQl9QSVJBW4JFEkxOS0IIX0hJRAxB0AwPCF9V
SUQKAghfUFJTEQkKBiO4Hhh5ABQbX0RJUwBwAFwvBF9TQl9QQ0kwUElCX1BJUkIUJl9TVEEAoBqT
XC8EX1NCX1BDSTBQSUJfUElSQgoApAoJoQSkCgsUTwZfQ1JTAAhCVUZCEQkKBiMAABh5AIxCVUZC
CgFJUkIxjEJVRkIKAklSQjJwXC8EX1NCX1BDSTBQSUJfUElSQmCgKJRgCgCgFZRgCgd0YAoIYHAK
AWF5YWBJUkIyoQxwCgFheWFgSVJCMaRCVUZCFEsEX1NSUwGMaAoBSVJCMYxoCgJJUkIyoBSUSVJC
MgCBSVJCMmB2YHJgCghgoQmBSVJCMWB2YHBgXC8EX1NCX1BDSTBQSUJfUElSQluCRRJMTktDCF9I
SUQMQdAMDwhfVUlECgMIX1BSUxEJCgYjuB4YeQAUG19ESVMAcABcLwRfU0JfUENJMFBJQl9QSVJD
FCZfU1RBAKAak1wvBF9TQl9QQ0kwUElCX1BJUkMKAKQKCaEEpAoLFE8GX0NSUwAIQlVGQxEJCgYj
AAAYeQCMQlVGQwoBSVJDMYxCVUZDCgJJUkMycFwvBF9TQl9QQ0kwUElCX1BJUkNgoCiUYAoAoBWU
YAoHdGAKCGBwCgFheWFgSVJDMqEMcAoBYXlhYElSQzGkQlVGQxRLBF9TUlMBjGgKAUlSQzGMaAoC
SVJDMqAUlElSQzIAgUlSQzJgdmByYAoIYKEJgUlSQzFgdmBwYFwvBF9TQl9QQ0kwUElCX1BJUkNb
gksSTE5LRAhfSElEDEHQDA8IX1VJRAoECF9QUlMRCQoGI7geGHkAFBtfRElTAHAAXC8EX1NCX1BD
STBQSUJfUElSRBQmX1NUQQCgGpNcLwRfU0JfUENJMFBJQl9QSVJECgCkCgmhBKQKCxRFB19DUlMA
CEJVRkQRCQoGIwAAGHkAjEJVRkQKAUlSRDGMQlVGRAoCSVJEMnBcLwRfU0JfUENJMFBJQl9QSVJE
YKAulGAKAKAYlGAKB3RgCghicAoBYXlhYmNwY0lSRDKhD3AKAWF5YWBicGJJUkQxpEJVRkQUSwRf
U1JTAYxoCgFJUkQxjGgKAklSRDKgFJRJUkQyAIFJUkQyYHZgcmAKCGChCYFJUkQxYHZgcGBcLwRf
U0JfUENJMFBJQl9QSVJEW4I/RE1BMQhfSElEDEHQAgAIX0NSUxEgCh0qEARHAQAAAAABEEcBgQCB
AAEPRwHAAMAAASB5ABQJX1NUQQCkCg9bgi9SVENfCF9ISUQMQdALABQJX1NUQQCkCg8IX0NSUxEQ
Cg1HAXAAcAABBCIAAXkAW4I1UElDXwhfSElEC0HQFAlfU1RBAKQKDwhfQ1JTERgKFUcBIAAgAAEC
RwGgAKAAAQIiBAB5AFuCL0NPUFIIX0hJRAxB0AwEFAlfU1RBAKQKDwhfQ1JTERAKDUcB8ADwAAEQ
IgAgeQBbgi9UTVJfCF9ISUQMQdABABQJX1NUQQCkCg8IX0NSUxEQCg1HAUAAQAABBCIBAHkAW4Is
U1BLUhQJX1NUQQCkCg8IX0hJRAxB0AgACF9DUlMRDQoKRwFhAGEAAQF5AFuCQgZNRU1fCF9ISUQM
QdAMARQJX1NUQQCkCg8URwRfQ1JTAAhTTUVNETUKMoYJAAEAAAAAAAAKAIYJAAAAwA0AAEAAAIYJ
AAAAAA4AAAACAIYJAAAAAPD/AAAQAHkApFNNRU1bgkYGU1lTUghfSElEDEHQDAIUCV9TVEEApAoP
CF9DUlMRRgQKQkcB0ATQBAECRwGAAIAAAQFHAZIAkgABAUcBqACoAAECRwEAgACAAYBHAYCAgIAB
gEcBAIEAgQEgRwEAaABoAYB5AFuAVlNJTwEL8AMKAluBEFZTSU8BSU5EWAhEQVRBCFuGL0lORFhE
QVRBAQBAcUNSRTIIQ1JFMwgAEENSRTYIQ1JFNwhDUkU4CAAoQ1JFRQgUNUVOQ0cAcFwvBF9TQl9Q
Q0kwUElCX0VYRkVgfWAKAmBwYFwvBF9TQl9QQ0kwUElCX0VYRkUUNUVYQ0cAcFwvBF9TQl9QQ0kw
UElCX0VYRkVge2AK/WBwYFwvBF9TQl9QQ0kwUElCX0VYRkVbgk8rRkRDMAhfSElEDEHQBwAIUlNS
QxEbChhHAQAAAAABBkcBAAAAAAEBIgAAKgAAeQAURwVfU1RBAHBcLwRfU0JfUENJMFBJQl9FWEZF
YHtgCgFgoAaSYKQKAEVOQ0dwQ1JFMmB7YAoQYKAYYHBDUkUzYUVYQ0egCJNhCgCkCg2kCg9FWENH
pAoNFBRfRElTAEVOQ0dwAENSRTNFWENHFE4TX0NSUwCgEJN7X1NUQQoEAACkUlNSQwhCVUYwERsK
GEcB8APwAwEGRwH3A/cDAQEiQAAqBAB5AIxCVUYwCgJJT0xPjEJVRjAKA0lPSEmMQlVGMAoESU9S
TIxCVUYwCgVJT1JIjEJVRjAKCkRBTE+MQlVGMAoLREFISYxCVUYwCgxEUkxPjEJVRjAKDURSSEmM
QlVGMAoRSVJRTIxCVUYwChRETUFWcERBVEFge2AKIGCgRgSTYAoAcApwSU9MT3AKA0lPSElwSU9M
T0lPUkxwSU9ISUlPUkhwCndEQUxPcAoDREFISXBEQUxPRFJMT3BEQUhJRFJISXBcLwRfU0JfUENJ
MFBJQl9GRElRYHAKAWF5YWBJUlFMcFwvBF9TQl9QQ0kwUElCX0ZEREFgcAoBYXlhYERNQVakQlVG
MAhfUFJTER4KGzEERwHwA/ADAQZHAfcD9wMBASJAACoEADh5ABRNC19TUlMBjGgKAklPTE+MaAoD
SU9ISYtoChFJUlFMjGgKFERNQVZFTkNHcENSRTJhe2EK72FwYUNSRTKgDJNJT0xPCvBwCvBgoQVw
CnBgemAKAmB7YAr8YHBJT0hJYXlhCgZhfWBhYHBgQ1JFM4JJUlFMYHZgcGBcLwRfU0JfUENJMFBJ
Ql9GRElRgkRNQVZgdmBwYFwvBF9TQl9QQ0kwUElCX0ZEREFwQ1JFMmF9YQoQYXBhQ1JFMkVYQ0db
gk0iVUFSMQhfSElEDEHQBQEIX1VJRAoBCFJTUkMREAoNRwEAAAAACAgiAAB5ABRHBV9TVEEAcFwv
BF9TQl9QQ0kwUElCX0VYRkVge2AKAWCgBpJgpAoARU5DR3BDUkUyYHtgCgRgoBhgcENSRTdhRVhD
R6AIk2EKAKQKDaQKD0VYQ0ekCgAUBl9ESVMAFE4MX0NSUwB7X1NUQQoEYKAJk2AApFJTUkMIQlVG
MBEQCg1HAfgD+AMICCIQAHkAjEJVRjAKAklPTE+MQlVGMAoDSU9ISYxCVUYwCgRJT1JMjEJVRjAK
BUlPUkiLQlVGMAoJSVJRV0VOQ0dwQ1JFN2BwYGF7YQrAYXphCgZhe2AKP2B5YAoCYHBgSU9MT3Bh
SU9ISXBJT0xPSU9STHBJT0hJSU9SSEVYQ0dwXC8EX1NCX1BDSTBQSUJfU0FJUWBwCgFheWFgSVJR
V6RCVUYwCF9QUlMROgo3MQRHAfgD+AMICCIYCDEERwH4AvgCCAgiGAgxBEcB6APoAwgIIhgIMQRH
AegC6AIICCIYCDh5ABRBCV9TUlMBjGgKAklPTE+MaAoDSU9ISYtoCglJUlFXRU5DR3BDUkUyYHtg
CvtgcGBDUkUycElPTE9gemAKAmB7YAr+YHBJT0hJYXlhCgZhfWBhYHBgQ1JFN3BJUlFXYIJgYKAE
YHZgcGBcLwRfU0JfUENJMFBJQl9TQUlRcENSRTJgfWAKBGBwYENSRTJFWENHW4JBJ0xQVF8IUElP
TREECgEAjFBJT00KAExQVE0IX0hJRAxB0AQAFEQHX1NUQQBwXC8EX1NCX1BDSTBQSUJfRVhGRWB7
YAoBYKAGkmCkCgBFTkNHcENSRTJge2AKA2CgDJNgCgFFWENHpAoAoAySk2AKA3BgTFBUTaEIRVhD
R6QKAHBDUkU2YKAMk2AKAEVYQ0ekCglFWENHpAoPFClfRElTAEVOQ0dwAENSRTZFWENHcABcLwRf
U0JfUENJMFBJQl9MUElRFEUOX0NSUwAIQlVGMBEQCg1HAQAAAAABACIAAHkAoEIMk19TVEEKD4xC
VUYwCgJJT0xPjEJVRjAKA0lPSEmMQlVGMAoESU9STIxCVUYwCgVJT1JIjEJVRjAKB1JHTE6LQlVG
MAoJSVJRV0VOQ0dwQ1JFNmBwCghSR0xOoAyTYArvcAoEUkdMTnBgYXthCsBhemEKBmF7YAo/YHlg
CgJgcGBJT0xPcGFJT0hJcElPTE9JT1JMcElPSElJT1JIRVhDR3BcLwRfU0JfUENJMFBJQl9MUElR
YHAKAWF5YWBJUlFXpEJVRjAIX1BSUxEqCicwRwF4A3gDAQgimAgwRwF4AngCAQgimAgwRwG8A7wD
AQQimAg4eQAURglfU1JTAYxoCgJJT0xPjGgKA0lPSEmLaAoJSVJRV0VOQ0dwQ1JFMmB9YAoDYHBg
Q1JFMnBJT0xPYHpgCgJgcElPSElheWEKBmF9YGFgcGBDUkU2cElSUVdggmBgoARgdmBwYFwvBF9T
Ql9QQ0kwUElCX0xQSVFwQ1JFMmB7YAr8YHBMUFRNYX1gYWFwYUNSRTJFWENHW4JIQEVDUF8IX0hJ
RAxB0AQBFEsFX1NUQQBwXC8EX1NCX1BDSTBQSUJfRVhGRWB7YAoBYKAGkmCkCgBFTkNHcENSRTJg
e2AKA2CgHJNgCgFwQ1JFNmFFWENHoAmSk2EKAKQKD6QKDUVYQ0ekCgAUPl9ESVMARU5DR3AAQ1JF
NkVYQ0dwAFwvBF9TQl9QQ0kwUElCX0xQREFwAFwvBF9TQl9QQ0kwUElCX0xQSVEUQCVfQ1JTAAhC
VUYwERsKGEcBAAAAAAEERwEAAAAAAQQiAAAqAAB5AIxCVUYwCgJJT0xPjEJVRjAKA0lPSEmMQlVG
MAoESU9STIxCVUYwCgVJT1JIjEJVRjAKB0xFTjGMQlVGMAoKREFMT4xCVUYwCgtEQUhJjEJVRjAK
DERSTE+MQlVGMAoNRFJISYxCVUYwCg9MRU4yi0JVRjAKEUlSUVeMQlVGMAoURE1BQ0VOQ0dwQ1JF
NmBwCghMRU4xcAoITEVOMqATk2AK73AKBExFTjFwCgRMRU4ycGBhe2EKwGF6YQoGYXtgCj9geWAK
AmBwYElPTE9wYUlPSElyYQoEYXBJT0xPSU9STHBJT0hJSU9SSHBJT0xPREFMT3BhREFISXBEQUxP
RFJMT3BEQUhJRFJISUVYQ0dwXC8EX1NCX1BDSTBQSUJfTFBJUWBwCgFheWFgSVJRV3BcLwRfU0Jf
UENJMFBJQl9MUERBYKA0k2AKAHBcLwRfU0JfUENJMFBJQl9ETUEwYXthCvdhcGFcLwRfU0JfUENJ
MFBJQl9ETUEwoDSTYAoBcFwvBF9TQl9QQ0kwUElCX0RNQUFhe2EK92FwYVwvBF9TQl9QQ0kwUElC
X0RNQUGgNJNgCgJwXC8EX1NCX1BDSTBQSUJfRE1BQmF7YQr3YXBhXC8EX1NCX1BDSTBQSUJfRE1B
QqA0k2AKA3BcLwRfU0JfUENJMFBJQl9ETUFDYXthCvdhcGFcLwRfU0JfUENJMFBJQl9ETUFDcAoB
YXlhYERNQUOkQlVGMAhfUFJTEU8ECksxAEcBeAN4AwEIRwF4B3gHAQgimAgqCwAxBUcBeAJ4AgEI
RwF4BngGAQgimAgqCwAxCkcBvAO8AwEERwG8B7wHAQQimAgqCwA4eQAURgtfU1JTAYxoCgJJT0xP
jGgKA0lPSEmLaAoRSVJRV4xoChRETUFDRU5DR3BDUkUyYH1gCgNgcGBDUkUycElPTE9gemAKAmBw
SU9ISWF5YQoGYX1gYWBwYENSRTZwSVJRV2CCYGCgBGB2YHBgXC8EX1NCX1BDSTBQSUJfTFBJUYJE
TUFDYHZgcGBcLwRfU0JfUENJMFBJQl9MUERBcENSRTJge2AK/GB9YAoBYHBgQ1JFMkVYQ0dbgidQ
UzJNCF9ISUQMQdAPEwhfQ1JTEQgKBSIAEHkAFAlfU1RBAKQKD1uCN1BTMksIX0hJRAxB0AMDCF9D
UlMRGAoVRwFgAGAAAQFHAWQAZAABASICAHkAFAlfU1RBAKQKD1uCQNZFQzBfCF9ISUQMQdAMCQhf
Q1JTERUKEkcBYgBiAAEBRwFmAGYAAQF5AAhfR1BFCgEIRUNPSwoACEVDT04KABQcX1JFRwKgFZNo
CgNwaUVDT0ugCWlwCgFFQ09OW4BFUkFNAwoACv9bgUEKRVJBTQEAQAxTTVBSCFNNU1QIU01BRAhT
TUNNCFNNRDBIEFNNQUEIABAASAlUTVNTAgACQkFOSwQAEAAERkFOQwEAAwAHRVZURgEAQBRDVE1Q
CABABFRTSzQIAEAFVFNDMAgACE1CVlQQABBNQkNUEAAoVERMWQgAIEJBVEQQAEAYTUZDUBBBRkNQ
EAAIQUJDVBAASApBUkNQEFJDQVAQW4EORVJBTQEAQA5TTVcwEFuBDkVSQU0BAEAOU01CMAhbAU1V
VDAAWwFNVVRYABRMClNNUkQEoBeSk2gKB6AQkpNoCgmgCZKTaAoLpAoZcAoEYKJGBZRgCgF7U01T
VApAU01TVHBqU01DTXBpU01BRHBoU01QUnAKFGN7U01TVAq/YaIYkJNhCgCUYwoAWyIKAXtTTVNU
Cr9hdmOgCZNhCoBwCgBgoQN2YKAJYHB7YQofAGChJaALk2gKB3BTTUIwa6ALk2gKCXBTTVcwa6AL
k2gKC3BTTUQwa6RgFEoKU01XUgSgF5KTaAoGoBCSk2gKCKAJkpNoCgqkChlwCgRgokoHlGAKAaAL
k2gKBnBrU01CMKALk2gKCHBrU01XMKALk2gKCnBrU01EMHtTTVNUCkBTTVNUcGpTTUNNcGlTTUFE
cGhTTVBScAoUY3tTTVNUCr9hohiQk2EKAJRjCgBbIgoBe1NNU1QKv2F2Y6AJk2EKgHAKAGChA3Zg
oAlgcHthCh8AYKRgFEgFQlBPTAGgQAWSWyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMIgTcEJBTktg
cAoBQkFOS3BoVERMWXBgQkFOS1snXC8FX1NCX1BDSTBQSUJfRUMwX01VVDAIQUNFVgoACEJBVE8K
wAhCQVROCgAIQkFURgrAFEQEX1EwOQBwDS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBfUTA5IDog
dGVzdABbMYZcLl9TQl9TQlROCgJwCgBTTVNUFEUzX1EyMABwDS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSBfUTIwIDogdGVzdDEAWzGgQzBFQ09OoEUve1NNU1QKQABwU01BQWBwYFsxoEMlk2AKFHAN
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIF9RMjAgOiB0ZXN0MgBbMVNFTEWgSQiSWyNcLwVfU0Jf
UENJMFBJQl9FQzBfTVVUMIgTcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LZnAKBlwvBV9TQl9QQ0kw
UElCX0VDMF9CQU5LcEJBVERhcGZcLwVfU0JfUENJMFBJQl9FQzBfQkFOS1snXC8FX1NCX1BDSTBQ
SUJfRUMwX01VVDBcLwNfU0JfQkFUMUNIQlBhoEkIklsjXC8FX1NCX1BDSTBQSUJfRUMwX01VVDCI
E3BcLwVfU0JfUENJMFBJQl9FQzBfQkFOS2ZwCgZcLwVfU0JfUENJMFBJQl9FQzBfQkFOS3BCQVRE
YXBmXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktbJ1wvBV9TQl9QQ0kwUElCX0VDMF9NVVQwXC8DX1NC
X0JBVDJDSEJQYaBGBXsKQEJBVEYAhlwuX1NCX0JBVDEKAIZcLl9TQl9CQVQxCoGGXC5fU0JfQkFU
MQqAcA0tLS0tLS0tLS0tLS0tLS0tTm90aWZ5IEJBVDEgMHgwMABbMaBIBXsKgEJBVEYAhlwuX1NC
X0JBVDIKAIZcLl9TQl9CQVQyCoGGXC5fU0JfQkFUMgqAcA0tLS0tLS0tLS0tLS0tLS0tTm90aWZ5
IEJBVDItLS0tLS0tAFsxcAoBQUNFVoZcLl9TQl9BQ0FECgBwDS0tLS0tLS0tLS0tLS0tLS1Ob3Rp
ZnkgQUNBRCAweDAwMDAAWzGgTAiSWyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMIgTcFwvBV9TQl9Q
Q0kwUElCX0VDMF9CQU5LZnAKBlwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LcEJBVERCQVRPcGZcLwVf
U0JfUENJMFBJQl9FQzBfQkFOS1snXC8FX1NCX1BDSTBQSUJfRUMwX01VVDBwCgBTTVNUFEUWU0VM
RQCgTAiSWyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMIgTcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5L
ZnAKBlwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LcEJBVERCQVROcGZcLwVfU0JfUENJMFBJQl9FQzBf
QkFOS1snXC8FX1NCX1BDSTBQSUJfRUMwX01VVDBwDS0tLS0tLS0tLS0tLS0tLS1Ob3RpZnkgQkFU
RABbMXBCQVROWzFwCgBCQVRGoBR7CsBCQVROAH1CQVRGCgFCQVRGoBV7CwAMQkFUTgB9QkFURgoE
QkFURntCQVROCgFge0JBVE8KAWGgEJKTYGF9QkFURgpAQkFURntCQVROCgJge0JBVE8KAmGgEJKT
YGF9QkFURgqAQkFURntCQVROCsBge0JBVE8KwGGgEJKTYGF9QkFURgoCQkFURqAUewoEQkFURgB9
QkFURgoQQkFURhQyX1ExNQBwDVNsZWVwIEJ1dHRvbiBRdWVyeTogRm4rRjEyAFsxhlwuX1NCX1NC
VE4KgBQGX1EwQQAUQidfUTEwAHANRGlzcGxheSBTd2l0Y2g6IEZuK0Y3AFsxoEIkk1wvBV9TQl9Q
Q0kwUFBCX1ZHQV9TV0lUCgBcLl9TQl9HU01JCopwCv1DTVNJcENNU0Rhe2EKA2FwYVsxoEMgk2EK
AVwuX1NCX0dTTUkKjHAK/UNNU0lwQ01TRGJ7YgoMYqAfk2IKBHAKAVwvBV9TQl9QQ0kwUFBCX1ZH
QV9UT0dGoB+TYgoIcAoAXC8FX1NCX1BDSTBQUEJfVkdBX1RPR0agH5NiCgxwCgJcLwVfU0JfUENJ
MFBQQl9WR0FfVE9HRnVcLwVfU0JfUENJMFBQQl9WR0FfVE9HRnBcLwVfU0JfUENJMFBQQl9WR0Ff
VE9HRmBwDVRvZ0YAWzFwYFsxoEkFk2AKAXANTENEAFsxcABcLwVfU0JfUENJMFBQQl9WR0FfVFZB
X3AAXC8FX1NCX1BDSTBQUEJfVkdBX0NSVEFwAVwvBV9TQl9QQ0kwUFBCX1ZHQV9MQ0RBoE0Fk2AK
AnANTENEK0NSVABbMXAAXC8FX1NCX1BDSTBQUEJfVkdBX1RWQV9wAVwvBV9TQl9QQ0kwUFBCX1ZH
QV9DUlRBcAFcLwVfU0JfUENJMFBQQl9WR0FfTENEQaBCB5NgCgNwDUNSVABbMXAAXC8FX1NCX1BD
STBQUEJfVkdBX1RPR0ZwAFwvBV9TQl9QQ0kwUFBCX1ZHQV9UVkFfcAFcLwVfU0JfUENJMFBQQl9W
R0FfQ1JUQXAAXC8FX1NCX1BDSTBQUEJfVkdBX0xDREGGXC8EX1NCX1BDSTBQUEJfVkdBXwqAoQ1c
Ll9TQl9HU01JCogURR5fUTExAHANRGlzcGxheSBTd2l0Y2g6IEZuK0Y4AFsxoEUbk1wvBV9TQl9Q
Q0kwUFBCX1ZHQV9TV0lUCgBcLl9TQl9HU01JCotwCv1DTVNJcENNU0Rhe2EKA2FwYVsxoEYXk2EK
AnVcLwVfU0JfUENJMFBQQl9WR0FfVE9HMnBcLwVfU0JfUENJMFBQQl9WR0FfVE9HMmCgSQWTYAoB
cA1MQ0QAWzFwAFwvBV9TQl9QQ0kwUFBCX1ZHQV9DUlRBcABcLwVfU0JfUENJMFBQQl9WR0FfVFZB
X3ABXC8FX1NCX1BDSTBQUEJfVkdBX0xDREGgTAWTYAoCcA1MQ0QrVFYAWzFwAFwvBV9TQl9QQ0kw
UFBCX1ZHQV9DUlRBcAFcLwVfU0JfUENJMFBQQl9WR0FfVFZBX3ABXC8FX1NCX1BDSTBQUEJfVkdB
X0xDREGgQQeTYAoDcA1UVgBbMXAAXC8FX1NCX1BDSTBQUEJfVkdBX1RPRzJwAFwvBV9TQl9QQ0kw
UFBCX1ZHQV9DUlRBcAFcLwVfU0JfUENJMFBQQl9WR0FfVFZBX3AAXC8FX1NCX1BDSTBQUEJfVkdB
X0xDREGGXC8EX1NCX1BDSTBQUEJfVkdBXwqAoQ1cLl9TQl9HU01JCokUBl9RMDUAFDRfUTgwAHAN
VGVtcGVyYXR1cmUgaW5jcmVhc2luZzogX1E4MABbMYZcLl9UWl9USFJNCoAUNF9RODEAcA1UZW1w
ZXJhdHVyZSBkZWNyZWFzaW5nOiBfUTgxAFsxhlwuX1RaX1RIUk0KgBQNX1BTMABwCgFFQ09OFEYG
X1BTMwBwCgBFQ09OcAoBRVZURqA4k4dcX09TXwoncFwvBV9TQl9QQ0kwUFBCX1ZHQV9EVFJUYHBg
XC8EX1NCX1BDSTBQUEJfVlI1OHBcLwRfU0JfUENJMFBNX19TQ0NETVIwQVuAR0xCTAELAIAKUFuB
M0dMQkwBAEgRAAVBV0FLAQAiAAdQSVJTAQAYAAdMUE9MAQAQQVBNQwgAQA8AAVBPMTcBW4BDTU9T
AQpyCgJbgRBDTU9TAUNJTkQIQ0RBVAhbhg9DSU5EQ0RBVAFDUkRJAluCRS9QUEJfCF9BRFIMAAAB
AAhfUFJUEh8BEhwEC///CgBcLwRfU0JfUENJMFBJQl9MTktDCgAIVlBTWAoACEhSMTAKAAhIUjg4
CgAISFJBOAoACEhSNTIKAAhIUjcyCgAISFJCNwoACFZSNTgKAFuCRihWR0FfCF9BRFIKAAhTV0lU
CgEIQ1JUQQoBCExDREEKAQhUVkFfCgAIVE9HRgoCCFRPRzIKARQgX0RPUwFwDVZHQSAtLV9ET1Mg
QXJnMABbMXBoU1dJVBQoX0RPRABwDVZHQSAtLV9ET0QAWzGkEhEDDAABAQAMEAEBAAwAAgEAW4JK
B0NSVF8IX0FEUgsAARQjX0RDUwBwDUNSVCAtLV9EQ1MAWzGgCENSVEGkCh+hBKQKHRQtX0RHUwBw
DUNSVCAtLV9ER1MAWzFwQ1JUQWBwYFsxoAhDUlRBpAoBoQSkCgAUGV9EU1MBcA1DUlQgLS1fRFNT
AFsxcGhbMVuCSgdMQ0RfCF9BRFILEAEUI19EQ1MAcA1MQ0QgLS1fRENTAFsxoAhMQ0RBpAofoQSk
Ch0ULV9ER1MAcA1MQ0QgLS1fREdTAFsxcExDREFgcGBbMaAITENEQaQKAaEEpAoAFBlfRFNTAXAN
TENEIC0tX0RTUwBbMXBoWzFbgkcHVFZfXwhfQURSCwACFCJfRENTAHANVFYgLS1fRENTAFsxoAhU
VkFfpAofoQSkCh0ULF9ER1MAcA1UViAtLV9ER1MAWzFwVFZBX2BwYFsxoAhUVkFfpAoBoQSkCgAU
GF9EU1MBcA1UViAtLV9EU1MAWzFwaFsxW4BWQVRJAgoACv9bgQ5WQVRJAQBALERUUlQgFEYEX1BT
MACgPpNWUFNYCgOgE5OHXF9PU18KJ3BWUjU4RFRSVHBIUjg4R0FUVHBIUkE4QUdQQ3BIUkI3UzJL
UnAKAFZQU1gUMV9QUzMAoCqTVlBTWAoAcEdBVFRIUjg4cEFHUENIUkE4cFMyS1JIUkI3cAoDVlBT
WFuCSAdQTV9fCF9BRFIMBAAHAFuAU0I3NAIKAAsAAVuBI1NCNzQBAEAFU0NDRBAAQBxQSVIwCFBJ
UjgIAEAOUE02MhAUH19QUzAAoBiTTVBTWAoDcE1SMEFQTTYycAoATVBTWBQWX1BTMwCgD5NNUFNY
CgBwCgNNUFNYCFJFR1QSLBUKEAogCiEKIgojCjMKNAo1CjYKNwpHCkgKSQpKCksKTApcCl0KXgpf
Cm8IRE1UQhISCAoFCgQKAwoCCgIKAQoBCgAIUElPVBISBwtYAgt/AQrwCrQKeApaCgAIQ0tCUwoK
W4JNZ0lERV8IX0FEUgwBAAcAW4BQQ0lfAgpICmBbgTBQQ0lfA1NEUjEIU0RSMAhQRFIxCFBEUjAI
U0RTVARQRFNUBAAYVURNUxBVRE1QEBRGEEdUTV8DcBEDChRgimAKAFBJTzCKYAoERE1BMIpgCghQ
SU8ximAKDERNQTGKYAoQRkxBR3AKCkNLQlOgHpVcLwRfU0JfUENJMFBJQl9SVklECkBwCg9DS0JT
cABGTEFHfUZMQUcKEEZMQUdye2kKDwB6aQoEAGFyYQoCYXdhCh5QSU8wfUZMQUcKAkZMQUdye2oK
DwB6agoEAGFyYQoCYXdhCh5QSU8xfUZMQUcKCEZMQUegEXtoCuAAfUZMQUcKBEZMQUdye2gKBwAK
AmF3YUNLQlNETUExoBJ7aAsA4AB9RkxBRwoBRkxBR3J6e2gLAAcACggACgJhd2FDS0JTRE1BMKRg
FEoVU1RNXwNwEQMKBWeLZwoAVURNVItnCgJQSU9UjGcKBFI0Q1SKaAoAUElPMIpoCgRETUEwimgK
CFBJTzGKaAoMRE1BMYpoChBGTEFHcAoKQ0tCU6AelVwvBF9TQl9QQ0kwUElCX1JWSUQKQHAKD0NL
QlNwRkxBR2RwCwcHYaAoe2QKAQB7YQoHYXhETUEwQ0tCUwBjdGMKAmN9YwrgY315YwoIY2FhoCR7
ZAoEAHthCwD/YXhETUExQ0tCUwBjdGMKAmN9fWMK4ABhYXBhVURNVHAKCmKgNHtkCgIAeFBJTzAK
HgBjdGMKA2OgD5VjCgx7YgoDYn1iCgRicHmDiF5eUkVHVGMACggAZqEFcAoAZqAwe2QKCAB4UElP
MQoeAGN0YwoDY6APlWMKDHtiCgxifWIKAWJwg4heXlJFR1RjAGahCXB7ZgsA/wBmcGJSNENUcGZQ
SU9UpGcURAlHVEZfA6APanARCgoHAwAAAACg72ehDnARCgoHAwAAAACw72eMZwoBTU9ERXJ7aAoP
AHpoCgQAYXJhCgJhd2EKHmBwiV5eUElPVANgAAoACgBhoARhdmGgHntpCuAAcIOIXl5ETVRCe2kK
BwAAYH1gCkBNT0RFoQl9YQoITU9ERXNnZ2Z9YQoITU9ERXNmZ2WkZVuCTRVQUklNCF9BRFIKABQ/
X0dUTQBwDUdUTSAtIFByaW1hcnkgQ29udHJvbGxlcgBbMXBeXkdUTV9eXlVETVBeXlBEUjBeXlBE
UjFgpGAUQAxfU1RNA3ANU1RNIC0gUHJpbWFyeSBDb250cm9sbGVyAFsxcF5eU1RNX2hpamCLYAoA
VURNQYtgCgJQSU9NjGAKBEFEU1RwXl5VRE1QZKAylVwvBF9TQl9QQ0kwUElCX1JWSUQKQHtVRE1B
C/f/VURNQXtkCghkfVVETUFkVURNQXBVRE1BXl5VRE1QcHtQSU9NCv8AYaAKYXBhXl5QRFIxelBJ
T00KCGGgCmFwYV5eUERSMHBBRFNUXl5QRFNUW4JNBE1BU1QIX0FEUgoAFD9fR1RGAHANR1RGIC0g
UHJpbWFyeSBNYXN0ZXIAWzF6Xl5eVURNUAoIYHBeXl5HVEZfXl5eUERSMGAKAWCkYFuCQxZTRUNO
CF9BRFIKARRCBF9HVE0AcA1HVE0gLSBTZWNvbmRhcnkgQ29udHJvbGxlcgBbMXBeXkdUTV9eXlVE
TVNeXlNEUjBeXlNEUjFgpGAUQAxfU1RNA3ANU1RNIC0gU2Vjb25kYXJ5IENvbnRyb2xsZXIAWzFw
Xl5TVE1faGlqYItgCgBVRE1Ti2AKAlBJT1OMYAoEQURTU3BeXlVETVNkoDKVXC8EX1NCX1BDSTBQ
SUJfUlZJRApAe1VETVML9/9VRE1Te2QKCGR9VURNU2RVRE1TcFVETVNeXlVETVN7UElPUwr/YaAK
YXBhXl5TRFIxelBJT1MKCGGgCmFwYV5eU0RSMHBBRFNTXl5TRFNUW4JABU1BU1QIX0FEUgoAFEIE
X0dURgBwDUdURiAtIFNlY29uZGFyeSBNYXN0ZXIAWzF6Xl5eVURNUwoIYHBeXl5HVEZfXl5eU0RS
MGAKAWCkYBQ2X1BTMACgKJNfUFNDCgOgH5NQSURFCgOgFpOHXF9PU18KJ1wuX1NCX0dTTUkKhHAK
AF9QU0MUNl9QUzMAoCiTX1BTQwoAoB+TUElERQoDoBaTh1xfT1NfCidcLl9TQl9HU01JCoNwCgNf
UFNDCF9QU0MKAFuCTwRVU0IwCF9BRFIMAgAHAFuAU0I3MgIKAArCW4EOU0I3MgEAQB5VSVJSBBQj
X1NUQQCgF1wvBF9TQl9QQ0kwUElCX0VVU0KkCgChBKQKD1uCQAdVU0IxCF9BRFIMAwAHAFuAU0I3
MgIKAArCW4EnU0I3MgEAIFVCMDQIAEgNVUIyMAhVQjIxCFVCMjIIVUIyMwgAQAwUK19TVEEAcFwv
BF9TQl9QQ0kwUElCX0VYRkVge2AKEGCgBWCkCgChBKQKDwhBUFNYCgAIQVI0MQoACEFSNDIKAFuC
Sw5BVURJCF9BRFIMBQAHAFuAU0I3NQIKAAqFW4EaU0I3NQEAQB5NSVJSCAAgQUxJQwhBRkVOCBQr
X1NUQQBwXC8EX1NCX1BDSTBQSUJfRVhGRWB7YAoEYKAFYKQKAKEEpAoPFEMEX1BTMACgO5NBUFNY
CgNwQVI0MUFMSUNwQVI0MkFGRU5wCgBcLwVfU0JfUENJMFBJQl9FQzBfRVZURnAKAEFQU1gUQwRf
UFMzAKA7k0FQU1gKAHBBTElDQVI0MXBBRkVOQVI0MnAKAVwvBV9TQl9QQ0kwUElCX0VDMF9FVlRG
cAoDQVBTWAhNUFNYCgAITVI0NAoAW4JNDE1PRE0IX0FEUgwGAAcAW4BTQjc2AgoACoVbgRVTQjc2
AQBAHk1JUkwIADhNQ0lDCBQrX1NUQQBwXC8EX1NCX1BDSTBQSUJfRVhGRWB7YAoIYKAFYKQKCaEE
pAoPCF9QUlcSBgIKDQoEFEIEX1BTMACgOpNNUFNYCgNwTVI0NE1DSUNwCgBNUFNYoCFcLwRfU0Jf
UENJMFBJQl9BV0FLhlwuX1NCX1NCVE4KAhQfX1BTMwCgGJNNUFNYCgBwTUNJQ01SNDRwCgNNUFNY
CExQU1gKAAhMUjBECgBbgk0GTEFOXwhfQURSDAAAEABbgExBTk4CCgAKhVuBFkxBTk4BAEAGTFJH
RAgAQCRMUE1FCAhfUFJXEgYCCgUKBBQWX1BTMACgD5NMUFNYCgNwCgBMUFNYFBZfUFMzAKAPk0xQ
U1gKAHAKA0xQU1gIQ1BTWAoAW4JDKUNSRDAIX0FEUgwAAAoACF9QUjASBgFQQ1IwCF9QUjESBgFQ
Q1IwCF9QUjISBgFQQ1IwW4BOUENDAgoACuBbgUAGTlBDQwMAIFRJMDQIAEAEVEkwRAgAQBBUSTJF
CABIB1RJM0UQACBUSTQ0EABAHVRJODAIAEgFVEk4QwhUSThECFRJOEUIVEk4RggACFRJOTEIAEAJ
VElBNAhUSUE1CFuAVElJTwEL4AMKAluBEFRJSU8BVElJRAhUSURBCBQyX0lOSQBwVElBNGBwewrw
VElBNABUSUE0cABUSTQ0cH1USTkxCoAAVEk5MXBgVElBNBRMB19QUzAAcAoBX1BTQ3BgYKBKBpND
UFNYCgOgTARcLwVfU0JfUENJMFBJQl9FQzBfRUNPTnAKAFwvBV9TQl9QQ0kwUElCX0VDMF9FVlRG
XC8FX1NCX1BDSTBQSUJfRUMwX0JQT0wKDnB7VElBNQr+AFRJQTVwCgBDUFNYFBBfUFMxAHAKAF9Q
U0NwYGAUGl9QUzIAcHsK8FRJQTQAVElBNHAKAF9QU0MUIF9QUzMAcAoAX1BTQ3BgYKAPk0NQU1gK
AHAKA0NQU1gIVElXSwAIRVgwMwAIX1BTQwoAW4QoUENSMAAAABQLX1NUQQCkX1BTQxQJX09OXwBw
YGAUCV9PRkYAcGBgFEkJVElFTgGgQQlUSVdLoE8Gk2gBcFRJQTRgcHsK8FRJQTQAVElBNHBUSTA0
YXB9VEkwNAoBAFRJMDRwC+EDVEk0NHAKA1RJSURwVElEQUVYMDNwfUVYMDMKgABUSURBcABUSTQ0
cGFUSTA0cGBUSUE0cH1USUE1CgEAVElBNaAak2gAoBV7VElBNQqAAHBUSUE1YHBgVElBNVuCRCJD
UkQxCF9BRFIMAQAKAAhfUFIwEgYBUENSMQhfUFIxEgYBUENSMQhfUFIyEgYBUENSMVuATlBDQwIK
AArgW4FBBU5QQ0MDACBUSTA0CABABFRJMEQIAEAbVEk0NBAAQB1USTgwCABIBVRJOEMIVEk4RAhU
SThFCFRJOEYIAAhUSTkxCABACVRJQTQIVElBNQhbgFRJSU8BC+ADCgJbgRBUSUlPAVRJSUQIVElE
QQgUMl9JTkkAcFRJQTRgcHsK8FRJQTQAVElBNHAAVEk0NHB9VEk5MQqAAFRJOTFwYFRJQTQUJl9Q
UzAAcGBgcAoBX1BTQ6AVk0NQU1gKA3B7VElBNQr+AFRJQTUUEF9QUzEAcGBgcAoAX1BTQxQaX1BT
MgBwewrwVElBNABUSUE0cAoAX1BTQxQQX1BTMwBwYGBwCgBfUFNDCF9QU0MKAFuEKFBDUjEAAAAU
C19TVEEApF9QU0MUCV9PTl8AcGBgFAlfT0ZGAHBgYAhUSVdLAAhFWDAzAAhFWDQzABRJCVRJRU4B
oEEJVElXS6BPBpNoAXBUSUE0YHB7CvBUSUE0AFRJQTRwVEkwNGFwfVRJMDQKAQBUSTA0cAvhA1RJ
NDRwCkNUSUlEcFRJREFFWDQzcH1FWDQzCoAAVElEQXAAVEk0NHBhVEkwNHBgVElBNHB9VElBNQoB
AFRJQTWgGpNoAKAVe1RJQTUKgABwVElBNWBwYFRJQTUIQUNPSwoBW4JGCkFDQUQIX0hJRA1BQ1BJ
MDAwMwAIX1BDTBIHAVxfU0JfCEFDUF//FCNfUFNSAHsKAVwvBV9TQl9QQ0kwUElCX0VDMF9CQVRG
YKRgFAlfU1RBAKQKDxQyQ0hBQwFwlHtoCvAACoBgoB2Sk2BBQ1BfcGBBQ1BfhlwuX1NCX0FDQUQK
AKT/oQOkABQcRkxQQQCAQUNQX0FDUF+GXC5fU0JfQUNBRAoAFBBWVE9CAXAKAWB5YGhgpGAUG0JU
T1YBemgKAWBwCgBhoglgdWF6YAoBYKRhFCdNS1dEAqANe2kKgABwDAAA//9goQRwAGB9YGhgfWB5
aQoIAGCkYBQTR0JGRQOMaGlUSURYcFRJRFhqFBNQQkZFA4xoaVRJRFhwalRJRFgURgZJVE9TAXAR
DAoJICAgICAgICAAYHARFAoRMDEyMzQ1Njc4OUFCQ0RFRgBncAoIYXAKAGJwCgBjoiphdmF7emh5
YQoCAAAKD2SgBWRw/2OgE2NHQkZFZ2RxZVBCRkVgYmV1YqRgWwFNVVQxAAhTRUwwCvBbgkqfQkFU
MQhfSElEDEHQDAoIX1VJRAoBCF9QQ0wSBwFcX1NCXwhQQklGEiYNCgAKBQoFCgEL0DkLkAELgAEK
QApADUJBVDEADSAADSAADSAACFBCU1QSCwQKAAoFCgULECcIVUJJRgvpAQhCUF9fCgEURx9fU1RB
AKBBHlwvBV9TQl9QQ0kwUElCX0VDMF9FQ09OoEccXC8FX1NCX1BDSTBQSUJfRUMwX0VDT0ugTRqS
WyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMAAUcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LZnAKBlwv
BV9TQl9QQ0kwUElCX0VDMF9CQU5Le1wvBV9TQl9QQ0kwUElCX0VDMF9CQVRECgFgcGZcLwVfU0Jf
UENJMFBJQl9FQzBfQkFOS6AJYHAKAUJQX1+hCHAKAEJQX19wXC8FX1NCX1BDSTBQSUJfRUMwX0JB
TktmcAoGXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktwXC8FX1NCX1BDSTBQSUJfRUMwX0JBVERcLwVf
U0JfUENJMFBJQl9FQzBfQkFUT3sL/v9cLwVfU0JfUENJMFBJQl9FQzBfQkFURlwvBV9TQl9QQ0kw
UElCX0VDMF9CQVRGoE4EewrAXC8FX1NCX1BDSTBQSUJfRUMwX0JBVE8AfVwvBV9TQl9QQ0kwUElC
X0VDMF9CQVRGCgFcLwVfU0JfUENJMFBJQl9FQzBfQkFURnBmXC8FX1NCX1BDSTBQSUJfRUMwX0JB
TktbJ1wvBV9TQl9QQ0kwUElCX0VDMF9NVVQwoAhCUF9fpAofoQSkCg8URwVfQklGAKBKBFwvBV9T
Ql9QQ0kwUElCX0VDMF9FQ09OoDBcLwVfU0JfUENJMFBJQl9FQzBfRUNPS6AJQlBfX1VQQkmhBUlW
QklwC+kBVUJJRqRQQklGFEIPX0JTVACgTw1cLwVfU0JfUENJMFBJQl9FQzBfRUNPTqBFDFwvBV9T
Ql9QQ0kwUElCX0VDMF9FQ09LoE4JklsjXC8FX1NCX1BDSTBQSUJfRUMwX01VVDAAFHBcLwVfU0Jf
UENJMFBJQl9FQzBfQkFOS2ZwCgZcLwVfU0JfUENJMFBJQl9FQzBfQkFOS3tcLwVfU0JfUENJMFBJ
Ql9FQzBfQkFURAoBYHBmXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktbJ1wvBV9TQl9QQ0kwUElCX0VD
MF9NVVQwoAZgVVBCU6EFSVZCU6EFSVZCU6RQQlNUFEooVVBCSQBwAGCgTSeSWyNcLwVfU0JfUENJ
MFBJQl9FQzBfTVVUMAAUcFZUT0J0X1VJRAoBAGF9eWEKDAAL/w9icABjXC8FX1NCX1BDSTBQSUJf
RUMwX1NNV1IKCAoUCgFiXC8FX1NCX1BDSTBQSUJfRUMwX1NNUkQKCQoUCgFxY3AAYHAKDGFwERAK
DQAYAAAZAAAAACEAIiBiokoHlGEKCKBBB5J7VUJJRlZUT0JhAEdCRkViYXFjoEoFY6BGBZJcLwVf
U0JfUENJMFBJQl9FQzBfU01SRAoLChZjcWRHQkZFZAogcWVQQkZFZGUKIHVlUEJGRWRlCgBwZIhQ
QklGYQB9VUJJRlZUT0JhVUJJRnD/YHZhok0FlGEKAKBEBZJ7VUJJRlZUT0JhAEdCRkViYXFjoD1j
oDqSXC8FX1NCX1BDSTBQSUJfRUMwX1NNUkQKCQoWY3FlcGWIUEJJRmEAfVVCSUZWVE9CYVVCSUZw
/2B2YXAKCmGgRQWSe1VCSUZWVE9CYQCgRgSSXC8FX1NCX1BDSTBQSUJfRUMwX1NNUkQKCQoWChxx
ZXBbKWUAYHBJVE9TYIhQQklGYQB9VUJJRlZUT0JhVUJJRnD/YHBcLwVfU0JfUENJMFBJQl9FQzBf
QkFOS2FwCgNcLwVfU0JfUENJMFBJQl9FQzBfQkFOS3BcLwVfU0JfUENJMFBJQl9FQzBfTUZDUGKg
EJNiCgBwCgWIUEJJRgoCAKEQd2IKCmJwYohQQklGCgIAcGFcLwVfU0JfUENJMFBJQl9FQzBfQkFO
S3CDiFBCSUYKAQBid2IKCmJwYohQQklGCgEAWydcLwVfU0JfUENJMFBJQl9FQzBfTVVUMKRgFEUk
VVBCUwBwAGCgSCOSWyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMIgTcFwvBV9TQl9QQ0kwUElCX0VD
MF9CQU5LYXAKBlwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LcFwvBV9TQl9QQ0kwUElCX0VDMF9NQkNU
YqAWe2ILAIAAfWIMAAD//2JygGIACgFicFwvBV9TQl9QQ0kwUElCX0VDMF9NQlZUY3AKBFwvBV9T
Ql9QQ0kwUElCX0VDMF9CQU5LcFwvBV9TQl9QQ0kwUElCX0VDMF9SQ0FQZXBhXC8FX1NCX1BDSTBQ
SUJfRUMwX0JBTkugH5KTYoOIUEJTVAoBAHdiCgpicGKIUEJTVAoBAHD/YKAlkpNjg4hQQlNUCgMA
d2MKFGN4YwpAZGNwY4hQQlNUCgMAcP9goB+Sk2WDiFBCU1QKAgB3ZQoKZXBliFBCU1QKAgBw/2Bw
CgBkcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LZnAKBlwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LoEIE
e1wvBV9TQl9QQ0kwUElCX0VDMF9CQVRECwAMAKAce1wvBV9TQl9QQ0kwUElCX0VDMF9CQVREChAA
oQZ9CgJkZKEkoCJ7XC8FX1NCX1BDSTBQSUJfRUMwX0JBVEQLAAEAfQoBZGRwZlwvBV9TQl9QQ0kw
UElCX0VDMF9CQU5LoBqSk2SDiFBCU1QKAABwZIhQQlNUCgAAcP9gWydcLwVfU0JfUENJMFBJQl9F
QzBfTVVUMKRgFEMGSFZCSQBwC1CWiFBCSUYKAQBwC1CWiFBCSUYKAgBwC9A5iFBCSUYKBABwDVBD
R0EtQlA3MQCIUEJJRgoJAHANTElPTgCIUEJJRgoLAHANU29ueSBDb3JwLgCIUEJJRgoMABRIBklW
QkkAcAvpAVVCSUZwCgWIUEJJRgoBAHAKBYhQQklGCgIAcAoFiFBCSUYKBABwDUJhZACIUEJJRgoJ
AHANQmFkAIhQQklGCgoAcA1CYWQAiFBCSUYKCwBwDUJhZACIUEJJRgoMABQzSVZCUwBwCgCIUEJT
VAoAAHAKBYhQQlNUCgEAcAoFiFBCU1QKAgBwCxAniFBCU1QKAwAURAdDSEJQAXAAYHBWVE9CdF9V
SUQKAQBhfXlhCgwAC/8PYnAAY6Aye2hhAKAJQlBfX1VQQlOhIqANk2J9Ywv/DwBVUEJJVVBCU3AK
AUJQX19wC+kBVUJJRqEboBlCUF9fcAoAQlBfX0lWQklJVkJTfQoEYGBbgkGbQkFUMghfSElEDEHQ
DAoIX1VJRAoCCF9QQ0wSBwFcX1NCXwhQQklGEiYNCgAKBQoFCgEL0DkLkAELgAEKQApADUJBVDIA
DSAADSAADSAACFBCU1QSCwQKAAoFCgULECcIVUJJRgvpAQhCUF9fCgEURhdfU1RBAKBAFlwvBV9T
Ql9QQ0kwUElCX0VDMF9FQ09OoEYUXC8FX1NCX1BDSTBQSUJfRUMwX0VDT0ugTBKSWyNcLwVfU0Jf
UENJMFBJQl9FQzBfTVVUMAAUcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LZnAKBlwvBV9TQl9QQ0kw
UElCX0VDMF9CQU5Le1wvBV9TQl9QQ0kwUElCX0VDMF9CQVRECgJgcGZcLwVfU0JfUENJMFBJQl9F
QzBfQkFOS6AJYHAKAUJQX1+hCHAKAEJQX19wXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktmcAoGXC8F
X1NCX1BDSTBQSUJfRUMwX0JBTktwXC8FX1NCX1BDSTBQSUJfRUMwX0JBVERcLwVfU0JfUENJMFBJ
Ql9FQzBfQkFUT3BmXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktbJ1wvBV9TQl9QQ0kwUElCX0VDMF9N
VVQwoAhCUF9fpAofoQSkCg8URwVfQklGAKBKBFwvBV9TQl9QQ0kwUElCX0VDMF9FQ09OoDBcLwVf
U0JfUENJMFBJQl9FQzBfRUNPS6AJQlBfX1VQQkmhBUlWQklwC+kBVUJJRqRQQklGFEIPX0JTVACg
Tw1cLwVfU0JfUENJMFBJQl9FQzBfRUNPTqBFDFwvBV9TQl9QQ0kwUElCX0VDMF9FQ09LoE4Jklsj
XC8FX1NCX1BDSTBQSUJfRUMwX01VVDAAFHBcLwVfU0JfUENJMFBJQl9FQzBfQkFOS2ZwCgZcLwVf
U0JfUENJMFBJQl9FQzBfQkFOS3tcLwVfU0JfUENJMFBJQl9FQzBfQkFURAoCYHBmXC8FX1NCX1BD
STBQSUJfRUMwX0JBTktbJ1wvBV9TQl9QQ0kwUElCX0VDMF9NVVQwoAZgVVBCU6EFSVZCU6EFSVZC
U6RQQlNUFEooVVBCSQBwAGCgTSeSWyNcLwVfU0JfUENJMFBJQl9FQzBfTVVUMAAUcFZUT0J0X1VJ
RAoBAGF9eWEKDAAL/w9icABjXC8FX1NCX1BDSTBQSUJfRUMwX1NNV1IKCAoUCgFiXC8FX1NCX1BD
STBQSUJfRUMwX1NNUkQKCQoUCgFxY3AAYHAKDGFwERAKDQAYEAAZAAAAACEAIiBiokoHlGEKCKBB
B5J7VUJJRlZUT0JhAEdCRkViYXFjoEoFY6BGBZJcLwVfU0JfUENJMFBJQl9FQzBfU01SRAoLChZj
cWRHQkZFZAogcWVQQkZFZGUKIHVlUEJGRWRlCgBwZIhQQklGYQB9VUJJRlZUT0JhVUJJRnD/YHZh
ok0FlGEKAKBEBZJ7VUJJRlZUT0JhAEdCRkViYXFjoD1joDqSXC8FX1NCX1BDSTBQSUJfRUMwX1NN
UkQKCQoWY3FlcGWIUEJJRmEAfVVCSUZWVE9CYVVCSUZw/2B2YXAKCmGgRQWSe1VCSUZWVE9CYQCg
RgSSXC8FX1NCX1BDSTBQSUJfRUMwX1NNUkQKCQoWChxxZXBbKWUAYHBJVE9TYIhQQklGYQB9VUJJ
RlZUT0JhVUJJRnD/YHBcLwVfU0JfUENJMFBJQl9FQzBfQkFOS2FwCgNcLwVfU0JfUENJMFBJQl9F
QzBfQkFOS3BcLwVfU0JfUENJMFBJQl9FQzBfQUZDUGKgEJNiCgBwCgWIUEJJRgoCAKEQd2IKCmJw
YohQQklGCgIAcGFcLwVfU0JfUENJMFBJQl9FQzBfQkFOS3CDiFBCSUYKAQBid2IKCmJwYohQQklG
CgEAWydcLwVfU0JfUENJMFBJQl9FQzBfTVVUMKRgFE0nVVBCUwBwAGCgQCeSWyNcLwVfU0JfUENJ
MFBJQl9FQzBfTVVUMIgTcFwvBV9TQl9QQ0kwUElCX0VDMF9CQU5LYXAKA1wvBV9TQl9QQ0kwUElC
X0VDMF9CQU5LcFwvBV9TQl9QQ0kwUElCX0VDMF9BQkNUYqAWe2ILAIAAfWIMAAD//2JygGIACgFi
cAoGXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktwXC8FX1NCX1BDSTBQSUJfRUMwX01CVlRjcAoEXC8F
X1NCX1BDSTBQSUJfRUMwX0JBTktwXC8FX1NCX1BDSTBQSUJfRUMwX0FSQ1BlcGFcLwVfU0JfUENJ
MFBJQl9FQzBfQkFOS6AfkpNig4hQQlNUCgEAd2IKCmJwYohQQlNUCgEAcP9goCWSk2ODiFBCU1QK
AwB3YwoUY3hjCkBkY3BjiFBCU1QKAwBw/2CgH5KTZYOIUEJTVAoCAHdlCgplcGWIUEJTVAoCAHD/
YHAKAGRwXC8FX1NCX1BDSTBQSUJfRUMwX0JBTktmcAoGXC8FX1NCX1BDSTBQSUJfRUMwX0JBTkug
QAZ7XC8FX1NCX1BDSTBQSUJfRUMwX0JBVEQLAAwAoBx7XC8FX1NCX1BDSTBQSUJfRUMwX0JBVEQK
IAChJKAie1wvBV9TQl9QQ0kwUElCX0VDMF9CQVRECwACAH0KAmRkoSSgIntcLwVfU0JfUENJMFBJ
Ql9FQzBfQkFURAsAAgB9CgFkZHBmXC8FX1NCX1BDSTBQSUJfRUMwX0JBTkugGpKTZIOIUEJTVAoA
AHBkiFBCU1QKAABw/2BbJ1wvBV9TQl9QQ0kwUElCX0VDMF9NVVQwpGAUQwZIVkJJAHALUJaIUEJJ
RgoBAHALUJaIUEJJRgoCAHAL0DmIUEJJRgoEAHANUENHQS1CUDcxAIhQQklGCgkAcA1MSU9OAIhQ
QklGCgsAcA1Tb255IENvcnAuAIhQQklGCgwAFEgGSVZCSQBwC+kBVUJJRnAKBYhQQklGCgEAcAoF
iFBCSUYKAgBwCgWIUEJJRgoEAHANQmFkAIhQQklGCgkAcA1CYWQAiFBCSUYKCgBwDUJhZACIUEJJ
RgoLAHANQmFkAIhQQklGCgwAFDNJVkJTAHAKAIhQQlNUCgAAcAoFiFBCU1QKAQBwCgWIUEJTVAoC
AHALECeIUEJTVAoDABREB0NIQlABcABgcFZUT0J0X1VJRAoBAGF9eWEKDAAL/w9icABjoDJ7aGEA
oAlCUF9fVVBCU6EioA2TYn1jC/8PAFVQQklVUEJTcAoBQlBfX3AL6QFVQklGoRugGUJQX19wCgBC
UF9fSVZCSUlWQlN9CgRgYFuCKkxJRF8IX0hJRAxB0AwNFBpfTElEAKRcLwRfU0JfUENJMFBJQl9M
UE9MWwFTTVVUABQ7R1NNSQFbI1NNVVT//3BoXC8DX1NCX1BDSTBBUE1EcArjXC8EX1NCX1BDSTBQ
SUJfQVBNQ1snU01VVA==
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=fadt
Content-Transfer-Encoding: base64
Content-Description: fadt

RkFDUPQAAAABY1NPTlkgIEs1ICAgICAgAAAEBlBUTF9AQg8AwP/vD8Ca7w8AAAkAL4AAAPDx8gAA
gAAAAAAAAASAAAAAAAAAAAAAAAiAAAAggAAAAAAAAAQCAAQEAAAAWgBMBAAAAAAABH1+MgEAAKUB
AAAAAAAAAAAAAAAAAAAAAAAAwP/vDwAAAADAmu8PAAAAAAEgAAAAgAAAAAAAAAEgAAAAAAAAAAAA
AAEQAAAEgAAAAAAAAAEQAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEgAAAIgAAAAAAAAAEgAAAggAAA
AAAAAAEAAAAAAAAAAAAAAA==
--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
