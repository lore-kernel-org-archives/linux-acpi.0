From: <foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Keyboard not working before loading ohci-hcd (Acer Aspire 1674)
Date: Thu, 12 Jan 2006 12:56:46 -0800 (PST)
Message-ID: <20060112205646.20606.qmail@web81607.mail.mud.yahoo.com>
References: <200601061847.27590.laurent.pinchart@skynet.be>
Reply-To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601061847.27590.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please try with ec_burst=0 kernel boot option.

--- Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org> wrote:

> Hi everybody,
> 
> I posted this mail to linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org a week ago, but as
> most 
> people hadn't resubscribed to the mailing list I thought I would give
> it 
> another chance.
> 
> Laurent Pinchart
> 
>
-----------------------------------------------------------------------------
> 
> I'm experiencing a weird problem with the internal keyboard of an
> Acer Aspire 
> 1674 (HyperThreading CPU).
> 
> When ACPI is enabled, the keyboard doesn't work at all before
> ohci-hcd is 
> loaded. Modifying PCI interrupt routing (pci=noacpi, pci=routeirq)
> doesn't 
> help, but disabling ACPI completely (acpi=off) gives a functional
> keyboard 
> even before loading ohci-hcd.
> 
> After some investigation (through an ssh session), I found out that
> the i8042 
> doesn't generate any interrupt when I press a key before loading
> ohci-hcd. I 
> attached the contents of /proc/interrupts at bootup (interrupts),
> after 
> loading ehci-hcd (interrupts.1.ehci), after loading both ehci and
> ohci 
> (interrupts.2.ohci), and when acpi is disabled (interrupts.acpi-off).
> 
> I also attached dmesg output at bootup (dmesg.start), after loading
> ehci-hcd 
> (dmesg.1.ehci), after loading both ehci and ohci (dmesg.2.ohci), and
> at 
> bootup with ACPI disabled (dmesg.start.acpi-off) as well as lspci -vv
> output.
> 
> Thanks in advance for all the help you can provide, this is really
> puzzling 
> me. I would leave it as it is, if I didn't have another issue with
> the ehci 
> controller which might be related to the same problem (USB 2.0
> peripherals 
> work very unreliably, they time out most of the time, and USB 2.0
> only works 
> when ohci-hcd is loaded before ehci-hcd).
> 
> I can send the DSDT if needed. I had to patch it to fix small battery
> issues 
> (missing return values, ByteAcc/AnyAcc, ...), but all the tests above
> were 
> made with the patched and unpatched versions with no differences.
> 
> Laurent Pinchart
> > Linux version 2.6.12 (root@localhost) (gcc version 3.3.5-20050130
> (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #4 SMP
> Thu Dec 29 12:43:11 CET 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
>  BIOS-e820: 000000003ff70000 - 000000003ff7b000 (ACPI data)
>  BIOS-e820: 000000003ff7b000 - 000000003ff80000 (ACPI NVS)
>  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
>  BIOS-e820: 000000004ff80000 - 0000000050000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> found SMP MP-table at 000f6950
> On node 0 totalpages: 229376
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> DMI present.
> ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f69b0
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
> 0x3ff773e8
> ACPI: FADT (v001 COMPAL ELW80    0x06040000 ATI  0x00000003) @
> 0x3ff7af24
> ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @
> 0x3ff7af98
> ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @
> 0x3ff77418
> ACPI: DSDT (v001 COMPAL    ELW80 0x06040000 MSFT 0x0100000e) @
> 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:3 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:3 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 50000000 (gap:
> 50000000:aec00000)
> Built 1 zonelists
> Kernel command line: root=/dev/hda7
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 3404.381 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 905256k/917504k available (1998k kernel code, 11736k
> reserved, 1109k data, 192k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor
> mode... Ok.
> Calibrating delay loop... 6668.28 BogoMIPS (lpj=3334144)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: bfebfbff 00000000 00000000
> 00000000 0000441d 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> 0000441d 00000000 00000000
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
> 0000441d 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
>    tbget-0294: *** Info: Table [DSDT] replaced by host OS
>  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully
> acquired
> Parsing all Control
>
Methods:....................................................................................................................
> Table [DSDT](id F005) - 510 Objects with 44 Devices 116 Methods 20
> Regions
> Parsing all Control Methods:..
> Table [SSDT](id F003) - 10 Objects with 0 Devices 2 Methods 0 Regions
> ACPI Namespace successfully loaded at root c04749c0
> evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode
> successful
> CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> Calibrating delay loop... 6782.97 BogoMIPS (lpj=3391488)
> CPU: After generic identify, caps: bfebfbff 00000000 00000000
> 00000000 0000441d 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> 0000441d 00000000 00000000
> monitor/mwait feature present.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
> 0000441d 00000000 00000000
> CPU1: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
> Total of 2 processors activated (13451.26 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> CPU0 attaching sched-domain:
>  domain 0: span 3
>   groups: 1 2
>   domain 1: span 3
>    groups: 3
> CPU1 attaching sched-domain:
>  domain 0: span 3
>   groups: 2 1
>   domain 1: span 3
>    groups: 3
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd768, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050309
> evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs
> on int 0x9
> evgpeblk-0987 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 1
> Runtime GPEs in this block
> Completing Region/Field/Buffer/Package
> initialization:...................................................
> Initialized 20/20 Regions 0/0 Fields 16/16 Buffers 15/20 Packages
> (529 nodes)
> Executing all Device _STA and_INI
> methods:................................................
> 48 Devices found containing: 48 _STA, 2 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and
> Pathname is relative
> nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and
> Pathname is relative
> nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and
> Pathname is relative
> nsxfeval-0250 [06] acpi_evaluate_object  : Handle is NULL and
> Pathname is relative
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
> Boot video device is 0000:01:05.0
> PCI: Transparent bridge - 0000:00:14.4
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNK0] (IRQs 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK1] (IRQs 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK2] (IRQs 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNK3] (IRQs 10 11) *0, disabled.
> ACPI: Embedded Controller [EC0] (gpe 6)
> [ACPI Debug] String: [0x16] "== Main Battery _STA=="
> [ACPI Debug] String: [0x16] "== Main Battery _STA=="
> [ACPI Debug] String: [0x12] "=====QUERY_1E====="
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> [ACPI Debug] String: [0x16] "== Main Battery _STA=="
> pnp: PnP ACPI: found 10 devices
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post
> a report
> pnp: 00:06: ioport range 0x1080-0x1080 has been reserved
> pnp: 00:06: ioport range 0x220-0x22f has been reserved
> pnp: 00:06: ioport range 0x40b-0x40b has been reserved
> pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> devfs: boot_options: 0x0
> Initializing Cryptographic API
> ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 177
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=390.00 Mhz,
> System=200.00 MHz
> radeonfb: PLL min 20000 max 40000
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string: CMO N154I1-L07
>          
> radeonfb: detected LVDS panel size from BIOS: 1280x800
> radeondb: BIOS provided dividers will be used
> radeonfb: Dynamic Clock Power Management enabled
> Console: switching to colour frame buffer device 160x50
> radeonfb (0000:01:05.0): ATI Radeon NP 
> vga16fb: initializing
> vga16fb: mapped to 0xc00a0000
> fb1: VGA16 VGA frame buffer device
> ACPI: AC Adapter [ACAD] (on-line)
> [ACPI Debug] String: [0x16] "== Main Battery _STA=="
> [ACPI Debug] String: [0x21] "==Main Battery Information _BIF=="
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
> PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq
> 1,12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing
> enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 185
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> Linux video capture interface: v1.00
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ATIIXP: IDE controller at PCI slot 0000:00:14.1
> ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 177
> ATIIXP: chipset revision 0
> ATIIXP: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x8070-0x8077, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x8078-0x807f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: IC25N080ATMR04-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: Slimtype DVDRW SOSW-852S, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hda: max request size: 1024KiB
> hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63,
> UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0: p2 p4 < p5 p6 p7 p8 >
> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 64Kbytes
> TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> NET: Registered protocol family 15
> Starting balanced_irq
> ReiserFS: hda7: found reiserfs format "3.6" with standard journal
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.
> ReiserFS: hda7: using ordered data mode
> ReiserFS: hda7: journal params: device hda7, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda7: checking transaction log (hda7)
> ReiserFS: hda7: journal-1153: found in header: first_unflushed_offset
> 1738, last_flushed_trans_id 12780
> ReiserFS: hda7: journal-1206: Starting replay from offset
> 54893977011914, trans_id 0
> ReiserFS: hda7: journal-1299: Setting newest_mount_id to 83
> ReiserFS: hda7: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 192k freed
> NET: Registered protocol family 1
> Adding 1020088k swap on /dev/hda8.  Priority:-1 extents:1
> ndiswrapper version 1.5 loaded (preempt=yes,smp=yes)
> ndiswrapper: driver wlipnds (Cisco-Linksys,
> LLC.,01/05/2004,1.22.01.2004) loaded
> ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 193
> ndiswrapper: using irq 193
> wlan0: vendor: 'INPROCOMM IPN2220 Wireless LAN Adapter'
> wlan0: ndiswrapper ethernet device 00:0e:9b:94:bc:f4 using driver
> wlipnds, 17FE:2220.5.conf
> wlan0: encryption modes supported: WEP; TKIP with WPA; AES/CCMP with
> WPA
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> >            CPU0       CPU1       
>   0:     219231          0    IO-APIC-edge  timer
>   1:         18          0    IO-APIC-edge  i8042
>  14:       1429          0    IO-APIC-edge  ide0
>  15:       1839          0    IO-APIC-edge  ide1
> 169:         15          0   IO-APIC-level  acpi
> 193:       9337          0   IO-APIC-level  ndiswrapper
> 201:         73          0   IO-APIC-level  ehci_hcd:usb1,
> ohci_hcd:usb2, ohci_hcd:usb3
> NMI:          0          0 
> LOC:     218912     219956 
> ERR:          0
> MIS:          0
> >            CPU0       
>   0:      91265    IO-APIC-edge  timer
>   1:         13    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>  14:       1374    IO-APIC-edge  ide0
>  15:        651    IO-APIC-edge  ide1
> 177:       2629   IO-APIC-level  ndiswrapper
> NMI:          0 
> LOC:      91191 
> ERR:          0
> MIS:          0
> > Linux version 2.6.12 (root@localhost) (gcc version 3.3.5-20050130
> (Gentoo 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #6 SMP
> Thu Dec 29 13:10:59 CET 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff70000 (usable)
>  BIOS-e820: 000000003ff70000 - 000000003ff7b000 (ACPI data)
>  BIOS-e820: 000000003ff7b000 - 000000003ff80000 (ACPI NVS)
>  BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
>  BIOS-e820: 000000004ff80000 - 0000000050000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> found SMP MP-table at 000f6950
> On node 0 totalpages: 229376
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> DMI present.
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID:   Product ID: RS300 Board APIC at: 0xFEE00000
> Processor #0 15:3 APIC version 20
> I/O APIC #2 Version 17 at 0xFEC00000.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Processors: 1
> Allocating PCI resources starting at 50000000 (gap:
> 50000000:aec00000)
> Built 1 zonelists
> Kernel command line: root=/dev/hda7 acpi=off
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 3404.391 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 905280k/917504k available (1982k kernel code, 11712k
> reserved, 1102k data, 192k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor
> mode... Ok.
> Calibrating delay loop... 6684.67 BogoMIPS (lpj=3342336)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: bfebfbff 00000000 00000000
> 00000000 0000441d 00000000 00000000
> CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> 0000441d 00000000 00000000
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080
> 0000441d 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
> Total of 1 processors activated (6684.67 BogoMIPS).
> WARNING: 1 siblings found for CPU0, should be 2
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=0
> Brought up 1 CPUs
> CPU0 attaching sched-domain:
>  domain 0: span 1
>   groups: 1
>   domain 1: span 1
>    groups: 1
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd768, last bus=2
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050309
> ACPI: Interpreter disabled.
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
> Boot video device is 0000:01:05.0
> PCI: Transparent bridge - 0000:00:14.4
> PCI: Using IRQ router default [1002/434c] at 0000:00:14.3
> PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 185
> PCI->APIC IRQ transform: 0000:00:13.1[A] -> IRQ 185
> PCI->APIC IRQ transform: 0000:00:13.2[A] -> IRQ 185
> PCI->APIC IRQ transform: 0000:00:14.1[A] -> IRQ 169
> PCI->APIC IRQ transform: 0000:00:14.5[B] -> IRQ 169
> PCI->APIC IRQ transform: 0000:00:14.6[B] -> IRQ 169
> PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 161
> PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 161
> PCI->APIC IRQ transform: 0000:02:02.0[A] -> IRQ 177
> PCI->APIC IRQ transform: 0000:02:03.0[A] -> IRQ 185
> PCI->APIC IRQ transform: 0000:02:04.0[A] -> IRQ 169
> PCI->APIC IRQ transform: 0000:02:04.1[B] -> IRQ 169
> PCI->APIC IRQ transform: 0000:02:04.2[B] -> IRQ 169
> PCI->APIC IRQ transform: 0000:02:04.3[B] -> IRQ 169
> Number of CPUs sharing cache didn't match any known set of CPUs
> Number of CPUs sharing cache didn't match any known set of CPUs
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
> devfs: boot_options: 0x0
> Initializing Cryptographic API
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=390.00 Mhz,
> System=200.00 MHz
> radeonfb: PLL min 20000 max 40000
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string: CMO N154I1-L07
>          
> radeonfb: detected LVDS panel size from BIOS: 1280x800
> radeondb: BIOS provided dividers will be used
> radeonfb: Dynamic Clock Power Management enabled
> Console: switching to colour frame buffer device 160x50
> radeonfb (0000:01:05.0): ATI Radeon NP 
> vga16fb: initializing
> vga16fb: mapped to 0xc00a0000
> fb1: VGA16 VGA frame buffer device
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing
> enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> Linux video capture interface: v1.00
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ATIIXP: IDE controller at PCI slot 0000:00:14.1
> ATIIXP: chipset revision 0
> ATIIXP: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x8070-0x8077, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x8078-0x807f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: IC25N080ATMR04-0, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: Slimtype DVDRW SOSW-852S, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> Probing IDE interface ide3...
> Probing IDE interface ide4...
> Probing IDE interface ide5...
> hda: max request size: 1024KiB
> hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63,
> UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0: p2 p4 < p5 p6 p7 p8 >
> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 64Kbytes
> TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> NET: Registered protocol family 15
> ReiserFS: hda7: found reiserfs format "3.6" with standard journal
> ReiserFS: hda7: using ordered data mode
> ReiserFS: hda7: journal params: device hda7, size 8192, journal first
> block 18, max trans len 1024, max batch 900, max commit age 30, max
> trans age 30
> ReiserFS: hda7: checking transaction log (hda7)
> ReiserFS: hda7: journal-1153: found in header: first_unflushed_offset
> 5316, last_flushed_trans_id 13062
> ReiserFS: hda7: journal-1206: Starting replay from offset
> 56105157792964, trans_id 0
> ReiserFS: hda7: journal-1299: Setting newest_mount_id to 92
> ReiserFS: hda7: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 192k freed
> input: AT Translated Set 2 keyboard on isa0060/serio0
> NET: Registered protocol family 1
> Adding 1020088k swap on /dev/hda8.  Priority:-1 extents:1
> ndiswrapper version 1.5 loaded (preempt=yes,smp=yes)
> ndiswrapper: driver wlipnds (Cisco-Linksys,
> LLC.,01/05/2004,1.22.01.2004) loaded
> ndiswrapper: using irq 177
> wlan0: vendor: 'INPROCOMM IPN2220 Wireless LAN Adapter'
> wlan0: ndiswrapper ethernet device 00:0e:9b:94:bc:f4 using driver
> wlipnds, 17FE:2220.5.conf
> wlan0: encryption modes supported: WEP; TKIP with WPA; AES/CCMP with
> WPA
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> >            CPU0       CPU1       
>   0:     176787          0    IO-APIC-edge  timer
>   1:         11          0    IO-APIC-edge  i8042
>  14:       1389          0    IO-APIC-edge  ide0
>  15:       1461          0    IO-APIC-edge  ide1
> 169:         15          0   IO-APIC-level  acpi
> 193:       7310          0   IO-APIC-level  ndiswrapper
> NMI:          0          0 
> LOC:     176466     177509 
> ERR:          0
> MIS:          0
> >            CPU0       CPU1       
>   0:     189551          0    IO-APIC-edge  timer
>   1:         12          0    IO-APIC-edge  i8042
>  14:       1411          0    IO-APIC-edge  ide0
>  15:       1569          0    IO-APIC-edge  ide1
> 169:         15          0   IO-APIC-level  acpi
> 193:       7885          0   IO-APIC-level  ndiswrapper
> 201:         24          0   IO-APIC-level  ehci_hcd:usb1
> NMI:          0          0 
> LOC:     189231     190274 
> ERR:          0
> MIS:          0
> > ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver
> (PCI)
> ohci_hcd: block sizes: ed 64 td 64
> ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 201
> ohci_hcd 0000:00:13.0: ATI Technologies Inc OHCI USB Controller #1
> ohci_hcd 0000:00:13.0: USB HC TakeOver from BIOS/SMM
> ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
> ohci_hcd 0000:00:13.0: irq 201, io mem 0xe8001000
> ohci_hcd 0000:00:13.0: resetting from state 'reset', control = 0x0
> ohci_hcd 0000:00:13.0: OHCI controller state
> ohci_hcd 0000:00:13.0: OHCI 1.0, NO legacy support registers
> ohci_hcd 0000:00:13.0: control 0x083 HCFS=operational CBSR=3
> ohci_hcd 0000:00:13.0: cmdstatus 0x00000 SOC=0
> ohci_hcd 0000:00:13.0: intrstatus 0x00000044 RHSC SF
> ohci_hcd 0000:00:13.0: intrenable 0x8000001a MIE UE RD WDH
> ohci_hcd 0000:00:13.0: fminterval a7782edf
> ohci_hcd 0000:00:13.0: hcca frame #0004
> ohci_hcd 0000:00:13.0: roothub.a 02000203 POTPGT=2 NPS NDP=3
> ohci_hcd 0000:00:13.0: roothub.b 00000000 PPCM=0000 DR=0000
> ohci_hcd 0000:00:13.0: roothub.status 00008000 DRWE
> ohci_hcd 0000:00:13.0: roothub.portstatus [0] 0x00000100 PPS
> ohci_hcd 0000:00:13.0: roothub.portstatus [1] 0x00000100 PPS
> ohci_hcd 0000:00:13.0: roothub.portstatus [2] 0x00000100 PPS
> usb usb2: default language 0x0409
> usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: ATI Technologies Inc OHCI USB Controller #1
> usb usb2: Manufacturer: Linux 2.6.12 ohci_hcd
> usb usb2: SerialNumber: 0000:00:13.0
> usb usb2: hotplug
> usb usb2: adding 2-0:1.0 (config #1, interface 0)
> usb 2-0:1.0: hotplug
> hub 2-0:1.0: usb_probe_interface
> hub 2-0:1.0: usb_probe_interface - got id
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> hub 2-0:1.0: standalone hub
> hub 2-0:1.0: no power switching (usb 1.0)
> hub 2-0:1.0: global over-current protection
> hub 2-0:1.0: power on to power good time: 4ms
> hub 2-0:1.0: local power source is good
> hub 2-0:1.0: no over-current condition exists
> hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0000
> ohci_hcd 0000:00:13.0: created debug files
> ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 201
> ohci_hcd 0000:00:13.1: ATI Technologies Inc OHCI USB Controller #2
> ohci_hcd 0000:00:13.1: USB HC TakeOver from BIOS/SMM
> ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
> ohci_hcd 0000:00:13.1: irq 201, io mem 0xe8002000
> ohci_hcd 0000:00:13.1: resetting from state 'reset', control = 0x0
> ohci_hcd 0000:00:13.1: OHCI controller state
> ohci_hcd 0000:00:13.1: OHCI 1.0, NO legacy support registers
> ohci_hcd 0000:00:13.1: control 0x083 HCFS=operational CBSR=3
> ohci_hcd 0000:00:13.1: cmdstatus 0x00000 SOC=0
> ohci_hcd 0000:00:13.1: intrstatus 0x00000044 RHSC SF
> ohci_hcd 0000:00:13.1: intrenable 0x8000001a MIE UE RD WDH
> ohci_hcd 0000:00:13.1: fminterval a7782edf
> ohci_hcd 0000:00:13.1: hcca frame #0088
> ohci_hcd 0000:00:13.1: roothub.a 02000203 POTPGT=2 NPS NDP=3
> ohci_hcd 0000:00:13.1: roothub.b 00000000 PPCM=0000 DR=0000
> ohci_hcd 0000:00:13.1: roothub.status 00008000 DRWE
> ohci_hcd 0000:00:13.1: roothub.portstatus [0] 0x00000100 PPS
> ohci_hcd 0000:00:13.1: roothub.portstatus [1] 0x00000100 PPS
> ohci_hcd 0000:00:13.1: roothub.portstatus [2] 0x00000100 PPS
> usb usb3: default language 0x0409
> usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: ATI Technologies Inc OHCI USB Controller #2
> usb usb3: Manufacturer: Linux 2.6.12 ohci_hcd
> usb usb3: SerialNumber: 0000:00:13.1
> usb usb3: hotplug
> usb usb3: adding 3-0:1.0 (config #1, interface 0)
> usb 3-0:1.0: hotplug
> hub 3-0:1.0: usb_probe_interface
> hub 3-0:1.0: usb_probe_interface - got id
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 3 ports detected
> hub 3-0:1.0: standalone hub
> hub 3-0:1.0: no power switching (usb 1.0)
> hub 3-0:1.0: global over-current protection
> hub 3-0:1.0: power on to power good time: 4ms
> hub 3-0:1.0: local power source is good
> hub 3-0:1.0: no over-current condition exists
> hub 3-0:1.0: state 5 ports 3 chg 0000 evt 0000
> ohci_hcd 0000:00:13.1: created debug files
> > ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
> ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 201
> ehci_hcd 0000:00:13.2: ATI Technologies Inc EHCI USB Controller
> ehci_hcd 0000:00:13.2: reset hcs_params 0x2306 dbg=0 cc=2 pcc=3
> ordered !ppc ports=6
> ehci_hcd 0000:00:13.2: reset hcc_params a012 thresh 1 uframes
> 256/512/1024
> ehci_hcd 0000:00:13.2: capability 0001 at a0
> ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:00:13.2: irq 201, io mem 0xe8003000
> ehci_hcd 0000:00:13.2: reset command 080002 (park)=0 ithresh=8
> period=1024 Reset HALT
> ehci_hcd 0000:00:13.2: init command 010009 (park)=0 ithresh=1
> period=256 RUN
> ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
> 2004
> usb usb1: default language 0x0409
> usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: ATI Technologies Inc EHCI USB Controller
> usb usb1: Manufacturer: Linux 2.6.12 ehci_hcd
> usb usb1: SerialNumber: 0000:00:13.2
> usb usb1: hotplug
> usb usb1: adding 1-0:1.0 (config #1, interface 0)
> usb 1-0:1.0: hotplug
> hub 1-0:1.0: usb_probe_interface
> hub 1-0:1.0: usb_probe_interface - got id
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> hub 1-0:1.0: standalone hub
> hub 1-0:1.0: no power switching (usb 1.0)
> hub 1-0:1.0: individual port over-current protection
> hub 1-0:1.0: Single TT
> hub 1-0:1.0: TT requires at most 8 FS bit times
> hub 1-0:1.0: power on to power good time: 20ms
> hub 1-0:1.0: local power source is good
> hub 1-0:1.0: state 5 ports 6 chg 0000 evt 0000
> > 00:00.0 Host bridge: ATI Technologies Inc Radeon 9100 IGP Host
Bridge
> (rev 02)
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 64
> 	Region 0: Memory at ea000000 (32-bit, prefetchable) [size=32M]
> 	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [a0] AGP version 3.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3+ Rate=x4,x8
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
> 
> 00:01.0 PCI bridge: ATI Technologies Inc Radeon 9100 IGP AGP Bridge
> (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 99
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
> 	I/O behind bridge: 00009000-00009fff
> 	Memory behind bridge: e8100000-e81fffff
> 	Prefetchable memory behind bridge: f0000000-f7ffffff
> 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:13.0 USB Controller: ATI Technologies Inc OHCI USB Controller #1
> (rev 01) (prog-if 10 [OHCI])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, Cache Line Size 20
> 	Interrupt: pin A routed to IRQ 193
> 	Region 0: Memory at e8001000 (32-bit, non-prefetchable) [size=4K]
> 
> 00:13.1 USB Controller: ATI Technologies Inc OHCI USB Controller #2
> (rev 01) (prog-if 10 [OHCI])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, Cache Line Size 20
> 	Interrupt: pin A routed to IRQ 193
> 	Region 0: Memory at e8002000 (32-bit, non-prefetchable) [size=4K]
> 
> 00:13.2 USB Controller: ATI Technologies Inc EHCI USB Controller (rev
> 01) (prog-if 20 [EHCI])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, Cache Line Size 20
> 	Interrupt: pin A routed to IRQ 193
> 	Region 0: Memory at e8003000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 		Bridge: PM- B3+
> 
> 00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 1a)
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Region 0: I/O ports at 8060 [size=16]
> 	Region 1: Memory at e8004000 (32-bit, non-prefetchable) [size=1K]
> 
> 00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus
> Master PCI IDE Controller (prog-if 8a [Master SecP PriP])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort+
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Interrupt: pin A routed to IRQ 177
> 	Region 0: I/O ports at <ignored>
> 	Region 1: I/O ports at <ignored>
> 	Region 2: I/O ports at <ignored>
> 	Region 3: I/O ports at <ignored>
> 	Region 4: I/O ports at 8070 [size=16]
> 
> 00:14.3 ISA bridge: ATI Technologies Inc Unknown device 434c
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 
> 00:14.4 PCI bridge: ATI Technologies Inc Unknown device 4342 (prog-if
> 01 [Subtractive decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Bus: primary=00, secondary=02, subordinate=04, sec-latency=68
> 	I/O behind bridge: 0000a000-0000afff
> 	Memory behind bridge: e8200000-e82fffff
> 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 
> 00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150
> AC'97 Audio Controller (rev 01)
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min), Cache Line Size 08
> 	Interrupt: pin B routed to IRQ 185
> 	Region 0: Memory at e8004400 (32-bit, non-prefetchable) [size=256]
> 
> 00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01) (prog-if
> 00 [Generic])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin B routed to IRQ 185
> 	Region 0: Memory at e8004800 (32-bit, non-prefetchable) [size=256]
> 
> 01:05.0 VGA compatible controller: ATI Technologies Inc RV350
> [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 255 (2000ns min), Cache Line Size 08
> 	Interrupt: pin A routed to IRQ 177
> 	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
> 	Region 1: I/O ports at 9000 [size=256]
> 	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
> 	Capabilities: [58] AGP version 3.0
> 		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
> 64bit- FW+ AGP3+ Rate=x4,x8
> 		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 80) (prog-if 10 [OHCI])
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (8000ns max), Cache Line Size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at e8200000 (32-bit, non-prefetchable) [size=2K]
> 	Region 1: I/O ports at a400 [size=128]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:02.0 Ethernet controller: Linksys, A Division of Cisco Systems
> [AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01)
> 	Subsystem: AMBIT Microsystem Corp. Unknown device 0305
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (8000ns min, 8000ns max)
> 	Interrupt: pin A routed to IRQ 201
> 	Region 0: I/O ports at a480 [size=32]
> 	Region 1: Memory at e8201000 (32-bit, non-prefetchable) [size=32]
> 	Region 2: Memory at e8200800 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: [40] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0036
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 128 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at a000 [size=256]
> 	Region 1: Memory at e8201400 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:04.0 CardBus bridge: ENE Technology Inc CB-710/2/4 Cardbus
> Controller
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64, Cache Line Size 08
> 	Interrupt: pin A routed to IRQ 255
> 	Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
> 	I/O window 0: 00000000-00000003
> 	I/O window 1: 00000000-00000003
> 	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
> PostWrite+
> 	16-bit legacy interface ports at 0001
> 
> 02:04.1 FLASH memory: ENE Technology Inc ENE PCI Memory Stick Card
> Reader Controller
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (250ns min, 1000ns max), Cache Line Size 08
> 	Interrupt: pin B routed to IRQ 11
> 	Region 0: Memory at e8201800 (32-bit, non-prefetchable) [size=128]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:04.2 Class 0805: ENE Technology Inc ENE PCI Secure Digital Card
> Reader Controller (prog-if 01)
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (8000ns min, 18000ns max), Cache Line Size 08
> 	Interrupt: pin B routed to IRQ 11
> 	Region 0: Memory at e8201c00 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:04.3 FLASH memory: ENE Technology Inc FLASH memory: ENE Technology
> Inc:
> 	Subsystem: Acer Incorporated [ALI] Unknown device 0065
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (250ns min, 1000ns max), Cache Line Size 08
> 	Interrupt: pin B routed to IRQ 11
> 	Region 0: Memory at e8202000 (32-bit, non-prefetchable) [size=128]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
