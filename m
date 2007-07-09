From: "Michal Semler" <cijoml@compare.cz>
Subject: Re: Dell Optiplex GX620 BIOS A11 dmidecode kernel 2.6.22
Date: Mon, 09 Jul 2007 13:27:20 +0200
Message-ID: <20070709112733.7E94B11484@nebuchadnezzar.smejdil.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nebuchadnezzar.smejdil.cz ([195.122.194.203]:55110 "EHLO
	nebuchadnezzar.smejdil.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348AbXGIL1g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jul 2007 07:27:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, 

attaching also acpidump for Dell Optiplex GX620 BIOS A11. 

Michal 

Michal Semler writes: 

> Linux version 2.6.22 (root@optiplex) (gcc version 4.1.2 20061115 
> (prerelease) (Debian 4.1.1-21)) #1 SMP PREEMPT Mon Jul 9 11:26:03 CEST 
> 2007
> Command line: BOOT_IMAGE=Linux ro root=802 no_fwh_detect
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000003f686c00 (usable)
> BIOS-e820: 000000003f686c00 - 000000003f688c00 (ACPI NVS)
> BIOS-e820: 000000003f688c00 - 000000003f68ac00 (ACPI data)
> BIOS-e820: 000000003f68ac00 - 0000000040000000 (reserved)
> BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
> BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> Entering add_active_range(0, 0, 160) 0 entries of 256 used
> Entering add_active_range(0, 256, 259718) 1 entries of 256 used
> end_pfn_map = 1048576
> DMI 2.3 present.
> ACPI: RSDP 000FEB00, 0024 (r2 DELL  )
> ACPI: XSDT 000FD257, 005C (r1 DELL    GX620          7 ASL        61)
> ACPI: FACP 000FD34F, 00F4 (r3 DELL    GX620          7 ASL        61)
> ACPI: DSDT FFFD4952, 3DA4 (r1   DELL    dt_ex     1000 INTL 20050309)
> ACPI: FACS 3F686C00, 0040
> ACPI: SSDT FFFD8815, 00AA (r1   DELL    st_ex     1000 INTL 20050309)
> ACPI: APIC 000FD443, 0072 (r1 DELL    GX620          7 ASL        61)
> ACPI: BOOT 000FD4B5, 0028 (r1 DELL    GX620          7 ASL        61)
> ACPI: ASF! 000FD4DD, 0067 (r16 DELL    GX620          7 ASL        61)
> ACPI: MCFG 000FD544, 003E (r1 DELL    GX620          7 ASL        61)
> ACPI: HPET 000FD582, 0038 (r1 DELL    GX620          7 ASL        61)
> Entering add_active_range(0, 0, 160) 0 entries of 256 used
> Entering add_active_range(0, 256, 259718) 1 entries of 256 used
> Zone PFN ranges:
>  DMA             0 ->     4096
>  DMA32        4096 ->  1048576
>  Normal    1048576 ->  1048576
> early_node_map[2] active PFN ranges
>    0:        0 ->      160
>    0:      256 ->   259718
> On node 0 totalpages: 259622
>  DMA zone: 56 pages used for memmap
>  DMA zone: 986 pages reserved
>  DMA zone: 2958 pages, LIFO batch:0
>  DMA32 zone: 3494 pages used for memmap
>  DMA32 zone: 252128 pages, LIFO batch:31
>  Normal zone: 0 pages used for memmap
> ACPI: PM-Timer IO Port: 0x808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 (Bootup-CPU)
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
> ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
> ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Setting APIC routing to flat
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> Using ACPI (MADT) for SMP configuration information
> swsusp: Registered nosave memory region: 00000000000a0000 - 
> 00000000000f0000
> swsusp: Registered nosave memory region: 00000000000f0000 - 
> 0000000000100000
> Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
> SMP: Allowing 4 CPUs, 2 hotplug CPUs
> PERCPU: Allocating 37256 bytes of per cpu data
> Built 1 zonelists.  Total pages: 255086
> Kernel command line: BOOT_IMAGE=Linux ro root=802 no_fwh_detect
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> time.c: Detected 2793.070 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Checking aperture...
> Memory: 1018384k/1038872k available (2155k kernel code, 20016k reserved, 
> 1016k data, 200k init)
> SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
> Calibrating delay using timer specific routine.. 5589.91 BogoMIPS 
> (lpj=2794955)
> Mount-cache hash table entries: 256
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> using mwait in idle threads.
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU0: Thermal monitoring enabled (TM1)
> SMP alternatives: switching to UP code
> ACPI: Core revision 20070126
> Using local APIC timer interrupts.
> result 12468989
> Detected 12.468 MHz APIC timer.
> SMP alternatives: switching to SMP code
> Booting processor 1/2 APIC 0x1
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 5586.12 BogoMIPS 
> (lpj=2793062)
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> CPU1: Thermal monitoring enabled (TM1)
>              Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
> checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> Brought up 2 CPUs
> migration_cost=11
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub 
> without MMCONFIG support.
> PCI: Using configuration type 1
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Probing PCI hardware (bus 00)
> PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
> PCI quirk: region 0880-08bf claimed by ICH6 GPIO
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, 
> disabled.
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> pnp: PnP ACPI: found 11 devices
> ACPI: ACPI bus type pnp unregistered
> SCSI subsystem initialized
> libata version 2.21 loaded.
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
> report
> PCI-GART: No AMD northbridge found.
> pnp: 00:01: ioport range 0x800-0x85f has been reserved
> pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
> pnp: 00:01: ioport range 0x860-0x8ff could not be reserved
> Time: tsc clocksource has been installed.
> pnp: 00:09: iomem range 0x0-0x9ffff could not be reserved
> pnp: 00:09: iomem range 0x100000-0xffffff could not be reserved
> pnp: 00:09: iomem range 0x1000000-0x3f686bff could not be reserved
> pnp: 00:09: iomem range 0xf0000-0xfffff could not be reserved
> pnp: 00:0a: ioport range 0x100-0x1fe could not be reserved
> pnp: 00:0a: ioport range 0x200-0x277 has been reserved
> pnp: 00:0a: ioport range 0x280-0x2e7 has been reserved
> pnp: 00:0a: ioport range 0x2f0-0x2f7 has been reserved
> pnp: 00:0a: ioport range 0x300-0x377 could not be reserved
> pnp: 00:0a: ioport range 0x380-0x3bb has been reserved
> pnp: 00:0a: ioport range 0x3c0-0x3e7 could not be reserved
> pnp: 00:0a: ioport range 0x3f6-0x3f7 could not be reserved
> pnp: 00:0a: iomem range 0xf0000000-0xf3ffffff could not be reserved
> pnp: 00:0a: iomem range 0xfeda0000-0xfedacfff has been reserved
> PCI: Bridge: 0000:00:01.0
>  IO window: disabled.
>  MEM window: fe900000-fe9fffff
>  PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.0
>  IO window: disabled.
>  MEM window: fe800000-fe8fffff
>  PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.1
>  IO window: disabled.
>  MEM window: fe700000-fe7fffff
>  PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>  IO window: disabled.
>  MEM window: disabled.
>  PREFETCH window: disabled.
> ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1c.1 to 64
> PCI: Setting latency timer of device 0000:00:1e.0 to 64
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
> TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> Simple Boot Flag at 0x7a set to 0x1
> IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
> audit: initializing netlink socket (disabled)
> audit(1183973268.598:1): initialized
> audit: cannot initialize inotify handle
> Total HugeTLB memory allocated, 0
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Boot video device is 0000:00:02.0
> PCI: Setting latency timer of device 0000:00:01.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:01.0:pcie00]
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:1c.0:pcie00]
> Allocate Port Service[0000:00:1c.0:pcie02]
> PCI: Setting latency timer of device 0000:00:1c.1 to 64
> assign_interrupt_mode Found MSI capability
> Allocate Port Service[0000:00:1c.1:pcie00]
> Allocate Port Service[0000:00:1c.1:pcie02]
> input: Power Button (FF) as /class/input/input0
> ACPI: Power Button (FF) [PWRF]
> input: Power Button (CM) as /class/input/input1
> ACPI: Power Button (CM) [VBTN]
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is 
> not present [20070126]
> ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is 
> not present [20070126]
> Linux agpgart interface v0.102 (c) Dave Jones
> agpgart: Detected an Intel 945G Chipset.
> agpgart: Detected 7932K stolen memory.
> agpgart: AGP aperture is 256M @ 0xe0000000
> intelfb: Framebuffer driver for Intel(R) 
> 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
> intelfb: Version 0.9.4
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> intelfb: 00:02.0: Intel(R) 945G, aperture size 256MB, stolen memory 7932kB
> intelfb: Mode is interlaced.
> intelfb: Initial video mode is 1024x768-32@70.
> Console: switching to colour frame buffer device 128x48
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> ata_piix 0000:00:1f.1: version 2.11
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 
> bmdma 0x000000000001ffa0 irq 14
> ata2: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 
> bmdma 0x000000000001ffa8 irq 15
> ata1.00: ATAPI: SONY DVD-ROM DDU1615, FDS2, max UDMA/33
> ata1.00: configured for UDMA/33
> ata2: port disabled. ignoring.
> scsi 0:0:0:0: CD-ROM            SONY     DVD-ROM DDU1615  FDS2 PQ: 0 ANSI: 
> 5
> sr0: scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 0:0:0:0: Attached scsi CD-ROM sr0
> sr 0:0:0:0: Attached scsi generic sg0 type 5
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> scsi2 : ata_piix
> scsi3 : ata_piix
> ata3: SATA max UDMA/133 cmd 0x000000000001fe00 ctl 0x000000000001fe12 
> bmdma 0x000000000001fea0 irq 20
> ata4: SATA max UDMA/133 cmd 0x000000000001fe20 ctl 0x000000000001fe32 
> bmdma 0x000000000001fea8 irq 20
> ata3.00: ATA-7: SAMSUNG HD080HJ/P, ZH100-34, max UDMA7
> ata3.00: 156250000 sectors, multi 8: LBA48 NCQ (depth 0/32)
> ata3.00: configured for UDMA/133
> scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD080HJ/ ZH10 PQ: 0 ANSI: 
> 5
> sd 2:0:0:0: [sda] 156250000 512-byte hardware sectors (80000 MB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> sd 2:0:0:0: [sda] 156250000 512-byte hardware sectors (80000 MB)
> sd 2:0:0:0: [sda] Write Protect is off
> sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
> support DPO or FUA
> sda: sda1 sda2 sda3
> sd 2:0:0:0: [sda] Attached SCSI disk
> sd 2:0:0:0: Attached scsi generic sg1 type 0
> PNP: No PS/2 controller found. Probing ports directly.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> usbcore: registered new interface driver usbhid
> drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
> TCP cubic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 200k freed
> Real Time Clock Driver v1.12ac
> parport_pc 00:07: reported by Plug and Play ACPI
> parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
> tg3.c:v3.77 (May 31, 2007)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express) 
> 10/100/1000Base-T Ethernet 00:19:b9:1d:40:ea
> eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
> eth0: dma_rwctrl[76180000] dma_mask[64-bit]
> USB Universal Host Controller Interface driver v3.0
> ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 21
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000ff80
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> input: PC Speaker as /class/input/input2
> Floppy drive(s): fd0 is 1.44M
> iTCO_vendor_support: vendor-support=0
> FDC 0 is a post-1991 82077
> iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
> iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
> iTCO_wdt: No card detected
> ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
> PCI: Setting latency timer of device 0000:00:1d.1 to 64
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000ff60
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> intel_rng: Firmware space is locked read-only. <4>intel_rng: If you can't 
> or
> don't want to <4>intel_rng: disable this in firmware setup, and 
> <4>intel_rng: if
> you are certain that your <4>intel_rng: system has a functional
> RNG, try<4>intel_rng: using the 'no_fwh_detect' option.
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
> PCI: Setting latency timer of device 0000:00:1d.3 to 64
> uhci_hcd 0000:00:1d.3: UHCI Host Controller
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000ff20
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 2-1: new low speed USB device using uhci_hcd and address 2
> ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 21
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:1d.7: debug port 1
> PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: irq 21, io mem 0xffa80800
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 8 ports detected
> ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 23 (level, low) -> IRQ 23
> PCI: Setting latency timer of device 0000:00:1e.2 to 64
> intel8x0_measure_ac97_clock: measured 51357 usecs
> intel8x0: clocking to 48000
> ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
> usb 2-1: new low speed USB device using uhci_hcd and address 3
> usb 2-1: configuration #1 chosen from 1 choice
> input: USB Optical Mouse as /class/input/input3
> input: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:1d.1-1
> usb 2-2: new full speed USB device using uhci_hcd and address 4
> usb 2-2: configuration #1 chosen from 1 choice
> input: Dell Dell Smart Card Reader Keyboard as /class/input/input4
> input: USB HID v1.11 Keyboard [Dell Dell Smart Card Reader Keyboard] on 
> usb-0000:00:1d.1-2
> Adding 979956k swap on /dev/sda3.  Priority:-1 extents:1 across:979956k
> EXT3 FS on sda2, internal journal
> loop: module loaded
> fuse init (API version 7.8)
> lp0: using parport0 (interrupt-driven).
> lp0: console ready
> tg3: eth0: Link is up at 1000 Mbps, full duplex.
> tg3: eth0: Flow control is off for TX and off for RX.
> [drm] Initialized drm 1.1.0 20060810
> [drm] Initialized i915 1.6.0 20060119 on minor 0  
> 
> So here you have your dmidecode, guys ;)  
> 
> 
> optiplex:/boot# dmidecode
> # dmidecode 2.8
> SMBIOS 2.3 present.
> 73 structures occupying 2590 bytes.
> Table at 0x000F0450.  
> 
> Handle 0xDA00, DMI type 218, 53 bytes
> OEM-specific Type
>        Header and Data:
>                DA 35 00 DA B2 00 17 0B 0E 38 00 00 80 00 80 01
>                00 02 80 02 80 01 00 00 A0 00 A0 01 00 58 00 58
>                00 01 00 59 00 59 00 01 00 05 80 05 80 01 00 FF
>                FF 00 00 00 00  
> 
> Handle 0xDA01, DMI type 218, 35 bytes
> OEM-specific Type
>        Header and Data:
>                DA 23 01 DA B2 00 17 0B 0E 38 00 10 F5 10 F5 00
>                00 11 F5 11 F5 00 00 12 F5 12 F5 00 00 FF FF 00
>                00 00 00  
> 
> Handle 0x0000, DMI type 0, 20 bytes
> BIOS Information
>        Vendor: Dell Inc.
>        Version: A11
>        Release Date: 11/30/2006
>        Address: 0xF0000
>        Runtime Size: 64 kB
>        ROM Size: 512 kB
>        Characteristics:
>                PCI is supported
>                PNP is supported
>                APM is supported
>                BIOS is upgradeable
>                BIOS shadowing is allowed
>                Boot from CD is supported
>                Selectable boot is supported
>                EDD is supported
>                Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
>                Print screen service is supported (int 5h)
>                8042 keyboard services are supported (int 9h)
>                Serial services are supported (int 14h)
>                Printer services are supported (int 17h)
>                ACPI is supported
>                USB legacy is supported
>                LS-120 boot is supported
>                BIOS boot specification is supported
>                Function key-initiated network boot is supported  
> 
> Handle 0x0100, DMI type 1, 25 bytes
> System Information
>        Manufacturer: Dell Inc.
>        Product Name: OptiPlex GX620
>        Version: Not Specified
>        Serial Number: JLG4Q2J
>        UUID: 44454C4C-4C00-1047-8034-CAC04F51324A
>        Wake-up Type: Power Switch  
> 
> Handle 0x0200, DMI type 2, 8 bytes
> Base Board Information
>        Manufacturer: Dell Inc.
>        Product Name: 0FH884
>        Version:
>        Serial Number: ..CN1374071302OZ.  
> 
> Handle 0x0300, DMI type 3, 13 bytes
> Chassis Information
>        Manufacturer: Dell Inc.
>        Type: Desktop
>        Lock: Not Present
>        Version: Not Specified
>        Serial Number: JLG4Q2J
>        Asset Tag:
>        Boot-up State: Safe
>        Power Supply State: Safe
>        Thermal State: Safe
>        Security Status: None  
> 
> Handle 0x0400, DMI type 4, 32 bytes
> Processor Information
>        Socket Designation: Microprocessor
>        Type: Central Processor
>        Family: Pentium 4
>        Manufacturer: Intel
>        ID: 49 0F 00 00 FF FB EB BF
>        Signature: Type 0, Family 15, Model 4, Stepping 9
>        Flags:
>                FPU (Floating-point unit on-chip)
>                VME (Virtual mode extension)
>                DE (Debugging extension)
>                PSE (Page size extension)
>                TSC (Time stamp counter)
>                MSR (Model specific registers)
>                PAE (Physical address extension)
>                MCE (Machine check exception)
>                CX8 (CMPXCHG8 instruction supported)
>                APIC (On-chip APIC hardware supported)
>                SEP (Fast system call)
>                MTRR (Memory type range registers)
>                PGE (Page global enable)
>                MCA (Machine check architecture)
>                CMOV (Conditional move instruction supported)
>                PAT (Page attribute table)
>                PSE-36 (36-bit page size extension)
>                CLFSH (CLFLUSH instruction supported)
>                DS (Debug store)
>                ACPI (ACPI supported)
>                MMX (MMX technology supported)
>                FXSR (Fast floating-point save and restore)
>                SSE (Streaming SIMD extensions)
>                SSE2 (Streaming SIMD extensions 2)
>                SS (Self-snoop)
>                HTT (Hyper-threading technology)
>                TM (Thermal monitor supported)
>                PBE (Pending break enabled)
>        Version: Not Specified
>        Voltage: 1.4 V
>        External Clock: 800 MHz
>        Max Speed: 4000 MHz
>        Current Speed: 2800 MHz
>        Status: Populated, Enabled
>        Upgrade: ZIF Socket
>        L1 Cache Handle: 0x0700
>        L2 Cache Handle: 0x0701
>        L3 Cache Handle: Not Provided  
> 
> Handle 0x0700, DMI type 7, 19 bytes
> Cache Information
>        Socket Designation: Not Specified
>        Configuration: Enabled, Not Socketed, Level 1
>        Operational Mode: Write Back
>        Location: Internal
>        Installed Size: 16 KB
>        Maximum Size: 16 KB
>        Supported SRAM Types:
>                Other
>        Installed SRAM Type: Other
>        Speed: Unknown
>        Error Correction Type: None
>        System Type: Data
>        Associativity: 8-way Set-associative  
> 
> Handle 0x0701, DMI type 7, 19 bytes
> Cache Information
>        Socket Designation: Not Specified
>        Configuration: Enabled, Not Socketed, Level 2
>        Operational Mode: Varies With Memory Address
>        Location: Internal
>        Installed Size: 1024 KB
>        Maximum Size: 1024 KB
>        Supported SRAM Types:
>                Other
>        Installed SRAM Type: Other
>        Speed: Unknown
>        Error Correction Type: Single-bit ECC
>        System Type: Unified
>        Associativity: 8-way Set-associative  
> 
> Handle 0x0800, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: PARALLEL
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: DB-25 female
>        Port Type: Parallel Port PS/2  
> 
> Handle 0x0801, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: SERIAL1
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: DB-9 male
>        Port Type: Serial Port 16550A Compatible  
> 
> Handle 0x0802, DMI type 126, 9 bytes
> Inactive  
> 
> Handle 0x0803, DMI type 126, 9 bytes
> Inactive  
> 
> Handle 0x0804, DMI type 126, 9 bytes
> Inactive  
> 
> Handle 0x0805, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB1
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x0806, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB2
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x0807, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB3
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x0808, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB4
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x0809, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB5
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x080A, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB6
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x080B, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB7
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x080C, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: USB8
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Access Bus (USB)
>        Port Type: USB  
> 
> Handle 0x080D, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: ENET
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: RJ-45
>        Port Type: Network Port  
> 
> Handle 0x080E, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: MIC
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Mini Jack (headphones)
>        Port Type: Audio Port  
> 
> Handle 0x080F, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: LINE-OUT
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Mini Jack (headphones)
>        Port Type: Audio Port  
> 
> Handle 0x0810, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: LINE-IN
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Mini Jack (headphones)
>        Port Type: Audio Port  
> 
> Handle 0x0811, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: HP-OUT
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: Mini Jack (headphones)
>        Port Type: Audio Port  
> 
> Handle 0x0812, DMI type 8, 9 bytes
> Port Connector Information
>        Internal Reference Designator: MONITOR
>        Internal Connector Type: None
>        External Reference Designator: Not Specified
>        External Connector Type: DB-15 female
>        Port Type: Video Port  
> 
> Handle 0x090A, DMI type 9, 13 bytes
> System Slot Information
>        Designation: PEG
>        Type: x16 PCI Express
>        Current Usage: Available
>        Length: Long
>        Characteristics:
>                3.3 V is provided
>                PME signal is supported  
> 
> Handle 0x0901, DMI type 126, 13 bytes
> Inactive  
> 
> Handle 0x0902, DMI type 9, 13 bytes
> System Slot Information
>        Designation: SLOT2
>        Type: 32-bit PCI
>        Current Usage: Available
>        Length: Long
>        ID: 2
>        Characteristics:
>                5.0 V is provided
>                3.3 V is provided
>                PME signal is supported  
> 
> Handle 0x0903, DMI type 9, 13 bytes
> System Slot Information
>        Designation: SLOT3
>        Type: 32-bit PCI
>        Current Usage: Available
>        Length: Long
>        ID: 3
>        Characteristics:
>                5.0 V is provided
>                3.3 V is provided
>                PME signal is supported  
> 
> Handle 0x0904, DMI type 126, 13 bytes
> Inactive  
> 
> Handle 0x0905, DMI type 126, 13 bytes
> Inactive  
> 
> Handle 0x0906, DMI type 126, 13 bytes
> Inactive  
> 
> Handle 0x0A00, DMI type 10, 6 bytes
> On Board Device Information
>        Type: Video
>        Status: Enabled
>        Description: Intel Graphics Media Accelerator 950  
> 
> Handle 0x0A02, DMI type 10, 6 bytes
> On Board Device Information
>        Type: Ethernet
>        Status: Enabled
>        Description: Broadcom 5751 NetXtreme Gigabit Controller  
> 
> Handle 0x0A03, DMI type 10, 6 bytes
> On Board Device Information
>        Type: Sound
>        Status: Enabled
>        Description: AC'97 Audio Controller  
> 
> Handle 0x0B00, DMI type 11, 5 bytes
> OEM Strings
>        String 1: www.dell.com  
> 
> Handle 0x0D00, DMI type 13, 22 bytes
> BIOS Language Information
>        Installable Languages: 1
>                en|US|iso8859-1
>        Currently Installed Language: en|US|iso8859-1  
> 
> Handle 0x0F00, DMI type 15, 29 bytes
> System Event Log
>        Area Length: 2049 bytes
>        Header Start Offset: 0x0000
>        Header Length: 16 bytes
>        Data Start Offset: 0x0010
>        Access Method: Memory-mapped physical 32-bit address
>        Access Address: 0xFFF81000
>        Status: Valid, Not Full
>        Change Token: 0x00000011
>        Header Format: Type 1
>        Supported Log Type Descriptors: 3
>        Descriptor 1: POST error
>        Data Format 1: POST results bitmap
>        Descriptor 2: System limit exceeded
>        Data Format 2: System management
>        Descriptor 3: Log area reset/cleared
>        Data Format 3: None  
> 
> Handle 0x1000, DMI type 16, 15 bytes
> Physical Memory Array
>        Location: System Board Or Motherboard
>        Use: System Memory
>        Error Correction Type: None
>        Maximum Capacity: 4 GB
>        Error Information Handle: Not Provided
>        Number Of Devices: 4  
> 
> Handle 0x1100, DMI type 17, 27 bytes
> Memory Device
>        Array Handle: 0x1000
>        Error Information Handle: Not Provided
>        Total Width: 64 bits
>        Data Width: 64 bits
>        Size: 512 MB
>        Form Factor: DIMM
>        Set: None
>        Locator: DIMM_1
>        Bank Locator: Not Specified
>        Type: DDR
>        Type Detail: Synchronous
>        Speed: 533 MHz (1.9 ns)
>        Manufacturer: 4000000000000000
>        Serial Number: 075826B0
>        Asset Tag: Not Specified
>        Part Number: V916764K24QAFW-E4  
> 
> Handle 0x1101, DMI type 17, 27 bytes
> Memory Device
>        Array Handle: 0x1000
>        Error Information Handle: Not Provided
>        Total Width: 64 bits
>        Data Width: 64 bits
>        Size: No Module Installed
>        Form Factor: DIMM
>        Set: None
>        Locator: DIMM_3
>        Bank Locator: Not Specified
>        Type: DDR
>        Type Detail: Synchronous
>        Speed: 533 MHz (1.9 ns)
>        Manufacturer: FFFFFFFFFFFFFFFF
>        Serial Number: FFFFFFFF
>        Asset Tag: Not Specified
>        Part Number:  
> 
> Handle 0x1102, DMI type 17, 27 bytes
> Memory Device
>        Array Handle: 0x1000
>        Error Information Handle: Not Provided
>        Total Width: 64 bits
>        Data Width: 64 bits
>        Size: 512 MB
>        Form Factor: DIMM
>        Set: None
>        Locator: DIMM_2
>        Bank Locator: Not Specified
>        Type: DDR
>        Type Detail: Synchronous
>        Speed: 533 MHz (1.9 ns)
>        Manufacturer: 4000000000000000
>        Serial Number: 085826B0
>        Asset Tag: Not Specified
>        Part Number: V916764K24QAFW-E4  
> 
> Handle 0x1103, DMI type 17, 27 bytes
> Memory Device
>        Array Handle: 0x1000
>        Error Information Handle: Not Provided
>        Total Width: 64 bits
>        Data Width: 64 bits
>        Size: No Module Installed
>        Form Factor: DIMM
>        Set: None
>        Locator: DIMM_4
>        Bank Locator: Not Specified
>        Type: DDR
>        Type Detail: Synchronous
>        Speed: 533 MHz (1.9 ns)
>        Manufacturer: FFFFFFFFFFFFFFFF
>        Serial Number: FFFFFFFF
>        Asset Tag: Not Specified
>        Part Number:  
> 
> Handle 0x1301, DMI type 19, 15 bytes
> Memory Array Mapped Address
>        Starting Address: 0x00000000000
>        Ending Address: 0x0003FFFFFFF
>        Range Size: 1 GB
>        Physical Array Handle: 0x1000
>        Partition Width: 0  
> 
> Handle 0x1402, DMI type 20, 19 bytes
> Memory Device Mapped Address
>        Starting Address: 0x00000000000
>        Ending Address: 0x0001FFFFFFF
>        Range Size: 512 MB
>        Physical Device Handle: 0x1100
>        Memory Array Mapped Address Handle: 0x1301
>        Partition Row Position: 1  
> 
> Handle 0x1403, DMI type 126, 19 bytes
> Inactive  
> 
> Handle 0x1404, DMI type 20, 19 bytes
> Memory Device Mapped Address
>        Starting Address: 0x00020000000
>        Ending Address: 0x0003FFFFFFF
>        Range Size: 512 MB
>        Physical Device Handle: 0x1102
>        Memory Array Mapped Address Handle: 0x1301
>        Partition Row Position: 1  
> 
> Handle 0x1405, DMI type 126, 19 bytes
> Inactive  
> 
> Handle 0x1800, DMI type 24, 5 bytes
> Hardware Security
>        Power-On Password Status: Enabled
>        Keyboard Password Status: Not Implemented
>        Administrator Password Status: Enabled
>        Front Panel Reset Status: Not Implemented  
> 
> Handle 0x1900, DMI type 25, 9 bytes
>        System Power Controls
>        Next Scheduled Power-on: *-* 00:00:00  
> 
> Handle 0x1B10, DMI type 27, 12 bytes
> Cooling Device
>        Type: Fan
>        Status: OK
>        OEM-specific Information: 0x0000DD00  
> 
> Handle 0x1B11, DMI type 126, 12 bytes
> Inactive  
> 
> Handle 0x1B12, DMI type 126, 12 bytes
> Inactive  
> 
> Handle 0x2000, DMI type 32, 11 bytes
> System Boot Information
>        Status: No errors detected  
> 
> Handle 0x8100, DMI type 129, 8 bytes
> OEM-specific Type
>        Header and Data:
>                81 08 00 81 01 01 02 01
>        Strings:
>                Intel_ASF
>                Dell_ASF_002  
> 
> Handle 0x8800, DMI type 136, 6 bytes
> OEM-specific Type
>        Header and Data:
>                88 06 00 88 5A 5A  
> 
> Handle 0xD000, DMI type 208, 10 bytes
> OEM-specific Type
>        Header and Data:
>                D0 0A 00 D0 01 03 FE 00 AD 01  
> 
> Handle 0xD100, DMI type 209, 12 bytes
> OEM-specific Type
>        Header and Data:
>                D1 0C 00 D1 78 03 07 03 04 0F 80 05  
> 
> Handle 0xD200, DMI type 210, 12 bytes
> OEM-specific Type
>        Header and Data:
>                D2 0C 00 D2 F8 03 04 03 06 80 04 05  
> 
> Handle 0xD201, DMI type 126, 12 bytes
> Inactive  
> 
> Handle 0xD400, DMI type 212, 252 bytes
> OEM-specific Type
>        Header and Data:
>                D4 FC 00 D4 70 00 71 00 00 10 2D 2E 42 00 11 FE
>                01 43 00 11 FE 00 0F 00 25 FC 00 10 00 25 FC 01
>                11 00 25 FC 02 12 00 25 FC 03 00 00 25 F3 00 00
>                00 25 F3 04 00 00 25 F3 08 00 00 25 F3 0C 07 00
>                23 8F 00 08 00 23 F3 00 09 00 23 F3 04 0A 00 23
>                F3 08 0B 00 23 8F 10 0C 00 23 8F 20 0E 00 23 8F
>                30 0D 00 23 8C 40 A6 00 23 8C 41 A7 00 23 8C 42
>                05 01 22 FD 02 06 01 22 FD 00 4E 01 28 DF 00 4F
>                01 28 DF 20 8C 00 22 FE 00 8D 00 22 FE 01 9B 00
>                25 3F 40 9C 00 25 3F 00 09 01 25 3F 80 A1 00 26
>                F3 00 A2 00 26 F3 08 A3 00 26 F3 04 9F 00 26 FD
>                02 A0 00 26 FD 00 9D 00 11 FB 04 9E 00 11 FB 00
>                54 01 23 7F 00 55 01 23 7F 80 5C 00 78 BF 40 5D
>                00 78 BF 00 04 80 78 F5 0A 01 A0 78 F5 00 93 00
>                7B 7F 80 94 00 7B 7F 00 8A 00 37 DF 20 8B 00 37
>                DF 00 03 C0 67 00 05 FF FF 00 00 00  
> 
> Handle 0xD401, DMI type 212, 207 bytes
> OEM-specific Type
>        Header and Data:
>                D4 CF 01 D4 70 00 71 00 03 40 59 6D 2D 00 59 FC
>                02 2E 00 59 FC 00 6E 00 59 FC 01 27 01 59 FC 03
>                28 00 59 3F 00 29 00 59 3F 40 2A 00 59 3F 80 2B
>                00 5A 00 00 2C 00 5B 00 00 55 00 59 F3 00 6D 00
>                59 F3 04 8E 00 59 F3 08 8F 00 59 F3 00 1C 00 55
>                FB 04 1D 00 55 FB 00 19 00 55 E7 00 1A 00 55 E7
>                08 1B 00 55 E7 10 23 00 55 7F 00 22 00 55 7F 80
>                F5 00 58 BF 40 F6 00 58 BF 00 EB 00 55 FE 00 EA
>                00 55 FE 01 01 01 51 3F 00 02 01 51 3F 40 03 01
>                51 3F 80 04 01 51 3F C0 40 01 54 EF 00 41 01 54
>                EF 10 42 01 54 F7 00 43 01 54 F7 08 4A 01 54 FB
>                00 4B 01 54 FB 04 4C 01 53 7F 00 4D 01 53 7F 80
>                68 01 56 BF 00 69 01 56 BF 40 FF FF 00 00 00  
> 
> Handle 0xD402, DMI type 212, 117 bytes
> OEM-specific Type
>        Header and Data:
>                D4 75 02 D4 70 00 71 00 00 10 2D 2E 2D 01 21 FE
>                01 2E 01 21 FE 00 2F 01 21 7F 00 30 01 21 7F 80
>                97 00 22 FB 00 98 00 22 FB 04 90 00 11 CF 00 91
>                00 11 CF 20 92 00 11 CF 10 E2 00 27 7F 00 E3 00
>                27 7F 80 E4 00 27 BF 00 E5 00 27 BF 40 D1 00 22
>                7F 80 D2 00 22 7F 00 3E 01 22 BF 40 3F 01 22 BF
>                00 36 01 21 F1 02 2B 01 11 7F 80 2C 01 11 7F 00
>                FF FF 00 00 00  
> 
> Handle 0xD403, DMI type 212, 97 bytes
> OEM-specific Type
>        Header and Data:
>                D4 61 03 D4 70 00 71 00 03 40 59 6D 17 01 52 FE
>                00 18 01 52 FE 01 19 01 52 FB 00 1A 01 52 FB 04
>                1B 01 52 FD 00 1C 01 52 FD 02 1D 01 52 F7 00 1E
>                01 52 F7 08 09 40 52 EF 00 08 40 52 EF 10 0B 40
>                52 DF 00 0A 40 52 DF 20 0D 40 52 BF 00 0C 40 52
>                BF 40 0F 40 52 7F 00 0E 40 52 7F 80 FF FF 00 00
>                00  
> 
> Handle 0xD800, DMI type 216, 9 bytes
> OEM-specific Type
>        Header and Data:
>                D8 09 00 D8 01 02 01 F0 03
>        Strings:
>                Intel(r)Lakeport-G PCI Accelerated SVGA BIOS
>                1215 PC Dev    03/11/2005  13:36:49  
> 
> Handle 0xDD00, DMI type 221, 19 bytes
> OEM-specific Type
>        Header and Data:
>                DD 13 00 DD 00 01 00 00 00 10 F5 00 00 00 00 00
>                00 00 00  
> 
> Handle 0xDD01, DMI type 221, 19 bytes
> OEM-specific Type
>        Header and Data:
>                DD 13 01 DD 00 01 00 00 00 11 F5 00 00 00 00 00
>                00 00 00  
> 
> Handle 0xDD02, DMI type 221, 19 bytes
> OEM-specific Type
>        Header and Data:
>                DD 13 02 DD 00 01 00 00 00 12 F5 00 00 00 00 00
>                00 00 00  
> 
> Handle 0xDE00, DMI type 222, 13 bytes
> OEM-specific Type
>        Header and Data:
>                DE 0D 00 DE C1 01 00 00 07 05 02 10 07  
> 
> Handle 0x7F00, DMI type 127, 4 bytes
> End Of Table
