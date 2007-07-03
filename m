From: eric <ericm24x7@gmail.com>
Subject: RTC wakeup
Date: Tue, 03 Jul 2007 14:56:55 -0400
Message-ID: <468A9BF7.7030201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000403010903040805090305"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:7903 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbXGCS5b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jul 2007 14:57:31 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1319094nze
        for <linux-acpi@vger.kernel.org>; Tue, 03 Jul 2007 11:57:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000403010903040805090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm currently trying to activate the RTC alarm that I setup under CMOS, 
which supposed to wakeup the system at certain time on the daily basis. 
If  I shutdown the system under Windows OS, RTC alarm wakeup the system 
as intended; however, after shutdown under Linux (Fedora - kernel ver. 
2.6.21-1.3240.fc8) it fails to wakeup the system.

The system's chipset that is FAILING under linux:
NVIDIA MCP61S
motherboard: ECS GeFforce6100S-M

The system's chipset that is WORKING OK under linux:
RS482 (northbridge) , SB400/SB450 (southbridge)
motherboard: ECS RS482-M

Sorry: resent due to missing attachments
-----------------------------------------------
Any suggested workaround solution would be appreciated.

Attached is a copy of the outputs from: dmesg, /proc/acpi/wakeup, dmidecode

thanks.
eric

--------------000403010903040805090305
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.21-1.3240.fc8 (kojibuilder@xenbuilder2.fedora.redhat.com) (gcc version 4.1.2 20070615 (Red Hat 4.1.2-13)) #1 SMP Mon Jun 25 20:04:45 EDT 2007
Command line: ro root=LABEL=/ rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003bee0000 (usable)
 BIOS-e820: 000000003bee0000 - 000000003bee3000 (ACPI NVS)
 BIOS-e820: 000000003bee3000 - 000000003bef0000 (ACPI data)
 BIOS-e820: 000000003bef0000 - 000000003bf00000 (reserved)
 BIOS-e820: 000000003c000000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 245472) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.2 present.
ACPI: RSDP 000F7A10, 0014 (r0 Nvidia)
ACPI: RSDT 3BEE3040, 0038 (r1 Nvidia NVDAACPI 42302E31 NVDA        0)
ACPI: FACP 3BEE30C0, 0074 (r1 Nvidia NVDAACPI 42302E31 NVDA        0)
ACPI Warning (tbfadt-0434): Optional field "Pm2ControlBlock" has zero address or length: 0000000000000000/1 [20070126]
ACPI: DSDT 3BEE3180, 6395 (r1 NVIDIA NVDAACPI     1000 MSFT  100000E)
ACPI: FACS 3BEE0000, 0040
ACPI: SSDT 3BEE9640, 0248 (r1 PTLTD  POWERNOW        1  LTP        1)
ACPI: HPET 3BEE9900, 0038 (r1 Nvidia NVDAACPI 42302E31 NVDA       98)
ACPI: MCFG 3BEE9980, 003C (r1 Nvidia NVDAACPI 42302E31 NVDA        0)
ACPI: APIC 3BEE9580, 007C (r1 Nvidia NVDAACPI 42302E31 NVDA        0)
Scanning NUMA topology in Northbridge 24
No NUMA configuration found
Faking a node at 0000000000000000-000000003bee0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 245472) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003bee0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   245472
On node 0 totalpages: 245375
  DMA zone: 88 pages used for memmap
  DMA zone: 2377 pages reserved
  DMA zone: 1534 pages, LIFO batch:0
  DMA32 zone: 5185 pages used for memmap
  DMA32 zone: 236191 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10de8201 base: 0xfeff0000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 41864 bytes of per cpu data
Built 1 zonelists.  Total pages: 237725
Kernel command line: ro root=LABEL=/ rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2310.647 MHz processor.
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Checking aperture...
CPU 0: aperture @ 2e000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 946084k/981888k available (2416k kernel code, 35416k reserved, 1467k data, 320k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 4625.37 BogoMIPS (lpj=2312688)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12557877
Detected 12.557 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4621.39 BogoMIPS (lpj=2310697)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 01
Brought up 2 CPUs
sizeof(vma)=176 bytes
sizeof(page)=88 bytes
sizeof(inode)=1008 bytes
sizeof(dentry)=248 bytes
sizeof(ext3inode)=1376 bytes
sizeof(buffer_head)=104 bytes
sizeof(skbuff)=232 bytes
sizeof(task_struct)=3920 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f0000000 - f3ffffff
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:04.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIGP] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [AIGP] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 15 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfeff0000, IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
ACPI: RTC can wake from S4
Time: hpet clocksource has been installed.
pnp: 00:01: ioport range 0x1000-0x107f has been reserved
pnp: 00:01: ioport range 0x1080-0x10ff has been reserved
pnp: 00:01: ioport range 0x1400-0x147f has been reserved
pnp: 00:01: ioport range 0x1480-0x14ff has been reserved
pnp: 00:01: ioport range 0x1800-0x187f has been reserved
pnp: 00:01: ioport range 0x1880-0x18ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
pnp: 00:01: iomem range 0x0-0x0 could not be reserved
pnp: 00:01: iomem range 0xfefe0000-0xfefe01ff has been reserved
pnp: 00:01: iomem range 0xfefe1000-0xfefe10ff has been reserved
pnp: 00:01: iomem range 0x3c000000-0x3fffffff could not be reserved
pnp: 00:0d: iomem range 0xf0000000-0xf3ffffff could not be reserved
pnp: 00:0e: iomem range 0xf0000-0xfffff could not be reserved
pnp: 00:0e: iomem range 0xfeff0000-0xfeff00ff could not be reserved
pnp: 00:0e: iomem range 0x3bee0000-0x3befffff could not be reserved
pnp: 00:0e: iomem range 0xffff0000-0xffffffff has been reserved
PCI: Bridge: 0000:00:04.0
  IO window: c000-cfff
  MEM window: fdf00000-fdffffff
  PREFETCH window: fd800000-fd8fffff
PCI: Bridge: 0000:00:09.0
  IO window: b000-bfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:0b.0
  IO window: a000-afff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fdb00000-fdbfffff
PCI: Bridge: 0000:00:0c.0
  IO window: 9000-9fff
  MEM window: fda00000-fdafffff
  PREFETCH window: fd900000-fd9fffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3145k freed
audit: initializing netlink socket (disabled)
audit(1183467715.938:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key E7A1F74B94C80B08
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:0d.0
PCI: Setting latency timer of device 0000:00:09.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:09.0:pcie00]
Allocate Port Service[0000:00:09.0:pcie03]
PCI: Setting latency timer of device 0000:00:0b.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (21 C)
hpet_resources: 0xfeff0000 is busy
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xf (2300 MHz), vid 0x9
powernow-k8:    1 : fid 0xe (2200 MHz), vid 0xa
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0xc
powernow-k8:    3 : fid 0xa (1800 MHz), vid 0xe
powernow-k8:    4 : fid 0x2 (1000 MHz), vid 0x12
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 320k freed
Write protecting the kernel read-only data: 1088k
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 23, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 22, io mem 0xfe02e000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
input: ImPS/2 Generic Wheel Mouse as /class/input/input2
SCSI subsystem initialized
libata version 2.21 loaded.
sata_nv 0000:00:08.0: version 3.4
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSI] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
scsi0 : sata_nv
scsi1 : sata_nv
ata1: SATA max UDMA/133 cmd 0x00000000000109f0 ctl 0x0000000000010bf2 bmdma 0x000000000001d800 irq 0
ata2: SATA max UDMA/133 cmd 0x0000000000010970 ctl 0x0000000000010b72 bmdma 0x000000000001d808 irq 0
usb 2-1: new high speed USB device using ehci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ata_hpa_resize 1: sectors = 586072368, hpa_sectors = 586072368
ata1.00: ATA-7: ST3300622AS, 3.AAH, max UDMA/133
ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: ata_hpa_resize 1: sectors = 586072368, hpa_sectors = 586072368
ata1.00: configured for UDMA/133
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x0000000000010977
scsi 0:0:0:0: Direct-Access     ATA      ST3300622AS      3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: [sda] Attached SCSI disk
pata_amd 0000:00:06.0: version 0.3.8
PCI: Setting latency timer of device 0000:00:06.0 to 64
scsi2 : pata_amd
scsi3 : pata_amd
ata3: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001f000 irq 14
ata4: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001f008 irq 15
ata3.00: ATAPI: PIONEER DVD-RW  DVR-111D, 1.23, max UDMA/66
ata3.00: configured for UDMA/66
ata4: port disabled. ignoring.
scsi 2:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-111D 1.23 PQ: 0 ANSI: 5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1183467723.766:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1818 types, 79 bools, 1 sens, 1024 cats
security:  60 classes, 67250 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda2, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev anon_inodefs, type anon_inodefs), not configured for labeling
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1183467724.250:3): policy loaded auid=4294967295
audit(1183467724.682:4): avc:  denied  { getattr } for  pid=546 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 2:0:0:0: Attached scsi generic sg1 type 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0
i2c-adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c-adapter i2c-1: nForce2 SMBus adapter at 0xf400
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:07.0 to 64
forcedeth: using HIGHDMA
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k
parport_pc 00:0a: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
eth0: forcedeth.c: subsystem: 01019:2602 bound to 0000:00:07.0
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
3c59x: Donald Becker and others.
0000:01:05.0: 3Com PCI 3c905B Cyclone 100baseTx at ffffc200001f4000.
PCI: Setting latency timer of device 0000:01:05.0 to 64
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:05.0[B] -> Link [AAZA] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:05.0 to 64
usb 2-1: reset high speed USB device using ehci_hcd and address 2
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
zd1211rw_mac80211 2-1:1.0: firmware version 4605
zd1211rw_mac80211 2-1:1.0: zd1211 chip 0ace:1211 v4330 high 00-11-a3 RF2959_RF pa0 -----
wmaster0: Selected rate control algorithm 'simple'
zd1211rw_mac80211 2-1:1.0: phy0
usbcore: registered new interface driver zd1211rw_mac80211
SELinux: initialized (dev kvmfs, type kvmfs), uses genfs_contexts
loop: module loaded
FDC 0 is a post-1991 82077
lp0: using parport0 (interrupt-driven).
lp0: console ready
audit(1183482131.774:5): avc:  denied  { getattr } for  pid=1473 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
No dock devices found.
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
audit(1183482133.327:6): avc:  denied  { getattr } for  pid=1571 comm="fsck" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.393:7): avc:  denied  { getattr } for  pid=1572 comm="fsck.ext3" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.421:8): avc:  denied  { getattr } for  pid=1573 comm="fsck.ext3" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.521:9): avc:  denied  { getattr } for  pid=1576 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
EXT3 FS on sda2, internal journal
audit(1183482133.723:10): avc:  denied  { getattr } for  pid=1580 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.729:11): avc:  denied  { getattr } for  pid=1581 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.733:12): avc:  denied  { getattr } for  pid=1582 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.738:13): avc:  denied  { getattr } for  pid=1583 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.743:14): avc:  denied  { getattr } for  pid=1584 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482133.747:15): avc:  denied  { getattr } for  pid=1585 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda5, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
audit(1183482134.563:16): avc:  denied  { getattr } for  pid=1634 comm="swapon" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:fsadm_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1 across:2048276k
audit(1183482134.589:17): avc:  denied  { getattr } for  pid=1635 comm="mount" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:mount_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
audit(1183482136.542:18): avc:  denied  { getattr } for  pid=1757 comm="iptables-restor" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:iptables_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (3835 buckets, 30680 max)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
audit(1183482139.527:19): avc:  denied  { getattr } for  pid=1987 comm="ifconfig" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:ifconfig_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482144.401:20): avc:  denied  { getattr } for  pid=2126 comm="ifconfig" name="/" dev=selinuxfs ino=1 scontext=system_u:system_r:ifconfig_t:s0 tcontext=system_u:object_r:security_t:s0 tclass=filesystem
audit(1183482144.853:21): audit_pid=2170 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth1: no IPv6 routers present
Bridge firewalling registered
device eth1 entered promiscuous mode
br80: port 1(eth1) entering learning state
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device tap82 entered promiscuous mode
br80: port 2(tap82) entering learning state
br80: no IPv6 routers present
tap82: no IPv6 routers present
eth1: no IPv6 routers present
br80: topology change detected, propagating
br80: port 1(eth1) entering forwarding state
br80: topology change detected, propagating
br80: port 2(tap82) entering forwarding state
kvm: emulating exchange as write

--------------000403010903040805090305
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.7
SMBIOS 2.2 present.
46 structures occupying 1734 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 19 bytes.
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 03/03/2007
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 512 kB
	Characteristics:
		ISA is supported
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

Handle 0x0001, DMI type 1, 25 bytes.
System Information
	Manufacturer:  
	Product Name:  
	Version:  
	Serial Number:  
	UUID: FEFEFEFE-FEFE-FEFE-FEFE-FEFEFEFEFEFE
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 188, 255 bytes.
OEM-specific Type
	Header and Data:
		BC FF 02 00 4B 38 4E 50 54 44 52 41 4D 30 03 00
		00 00 00 00 3F 00 00 00 00 00 01 00 00 00 00 00
		00 00 02 00 00 00 00 00 00 00 03 00 00 00 00 00
		00 00 04 00 00 00 00 00 00 00 05 00 00 00 00 00
		00 00 06 00 00 00 00 00 00 00 07 00 00 00 00 00
		00 00 40 00 10 0A 00 00 00 00 00 00 04 00 EF 02
		00 FF 01 00 00 00 81 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 60 3F 38 00 00 00 00 00 00 00 00 00 00 00
		00 00 46 00 00 00 00 00 00 00 02 00 00 00 00 00
		00 00 24 C2 6A 5D 20 13 12 00 10 04 01 00 6A 00
		10 67 88 88 FF FE 14 14 14 15 13 13 13 13 14 00
		00 00 12 13 13 13 14 13 13 14 12 00 00 00 2D 00
		00 00 00 00 00 00 00 00 00 00 00 2F 2F 2F 2F 2F
		2F 2F 2F 00 00 00 00 00 22 12 11 20 20 22 20 00
		22 12 11 10 20 22 20 00 00 00 00 00 00 00 00
	Strings:
		 

Handle 0x0003, DMI type 190, 255 bytes.
OEM-specific Type
	Header and Data:
		BE FF 03 00 00 00 00 40 00 00 00 00 00 00 00 00
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
		 

Handle 0x0004, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer:  
	Product Name: NF-MCP61
	Version:  
	Serial Number:  

Handle 0x0005, DMI type 3, 13 bytes.
Chassis Information
	Manufacturer:  
	Type: Desktop
	Lock: Not Present
	Version:  
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown

Handle 0x0006, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: Socket M2 
	Type: Central Processor
	Family: Sempron
	Manufacturer: AMD
	ID: B1 0F 06 00 FF FB 8B 17
	Signature: Extended Family 0, Model B, Stepping 1
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
	Version: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
	Voltage: 1.3 V
	External Clock: 201 MHz
	Max Speed: 3000 MHz
	Current Speed: 2312 MHz
	Status: Populated, Enabled
	Upgrade: Socket 940
	L1 Cache Handle: 0x000D
	L2 Cache Handle: 0x000F
	L3 Cache Handle: No L3 Cache

Handle 0x0007, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: Socket M2 
	Type: Central Processor
	Family: Sempron
	Manufacturer: AMD
	ID: B1 0F 06 00 FF FB 8B 17
	Signature: Extended Family 0, Model B, Stepping 1
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
	Version: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
	Voltage: 1.3 V
	External Clock: 201 MHz
	Max Speed: 3000 MHz
	Current Speed: 2312 MHz
	Status: Populated, Enabled
	Upgrade: Socket 940
	L1 Cache Handle: 0x000E
	L2 Cache Handle: 0x0010
	L3 Cache Handle: No L3 Cache

Handle 0x0008, DMI type 5, 24 bytes.
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 4096 MB
	Maximum Total Memory Size: 16384 MB
	Supported Speeds:
		70 ns
		60 ns
		50 ns
	Supported Memory Types:
		Standard
		DIMM
	Memory Module Voltage: 2.9 V
	Associated Memory Slots: 4
		0x0009
		0x000A
		0x000B
		0x000C
	Enabled Error Correcting Capabilities: None

Handle 0x0009, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A0
	Bank Connections: 0 1
	Current Speed: 6 ns
	Type: Other Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A1
	Bank Connections: None
	Current Speed: 6 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A2
	Bank Connections: None
	Current Speed: 6 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000C, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: A3
	Bank Connections: None
	Current Speed: 6 ns
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x000D, DMI type 7, 19 bytes.
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

Handle 0x000E, DMI type 7, 19 bytes.
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

Handle 0x000F, DMI type 7, 19 bytes.
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

Handle 0x0010, DMI type 7, 19 bytes.
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

Handle 0x0011, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0012, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SECONDARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0013, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x0014, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0015, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0016, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LPT1
	Internal Connector Type: DB-25 female
	External Reference Designator:  
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x0017, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0018, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0019, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Other
	Port Type: USB

Handle 0x001A, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001B, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001C, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001D, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001E, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI4
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001F, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI5
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0020, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI6
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0021, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x0022, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 16 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0023, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x0022
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: Unknown
	Type Detail: None

Handle 0x0024, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x0022
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

Handle 0x0025, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x0022
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: Unknown
	Type Detail: None

Handle 0x0026, DMI type 17, 21 bytes.
Memory Device
	Array Handle: 0x0022
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: Unknown
	Type Detail: None

Handle 0x0027, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0022
	Partition Width: 0

Handle 0x0028, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0023
	Memory Array Mapped Address Handle: 0x0027
	Partition Row Position: 1

Handle 0x0029, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0024
	Memory Array Mapped Address Handle: 0x0027
	Partition Row Position: 1

Handle 0x002A, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0025
	Memory Array Mapped Address Handle: 0x0027
	Partition Row Position: 1

Handle 0x002B, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0026
	Memory Array Mapped Address Handle: 0x0027
	Partition Row Position: 1

Handle 0x002C, DMI type 32, 11 bytes.
System Boot Information
	Status: No errors detected

Handle 0x002D, DMI type 127, 4 bytes.
End Of Table


--------------000403010903040805090305
Content-Type: text/plain;
 name="wakeup.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wakeup.txt"

Device	S-state	  Status   Sysfs node
HUB0	  S5	 enabled  pci:0000:00:04.0
XVR0	  S5	 enabled  pci:0000:00:09.0
XVR1	  S5	 enabled  pci:0000:00:0b.0
XVR2	  S5	 enabled  pci:0000:00:0c.0
UAR1	  S5	 enabled  pnp:00:09
USB0	  S3	 enabled  pci:0000:00:02.0
USB2	  S3	 enabled  pci:0000:00:02.1
AZAD	  S5	 enabled  pci:0000:00:05.0
MMAC	  S5	 enabled  pci:0000:00:07.0

--------------000403010903040805090305--
