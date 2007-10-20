From: Igor Lumpus <igor.lopez@bredband.net>
Subject: dmidecode output
Date: Sat, 20 Oct 2007 15:04:17 +0200
Message-ID: <1192885458.6114.3.camel@LOPEZMOB.bredbandsbolaget.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-io4adLkvZz8ngyMWTAEL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from proxy3.bredband.net ([195.54.101.73]:39775 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbXJTNEd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Oct 2007 09:04:33 -0400
Received: from ironport2.bredband.com (195.54.101.122) by proxy3.bredband.net (7.3.127)
        id 4713609E002254FB for linux-acpi@vger.kernel.org; Sat, 20 Oct 2007 15:04:31 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-io4adLkvZz8ngyMWTAEL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have just upgraded my Ubuntu 7.04 to 7.10 and got a problem with
sound.
Browsing thru dmesg i noticed these two rows
[   27.971829] ACPI: Please test with "acpi_osi=!Linux"
[   27.971830] Please send dmidecode to linux-acpi@vger.kernel.org

So I am sending the output of dmidecode and dmesg before and after
booting with suggested parameters.

One note is that booting with parameter acpi_osi=!Linux made it so that
my wifi network did not work and so all i did was capturing the dmesg
and dmidecode.


B.R
/Igor


--=-io4adLkvZz8ngyMWTAEL
Content-Disposition: attachment; filename=dmesg-output-after
Content-Type: text/plain; name=dmesg-output-after; charset=utf-8
Content-Transfer-Encoding: 7bit

[    0.000000] Linux version 2.6.22-14-386 (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 Sun Oct 14 22:36:54 GMT 2007 (Ubuntu 2.6.22-14.46-386)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff00000 (usable)
[    0.000000]  BIOS-e820: 000000007ff00000 - 000000007ff16000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff16000 - 000000007ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 1151MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f8910
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
[    0.000000] ACPI: RSDP signature @ 0xC00F88E0 checksum 0
[    0.000000] ACPI: RSDP 000F88E0, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 7FF0CCE2, 003C (r1 HPQOEM SLIC-MPC  6040000  LTP        0)
[    0.000000] ACPI: FACP 7FF15CCE, 0074 (r1 HP     MCP51M    6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 7FF0CD1E, 8FB0 (r1 HP       MCP51M  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 7FF16FC0, 0040
[    0.000000] ACPI: SSDT 7FF15D42, 01C4 (r1 HP     POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: MCFG 7FF15F06, 003C (r1 HP       MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 7FF15F42, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 7FF15F7A, 005E (r1 HP     	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 7FF15FD8, 0028 (r1     HP $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] Built 1 zonelists.  Total pages: 519938
[    0.000000] Kernel command line: root=UUID=3f05438a-3fca-4417-8c62-6dabcd8e9b98 ro quiet splash acpi?osi)!Linux
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1808.305 MHz processor.
[   56.509980] spurious 8259A interrupt: IRQ7.
[   56.512626] Console: colour VGA+ 80x25
[   56.512960] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   56.513368] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   56.568321] Memory: 2067356k/2096128k available (1929k kernel code, 27524k reserved, 877k data, 348k init, 1178624k highmem)
[   56.568332] virtual kernel memory layout:
[   56.568333]     fixmap  : 0xfffa8000 - 0xfffff000   ( 348 kB)
[   56.568335]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   56.568336]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   56.568337]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   56.568339]       .init : 0xc03c0000 - 0xc0417000   ( 348 kB)
[   56.568340]       .data : 0xc02e25d5 - 0xc03bda04   ( 877 kB)
[   56.568341]       .text : 0xc0100000 - 0xc02e25d5   (1929 kB)
[   56.568344] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   56.568390] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[   56.568534] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[   56.568539] hpet0: 3 32-bit timers, 25000000 Hz
[   56.649517] Calibrating delay using timer specific routine.. 3619.54 BogoMIPS (lpj=7239088)
[   56.649538] Security Framework v1.0.0 initialized
[   56.649544] SELinux:  Disabled at boot.
[   56.649550] Mount-cache hash table entries: 512
[   56.649641] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   56.649648] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   56.649651] CPU: L2 Cache: 512K (64 bytes/line)
[   56.649653] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   56.649662] Compat vDSO mapped to ffffe000.
[   56.649671] CPU: AMD Turion(tm) 64 X2 Mobile Technology TL-56 stepping 02
[   56.649675] Checking 'hlt' instruction... OK.
[   56.666009] Early unpacking initramfs... done
[   56.969897] ACPI: Core revision 20070126
[   56.969975] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   57.129524] ENABLING IO-APIC IRQs
[   57.129766] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   57.425102] APIC calibration not consistent with PM Timer: 247ms instead of 100ms
[   57.425105] APIC delta adjusted to PM-Timer: 1255713 (3114148)
[   57.425168] Booting paravirtualized kernel on bare hardware
[   57.425242] Time: 14:51:30  Date: 09/20/107
[   57.425259] NET: Registered protocol family 16
[   57.425318] EISA bus registered
[   57.425322] ACPI: bus type pci registered
[   57.440877] PCI: BIOS BUG #81[49435000] found
[   57.440923] PCI: Using configuration type 1
[   57.440925] Setting up standard PCI resources
[   57.442284] ACPI: EC: Look up EC in DSDT
[   57.442747] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   57.444101] ACPI: System BIOS is requesting _OSI(Linux)
[   57.444103] ACPI: Please test with "acpi_osi=!Linux"
[   57.444105] Please send dmidecode to linux-acpi@vger.kernel.org
[   57.444337] ACPI: Interpreter enabled
[   57.444339] ACPI: (supports S0 S3 S4 S5)
[   57.444351] ACPI: Using IOAPIC for interrupt routing
[   57.451337] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   57.451382] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   57.451390] PCI: Probing PCI hardware (bus 00)
[   57.452556] PCI: Transparent bridge - 0000:00:10.0
[   57.452587] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   57.452675] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   57.452698] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[   57.452727] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[   57.452756] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[   57.487304] ACPI: PCI Interrupt Link [LNK1] (IRQs 5) *0, disabled.
[   57.487498] ACPI: PCI Interrupt Link [LNK2] (IRQs 7) *11
[   57.487689] ACPI: PCI Interrupt Link [LNK3] (IRQs 10) *11
[   57.487879] ACPI: PCI Interrupt Link [LNK4] (IRQs 11) *0, disabled.
[   57.488069] ACPI: PCI Interrupt Link [LK1E] (IRQs 16) *11
[   57.488259] ACPI: PCI Interrupt Link [LK2E] (IRQs 17) *0, disabled.
[   57.488450] ACPI: PCI Interrupt Link [LK3E] (IRQs 18) *0, disabled.
[   57.488640] ACPI: PCI Interrupt Link [LK4E] (IRQs 19) *0, disabled.
[   57.488830] ACPI: PCI Interrupt Link [LSMB] (IRQs *10)
[   57.489020] ACPI: PCI Interrupt Link [LPMU] (IRQs 11) *10
[   57.489214] ACPI: PCI Interrupt Link [LUS0] (IRQs 22) *11
[   57.489405] ACPI: PCI Interrupt Link [LUS2] (IRQs 22) *7
[   57.489595] ACPI: PCI Interrupt Link [LMAC] (IRQs 20) *10
[   57.489786] ACPI: PCI Interrupt Link [LAZA] (IRQs 21) *0, disabled.
[   57.489981] ACPI: PCI Interrupt Link [LACI] (IRQs 21) *0, disabled.
[   57.490172] ACPI: PCI Interrupt Link [LMCI] (IRQs 21) *0, disabled.
[   57.490363] ACPI: PCI Interrupt Link [LPID] (IRQs 21) *0, disabled.
[   57.490562] ACPI: PCI Interrupt Link [LTID] (IRQs 23) *5
[   57.490758] ACPI: PCI Interrupt Link [LSI1] (IRQs 20) *10
[   57.490844] Linux Plug and Play Support v0.97 (c) Adam Belay
[   57.490853] pnp: PnP ACPI init
[   57.490859] ACPI: bus type pnp registered
[   57.493433] pnp: PnP ACPI: found 13 devices
[   57.493435] ACPI: ACPI bus type pnp unregistered
[   57.493438] PnPBIOS: Disabled by ACPI PNP
[   57.493474] PCI: Using ACPI for IRQ routing
[   57.493477] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   57.493562] NET: Registered protocol family 8
[   57.493564] NET: Registered protocol family 20
[   57.493611] pnp: 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[   57.493616] pnp: 00:01: iomem range 0xffc00000-0xffffffff could not be reserved
[   57.493620] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[   57.493623] pnp: 00:01: iomem range 0xfee00000-0xfeefffff could not be reserved
[   57.493626] pnp: 00:01: iomem range 0xfed00000-0xfed00fff has been reserved
[   57.493631] pnp: 00:03: iomem range 0xe0000000-0xefffffff could not be reserved
[   57.493635] pnp: 00:04: ioport range 0x1000-0x107f has been reserved
[   57.493638] pnp: 00:04: ioport range 0x1080-0x10ff has been reserved
[   57.493641] pnp: 00:04: ioport range 0x1400-0x147f has been reserved
[   57.493644] pnp: 00:04: ioport range 0x1480-0x14ff has been reserved
[   57.493646] pnp: 00:04: ioport range 0x1800-0x187f has been reserved
[   57.493649] pnp: 00:04: ioport range 0x1880-0x18ff has been reserved
[   57.493652] pnp: 00:04: ioport range 0x2000-0x203f has been reserved
[   57.497076] Time: tsc clocksource has been installed.
[   57.497087] Switched to high resolution mode on CPU 0
[   57.523854] PCI: Bridge: 0000:00:02.0
[   57.523856]   IO window: 4000-4fff
[   57.523859]   MEM window: c2000000-c3ffffff
[   57.523862]   PREFETCH window: c8200000-c83fffff
[   57.523864] PCI: Bridge: 0000:00:03.0
[   57.523866]   IO window: disabled.
[   57.523869]   MEM window: c4000000-c5ffffff
[   57.523871]   PREFETCH window: disabled.
[   57.523876] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
[   57.523926] PCI: Bridge: 0000:00:04.0
[   57.523928]   IO window: 5000-5fff
[   57.523931]   MEM window: c6000000-c7ffffff
[   57.523933]   PREFETCH window: d0000000-dfffffff
[   57.523936] PCI: Bridge: 0000:00:10.0
[   57.523938]   IO window: disabled.
[   57.523941]   MEM window: c8000000-c80fffff
[   57.523944]   PREFETCH window: disabled.
[   57.523955] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   57.523961] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   57.523967] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   57.523974] PCI: Setting latency timer of device 0000:00:10.0 to 64
[   57.523985] NET: Registered protocol family 2
[   57.561043] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   57.561146] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   57.561947] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   57.562182] TCP: Hash tables configured (established 131072 bind 65536)
[   57.562185] TCP reno registered
[   57.573134] checking if image is initramfs... it is
[   58.170055] Freeing initrd memory: 6761k freed
[   58.170136] Simple Boot Flag at 0x36 set to 0x1
[   58.170360] audit: initializing netlink socket (disabled)
[   58.170373] audit(1192891890.192:1): initialized
[   58.170415] highmem bounce pool size: 64 pages
[   58.171707] VFS: Disk quotas dquot_6.5.1
[   58.171718] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   58.171785] io scheduler noop registered
[   58.171787] io scheduler anticipatory registered
[   58.171789] io scheduler deadline registered
[   58.171802] io scheduler cfq registered (default)
[   58.388590] Boot video device is 0000:05:00.0
[   58.388661] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   58.388681] assign_interrupt_mode Found MSI capability
[   58.388683] Allocate Port Service[0000:00:02.0:pcie00]
[   58.388729] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   58.388748] assign_interrupt_mode Found MSI capability
[   58.388751] Allocate Port Service[0000:00:03.0:pcie00]
[   58.388793] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   58.388812] assign_interrupt_mode Found MSI capability
[   58.388814] Allocate Port Service[0000:00:04.0:pcie00]
[   58.388897] isapnp: Scanning for PnP cards...
[   58.742387] isapnp: No Plug & Play device found
[   58.760435] hpet_resources: 0xfed00000 is busy
[   58.760469] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   58.761291] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   58.761441] input: Macintosh mouse button emulation as /class/input/input0
[   58.761492] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   58.778977] serio: i8042 KBD port at 0x60,0x64 irq 1
[   58.778982] serio: i8042 AUX port at 0x60,0x64 irq 12
[   58.779093] mice: PS/2 mouse device common for all mice
[   58.780015] EISA: Probing bus 0 at eisa.0
[   58.780023] Cannot allocate resource for EISA slot 1
[   58.780025] Cannot allocate resource for EISA slot 2
[   58.780027] Cannot allocate resource for EISA slot 3
[   58.780030] Cannot allocate resource for EISA slot 4
[   58.780032] Cannot allocate resource for EISA slot 5
[   58.780044] EISA: Detected 0 cards.
[   58.780123] TCP cubic registered
[   58.780133] NET: Registered protocol family 1
[   58.780152] Using IPI Shortcut mode
[   58.780332]   Magic number: 11:351:890
[   58.780426]   hash matches device ptyy0
[   58.780721] Freeing unused kernel memory: 348k freed
[   58.812388] input: AT Translated Set 2 keyboard as /class/input/input1
[   59.999559] fuse init (API version 7.8)
[   60.005330] Capability LSM initialized
[   60.015603] ACPI: Thermal Zone [THRM] (71 C)
[   60.701546] usbcore: registered new interface driver usbfs
[   60.701566] usbcore: registered new interface driver hub
[   60.701582] usbcore: registered new device driver usb
[   60.702119] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   60.702476] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
[   60.702487] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 22 (level, high) -> IRQ 16
[   60.702499] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   60.702503] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[   60.702650] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[   60.702671] ohci_hcd 0000:00:0b.0: irq 16, io mem 0xc0004000
[   60.718559] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   60.718564] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   60.739721] SCSI subsystem initialized
[   60.743957] libata version 2.21 loaded.
[   60.765412] usb usb1: configuration #1 chosen from 1 choice
[   60.765438] hub 1-0:1.0: USB hub found
[   60.765449] hub 1-0:1.0: 8 ports detected
[   60.867777] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 22
[   60.867783] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 22 (level, high) -> IRQ 16
[   60.867794] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[   60.867797] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[   60.867821] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[   60.867853] ehci_hcd 0000:00:0b.1: debug port 1
[   60.867858] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[   60.867864] ehci_hcd 0000:00:0b.1: irq 16, io mem 0xc0005000
[   60.867876] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   60.867937] usb usb2: configuration #1 chosen from 1 choice
[   60.867957] hub 2-0:1.0: USB hub found
[   60.867963] hub 2-0:1.0: 8 ports detected
[   60.873782] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   60.971339] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[   60.971361] NFORCE-MCP51: chipset revision 241
[   60.971363] NFORCE-MCP51: not 100% native mode: will probe irqs later
[   60.971368] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[   60.971374] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[   60.971383]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:DMA, hdb:pio
[   60.971392] Probing IDE interface ide0...
[   62.591384] hda: TSSTcorpCD/DVDW TS-L632L, ATAPI CD/DVD-ROM drive
[   63.366080] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   63.380738] hda: drive still BUSY!
[   63.380741] hda: task_in_intr: status=0xd0 { Busy }
[   63.380744] ide: failed opcode was: 0xa1
[   63.384626] sata_nv 0000:00:0e.0: version 3.4
[   63.384642] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[   63.384968] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
[   63.384980] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 17
[   63.385018] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   63.385079] scsi0 : sata_nv
[   63.385250] scsi1 : sata_nv
[   63.385388] ata1: SATA max UDMA/133 cmd 0x000130c0 ctl 0x000130b6 bmdma 0x00013090 irq 17
[   63.385392] ata2: SATA max UDMA/133 cmd 0x000130b8 ctl 0x000130b2 bmdma 0x00013098 irq 17
[   63.403391] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
[   63.403399] Uniform CD-ROM driver Revision: 3.20
[   63.743062] usb 2-4: new high speed USB device using ehci_hcd and address 3
[   63.998968] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   64.127166] ata1.00: ATA-7: FUJITSU MHV2100BH PL, 892C, max UDMA/100
[   64.127169] ata1.00: 195371568 sectors, multi 16: LBA48 
[   64.256044] usb 2-4: configuration #1 chosen from 1 choice
[   64.261662] ata1.00: configured for UDMA/100
[   64.638791] ata2: SATA link down (SStatus 0 SControl 300)
[   64.650473] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 892C PQ: 0 ANSI: 5
[   64.650534] PCI: Enabling device 0000:00:0f.0 (0005 -> 0007)
[   64.650867] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 20
[   64.650880] ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LSI1] -> GSI 20 (level, high) -> IRQ 18
[   64.650919] PCI: Setting latency timer of device 0000:00:0f.0 to 64
[   64.650956] scsi2 : sata_nv
[   64.650986] scsi3 : sata_nv
[   64.651037] ata3: SATA max UDMA/133 cmd 0x000130d8 ctl 0x000130ce bmdma 0x000130a0 irq 18
[   64.651041] ata4: SATA max UDMA/133 cmd 0x000130d0 ctl 0x000130ca bmdma 0x000130a8 irq 18
[   65.022795] usb 2-5: new high speed USB device using ehci_hcd and address 4
[   65.278699] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   65.406900] ata3.00: ATA-7: FUJITSU MHV2100BH PL, 892C, max UDMA/100
[   65.406903] ata3.00: 195371568 sectors, multi 16: LBA48 
[   65.535115] usb 2-5: configuration #1 chosen from 1 choice
[   65.535196] hub 2-5:1.0: USB hub found
[   65.535299] hub 2-5:1.0: 7 ports detected
[   65.540975] ata3.00: configured for UDMA/100
[   65.918535] ata4: SATA link down (SStatus 0 SControl 300)
[   65.930226] scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 892C PQ: 0 ANSI: 5
[   65.930926] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
[   65.930938] ACPI: PCI Interrupt 0000:07:05.0[A] -> Link [LNK1] -> GSI 5 (level, high) -> IRQ 5
[   65.982956] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[c8000000-c80007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   65.987378] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 20
[   65.987382] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 20 (level, high) -> IRQ 18
[   65.987388] PCI: Setting latency timer of device 0000:00:14.0 to 64
[   65.987394] forcedeth: using HIGHDMA
[   66.001006] sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
[   66.001020] sd 0:0:0:0: [sda] Write Protect is off
[   66.001022] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   66.001034] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   66.001079] sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
[   66.001086] sd 0:0:0:0: [sda] Write Protect is off
[   66.001088] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   66.001098] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   66.001101]  sda: sda1 sda2 sda3 sda4 < sda5 >
[   66.399144] sd 0:0:0:0: [sda] Attached SCSI disk
[   66.399272] sd 2:0:0:0: [sdb] 195371568 512-byte hardware sectors (100030 MB)
[   66.399281] sd 2:0:0:0: [sdb] Write Protect is off
[   66.399284] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   66.399294] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   66.399327] sd 2:0:0:0: [sdb] 195371568 512-byte hardware sectors (100030 MB)
[   66.399334] sd 2:0:0:0: [sdb] Write Protect is off
[   66.399336] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   66.399345] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   66.399348]  sdb: sdb1 sdb2 < sdb5 >
[   66.499083] sd 2:0:0:0: [sdb] Attached SCSI disk
[   66.502847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   66.502867] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   66.512448] eth0: forcedeth.c: subsystem: 0103c:30b7 bound to 0000:00:14.0
[   66.532150] usb 1-3: new full speed USB device using ohci_hcd and address 2
[   66.774922] Attempting manual resume
[   66.774926] swsusp: Resume From Partition 8:21
[   66.774928] PM: Checking swsusp image.
[   66.775159] PM: Resume from disk failed.
[   66.778364] usb 1-3: configuration #1 chosen from 1 choice
[   66.864153] kjournald starting.  Commit interval 5 seconds
[   66.864165] EXT3-fs: mounted filesystem with ordered data mode.
[   67.096371] usb 1-6: new low speed USB device using ohci_hcd and address 3
[   67.282005] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b0015c51400]
[   67.329059] usb 1-6: configuration #1 chosen from 1 choice
[   67.563486] usb 2-5.5: new low speed USB device using ehci_hcd and address 6
[   67.682371] usb 2-5.5: configuration #1 chosen from 1 choice
[   79.100600] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   79.103032] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   79.301383] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   79.301411] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   79.907500] sdhci: Secure Digital Host Controller Interface driver
[   79.907503] sdhci: Copyright(c) Pierre Ossman
[   79.907540] sdhci: SDHCI controller found at 0000:07:05.1 [1180:0822] (rev 19)
[   79.907879] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 7
[   79.907892] ACPI: PCI Interrupt 0000:07:05.1[B] -> Link [LNK2] -> GSI 7 (level, high) -> IRQ 7
[   79.907963] mmc0: SDHCI at 0xc8000800 irq 7 DMA
[   80.049272] Linux agpgart interface v0.102 (c) Dave Jones
[   80.193220] input: PC Speaker as /class/input/input2
[   80.217306] Real Time Clock Driver v1.12ac
[   80.237560] ieee80211_crypt: registered algorithm 'NULL'
[   80.254182] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   80.254186] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   80.354347] nvidia: module license 'NVIDIA' taints kernel.
[   80.609421] bcm43xx driver
[   80.609843] ACPI: PCI Interrupt Link [LK4E] enabled at IRQ 19
[   80.609855] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK4E] -> GSI 19 (level, high) -> IRQ 19
[   80.609865] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   80.720974] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 16
[   80.720987] ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LK1E] -> GSI 16 (level, high) -> IRQ 20
[   80.720996] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   80.721208] NVRM: loading NVIDIA UNIX x86 Kernel Module  100.14.19  Wed Sep 12 14:12:24 PDT 2007
[   80.939023] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
[   81.003106] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[   81.110339] Bluetooth: Core ver 2.11
[   81.110379] NET: Registered protocol family 31
[   81.110381] Bluetooth: HCI device and connection manager initialized
[   81.110384] Bluetooth: HCI socket layer initialized
[   81.127120] Bluetooth: HCI USB driver ver 2.9
[   81.135244] usbcore: registered new interface driver hci_usb
[   82.259173] usbcore: registered new interface driver hiddev
[   82.797434] input: Logitech Optical USB Mouse as /class/input/input4
[   82.797666] input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:0b.0-6
[   82.799938] input: Logitech USB Receiver as /class/input/input5
[   82.800064] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:0b.1-5.5
[   82.805580] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: Fixing up Logitech keyboard report descriptor
[   82.806103] input: Logitech USB Receiver as /class/input/input6
[   82.806485] input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:0b.1-5.5
[   82.806495] usbcore: registered new interface driver usbhid
[   82.806498] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   91.570828] lp: driver loaded but no devices found
[   91.657366] Adding 4016208k swap on /dev/sdb5.  Priority:-1 extents:1 across:4016208k
[   92.190386] EXT3 FS on sdb1, internal journal
[   93.023659] kjournald starting.  Commit interval 5 seconds
[   93.024001] EXT3 FS on sda5, internal journal
[   93.024005] EXT3-fs: mounted filesystem with ordered data mode.
[   93.050467] FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   94.427642] No dock devices found.
[   94.776620] input: Power Button (FF) as /class/input/input7
[   94.780905] ACPI: Power Button (FF) [PWRF]
[   94.814229] input: Power Button (CM) as /class/input/input8
[   94.818491] ACPI: Power Button (CM) [PWRB]
[   94.851701] input: Sleep Button (CM) as /class/input/input9
[   94.855913] ACPI: Sleep Button (CM) [SLPB]
[   94.889053] input: Lid Switch as /class/input/input10
[   94.893299] ACPI: Lid Switch [LID]
[   95.097407] ACPI: Battery Slot [BAT0] (battery present)
[   95.366239] ACPI: AC Adapter [ACAD] (on-line)
[   95.393029] ACPI: Video Device [UVGA] (multi-head: yes  rom: no  post: no)
[   95.395689] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   95.575354] powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-56 processors (version 2.00.00)
[   95.575386] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x13
[   95.575389] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x15
[   95.575391] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x1e
[   98.040758] eth1: no link during initialization.
[  102.721930] ppdev: user-space parallel port driver
[  106.556185] apm: BIOS not found.
[   50.016000] Marking TSC unstable due to: cpufreq changes.
[   50.020000] Time: hpet clocksource has been installed.
[   50.300000] Capability LSM initialized
[   50.500000] Clocksource tsc unstable (delta = -271560801 ns)
[   51.240000] Bluetooth: L2CAP ver 2.8
[   51.240000] Bluetooth: L2CAP socket layer initialized
[   51.248000] Bluetooth: RFCOMM socket layer initialized
[   51.248000] Bluetooth: RFCOMM TTY layer initialized
[   51.248000] Bluetooth: RFCOMM ver 1.8
[   88.076000] NET: Registered protocol family 17

--=-io4adLkvZz8ngyMWTAEL
Content-Disposition: attachment; filename=dmesg-output-before
Content-Type: text/plain; name=dmesg-output-before; charset=utf-8
Content-Transfer-Encoding: 7bit

[    0.000000] Linux version 2.6.22-14-386 (buildd@palmer) (gcc version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 Sun Oct 14 22:36:54 GMT 2007 (Ubuntu 2.6.22-14.46-386)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
[    0.000000]  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff00000 (usable)
[    0.000000]  BIOS-e820: 000000007ff00000 - 000000007ff16000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff16000 - 000000007ff80000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 1151MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f8910
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
[    0.000000] ACPI: RSDP signature @ 0xC00F88E0 checksum 0
[    0.000000] ACPI: RSDP 000F88E0, 0014 (r0 HP    )
[    0.000000] ACPI: RSDT 7FF0CCE2, 003C (r1 HPQOEM SLIC-MPC  6040000  LTP        0)
[    0.000000] ACPI: FACP 7FF15CCE, 0074 (r1 HP     MCP51M    6040000 PTL_    F4240)
[    0.000000] ACPI: DSDT 7FF0CD1E, 8FB0 (r1 HP       MCP51M  6040000 MSFT  3000000)
[    0.000000] ACPI: FACS 7FF16FC0, 0040
[    0.000000] ACPI: SSDT 7FF15D42, 01C4 (r1 HP     POWERNOW  6040000  LTP        1)
[    0.000000] ACPI: MCFG 7FF15F06, 003C (r1 HP       MCFG    6040000  LTP        0)
[    0.000000] ACPI: HPET 7FF15F42, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
[    0.000000] ACPI: APIC 7FF15F7A, 005E (r1 HP     	 APIC    6040000  LTP        0)
[    0.000000] ACPI: BOOT 7FF15FD8, 0028 (r1     HP $SBFTBL$  6040000  LTP        1)
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:8 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:8 APIC version 16
[    0.000000] WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
[    0.000000] Built 1 zonelists.  Total pages: 519938
[    0.000000] Kernel command line: root=UUID=3f05438a-3fca-4417-8c62-6dabcd8e9b98 ro quiet splash
[    0.000000] mapped APIC to ffffd000 (fee00000)
[    0.000000] mapped IOAPIC to ffffc000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 1808.284 MHz processor.
[   27.037703] spurious 8259A interrupt: IRQ7.
[   27.040350] Console: colour VGA+ 80x25
[   27.040685] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   27.041092] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   27.096159] Memory: 2067356k/2096128k available (1929k kernel code, 27524k reserved, 877k data, 348k init, 1178624k highmem)
[   27.096170] virtual kernel memory layout:
[   27.096171]     fixmap  : 0xfffa8000 - 0xfffff000   ( 348 kB)
[   27.096172]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   27.096173]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   27.096175]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   27.096176]       .init : 0xc03c0000 - 0xc0417000   ( 348 kB)
[   27.096177]       .data : 0xc02e25d5 - 0xc03bda04   ( 877 kB)
[   27.096179]       .text : 0xc0100000 - 0xc02e25d5   (1929 kB)
[   27.096181] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   27.096227] SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
[   27.096371] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31
[   27.096376] hpet0: 3 32-bit timers, 25000000 Hz
[   27.177354] Calibrating delay using timer specific routine.. 3619.48 BogoMIPS (lpj=7238964)
[   27.177375] Security Framework v1.0.0 initialized
[   27.177381] SELinux:  Disabled at boot.
[   27.177387] Mount-cache hash table entries: 512
[   27.177478] CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001f
[   27.177486] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   27.177488] CPU: L2 Cache: 512K (64 bytes/line)
[   27.177491] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001f
[   27.177499] Compat vDSO mapped to ffffe000.
[   27.177508] CPU: AMD Turion(tm) 64 X2 Mobile Technology TL-56 stepping 02
[   27.177513] Checking 'hlt' instruction... OK.
[   27.193846] Early unpacking initramfs... done
[   27.497731] ACPI: Core revision 20070126
[   27.497809] ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
[   27.657376] ENABLING IO-APIC IRQs
[   27.657618] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   27.952939] APIC calibration not consistent with PM Timer: 247ms instead of 100ms
[   27.952942] APIC delta adjusted to PM-Timer: 1255712 (3114147)
[   27.953004] Booting paravirtualized kernel on bare hardware
[   27.953078] Time: 14:04:48  Date: 09/20/107
[   27.953095] NET: Registered protocol family 16
[   27.953155] EISA bus registered
[   27.953159] ACPI: bus type pci registered
[   27.968611] PCI: BIOS BUG #81[49435000] found
[   27.968658] PCI: Using configuration type 1
[   27.968660] Setting up standard PCI resources
[   27.970011] ACPI: EC: Look up EC in DSDT
[   27.970474] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   27.971827] ACPI: System BIOS is requesting _OSI(Linux)
[   27.971829] ACPI: Please test with "acpi_osi=!Linux"
[   27.971830] Please send dmidecode to linux-acpi@vger.kernel.org
[   27.972062] ACPI: Interpreter enabled
[   27.972065] ACPI: (supports S0 S3 S4 S5)
[   27.972077] ACPI: Using IOAPIC for interrupt routing
[   27.979025] ACPI: EC: GPE=0x10, ports=0x66, 0x62
[   27.979070] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   27.979077] PCI: Probing PCI hardware (bus 00)
[   27.980240] PCI: Transparent bridge - 0000:00:10.0
[   27.980271] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   27.980359] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   27.980382] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[   27.980411] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR1._PRT]
[   27.980440] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR2._PRT]
[   28.014990] ACPI: PCI Interrupt Link [LNK1] (IRQs 5) *0, disabled.
[   28.015184] ACPI: PCI Interrupt Link [LNK2] (IRQs 7) *11
[   28.015374] ACPI: PCI Interrupt Link [LNK3] (IRQs 10) *11
[   28.015564] ACPI: PCI Interrupt Link [LNK4] (IRQs 11) *0, disabled.
[   28.015755] ACPI: PCI Interrupt Link [LK1E] (IRQs 16) *11
[   28.015945] ACPI: PCI Interrupt Link [LK2E] (IRQs 17) *0, disabled.
[   28.016135] ACPI: PCI Interrupt Link [LK3E] (IRQs 18) *0, disabled.
[   28.016325] ACPI: PCI Interrupt Link [LK4E] (IRQs 19) *0, disabled.
[   28.016516] ACPI: PCI Interrupt Link [LSMB] (IRQs *10)
[   28.016705] ACPI: PCI Interrupt Link [LPMU] (IRQs 11) *10
[   28.016896] ACPI: PCI Interrupt Link [LUS0] (IRQs 22) *11
[   28.017191] ACPI: PCI Interrupt Link [LUS2] (IRQs 22) *7
[   28.017383] ACPI: PCI Interrupt Link [LMAC] (IRQs 20) *10
[   28.017573] ACPI: PCI Interrupt Link [LAZA] (IRQs 21) *0, disabled.
[   28.017768] ACPI: PCI Interrupt Link [LACI] (IRQs 21) *0, disabled.
[   28.017959] ACPI: PCI Interrupt Link [LMCI] (IRQs 21) *0, disabled.
[   28.018150] ACPI: PCI Interrupt Link [LPID] (IRQs 21) *0, disabled.
[   28.018349] ACPI: PCI Interrupt Link [LTID] (IRQs 23) *5
[   28.018546] ACPI: PCI Interrupt Link [LSI1] (IRQs 20) *10
[   28.018635] Linux Plug and Play Support v0.97 (c) Adam Belay
[   28.018643] pnp: PnP ACPI init
[   28.018650] ACPI: bus type pnp registered
[   28.021198] pnp: PnP ACPI: found 13 devices
[   28.021200] ACPI: ACPI bus type pnp unregistered
[   28.021204] PnPBIOS: Disabled by ACPI PNP
[   28.021241] PCI: Using ACPI for IRQ routing
[   28.021243] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   28.021329] NET: Registered protocol family 8
[   28.021331] NET: Registered protocol family 20
[   28.021380] pnp: 00:00: iomem range 0xe0000000-0xefffffff could not be reserved
[   28.021386] pnp: 00:01: iomem range 0xffc00000-0xffffffff could not be reserved
[   28.021389] pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
[   28.021392] pnp: 00:01: iomem range 0xfee00000-0xfeefffff could not be reserved
[   28.021395] pnp: 00:01: iomem range 0xfed00000-0xfed00fff has been reserved
[   28.021400] pnp: 00:03: iomem range 0xe0000000-0xefffffff could not be reserved
[   28.021405] pnp: 00:04: ioport range 0x1000-0x107f has been reserved
[   28.021407] pnp: 00:04: ioport range 0x1080-0x10ff has been reserved
[   28.021410] pnp: 00:04: ioport range 0x1400-0x147f has been reserved
[   28.021413] pnp: 00:04: ioport range 0x1480-0x14ff has been reserved
[   28.021416] pnp: 00:04: ioport range 0x1800-0x187f has been reserved
[   28.021418] pnp: 00:04: ioport range 0x1880-0x18ff has been reserved
[   28.021421] pnp: 00:04: ioport range 0x2000-0x203f has been reserved
[   28.024913] Time: tsc clocksource has been installed.
[   28.024924] Switched to high resolution mode on CPU 0
[   28.051620] PCI: Bridge: 0000:00:02.0
[   28.051622]   IO window: 4000-4fff
[   28.051625]   MEM window: c2000000-c3ffffff
[   28.051627]   PREFETCH window: c8200000-c83fffff
[   28.051630] PCI: Bridge: 0000:00:03.0
[   28.051631]   IO window: disabled.
[   28.051634]   MEM window: c4000000-c5ffffff
[   28.051636]   PREFETCH window: disabled.
[   28.051641] PCI: Failed to allocate mem resource #6:20000@e0000000 for 0000:05:00.0
[   28.051691] PCI: Bridge: 0000:00:04.0
[   28.051693]   IO window: 5000-5fff
[   28.051695]   MEM window: c6000000-c7ffffff
[   28.051698]   PREFETCH window: d0000000-dfffffff
[   28.051701] PCI: Bridge: 0000:00:10.0
[   28.051702]   IO window: disabled.
[   28.051706]   MEM window: c8000000-c80fffff
[   28.051708]   PREFETCH window: disabled.
[   28.051719] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   28.051725] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   28.051730] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   28.051738] PCI: Setting latency timer of device 0000:00:10.0 to 64
[   28.051749] NET: Registered protocol family 2
[   28.088877] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   28.088974] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   28.089773] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   28.090008] TCP: Hash tables configured (established 131072 bind 65536)
[   28.090011] TCP reno registered
[   28.100969] checking if image is initramfs... it is
[   28.697503] Freeing initrd memory: 6761k freed
[   28.697584] Simple Boot Flag at 0x36 set to 0x1
[   28.697809] audit: initializing netlink socket (disabled)
[   28.697821] audit(1192889088.192:1): initialized
[   28.697863] highmem bounce pool size: 64 pages
[   28.699154] VFS: Disk quotas dquot_6.5.1
[   28.699165] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   28.699231] io scheduler noop registered
[   28.699233] io scheduler anticipatory registered
[   28.699235] io scheduler deadline registered
[   28.699248] io scheduler cfq registered (default)
[   28.916421] Boot video device is 0000:05:00.0
[   28.916493] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   28.916516] assign_interrupt_mode Found MSI capability
[   28.916518] Allocate Port Service[0000:00:02.0:pcie00]
[   28.916568] PCI: Setting latency timer of device 0000:00:03.0 to 64
[   28.916590] assign_interrupt_mode Found MSI capability
[   28.916593] Allocate Port Service[0000:00:03.0:pcie00]
[   28.916639] PCI: Setting latency timer of device 0000:00:04.0 to 64
[   28.916662] assign_interrupt_mode Found MSI capability
[   28.916664] Allocate Port Service[0000:00:04.0:pcie00]
[   28.916751] isapnp: Scanning for PnP cards...
[   29.270169] isapnp: No Plug & Play device found
[   29.288398] hpet_resources: 0xfed00000 is busy
[   29.288431] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   29.289259] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   29.289409] input: Macintosh mouse button emulation as /class/input/input0
[   29.289460] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   29.306497] serio: i8042 KBD port at 0x60,0x64 irq 1
[   29.306501] serio: i8042 AUX port at 0x60,0x64 irq 12
[   29.306610] mice: PS/2 mouse device common for all mice
[   29.307672] EISA: Probing bus 0 at eisa.0
[   29.307680] Cannot allocate resource for EISA slot 1
[   29.307682] Cannot allocate resource for EISA slot 2
[   29.307684] Cannot allocate resource for EISA slot 3
[   29.307687] Cannot allocate resource for EISA slot 4
[   29.307689] Cannot allocate resource for EISA slot 5
[   29.307701] EISA: Detected 0 cards.
[   29.307780] TCP cubic registered
[   29.307790] NET: Registered protocol family 1
[   29.307809] Using IPI Shortcut mode
[   29.307986]   Magic number: 11:524:81
[   29.308376] Freeing unused kernel memory: 348k freed
[   29.344212] input: AT Translated Set 2 keyboard as /class/input/input1
[   30.528527] fuse init (API version 7.8)
[   30.534317] Capability LSM initialized
[   30.544516] ACPI: Thermal Zone [THRM] (67 C)
[   31.224944] usbcore: registered new interface driver usbfs
[   31.224964] usbcore: registered new interface driver hub
[   31.224980] usbcore: registered new device driver usb
[   31.225520] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[   31.225877] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 22
[   31.225889] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LUS0] -> GSI 22 (level, high) -> IRQ 16
[   31.225900] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[   31.225904] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[   31.226052] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[   31.226074] ohci_hcd 0000:00:0b.0: irq 16, io mem 0xc0004000
[   31.244728] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   31.244733] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   31.257690] SCSI subsystem initialized
[   31.275183] libata version 2.21 loaded.
[   31.291460] forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
[   31.325203] usb usb1: configuration #1 chosen from 1 choice
[   31.325227] hub 1-0:1.0: USB hub found
[   31.325239] hub 1-0:1.0: 8 ports detected
[   31.427341] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[   31.427363] NFORCE-MCP51: chipset revision 241
[   31.427365] NFORCE-MCP51: not 100% native mode: will probe irqs later
[   31.427370] NFORCE-MCP51: BIOS didn't set cable bits correctly. Enabling workaround.
[   31.427376] NFORCE-MCP51: 0000:00:0d.0 (rev f1) UDMA133 controller
[   31.427385]     ide0: BM-DMA at 0x3080-0x3087, BIOS settings: hda:DMA, hdb:pio
[   31.427396] Probing IDE interface ide0...
[   31.972587] usb 1-3: new full speed USB device using ohci_hcd and address 2
[   32.509556] usb 1-3: configuration #1 chosen from 1 choice
[   32.868533] hda: TSSTcorpCD/DVDW TS-L632L, ATAPI CD/DVD-ROM drive
[   33.124327] usb 1-4: new full speed USB device using ohci_hcd and address 3
[   33.643545] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   33.661138] sata_nv 0000:00:0e.0: version 3.4
[   33.661156] PCI: Enabling device 0000:00:0e.0 (0005 -> 0007)
[   33.661486] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
[   33.661498] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 17
[   33.661536] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[   33.661597] scsi0 : sata_nv
[   33.661780] scsi1 : sata_nv
[   33.661944] ata1: SATA max UDMA/133 cmd 0x000130c0 ctl 0x000130b6 bmdma 0x00013090 irq 17
[   33.661948] ata2: SATA max UDMA/133 cmd 0x000130b8 ctl 0x000130b2 bmdma 0x00013098 irq 17
[   33.664961] usb 1-4: configuration #1 chosen from 1 choice
[   33.682182] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
[   33.682190] Uniform CD-ROM driver Revision: 3.20
[   34.276120] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   34.276234] usb 1-5: new full speed USB device using ohci_hcd and address 4
[   34.404327] ata1.00: ATA-7: FUJITSU MHV2100BH PL, 892C, max UDMA/100
[   34.404330] ata1.00: 195371568 sectors, multi 16: LBA48 
[   34.660274] ata1.00: configured for UDMA/100
[   34.923281] usb 1-5: configuration #1 chosen from 1 choice
[   34.926262] hub 1-5:1.0: USB hub found
[   34.929216] hub 1-5:1.0: 7 ports detected
[   35.043942] ata2: SATA link down (SStatus 0 SControl 300)
[   35.055745] scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 892C PQ: 0 ANSI: 5
[   35.055810] PCI: Enabling device 0000:00:0f.0 (0005 -> 0007)
[   35.056137] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 20
[   35.056149] ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LSI1] -> GSI 20 (level, high) -> IRQ 18
[   35.056188] PCI: Setting latency timer of device 0000:00:0f.0 to 64
[   35.056225] scsi2 : sata_nv
[   35.056253] scsi3 : sata_nv
[   35.056306] ata3: SATA max UDMA/133 cmd 0x000130d8 ctl 0x000130ce bmdma 0x000130a0 irq 18
[   35.056310] ata4: SATA max UDMA/133 cmd 0x000130d0 ctl 0x000130ca bmdma 0x000130a8 irq 18
[   35.512903] usb 1-6: new low speed USB device using ohci_hcd and address 5
[   35.544908] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   35.556102] ata3.00: ATA-7: FUJITSU MHV2100BH PL, 892C, max UDMA/100
[   35.556106] ata3.00: 195371568 sectors, multi 16: LBA48 
[   35.609119] ata3.00: configured for UDMA/100
[   35.785826] usb 1-6: configuration #1 chosen from 1 choice
[   36.067714] ata4: SATA link down (SStatus 0 SControl 300)
[   36.079414] scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 892C PQ: 0 ANSI: 5
[   36.080130] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 20
[   36.080134] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LMAC] -> GSI 20 (level, high) -> IRQ 18
[   36.080141] PCI: Setting latency timer of device 0000:00:14.0 to 64
[   36.080148] forcedeth: using HIGHDMA
[   36.093092] sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
[   36.093106] sd 0:0:0:0: [sda] Write Protect is off
[   36.093108] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   36.093119] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.093164] sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
[   36.093171] sd 0:0:0:0: [sda] Write Protect is off
[   36.093173] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   36.093183] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.093187]  sda:<6>usb 1-5.5: new low speed USB device using ohci_hcd and address 6
[   36.447761]  sda1 sda2 sda3 sda4 <<6>usb 1-5.5: configuration #1 chosen from 1 choice
[   36.475410] usbcore: registered new interface driver hiddev
[   36.480544] input: Logitech Optical USB Mouse as /class/input/input2
[   36.480563] input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:0b.0-6
[   36.485520] input: Logitech USB Receiver as /class/input/input3
[   36.485528] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:0b.0-5.5
[   36.495393] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: Fixing up Logitech keyboard report descriptor
[   36.495827] input: Logitech USB Receiver as /class/input/input4
[   36.495878] input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:0b.0-5.5
[   36.495890] usbcore: registered new interface driver usbhid
[   36.495892] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   36.497120]  sda5 >
[   36.497213] sd 0:0:0:0: [sda] Attached SCSI disk
[   36.500198] sd 2:0:0:0: [sdb] 195371568 512-byte hardware sectors (100030 MB)
[   36.504199] sd 2:0:0:0: [sdb] Write Protect is off
[   36.504204] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   36.512203] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.520201] sd 2:0:0:0: [sdb] 195371568 512-byte hardware sectors (100030 MB)
[   36.524192] sd 2:0:0:0: [sdb] Write Protect is off
[   36.524197] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   36.530702] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   36.530708]  sdb: sdb1 sdb2 <<6>eth0: forcedeth.c: subsystem: 0103c:30b7 bound to 0000:00:14.0
[   36.627489]  sdb5 >
[   36.627551] sd 2:0:0:0: [sdb] Attached SCSI disk
[   36.631006] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   36.631023] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   36.636471] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 22
[   36.636477] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LUS2] -> GSI 22 (level, high) -> IRQ 16
[   36.636489] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[   36.636493] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[   36.636524] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
[   36.636557] ehci_hcd 0000:00:0b.1: debug port 1
[   36.636562] PCI: cache line size of 64 is not supported by device 0000:00:0b.1
[   36.636569] ehci_hcd 0000:00:0b.1: irq 16, io mem 0xc0005000
[   36.636581] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   36.636626] usb 1-3: USB disconnect, address 2
[   36.636929] usb usb2: configuration #1 chosen from 1 choice
[   36.636950] hub 2-0:1.0: USB hub found
[   36.636955] hub 2-0:1.0: 8 ports detected
[   36.742499] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
[   36.742513] ACPI: PCI Interrupt 0000:07:05.0[A] -> Link [LNK1] -> GSI 5 (level, high) -> IRQ 5
[   36.792298] usb 1-4: USB disconnect, address 3
[   36.794498] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[c8000000-c80007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   36.923956] usb 1-5: USB disconnect, address 4
[   36.923960] usb 1-5.5: USB disconnect, address 6
[   36.942948] Attempting manual resume
[   36.942952] swsusp: Resume From Partition 8:21
[   36.942953] PM: Checking swsusp image.
[   36.948289] PM: Resume from disk failed.
[   37.003469] kjournald starting.  Commit interval 5 seconds
[   37.003480] EXT3-fs: mounted filesystem with ordered data mode.
[   37.072271] usb 1-6: USB disconnect, address 5
[   37.731370] usb 2-4: new high speed USB device using ehci_hcd and address 3
[   37.911368] usb 2-4: configuration #1 chosen from 1 choice
[   38.141832] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00241b0015c51400]
[   38.171291] usb 2-5: new high speed USB device using ehci_hcd and address 4
[   38.312657] usb 2-5: configuration #1 chosen from 1 choice
[   38.312729] hub 2-5:1.0: USB hub found
[   38.312836] hub 2-5:1.0: 7 ports detected
[   38.920532] usb 1-3: new full speed USB device using ohci_hcd and address 7
[   39.174039] usb 1-3: configuration #1 chosen from 1 choice
[   39.509820] usb 1-6: new low speed USB device using ohci_hcd and address 8
[   39.748721] usb 1-6: configuration #1 chosen from 1 choice
[   39.758785] input: Logitech Optical USB Mouse as /class/input/input5
[   39.758800] input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:0b.0-6
[   39.984089] usb 2-5.5: new low speed USB device using ehci_hcd and address 6
[   40.103841] usb 2-5.5: configuration #1 chosen from 1 choice
[   40.106558] input: Logitech USB Receiver as /class/input/input6
[   40.106572] input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:0b.1-5.5
[   40.112017] /build/buildd/linux-source-2.6.22-2.6.22/drivers/hid/usbhid/hid-core.c: Fixing up Logitech keyboard report descriptor
[   40.112423] input: Logitech USB Receiver as /class/input/input7
[   40.112464] input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:0b.1-5.5
[   49.586473] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   49.592672] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   50.482123] ieee80211_crypt: registered algorithm 'NULL'
[   50.685501] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   50.685505] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   50.708666] Linux agpgart interface v0.102 (c) Dave Jones
[   50.764826] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x3040
[   50.764852] i2c-adapter i2c-1: nForce2 SMBus adapter at 0x3000
[   50.980149] Bluetooth: Core ver 2.11
[   50.980447] NET: Registered protocol family 31
[   50.980449] Bluetooth: HCI device and connection manager initialized
[   50.980452] Bluetooth: HCI socket layer initialized
[   50.989947] sdhci: Secure Digital Host Controller Interface driver
[   50.989951] sdhci: Copyright(c) Pierre Ossman
[   50.990004] sdhci: SDHCI controller found at 0000:07:05.1 [1180:0822] (rev 19)
[   50.990339] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 7
[   50.990352] ACPI: PCI Interrupt 0000:07:05.1[B] -> Link [LNK2] -> GSI 7 (level, high) -> IRQ 7
[   50.990422] mmc0: SDHCI at 0xc8000800 irq 7 DMA
[   51.074305] nvidia: module license 'NVIDIA' taints kernel.
[   51.403677] ACPI: PCI Interrupt Link [LK1E] enabled at IRQ 16
[   51.403691] ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [LK1E] -> GSI 16 (level, high) -> IRQ 19
[   51.403700] PCI: Setting latency timer of device 0000:05:00.0 to 64
[   51.403922] NVRM: loading NVIDIA UNIX x86 Kernel Module  100.14.19  Wed Sep 12 14:12:24 PDT 2007
[   51.434559] bcm43xx driver
[   51.434979] ACPI: PCI Interrupt Link [LK4E] enabled at IRQ 19
[   51.434989] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LK4E] -> GSI 19 (level, high) -> IRQ 20
[   51.434999] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   51.642066] Bluetooth: HCI USB driver ver 2.9
[   51.643588] usbcore: registered new interface driver hci_usb
[   51.644870] input: PC Speaker as /class/input/input8
[   51.662366] Real Time Clock Driver v1.12ac
[   52.067129] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x200000
[   52.129801] input: SynPS/2 Synaptics TouchPad as /class/input/input9
[   53.049226] NET: Registered protocol family 17
[   62.698838] lp: driver loaded but no devices found
[   62.785383] Adding 4016208k swap on /dev/sdb5.  Priority:-1 extents:1 across:4016208k
[   63.177486] EXT3 FS on sdb1, internal journal
[  119.979159] NET: Registered protocol family 10
[  119.979233] lo: Disabled Privacy Extensions
[  119.979289] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  241.240795] kjournald starting.  Commit interval 5 seconds
[  241.241150] EXT3 FS on sda5, internal journal
[  241.241155] EXT3-fs: mounted filesystem with ordered data mode.
[  241.297835] FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[  242.675844] No dock devices found.
[  242.768111] input: Power Button (FF) as /class/input/input10
[  242.772457] ACPI: Power Button (FF) [PWRF]
[  242.805787] input: Power Button (CM) as /class/input/input11
[  242.810113] ACPI: Power Button (CM) [PWRB]
[  242.844040] input: Sleep Button (CM) as /class/input/input12
[  242.848339] ACPI: Sleep Button (CM) [SLPB]
[  242.882304] input: Lid Switch as /class/input/input13
[  242.886583] ACPI: Lid Switch [LID]
[  242.962917] ACPI: Battery Slot [BAT0] (battery present)
[  243.021042] ACPI: AC Adapter [ACAD] (on-line)
[  243.047539] ACPI: Video Device [UVGA] (multi-head: yes  rom: no  post: no)
[  243.050223] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[  243.289729] powernow-k8: Found 1 AMD Turion(tm) 64 X2 Mobile Technology TL-56 processors (version 2.00.00)
[  243.289761] powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x13
[  243.289764] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x15
[  243.289767] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x1e
[  245.238324] eth1: no link during initialization.
[  245.238997] ADDRCONF(NETDEV_UP): eth1: link is not ready
[  248.004213] ppdev: user-space parallel port driver
[  255.036884] apm: BIOS not found.
[  255.420206] Capability LSM initialized
[  228.576000] Marking TSC unstable due to: cpufreq changes.
[  228.580000] Time: hpet clocksource has been installed.
[  229.004000] Clocksource tsc unstable (delta = -240930961 ns)
[  229.224000] Bluetooth: L2CAP ver 2.8
[  229.224000] Bluetooth: L2CAP socket layer initialized
[  229.232000] Bluetooth: RFCOMM socket layer initialized
[  229.232000] Bluetooth: RFCOMM TTY layer initialized
[  229.232000] Bluetooth: RFCOMM ver 1.8
[  572.480000] eth1: no link during initialization.
[  572.480000] ADDRCONF(NETDEV_UP): eth1: link is not ready
[  572.844000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  574.516000] eth1: no link during initialization.
[  574.516000] ADDRCONF(NETDEV_UP): eth1: link is not ready
[  574.904000] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  586.672000] SoftMAC: Open Authentication completed with 00:17:3f:07:d8:26
[  587.040000] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  587.080000] ieee80211_crypt: registered algorithm 'TKIP'
[  602.148000] eth0: no IPv6 routers present
[  612.432000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.440000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.444000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.448000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.460000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.464000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  612.468000] TKIP: received packet without ExtIV flag from 00:13:46:5b:b3:1b
[  614.268000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[  636.524000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[  707.404000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[  926.376000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[  961.724000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1199.316000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1420.828000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1420.852000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1420.856000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1466.412000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1549.872000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1552.840000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1670.132000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1673.076000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1677.676000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1679.116000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1686.556000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69
[ 1724.048000] TKIP: received packet without ExtIV flag from 00:19:5b:b5:09:69

--=-io4adLkvZz8ngyMWTAEL
Content-Disposition: attachment; filename=dmidecode-output-after
Content-Type: text/plain; name=dmidecode-output-after; charset=utf-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 822 bytes.
Table at 0x000F1C70.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.37    
	Release Date: 05/31/2007
	Address: 0xE6A20
	Runtime Size: 103904 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv9000 (RE378EA#UUW)  
	Version: Rev 1
	Serial Number: CNF6391MYT
	UUID: 434E4636-3339-314D-5954-001B24261DF7
	Wake-up Type: Power Switch
	SKU Number: RE378EA#UUW
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Quanta
	Product Name: 30B9
	Version: 65.28
	Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Quanta
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: dv9094ea            
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket S1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 72, Stepping 2
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Turion(tm) 64 X2 Mobile TL56
	Voltage: 1.6 V
	External Clock: 200 MHz
	Max Speed: 1800 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 1
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 2
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0009, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:    

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#UUW    

Handle 0x000B, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x000000F9
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000C, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 1
	Bank Locator: Bank 0,1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: EC00000000000000
	Serial Number: 6F52A10B
	Asset Tag: Not Specified
	Part Number: M4 70T2953CZ3-CE6 

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 2
	Bank Locator: Bank 2,3
	Type: DDR2
	Type Detail: Unknown
	Speed: 667 MHz (1.5 ns)
	Manufacturer: EC00000000000000
	Serial Number: 6F52B126
	Asset Tag: Not Specified
	Part Number: M4 70T2953CZ3-CE6 

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000C
	Partition Width: 0

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000D
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000E
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0012, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0013, DMI type 127, 4 bytes
End Of Table


--=-io4adLkvZz8ngyMWTAEL
Content-Disposition: attachment; filename=dmidecode-output-before
Content-Type: text/plain; name=dmidecode-output-before; charset=utf-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.4 present.
20 structures occupying 822 bytes.
Table at 0x000F1C70.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: F.37    
	Release Date: 05/31/2007
	Address: 0xE6A20
	Runtime Size: 103904 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv9000 (RE378EA#UUW)  
	Version: Rev 1
	Serial Number: CNF6391MYT
	UUID: 434E4636-3339-314D-5954-001B24261DF7
	Wake-up Type: Power Switch
	SKU Number: RE378EA#UUW
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Quanta
	Product Name: 30B9
	Version: 65.28
	Serial Number: None

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Quanta
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: dv9094ea            
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket S1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Family 15, Model 72, Stepping 2
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Hyper-threading technology)
	Version: AMD Turion(tm) 64 X2 Mobile TL56
	Voltage: 1.6 V
	External Clock: 200 MHz
	Max Speed: 1800 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 1
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0008, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot 2
	Type: 64-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		Hot-plug devices are supported

Handle 0x0009, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:    

Handle 0x000A, DMI type 11, 5 bytes
OEM Strings
	String 1: $HP$
	String 2: LOC#UUW    

Handle 0x000B, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x000000F9
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000C, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 1
	Bank Locator: Bank 0,1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: EC00000000000000
	Serial Number: 6F52A10B
	Asset Tag: Not Specified
	Part Number: M4 70T2953CZ3-CE6 

Handle 0x000E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000C
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 2
	Bank Locator: Bank 2,3
	Type: DDR2
	Type Detail: Unknown
	Speed: 667 MHz (1.5 ns)
	Manufacturer: EC00000000000000
	Serial Number: 6F52B126
	Asset Tag: Not Specified
	Part Number: M4 70T2953CZ3-CE6 

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x000C
	Partition Width: 0

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000D
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0011, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x000E
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0012, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0013, DMI type 127, 4 bytes
End Of Table


--=-io4adLkvZz8ngyMWTAEL--
