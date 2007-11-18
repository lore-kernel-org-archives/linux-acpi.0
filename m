From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: /proc/acpi/thermal_zone empty on gigabyte board and athlon64
Date: Sun, 18 Nov 2007 17:11:27 +0100
Message-ID: <20071118161119.GA1160@code-monkey.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from code-monkey.de ([88.198.45.137]:42613 "EHLO code-monkey.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbXKRQWo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Nov 2007 11:22:44 -0500
Received: from brimstone (dialin-212-144-188-114.pools.arcor-ip.net [212.144.188.114])
	by code-monkey.de (Postfix) with ESMTP id 4DE663F24B
	for <linux-acpi@vger.kernel.org>; Sun, 18 Nov 2007 17:10:47 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I'm trying to read my CPU's temperature from /proc/acpi/thermal_zone,
but that directory is empty. The BIOS does show the CPU's
temperature however. I can also get temperature readings using the hwmon
module, but I'm not sure whether those are from the CPU or from other
components.

This is with an Athlon64 X2 on a Gigabyte GA-M56S-S3. I'm currently
running Linux 2.6.23.1.

I stuck some printk's into drivers/acpi/thermal.c and found out that
acpi_thermal_add() is failing because acpi_thermal_get_temperature()
returns -ENODEV.

Is this a kernel bug, or a problem with the BIOS?

I'm attaching dmesg output etc, maybe that helps in pinpointing the
problem.

Thanks,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.23.1 (tilman@brimstone) (gcc version 4.2.2 (CRUX)) #13 SM=
P Sun Nov 18 13:18:44 CET 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007fef3000 (ACPI NVS)
 BIOS-e820: 000000007fef3000 - 000000007ff00000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4a50
Entering add_active_range(0, 0, 524016) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524016
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   524016
On node 0 totalpages: 524016
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2301 pages used for memmap
  HighMem zone: 292339 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.4 present.
ACPI: RSDP 000F6410, 0014 (r0 GBT   )
ACPI: RSDT 7FEF3000, 0038 (r1 GBT    NVDAACPI 42302E31 NVDA  1010101)
ACPI: FACP 7FEF3040, 0074 (r1 GBT    NVDAACPI 42302E31 NVDA  1010101)
ACPI: DSDT 7FEF30C0, 46B5 (r1 GBT    NVDAACPI     1000 MSFT  100000C)
ACPI: FACS 7FEF0000, 0040
ACPI: SSDT 7FEF7800, 0206 (r1 PTLTD  POWERNOW        1  LTP        1)
ACPI: HPET 7FEF7A40, 0038 (r1 GBT    NVDAACPI 42302E31 NVDA       98)
ACPI: MCFG 7FEF7A80, 003C (r1 GBT    NVDAACPI 42302E31 NVDA  1010101)
ACPI: APIC 7FEF7780, 0072 (r1 GBT    NVDAACPI 42302E31 NVDA  1010101)
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x10de8201 base: 0xfeff0000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ff00000:70100000)
Built 1 zonelists in Zone order.  Total pages: 519923
Kernel command line: root=3D/dev/sda1
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2109.677 MHz processor.
spurious 8259A interrupt: IRQ7.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2075032k/2096064k available (1679k kernel code, 19960k reserved, 59=
6k data, 192k init, 1178560k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9b000 - 0xfffff000   ( 400 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc033f000 - 0xc036f000   ( 192 kB)
      .data : 0xc02a3e64 - 0xc0338eec   ( 596 kB)
      .text : 0xc0100000 - 0xc02a3e64   (1679 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4224.17 BogoMIPS (lpj=3D84=
48356)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 0000=
2001 00000000 0000011f 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00=
000000 0000011f 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 9k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 773 Objects with 85 Devices 293 Methods 35 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 8 Objects with 0 Devices 0 Methods 0 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successf=
ul
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+ stepping 01
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4219.16 BogoMIPS (lpj=3D84=
38331)
CPU: After generic identify, caps: 178bfbff ebd3fbff 00000000 00000000 0000=
2001 00000000 0000011f 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbff ebd3fbff 00000000 00000410 00002001 00=
000000 0000011f 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+ stepping 01
Total of 2 processors activated (8443.34 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on device 00:18
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on in=
t 0x9
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs on in=
t 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 7 Wake, Enabled 0 Runtime =
GPEs in this block
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 0 Wake, Enabled 0 Runtime =
GPEs in this block
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:.....................=
=2E........................................................
Initialized 30/35 Regions 1/1 Fields 32/32 Buffers 15/24 Packages (790 node=
s)
Initializing Device/Processor/Thermal objects by executing _INI methods:.
Executed 1 _INI methods requiring 1 _STA executions (examined 89 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LU1B] (IRQs 5 7 9 10 11 14 15) *0
ACPI: PCI Interrupt Link [LU2B] (IRQs 5 7 9 10 11 14 15) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 11 14 *15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [AUBA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AUB2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AU1B] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AU2B] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
Time: hpet clocksource has been installed.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
pnp: 00:01: ioport range 0x1000-0x107f has been reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff has been reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
pnp: 00:01: iomem range 0x0-0x0 could not be reserved
pnp: 00:0a: iomem range 0xf0000000-0xf1ffffff could not be reserved
pnp: 00:0b: iomem range 0xce600-0xcffff has been reserved
pnp: 00:0b: iomem range 0xf0000-0xf7fff could not be reserved
pnp: 00:0b: iomem range 0xf8000-0xfbfff could not be reserved
pnp: 00:0b: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:08.0
  IO window: a000-afff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: b000-bfff
  MEM window: f2000000-f3ffffff
  PREFETCH window: e0000000-efffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler deadline registered (default)
Boot video device is 0000:02:00.0
PCI: Setting latency timer of device 0000:00:0d.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
ahci 0000:00:0a.0: version 2.3
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSI] -> GSI 23 (level, low) -=
> IRQ 16
ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:0a.0: flags: 64bit ncq sntf pm led clo pmp pio=20
PCI: Setting latency timer of device 0000:00:0a.0 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xf8814100 ctl 0x00000000 bmdma 0x00000000 irq =
16
ata2: SATA max UDMA/133 cmd 0xf8814180 ctl 0x00000000 bmdma 0x00000000 irq =
16
ata3: SATA max UDMA/133 cmd 0xf8814200 ctl 0x00000000 bmdma 0x00000000 irq =
16
ata4: SATA max UDMA/133 cmd 0xf8814280 ctl 0x00000000 bmdma 0x00000000 irq =
16
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: Host Protected Area detected:
	current size: 976771055 sectors
	native size: 976773168 sectors
ata1.00: ATA-8: SAMSUNG HD501LJ, CR100-11, max UDMA7
ata1.00: 976771055 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: Host Protected Area detected:
	current size: 976771055 sectors
	native size: 976773168 sectors
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976771055 512-byte hardware sectors (500107 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 0:0:0:0: [sda] 976771055 512-byte hardware sectors (500107 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please bo=
ot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
ACPI: ACPIt cannot get temp
input: Power Button (FF) as /class/input/input1
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NFORCE-MCP65: IDE controller at PCI slot 0000:00:09.0
NFORCE-MCP65: chipset revision 161
NFORCE-MCP65: not 100% native mode: will probe irqs later
NFORCE-MCP65: 0000:00:09.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
hda: LG DVD-ROM DRD-8080B, ATAPI CD/DVD-ROM drive
hdb: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCH] -> GSI 22 (level, low) -=
> IRQ 17
PCI: Setting latency timer of device 0000:00:06.0 to 64
forcedeth: using HIGHDMA
hda: ATAPI 27X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:06.0
ACPI: PCI Interrupt Link [AUBA] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [AUBA] -> GSI 21 (level, low) -=
> IRQ 18
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 18, io mem 0xf4008000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt Link [AUB2] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [AUB2] -> GSI 20 (level, low) -=
> IRQ 19
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 19, io mem 0xf4006000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[B] -> Link [AAZA] -> GSI 23 (level, low) -=
> IRQ 16
PCI: Setting latency timer of device 0000:00:07.0 to 64
usb 1-4: new low speed USB device using ohci_hcd and address 2
usb 1-4: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Logitech USB-PS/2 Optical Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00=
:02.0-4
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 248996k swap on /dev/sda2.  Priority:-1 extents:1 across:248996k
powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 4000+ process=
ors (2 cpu cores) (version 2.00.00)
powernow-k8:    0 : fid 0xd (2100 MHz), vid 0xc
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xd
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xf
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
it87: Found IT8716F chip at 0x290, revision 3
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redha=
t.com
Clocksource tsc unstable (delta =3D -261926971 ns)
Linux agpgart interface v0.102
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt Link [APC8] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC8] -> GSI 16 (level, low) -=
> IRQ 20
[drm] Initialized radeon 1.28.0 20060524 on minor 0
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmidecode.log"
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.9
SMBIOS 2.4 present.
42 structures occupying 1779 bytes.
Table at 0x000F0100.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Award Software International, Inc.
	Version: F2
	Release Date: 09/26/2007
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 512 kB
	Characteristics:
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: M56S-S3
	Version: =20
	Serial Number: =20
	UUID: 30303144-3744-3934-3539-3839FFFFFFFF
	Wake-up Type: Power Switch
	SKU Number: =20
	Family: =20

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Product Name: GA-M56S-S3
	Version: =20
	Serial Number: =20

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Gigabyte Technology Co., Ltd.
	Type: Desktop
	Lock: Not Present
	Version: =20
	Serial Number: =20
	Asset Tag: =20
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: Socket M2
	Type: Central Processor
	Family: Athlon
	Manufacturer: AMD
	ID: B1 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 107, Stepping 1
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
	Version: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
	Voltage: 1.3 V
	External Clock: 200 MHz
	Max Speed: 3200 MHz
	Current Speed: 2100 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000C
	L3 Cache Handle: Not Provided
	Serial Number: =20
	Asset Tag: =20
	Part Number: =20

Handle 0x0005, DMI type 5, 24 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 4096 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		Standard
		EDO
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 4
		0x0006
		0x0007
		0x0008
		0x0009
	Enabled Error Correcting Capabilities:
		None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A0
	Bank Connections: 1
	Current Speed: 1 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A1
	Bank Connections: 2
	Current Speed: 1 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A2
	Bank Connections: 3
	Current Speed: 1 ns
	Type: Other Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A3
	Bank Connections: 4
	Current Speed: 1 ns
	Type: Other Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000D, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Disabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: =20
	External Connector Type: None
	Port Type: Other

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: =20
	External Connector Type: None
	Port Type: Other

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: =20
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: =20
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: =20
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator: =20
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: Other
	External Reference Designator: =20
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator: No Detected
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB
	Internal Connector Type: None
	External Reference Designator: =20
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0017, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 6
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0018, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 7
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0019, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x001A, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 9
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x001B, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x001C, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x001D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None
	Speed: 400 MHz (2.5 ns)
	Manufacturer: =20
	Serial Number: =20
	Asset Tag: =20
	Part Number: =20

Handle 0x001E, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A1
	Bank Locator: Bank2/3
	Type: Unknown
	Type Detail: None
	Speed: 400 MHz (2.5 ns)
	Manufacturer: =20
	Serial Number: =20
	Asset Tag: =20
	Part Number: =20

Handle 0x001F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None
	Speed: 400 MHz (2.5 ns)
	Manufacturer: =20
	Serial Number: =20
	Asset Tag: =20
	Part Number: =20

Handle 0x0020, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x001C
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: Unknown
	Type Detail: None
	Speed: 400 MHz (2.5 ns)
	Manufacturer: =20
	Serial Number: =20
	Asset Tag: =20
	Part Number: =20

Handle 0x0021, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x001C
	Partition Width: 32

Handle 0x0022, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x001D
	Memory Array Mapped Address Handle: 0x0021
	Partition Row Position: 1

Handle 0x0023, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x001E
	Memory Array Mapped Address Handle: 0x0021
	Partition Row Position: 1

Handle 0x0024, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x001F
	Memory Array Mapped Address Handle: 0x0021
	Partition Row Position: 1

Handle 0x0025, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0020
	Memory Array Mapped Address Handle: 0x0021
	Partition Row Position: 1

Handle 0x0026, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0027, DMI type 68, 255 bytes
Unknown Type
	Header and Data:
		44 FF 27 00 4B 38 4E 50 54 44 52 41 4D 30 03 00
		00 00 00 00 7F 00 00 00 00 00 01 00 00 00 00 00
		00 00 02 00 00 00 00 00 00 00 03 00 00 00 00 00
		00 00 04 00 00 00 00 00 00 00 05 00 00 00 00 00
		00 00 06 00 00 00 00 00 00 00 07 00 00 00 00 00
		00 00 40 00 10 0A 00 00 00 00 00 00 FF 00 EB 02
		00 AE 00 00 00 00 00 00 00 00 01 00 00 00 01 01
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 E0 3E 78 00 00 00 00 00 00 00
		00 00 46 00 00 00 00 00 00 00 20 00 00 00 00 00
		00 00 24 F2 7D AE 20 13 82 00 10 08 01 00 6B 00
		10 74 88 88 FF FE 1A 17 19 19 18 16 18 1A 1A 00
		00 00 12 13 13 13 14 13 13 12 12 00 00 00 00 32
		00 00 19 19 17 18 19 19 19 1A 19 13 13 14 13 13
		12 13 14 13 00 32 00 00 22 32 11 20 20 25 20 00
		22 32 11 20 20 25 20 00 00 00 00 00 00 00 00
	Strings:
		=20

Handle 0x0028, DMI type 69, 255 bytes
Unknown Type
	Header and Data:
		45 FF 28 00 00 00 00 80 00 00 00 00 00 00 00 00
		00 00 00 00 01 06 16 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	Strings:
		=20

Handle 0x0029, DMI type 127, 4 bytes
End Of Table


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod.txt"
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by
radeon                121056  2=20
drm                    70996  3 radeon
agpgart                26504  1 drm
dm_crypt               11016  0=20
dm_mod                 47232  1 dm_crypt
it87                   16908  0=20
hwmon_vid               2752  1 it87
cpufreq_ondemand        6668  1=20
powernow_k8             9868  1=20
freq_table              3528  2 cpufreq_ondemand,powernow_k8
usbhid                 24832  0=20
hid                    26368  1 usbhid
ide_cd                 34272  0=20
cdrom                  33568  1 ide_cd
ehci_hcd               28044  0=20
snd_hda_intel         266716  0=20
ohci_hcd               18948  0=20
forcedeth              43144  0=20
amd74xx                 9104  0 [permanent]
usbcore               115336  4 usbhid,ehci_hcd,ohci_hcd
snd_pcm                61316  1 snd_hda_intel
snd_timer              18308  1 snd_pcm
snd                    37816  3 snd_hda_intel,snd_pcm,snd_timer
soundcore               5792  1 snd
snd_page_alloc          7560  2 snd_hda_intel,snd_pcm
k8temp                  4224  0=20
hwmon                   2244  2 it87,k8temp
ide_core               96784  2 ide_cd,amd74xx
button                  6224  0=20
thermal                14748  0=20
processor              28288  2 powernow_k8,thermal
evdev                   7744  0=20

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.log"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping	: 1
cpu MHz		: 1000.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy misalignsse ts fid vid ttp tm stc 100mhzsteps
bogomips	: 2011.51
clflush size	: 64

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Athlon(tm) 64 X2 Dual Core Processor 4000+
stepping	: 1
cpu MHz		: 1000.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy misalignsse ts fid vid ttp tm stc 100mhzsteps
bogomips	: 2011.51
clflush size	: 64


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.log"

00:00.0 RAM memory [0500]: nVidia Corporation MCP65 Memory Controller [10de:0444] (rev a3)
	Subsystem: Giga-byte Technology Unknown device [1458:5001]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 200MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [dc] HyperTransport: MSI Mapping Enable+ Fixed-
		Mapping Address Base: 00000000fee00000

00:01.0 ISA bridge [0601]: nVidia Corporation MCP65 LPC Bridge [10de:0441] (rev a3)
	Subsystem: Giga-byte Technology Unknown device [1458:0c11]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0

00:01.1 SMBus [0c05]: nVidia Corporation MCP65 SMBus [10de:0446] (rev a1)
	Subsystem: Giga-byte Technology Unknown device [1458:0c11]
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e000 [size=64]
	Region 4: I/O ports at 1c00 [size=64]
	Region 5: I/O ports at 1c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.2 RAM memory [0500]: nVidia Corporation MCP65 Memory Controller [10de:0445] (rev a1)
	Subsystem: Giga-byte Technology Unknown device [1458:0c11]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.0 USB Controller [0c03]: nVidia Corporation MCP65 USB Controller [10de:0454] (rev a3) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology Unknown device [1458:5004]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4008000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:02.1 USB Controller [0c03]: nVidia Corporation MCP65 USB Controller [10de:0455] (rev a3) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology Unknown device [1458:5004]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at f4006000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port: BAR=1 offset=0098
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:06.0 Ethernet controller [0200]: nVidia Corporation MCP65 Ethernet [10de:0450] (rev a3)
	Subsystem: Giga-byte Technology Unknown device [1458:e000]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f4007000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at c800 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/3 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: forcedeth
	Kernel modules: forcedeth

00:07.0 Audio device [0403]: nVidia Corporation MCP65 High Definition Audio [10de:044a] (rev a1)
	Subsystem: Giga-byte Technology Unknown device [1458:a002]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [6c] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

00:08.0 PCI bridge [0604]: nVidia Corporation MCP65 PCI bridge [10de:0449] (rev a1) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
	Capabilities: [b8] Subsystem: Giga-byte Technology Unknown device [1458:026f]
	Capabilities: [8c] HyperTransport: MSI Mapping Enable- Fixed-
		Mapping Address Base: 00000000fee00000

00:09.0 IDE interface [0101]: nVidia Corporation MCP65 IDE [10de:0448] (rev a1) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology Unknown device [1458:5002]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: AMD_IDE
	Kernel modules: amd74xx

00:0a.0 SATA controller [0106]: nVidia Corporation MCP65 AHCI Controller [10de:044d] (rev a3) (prog-if 01 [AHCI 1.0])
	Subsystem: Giga-byte Technology Unknown device [1458:b002]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at dc00 [size=16]
	Region 5: Memory at f4004000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/3 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [cc] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: ahci

00:0d.0 PCI bridge [0604]: nVidia Corporation MCP65 PCI Express bridge [10de:0458] (rev a1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: f2000000-f3ffffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device [10de:0000]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
		Mapping Address Base: 00000000fee00000
	Capabilities: [80] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <512ns, L1 <4us
			ClockPM- Suprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
			Slot #  0, PowerLimit 0.000000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100] Virtual Channel <?>
	Kernel driver in use: pcieport-driver

00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k8temp
	Kernel modules: k8temp

02:00.0 VGA compatible controller [0300]: ATI Technologies Inc R430 [Radeon X800 (PCIE)] [1002:554f] (prog-if 00 [VGA controller])
	Subsystem: C.P. Technology Co. Ltd Unknown device [148c:2111]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at f3000000 (64-bit, non-prefetchable) [size=64K]
	Region 4: I/O ports at b000 [size=256]
	[virtual] Expansion ROM at f2000000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <4us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Advanced Error Reporting <?>

02:00.1 Display controller [0380]: ATI Technologies Inc R430 [Radeon X800] (PCIE) (Secondary) [1002:556f]
	Subsystem: C.P. Technology Co. Ltd Unknown device [148c:2110]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Region 0: Memory at f3010000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <4us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <256ns, L1 <2us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-


--2oS5YaxWCcQjTEyO--

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHQGQm6tx5H15YdGIRAsKzAKCFpO43pvs5Vsn9YSOMykLSpL0IlQCglu41
99F4xa1CqOmS3g9TkmwEVfQ=
=zTNK
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
