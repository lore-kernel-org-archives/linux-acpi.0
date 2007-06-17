From: Federico Manzan <f.manzan@gmail.com>
Subject: linux kernel 2.6.22-rc5
Date: Sun, 17 Jun 2007 21:26:20 +0200
Message-ID: <46758ADC.1050608@gmail.com>
Reply-To: f.manzan@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090503090805070806060203"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:30007 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732AbXFQT3i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jun 2007 15:29:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1242127ugf
        for <linux-acpi@vger.kernel.org>; Sun, 17 Jun 2007 12:29:36 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503090805070806060203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have new kernel linux kernel 2.6.22-rc5, in a Toshiba Tecra A7

ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org

If you want, I can send other file, or make test.

Thanks for your work
Ciao
Federico

-- 
--------------------------
AUTOMIX di Federico Manzan
Via G. Garibaldi, n.17/3 
31050 Ponzano Veneto
Treviso - Italy
P.I. 04118510264
C.F. MNZFRC71H11L407M
+39 339 7467904
f.manzan@gmail.com
--------------------------


--------------090503090805070806060203
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.22-rc5 (root@cerbiattolo3) (gcc version 4.1.3 20070601 (prerelease) (Debian 4.1.2-12)) #1 SMP PREEMPT Sun Jun 17 18:33:06 CEST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe70000 (usable)
 BIOS-e820: 000000003fe70000 - 000000003fe86000 (ACPI data)
 BIOS-e820: 000000003fe86000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f65d0
Entering add_active_range(0, 0, 261744) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261744
early_node_map[1] active PFN ranges
    0:        0 ->   261744
On node 0 totalpages: 261744
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 252 pages used for memmap
  HighMem zone: 32116 pages, LIFO batch:7
DMI present.
ACPI: RSDP 000F6520, 0014 (r0 TOSINV)
ACPI: RSDT 3FE7E25D, 0048 (r1 TOSINV Capell00  6040000  LTP        0)
ACPI: FACP 3FE85DEE, 0074 (r1 TOSINV CALISTGA  6040000 LOHR       5A)
ACPI: DSDT 3FE7F912, 64DC (r1 TOSINV CALISTGA  6040000 INTL 20050624)
ACPI: FACS 3FE86FC0, 0040
ACPI: APIC 3FE85E62, 0068 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: HPET 3FE85ECA, 0038 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: MCFG 3FE85F02, 003C (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: BOOT 3FE85FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: APIC 3FE85F70, 0068 (r1 TOSINV   APIC    6040000  LTP        0)
ACPI: SSDT 3FE7F2BF, 064F (r1 SataRe  SataPri     1000 INTL 20050624)
ACPI: SSDT 3FE7EC2D, 0692 (r1 SataRe  SataSec     1000 INTL 20050624)
ACPI: SSDT 3FE7E2A5, 04F6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
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
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists.  Total pages: 259700
Kernel command line: root=/dev/sda5 resume=/dev/sda3 pci=assign-busses quiet ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1828.984 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031540k/1046976k available (3798k kernel code, 14840k reserved, 1213k data, 276k init, 129472k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9d000 - 0xfffff000   ( 392 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc05ed000 - 0xc0632000   ( 276 kB)
      .data : 0xc04b5ae5 - 0xc05e529c   (1213 kB)
      .text : 0xc0100000 - 0xc04b5ae5   (3798 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Calibrating delay using timer specific routine.. 3660.73 BogoMIPS (lpj=1830366)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.53 BogoMIPS (lpj=1828767)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00002940 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
Total of 2 processors activated (7318.26 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=48
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Power Resource [FN00] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 23
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
Time: tsc clocksource has been installed.
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: d6000000-d7ffffff
  PREFETCH window: d0000000-d1ffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 4000-4fff
  MEM window: d8000000-d9ffffff
  PREFETCH window: d2000000-d3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 5000-5fff
  MEM window: da000000-dbffffff
  PREFETCH window: d4000000-d5ffffff
PCI: Bus 6, cardbus bridge: 0000:05:06.0
  IO window: 00006000-000060ff
  IO window: 00006400-000064ff
  PREFETCH window: 50000000-53ffffff
  MEM window: 54000000-57ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-6fff
  MEM window: dc100000-dc1fffff
  PREFETCH window: 50000000-53ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Enabling device 0000:05:06.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:05:06.0[A] -> GSI 18 (level, low) -> IRQ 18
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
highmem bounce pool size: 64 pages
squashfs: version 3.2-r2 (2007/01/15) Phillip Lougher
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.28 [Flags: R/W].
fuse init (API version 7.8)
JFS: nTxBlock = 8060, nTxLock = 64484
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
0000:00:1d.7 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
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
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
ACPI: Transitioning device [FAN0] to D3
ACPI: Transitioning device [FAN0] to D3
ACPI: Fan [FAN0] (off)
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI: SSDT 3FE7E9FC, 01A8 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 3FE7E79B, 01DC (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 3FE7EBA4, 0089 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 3FE7E977, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Invalid passive threshold
ACPI: Transitioning device [FAN0] to D0
ACPI: Transitioning device [FAN0] to D0
ACPI: Unable to turn cooling device [c19213d8] 'on'
ACPI: Thermal Zone [TZ00] (57 C)
ACPI: Thermal Zone [TZ01] (60 C)
isapnp: Scanning for PnP cards...
Marking TSC unstable due to: possible TSC halt in C2.
Time: hpet clocksource has been installed.
isapnp: No Plug & Play device found
DoubleTalk PC - not found
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
toshiba: not a supported Toshiba laptop
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
floppy0: no floppy controllers found
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:a0:d1:3b:82:0c
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Intel(R) PRO/10GbE Network Driver - version 1.0.126-k2
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x000118b0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x000118b8 irq 15
ata1.00: ata_hpa_resize 1: sectors = 195371568, hpa_sectors = 195371568
ata1.00: ATA-7: FUJITSU MHV2100BH PL, 00000029, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: ata_hpa_resize 1: sectors = 195371568, hpa_sectors = 195371568
ata1.00: configured for UDMA/100
ata2.00: ATAPI: MATSHITADVD-RAM UJ-841S, 1.60, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 0000 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-841S  1.60 PQ: 0 ANSI: 5
scsi 1:0:0:0: Attached scsi generic sg1 type 5
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xdc404000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 2
usb 1-6: configuration #1 chosen from 1 choice
hub 1-6:1.0: USB hub found
hub 1-6:1.0: 7 ports detected
usb 1-6.6: new low speed USB device using ehci_hcd and address 3
usb 1-6.6: configuration #1 chosen from 1 choice
usbcore: registered new interface driver libusual
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Suspend v2.2.10.1
Suspend2 Checksumming support registered.
Suspend2 Userspace Storage Manager support registered.
Suspend2 Basic User Interface support registered.
Suspend2 Compressor support registered.
Suspend2 Block I/O support registered.
Suspend2 Swap Allocator support registered.
Suspend2 File Allocator support registered.
Suspend2 Userspace UI support registered.
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input4
Replacing swsusp.
No storage allocator is currently active. Rechecking whether we can use one.
Suspend2: SwapAllocator: Signature found.
Suspend2: Resuming enabled.
Suspend2: Normal swapspace found.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
usb 1-6.5: new full speed USB device using ehci_hcd and address 4
usb 1-6.5: configuration #1 chosen from 1 choice
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Linux agpgart interface v0.102 (c) Dave Jones
intel_rng: FWH not detected
agpgart: Detected an Intel 945GME Chipset.
agpgart: AGP aperture is 256M @ 0x0
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:05:06.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:05:06.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[dc105000-dc1057ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
usbcore: registered new interface driver hiddev
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:05:06.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:05:06.3[A] -> GSI 18 (level, low) -> IRQ 18
mmc0: SDHCI at 0xdc105800 irq 18 DMA
input: Logitech USB-PS/2 Optical Mouse as /class/input/input5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.7-6.6
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
smsc_ircc_present(), addr 0x0158 - no device found!
pnp: Device 00:09 disabled.
Yenta: CardBus bridge found at 0000:05:06.0 [1179:ff10]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:05:06.0, mfunc 0x01a01b22, devctl 0x66
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 5 [PCSPP,TRISTATE]
Yenta: ISA IRQ mask 0x0cd8, PCI irq 18
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
cs: IO port probe 0x6000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xdc100000 - 0xdc1fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x400-0x407 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0d13b820c]
scsi 2:0:0:0: Direct-Access     Option   ICON             2.31 PQ: 0 ANSI: 2
sd 2:0:0:0: [sdb] READ CAPACITY failed
sd 2:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 2:0:0:0: [sdb] Sense Key : Not Ready [current] 
sd 2:0:0:0: [sdb] Add. Sense: No additional sense information
sd 2:0:0:0: [sdb] Test WP failed, assume Write Enabled
sd 2:0:0:0: [sdb] Assuming drive cache: write through
sd 2:0:0:0: [sdb] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete
Adding 1028152k swap on /dev/sda3.  Priority:-1 extents:1 across:1028152k
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

--------------090503090805070806060203--
