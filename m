From: Andrew Morton <akpm@osdl.org>
Subject: acpi warning with current git tree
Date: Wed, 1 Nov 2006 23:29:19 -0800
Message-ID: <20061101232919.bb12620c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:24720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752707AbWKBH3X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 02:29:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>


This is with the full -mm lineup on my old Nocona Intel SDV machine:

Linux version 2.6.19-rc4-mm2 (akpm@box) (gcc version 4.0.2) #2 SMP PREEMPT Wed Nov 1 23:20:15 PST 2006
Command line: root=/dev/sda3 profile=1 ro rhgb netconsole=4444@192.168.2.15/eth0,5141@192.168.2.33/00:0D:56:C6:C6:CC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524240) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1572864) 2 entries of 256 used
end_pfn_map = 1572864
DMI not present or invalid.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6710
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0000
ACPI: FADT (v002 A M I  OEMFACP  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0200
ACPI: MADT (v001 A M I  OEMAPIC  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0390
ACPI: MCFG (v001 Intel  Cayuse   0x00000001 MSFT 0x00000001) @ 0x000000007ffd0420
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000427 MSFT 0x00000097) @ 0x000000007ffdf040
ACPI: HPET (v001 A M I  OEMHPET  0x05000427 MSFT 0x00000097) @ 0x000000007ffd7460
ACPI: DSDT (v001  CYCRB CYCRB039 0x00000039 INTL 0x02002026) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524240) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1572864) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1572864
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524240
    0:  1048576 ->  1572864
On node 0 totalpages: 1048431
  DMA zone: 64 pages used for memmap
  DMA zone: 1236 pages reserved
  DMA zone: 2699 pages, LIFO batch:0
  DMA32 zone: 16320 pages used for memmap
  DMA32 zone: 503824 pages, LIFO batch:31
  Normal zone: 8192 pages used for memmap
  Normal zone: 516096 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 10, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000ec000
Nosave address range: 00000000000ec000 - 0000000000100000
Nosave address range: 000000007ffd0000 - 000000007ffdf000
Nosave address range: 000000007ffdf000 - 0000000080000000
Nosave address range: 0000000080000000 - 00000000e0000000
Nosave address range: 00000000e0000000 - 00000000f0000000
Nosave address range: 00000000f0000000 - 00000000ffc00000
Nosave address range: 00000000ffc00000 - 0000000100000000
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 33536 bytes of per cpu data
Built 1 zonelists.  Total pages: 1022619
Kernel command line: root=/dev/sda3 profile=1 ro rhgb netconsole=4444@192.168.2.15/eth0,5141@192.168.2.33/00:0D:56:C6:C6:CC
kernel profiling enabled (shift: 1)
netconsole: local port 4444
netconsole: local IP 192.168.2.15
netconsole: interface eth0
netconsole: remote port 5141
netconsole: remote IP 192.168.2.33
netconsole: remote ethernet address 00:0d:56:c6:c6:cc
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x7c1d000 - 0xbc1d000
Memory: 4012040k/6291456k available (2921k kernel code, 181608k reserved, 1161k data, 196k init)
Calibrating delay using timer specific routine.. 6806.26 BogoMIPS (lpj=13612521)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 461 Objects with 50 Devices 130 Methods 11 Regions
ACPI Namespace successfully loaded at root ffffffff806b2b60
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.
result 12500770
Detected 12.500 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6800.53 BogoMIPS (lpj=13601068)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 6800.35 BogoMIPS (lpj=13600712)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6800.35 BogoMIPS (lpj=13600706)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3400.241 MHz processor.
migration_cost=6,963
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:..............................................................................................
Initialized 10/11 Regions 26/26 Fields 36/36 Buffers 22/23 Packages (470 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:
Executed 0 _INI methods requiring 0 _STA executions (examined 56 objects)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:05:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
intel_rng: FWH not detected
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:02:00.0
  IO window: d000-dfff
  MEM window: fa400000-fa6fffff
  PREFETCH window: bfe00000-bfefffff
PCI: Bridge: 0000:02:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: d000-dfff
  MEM window: fa400000-fa8fffff
  PREFETCH window: bfe00000-bfefffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: fa900000-feafffff
  PREFETCH window: bff00000-dfefffff
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: fa300000-fa3fffff
  PREFETCH window: 88000000-880fffff
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:02:00.2 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFF0 [20060707]

Call Trace:
 [<ffffffff8037aba9>] acpi_format_exception+0xbd/0xc8
 [<ffffffff80377545>] acpi_ut_status_exit+0x43/0x85
 [<ffffffff8039f794>] hpet_resources+0x0/0x138
 [<ffffffff80373381>] acpi_walk_resources+0x13c/0x14e
 [<ffffffff8039f743>] hpet_acpi_add+0x40/0x91
 [<ffffffff80388087>] acpi_bus_driver_init+0x2f/0x95
 [<ffffffff80388331>] acpi_bus_register_driver+0xb8/0x145
 [<ffffffff8062fcea>] hpet_init+0x3d/0x6b
 [<ffffffff802071ae>] init+0x152/0x308
 [<ffffffff804d75d3>] _spin_unlock_irq+0x14/0x30
 [<ffffffff8022c6d4>] schedule_tail+0x43/0x9f
 [<ffffffff8020a6f8>] child_rip+0xa/0x12
 [<ffffffff8020705c>] init+0x0/0x308
 [<ffffffff8020a6ee>] child_rip+0x0/0x12

Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k4
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 17 (level, low) -> IRQ 17
e1000: 0000:01:02.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:2f:2c:c1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.59.
netconsole: device eth0 not up yet, forcing it
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
netconsole: network logging started
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 30 (level, low) -> IRQ 30
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
scsi 0:0:5:0: Direct-Access     MAXTOR   ATLAS10K4_73WLS  DFV0 PQ: 0 ANSI: 3
 target0:0:5: asynchronous
scsi0:A:5:0: Tagged Queuing enabled.  Depth 64
 target0:0:5: Beginning Domain Validation
 target0:0:5: wide asynchronous
 target0:0:5: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS (6.25 ns, offset 127)
 target0:0:5: Ending Domain Validation
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 31 (level, low) -> IRQ 31
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
3ware Storage Controller device driver for Linux v1.26.02.001.
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
sda: Write Protect is off
sda: Mode Sense: ed 00 10 08
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
sda: Write Protect is off
sda: Mode Sense: ed 00 10 08
SCSI device sda: drive cache: write back w/ FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:5:0: Attached scsi disk sda
sd 0:0:5:0: Attached scsi generic sg0 type 0
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebff400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc4-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000e080
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e400
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e480
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.19-rc4-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
Intel 810 + AC97 Audio, version 1.01, 23:19:31 Nov  1 2006
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xe880 and 0xec00, MEM 0xfebffc00 and 0xfebff800, IRQ 17
i810: Intel ICH5 mmio at 0xffffc20000012c00 and 0xffffc20000014800
input: AT Translated Set 2 keyboard as /class/input/input0
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ADS116 (Analog Devices AD1981B)
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 196k freed
eth0: no IPv6 routers present
warning: process `kmodule' used the removed sysctl system call with 1.23.
asus_acpi: Unknown symbol backlight_device_unregister
asus_acpi: Unknown symbol backlight_device_register
Using specific hotkey driver
ibm_acpi: Unknown symbol backlight_device_unregister
ibm_acpi: Unknown symbol backlight_device_register
sony_acpi: Unknown symbol backlight_device_unregister
sony_acpi: Unknown symbol backlight_device_register
toshiba_acpi: Unknown symbol backlight_device_unregister
toshiba_acpi: Unknown symbol backlight_device_register
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /usr/src/swap.  Priority:-1 extents:280 across:1088960k
hald[3913]: segfault at 0000000000000000 rip 000000302046f200 rsp 00007fff65892b68 error 4

