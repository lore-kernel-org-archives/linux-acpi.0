From: Miguel Gea Milvaques <xerakko@debian.org>
Subject: dmidecode for LG P1 PRO Express Dual 150B
Date: Sat, 04 Aug 2007 13:24:09 +0200
Message-ID: <46B461D9.3000604@ellobo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_R89MUBXpZpKF3a6VcXKv+A)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoria1.xtec.net ([213.176.161.24]:39188 "EHLO zoria1.xtec.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749AbXHDMY1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Aug 2007 08:24:27 -0400
Received: from conversion-daemon.zoria1.xtec.net by zoria1.xtec.net
 (Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
 id <0JM800J01Y969M00@zoria1.xtec.net> (original mail from xerakko@debian.org)
 for linux-acpi@vger.kernel.org; Sat, 04 Aug 2007 13:24:18 +0200 (CEST)
Received: from [192.168.1.100] ([85.59.54.134])
 by zoria1.xtec.net (Sun Java System Messaging Server 6.2-4.03 (built Sep 22
 2005)) with ESMTPA id <0JM800DKCYALAZ40@zoria1.xtec.net> for
 linux-acpi@vger.kernel.org; Sat, 04 Aug 2007 13:23:12 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_R89MUBXpZpKF3a6VcXKv+A)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

Hi,
I've seen this message in my dmsg:
...
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
...

So, I sent you my dmidecode and dmesg. Feel free to mail for more info.

--Boundary_(ID_R89MUBXpZpKF3a6VcXKv+A)
Content-type: text/plain; name=dmesg
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dmesg

Linux version 2.6.22-1-amd64 (Debian 2.6.22-3) (waldi@debian.org) (gcc version 4.1.3 20070718 (prerelease) (Debian 4.1.2-14)) #1 SMP Sun Jul 29 13:54:41 UTC 2007
Command line: root=/dev/sda2 ro 
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 261856) 1 entries of 3200 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP 000F63D0, 0014 (r0 PTLTD )
ACPI: RSDT 3FEE2DC7, 0050 (r1 PTLTD  Capell00  6040000  LTP        0)
ACPI: FACP 3FEECDEE, 0074 (r1 LGE    ROCKY     6040000 LOHR       5A)
ACPI: DSDT 3FEE47C7, 8627 (r1 LGE    ROCKY     6040000 INTL 20050309)
ACPI: FACS 3FEEDFC0, 0040
ACPI: APIC 3FEECE62, 0068 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: HPET 3FEECECA, 0038 (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: MCFG 3FEECF02, 003C (r1 INTEL  CALISTGA  6040000 LOHR       5A)
ACPI: BOOT 3FEECFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: APIC 3FEECF70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: SSDT 3FEE45B9, 020A (r1 SataRe SataAhci     1000 INTL 20050624)
ACPI: SSDT 3FEE4176, 0443 (r1 LGE    RKY_EGFX     1000 INTL 20050624)
ACPI: SSDT 3FEE33A3, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
ACPI: SSDT 3FEE32FD, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
ACPI: SSDT 3FEE2E17, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
No NUMA configuration found
Faking a node at 0000000000000000-000000003fee0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 261856) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003fee0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   261856
On node 0 totalpages: 261759
  DMA zone: 56 pages used for memmap
  DMA zone: 1019 pages reserved
  DMA zone: 2924 pages, LIFO batch:0
  DMA32 zone: 3524 pages used for memmap
  DMA32 zone: 254236 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000dc000
swsusp: Registered nosave memory region: 00000000000dc000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 37896 bytes of per cpu data
Built 1 zonelists.  Total pages: 257160
Kernel command line: root=/dev/sda2 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1994.999 MHz processor.
Console: colour VGA+ 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1021556k/1047424k available (2009k kernel code, 25480k reserved, 946k data, 296k init)
Calibrating delay using timer specific routine.. 3994.35 BogoMIPS (lpj=7988716)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring handled by SMI
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 10390606
Detected 10.390 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3990.03 BogoMIPS (lpj=7980074)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz stepping 06
Brought up 2 CPUs
migration_cost=28
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
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
PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#06) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: Power Resource [CTHT] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: ACPI device : hid PNP0A08
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid INT0800
pnp: ACPI device : hid PNP0103
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0401
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0F13
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: match found with the PnP device '00:04' and the driver 'system'
pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
pnp: match found with the PnP device '00:06' and the driver 'system'
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: 00:07: ioport range 0x6a0-0x6af has been reserved
pnp: 00:07: ioport range 0x6b0-0x6ff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: d8000000-d80fffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: d4000000-d5ffffff
  PREFETCH window: d0000000-d1ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: d6000000-d7ffffff
  PREFETCH window: d2000000-d3ffffff
Time: hpet clocksource has been installed.
PCI: Bridge: 0000:00:1c.3
  IO window: disabled.
  MEM window: d8100000-d81fffff
  PREFETCH window: disabled.
PCI: Bus 7, cardbus bridge: 0000:06:00.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: 50000000-53ffffff
  MEM window: 54000000-57ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: d8200000-d82fffff
  PREFETCH window: 50000000-53ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 6900k freed
Simple Boot Flag at 0x38 set to 0x1
audit: initializing netlink socket (disabled)
audit(1186233397.128:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
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
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 296k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Transitioning device [FAN0] to D3
ACPI: Transitioning device [FAN0] to D3
ACPI: Fan [FAN0] (off)
ACPI: SSDT 3FEE3E76, 0238 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 3FEE3602, 07EF (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 3FEE40AE, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 3FEE3DF1, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [TZ0] (52 C)
ACPI: Thermal Zone [TZ1] (40 C)
ACPI: Thermal Zone [TZ2] (40 C)
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xd8504000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pnp: the driver 'ide' has been registered
SCSI subsystem initialized
libata version 2.21 loaded.
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001800
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
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 21, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:06:00.1[A] -> GSI 16 (level, low) -> IRQ 16
firewire_ohci: Added fw-ohci device 0000:06:00.1, OHCI version 1.10
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 19 (level, low) -> IRQ 19
ICH7: chipset revision 2
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
firewire_core: created new fw device fw0 (0 config rom retries)
usb 5-1: new full speed USB device using uhci_hcd and address 2
hda: HL-DT-ST DVDRAM GSA-T10N, ATAPI CD/DVD-ROM drive
usb 5-1: configuration #1 chosen from 1 choice
hda: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ahci 0000:00:1f.2: version 2.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc2001060c500 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1275
ata2: SATA max UDMA/133 cmd 0xffffc2001060c580 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1275
ata3: SATA max UDMA/133 cmd 0xffffc2001060c600 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1275
ata4: SATA max UDMA/133 cmd 0xffffc2001060c680 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 1275
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: FUJITSU MHV2100BH, 00000028, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2100B 0000 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
hda: ATAPI<5>sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
 sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Attempting manual resume
swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
et131x: module license 'BSD' taints kernel.
10/100/1000 Base-T Ethernet Driver for the ET1310, v1.2.3 01/31/2006 15:40:00 by Agere Systems, http://www.agere.com
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
Yenta: CardBus bridge found at 0000:06:00.0 [1854:005f]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:00.0, mfunc 0x01001002, devctl 0x64
intel_rng: FWH not detected
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#06) from #06 to #0a
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x5fff
pcmcia: parent PCI bridge Memory window: 0xd8200000 - 0xd82fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
ACPI: PCI Interrupt 0000:06:00.2[A] -> GSI 16 (level, low) -> IRQ 16
tifm_core: MMC/SD card detected in socket 0:1
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
Bluetooth: HCI USB driver ver 2.9
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
usbcore: registered new interface driver hci_usb
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:06:00.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:06:00.3[A] -> GSI 16 (level, low) -> IRQ 16
mmc0: SDHCI at 0xd8205800 irq 16 PIO
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.2.1dmpr
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:05:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
iTCO_wdt: Found a ICH7-M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 5, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
hda_intel: azx_get_response timeout, switching to polling mode...
Adding 3028244k swap on /dev/sda3.  Priority:-1 extents:1 across:3028244k
EXT3 FS on sda2, internal journal
loop: module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth2: link is not ready
ACPI: Battery Slot [CMB0] (battery present)
ACPI: AC Adapter [AC] (on-line)
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /class/input/input3
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
lp0: using parport0 (interrupt-driven).
ppdev: user-space parallel port driver
vboxdrv: Trying to deactivate NMI watchdog permanently...
vboxdrv: Successfully done.
eth1: no IPv6 routers present
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8946
[fglrx] Maximum main memory to use for locked dma buffers: 922 MBytes.
[fglrx] module loaded - fglrx 8.38.6 [Jun 22 2007] on minor 0
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[fglrx:drm_parse_option] *ERROR* "agplock" is not a valid option
[fglrx] Maximum main memory to use for locked dma buffers: 922 MBytes.
[fglrx] total      GART = 130023424
[fglrx] free       GART = 114032640
[fglrx] max single GART = 114032640
[fglrx] total      LFB  = 134086656
[fglrx] free       LFB  = 99209216
[fglrx] max single LFB  = 99209216
[fglrx] total      Inv  = 0
[fglrx] free       Inv  = 0
[fglrx] max single Inv  = 0
[fglrx] total      TIM  = 0
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
et131x.ko:WARNING:et131x_ioctl Unhandled IOCTL Code: 0x8b01
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)

--Boundary_(ID_R89MUBXpZpKF3a6VcXKv+A)
Content-type: text/plain; name=dmidecode
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=dmidecode

# dmidecode 2.9
SMBIOS 2.4 present.
30 structures occupying 988 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies LTD
	Version: RKYWSF21
	Release Date: 11/10/2006
	Address: 0xE4B00
	Runtime Size: 111872 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: LG Electronics
	Product Name: P1-J150B
	Version: Not Applicable
	Serial Number: 701KSWK002977
	UUID: 80B450F8-B164-0010-94B0-E3E13E4B84D0
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: LG Electronics
	Product Name: ROCKY
	Version: Not Applicable
	Serial Number: Not Applicable

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: LG Electronics
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU         T7
	Voltage: 1.2 V
	External Clock: Unknown
	Max Speed: 2160 MHz
	Current Speed: 2000 MHz
	Status: Populated, Enabled
	Upgrade: Slot 1
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
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
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 4096 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Express Slot
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Long
	ID: 8
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: HD-Audio

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: LG Electronics
	String 2: Customer Satisfaction First

Handle 0x000A, DMI type 15, 29 bytes
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000002
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 3 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: No Error
	Total Width: 32 bits
	Data Width: 32 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: 1
	Locator: M2
	Bank Locator: Bank 1
	Type: DDR2
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x000E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x000B
	Partition Width: 0

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0010, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000D
	Memory Array Mapped Address Handle: 0x000E
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0011, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0012, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x0013, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0014, DMI type 26, 20 bytes
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x0016
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x0016, DMI type 28, 20 bytes
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0017, DMI type 29, 20 bytes
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0018, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0019, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x001A, DMI type 129, 16 bytes
OEM-specific Type
	Header and Data:
		81 10 1A 00 01 01 02 01 00 00 00 01 00 00 08 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x001B, DMI type 136, 8 bytes
OEM-specific Type
	Header and Data:
		88 08 1B 00 FF FF 00 00
	Strings:
		...
		..

Handle 0x001C, DMI type 150, 14 bytes
OEM-specific Type
	Header and Data:
		96 0E 1C 00 01 01 00 00 00 00 00 00 00 00
	Strings:
		ABSOLUTE(PHOENIX) CLM

Handle 0x001D, DMI type 127, 4 bytes
End Of Table


--Boundary_(ID_R89MUBXpZpKF3a6VcXKv+A)--
