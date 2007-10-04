From: Michael Sicher <Michael.Sicher@stud.unibas.ch>
Subject: dmesg
Date: Thu, 04 Oct 2007 03:53:20 +0200
Message-ID: <47044790.1010306@stud.unibas.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020407030201080903020600"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail20.bluewin.ch ([195.186.19.65]:49732 "EHLO
	mail20.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXJDB71 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Oct 2007 21:59:27 -0400
Received: from localhost.localdomain (83.77.208.90) by mail20.bluewin.ch (Bluewin 7.3.121)
        id 46F382AC002F6C3D for linux-acpi@vger.kernel.org; Thu, 4 Oct 2007 01:53:27 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020407030201080903020600
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello
This is the content after a dmesg. (Attachment) Somewhere I were pleased 
to send you this...I hope you will help me eliminate those errors...

michael.sicher@stud.unibas.ch
Fasanenstrasse 7
4153 REINACH BL
CH


--------------020407030201080903020600
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[michi@localhost ~]$ sudo dmesg
Password:
Linux version 2.6.22.9-91.fc7 (kojibuilder@xenbuilder2.fedora.redhat.com) (gcc v
ersion 4.1.2 20070502 (Red Hat 4.1.2-12)) #1 SMP Thu Sep 27 20:47:39 EDT 2007
Command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe8cc00 (usable)
 BIOS-e820: 000000007fe8cc00 - 000000007fe8ec00 (ACPI NVS)
 BIOS-e820: 000000007fe8ec00 - 000000007fe90c00 (ACPI data)
 BIOS-e820: 000000007fe90c00 - 0000000080000000 (reserved)
 BIOS-e820: 00000000d0000000 - 00000000d4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 523916) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000FEB00, 0024 (r2 DELL  )
ACPI: XSDT 000FD25F, 005C (r1 DELL    DXP051         7 ASL        61)
ACPI: FACP 000FD357, 00F4 (r3 DELL    DXP051         7 ASL        61)
ACPI: DSDT FFFC7B7D, 32B9 (r1   DELL    dt_ex     1000 INTL 20050309)
ACPI: FACS 7FE8CC00, 0040
ACPI: SSDT FFFCAF57, 00AC (r1   DELL    st_ex     1000 INTL 20050309)
ACPI: APIC 000FD44B, 0072 (r1 DELL    DXP051         7 ASL        61)
ACPI: BOOT 000FD4BD, 0028 (r1 DELL    DXP051         7 ASL        61)
ACPI: ASF! 000FD4E5, 0067 (r16 DELL    DXP051         7 ASL        61)
ACPI: MCFG 000FD54C, 003E (r1 DELL    DXP051         7 ASL        61)
ACPI: HPET 000FD58A, 0038 (r1 DELL    DXP051         7 ASL        61)
No NUMA configuration found
Faking a node at 0000000000000000-000000007fe8c000
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 523916) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000007fe8c000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:      256 ->   523916
On node 0 totalpages: 523820
  DMA zone: 56 pages used for memmap
  DMA zone: 1300 pages reserved
  DMA zone: 2644 pages, LIFO batch:0
  DMA32 zone: 7106 pages used for memmap
  DMA32 zone: 512714 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:50000000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 40968 bytes of per cpu data
Built 1 zonelists.  Total pages: 515358
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 3391.586 MHz processor.
Console: colour VGA+ 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 2057260k/2095664k available (2362k kernel code, 38020k reserved, 1400k d
ata, 312k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
Calibrating delay using timer specific routine.. 6787.61 BogoMIPS (lpj=3393808)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12468987
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6783.18 BogoMIPS (lpj=3391590)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) D CPU 3.40GHz stepping 04
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
sizeof(vma)=176 bytes
sizeof(page)=56 bytes
sizeof(inode)=560 bytes
sizeof(dentry)=208 bytes
sizeof(ext3inode)=760 bytes
sizeof(buffer_head)=104 bytes
sizeof(skbuff)=232 bytes
sizeof(task_struct)=2048 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub with MMC
ONFIG support.
PCI: Using MMCONFIG at d0000000 - d3ffffff
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 8 devices
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
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
pnp: 00:01: ioport range 0x800-0x85f has been reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
pnp: 00:01: ioport range 0x860-0x8ff has been reserved
pnp: 00:06: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:06: iomem range 0x100000-0xffffff could not be reserved
pnp: 00:06: iomem range 0x1000000-0x7fe8cbff could not be reserved
pnp: 00:06: iomem range 0xf0000-0xfffff could not be reserved
pnp: 00:07: ioport range 0x100-0x1fe could not be reserved
pnp: 00:07: ioport range 0x200-0x277 has been reserved
pnp: 00:07: ioport range 0x280-0x2e7 has been reserved
pnp: 00:07: ioport range 0x2e8-0x2ef has been reserved
pnp: 00:07: ioport range 0x2f0-0x2f7 has been reserved
pnp: 00:07: ioport range 0x2f8-0x2ff has been reserved
pnp: 00:07: ioport range 0x300-0x377 could not be reserved
pnp: 00:07: ioport range 0x380-0x3bb has been reserved
pnp: 00:07: iomem range 0xd0000000-0xd3ffffff could not be reserved
pnp: 00:07: iomem range 0xfeda0000-0xfedacfff has been reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fc000000-feafffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: fbf00000-fbffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: c000-cfff
  MEM window: fb800000-fbefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: f4000000-fb7fffff
  PREFETCH window: f0000000-f3ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 6291456 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3777k freed
Simple Boot Flag at 0x7a set to 0x1
audit: initializing netlink socket (disabled)
audit(1191467297.460:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key F49647332066F9
- User ID: Red Hat, Inc. (Kernel Module GPG key)
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
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
Allocate Port Service[0000:00:1c.5:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not pres
ent [20070126]
ACPI Exception (processor_core-0783): AE_NOT_FOUND, Processor Device is not pres
ent [20070126]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 312k freed
Write protecting the kernel read-only data: 1060k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000ff80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 22, io base 0x0000ff60
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ff40
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 23, io base 0x0000ff20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x00
0000000001ffa0 irq 14
ata2: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x00
0000000001ffa8 irq 15
usb 1-1: device not accepting address 2, error -71
ata1.00: ATAPI: HL-DT-STDVD+-RW GSA-H21N, A105, max UDMA/33
ata1.00: configured for UDMA/33
ata2: port disabled. ignoring.
scsi 0:0:0:0: CD-ROM            HL-DT-ST DVD+-RW GSA-H21N A105 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000000000001fe00 ctl 0x000000000001fe12 bmdma 0x00
0000000001fea0 irq 20
ata4: SATA max UDMA/133 cmd 0x000000000001fe20 ctl 0x000000000001fe32 bmdma 0x00
0000000001fea8 irq 20
ata3.00: ATA-7: WDC WD2500JS-75NCB3, 10.02E04, max UDMA/133
ata3.00: 488281250 sectors, multi 8: LBA48 NCQ (depth 0/32)
ata3.01: ATA-7: WDC WD2500JS-75NCB3, 10.02E04, max UDMA/133
ata3.01: 488281250 sectors, multi 8: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata3.01: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD2500JS-75N 10.0 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 488281250 512-byte hardware sectors (250000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 2:0:0:0: [sda] 488281250 512-byte hardware sectors (250000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sda: sda1 sda2 sda3
sd 2:0:0:0: [sda] Attached SCSI disk
scsi 2:0:1:0: Direct-Access     ATA      WDC WD2500JS-75N 10.0 PQ: 0 ANSI: 5
sd 2:0:1:0: [sdb] 488281250 512-byte hardware sectors (250000 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
sd 2:0:1:0: [sdb] 488281250 512-byte hardware sectors (250000 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO
 or FUA
 sdb: sdb1 sdb2 sdb3
sd 2:0:1:0: [sdb] Attached SCSI disk
usb 5-2: new high speed USB device using ehci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
hub 5-2:1.0: USB hub found
hub 5-2:1.0: 4 ports detected
usb 5-3: new high speed USB device using ehci_hcd and address 4
usb 5-3: configuration #1 chosen from 1 choice
usb 5-5: new high speed USB device using ehci_hcd and address 6
usb 5-5: configuration #1 chosen from 1 choice
hub 5-5:1.0: USB hub found
hub 5-5:1.0: 4 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 4
usb 1-1: configuration #1 chosen from 1 choice
input: Dell Dell USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:1d.0-1
usb 5-2.1: new high speed USB device using ehci_hcd and address 8
usb 5-2.1: configuration #1 chosen from 1 choice
usb 5-2.2: new high speed USB device using ehci_hcd and address 9
Initializing USB Mass Storage driver...
usb 5-2.2: configuration #1 chosen from 1 choice
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 8
usb-storage: waiting for device to settle before scanning
scsi6 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 9
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
usb 5-5.1: new low speed USB device using ehci_hcd and address 10
usb 5-5.1: configuration #1 chosen from 1 choice
input: Microsoft Microsoft USB Wireless Mouse as /class/input/input2
input: USB HID v1.11 Mouse [Microsoft Microsoft USB Wireless Mouse] on usb-0000:
00:1d.7-5.1
usb 5-5.3: new high speed USB device using ehci_hcd and address 11
usb 5-5.3: configuration #1 chosen from 1 choice
hub 5-5.3:1.0: USB hub found
hub 5-5.3:1.0: 4 ports detected
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb-storage: device scan complete
scsi 6:0:0:0: Direct-Access     HP       Photosmart 2570  1.00 PQ: 0 ANSI: 2
usb-storage: device scan complete
scsi 5:0:0:0: Direct-Access     HDS72251 6VLAT20               PQ: 0 ANSI: 0
sd 6:0:0:0: [sdc] Attached SCSI removable disk
sd 5:0:0:0: [sdd] 321672960 512-byte hardware sectors (164697 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 33 00 00 00
sd 5:0:0:0: [sdd] Assuming drive cache: write through
sd 5:0:0:0: [sdd] 321672960 512-byte hardware sectors (164697 MB)
usb-storage: device scan complete
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 33 00 00 00
sd 5:0:0:0: [sdd] Assuming drive cache: write through
 sdd:<5>scsi 4:0:0:0: Direct-Access     TEAC     USB   HS-CF Card 4.00 PQ: 0 ANS
I: 0
 sdd1
sd 5:0:0:0: [sdd] Attached SCSI disk
scsi 4:0:0:1: Direct-Access     TEAC     USB   HS-xD/SM   4.00 PQ: 0 ANSI: 0
scsi 4:0:0:2: Direct-Access     TEAC     USB   HS-MS Card 4.00 PQ: 0 ANSI: 0
scsi 4:0:0:3: Direct-Access     TEAC     USB   HS-SD Card 4.00 PQ: 0 ANSI: 0
sd 4:0:0:0: [sde] Attached SCSI removable disk
sd 4:0:0:1: [sdf] Attached SCSI removable disk
sd 4:0:0:2: [sdg] Attached SCSI removable disk
sd 4:0:0:3: [sdh] Attached SCSI removable disk
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1191467316.487:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1854 types, 84 bools, 1 sens, 1024 cats
security:  61 classes, 70584 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
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
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1191467316.811:3): policy loaded auid=4294967295
scsi 0:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:1:0: Attached scsi generic sg2 type 0
sd 6:0:0:0: Attached scsi generic sg3 type 0
sd 5:0:0:0: Attached scsi generic sg4 type 0
sd 4:0:0:0: Attached scsi generic sg5 type 0
sd 4:0:0:1: Attached scsi generic sg6 type 0
sd 4:0:0:2: Attached scsi generic sg7 type 0
sd 4:0:0:3: Attached scsi generic sg8 type 0
sr0: scsi3-mmc drive: 94x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 9 if 1 alt 0 pr
oto 2 vid 0x03F0 pid 0x4E11
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Floppy drive(s): fd0 is 1.44M
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
Linux video capture interface: v2.00
ivtv:  ==================== START INIT IVTV ====================
ivtv:  version 1.0.0 (2.6.22.9-91.fc7 SMP mod_unload ) loading
ivtv0: Autodetected Hauppauge card (cx23416 based)
ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 17 (level, low) -> IRQ 17
ctossrv: module license 'Creative Proprietary License' taints kernel.
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
emupia: Unknown symbol InterlockedIncrement
emupia: Unknown symbol heap_alloc
emupia: Unknown symbol stack_free_page
emupia: Unknown symbol stack_alloc
emupia: Unknown symbol get_ossrv
emupia: Unknown symbol unload_all_plugins
emupia: Unknown symbol stack_alloc_page
emupia: Unknown symbol ioctl_dispatch
emupia: Unknown symbol heap_free
emupia: Unknown symbol InterlockedDecrement
emupia: Unknown symbol stack_free
ctsfman: Unknown symbol heap_alloc
ctsfman: Unknown symbol get_ossrv
ctsfman: Unknown symbol ioctl_dispatch
ctsfman: Unknown symbol heap_free
ct20xut: Unknown symbol InterlockedIncrement
ct20xut: Unknown symbol heap_alloc
ct20xut: Unknown symbol unregister_plugin
ct20xut: Unknown symbol heap_free
ct20xut: Unknown symbol register_plugin
ct20xut: Unknown symbol InterlockedDecrement
ivtv0: unable to open firmware v4l-cx2341x-enc.fw (must be 376836 bytes)
ivtv0: did you put the firmware in the hotplug firmware directory?
ivtv0: Retry loading firmware
ctexfifx: Unknown symbol InterlockedDecrement
ctexfifx: Unknown symbol register_plugin
ctexfifx: Unknown symbol unregister_plugin
ctexfifx: Unknown symbol heap_alloc
ctexfifx: Unknown symbol InterlockedIncrement
ctexfifx: Unknown symbol heap_free
cthwiut: Unknown symbol InterlockedIncrement
cthwiut: Unknown symbol heap_alloc
cthwiut: Unknown symbol unregister_plugin
cthwiut: Unknown symbol heap_free
cthwiut: Unknown symbol register_plugin
cthwiut: Unknown symbol InterlockedDecrement
haxfi: Unknown symbol InterlockedDecrement
haxfi: Unknown symbol get_ossrv
haxfi: Unknown symbol heap_alloc
haxfi: Unknown symbol InterlockedIncrement
haxfi: Unknown symbol heap_free
ctalsa: Unknown symbol bytes_to_order
ctalsa: Unknown symbol get_ossrv
ctalsa: Unknown symbol heap_alloc
ctalsa: Unknown symbol malloc_sizes
ctalsa: Unknown symbol ioctl_dispatch
ctalsa: Unknown symbol heap_free
ivtv0: unable to open firmware v4l-cx2341x-enc.fw (must be 376836 bytes)
ivtv0: did you put the firmware in the hotplug firmware directory?
ivtv0: Error initializing firmware
ivtv0: Error -19 on initialization
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:04:00.0 to 64
ivtv:  ====================  END INIT IVTV  ====================
e1000: 0000:04:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:72:2c:ba:
25
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  100.14.19  Wed Sep 12 14:08:38 P
DT 2007
usbcore: registered new interface driver snd-usb-audio
emupia: Unknown symbol InterlockedIncrement
emupia: Unknown symbol heap_alloc
emupia: Unknown symbol stack_free_page
emupia: Unknown symbol stack_alloc
emupia: Unknown symbol get_ossrv
emupia: Unknown symbol unload_all_plugins
emupia: Unknown symbol stack_alloc_page
emupia: Unknown symbol ioctl_dispatch
emupia: Unknown symbol heap_free
emupia: Unknown symbol InterlockedDecrement
emupia: Unknown symbol stack_free
ctsfman: Unknown symbol heap_alloc
ctsfman: Unknown symbol get_ossrv
ctsfman: Unknown symbol ioctl_dispatch
ctsfman: Unknown symbol heap_free
ct20xut: Unknown symbol InterlockedIncrement
ct20xut: Unknown symbol heap_alloc
ct20xut: Unknown symbol unregister_plugin
ct20xut: Unknown symbol heap_free
ct20xut: Unknown symbol register_plugin
ct20xut: Unknown symbol InterlockedDecrement
ctexfifx: Unknown symbol InterlockedDecrement
ctexfifx: Unknown symbol register_plugin
ctexfifx: Unknown symbol unregister_plugin
ctexfifx: Unknown symbol heap_alloc
ctexfifx: Unknown symbol InterlockedIncrement
ctexfifx: Unknown symbol heap_free
cthwiut: Unknown symbol InterlockedIncrement
cthwiut: Unknown symbol heap_alloc
cthwiut: Unknown symbol unregister_plugin
cthwiut: Unknown symbol heap_free
cthwiut: Unknown symbol register_plugin
cthwiut: Unknown symbol InterlockedDecrement
haxfi: Unknown symbol InterlockedDecrement
haxfi: Unknown symbol get_ossrv
haxfi: Unknown symbol heap_alloc
haxfi: Unknown symbol InterlockedIncrement
haxfi: Unknown symbol heap_free
ctalsa: Unknown symbol bytes_to_order
ctalsa: Unknown symbol get_ossrv
ctalsa: Unknown symbol heap_alloc
ctalsa: Unknown symbol malloc_sizes
ctalsa: Unknown symbol ioctl_dispatch
ctalsa: Unknown symbol heap_free
floppy0: no floppy controllers found
Floppy drive(s): fd0 is 1.44M
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
floppy0: no floppy controllers found
No dock devices found.
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [VBTN]
device-mapper: multipath: version 1.0.5 loaded
usb 5-2.2: reset high speed USB device using ehci_hcd and address 9
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sdb1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:
2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control:
RX
e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
audit(1191460174.540:4): audit_pid=2119 old=0 by auid=4294967295 subj=system_u:s
ystem_r:auditd_t:s0
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
eth0: no IPv6 routers present
ppdev: user-space parallel port driver
ppdev0: claim the port first
ppdev1: claim the port first
ppdev2: claim the port first
ppdev3: claim the port first
lp: driver loaded but no devices found
ppdev0: claim the port first
ppdev1: claim the port first
ppdev2: claim the port first
ppdev3: claim the port first
[michi@localhost ~]$


--------------020407030201080903020600--
