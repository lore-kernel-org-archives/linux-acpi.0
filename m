From: Rob <v.g@chello.nl>
Subject: acpi_osi=!Linux
Date: Sat, 05 Jan 2008 15:38:48 +0100
Message-ID: <1199543928.7835.9.camel@laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-b0GXBlJZ8UkZ5QGHDbQO"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:3657 "EHLO
	viefep14-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752862AbYAEOio (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 09:38:44 -0500
Received: from [192.168.253.53] (really [62.195.165.131])
          by viefep14-int.chello.at
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20080105143840.YKNP23496.viefep14-int.chello.at@[192.168.253.53]>
          for <linux-acpi@vger.kernel.org>; Sat, 5 Jan 2008 15:38:40 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-b0GXBlJZ8UkZ5QGHDbQO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

As requested in DMESG I tested adding acpi_osi=!Linux to my grub
bootparams.

I don't see it working, it even asks to add the already added param to
bootparams: 
"[    0.448000] ACPI: System BIOS is requesting _OSI(Linux)
[    0.448000] ACPI: Please test with "acpi_osi=!Linux"
[    0.448000] Please send dmidecode to linux-acpi@vger.kernel.org"

I don't know what dmidecode is, so I send you my dmesg.

Do I do something wrong? Do I need to replace some of the other
parameters? My laptop did not boot without noapic, irqpoll could maybe
be replaced, this was the first succesfull working combination...

I just added acpi_osi=!Linux to grup startup command like:
[    0.000000] Kernel command line:
root=UUID=28d159a3-ae3c-4743-8b24-1eba7f0181a4 ro quiet splash
locale=nl_NL noapic irqpoll nosmp acpi_osi=!Linux

I can send you more information if you tell me the right commands I need
to type in the terminal... Yes I'm a Linux newbie.

My hardware:
HP Pavilion dv6361eu:
AMD Turion 64 X2 mobile TL-56
2 GB memory
nVidia Corporation GeForce Go 7200 rev 161 256 MB (shared)
MCP51 Serial ATA Controller (Presario V6133CL)
Hitachi HTS 54161 160 GB HDD
Microsoft Natural Ergonomic Keyboard 4000 (yes, M$ works together with
Ubuntu LOL) USB
Typhoon 3 button mouse USB

VideoDriver:
NVidea 169.07 (1200x800@50 TFT) (Gutsy)

--=-b0GXBlJZ8UkZ5QGHDbQO
Content-Disposition: attachment; filename=dmesg050107-2
Content-Type: text/plain; name=dmesg050107-2; charset=UTF-8
Content-Transfer-Encoding: 8bit

[    0.000000] Linux version 2.6.22-14-generic (buildd@terranova) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Tue Dec 18 08:02:57 UTC 2007 (Ubuntu 2.6.22-14.47-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff00000 (usable)
[    0.000000]  BIOS-e820: 000000007ff00000 - 000000007ff15000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff15000 - 000000007ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 1151MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f8920
[    0.000000] Entering add_active_range(0, 0, 524032) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   524032
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   524032
[    0.000000] On node 0 totalpages: 524032
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2302 pages used for memmap
[    0.000000]   HighMem zone: 292354 pages, LIFO batch:31
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP signature @ 0xC00F88F0 checksum 0
[    0.000000] ACPI: RSDP 000F88F0, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 7FF0BB67, 0040 (r1 HPQOEM SLIC-MPC  6040000  LTP        0)
[    0.000000] ACPI: FACP 7FF14B58, 0074 (r1 HP     MCP51M    6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 7FF0BBA7, 8FB1 (r1 HP       MCP51M  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 7FF15FC0, 0040
[    0.000000] ACPI: SSDT 7FF14BCC, 01C4 (r1 PTLTD  POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: MCFG 7FF14D90, 003C (r1 HP       MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 7FF14DCC, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 7FF14E04, 005E (r1 HP     	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 7FF14E62, 0028 (r1     HP $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: SLIC 7FF14E8A, 0176 (r1 HPQOEM SLIC-MPC  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: Skipping IOAPIC probe due to 'noapic' option.
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI for processor (LAPIC) configuration information
[    0.000000] Intel MultiProcessor Specification v1.4
[    0.000000]     Virtual Wire compatibility mode.
[    0.000000] OEM ID: nVIDIA   Product ID: C51-MCP51    APIC at: 0xFEE00000
[    0.000000] I/O APIC #2 Version 17 at 0xFEC00000.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Processors: 2
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] Built 1 zonelists.  Total pages: 519938
[    0.000000] Kernel command line: root=UUID=28d159a3-ae3c-4743-8b24-1eba7f0181a4 ro quiet splash locale=nl_NL noapic irqpoll nosmp acpi_osi=!Linux
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance
[    0.000000] ACPI: Disabled _OSI(Linux)
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1808.387 MHz processor.
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2066708k/2096128k available (2015k kernel code, 28224k reserved, 916k data, 364k init, 1178624k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[    0.000000]       .init : 0xc03e3000 - 0xc043e000   ( 364 kB)
[    0.000000]       .data : 0xc02f7de6 - 0xc03dce84   ( 916 kB)
[    0.000000]       .text : 0xc0100000 - 0xc02f7de6   (2015 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
[    0.000000] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[    0.000000] hpet0: 3 32-bit timers, 25000000 Hz
[    0.080000] Calibrating delay using timer specific routine.. 3626.03 BogoMIPS (lpj=7252060)
[    0.080000] Security Framework v1.0.0 initialized
[    0.080000] SELinux:  Disabled at boot.
[    0.080000] Mount-cache hash table entries: 512
[    0.080000] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[    0.080000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.080000] CPU: L2 Cache: 512K (64 bytes/line)
[    0.080000] CPU 0(2) -> Core 0
[    0.080000] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[    0.080000] Compat vDSO mapped to ffffe000.
[    0.080000] Checking 'hlt' instruction... OK.
[    0.096000] SMP alternatives: switching to UP code
[    0.096000] Early unpacking initramfs... done
[    0.416000] ACPI: Core revision 20070126
[    0.416000] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[    0.420000] ACPI: setting ELCR to 0200 (from 0ca0)
[    0.424000] CPU0: AMD Turion(tm) 64 X2 Mobile Technology TL-56 stepping 02
[    0.424000] SMP mode deactivated, forcing use of dummy APIC emulation.
[    0.424000] Brought up 1 CPUs
[    0.424000] Booting paravirtualized kernel on bare hardware
[    0.424000] Time: 15:02:12  Date: 00/05/108
[    0.424000] NET: Registered protocol family 16
[    0.424000] EISA bus registered
[    0.424000] ACPI: bus type pci registered
[    0.444000] PCI: BIOS BUG #81[49435000] found
[    0.444000] PCI: Using configuration type 1
[    0.444000] Setting up standard PCI resources
[    0.444000] ACPI: EC: Look up EC in DSDT
[    0.444000] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[    0.448000] ACPI: System BIOS is requesting _OSI(Linux)
[    0.448000] ACPI: Please test with "acpi_osi=!Linux"
[    0.448000] Please send dmidecode to linux-acpi@vger.kernel.org
[    0.448000] ACPI: Interpreter enabled
[    0.448000] ACPI: (supports S0 S3 S4 S5)
[    0.448000] ACPI: Using PIC for interrupt routing
[    0.456000] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[    0.456000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.456000] PCI: Probing PCI hardware (bus 00)
[    0.456000] PCI: Transparent bridge - 0000:00:10.0
[    0.456000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.456000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[    0.456000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.456000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[    0.456000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[    0.488000] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.488000] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 *11 14 15)
[    0.488000] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
[    0.488000] ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LK1E] (IRQs 5 7 9 10 *11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LK2E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LK3E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LK4E] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 *10 11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LUS0] (IRQs 5 7 9 10 *11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LUS2] (IRQs 5 *7 9 10 11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LPID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
[    0.492000] ACPI: PCI Interrupt Link [LTID] (IRQs *5 7 9 10 11 14 15)
[    0.492000] ACPI: PCI Interrupt Link [LSI1] (IRQs 5 7 9 *10 11 14 15)
[    0.492000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.492000] pnp: PnP ACPI init
[    0.492000] ACPI: bus type pnp registered
[    0.496000] pnp: PnP ACPI: found 13 devices
[    0.496000] ACPI: ACPI bus type pnp unregistered
[    0.496000] PnPBIOS: Disabled by ACPI PNP
[    0.496000] PCI: Using ACPI for IRQ routing
[    0.496000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.496000] NET: Registered protocol family 8
[    0.496000] NET: Registered protocol family 20
[    0.496000] pnp: 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.496000] pnp: 00:01: iomem range 0xffc00000-0xffffffff could not be reserved
[    0.496000] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.496000] pnp: 00:01: iomem range 0xfee00000-0xfeefffff could not be reserved
[    0.496000] pnp: 00:01: iomem range 0xfed00000-0xfed00fff has been reserved
[    0.496000] pnp: 00:03: iomem range 0xe0000000-0xefffffff could not be reserved
[    0.496000] pnp: 00:04: ioport range 0x1000-0x107f has been reserved
[    0.496000] pnp: 00:04: ioport range 0x1080-0x10ff has been reserved
[    0.496000] pnp: 00:04: ioport range 0x1400-0x147f has been reserved
[    0.496000] pnp: 00:04: ioport range 0x1480-0x14ff has been reserved
[    0.496000] pnp: 00:04: ioport range 0x1800-0x187f has been reserved
[    0.496000] pnp: 00:04: ioport range 0x1880-0x18ff has been reserved
[    0.496000] pnp: 00:04: ioport range 0x2000-0x203f has been reserved
[    0.500000] Time: hpet clocksource has been installed.
[    0.500000] Switched to high resolution mode on CPU 0
[    0.524000] PCI: Bridge: 0000:00:02.0
[    0.524000]   IO window: 4000-4fff
[    0.524000]   MEM window: c2000000-c3ffffff
[    0.524000]   PREFETCH window: c8200000-c83fffff
[    0.524000] PCI: Bridge: 0000:00:03.0
[    0.524000]   IO window: disabled.
[    0.524000]   MEM window: c4000000-c5ffffff
[    0.524000]   PREFETCH window: disabled.
[    0.524000] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
[    0.524000] PCI: Bridge: 0000:00:04.0
[    0.524000]   IO window: disabled.
[    0.524000]   MEM window: c6000000-c7ffffff
[    0.524000]   PREFETCH window: d0000000-dfffffff
[    0.524000] PCI: Bridge: 0000:00:10.0
[    0.524000]   IO window: disabled.
[    0.524000]   MEM window: c8000000-c80fffff
[    0.524000]   PREFETCH window: disabled.
[    0.524000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.524000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    0.524000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    0.524000] PCI: Setting latency timer of device 0000:00:10.0 to 64
[    0.524000] NET: Registered protocol family 2
[    0.564000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.564000] TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
[    0.564000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.564000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.564000] TCP reno registered
[    0.576000] checking if image is initramfs... it is
[    1.208000] Freeing initrd memory: 7100k freed
[    1.208000] Simple Boot Flag at 0x36 set to 0x1
[    1.212000] audit: initializing netlink socket (disabled)
[    1.212000] audit(1199545332.000:1): initialized
[    1.212000] highmem bounce pool size: 64 pages
[    1.212000] VFS: Disk quotas dquot_6.5.1
[    1.212000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.212000] io scheduler noop registered
[    1.212000] io scheduler anticipatory registered
[    1.212000] io scheduler deadline registered
[    1.212000] io scheduler cfq registered (default)
[    1.420000] Boot video device is 0000:05:00.0
[    1.420000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    1.420000] assign_interrupt_mode Found MSI capability
[    1.420000] Allocate Port Service[0000:00:02.0:pcie00]
[    1.420000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    1.420000] assign_interrupt_mode Found MSI capability
[    1.420000] Allocate Port Service[0000:00:03.0:pcie00]
[    1.420000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    1.420000] assign_interrupt_mode Found MSI capability
[    1.420000] Allocate Port Service[0000:00:04.0:pcie00]
[    1.420000] isapnp: Scanning for PnP cards...
[    1.772000] isapnp: No Plug & Play device found
[    1.796000] Real Time Clock Driver v1.12ac
[    1.796000] hpet_resources: 0xfed00000 is busy
[    1.796000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[    1.796000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    1.796000] input: Macintosh mouse button emulation as /class/input/input0
[    1.796000] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[    1.816000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.816000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.816000] mice: PS/2 mouse device common for all mice
[    1.816000] EISA: Probing bus 0 at eisa.0
[    1.816000] Cannot allocate resource for EISA slot 1
[    1.816000] Cannot allocate resource for EISA slot 2
[    1.816000] Cannot allocate resource for EISA slot 3
[    1.816000] Cannot allocate resource for EISA slot 4
[    1.816000] EISA: Detected 0 cards.
[    1.816000] TCP cubic registered
[    1.816000] NET: Registered protocol family 1
[    1.816000] Using IPI No-Shortcut mode
[    1.816000]   Magic number: 8:893:31
[    1.816000]   hash matches device ttyde
[    1.816000] Freeing unused kernel memory: 364k freed
[    1.856000] input: AT Translated Set 2 keyboard as /class/input/input1
[    3.044000] AppArmor: AppArmor initialized<5>audit(1199545334.000:2):  type=1505 info="AppArmor initialized" pid=1261
[    3.052000] fuse init (API version 7.8)
[    3.060000] Failure registering capabilities with primary security module.
[    3.080000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    3.080000] ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not present [20070126]
[    3.080000] ACPI: Thermal Zone [THRM] (49 C)
[    3.848000] usbcore: registered new interface driver usbfs
[    3.848000] usbcore: registered new interface driver hub
[    3.848000] usbcore: registered new device driver usb
[    3.848000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.848000] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
[    3.848000] PCI: setting IRQ 11 as level-triggered
[    3.848000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 11 (level, low) -> IRQ 11
[    3.848000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    3.848000] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    3.848000] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[    3.848000] ohci_hcd 0000:00:0b.0: irq 11, io mem 0xc0004000
[    3.884000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    3.884000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    3.896000] SCSI subsystem initialized
[    3.900000] libata version 2.21 loaded.
[    3.920000] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[    3.948000] usb usb1: configuration #1 chosen from 1 choice
[    3.948000] hub 1-0:1.0: USB hub found
[    3.948000] hub 1-0:1.0: 8 ports detected
[    4.052000] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 7
[    4.052000] PCI: setting IRQ 7 as level-triggered
[    4.052000] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 7 (level, low) -> IRQ 7
[    4.052000] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[    4.052000] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    4.052000] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[    4.052000] ehci_hcd 0000:00:0b.1: debug port 1
[    4.052000] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[    4.052000] ehci_hcd 0000:00:0b.1: irq 7, io mem 0xc0005000
[    4.052000] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    4.052000] usb usb2: configuration #1 chosen from 1 choice
[    4.052000] hub 2-0:1.0: USB hub found
[    4.052000] hub 2-0:1.0: 8 ports detected
[    4.156000] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[    4.156000] NFORCE-MCP51: chipset revision 241
[    4.156000] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    4.156000] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[    4.156000] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[    4.156000]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:DMA, hdb:pio
[    4.156000] Probing IDE interface ide0...
[    4.892000] hda: HL-DT-ST DVDRAM GSA-4084N, ATAPI CD/DVD-ROM drive
[    5.228000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.236000] sata_nv 0000:00:0e.0: version 3.4
[    5.236000] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[    5.236000] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 5
[    5.236000] PCI: setting IRQ 5 as level-triggered
[    5.236000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 5 (level, low) -> IRQ 5
[    5.236000] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    5.236000] scsi0 : sata_nv
[    5.236000] scsi1 : sata_nv
[    5.236000] ata1: SATA max UDMA/133 cmd 0x000130c0 ctl 0x000130b6 bmdma 0x00013090 irq 5
[    5.236000] ata2: SATA max UDMA/133 cmd 0x000130b8 ctl 0x000130b2 bmdma 0x00013098 irq 5
[    5.248000] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
[    5.248000] Uniform CD-ROM driver Revision: 3.20
[    5.444000] usb 2-4: new high speed USB device using ehci_hcd and address 5
[    5.584000] usb 2-4: configuration #1 chosen from 1 choice
[    5.704000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.712000] ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7BP, max UDMA/100
[    5.712000] ata1.00: 312581808 sectors, multi 16: LBA48 
[    5.728000] ata1.00: configured for UDMA/100
[    5.888000] usb 1-1: new low speed USB device using ohci_hcd and address 2
[    6.040000] ata2: SATA link down (SStatus 0 SControl 300)
[    6.048000] scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
[    6.048000] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
[    6.048000] PCI: setting IRQ 10 as level-triggered
[    6.048000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 10 (level, low) -> IRQ 10
[    6.048000] PCI: Setting latency timer of device 0000:00:14.0 to 64
[    6.048000] forcedeth: using HIGHDMA
[    6.060000] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    6.060000] sd 0:0:0:0: [sda] Write Protect is off
[    6.060000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.060000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.060000] sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
[    6.060000] sd 0:0:0:0: [sda] Write Protect is off
[    6.060000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.060000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.060000]  sda:<6>usb 1-1: configuration #1 chosen from 1 choice
[    6.400000] usb 1-2: new low speed USB device using ohci_hcd and address 3
[    6.476000]  sda1 sda2 sda3 sda4 < sda5 >
[    6.496000] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.500000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.572000] eth0: forcedeth.c: subsystem: 0103c:30b7 bound to 0000:00:14.0
[    6.572000] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
[    6.572000] ACPI: PCI Interrupt 0000:07:05.0[A] -> Link [LNK1] -> GSI 11 (level, low) -> IRQ 11
[    6.624000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[c8000000-c80007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    6.676000] usb 1-2: configuration #1 chosen from 1 choice
[    6.960000] Attempting manual resume
[    6.960000] swsusp: Resume From Partition 8:5
[    6.960000] PM: Checking swsusp image.
[    6.960000] PM: Resume from disk failed.
[    6.976000] EXT3-fs: INFO: recovery required on readonly filesystem.
[    6.976000] EXT3-fs: write access will be enabled during recovery.
[    6.984000] usb 1-3: new full speed USB device using ohci_hcd and address 4
[    7.212000] usb 1-3: configuration #1 chosen from 1 choice
[    7.216000] usbcore: registered new interface driver hiddev
[    7.224000] input: HID 1241:1122 as /class/input/input2
[    7.224000] input: USB HID v1.00 Mouse [HID 1241:1122] on usb-0000:00:0b.0-1
[    7.232000] input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input3
[    7.232000] input: USB HID v1.11 Keyboard [Microsoft Natural® Ergonomic Keyboard 4000] on usb-0000:00:0b.0-2
[    7.248000] input: Microsoft Natural® Ergonomic Keyboard 4000 as /class/input/input4
[    7.248000] input: USB HID v1.11 Device [Microsoft Natural® Ergonomic Keyboard 4000] on usb-0000:00:0b.0-2
[    7.248000] usbcore: registered new interface driver usbhid
[    7.248000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[    7.900000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b0034351600]
[   10.984000] kjournald starting.  Commit interval 5 seconds
[   10.984000] EXT3-fs: recovery complete.
[   10.984000] EXT3-fs: mounted filesystem with ordered data mode.
[   18.028000] ndiswrapper version 1.45 loaded (smp=yes)
[   18.128000] ndiswrapper: driver bcmwl5 (Broadcom,03/23/2006, 4.40.19.0) loaded
[   18.132000] ACPI: PCI Interrupt Link [LK4E] enabled at IRQ 10
[   18.132000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK4E] -> GSI 10 (level, low) -> IRQ 10
[   18.132000] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   18.136000] ndiswrapper: using IRQ 10
[   18.524000] wlan0: ethernet device 00:1a:73:50:a0:ec using NDIS driver: bcmwl5, version: 0x4281300, NDIS version: 0x501, vendor: 'NDIS Network Adapter', 14E4:4312.5.conf
[   18.524000] wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP with WPA, WPA2, WPA2PSK
[   18.532000] usbcore: registered new interface driver ndiswrapper
[   18.640000] ip_tables: (C) 2000-2006 Netfilter Core Team
[   18.676000] Netfilter messages via NETLINK v0.30.
[   18.688000] nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
[   20.876000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   20.928000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   21.076000] NET: Registered protocol family 17
[   21.484000] Linux agpgart interface v0.102 (c) Dave Jones
[   23.040000] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 11
[   23.040000] ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LK1E] -> GSI 11 (level, low) -> IRQ 11
[   23.040000] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   23.040000] NVRM: loading NVIDIA UNIX x86 Kernel Module  169.07  Thu Dec 13 18:42:56 PST 2007
[   23.092000] ieee80211_crypt: registered algorithm 'NULL'
[   23.116000] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   23.116000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   23.352000] input: PC Speaker as /class/input/input5
[   23.360000] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   23.360000] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   23.484000] sdhci: Secure Digital Host Controller Interface driver
[   23.484000] sdhci: Copyright(c) Pierre Ossman
[   23.484000] sdhci: SDHCI controller found at 0000:07:05.1 [1180:0822] (rev 19)
[   23.484000] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
[   23.484000] ACPI: PCI Interrupt 0000:07:05.1[B] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
[   23.484000] mmc0: SDHCI at 0xc8000800 irq 11 DMA
[   23.540000] Linux video capture interface: v2.00
[   23.672000] bcm43xx driver
[   23.736000] Bluetooth: Core ver 2.11
[   23.736000] NET: Registered protocol family 31
[   23.736000] Bluetooth: HCI device and connection manager initialized
[   23.736000] Bluetooth: HCI socket layer initialized
[   23.860000] usbcore: registered new interface driver xpad
[   23.860000] /build/buildd/linux-source-2.6.22-2.6.22/drivers/input/joystick/xpad.c: driver for Xbox controllers v0.1.6
[   23.900000] Bluetooth: HCI USB driver ver 2.9
[   23.900000] usbcore: registered new interface driver hci_usb
[   23.952000] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (0c45:62c0)
[   23.952000] usbcore: registered new interface driver uvcvideo
[   23.952000] USB Video Class driver (v0.1.0)
[   24.260000] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1a0b1, caps: 0xa04713/0x200000
[   24.268000] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 9
[   24.268000] PCI: setting IRQ 9 as level-triggered
[   24.268000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LAZA] -> GSI 9 (level, low) -> IRQ 9
[   24.268000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   24.324000] input: SynPS/2 Synaptics TouchPad as /class/input/input6
[   24.868000] lp: driver loaded but no devices found
[   25.328000] Adding 2851496k swap on /dev/sda5.  Priority:-1 extents:1 across:2851496k
[   25.740000] EXT3 FS on sda3, internal journal
[   26.384000] NET: Registered protocol family 10
[   26.384000] lo: Disabled Privacy Extensions
[   29.548000] powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-56 processors (version 2.00.00)
[   29.548000] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x12
[   29.548000] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x14
[   29.548000] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x1e
[   29.724000] ACPI: AC Adapter [ACAD] (on-line)
[   29.772000] ACPI: Battery Slot [BAT0] (battery absent)
[   29.788000] No dock devices found.
[   29.828000] ACPI: Video Device [UVGA] (multi-head: yes  rom: no  post: no)
[   29.832000] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   29.940000] input: Power Button (FF) as /class/input/input7
[   29.944000] ACPI: Power Button (FF) [PWRF]
[   29.984000] input: Power Button (CM) as /class/input/input8
[   29.988000] ACPI: Power Button (CM) [PWRB]
[   30.028000] input: Sleep Button (CM) as /class/input/input9
[   30.032000] ACPI: Sleep Button (CM) [SLPB]
[   30.072000] input: Lid Switch as /class/input/input10
[   30.076000] ACPI: Lid Switch [LID]
[   31.904000] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   33.536000] Failure registering capabilities with primary security module.
[   36.112000] ppdev: user-space parallel port driver
[   36.644000] audit(1199541767.980:3):  type=1503 operation="inode_permission" requested_mask="a" denied_mask="a" name="/dev/tty" pid=5720 profile="/usr/sbin/cupsd"
[   36.740000] apm: BIOS not found.
[   36.868000] eth0: no IPv6 routers present
[   39.912000] hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to recover by ending request.
[   43.008000] NET: Registered protocol family 29
[   43.200000] 
[   43.200000] ndas: Initializing NDAS driver version 1.1.15
[   43.204000] ndas: Setting max request size to 64kbytes
[   43.204000] ndas: registering network interface eth0
[   43.204000] ndas: registering network interface wlan0
[   43.328000] ndas: registered ndas device at major number 60
[   52.996000] /dev/vmmon[6295]: Module vmmon: registered with major=10 minor=165
[   52.996000] /dev/vmmon[6295]: Module vmmon: initialized
[   53.100000] /dev/vmnet: open called by PID 6320 (vmnet-bridge)
[   53.100000] /dev/vmnet: hub 0 does not exist, allocating memory.
[   53.100000] /dev/vmnet: port on hub 0 successfully opened
[   53.100000] bridge-eth0: enabling the bridge
[   53.100000] bridge-eth0: up
[   53.100000] bridge-eth0: already up
[   53.100000] bridge-eth0: attached
[   53.152000] /dev/vmnet: open called by PID 6334 (vmnet-natd)
[   53.152000] /dev/vmnet: hub 8 does not exist, allocating memory.
[   53.152000] /dev/vmnet: port on hub 8 successfully opened
[   53.500000] Clocksource tsc unstable (delta = -157833932 ns)
[   53.768000] Bluetooth: L2CAP ver 2.8
[   53.768000] Bluetooth: L2CAP socket layer initialized
[   53.784000] Bluetooth: RFCOMM socket layer initialized
[   53.788000] Bluetooth: RFCOMM TTY layer initialized
[   53.788000] Bluetooth: RFCOMM ver 1.8
[   63.132000] /dev/vmnet: open called by PID 6942 (vmnet-netifup)
[   63.132000] /dev/vmnet: hub 1 does not exist, allocating memory.
[   63.132000] /dev/vmnet: port on hub 1 successfully opened
[   63.140000] /dev/vmnet: open called by PID 6943 (vmnet-netifup)
[   63.140000] /dev/vmnet: port on hub 8 successfully opened
[   63.152000] ndas: network up. Registering vmnet8
[   63.176000] ndas: network up. Registering vmnet1
[   63.256000] /dev/vmnet: open called by PID 6958 (vmnet-dhcpd)
[   63.256000] /dev/vmnet: port on hub 8 successfully opened
[   63.260000] /dev/vmnet: open called by PID 6965 (vmnet-dhcpd)
[   63.260000] /dev/vmnet: port on hub 1 successfully opened
[   73.956000] vmnet8: no IPv6 routers present
[   74.172000] vmnet1: no IPv6 routers present
[   90.032000] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   97.128000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23234 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[   97.604000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23235 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[   98.356000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23236 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[   99.660000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23237 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[  101.492000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23238 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[  103.764000] wlan0: no IPv6 routers present
[  104.956000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23239 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[  111.684000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23240 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 
[  124.944000] Unknown InputIN=eth0 OUT= MAC=00:1b:24:29:51:8c:00:14:bf:8a:78:ac:08:00 SRC=208.69.34.230 DST=192.168.253.50 LEN=1500 TOS=0x00 PREC=0x00 TTL=54 ID=23241 DF PROTO=TCP SPT=80 DPT=47483 WINDOW=33304 RES=0x00 ACK URGP=0 

--=-b0GXBlJZ8UkZ5QGHDbQO--

