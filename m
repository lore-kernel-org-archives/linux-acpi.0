From: Ralf Goertz <R_Goertz@web.de>
Subject: acpi-problem
Date: Fri, 30 Nov 2007 09:20:31 +0100
Message-ID: <200711300920.32019.R_Goertz@web.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Qf8THKIxuL7tpD3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:58717 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbXK3IUg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Nov 2007 03:20:36 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 71499B6F8AFD
	for <linux-acpi@vger.kernel.org>; Fri, 30 Nov 2007 09:20:34 +0100 (CET)
Received: from [84.176.149.234] (helo=lrg.site)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #208)
	id 1Iy16v-0005Hg-00
	for linux-acpi@vger.kernel.org; Fri, 30 Nov 2007 09:20:33 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_Qf8THKIxuL7tpD3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

There is no thermal, fan or processor feature control for our quadcore
Dell PowerEdge 840 machine. Does that mean that it constantly runs on
full power? Setting acpi_osi=!Linux doesn't seem to have any effect even
the line

ACPI: Please test with "acpi_osi=!Linux"

is still displayed.

Ralf



--Boundary-00=_Qf8THKIxuL7tpD3
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.22.12-0.1-default (geeko@buildhost) (gcc version 4.2.1 (SUSE Linux)) #1 SMP 2007/11/06 23:05:18 UTC
Command line: root=/dev/disk/by-id/scsi-3600508e000000000b35b5ac98bc0e401-part6 vga=0x317 resume=/dev/sda5 splash=verbose
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 00000000dffc0000 (usable)
 BIOS-e820: 00000000dffc0000 - 00000000dffcfc00 (ACPI data)
 BIOS-e820: 00000000dffcfc00 - 00000000dffff000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed13000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001ffffe000 (usable)
 BIOS-e820: 00000001ffffe000 - 0000000200000000 (reserved)
 BIOS-e820: 0000000200000000 - 0000000220000000 (usable)
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 917440) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2097150) 2 entries of 3200 used
Entering add_active_range(0, 2097152, 2228224) 3 entries of 3200 used
end_pfn_map = 2228224
DMI 2.4 present.
ACPI: RSDP 000F9EA0, 0024 (r2 DELL  )
ACPI: XSDT 000F9F14, 0054 (r1 DELL   PE_SC3          1 INTL        1)
ACPI: FACP 000FA004, 00F4 (r3 DELL   PE_SC3          1 INTL        1)
ACPI: DSDT DFFC0000, 1F8A (r1 DELL   PE_SC3          1 INTL 20050624)
ACPI: FACS DFFCFC00, 0040
ACPI: APIC 000FA0F8, 0084 (r1 DELL   PE_SC3          1 INTL        1)
ACPI: SPCR 000FA17C, 0050 (r1 DELL   PE_SC3          1 INTL        1)
ACPI: HPET 000FA1CC, 0038 (r1 DELL   PE_SC3          1 INTL        1)
ACPI: MCFG 000FA204, 003C (r1 DELL   PE_SC3          1 INTL        1)
ACPI: SLIC 000FA240, 0024 (r1 DELL   PE_SC3          1 INTL        1)
No NUMA configuration found
Faking a node at 0000000000000000-0000000220000000
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 917440) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2097150) 2 entries of 3200 used
Entering add_active_range(0, 2097152, 2228224) 3 entries of 3200 used
Bootmem setup node 0 0000000000000000-0000000220000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  2228224
early_node_map[4] active PFN ranges
    0:        0 ->      160
    0:      256 ->   917440
    0:  1048576 ->  2097150
    0:  2097152 ->  2228224
On node 0 totalpages: 2096990
  DMA zone: 56 pages used for memmap
  DMA zone: 1278 pages reserved
  DMA zone: 2666 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 899064 pages, LIFO batch:31
  Normal zone: 16128 pages used for memmap
  Normal zone: 1163518 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfec10000] gsi_base[32])
IOAPIC[1]: apic_id 5, address 0xfec10000, GSI 32-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 00000000000a0000 - 0000000000100000
swsusp: Registered nosave memory region: 00000000dffc0000 - 00000000dffcf000
swsusp: Registered nosave memory region: 00000000dffcf000 - 00000000dffd0000
swsusp: Registered nosave memory region: 00000000dffd0000 - 00000000dffff000
swsusp: Registered nosave memory region: 00000000dffff000 - 00000000f0000000
swsusp: Registered nosave memory region: 00000000f0000000 - 00000000f4000000
swsusp: Registered nosave memory region: 00000000f4000000 - 00000000fec00000
swsusp: Registered nosave memory region: 00000000fec00000 - 00000000fed00000
swsusp: Registered nosave memory region: 00000000fed00000 - 00000000fed13000
swsusp: Registered nosave memory region: 00000000fed13000 - 00000000feda0000
swsusp: Registered nosave memory region: 00000000feda0000 - 00000000fee00000
swsusp: Registered nosave memory region: 00000000fee00000 - 00000000fee10000
swsusp: Registered nosave memory region: 00000000fee10000 - 00000000ffb00000
swsusp: Registered nosave memory region: 00000000ffb00000 - 0000000100000000
swsusp: Registered nosave memory region: 00000001ffffe000 - 0000000200000000
Allocating PCI resources starting at e0000000 (gap: dffff000:10001000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 50296 bytes of per cpu data
Built 1 zonelists.  Total pages: 2065248
Kernel command line: root=/dev/disk/by-id/scsi-3600508e000000000b35b5ac98bc0e401-part6 vga=0x317 resume=/dev/sda5 splash=verbose
bootsplash: verbose mode.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
time.c: Detected 2400.083 MHz processor.
Console: colour dummy device 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x1071000 - 0x5071000
Memory: 8190140k/8912896k available (2053k kernel code, 197820k reserved, 1018k data, 316k init)
Calibrating delay using timer specific routine.. 4803.48 BogoMIPS (lpj=9606976)
Security Framework v1.0.0 initialized
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
Unpacking initramfs... done
Freeing initrd memory: 4423k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 257 Objects with 31 Devices 88 Methods 8 Regions
 tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.
result 16667223
Detected 16.667 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4800.09 BogoMIPS (lpj=9600181)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU           X3220  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4800.20 BogoMIPS (lpj=9600404)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
CPU2: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU           X3220  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4800.27 BogoMIPS (lpj=9600551)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
CPU3: Thermal monitoring enabled (TM2)
Intel(R) Xeon(R) CPU           X3220  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
migration_cost=14,3344
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000 - f3ffffff
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 1 Wake, Enabled 0 Runtime GPEs in this block
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:...............................
Initialized 4/8 Regions 0/0 Fields 10/10 Buffers 17/24 Packages (266 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
.
Executed 1 _INI methods requiring 0 _STA executions (examined 37 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH6 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PES1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP0.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEP2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIS._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 *6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: 00:09: ioport range 0x800-0x87f has been reserved
pnp: 00:09: ioport range 0x880-0x8bf has been reserved
pnp: 00:09: ioport range 0x8c0-0x8df has been reserved
pnp: 00:09: ioport range 0x8e0-0x8e3 has been reserved
pnp: 00:09: ioport range 0xc00-0xc0f has been reserved
pnp: 00:09: ioport range 0xc10-0xc1f has been reserved
pnp: 00:09: ioport range 0xca0-0xca7 has been reserved
pnp: 00:09: ioport range 0xca9-0xcab has been reserved
pnp: 00:0a: ioport range 0xca8-0xca8 has been reserved
pnp: 00:0a: ioport range 0xcac-0xcac has been reserved
pnp: 00:0b: iomem range 0xf0000000-0xf3ffffff could not be reserved
PCI: Bridge: 0000:01:00.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fe700000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: fe600000-fe6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: d000-dfff
  MEM window: fe400000-fe5fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: fe200000-fe3fffff
  PREFETCH window: e8000000-efffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:03:00.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[C] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
Time: tsc clocksource has been installed.
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 1048576 (order: 12, 25165824 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 1048576 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1196409551.500:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:07:05.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie03]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
Allocate Port Service[0000:00:1c.5:pcie03]
vesafb: framebuffer at 0xe8000000, mapped to 0xffffc20006800000, using 6144k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...
bootsplash: silentjpeg size 78436 bytes
bootsplash: ...found (1024x768, 28133 bytes, v3).
Console: switching to colour frame buffer device 124x44
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
pnp: Device 00:08 activated.
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
NET: Registered protocol family 1
Freeing unused kernel memory: 316k freed
SCSI subsystem initialized
libata version 3.00 loaded.
ata_piix 0000:00:1f.1: version 2.11
ACPI: Unable to derive IRQ for device 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A]: no GSI
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001fc00 irq 14
ata2: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001fc08 irq 15
ata1.00: ATAPI: TSSTcorpDVD-ROM TS-H352C, DE02, max UDMA/33
ata1.00: configured for UDMA/33
ata2: port disabled. ignoring.
scsi 0:0:0:0: CD-ROM            TSSTcorp DVD-ROM TS-H352C DE02 PQ: 0 ANSI: 5
Fusion MPT base driver 3.04.05
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SAS Host driver 3.04.05
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 16 (level, low) -> IRQ 16
mptbase: Initiating ioc0 bringup
ioc0: SAS1068: Capabilities={Initiator}
scsi2 : ioc0: LSISAS1068, FwRev=000a3300h, Ports=1, MaxQ=286, IRQ=16
scsi 2:0:0:0: Direct-Access     ATA      ST3500630NS      3BKH PQ: 0 ANSI: 5
scsi 2:0:1:0: Direct-Access     ATA      ST3500630NS      3BKH PQ: 0 ANSI: 5
scsi 2:1:0:0: Direct-Access     Dell     VIRTUAL DISK     1028 PQ: 0 ANSI: 5
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
sd 2:1:0:0: [sda] 976562176 512-byte hardware sectors (500000 MB)
sd 2:1:0:0: [sda] Write Protect is off
sd 2:1:0:0: [sda] Mode Sense: 03 00 00 08
usbcore: registered new interface driver usbfs
sd 2:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 2:1:0:0: [sda] 976562176 512-byte hardware sectors (500000 MB)
sd 2:1:0:0: [sda] Write Protect is off
sd 2:1:0:0: [sda] Mode Sense: 03 00 00 08
sd 2:1:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
usbcore: registered new interface driver hub
sd 2:1:0:0: [sda] Attached SCSI disk
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000bce0
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000bcc0
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 22, io base 0x0000bca0
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfeb00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.22.12-0.1-default ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
swsusp: Marking nosave pages: 00000000000a0000 - 0000000000100000
swsusp: Marking nosave pages: 00000000dffc0000 - 0000000100000000
swsusp: Marking nosave pages: 00000001ffffe000 - 0000000200000000
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi 0:0:0:0: Attached scsi generic sg0 type 5
scsi 2:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:1:0: Attached scsi generic sg2 type 0
sd 2:1:0:0: Attached scsi generic sg3 type 0
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:04 failed with error -16
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sr0: scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
tg3.c:v3.77 (May 31, 2007)
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:05:00.0 to 64
intel_rng: FWH not detected
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000Base-T Ethernet 00:19:b9:fe:59:84
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
ACPI: Unable to derive IRQ for device 0000:00:1f.3
ACPI: PCI Interrupt 0000:00:1f.3[B]: no GSI
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
floppy0: no floppy controllers found
Adding 2104472k swap on /dev/sda5.  Priority:-1 extents:1 across:2104472k
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
loop: module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
ADDRCONF(NETDEV_UP): eth0: link is not ready
NET: Registered protocol family 17
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=217 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=197 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=74 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=54 
mtrr: type mismatch for e8000000,1000000 old: write-back new: write-combining
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=386 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=366 
eth0: no IPv6 routers present
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC= SRC=192.168.101.223 DST=224.0.0.251 LEN=64 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=44 
SFW2-INext-ACC-TCP IN=eth0 OUT= MAC=00:19:b9:fe:59:84:00:16:41:10:af:9e:08:00 SRC=192.168.101.11 DST=192.168.101.223 LEN=60 TOS=0x00 PREC=0x00 TTL=64 ID=23479 DF PROTO=TCP SPT=13999 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0 OPT (020405B40402080A0002C1410000000001030306) 

--Boundary-00=_Qf8THKIxuL7tpD3
Content-Type: text/plain;
  charset="us-ascii";
  name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode"

# dmidecode 2.9
SMBIOS 2.4 present.
48 structures occupying 2267 bytes.
Table at 0x000FA5B0.

Handle 0xDA00, DMI type 218, 11 bytes
OEM-specific Type
	Header and Data:
		DA 0B 00 DA B2 00 17 0B 2E 68 00

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Dell Computer Corporation
	Version: A05
	Release Date: 10/04/2007
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		BIOS ROM is socketed
		EDD is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 6.0

Handle 0x0100, DMI type 1, 27 bytes
System Information
	Manufacturer: Dell Computer Corporation
	Product Name: PowerEdge 840
	Version: Not Specified
	Serial Number: GZ0D93J
	UUID: 44454C4C-5A00-1030-8044-C7C04F39334A
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0200, DMI type 2, 9 bytes
Base Board Information
	Manufacturer: Dell Computer Corporation
	Product Name: 0XM091
	Version: A01
	Serial Number: ..CN7170378T0758.

Handle 0x0300, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: Dell Computer Corporation
	Type: Main Server Chassis
	Lock: Present
	Version: Not Specified
	Serial Number: GZ0D93J
	Asset Tag: Not Specified
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: Unknown
	OEM Information: 0x00000000
	Height: 5 U
	Number Of Power Cords: Unspecified
	Contained Elements: 0

Handle 0x0400, DMI type 4, 40 bytes
Processor Information
	Socket Designation: PROC
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: FB 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 11
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
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Xeon(R) CPU           X3220  @ 2.40GHz 
	Voltage: 1.5 V
	External Clock: 1066 MHz
	Max Speed: 3800 MHz
	Current Speed: 2400 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA775
	L1 Cache Handle: 0x0700
	L2 Cache Handle: 0x0701
	L3 Cache Handle: 0x0702
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified
	Core Count: 4
	Core Enabled: 4
	Thread Count: 4
	Characteristics:
		64-bit capable

Handle 0x0700, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0701, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 8192 KB
	Maximum Size: 8192 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0702, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: <OUT OF SPEC>

Handle 0x0800, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0801, DMI type 126, 9 bytes
Inactive

Handle 0x0802, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0803, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0804, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0805, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0806, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0807, DMI type 126, 9 bytes
Inactive

Handle 0x0808, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0809, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x080A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0900, DMI type 9, 13 bytes
System Slot Information
	Designation: SLOT_1
	Type: x8 PCI Express
	Current Usage: In Use
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0901, DMI type 9, 13 bytes
System Slot Information
	Designation: SLOT_2
	Type: x1 PCI Express
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0902, DMI type 9, 13 bytes
System Slot Information
	Designation: SLOT_3
	Type: 64-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0903, DMI type 9, 13 bytes
System Slot Information
	Designation: SLOT_4
	Type: 64-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 4
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0904, DMI type 9, 13 bytes
System Slot Information
	Designation: SLOT_5
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 5
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0A00, DMI type 10, 8 bytes
On Board Device 1 Information
	Type: Video
	Status: Enabled
	Description: Embedded ATI ES1000 Video
On Board Device 2 Information
	Type: Ethernet
	Status: Enabled
	Description: Broadcom 5721J Ethernet

Handle 0x0A01, DMI type 126, 10 bytes
Inactive

Handle 0x0B00, DMI type 11, 5 bytes
OEM Strings
	String 1: Dell System
	String 2: 5[0000]

Handle 0x7E00, DMI type 126, 144 bytes
Inactive

Handle 0x0C00, DMI type 12, 5 bytes
System Configuration Options
	Option 1: NVRAM_CLR:  Clear user settable NVRAM areas and set defaults
	Option 2: EN_PASSWD:  Close to enable password

Handle 0x0D00, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x1000, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x1100, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM1_A
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: CE00000000000000
	Serial Number: 4529A7FF
	Asset Tag: 010767
	Part Number: M3 91T5663DZ3-CE6 

Handle 0x1101, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM1_B
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: CE00000000000000
	Serial Number: 4529A823
	Asset Tag: 010767
	Part Number: M3 91T5663DZ3-CE6 

Handle 0x1102, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 2
	Locator: DIMM2_A
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: CE00000000000000
	Serial Number: 4529A819
	Asset Tag: 010767
	Part Number: M3 91T5663DZ3-CE6 

Handle 0x1103, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x1000
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: 2
	Locator: DIMM2_B
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: CE00000000000000
	Serial Number: 4529A80C
	Asset Tag: 010767
	Part Number: M3 91T5663DZ3-CE6 

Handle 0x1300, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000DFFFFFFF
	Range Size: 3584 MB
	Physical Array Handle: 0x1000
	Partition Width: 0

Handle 0x1301, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00100000000
	Ending Address: 0x0021FFFFFFF
	Range Size: 4608 MB
	Physical Array Handle: 0x1000
	Partition Width: 0

Handle 0x2000, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x2600, DMI type 38, 18 bytes
IPMI Device Information
	Interface Type: KCS (Keyboard Control Style)
	Specification Version: 1.5
	I2C Slave Address: 0x10
	NV Storage Device: Not Present
	Base Address: 0x0000000000000CA8 (I/O)
	Register Spacing: 32-bit Boundaries

Handle 0xD000, DMI type 208, 10 bytes
OEM-specific Type
	Header and Data:
		D0 0A 00 D0 01 05 FE 00 E7 01

Handle 0xD200, DMI type 210, 12 bytes
OEM-specific Type
	Header and Data:
		D2 0C 00 D2 00 00 00 03 06 80 04 04

Handle 0xD400, DMI type 212, 132 bytes
OEM-specific Type
	Header and Data:
		D4 84 00 D4 70 00 71 00 00 10 2D 2E 03 00 11 7F
		80 04 00 11 7F 00 0F 00 25 F8 00 11 00 25 F8 01
		12 00 25 F8 02 2E 40 25 F8 03 2F 40 25 F8 04 3B
		40 25 F8 06 00 00 25 F8 05 31 40 11 FB 00 32 40
		11 FB 04 9D 00 11 FD 02 9E 00 11 FD 00 42 00 11
		FE 01 43 00 11 FE 00 9F 00 26 FE 01 A0 00 26 FE
		00 51 00 26 3F 00 52 00 26 3F 40 53 00 26 3F 80
		54 00 26 3F C0 28 40 26 DF 20 29 40 26 DF 00 FF
		FF 00 00 00

Handle 0xD401, DMI type 212, 247 bytes
OEM-specific Type
	Header and Data:
		D4 F7 01 D4 70 00 71 00 03 40 59 6D 6B 00 78 7F
		80 6C 00 78 7F 00 58 00 78 FA 05 59 00 78 FA 00
		5C 00 78 BF 40 5D 00 78 BF 00 04 80 78 FD 02 01
		A0 78 FD 00 08 40 51 FE 01 09 40 51 FE 00 0A 40
		51 FD 02 0B 40 51 FD 00 19 00 55 E7 00 1A 00 55
		E7 08 1B 00 55 E7 10 FF 00 55 9F 40 FE 00 55 9F
		20 FD 00 55 9F 00 1E 00 55 FD 02 50 00 55 FD 00
		8A 00 55 FE 01 8B 00 55 FE 00 BF 00 53 FE 00 C0
		00 53 FE 01 33 40 53 E7 00 34 40 53 E7 08 35 40
		53 E7 10 36 40 53 E7 18 1A 40 53 FD 02 1B 40 53
		FD 00 1C 40 53 FB 04 1D 40 53 FB 00 6E 00 58 FC
		01 2D 00 58 FC 02 2E 00 58 FC 00 22 40 58 EF 10
		23 40 58 EF 00 00 00 58 F3 04 00 00 58 F3 08 00
		00 58 F3 00 D8 00 55 7F 80 D9 00 55 7F 00 00 C0
		5C 00 0A 03 C0 67 00 05 83 00 76 00 00 84 00 77
		00 00 FF FF 00 00 00

Handle 0xD402, DMI type 212, 202 bytes
OEM-specific Type
	Header and Data:
		D4 CA 02 D4 72 00 73 00 00 40 5D 5E 26 40 42 FE
		01 27 40 42 FE 00 37 40 42 FB 00 38 40 42 FB 04
		49 01 47 FE 01 48 01 47 FE 00 28 01 4A FC 00 29
		01 4A FC 01 2A 01 4A FC 02 02 40 4A F7 00 01 40
		4A F7 08 71 01 46 FB 04 72 01 46 FB 00 73 01 46
		F7 08 74 01 46 F7 00 00 00 7E FE 00 00 00 7E FE
		01 4A 01 43 FE 00 4B 01 43 FE 01 D3 00 00 00 02
		00 90 2C 00 00 01 90 2D 00 00 17 01 4B FE 00 18
		01 4B FE 01 19 01 4B FD 00 1A 01 4B FD 02 1B 01
		4B FB 00 1C 01 4B FB 04 1D 01 4B F7 00 1E 01 4B
		F7 08 35 01 4C FC 00 37 01 4C FC 01 3B 01 4C F3
		04 DE 00 76 FE 01 A1 00 48 FC 02 A3 00 48 FC 01
		A2 00 48 FC 00 FF FF 00 00 00

Handle 0xD800, DMI type 216, 9 bytes
OEM-specific Type
	Header and Data:
		D8 09 00 D8 01 02 01 00 00
	Strings:
		ATI
		RN50 A21 BIOS

Handle 0xDE00, DMI type 222, 15 bytes
OEM-specific Type
	Header and Data:
		DE 0F 00 DE 01 02 FF FF 00 00 00 00 00 02 00

Handle 0x7F00, DMI type 127, 4 bytes
End Of Table


--Boundary-00=_Qf8THKIxuL7tpD3--
