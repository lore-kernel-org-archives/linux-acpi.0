From: Hrvoje =?iso-8859-2?q?Habjani=E6?= <hrvoje.habjanic@zg.t-com.hr>
Subject: "acpi_osi" testing
Date: Thu, 26 Jul 2007 10:03:49 +0200
Message-ID: <200707261003.49162.hrvoje.habjanic@zg.t-com.hr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="Boundary-00=_lVFqGG5XT6IN7ed"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ls405.t-com.hr ([195.29.150.135]:59915 "EHLO ls405.t-com.hr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756757AbXGZIDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 04:03:52 -0400
Received: from ls248.t-com.hr (ls248.t-com.hr [195.29.150.237])
	by ls405.t-com.hr (Postfix) with ESMTP id C1100144250
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 10:03:49 +0200 (CEST)
Received: from ls248.t-com.hr (localhost.localdomain [127.0.0.1])
	by ls248.t-com.hr (Qmlai) with ESMTP id AB2D5D5004A
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 10:03:49 +0200 (CEST)
Received: from ls248.t-com.hr (localhost.localdomain [127.0.0.1])
	by ls248.t-com.hr (Qmlai) with ESMTP id 9AA32D50047
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 10:03:49 +0200 (CEST)
Received: from habi.t-com.hr (habi.t-com.hr [195.29.148.138])by
	ls248.t-com.hr (Qmali) with ESMTP id 70C9C5E0120for
	<linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 10:03:49 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Boundary-00=_lVFqGG5XT6IN7ed
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi!

I got:
"
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
"

so here it is. dmidecode dump, along with dmesg's before  and after. Under 
both cases computer seems to be working normaly. I'm running Fedora 7, 64bit 
version.

H.


--Boundary-00=_lVFqGG5XT6IN7ed
Content-Type: text/plain;
  charset="iso-8859-2";
  name="dmesg.2.6.22.1-27.fc7"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.2.6.22.1-27.fc7"

Linux version 2.6.22.1-27.fc7 (kojibuilder@xenbuilder1.fedora.redhat.com) (gcc version 4.1.2 20070502 (Red Hat 4.1.2-12)) #1 SMP Tue Jul 17 17:19:58 EDT 2007
Command line: ro root=LABEL=/ rhgb
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe8ac00 (usable)
 BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI NVS)
 BIOS-e820: 000000003fe8cc00 - 000000003fe8ec00 (ACPI data)
 BIOS-e820: 000000003fe8ec00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 261770) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000FEC30, 0014 (r0 DELL  )
ACPI: RSDT 000FCB3B, 0040 (r1 DELL    WS 670         7 ASL        61)
ACPI: FACP 000FCB9F, 0074 (r1 DELL    WS 670         7 ASL        61)
ACPI: DSDT FFFD932B, 3116 (r1   DELL    dt_ex     1000 MSFT  100000D)
ACPI: FACS 3FE8AC00, 0040
ACPI: SSDT FFFDC57E, 00BA (r1   DELL    st_ex     1000 MSFT  100000D)
ACPI: APIC 000FCC13, 00AA (r1 DELL    WS 670         7 ASL        61)
ACPI: BOOT 000FCCBD, 0028 (r1 DELL    WS 670         7 ASL        61)
ACPI: ASF! 000FCCE5, 0067 (r16 DELL    WS 670         7 ASL        61)
ACPI: MCFG 000FCD4C, 003E (r1 DELL    WS 670         7 ASL        61)
ACPI: HPET 000FCD8A, 0038 (r1 DELL    WS 670         7 ASL        61)
No NUMA configuration found
Faking a node at 0000000000000000-000000003fe8a000
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 261770) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003fe8a000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:      256 ->   261770
On node 0 totalpages: 261674
  DMA zone: 56 pages used for memmap
  DMA zone: 1301 pages reserved
  DMA zone: 2643 pages, LIFO batch:0
  DMA32 zone: 3522 pages used for memmap
  DMA32 zone: 254152 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, address 0xfec80800, GSI 48-71
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
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 8 CPUs, 6 hotplug CPUs
PERCPU: Allocating 40968 bytes of per cpu data
Built 1 zonelists.  Total pages: 256795
Kernel command line: ro root=LABEL=/ rhgb
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 3191.994 MHz processor.
Console: colour VGA+ 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1023476k/1047080k available (2366k kernel code, 23220k reserved, 1401k data, 312k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=8, Nodes=1
Calibrating delay using timer specific routine.. 6387.42 BogoMIPS (lpj=3193713)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12468654
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6383.97 BogoMIPS (lpj=3191985)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
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
PCI: Using MMCONFIG at e0000000 - efffffff
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Firmware left 0000:04:04.0 e100 interrupts enabled, disabling
PCI: Firmware left 0000:04:05.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
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
ACPI: RTC can wake from S4
pnp: 00:01: ioport range 0x800-0x85f has been reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
Time: tsc clocksource has been installed.
pnp: 00:01: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:01:00.0
  IO window: d000-dfff
  MEM window: dfd00000-dfefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:0d.0
  IO window: b000-bfff
  MEM window: dfa00000-dfbfffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:01:00.2
  IO window: b000-cfff
  MEM window: dfa00000-dfcfffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:00:02.0
  IO window: b000-dfff
  MEM window: dfa00000-dfefffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: df900000-df9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: a000-afff
  MEM window: df700000-df8fffff
  PREFETCH window: c8100000-d7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: df600000-df6fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3158k freed
Simple Boot Flag at 0x7a set to 0x1
audit: initializing netlink socket (disabled)
audit(1185435140.080:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 88A06E0E2D36A1D0
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:06:00.0
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:02.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:03.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:04.0:pcie01 failed with error 2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
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
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 312k freed
Write protecting the kernel read-only data: 1060k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
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
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ff20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001ffa0 irq 14
ata2: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001ffa8 irq 15
ata1: port disabled. ignoring.
usb 5-6: new high speed USB device using ehci_hcd and address 2
usb 5-6: configuration #1 chosen from 1 choice
hub 5-6:1.0: USB hub found
hub 5-6:1.0: 4 ports detected
ata2.00: ATAPI: PHILIPS DVD+/-RW DVD8631, GD30, max UDMA/33
ata2.00: configured for UDMA/33
scsi 1:0:0:0: CD-ROM            PHILIPS  DVD+-RW DVD8631  GD30 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
usb 5-6.1: new low speed USB device using ehci_hcd and address 3
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000000000001fe00 ctl 0x000000000001fe12 bmdma 0x000000000001fea0 irq 18
ata4: SATA max UDMA/133 cmd 0x000000000001fe20 ctl 0x000000000001fe32 bmdma 0x000000000001fea8 irq 18
usb 5-6.1: configuration #1 chosen from 1 choice
input: Logitech Optical USB Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.7-6.1
ata3.00: ATA-7: Maxtor 6Y160M0, YAR51HW0, max UDMA/133
ata3.00: 312500000 sectors, multi 8: LBA48 
ata3.00: configured for UDMA/133
usb 5-6.2: new low speed USB device using ehci_hcd and address 4
usb 5-6.2: configuration #1 chosen from 1 choice
input: DELL DELL USB Keyboard as /class/input/input2
input: USB HID v1.10 Keyboard [DELL DELL USB Keyboard] on usb-0000:00:1d.7-6.2
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<6>input: DELL DELL USB Keyboard as /class/input/input3
input: USB HID v1.10 Device [DELL DELL USB Keyboard] on usb-0000:00:1d.7-6.2
 sda1 sda2 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 2:0:0:0: [sda] Attached SCSI disk
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 24 (level, low) -> IRQ 24
scsi4 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7901 Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
scsi 4:0:0:0: Sequential-Access HP       C5683A           C005 PQ: 0 ANSI: 2
 target4:0:0: asynchronous
 target4:0:0: Beginning Domain Validation
scsi: waiting for bus probes to complete ...
 target4:0:0: wide asynchronous
 target4:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 32)
 target4:0:0: Domain Validation skipping write tests
 target4:0:0: Ending Domain Validation
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1827 types, 80 bools, 1 sens, 1024 cats
security:  61 classes, 68491 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda5, type ext3), uses xattr
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
audit(1185435164.189:2): policy loaded auid=4294967295
scsi 1:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 4:0:0:0: Attached scsi generic sg2 type 1
st: Version 20070203, fixed bufsize 32768, s/g segs 256
st 4:0:0:0: Attached scsi tape st0
st 4:0:0:0: st0: try direct i/o: yes (alignment 512 B)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
EDAC MC: Ver: 2.0.1 Jul 17 2007
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
EDAC e752x: tolm = 40000, remapbase = ffc000, remaplimit = 0
EDAC MC0: Giving out device to e752x_edac E7525: DEV 0000:00:00.0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
intel_rng: FWH not detected
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:03:0e.0[A] -> GSI 48 (level, low) -> IRQ 48
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
e1000: 0000:03:0e.0: e1000_probe: (PCI:33MHz:64-bit) 00:11:43:2a:0f:9a
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day
iTCO_vendor_support: vendor-support=0
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
iTCO_wdt: No card detected
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 49 (level, low) -> IRQ 49
e100: eth1: e100_probe: addr 0xc8001000, irq 49, MAC addr 00:50:8B:95:9E:12
ACPI: PCI Interrupt 0000:07:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 50 (level, low) -> IRQ 50
e100: eth2: e100_probe: addr 0xc8000000, irq 50, MAC addr 00:50:8B:95:9E:13
firewire_ohci: Added fw-ohci device 0000:07:0c.0, OHCI version 1.10
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
firewire_core: created new fw device fw0 (0 config rom retries)
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 51109 usecs
intel8x0: clocking to 48000
audit(1185435170.604:4): avc:  denied  { read } for  pid=1286 comm="salsa" name="root" dev=sda5 ino=57 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185435170.604:3): avc:  denied  { read } for  pid=1277 comm="salsa" name="root" dev=sda5 ino=57 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185435170.613:5): avc:  denied  { search } for  pid=1277 comm="salsa" name="home" dev=sda5 ino=345313 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
audit(1185435170.613:6): avc:  denied  { search } for  pid=1279 comm="salsa" name="home" dev=sda5 ino=345313 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
loop: module loaded
lp0: using parport0 (interrupt-driven).
lp0: console ready
No dock devices found.
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [VBTN]
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda8, type ext3), uses xattr
SELinux: initialized (dev sda2, type ext2), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda11, type ext3), uses xattr
SELinux: initialized (dev sda10, type vfat), uses genfs_contexts
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.27.0 20060524 on minor 0
audit(1185435182.954:7): avc:  denied  { read } for  pid=1491 comm="rhgb" name="root" dev=sda5 ino=57 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185435182.954:8): avc:  denied  { search } for  pid=1491 comm="rhgb" name="/" dev=sda8 ino=2 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
audit(1185435182.986:9): avc:  denied  { search } for  pid=1491 comm="rhgb" name="root" dev=sda8 ino=3270403 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=dir
Adding 1004020k swap on /dev/sda1.  Priority:-1 extents:1 across:1004020k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (4090 buckets, 32720 max)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX
audit(1185435194.052:10): audit_pid=2035 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth0: no IPv6 routers present
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs

--Boundary-00=_lVFqGG5XT6IN7ed
Content-Type: text/plain;
  charset="iso-8859-2";
  name="dmesg.2.6.22.1-27.fc7.osi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.2.6.22.1-27.fc7.osi"

Linux version 2.6.22.1-27.fc7 (kojibuilder@xenbuilder1.fedora.redhat.com) (gcc version 4.1.2 20070502 (Red Hat 4.1.2-12)) #1 SMP Tue Jul 17 17:19:58 EDT 2007
Command line: ro root=LABEL=/ rhgb acpi_osi=!Linux
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe8ac00 (usable)
 BIOS-e820: 000000003fe8ac00 - 000000003fe8cc00 (ACPI NVS)
 BIOS-e820: 000000003fe8cc00 - 000000003fe8ec00 (ACPI data)
 BIOS-e820: 000000003fe8ec00 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 261770) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000FEC30, 0014 (r0 DELL  )
ACPI: RSDT 000FCB3B, 0040 (r1 DELL    WS 670         7 ASL        61)
ACPI: FACP 000FCB9F, 0074 (r1 DELL    WS 670         7 ASL        61)
ACPI: DSDT FFFD932B, 3116 (r1   DELL    dt_ex     1000 MSFT  100000D)
ACPI: FACS 3FE8AC00, 0040
ACPI: SSDT FFFDC57E, 00BA (r1   DELL    st_ex     1000 MSFT  100000D)
ACPI: APIC 000FCC13, 00AA (r1 DELL    WS 670         7 ASL        61)
ACPI: BOOT 000FCCBD, 0028 (r1 DELL    WS 670         7 ASL        61)
ACPI: ASF! 000FCCE5, 0067 (r16 DELL    WS 670         7 ASL        61)
ACPI: MCFG 000FCD4C, 003E (r1 DELL    WS 670         7 ASL        61)
ACPI: HPET 000FCD8A, 0038 (r1 DELL    WS 670         7 ASL        61)
No NUMA configuration found
Faking a node at 0000000000000000-000000003fe8a000
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 256, 261770) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003fe8a000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:      256 ->   261770
On node 0 totalpages: 261674
  DMA zone: 56 pages used for memmap
  DMA zone: 1301 pages reserved
  DMA zone: 2643 pages, LIFO batch:0
  DMA32 zone: 3522 pages used for memmap
  DMA32 zone: 254152 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80800] gsi_base[48])
IOAPIC[2]: apic_id 10, address 0xfec80800, GSI 48-71
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
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 8 CPUs, 6 hotplug CPUs
PERCPU: Allocating 40968 bytes of per cpu data
Built 1 zonelists.  Total pages: 256795
Kernel command line: ro root=LABEL=/ rhgb acpi_osi=!Linux
ACPI: Disabled _OSI(Linux)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 3191.997 MHz processor.
Console: colour VGA+ 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1023476k/1047080k available (2366k kernel code, 23220k reserved, 1401k data, 312k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=8, Nodes=1
Calibrating delay using timer specific routine.. 6387.39 BogoMIPS (lpj=3193698)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12468690
Detected 12.468 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6383.98 BogoMIPS (lpj=3191991)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.20GHz stepping 01
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
PCI: Using MMCONFIG at e0000000 - efffffff
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Firmware left 0000:04:04.0 e100 interrupts enabled, disabling
PCI: Firmware left 0000:04:05.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
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
ACPI: RTC can wake from S4
pnp: 00:01: ioport range 0x800-0x85f has been reserved
pnp: 00:01: ioport range 0xc00-0xc7f has been reserved
pnp: 00:01: ioport range 0x860-0x8ff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:01:00.0
  IO window: d000-dfff
  MEM window: dfd00000-dfefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:0d.0
  IO window: b000-bfff
  MEM window: dfa00000-dfbfffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:01:00.2
  IO window: b000-cfff
  MEM window: dfa00000-dfcfffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:00:02.0
  IO window: b000-dfff
  MEM window: dfa00000-dfefffff
  PREFETCH window: c8000000-c80fffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: df900000-df9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: a000-afff
  MEM window: df700000-df8fffff
  PREFETCH window: c8100000-d7ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: df600000-df6fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3158k freed
Simple Boot Flag at 0x7a set to 0x1
audit: initializing netlink socket (disabled)
audit(1185436052.076:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 88A06E0E2D36A1D0
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:06:00.0
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie01]
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie01]
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie01]
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:02.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:03.0:pcie01 failed with error 2
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
aer_init: AER service init fails - Run ACPI _OSC fails
aer: probe of 0000:00:04.0:pcie01 failed with error 2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
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
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 312k freed
Write protecting the kernel read-only data: 1060k
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ff80
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ff60
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
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ff20
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffa80800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001ffa0 irq 14
ata2: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001ffa8 irq 15
ata1: port disabled. ignoring.
usb 5-6: new high speed USB device using ehci_hcd and address 2
usb 5-6: configuration #1 chosen from 1 choice
hub 5-6:1.0: USB hub found
hub 5-6:1.0: 4 ports detected
ata2.00: ATAPI: PHILIPS DVD+/-RW DVD8631, GD30, max UDMA/33
usb 5-6.1: new low speed USB device using ehci_hcd and address 3
ata2.00: configured for UDMA/33
scsi 1:0:0:0: CD-ROM            PHILIPS  DVD+-RW DVD8631  GD30 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
usb 5-6.1: configuration #1 chosen from 1 choice
input: Logitech Optical USB Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.7-6.1
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000000000001fe00 ctl 0x000000000001fe12 bmdma 0x000000000001fea0 irq 18
ata4: SATA max UDMA/133 cmd 0x000000000001fe20 ctl 0x000000000001fe32 bmdma 0x000000000001fea8 irq 18
usb 5-6.2: new low speed USB device using ehci_hcd and address 4
ata3.00: ATA-7: Maxtor 6Y160M0, YAR51HW0, max UDMA/133
ata3.00: 312500000 sectors, multi 8: LBA48 
usb 5-6.2: configuration #1 chosen from 1 choice
ata3.00: configured for UDMA/133
input: DELL DELL USB Keyboard as /class/input/input2
input: USB HID v1.10 Keyboard [DELL DELL USB Keyboard] on usb-0000:00:1d.7-6.2
input: DELL DELL USB Keyboard as /class/input/input3
input: USB HID v1.10 Device [DELL DELL USB Keyboard] on usb-0000:00:1d.7-6.2
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6Y160M0   YAR5 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 312500000 512-byte hardware sectors (160000 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 2:0:0:0: [sda] Attached SCSI disk
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 24 (level, low) -> IRQ 24
scsi4 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7901 Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
scsi 4:0:0:0: Sequential-Access HP       C5683A           C005 PQ: 0 ANSI: 2
 target4:0:0: asynchronous
 target4:0:0: Beginning Domain Validation
scsi: waiting for bus probes to complete ...
 target4:0:0: wide asynchronous
 target4:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 32)
 target4:0:0: Domain Validation skipping write tests
 target4:0:0: Ending Domain Validation
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1827 types, 80 bools, 1 sens, 1024 cats
security:  61 classes, 68491 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda5, type ext3), uses xattr
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
audit(1185436076.321:2): policy loaded auid=4294967295
scsi 1:0:0:0: Attached scsi generic sg0 type 5
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 4:0:0:0: Attached scsi generic sg2 type 1
st: Version 20070203, fixed bufsize 32768, s/g segs 256
st 4:0:0:0: Attached scsi tape st0
st 4:0:0:0: st0: try direct i/o: yes (alignment 512 B)
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
EDAC MC: Ver: 2.0.1 Jul 17 2007
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
EDAC e752x: tolm = 40000, remapbase = ffc000, remaplimit = 0
EDAC MC0: Giving out device to e752x_edac E7525: DEV 0000:00:00.0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
intel_rng: FWH not detected
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
iTCO_wdt: No card detected
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:03:0e.0[A] -> GSI 48 (level, low) -> IRQ 48
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
e1000: 0000:03:0e.0: e1000_probe: (PCI:33MHz:64-bit) 00:11:43:2a:0f:9a
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one day
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:07:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
firewire_ohci: Added fw-ohci device 0000:07:0c.0, OHCI version 1.10
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 49 (level, low) -> IRQ 49
e100: eth1: e100_probe: addr 0xc8001000, irq 49, MAC addr 00:50:8B:95:9E:12
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 50 (level, low) -> IRQ 50
e100: eth2: e100_probe: addr 0xc8000000, irq 50, MAC addr 00:50:8B:95:9E:13
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
firewire_core: created new fw device fw0 (0 config rom retries)
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 51100 usecs
intel8x0: clocking to 48000
audit(1185436083.454:3): avc:  denied  { read } for  pid=1283 comm="salsa" name="root" dev=sda5 ino=57 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185436083.454:4): avc:  denied  { read } for  pid=1287 comm="salsa" name="root" dev=sda5 ino=57 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185436083.463:6): avc:  denied  { search } for  pid=1289 comm="salsa" name="home" dev=sda5 ino=345313 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
audit(1185436083.463:5): avc:  denied  { search } for  pid=1287 comm="salsa" name="home" dev=sda5 ino=345313 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
loop: module loaded
lp0: using parport0 (interrupt-driven).
lp0: console ready
No dock devices found.
input: Power Button (FF) as /class/input/input4
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [VBTN]
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda8, type ext3), uses xattr
SELinux: initialized (dev sda2, type ext2), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda11, type ext3), uses xattr
SELinux: initialized (dev sda10, type vfat), uses genfs_contexts
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized drm 1.1.0 20060810
[drm] Initialized radeon 1.27.0 20060524 on minor 0
audit(1185436095.820:7): avc:  denied  { read } for  pid=1487 comm="rhgb" name="root" dev=sda5 ino=57 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=lnk_file
audit(1185436095.820:8): avc:  denied  { search } for  pid=1487 comm="rhgb" name="/" dev=sda8 ino=2 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:home_root_t:s0 tclass=dir
audit(1185436095.853:9): avc:  denied  { search } for  pid=1487 comm="rhgb" name="root" dev=sda8 ino=3270403 scontext=system_u:system_r:rhgb_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=dir
Adding 1004020k swap on /dev/sda1.  Priority:-1 extents:1 across:1004020k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (4090 buckets, 32720 max)
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX
audit(1185436106.945:10): audit_pid=2026 old=0 by auid=4294967295 subj=system_u:system_r:auditd_t:s0
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
eth0: no IPv6 routers present
IPTABLES in: IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:11:43:1c:b9:47:08:00 SRC=195.29.148.144 DST=195.29.148.255 LEN=84 TOS=0x00 PREC=0x00 TTL=128 ID=60938 PROTO=UDP SPT=1685 DPT=7938 LEN=64 
IPTABLES in: IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:11:43:1c:b9:47:08:00 SRC=195.29.148.144 DST=195.29.148.255 LEN=84 TOS=0x00 PREC=0x00 TTL=128 ID=60939 PROTO=UDP SPT=1685 DPT=111 LEN=64 
IPTABLES in: IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:11:43:1c:b9:47:08:00 SRC=195.29.148.144 DST=195.29.148.255 LEN=84 TOS=0x00 PREC=0x00 TTL=128 ID=60940 PROTO=UDP SPT=1685 DPT=7938 LEN=64 
IPTABLES in: IN=eth0 OUT= MAC=ff:ff:ff:ff:ff:ff:00:11:43:1c:b9:47:08:00 SRC=195.29.148.144 DST=195.29.148.255 LEN=84 TOS=0x00 PREC=0x00 TTL=128 ID=60941 PROTO=UDP SPT=1685 DPT=111 LEN=64 
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs

--Boundary-00=_lVFqGG5XT6IN7ed
Content-Type: text/plain;
  charset="iso-8859-2";
  name="dmidecode.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmidecode.txt"

# dmidecode 2.7
SMBIOS 2.3 present.
101 structures occupying 3625 bytes.
Table at 0x000F0450.

Handle 0xDA00, DMI type 218, 53 bytes.
OEM-specific Type
	Header and Data:
		DA 35 00 DA B2 00 17 4B 0E 38 00 00 00 00 80 01
		00 00 00 02 80 01 00 00 00 00 A0 01 00 58 00 58
		00 01 00 59 00 59 00 01 00 05 80 05 80 01 00 FF
		FF 00 00 00 00

Handle 0xDA01, DMI type 218, 83 bytes.
OEM-specific Type
	Header and Data:
		DA 53 01 DA B2 00 17 4B 0E 38 00 20 F3 20 F3 00
		00 10 F3 10 F3 00 00 30 F3 30 F3 00 00 00 00 21
		F3 00 00 00 00 11 F3 00 00 00 00 31 F3 00 00 10
		F5 10 F5 00 00 00 00 11 F5 00 00 12 F5 12 F5 00
		00 13 F5 13 F5 00 00 00 00 14 F5 00 00 FF FF 00
		00 00 00

Handle 0xDA02, DMI type 218, 137 bytes.
OEM-specific Type
	Header and Data:
		DA 89 02 DA B2 00 17 4B 0E 38 00 20 F4 20 F4 00
		00 10 F4 10 F4 00 00 30 F4 30 F4 00 00 40 F4 40
		F4 00 00 21 F4 21 F4 00 00 11 F4 11 F4 00 00 31
		F4 31 F4 00 00 41 F4 41 F4 00 00 00 00 22 F4 00
		00 00 00 12 F4 00 00 00 00 32 F4 00 00 00 00 42
		F4 00 00 23 F4 23 F4 00 00 13 F4 13 F4 00 00 33
		F4 33 F4 00 00 43 F4 43 F4 00 00 24 F4 24 F4 00
		00 14 F4 14 F4 00 00 34 F4 34 F4 00 00 44 F4 44
		F4 00 00 FF FF 00 00 00 00

Handle 0xDA03, DMI type 218, 161 bytes.
OEM-specific Type
	Header and Data:
		DA A1 03 DA B2 00 17 4B 0E 38 00 25 F4 25 F4 00
		00 15 F4 15 F4 00 00 35 F4 35 F4 00 00 45 F4 45
		F4 00 00 26 F4 26 F4 00 00 16 F4 16 F4 00 00 36
		F4 36 F4 00 00 46 F4 46 F4 00 00 27 F4 27 F4 00
		00 17 F4 17 F4 00 00 37 F4 37 F4 00 00 47 F4 47
		F4 00 00 28 F4 28 F4 00 00 18 F4 18 F4 00 00 38
		F4 38 F4 00 00 48 F4 48 F4 00 00 29 F4 29 F4 00
		00 19 F4 19 F4 00 00 39 F4 39 F4 00 00 49 F4 49
		F4 00 00 2A F4 2A F4 00 00 1A F4 1A F4 00 00 3A
		F4 3A F4 00 00 4A F4 4A F4 00 00 FF FF 00 00 00
		00

Handle 0x0000, DMI type 0, 20 bytes.
BIOS Information
	Vendor: Dell Inc.                
	Version: A07
	Release Date: 03/15/2006
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 512 kB
	Characteristics:
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported

Handle 0x0100, DMI type 1, 25 bytes.
System Information
	Manufacturer: Dell Inc.                
	Product Name: Precision WorkStation 670    
	Version: Not Specified
	Serial Number: 5890M1J
	UUID: 44454C4C-3800-1039-8030-B5C04F4D314A
	Wake-up Type: Power Switch

Handle 0x0200, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: Dell Inc.          
	Product Name: 0U7565
	Version:    
	Serial Number: ..CN1374051D010J.

Handle 0x0300, DMI type 3, 13 bytes.
Chassis Information
	Manufacturer: Dell Inc.                
	Type: Mini Tower
	Lock: Not Present
	Version: Not Specified
	Serial Number: 5890M1J
	Asset Tag:           
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None

Handle 0x0400, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: Microprocessor
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: 41 0F 00 00 FF FB EB BF
	Signature: Type 0, Family 15, Model 4, Stepping 1
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
	Version: Not Specified
	Voltage: 1.5 V
	External Clock: 800 MHz
	Max Speed: 3800 MHz
	Current Speed: 3200 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0700
	L2 Cache Handle: 0x0701
	L3 Cache Handle: Not Provided

Handle 0x0401, DMI type 4, 32 bytes.
Processor Information
	Socket Designation: Microprocessor
	Type: Central Processor
	Family: Xeon
	Manufacturer: Intel
	ID: 00 00 00 00 00 00 00 00
	Signature: Type 0, Family 0, Model 0, Stepping 0
	Flags: None
	Version: Not Specified
	Voltage: 1.5 V
	External Clock: 100 MHz
	Max Speed: 3800 MHz
	Current Speed: Unknown
	Status: Unpopulated
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0702
	L2 Cache Handle: 0x0703
	L3 Cache Handle: Not Provided

Handle 0x0700, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0701, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0702, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: None
	System Type: Data
	Associativity: Unknown

Handle 0x0703, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: Not Specified
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 0 KB
	Maximum Size: 0 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Unknown

Handle 0x0800, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: PARALLEL
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-25 female
	Port Type: Parallel Port PS/2

Handle 0x0801, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SERIAL1
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0802, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: SERIAL2
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0803, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: KYBD
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0804, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: MOUSE
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0805, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB1
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0806, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB2
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0807, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB3
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0808, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB4
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0809, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB5
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x080A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB6
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x080B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB7
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x080C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: USB8
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x080D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: ENET
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x080E, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: MIC
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x080F, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LINE-OUT
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0810, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: LINE-IN
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0814, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: IEEE-1394 Front
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x0815, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: IEEE-1394 Back
	Internal Connector Type: None
	External Reference Designator: Not Specified
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x0901, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_E_1
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Long
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0902, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_2  
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PME signal is supported

Handle 0x0903, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_E_3
	Type: x4 PCI Express
	Current Usage: Available
	Length: Long
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0904, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_X_4
	Type: 64-bit PCI-X
	Current Usage: In Use
	Length: Long
	ID: 4
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0905, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_X_5
	Type: 64-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 5
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0906, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI_X_6
	Type: 64-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 6
	Characteristics:
		3.3 V is provided
		PME signal is supported

Handle 0x0A02, DMI type 10, 6 bytes.
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Intel PRO/1000 MTW Network Connections

Handle 0x0A03, DMI type 10, 6 bytes.
On Board Device Information
	Type: Sound
	Status: Enabled
	Description: AC'97 Audio Controller

Handle 0x0A04, DMI type 10, 6 bytes.
On Board Device Information
	Type: SCSI Controller
	Status: Enabled
	Description: Adaptec AIC-7901 Ultra 320 SCSI Controller

Handle 0x0A05, DMI type 10, 6 bytes.
On Board Device Information
	Type: Other
	Status: Enabled
	Description: IEEE-1394

Handle 0x0B00, DMI type 11, 5 bytes.
OEM Strings
	String 1: www.dell.com

Handle 0x0D00, DMI type 13, 22 bytes.
BIOS Language Information
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0F00, DMI type 15, 31 bytes.
System Event Log
	Area Length: 2049 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFFF81000
	Status: Valid, Not Full
	Change Token: 0x00000029
	Header Format: Type 1
	Supported Log Type Descriptors: 4
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: System limit exceeded
	Data Format 2: System management
	Descriptor 3: Log area reset/cleared
	Data Format 3: None
	Descriptor 4: Multi-bit ECC memory error
	Data Format 4: Handle

Handle 0x1000, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 16 GB
	Error Information Handle: No Error
	Number Of Devices: 6

Handle 0x1100, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_1
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: C100000000000000
	Serial Number: 0D011610
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x1101, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM_2
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: C100000000000000
	Serial Number: 0D011610
	Asset Tag: Not Specified
	Part Number: 72T64020HR5A      

Handle 0x1102, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM_3
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: C100000000000000
	Serial Number: 0D011611
	Asset Tag: Not Specified
	Part Number: 72T64020HR5A      

Handle 0x1103, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM_4
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: FFFFFFFFFFFFFFFF
	Serial Number: FFFFFFFF
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x1104, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM_5
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: FFFFFFFFFFFFFFFF
	Serial Number: FFFFFFFF
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x1105, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x1000
	Error Information Handle: No Error
	Total Width: 144 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM_6
	Bank Locator: Not Specified
	Type: DDR
	Type Detail: Synchronous
	Speed: 400 MHz (2.5 ns)
	Manufacturer: FFFFFFFFFFFFFFFF
	Serial Number: FFFFFFFF
	Asset Tag: Not Specified
	Part Number:                   

Handle 0x1200, DMI type 126, 23 bytes.
Inactive

Handle 0x1301, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x1000
	Partition Width: 0

Handle 0x1402, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x1100
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 2

Handle 0x1403, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x1101
	Memory Array Mapped Address Handle: 0x1301
	Partition Row Position: 1
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x1404, DMI type 126, 19 bytes.
Inactive

Handle 0x1405, DMI type 126, 19 bytes.
Inactive

Handle 0x1406, DMI type 126, 19 bytes.
Inactive

Handle 0x1407, DMI type 126, 19 bytes.
Inactive

Handle 0x1800, DMI type 24, 5 bytes.
Hardware Security
	Power-On Password Status: Enabled
	Keyboard Password Status: Not Implemented
	Administrator Password Status: Enabled
	Front Panel Reset Status: Not Implemented

Handle 0x1900, DMI type 25, 9 bytes.
	System Power Controls
	Next Scheduled Power-on: *-* 00:00:00

Handle 0x1A00, DMI type 26, 20 bytes.
Voltage Probe
	Description: +1.8V
	Location: Motherboard
	Status: OK
	Maximum Value: 3.320 V
	Minimum Value: 0.000 V
	Resolution: 9.3 mV
	Tolerance: Unknown
	Accuracy: 2.00%
	OEM-specific Information: 0x0000DC00

Handle 0x1A01, DMI type 26, 20 bytes.
Voltage Probe
	Description: CPU0 Voltage
	Location: Motherboard
	Status: OK
	Maximum Value: 1.990 V
	Minimum Value: 0.000 V
	Resolution: 7.8 mV
	Tolerance: Unknown
	Accuracy: 2.00%
	OEM-specific Information: 0x0000DC01

Handle 0x1A02, DMI type 126, 20 bytes.
Inactive

Handle 0x1A03, DMI type 26, 20 bytes.
Voltage Probe
	Description: +5V
	Location: Motherboard
	Status: OK
	Maximum Value: 6.640 V
	Minimum Value: 0.000 V
	Resolution: 26.0 mV
	Tolerance: Unknown
	Accuracy: 2.00%
	OEM-specific Information: 0x0000DC03

Handle 0x1A04, DMI type 26, 20 bytes.
Voltage Probe
	Description: +1.5V
	Location: Motherboard
	Status: OK
	Maximum Value: 1.990 V
	Minimum Value: 0.000 V
	Resolution: 7.8 mV
	Tolerance: Unknown
	Accuracy: 2.00%
	OEM-specific Information: 0x0000DC04

Handle 0x1A05, DMI type 26, 20 bytes.
Voltage Probe
	Description: +VCC
	Location: Motherboard
	Status: OK
	Maximum Value: 4.380 V
	Minimum Value: 0.000 V
	Resolution: 17.1 mV
	Tolerance: Unknown
	Accuracy: 2.00%
	OEM-specific Information: 0x0000DC05

Handle 0x1B10, DMI type 27, 12 bytes.
Cooling Device
	Type: Fan
	Status: OK
	OEM-specific Information: 0x0000DD00

Handle 0x1B11, DMI type 126, 12 bytes.
Inactive

Handle 0x1B12, DMI type 27, 12 bytes.
Cooling Device
	Type: Fan
	Status: OK
	OEM-specific Information: 0x0000DD02

Handle 0x1B13, DMI type 27, 12 bytes.
Cooling Device
	Type: Fan
	Status: OK
	OEM-specific Information: 0x0000DD03

Handle 0x1B14, DMI type 126, 12 bytes.
Inactive

Handle 0x1C00, DMI type 28, 20 bytes.
Temperature Probe
	Description: CPU0
	Location: Processor
	Status: OK
	Maximum Value: 127.0 deg C
	Minimum Value -127.0 deg C
	Resolution: 1.000 deg C
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x0000DC11

Handle 0x1C01, DMI type 126, 20 bytes.
Inactive

Handle 0x2000, DMI type 32, 11 bytes.
System Boot Information
	Status: No errors detected

Handle 0x8100, DMI type 129, 8 bytes.
OEM-specific Type
	Header and Data:
		81 08 00 81 01 01 02 01
	Strings:
		Intel_ASF
		Dell_ASF_002

Handle 0x8800, DMI type 136, 6 bytes.
OEM-specific Type
	Header and Data:
		88 06 00 88 5A 5A

Handle 0xD000, DMI type 208, 10 bytes.
OEM-specific Type
	Header and Data:
		D0 0A 00 D0 01 03 FE 00 68 01

Handle 0xD100, DMI type 209, 12 bytes.
OEM-specific Type
	Header and Data:
		D1 0C 00 D1 78 03 07 03 04 0F 80 05

Handle 0xD200, DMI type 210, 12 bytes.
OEM-specific Type
	Header and Data:
		D2 0C 00 D2 F8 03 04 03 06 80 04 05

Handle 0xD201, DMI type 210, 12 bytes.
OEM-specific Type
	Header and Data:
		D2 0C 01 D2 F8 02 03 03 06 80 04 05

Handle 0xD400, DMI type 212, 232 bytes.
OEM-specific Type
	Header and Data:
		D4 E8 00 D4 70 00 71 00 00 10 2D 2E 42 00 11 FE
		01 43 00 11 FE 00 0F 00 25 FC 00 10 00 25 FC 01
		11 00 25 FC 02 12 00 25 FC 03 13 00 25 F3 00 14
		00 25 F3 04 15 00 25 F3 08 16 00 25 F3 0C 07 00
		23 8F 00 08 00 23 F3 00 09 00 23 F3 04 0A 00 23
		F3 08 0B 00 23 8F 10 0C 00 23 8F 20 0E 00 23 8F
		30 0D 00 23 8C 40 A6 00 23 8C 41 A7 00 23 8C 42
		05 01 22 FD 02 06 01 22 FD 00 8C 00 22 FE 00 8D
		00 22 FE 01 9B 00 25 3F 40 9C 00 25 3F 00 09 01
		25 3F 80 A1 00 26 F3 00 A2 00 26 F3 08 A3 00 26
		F3 04 9F 00 26 FD 02 A0 00 26 FD 00 9D 00 11 FB
		04 9E 00 11 FB 00 2B 01 11 7F 80 2C 01 11 7F 00
		54 01 23 7F 00 55 01 23 7F 80 5C 00 78 BF 40 5D
		00 78 BF 00 8A 00 37 DF 20 8B 00 37 DF 00 03 C0
		67 00 05 FF FF 00 00 00

Handle 0xD401, DMI type 212, 177 bytes.
OEM-specific Type
	Header and Data:
		D4 B1 01 D4 70 00 71 00 03 40 59 6D 2D 00 59 FC
		02 2E 00 59 FC 00 6E 00 59 FC 01 27 01 59 FC 03
		28 00 59 3F 00 29 00 59 3F 40 2A 00 59 3F 80 2B
		00 5A 00 00 2C 00 5B 00 00 55 00 59 F3 00 6D 00
		59 F3 04 8E 00 59 F3 08 8F 00 59 F3 00 1C 00 55
		FB 04 1D 00 55 FB 00 19 00 55 E7 00 1A 00 55 E7
		08 1B 00 55 E7 10 23 00 55 7F 00 22 00 55 7F 80
		F5 00 58 BF 40 F6 00 58 BF 00 EB 00 55 FE 00 EA
		00 55 FE 01 01 01 51 3F 00 02 01 51 3F 40 03 01
		51 3F 80 04 01 51 3F C0 40 01 54 CF 00 41 01 54
		CF 10 42 01 54 F7 00 43 01 54 F7 08 FF FF 00 00
		00

Handle 0xD402, DMI type 212, 132 bytes.
OEM-specific Type
	Header and Data:
		D4 84 02 D4 70 00 71 00 00 10 2D 2E 2D 01 21 FE
		01 2E 01 21 FE 00 44 00 25 DF 20 45 00 25 DF 00
		95 00 25 EF 10 96 00 25 EF 00 90 00 11 CF 00 91
		00 11 CF 20 92 00 11 CF 10 E2 00 27 7F 00 E3 00
		27 7F 80 E4 00 27 BF 00 E5 00 27 BF 40 D1 00 22
		7F 80 D2 00 22 7F 00 00 00 22 BF 40 00 00 22 BF
		00 39 01 21 F1 02 37 01 21 F1 00 04 80 78 F5 0A
		01 A0 78 F5 00 93 00 7B 7F 80 94 00 7B 7F 00 FF
		FF 00 00 00

Handle 0xD403, DMI type 212, 97 bytes.
OEM-specific Type
	Header and Data:
		D4 61 03 D4 70 00 71 00 03 40 59 6D 17 01 52 FE
		00 18 01 52 FE 01 19 01 52 FB 00 1A 01 52 FB 04
		1B 01 52 FD 00 1C 01 52 FD 02 1D 01 52 F7 00 1E
		01 52 F7 08 09 40 52 EF 00 08 40 52 EF 10 0B 40
		52 DF 00 0A 40 52 DF 20 0D 40 52 BF 00 0C 40 52
		BF 40 0F 40 52 7F 00 0E 40 52 7F 80 FF FF 00 00
		00

Handle 0xDC00, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 00 DC 20 F4 00 00 10 F4 00 00 00 00 30 F4
		40 F4 00 00 00 00

Handle 0xDC01, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 01 DC 21 F4 00 00 11 F4 00 00 00 00 31 F4
		41 F4 00 00 00 00

Handle 0xDC02, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 02 DC 22 F4 00 00 12 F4 00 00 00 00 32 F4
		42 F4 00 00 00 00

Handle 0xDC03, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 03 DC 23 F4 00 00 13 F4 00 00 00 00 33 F4
		43 F4 00 00 00 00

Handle 0xDC04, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 04 DC 24 F4 00 00 14 F4 00 00 00 00 34 F4
		44 F4 00 00 00 00

Handle 0xDC05, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 05 DC 25 F4 00 00 15 F4 00 00 00 00 35 F4
		45 F4 00 00 00 00

Handle 0xDC11, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 11 DC 20 F3 00 00 10 F3 00 00 00 00 30 F3
		00 00 00 00 00 00

Handle 0xDC12, DMI type 220, 22 bytes.
OEM-specific Type
	Header and Data:
		DC 16 12 DC 21 F3 00 00 11 F3 00 00 00 00 31 F3
		00 00 00 00 00 00

Handle 0xDD00, DMI type 221, 19 bytes.
OEM-specific Type
	Header and Data:
		DD 13 00 DD 00 01 00 00 00 10 F5 00 00 00 00 00
		00 00 00

Handle 0xDD01, DMI type 221, 19 bytes.
OEM-specific Type
	Header and Data:
		DD 13 01 DD 00 01 00 00 00 11 F5 00 00 00 00 00
		00 00 00

Handle 0xDD02, DMI type 221, 19 bytes.
OEM-specific Type
	Header and Data:
		DD 13 02 DD 00 01 00 00 00 12 F5 00 00 00 00 00
		00 00 00

Handle 0xDD03, DMI type 221, 19 bytes.
OEM-specific Type
	Header and Data:
		DD 13 03 DD 00 01 00 00 00 13 F5 00 00 00 00 00
		00 00 00

Handle 0xDE00, DMI type 222, 16 bytes.
OEM-specific Type
	Header and Data:
		DE 10 00 DE C1 01 00 00 07 01 24 09 36 00 00 01

Handle 0x7F00, DMI type 127, 4 bytes.
End Of Table


--Boundary-00=_lVFqGG5XT6IN7ed--
