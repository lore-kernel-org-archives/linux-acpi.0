From: Andreas Zoglauer <andi-UNdit3cmHfQ@public.gmane.org>
Subject: Re: Fw: 2.6.11.4: ACPI, IRQ 11 disabled, Ethernet/USB stops
 working
Date: Thu, 24 Mar 2005 12:09:39 -0800
Message-ID: <42431E83.1090009@zogi.de>
References: <20050323023629.5723f9bc.akpm@osdl.org> <1111689690.24547.31.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111689690.24547.31.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel-UNdit3cmHfQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi Bjorn,

The patch didn't do the job... The
 > irq 11: nobody cared!
is still in the boot message and ethernet and USB stop working...

Looking at my lspci, I probably have no VIA chips in my Notebook.

More ideas?
Thanks,
Andreas

lspci:

0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corp. Mobile Graphics 
Controller (rev 03)
0000:00:02.1 Display controller: Intel Corp. Mobile Graphics Controller 
(rev 03)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 1 (rev 04)
0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 2 (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corp. 
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
AC'97 Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface 
Bridge (rev 04)
0000:00:1f.2 IDE interface: Intel Corp. 82801FBM (ICH6M) SATA Controller 
(rev 04)
0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown 
device 4351 (rev 10)
0000:05:04.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:05:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:05:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032
0000:05:06.3 Unknown mass storage controller: Texas Instruments: Unknown 
device 8033
0000:05:06.4 Class 0805: Texas Instruments: Unknown device 8034

boot.msg:

Inspecting /boot/System.map-2.6.11.4
Loaded 24627 symbols from /boot/System.map-2.6.11.4.
Symbols match kernel version 2.6.11.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.6.11.4 (root@thetis) (gcc-Version 3.3.4 (pre 3.3.5 
20040809)) #1 Thu Mar 24 11:39:53 PST 2005
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001f7dfffc (usable)
<4> BIOS-e820: 000000001f7dfffc - 000000001f7fffc0 (ACPI data)
<4> BIOS-e820: 000000001f7fffc0 - 000000001f800000 (ACPI NVS)
<4> BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>503MB LOWMEM available.
<7>On node 0 totalpages: 128991
<7>  DMA zone: 4096 pages, LIFO batch:1
<7>  Normal zone: 124895 pages, LIFO batch:16
<7>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI 2.3 present.
<7>ACPI: RSDP (v000 INSYDE                                ) @ 0x000e5010
<7>ACPI: RSDT (v001 INSYDE RSDT_000 0x00000100 ABCD 0x00010200) @ 0x1f7f8769
<7>ACPI: FADT (v001 INSYDE FACP_000 0x00000100 0000 0x00010200) @ 0x1f7ffb30
<7>ACPI: MCFG (v001 INSYDE MCFG_000 0x30303030 0000 0x30303030) @ 0x1f7ffbc0
<7>ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x1f7f8975
<7>ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x1f7f879d
<7>ACPI: DSDT (v001 TOSINV SONOMA   0x00001004 INTL 0x02002036) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0x1008
<4>Allocating PCI resources starting at 1f800000 (gap: 1f800000:e0700000)
<4>Built 1 zonelists
<4>Kernel command line: root=/dev/sda7 vga=791 selinux=0 
resume2=/dev/sda6 desktop elevator=as splash=silent
<4>Local APIC disabled by BIOS -- you can enable it with "lapic"
<7>mapped APIC to ffffd000 (013f2000)
<6>Initializing CPU#0
<4>PID hash table entries: 2048 (order: 11, 32768 bytes)
<4>Detected 1596.579 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>Memory: 506032k/515964k available (2358k kernel code, 9380k reserved, 
778k data, 232k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
<7>Calibrating delay loop... 3153.92 BogoMIPS (lpj=1576960)
<6>Security Framework v1.0.0 initialized
<6>SELinux:  Disabled at boot.
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU: After generic identify, caps: afe9f9ff 00000000 00000000 
00000000 00000180 00000000 00000000
<7>CPU: After vendor identify, caps: afe9f9ff 00000000 00000000 00000000 
00000180 00000000 00000000
<6>CPU: L1 I cache: 32K, L1 D cache: 32K
<6>CPU: L2 cache: 2048K
<7>CPU: After all inits, caps: afe9f9ff 00000000 00000000 00000040 
00000180 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4> tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully 
acquired
<4>Parsing all Control 
Methods:...................................................................................................................................................................................................................................................
<4>Table [DSDT](id F006) - 889 Objects with 69 Devices 243 Methods 29 
Regions
<4>Parsing all Control Methods:...
<4>Table [SSDT](id F003) - 5 Objects with 0 Devices 3 Methods 0 Regions
<4>Parsing all Control Methods:.
<4>Table [SSDT](id F004) - 1 Objects with 0 Devices 1 Methods 0 Regions
<4>ACPI Namespace successfully loaded at root c048bf00
<4>ACPI: setting ELCR to 0200 (from 0c20)
<4>evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode 
successful
<6>checking if image is initramfs...it isn't (no cpio magic); looks like 
an initrd
<6>Freeing initrd memory: 1144k freed
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xea7e4, last bus=5
<6>PCI: Using MMCONFIG
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20050211
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4> exutils-0216 [21] ex_acquire_global_lock: Could not acquire Global 
Lock, AE_NO_GLOBAL_LOCK
<4>evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs 
on int 0x9
<4>evgpeblk-0987 [06] ev_create_gpe_block   : Found 8 Wake, Enabled 4 
Runtime GPEs in this block
<4>Completing Region/Field/Buffer/Package 
initialization:.........................................................................................
<4>Initialized 28/29 Regions 0/0 Fields 39/39 Buffers 22/34 Packages 
(904 nodes)
<4>Executing all Device _STA and_INI 
methods:...........................................................................
<4>75 Devices found containing: 75 _STA, 1 _INI methods
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *11)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *11)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *5 11)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 5 10) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 6) *11
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10) *11
<6>ACPI: Embedded Controller [EC0] (gpe 16)
<6>ACPI: Power Resource [PFA1] (off)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>pnp: PnP ACPI init
<6>pnp: PnP ACPI: found 9 devices
<6>PCI: Using ACPI for IRQ routing
<6>** PCI interrupts are no longer routed automatically.  If this
<6>** causes a device to stop working, it is probably because the
<6>** driver failed to call pci_enable_device().  As a temporary
<6>** workaround, the "pci=routeirq" argument restores the old
<6>** behavior.  If this argument makes the device work again,
<6>** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
<6>** so I can fix the driver.
<3>PCI: Cannot allocate resource region 0 of device 0000:05:06.0
<4>TC classifier action (bugs to netdev-VZNHf3L845pBDgjK7y7TUQ@public.gmane.org cc hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org)
<6>apm: BIOS not found.
<6>audit: initializing netlink socket (disabled)
<3>audit(1111665062.963:0): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
<4>PCI: setting IRQ 10 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1c.0[A] -> GSI 10 (level, low) -> IRQ 10
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>Allocate Port Service[pcie02]
<7>Allocate Port Service[pcie03]
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
<4>PCI: setting IRQ 11 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1c.1[B] -> GSI 11 (level, low) -> IRQ 11
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[pcie00]
<7>Allocate Port Service[pcie02]
<7>Allocate Port Service[pcie03]
<6>vesafb: framebuffer at 0xa0000000, mapped to 0xe0080000, using 3072k, 
total 7872k
<6>vesafb: mode is 1024x768x16, linelength=2048, pages=4
<6>vesafb: protected mode interface info at 00ff:44f0
<6>vesafb: scrolling: redraw
<6>vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
<4>Console: switching to colour frame buffer device 128x48
<6>fb0: VESA VGA frame buffer device
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Real Time Clock Driver v1.12
<6>i8042.c: Detected active multiplexing controller, rev 1.1.
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
<4>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
<4>PCI: setting IRQ 5 as level-triggered
<6>ACPI: PCI interrupt 0000:00:1e.3[B] -> GSI 5 (level, low) -> IRQ 5
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<4>floppy0: no floppy controllers found
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<3>ide0: I/O resource 0x1F0-0x1F7 not free.
<3>ide0: ports already in use, skipping probe
<7>Probing IDE interface ide1...
<4>hdc: MATSHITADVD-RAM UJ-830S, ATAPI CD/DVD-ROM drive
<7>Probing IDE interface ide2...
<7>Probing IDE interface ide3...
<7>Probing IDE interface ide4...
<7>Probing IDE interface ide5...
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide-floppy driver 0.99.newide
<6>mice: PS/2 mouse device common for all mice
<6>input: AT Translated Set 2 keyboard on isa0060/serio0
<6>Synaptics Touchpad, model: 1
<6> Firmware: 5.9
<6> 180 degree mounted touchpad
<6> Sensor: 37
<6> new absolute packet format
<6> Touchpad has extended capability bits
<6> -> multifinger detection
<6> -> palm detection
<6>input: SynPS/2 Synaptics TouchPad on isa0060/serio1
<6>input: PC Speaker
<6>md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>NET: Registered protocol family 2
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes
<4>TCP established hash table entries: 16384 (order: 5, 131072 bytes)
<4>TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
<6>TCP: Hash tables configured (established 16384 bind 16384)
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 8
<6>NET: Registered protocol family 20
<7>PM: Reading swsusp image.
<7>PM: Resume from disk failed.
<4>ACPI wakeup devices:
<4>LID0 RP01 RP02 RP03 RP04 USB1 USB2 USB3 USB4 USB7 MODM PS2K
<6>ACPI: (supports S0 S3 S4 S5)
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<5>RAMDISK: Compressed image found at block 0
<4>VFS: Mounted root (ext2 filesystem).
<5>SCSI subsystem initialized
<7>libata version 1.10 loaded.
<7>ata_piix version 1.03
<4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
<6>ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 11 (level, low) -> IRQ 11
<4>ata: 0x170 IDE port busy
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1100 irq 14
<7>ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3468 86:1a09 
87:4003 88:203f
<6>ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
<6>ata1: dev 0 configured for UDMA/100
<6>scsi0 : ata_piix
<5>  Vendor: ATA       Model: FUJITSU MHT2080A  Rev: 0022
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 < sda5 sda6 sda7 > sda4
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<5>ReiserFS: sda7: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sda7: using ordered data mode
<5>ReiserFS: sda7: journal params: device sda7, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
<5>ReiserFS: sda7: checking transaction log (sda7)
<5>ReiserFS: sda7: Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<5>Trying to move old root to /initrd ... failed
<5>Unmounting old root
<5>Trying to free ramdisk memory ... failed
<6>Freeing unused kernel memory: 232k freed
<4>lt_modem: module license 'Proprietary' taints kernel.
<6>Loading Agere/Lucent WinModem Controller driver version 8.31
<3>agrserial - No device detected
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
<4>sk98lin: Network Device Driver v8.15.1.3
<4>(C)Copyright 1999-2005 Marvell(R).
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
<7>PCI: Setting latency timer of device 0000:01:00.0 to 64
<4>eth0: Marvell Yukon 88E8036 Fast Ethernet Controller
<4>      PrefPort:A  RlmtMode:Check Link State
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
<6>NTFS driver 2.1.22 [Flags: R/O MODULE].
<6>Linux agpgart interface v0.100 (c) Dave Jones
<6>USB Universal Host Controller Interface driver v2.2
<4>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
<6>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<6>NTFS volume version 3.1.
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: irq 10, io base 0x1200
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: irq 11, io base 0x1220
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
<6>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: irq 11, io base 0x1240
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>ACPI: PCI interrupt 0000:00:1d.3[D] -> GSI 11 (level, low) -> IRQ 11
<6>uhci_hcd 0000:00:1d.3: UHCI Host Controller
<6>usb 1-1: new low speed USB device using uhci_hcd and address 2
<7>PCI: Setting latency timer of device 0000:00:1d.3 to 64
<6>uhci_hcd 0000:00:1d.3: irq 11, io base 0x1260
<6>uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 2 ports detected
<6>agpgart: Detected an Intel 915GM Chipset.
<6>agpgart: Maximum main memory to use for agp memory: 431M
<6>agpgart: Detected 7932K stolen memory.
<6>agpgart: AGP aperture is 256M @ 0xa0000000
<4>PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
<6>ACPI: PCI interrupt 0000:00:1d.7[A] -> GSI 10 (level, low) -> IRQ 10
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: irq 10, pci mem 0xf4000000
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
<7>PCI: cache line size of 32 is not supported by device 0000:00:1d.7
<6>ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
<6>hub 5-0:1.0: USB hub found
<6>hub 5-0:1.0: 8 ports detected
<6>usb 1-1: USB disconnect, address 2
<7>ieee1394: Initialized config rom entry `ip1394'
<6>usb 1-1: new low speed USB device using uhci_hcd and address 3
<6>ohci1394: $Rev: 1223 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
<4>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 6
<4>PCI: setting IRQ 6 as level-triggered
<6>ACPI: PCI interrupt 0000:05:06.2[C] -> GSI 6 (level, low) -> IRQ 6
<6>ohci1394: fw-host0: Remapped memory spaces reg 0xe0644000
<6>ohci1394: fw-host0: Soft reset finished
<6>ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
<6>ohci1394: fw-host0: 4 iso receive contexts available
<6>ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
<6>ohci1394: fw-host0: 8 iso transmit contexts available
<6>ohci1394: fw-host0: Receive DMA ctx=0 initialized
<6>ohci1394: fw-host0: Receive DMA ctx=0 initialized
<6>ohci1394: fw-host0: Transmit DMA ctx=0 initialized
<6>ohci1394: fw-host0: Transmit DMA ctx=1 initialized
<6>ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[6] 
MMIO=[b8000000-b80007ff]  Max Packet=[2048]
<7>ieee1394: CSR: setting expire to 98, HZ=1000
<3>irq 11: nobody cared!
<4> [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
<4> [note_interrupt+123/160] note_interrupt+0x7b/0xa0
<4> [__do_IRQ+251/272] __do_IRQ+0xfb/0x110
<4> [do_IRQ+54/112] do_IRQ+0x36/0x70
<4> [common_interrupt+26/32] common_interrupt+0x1a/0x20
<4> [handle_IRQ_event+41/112] handle_IRQ_event+0x29/0x70
<4> [__do_IRQ+167/272] __do_IRQ+0xa7/0x110
<4> [do_IRQ+54/112] do_IRQ+0x36/0x70
<4> [common_interrupt+26/32] common_interrupt+0x1a/0x20
<4> [pg0+538611965/1068864512] set_phy_reg+0x5d/0xa0 [ohci1394]
<4> [kmem_freepages+1/160] kmem_freepages+0x1/0xa0
<4> [pg0+538617216/1068864512] ohci_devctl+0x4c0/0x660 [ohci1394]
<4> [pg0+537967380/1068864512] csr1212_fill_cache+0xd4/0x110 [ieee1394]
<4> [pg0+537967910/1068864512] csr1212_generate_csr_image+0x1d6/0x210 
[ieee1394]
<4> [pg0+537924080/1068864512] hpsb_reset_bus+0x20/0x30 [ieee1394]
<4> [worker_thread+386/544] worker_thread+0x182/0x220
<4> [activate_task+92/112] activate_task+0x5c/0x70
<4> [pg0+537934448/1068864512] delayed_reset_bus+0x0/0xc0 [ieee1394]
<4> [default_wake_function+0/16] default_wake_function+0x0/0x10
<4> [__wake_up_common+55/112] __wake_up_common+0x37/0x70
<4> [default_wake_function+0/16] default_wake_function+0x0/0x10
<4> [worker_thread+0/544] worker_thread+0x0/0x220
<4> [kthread+150/224] kthread+0x96/0xe0
<4> [kthread+0/224] kthread+0x0/0xe0
<4> [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
<3>handlers:
<3>[pg0+537513408/1068864512] (SkY2Isr+0x0/0x1f0 [sk98lin])
<3>[pg0+536503456/1068864512] (usb_hcd_irq+0x0/0x70 [usbcore])
<3>[pg0+536503456/1068864512] (usb_hcd_irq+0x0/0x70 [usbcore])
<3>[pg0+536503456/1068864512] (usb_hcd_irq+0x0/0x70 [usbcore])
<0>Disabling IRQ #11
<6>ohci1394: fw-host0: IntEvent: 00030010
<6>ohci1394: fw-host0: irq_handler: Bus reset requested
<6>ohci1394: fw-host0: Cancel request received
<6>ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
<6>ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
<6>ohci1394: fw-host0: SelfID packet 0x807f8852 received
<7>ieee1394: Including SelfID 0x52887f80
<6>ohci1394: fw-host0: SelfID for this node is 0x807f8852
<6>ohci1394: fw-host0: SelfID complete
<6>ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
<7>ieee1394: selfid_complete called with successful SelfID stage ... 
irm_id: 0xFFC0 node_id: 0xFFC0
<7>ieee1394: NodeMgr: Processing host reset for knodemgrd_0
<6>ohci1394: fw-host0: Single packet rcv'd
<7>ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
<6>Linux Kernel Card Services
<6>  options:  [pci] [cardbus] [pm]
<6>ACPI: PCI interrupt 0000:05:06.0[A] -> GSI 11 (level, low) -> IRQ 11
<6>Yenta: CardBus bridge found at 0000:05:06.0 [1179:ff10]
<6>Yenta: ISA IRQ mask 0x0098, PCI irq 11
<6>Socket status: 30000810
<7>ieee1394: send packet local: ffc00140 ffc0ffff f0000400
<7>ieee1394: received packet: ffc00140 ffc0ffff f0000400
<7>ieee1394: send packet local: ffc00160 ffc00000 00000000 1de30404
<7>ieee1394: received packet: ffc00160 ffc00000 00000000 1de30404
<7>ieee1394: send packet local: ffc00540 ffc0ffff f0000404
<7>ieee1394: received packet: ffc00540 ffc0ffff f0000404
<7>ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
<7>ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
<7>ieee1394: send packet local: ffc00940 ffc0ffff f0000408
<7>ieee1394: received packet: ffc00940 ffc0ffff f0000408
<7>ieee1394: send packet local: ffc00960 ffc00000 00000000 32a264e0
<7>ieee1394: received packet: ffc00960 ffc00000 00000000 32a264e0
<7>ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
<7>ieee1394: received packet: ffc00d40 ffc0ffff f000040c
<7>ieee1394: send packet local: ffc00d60 ffc00000 00000000 a00d0800
<7>ieee1394: received packet: ffc00d60 ffc00000 00000000 a00d0800
<7>ieee1394: send packet local: ffc01140 ffc0ffff f0000410
<7>ieee1394: received packet: ffc01140 ffc0ffff f0000410
<7>ieee1394: send packet local: ffc01160 ffc00000 00000000 51a8bcd1
<7>ieee1394: received packet: ffc01160 ffc00000 00000000 51a8bcd1
<7>ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
<7>ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
<7>ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
<7>ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
<7>ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 
cyc_clk_acc=100 max_rec=2048 max_rom=1024 gen=3 lspd=2
<7>ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0d1bca851]
<7>ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
<6>ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, 
tcode=0x0, speed=0
<6>ohci1394: fw-host0: Starting transmit DMA ctx=0
<6>ohci1394: fw-host0: IntEvent: 00000001
<6>ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
<6>ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0x00 
ack=0x11 spd=0 data=0x1F0000C0 ctx=0
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Thu Mar 24 11:51:52 2005

Master Resource Control: previous runlevel: N, switching to runlevel: 5
<notice>start services (random pcmcia isdn SuSEfirewall2_init)
Initializing random number generatordone
Starting PCMCIA <notice>startproc: execve (/sbin/cardmgr) [ 
/sbin/cardmgr ], [ resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux 
SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/sbin/cardmgr ]
cardmgr[5136]: socket 0: ATA/IDE Fixed Disk

done
Starting Firewall Initialization (phase 1 of 3) cardmgr[5136]: 
executing: 'modprobe ide-cs 2>&1'

cardmgr[5136]: + FATAL: Module ide_cs not found.

cardmgr[5136]: modprobe exited with status 1

cardmgr[5136]: module /lib/modules/2.6.11.4/pcmcia/ide-cs.o not available

cardmgr[5136]: bind 'ide-cs' to socket 0 failed: Invalid argument

done
<notice>exit status of (random pcmcia isdn SuSEfirewall2_init) is (0 0 0 0)
<notice>start services (network)
Setting up network interfaces:
     lo
     lo        IP address: 127.0.0.1/8
done    eth0      device: Marvell Technology Group Ltd.: Unknown device 
4351 (rev 10)
     eth0      configuration: eth-id-00:a0:d1:bc:a8:51
     eth0      IP address: 128.32.13.12/24
doneWaiting for mandatory devices:  wlan-bus-pci-0000:05:04.0
19 18 17 15 14 13 12 11 10 8 7 6 5 4 3 2 0
     wlan-bus-pci-0000:05:04.0           No interface found
failed    modem0
     modem0    Startmode is 'manual'
skippedSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  . 
  .  .  .failed
<notice>exit status of (network) is (7)
<notice>start services (syslog)
Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ 
/sbin/syslogd -a /var/lib/ntp/dev/log ], [ resume2=/dev/sda6 
CONSOLE=/dev/console TERM=linux SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 
REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/sbin/syslogd ]
<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 -x ], [ 
resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux SHELL=/bin/sh 
INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/sbin/klogd ]
done
Starting Firewall Initialization (phase 2 of 3) <notice>exit status of 
(syslog) is (0)
<notice>start services (SuSEfirewall2_setup)
SuSEfirewall2: Warning: ip6tables does not support state matching. 
Extended IPv6 support disabled.
SuSEfirewall2: Firewall rules successfully set from 
/etc/sysconfig/SuSEfirewall2
done
<notice>exit status of (SuSEfirewall2_setup) is (0)
<notice>start services (splash_early resmgr portmap fnfxd)
Starting resource manager<notice>startproc: execve (/sbin/resmgrd) [ 
/sbin/resmgrd ], [ resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux 
SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/sbin/resmgrd ]
done
Starting RPC portmap daemon<notice>startproc: execve (/sbin/portmap) [ 
/sbin/portmap ], [ resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux 
SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/sbin/portmap ]
done
Starting fnfxd ...()...missing /proc/acpi/toshibaskipped
<notice>exit status of (splash_early resmgr portmap fnfxd) is (0 0 0 5)
<notice>start services (nfsboot nfs)
Starting nfsboot (sm-notify) done
Importing Net File System (NFS)unused
<notice>exit status of (nfsboot nfs) is (0 6)
<notice>start services (sshd smpppd running-kernel fbset alsasound)
Starting SSH daemon<notice>startproc: execve (/usr/sbin/sshd) [ 
/usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid ], [ resume2=/dev/sda6 
CONSOLE=/dev/console TERM=linux SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 
REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/sshd ]
done
<notice>startproc: execve (/usr/sbin/smpppd) [ /usr/sbin/smpppd ], [ 
resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux SHELL=/bin/sh 
INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/smpppd ]
Starting SMPPPDdone
Starting sound driver:  intel8x0done
Restoring the previous sound settingdone
<notice>exit status of (sshd smpppd running-kernel fbset alsasound) is 
(0 0 0 0 0)
<notice>start services (splash powersaved kbd cups)
loading ACPI modules (ac battery button fan processor thermal ) done
Starting powersaved  (accessing ACPI events over acpid) 
<notice>startproc: execve (/usr/sbin/powersaved) [ /usr/sbin/powersaved 
-d -x /usr/lib/powersave/scripts -a resmgr -v 3 ], [ resume2=/dev/sda6 
CONSOLE=/dev/console TERM=linux SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 
REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/powersaved ]
done
Loading keymap qwerty/us.map.gz
doneLoading compose table winkeys shiftctrl latin1.adddone
Start Unicode mode
doneLoading console font lat9w-16.psfu  -m trivial \033(K
doneStarting cupsd<notice>startproc: execve (/usr/sbin/cupsd) [ 
/usr/sbin/cupsd ], [ resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux 
SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/cupsd ]
done
<notice>exit status of (splash powersaved kbd cups) is (5 0 0 0)
<notice>start services (xdm postfix nscd hwscan)
Starting service kdm<notice>startproc: execve (/opt/kde3/bin/kdm) [ 
/opt/kde3/bin/kdm ], [ resume2=/dev/sda6 LC_MONETARY= 
CONSOLE=/dev/console TERM=linux SHELL=/bin/sh LC_NUMERIC= 
QTDIR=/usr/lib/qt3 LC_ALL= INIT_VERSION=sysvinit-2.85 
KDEROOTHOME=/root/.kdm REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin LC_MESSAGES= vga=791 
RUNLEVEL=5 LC_COLLATE= PWD=/ SPLASHCFG= LANG=de_DE.UTF-8 elevator=as 
PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 XCURSOR_THEME=crystalwhite 
WINDOWMANAGER=/usr/X11R6/bin/kde LC_CTYPE=de_DE.UTF-8 splash=silent 
SPLASH=no LC_TIME= _=/sbin/startproc DAEMON=/opt/kde3/bin/kdm ]
done
Starting mail service (Postfix)done
Starting Name Service Cache Daemon<notice>startproc: execve 
(/usr/sbin/nscd) [ /usr/sbin/nscd ], [ resume2=/dev/sda6 
CONSOLE=/dev/console TERM=linux SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 
REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/nscd ]
done
Starting hardware scan on boot<notice>exit status of (xdm postfix nscd 
hwscan) is (0 0 0 0)
<notice>start services (smbfs cron)
Mount SMB/ CIFS File Systems unused
Starting CRON daemon<notice>startproc: execve (/usr/sbin/cron) [ 
/usr/sbin/cron ], [ resume2=/dev/sda6 CONSOLE=/dev/console TERM=linux 
SHELL=/bin/sh INIT_VERSION=sysvinit-2.85 REDIRECT=/dev/tty1 COLUMNS=128 
PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin vga=791 RUNLEVEL=5 
PWD=/ SPLASHCFG= elevator=as PREVLEVEL=N LINES=48 HOME=/ SHLVL=2 
splash=silent SPLASH=no _=/sbin/startproc DAEMON=/usr/sbin/cron ]
done
<notice>exit status of (smbfs cron) is (6 0)
<notice>start services (SuSEfirewall2_final)
Starting Firewall Initialization (phase 3 of 3) SuSEfirewall2: Warning: 
ip6tables does not support state matching. Extended IPv6 support disabled.
SuSEfirewall2: Firewall rules successfully set from 
/etc/sysconfig/SuSEfirewall2
done
Master Resource Control: runlevel 5 has been reached
Failed services in runlevel 5: network
Skipped services in runlevel 5: fnfxd nfs splash smbfs
<notice>exit status of (SuSEfirewall2_final) is (0)
<notice>killproc: kill(5074,3)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
