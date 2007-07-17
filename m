From: Dario Castellarin <dacstp@tiscali.it>
Subject: Dell Inspiron 1501 - dmidecode
Date: Tue, 17 Jul 2007 14:05:23 +0200
Message-ID: <469CB083.10101@tiscali.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000204070209020201010505"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from joe.tiscali.it ([213.205.33.54]:40833 "EHLO joe.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbXGQML0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jul 2007 08:11:26 -0400
Received: from localhost.localdomain (84.223.87.232) by joe.tiscali.it (7.2.079)
        id 465A9B16007A1DC3 for linux-acpi@vger.kernel.org; Tue, 17 Jul 2007 14:05:27 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000204070209020201010505
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
 while testing kernel 2.6.22.1-20.fc7 on Fedora 7 x86_64on my Dell 
Inspiron 1501 with the latest available BIOS version 2.4.1, I jumped 
into this:

ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org

Adding acpi_osi=!Linux to the kenrel command line didn't change 
anything, so here I send the output of dmesg and dmidecode, I'm 
available for any further request or testing.

Dario

--------------000204070209020201010505
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.22.1-20.fc7 (kojibuilder@xenbuilder2.fedora.redhat.com) (gcc version 4.1.2 20070502 (Red Hat 4.1.2-12)) #1 SMP Thu Jul 12 19:40:48 EDT 2007
Command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037e70000 (usable)
 BIOS-e820: 0000000037e70000 - 0000000037e80000 (ACPI data)
 BIOS-e820: 0000000037e80000 - 0000000037f00000 (ACPI NVS)
 BIOS-e820: 0000000037f00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 157) 0 entries of 3200 used
Entering add_active_range(0, 256, 228976) 1 entries of 3200 used
end_pfn_map = 1048576
DMI present.
ACPI: RSDP 000F8500, 0014 (r0 PTLTD )
ACPI: RSDT 37E7956A, 0040 (r1 DELL    M08      6040000  LTP        0)
ACPI: FACP 37E7FB9A, 0074 (r1 ATI    Bowfin    6040000 ATI     F4240)
ACPI: DSDT 37E795AA, 65F0 (r1    ATI    SB600  6040000 MSFT  3000000)
ACPI: FACS 37E90FC0, 0040
ACPI: TCPA 37E7FC0E, 0032 (r2 AMD              6040000 PTEC        0)
ACPI: SSDT 37E7FC40, 0182 (r1 PTLTD  POWERNOW  6040000  LTP        1)
ACPI: APIC 37E7FDC2, 0054 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: MCFG 37E7FE16, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ACPI: HPET 37E7FE52, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
ACPI: SLIC 37E7FE8A, 0176 (r1 DELL    M08      6040000  LTP        0)
Scanning NUMA topology in Northbridge 24
No NUMA configuration found
Faking a node at 0000000000000000-0000000037e70000
Entering add_active_range(0, 0, 157) 0 entries of 3200 used
Entering add_active_range(0, 256, 228976) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-0000000037e70000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      157
    0:      256 ->   228976
On node 0 totalpages: 228877
  DMA zone: 56 pages used for memmap
  DMA zone: 1302 pages reserved
  DMA zone: 2639 pages, LIFO batch:0
  DMA32 zone: 3074 pages used for memmap
  DMA32 zone: 221806 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x43538301 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009d000 - 000000000009e000
swsusp: Registered nosave memory region: 000000000009e000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000ce000
swsusp: Registered nosave memory region: 00000000000ce000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 40968 bytes of per cpu data
Built 1 zonelists.  Total pages: 224445
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 1596.008 MHz processor.
Console: colour VGA+ 80x25
Checking aperture...
CPU 0: aperture @ 5b88000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 893752k/915904k available (2366k kernel code, 21756k reserved, 1401k data, 312k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 3194.24 BogoMIPS (lpj=1597124)
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
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 12468826
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3191.96 BogoMIPS (lpj=1595981)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Turion(tm) 64 X2 Mobile Technology TL-52 stepping 02
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
PCI: Using MMCONFIG at e0000000 - e09fffff
PCI: No mmconfig possible on device 00:18
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB5_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 7) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:05.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:05.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 32-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: 00:01: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:08: ioport range 0x1080-0x1080 has been reserved
pnp: 00:08: ioport range 0x220-0x22f has been reserved
pnp: 00:09: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
pnp: 00:09: iomem range 0xc0004800-0xc0004bff has been reserved
pnp: 00:09: iomem range 0xfed00000-0xfed003ff has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: c0100000-c01fffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: c0200000-c02fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:14.4
  IO window: disabled.
  MEM window: c0300000-c03fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
NET: Registered protocol family 2
Time: hpet clocksource has been installed.
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3754k freed
audit: initializing netlink socket (disabled)
audit(1184672762.632:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 1D871FA41536D38E
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. MSI deactivated.
Boot video device is 0000:01:05.0
PCI: Setting latency timer of device 0000:00:05.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie02]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (61 C)
hpet_resources: 0xfed00000 is busy
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-52 processors (version 2.00.00)
powernow-k8:    0 : fid 0x8 (1600 MHz), vid 0x13
powernow-k8:    1 : fid 0x0 (800 MHz), vid 0x1e
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 312k freed
Write protecting the kernel read-only data: 1060k
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xc0005000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xc0006000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.2: irq 18, io mem 0xc0007000
Synaptics Touchpad, model: 1, fw: 6.3, id: 0x180b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.3: irq 17, io mem 0xc0008000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.4: irq 18, io mem 0xc0009000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xc0004400
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 10 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
ahci 0000:00:12.0: version 2.2
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq ilck led clo pmp pio 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc200001f8100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata2: SATA max UDMA/133 cmd 0xffffc200001f8180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata3: SATA max UDMA/133 cmd 0xffffc200001f8200 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata4: SATA max UDMA/133 cmd 0xffffc200001f8280 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 22
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Hitachi HTS541680J9SA00, SB2OC74P, max UDMA/100
ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54168 SB2O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:14.1 to 64
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x0000000000018420 irq 14
ata6: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x0000000000018428 irq 15
ata5.00: ATAPI: TSSTcorp DVD+/-RW TS-L632D, DE04, max UDMA/33
ata5.00: configured for UDMA/33
scsi 4:0:0:0: CD-ROM            TSSTcorp DVD+-RW TS-L632D DE04 PQ: 0 ANSI: 5
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1184672773.196:2): selinux=0 auid=4294967295
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 4:0:0:0: Attached scsi generic sg1 type 5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0
b44.c:v1.01 (Jun 16, 2006)
ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 21 (level, low) -> IRQ 21
eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:c5:c1:ab:b8
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:08:01.0 [1180:0822] (rev 19)
ACPI: PCI Interrupt 0000:08:01.0[B] -> GSI 20 (level, low) -> IRQ 20
mmc0: SDHCI at 0xc0302800 irq 20 DMA
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
loop: module loaded
floppy0: no floppy controllers found
lp: driver loaded but no devices found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
No dock devices found.
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input5
ACPI: Sleep Button (CM) [SLPB]
input: Lid Switch as /class/input/input6
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1802232k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:1802232k
ndiswrapper version 1.47 loaded (smp=yes)
ndiswrapper (link_pe_images:576): fixing KI_USER_SHARED_DATA address in the driver
ndiswrapper: driver bcmwl5 (Broadcom,10/12/2006, 4.100.15.5) loaded
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
ndiswrapper: using IRQ 18
eth1: ethernet device 00:16:cf:c9:da:2a using NDIS driver: bcmwl5, version: 0x4640f05, NDIS version: 0x501, vendor: 'NDIS Network Adapter', 14E4:4312.5.conf
eth1: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES/CCMP with WPA, WPA2, WPA2PSK
usbcore: registered new interface driver ndiswrapper
audit(1184672813.776:3): audit_pid=2209 old=0 by auid=4294967295
i2c /dev entries driver
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_UP): eth0: link is not ready
APIC error on CPU1: 00(40)
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)

--------------000204070209020201010505
Content-Type: text/plain;
 name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode.txt"

# dmidecode 2.7
SMBIOS 2.4 present.
37 structures occupying 1321 bytes.
Table at 0x000F0470.

Handle 0xDA00, DMI type 218, 131 bytes.
OEM-specific Type
	Header and Data:
		DA 83 00 DA B0 00 92 1B 07 02 00 7D 00 00 00 00
		00 80 01 16 00 01 00 7F 01 16 00 00 00 75 01 75
		01 01 00 76 01 76 01 01 00 2E 00 25 00 00 00 6E
		00 25 00 01 00 2D 00 25 00 02 00 8A 01 48 00 01
		00 89 01 48 00 00 00 9B 00 23 00 01 00 9C 00 23
		00 00 00 14 01 46 00 00 00 15 01 46 00 01 00 16
		01 46 00 02 00 94 01 47 00 01 00 93 01 47 00 00
		00 EA 00 67 00 01 00 EB 00 67 00 00 00 FF FF 00
		00 00 00

Handle 0x0001, DMI type 0, 24 bytes.
BIOS Information
	Vendor: Dell Inc.
	Version: 2.4.1    
	Release Date: 05/30/2006
	Address: 0xE58B0
	Runtime Size: 108368 bytes
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
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
		LS-120 boot is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Targeted content distribution is supported

Handle 0x0002, DMI type 1, 27 bytes.
System Information
	Manufacturer: Dell Inc.
	Product Name: Inspiron 1501 
	Version: Not Specified                   
	Serial Number: 5NYFM2J
	UUID: 44454C4C-4E00-1059-8046-B5C04F4D324A
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0003, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: Dell Inc.
	Product Name: 0UW744??????  
	Version:                        
	Serial Number: .5NYFM2J.CN486436AK1716.

Handle 0x0004, DMI type 3, 17 bytes.
Chassis Information
	Manufacturer: Dell Inc.
	Type: Portable
	Lock: Not Present
	Version: Not Specified           
	Serial Number: 5NYFM2J
	Asset Tag:                         
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0005, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: Socket M2/S1G1
	Type: Central Processor
	Family: Opteron
	Manufacturer: AMD
	ID: 82 0F 04 00 FF FB 8B 17
	Signature: Extended Family 0, Model 8, Stepping 2
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
	Version: Engineering Sample
	Voltage: 1.4 V
	External Clock: 200 MHz
	Max Speed: 4000 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: Not Provided
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0006, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J28
	Internal Connector Type: None
	External Reference Designator: Video
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x0008, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J33
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0009, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J33
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J31
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J32
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J32
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J31
	Internal Connector Type: None
	External Reference Designator: USB 4
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Microphone In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x000F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J30
	Internal Connector Type: None
	External Reference Designator: Speaker Out
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0011, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0012, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0013, DMI type 10, 6 bytes.
On Board Device Information
	Type: Video
	Status: Disabled
	Description: ATI RS485M

Handle 0x0014, DMI type 10, 6 bytes.
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: Sigmatel

Handle 0x0015, DMI type 11, 5 bytes.
OEM Strings
	String 1: Dell System
	String 2: 5
	String 3: 13

Handle 0x0016, DMI type 12, 5 bytes.
System Configuration Options
	Option 1: J13 1-2 Normal Operation, 2-3 Clear CMOS

Handle 0x0017, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x0018, DMI type 15, 29 bytes.
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0019, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x001A, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM_A
	Bank Locator: <BAD INDEX>
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001B, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: 128 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 2
	Locator: DIMM_B
	Bank Locator: <BAD INDEX>
	Type: DRAM
	Type Detail: Synchronous
	Speed: Unknown
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001C, DMI type 18, 23 bytes.
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x001D, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0019
	Partition Width: 0

Handle 0x001E, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001A
	Memory Array Mapped Address Handle: 0x001D
	Partition Row Position: 2
	Interleave Position: 1
	Interleaved Data Depth: 6

Handle 0x001F, DMI type 22, 26 bytes.
Portable Battery
	Location: System Battery Bay
	Manufacturer: SIMPLO DELLRD8506   
	Name: SIMPLO DELLRD8506   
	Chemistry: Lithium Ion
	Design Capacity: 78000 mWh
	Design Voltage: 11100 mV
	SBDS Version: Bat123
	Maximum Error: Unknown
	SBDS Serial Number: 0003
	SBDS Manufacture Date: 1980-00-00
	OEM-specific Information: 0x00000000

Handle 0x0020, DMI type 32, 20 bytes.
System Boot Information
	Status: <OUT OF SPEC>

Handle 0xB100, DMI type 177, 12 bytes.
OEM-specific Type
	Header and Data:
		B1 0C 00 B1 02 00 00 00 00 00 00 00

Handle 0xD000, DMI type 208, 10 bytes.
OEM-specific Type
	Header and Data:
		D0 0A 00 D0 01 05 FE 00 F5 01

Handle 0xD400, DMI type 212, 17 bytes.
OEM-specific Type
	Header and Data:
		D4 11 00 D4 70 00 71 00 00 10 2D 2E FF FF 00 00
		00

Handle 0x0024, DMI type 127, 4 bytes.
End Of Table


--------------000204070209020201010505--
