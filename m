From: Adam Tauno Williams <adamtaunowilliams@gmail.com>
Subject: Toshiba P105-S6207 (success using acpi_osi=!Linux)
Date: Wed, 14 Nov 2007 07:32:14 -0500
Message-ID: <1195043534.5511.18.camel@localhost>
Reply-To: adamtaunowilliams@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:55890 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbXKNMao (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 07:30:44 -0500
Received: by py-out-1112.google.com with SMTP id u77so2690693pyb
        for <linux-acpi@vger.kernel.org>; Wed, 14 Nov 2007 04:30:43 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have a Toshiba P105-S6207 running openSUSE 10.3
(2.6.22.12-0.1-default).  All the devices (to my knowledge) are working,
except sound;  I've tried various things and the sound driver seems to
load just fine but produce no output.  Then I noticed a message in dmesg
about trying to boot with "acpi_osi=!Linux".  So I booted as:

root=/dev/Aleph/Root vga=0x314 resume=/dev/sda2 splash=silent acpi_osi=!
Linux

and Bingo! I got sound.  Is there a guide somewhere as what to test and
report further?

dmesg
------------------------
Linux version 2.6.22.12-0.1-default (geeko@buildhost) (gcc version 4.2.1 (SUSE Linux)) #1 SMP 2007/11/06 23:05:18 UTC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e4000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f690000 (usable)
 BIOS-e820: 000000007f690000 - 000000007f69c000 (ACPI data)
 BIOS-e820: 000000007f69c000 - 000000007f700000 (ACPI NVS)
 BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1142MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7690
Entering add_active_range(0, 0, 521872) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   521872
early_node_map[1] active PFN ranges
    0:        0 ->   521872
On node 0 totalpages: 521872
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2285 pages used for memmap
  HighMem zone: 290211 pages, LIFO batch:31
DMI present.
Using APIC driver default
ACPI: RSDP 000F75D0, 0024 (r2 TOSQCI)
ACPI: XSDT 7F691FF6, 0074 (r1 TOSQCI TOSQCI00  6040000  LTP        0)
ACPI: FACP 7F69BC2A, 00F4 (r3 TOSQCI TOSQCI00  6040000 ALAN        1)
ACPI: DSDT 7F69305C, 8B5A (r1 TOSQCI   Denver  6040000 MSFT  3000001)
ACPI: FACS 7F69CFC0, 0040
ACPI: APIC 7F69BD1E, 0068 (r1 TOSQCI TOSQCI00  6040000 LOHR       5A)
ACPI: HPET 7F69BD86, 0038 (r1 TOSQCI TOSQCI00  6040000 LOHR       5A)
ACPI: MCFG 7F69BDBE, 003C (r1 TOSQCI TOSQCI00  6040000 LOHR       5A)
ACPI: APIC 7F69BDFA, 0068 (r1 PTLTD      APIC    6040000  LTP        0)
ACPI: BOOT 7F69BE62, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SLIC 7F69BE8A, 0176 (r1 TOSQCI TOSQCI00  6040000  LTP        0)
ACPI: SSDT 7F6925F6, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20060912)
ACPI: SSDT 7F692550, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20060912)
ACPI: SSDT 7F69206A, 04E6 (r1  PmRef    CpuPm     3000 INTL 20060912)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Built 1 zonelists.  Total pages: 517795
Kernel command line: root=/dev/Aleph/Root vga=0x314 resume=/dev/sda2 splash=silent acpi_osi=!Linux
bootsplash: silent mode.
ACPI: Disabled _OSI(Linux)
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1672.325 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2061328k/2087488k available (1825k kernel code, 24932k reserved, 765k data, 228k init, 1169984k highmem)
virtual kernel memory layout:
    fixmap  : 0xffdf4000 - 0xfffff000   (2092 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc038e000 - 0xc03c7000   ( 228 kB)
      .data : 0xc02c842b - 0xc0387964   ( 765 kB)
      .text : 0xc0100000 - 0xc02c842b   (1825 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Calibrating delay using timer specific routine.. 3348.09 BogoMIPS (lpj=6696184)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e39d 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e39d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Unpacking initramfs... done
Freeing initrd memory: 4348k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 1074 Objects with 82 Devices 253 Methods 27 Regions
Parsing all Control Methods:
Table [SSDT](id 0002) - 7 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0003) - 4 Objects with 0 Devices 3 Methods 0 Regions
Parsing all Control Methods:
Table [SSDT](id 0004) - 13 Objects with 0 Devices 4 Methods 0 Regions
 tbxface-0587 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz stepping 06
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3344.36 BogoMIPS (lpj=6688737)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e39d 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e39d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz stepping 06
Total of 2 processors activated (6692.46 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=44
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 3 Runtime GPEs in this block
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:..................................................................................................
Initialized 25/27 Regions 6/6 Fields 30/31 Buffers 37/51 Packages (1107 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:.<4>ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
.
Executed 2 _INI methods requiring 0 _STA executions (examined 87 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *7 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: 00:03: iomem range 0xfed00000-0xfed003ff could not be reserved
Time: tsc clocksource has been installed.
Switched to NOHz mode on CPU #0
Switched to NOHz mode on CPU #1
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: 88000000-880fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: 88100000-881fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 11, cardbus bridge: 0000:0a:04.0
  IO window: 00001400-000014ff
  IO window: 00001c00-00001cff
  PREFETCH window: 8c000000-8fffffff
  MEM window: 90000000-93ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: d0100000-d01fffff
  PREFETCH window: disabled.
PCI: Enabling device 0000:00:1c.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Enabling device 0000:00:1c.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Enabling device 0000:00:1e.0 (0004 -> 0006)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:0a:04.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:0a:04.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0a:04.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1195040455.684:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 3750k, total 7872k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...
bootsplash: silentjpeg size 78734 bytes
bootsplash: ...found (800x600, 27773 bytes, v3).
Console: switching to colour frame buffer device 96x33
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
floppy0: no floppy controllers found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x82a0b1, caps: 0xb04713/0x60040d
synaptics: Toshiba Satellite P105 detected, limiting rate to 40pps.
input: SynPS/2 Synaptics TouchPad as /class/input/input2
NET: Registered protocol family 1
Using IPI No-Shortcut mode
Freeing unused kernel memory: 228k freed
ACPI: SSDT 7F692D9E, 01F6 (r1  PmRef  Cpu0Ist     3000 INTL 20060912)
Parsing all Control Methods:
Table [SSDT](id 006B) - 6 Objects with 0 Devices 3 Methods 0 Regions
ACPI: SSDT 7F692855, 04C4 (r1  PmRef  Cpu0Cst     3001 INTL 20060912)
Parsing all Control Methods:
Table [SSDT](id 006C) - 1 Objects with 0 Devices 1 Methods 0 Regions
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: SSDT 7F692F94, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20060912)
Parsing all Control Methods:
Table [SSDT](id 0070) - 4 Objects with 0 Devices 4 Methods 0 Regions
ACPI: SSDT 7F692D19, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20060912)
Parsing all Control Methods:
Table [SSDT](id 0071) - 1 Objects with 0 Devices 1 Methods 0 Regions
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (51 C)
Marking TSC unstable due to: possible TSC halt in C2.
Time: hpet clocksource has been installed.
SCSI subsystem initialized
libata version 3.00 loaded.
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x000118b0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x000118b8 irq 15
ata1.00: ATA-7: FUJITSU MHV2200BT PL, 00000050, max UDMA/100
ata1.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
Clocksource tsc unstable (delta = -340065210 ns)
ata2.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.10, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2200B 0000 PQ: 0 ANSI: 5
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-850S  1.10 PQ: 0 ANSI: 5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001820
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001840
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 17, io base 0x00001880
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.22.12-0.1-default uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.3
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new device found, idVendor=046d, idProduct=c501
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB Receiver
usb 1-1: Manufacturer: Logitech
usb 1-1: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xd0644000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: EHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.22.12-0.1-default ehci_hcd
usb usb5: SerialNumber: 0000:00:1d.7
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 1-1: USB disconnect, address 2
usbcore: registered new interface driver hiddev
usb 1-1: new low speed USB device using uhci_hcd and address 3
usb 1-1: new device found, idVendor=046d, idProduct=c501
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB Receiver
usb 1-1: Manufacturer: Logitech
usb 1-1: configuration #1 chosen from 1 choice
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: new device found, idVendor=0483, idProduct=2016
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: Biometric Coprocessor
usb 3-1: Manufacturer: STMicroelectronics
usb 3-1: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
md: linear personality registered for level -1
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
JBD: barrier-based sync failed on dm-2 - disabling barriers
iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.1.0
iwl3945: Copyright(c) 2003-2007 Intel Corporation
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
iwl3945: Detected Intel PRO/Wireless 3945ABG Network Connection
iwl3945: Tunable channels: 11 802.11bg, 13 802.11a channels
wmaster0: Selected rate control algorithm 'iwl-3945-rs'
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 5
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input5
ACPI: Lid Switch [LID]
input: Power Button (CM) as /class/input/input6
ACPI: Power Button (CM) [PWRB]
ACPI: AC Adapter [ACAD] (on-line)
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
Linux agpgart interface v0.102 (c) Dave Jones
Intel(R) PRO/1000 Network Driver - version 7.6.5-NAPI
Copyright (c) 1999-2007 Intel Corporation.
PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:02:00.0 to 64
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
iTCO_vendor_support: vendor-support=0
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:36:dd:6d:36
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ACPI: Battery Slot [BAT1] (battery present)
intel_rng: FWH not detected
rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
rtc_cmos: probe of 00:06 failed with error -16
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
wmaster0 renamed to eth1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
wlan0 renamed to wlan0_rename
udev: renamed network interface wmaster0 to eth1
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
PCI: Enabling device 0000:0a:04.2 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ACPI: PCI Interrupt 0000:0a:04.2[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0a:04.2 to 64
tifm_core: MMC/SD card detected in socket 0:1
sdhci: SDHCI controller found at 0000:0a:04.3 [104c:803c] (rev 0)
PCI: Enabling device 0000:0a:04.3 (0000 -> 0002)
ACPI: PCI Interrupt 0000:0a:04.3[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0a:04.3 to 64
mmc0: SDHCI at 0xd0102800 irq 16 DMA
PCI: Enabling device 0000:0a:04.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:0a:04.1[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0a:04.1 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d0102000-d01027ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Yenta: CardBus bridge found at 0000:0a:04.0 [1179:ff31]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:0a:04.0, mfunc 0x01a21b22, devctl 0x66
irq 17: nobody cared (try booting with the "irqpoll" option)
 [<c014fb82>] __report_bad_irq+0x36/0x75
 [<c014fdbb>] note_interrupt+0x1fa/0x237
 [<c0137c56>] getnstimeofday+0x30/0xbe
 [<f8e1175c>] usb_hcd_irq+0x4c/0x54 [usbcore]
 [<c014f2df>] handle_IRQ_event+0x23/0x51
 [<c01504e7>] handle_fasteoi_irq+0x66/0xa8
 [<c0107481>] do_IRQ+0x79/0x90
 [<c0105e73>] common_interrupt+0x23/0x30
 [<f883b0b6>] acpi_processor_idle+0x24c/0x40a [processor]
 [<f883ae6a>] acpi_processor_idle+0x0/0x40a [processor]
 [<f883ae6a>] acpi_processor_idle+0x0/0x40a [processor]
 [<c01033af>] cpu_idle+0xaa/0xcb
 [<c038e9a4>] start_kernel+0x352/0x35a
 [<c038e17e>] unknown_bootoption+0x0/0x216
 =======================
handlers:
[<f8e11710>] (usb_hcd_irq+0x0/0x54 [usbcore])
Disabling IRQ #17
mmcblk0: mmc1:b368 SDC   1960448KiB 
 mmcblk0: p1
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#0a) from #0b to #0e
pcmcia: parent PCI bridge Memory window: 0xd0100000 - 0xd01fffff
JBD: barrier-based sync failed on dm-2 - disabling barriers
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
Adding 8393952k swap on /dev/sda2.  Priority:-1 extents:1 across:8393952k

Laptop review:
http://groups.google.com/group/mosg/msg/e9df8e867e6a557d

-- 
Adam Tauno Williams, Network & Systems Administrator
Consultant - http://www.whitemiceconsulting.com
Developer - http://www.opengroupware.org

