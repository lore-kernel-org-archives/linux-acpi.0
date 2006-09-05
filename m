From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problem with resuming ATI SATA on HPC nx6325
Date: Tue, 5 Sep 2006 13:38:34 +0200
Message-ID: <200609051338.35059.rjw@sisk.pl>
References: <200609041332.19780.rjw@sisk.pl> <20060905062438.GD1958@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7GW/EQj4xESONke"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:61063 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750792AbWIELfu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2006 07:35:50 -0400
In-Reply-To: <20060905062438.GD1958@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

--Boundary-00=_7GW/EQj4xESONke
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 5 September 2006 08:24, Pavel Machek wrote:

]--snip--[
> 
> So situation is:
> 
> 2.6.18-rc5: works in any config

No.  It works with init=/bin/bash plus some additional modules loaded
(see below).
 
> 2.6.18-rc5-mm1: if ohci+ehci+sata are loaded, SATA breaks during
> resume

2.6.18-rc5-mm1 also works with init=/bin/bash plus some additional modules
loaded, but only if sata_sil is directly compiled in.

I've done some more testing on 2.6.18-rc6 with sata_sil and libata compiled in
and the results are the following:

1) swsusp works with init=/bin/bash, in which case the following modules are
loaded (from the initrd)

ext3
jbd
fan
thermal
processor
atiixp
ide_disk
ide_core
sg

2) it also works with some combinations of additional modules loaded, but
generally the following modules break either the resume-during-suspend stage
of the final resume:

bcm43xx
powernow_k8
sdhci
snd_hda_intel
tg3
yenta_socket

in some combinations with the other modules or by themselves.  For example,
snd_had_intel and powernow_k8 always break the resume-during-suspend phase.
tg3 also breaks it if ehci_hcd and ohci_hcd are loaded and the network interface
is up.  sdhci breaks the resume-during-suspend phase if it is loaded along with
ohci1394 etc.

Now, the output of /proc/interrupts with everything loaded is

           CPU0       CPU1       
  0:     511683          0  local-APIC-edge  timer
  1:       6164          0    IO-APIC-edge  i8042
  8:          0          0    IO-APIC-edge  rtc
 12:        148          0    IO-APIC-edge  i8042
 14:      18053          0    IO-APIC-edge  ide0
169:        140          0   IO-APIC-level  acpi
177:          4          0   IO-APIC-level  yenta, ohci1394, sdhci:slot0
217:      48306          0   IO-APIC-level  libata, HDA Intel
225:      22528          0   IO-APIC-level  ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
233:      30024          0   IO-APIC-level  eth0
NMI:        682       1125 
LOC:     511687     511654 
ERR:          0
MIS:          0

so it looks like the problems are related to the drivers of interrupt vectors
above 14.  However, powernow_k8 doesn't seem to fit.

3) when it breaks, the kernel reports:

sd 0:0:0:0 SCSI error, return code = 0x00070000
end_request: I/O error, dev sda, sector <sector_number>
lost page write due to I/O error on sda

for each sector that is attempted to be read from/written to.  Interestingly
enough, when this happens, the other devices seem to work (eg. the tg3 driver
evidently works).

I'm attaching the output of dmesg after a fresh boot (I think I'll create a
bugzilla entry and put all of the information in there).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

--Boundary-00=_7GW/EQj4xESONke
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.log"

Bootdata ok (command line is root=/dev/sda3 vga=792 resume=/dev/sda1)
Linux version 2.6.18-rc6 (rafael@albercik) (gcc version 4.1.0 (SUSE Linux)) #3 SMP PREEMPT Mon Sep 4 22:31:52 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037fd0000 (usable)
 BIOS-e820: 0000000037fd0000 - 0000000037fe5600 (reserved)
 BIOS-e820: 0000000037fe5600 - 0000000037ff8000 (ACPI NVS)
 BIOS-e820: 0000000037ff8000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000ffbc0000 - 00000000ffcc0000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
DMI 2.4 present.
ACPI: RSDP (v002 HP                                    ) @ 0x00000000000f7d30
ACPI: XSDT (v001 HP     0944     0x06070620 HP   0x00000001) @ 0x0000000037fe57b4
ACPI: FADT (v004 HP     0944     0x00000003 HP   0x00000001) @ 0x0000000037fe5684
ACPI: MADT (v001 HP     0944     0x00000001 HP   0x00000001) @ 0x0000000037fe5808
ACPI: MCFG (v001 HP     0944     0x00000001 HP   0x00000001) @ 0x0000000037fe586c
ACPI: TCPA (v002 HP     0944     0x00000001 HP   0x00000001) @ 0x0000000037fe58a8
ACPI: SSDT (v001 HP       HPQNLP 0x00000001 MSFT 0x0100000e) @ 0x0000000037ff4756
ACPI: SSDT (v001 HP     PSSTBLID 0x00000001 HP   0x00000001) @ 0x0000000037ff47af
ACPI: DSDT (v001 HP        SB400 0x00010000 MSFT 0x0100000e) @ 0x0000000000000000
No mptable found.
On node 0 totalpages: 224966
  DMA zone: 2813 pages, LIFO batch:0
  DMA32 zone: 222153 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:8 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 224966
Kernel command line: root=/dev/sda3 vga=792 resume=/dev/sda1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 1995.070 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ 8308000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 893136k/917312k available (2018k kernel code, 23440k reserved, 1627k data, 176k init)
Calibrating delay using timer specific routine.. 3995.12 BogoMIPS (lpj=7990243)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 12469202
Detected 12.469 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3990.21 BogoMIPS (lpj=7980439)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Turion(tm) 64 X2 Mobile Technology TL-60 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 501 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=357
checking if image is initramfs... it is
Freeing initrd memory: 4695k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 0:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [C074] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
ACPI: Assume root bridge [\_SB_.C074] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C074._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:05.0
PM: Adding info for pci:0000:00:06.0
PM: Adding info for pci:0000:00:12.0
PM: Adding info for pci:0000:00:13.0
PM: Adding info for pci:0000:00:13.1
PM: Adding info for pci:0000:00:13.2
PM: Adding info for pci:0000:00:14.0
PM: Adding info for pci:0000:00:14.1
PM: Adding info for pci:0000:00:14.2
PM: Adding info for pci:0000:00:14.3
PM: Adding info for pci:0000:00:14.4
PM: Adding info for pci:0000:00:18.0
PM: Adding info for pci:0000:00:18.1
PM: Adding info for pci:0000:00:18.2
PM: Adding info for pci:0000:00:18.3
PM: Adding info for pci:0000:01:05.0
PM: Adding info for pci:0000:30:00.0
PM: Adding info for pci:0000:02:01.0
PM: Adding info for pci:0000:02:04.0
PM: Adding info for pci:0000:02:04.1
PM: Adding info for pci:0000:02:04.2
PM: Adding info for pci:0000:02:04.3
ACPI: PCI Interrupt Routing Table [\_SB_.C074.C075._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C074.C0DF._PRT]
ACPI: Power Resource [C223] (off)
ACPI: Embedded Controller [C149] (gpe 17) interrupt mode.
ACPI: Power Resource [C1FE] (off)
ACPI: Power Resource [C217] (on)
ACPI: PCI Interrupt Link [C125] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C126] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C127] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C128] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C129] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C12A] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [C12B] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [C12C] (IRQs *10 11)
ACPI: Power Resource [C34B] (off)
ACPI: Power Resource [C34C] (off)
ACPI: Power Resource [C34D] (off)
ACPI: Power Resource [C34E] (off)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:14.2
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: 6000-6fff
  MEM window: d4300000-d43fffff
  PREFETCH window: c0000000-c7ffffff
PCI: Bridge: 0000:00:04.0
  IO window: 4000-5fff
  MEM window: d0000000-d3ffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: 2000-3fff
  MEM window: cc000000-cfffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: c8000000-c80fffff
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:04.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:14.4
  IO window: 1000-1fff
  MEM window: d4000000-d42fffff
  PREFETCH window: 50000000-51ffffff
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 20 (level, low) -> IRQ 177
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
PM: Adding info for platform:pcspkr
audit: initializing netlink socket (disabled)
audit(1157453631.956:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[5a36:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
PM: Adding info for pci_express:0000:00:04.0:pcie00
Allocate Port Service[0000:00:04.0:pcie01]
PM: Adding info for pci_express:0000:00:04.0:pcie01
Allocate Port Service[0000:00:04.0:pcie03]
PM: Adding info for pci_express:0000:00:04.0:pcie03
PCI: Setting latency timer of device 0000:00:05.0 to 64
pcie_portdrv_probe->Dev[5a37:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
PM: Adding info for pci_express:0000:00:05.0:pcie00
Allocate Port Service[0000:00:05.0:pcie01]
PM: Adding info for pci_express:0000:00:05.0:pcie01
Allocate Port Service[0000:00:05.0:pcie03]
PM: Adding info for pci_express:0000:00:05.0:pcie03
PCI: Setting latency timer of device 0000:00:06.0 to 64
pcie_portdrv_probe->Dev[5a38:1002] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PM: Adding info for pci_express:0000:00:06.0:pcie00
Allocate Port Service[0000:00:06.0:pcie01]
PM: Adding info for pci_express:0000:00:06.0:pcie01
Allocate Port Service[0000:00:06.0:pcie03]
PM: Adding info for pci_express:0000:00:06.0:pcie03
PM: Adding info for platform:vesafb.0
vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using 4608k, total 16384k
vesafb: mode is 1024x768x24, linelength=3072, pages=6
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
libata version 2.00 loaded.
sata_sil 0000:00:12.0: version 2.0
GSI 17 sharing vector 0xD9 and IRQ 17
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 16 (level, low) -> IRQ 217
ata1: SATA max UDMA/100 cmd 0xFFFFC2000000C080 ctl 0xFFFFC2000000C08A bmdma 0xFFFFC2000000C000 irq 217
ata2: SATA max UDMA/100 cmd 0xFFFFC2000000C0C0 ctl 0xFFFFC2000000C0CA bmdma 0xFFFFC2000000C008 irq 217
scsi0 : sata_sil
PM: Adding info for No Bus:host0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_sil
PM: Adding info for No Bus:host1
ata2: SATA link down (SStatus 0 SControl 300)
PM: Adding info for No Bus:target0:0:0
  Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 892C
  Type:   Direct-Access                      ANSI SCSI revision: 05
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
PM: Adding info for platform:i8042
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
PM: Adding info for serio:serio1
serio: i8042 AUX2 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio2
serio: i8042 AUX3 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio3
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio4
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 1
swsusp: Resume From Partition /dev/sda1
PM: Checking swsusp image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 414k
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
Losing some ticks... checking if CPU frequency changed.
PM: Adding info for serio:serio5
sd 0:0:0:0: Attached scsi generic sg0 type 0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 217
ATIIXP: chipset revision 128
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x7040-0x7047, BIOS settings: hda:DMA, hdb:pio
ATIIXP: simplex device: DMA disabled
ide1: ATIIXP Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GMA-4082N, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
ACPI: Processor [C000] (supports 8 throttling states)
ACPI: Processor [C001] (supports 8 throttling states)
ACPI: Thermal Zone [TZ1] (56 C)
ACPI: Thermal Zone [TZ2] (48 C)
ACPI: Thermal Zone [TZ3] (28 C)
ACPI: Transitioning device [C34F] to D3
ACPI: Transitioning device [C34F] to D3
ACPI: Fan [C34F] (off)
ACPI: Transitioning device [C350] to D3
ACPI: Transitioning device [C350] to D3
ACPI: Fan [C350] (off)
ACPI: Fan [C351] (on)
ACPI: Fan [C352] (on)
Attempting manual resume
swsusp: Resume From Partition 8:1
PM: Checking swsusp image.
PM: Resume from disk failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
Yenta: CardBus bridge found at 0000:02:04.0 [103c:30b0]
Yenta: Enabling burst memory read transactions
usbcore: registered new driver hub
Yenta: Using INTVAL to route CSC interrupts to PCI
GSI 18 sharing vector 0xE1 and IRQ 18
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x01a11002, devctl 0x64
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 225
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 1
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ehci_hcd 0000:00:13.2: irq 225, io mem 0xd4403000
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, DMA
Yenta: ISA IRQ mask 0x0ef8, PCI irq 177
Uniform CD-ROM driver Revision: 3.20
Socket status: 30000006
PM: Adding info for No Bus:usbdev1.1_ep81
Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
pcmcia: parent PCI bridge I/O window: 0x1000 - 0x1fff
pcmcia: parent PCI bridge Memory window: 0xd4000000 - 0xd42fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
ieee80211_crypt: registered algorithm 'NULL'
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 225
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 225, io mem 0xd4401000
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee1394: Initialized config rom entry `ip1394'
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 225
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 225, io mem 0xd4402000
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
Floppy drive(s): fd0 is 1.44M
PM: Adding info for No Bus:usbdev3.1_ep81
tg3.c:v3.65 (August 07, 2006)
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
GSI 19 sharing vector 0xE9 and IRQ 19
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 23 (level, low) -> IRQ 233
PM: Adding info for No Bus:i2c-0
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
bcm43xx driver
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:17:08:2e:2e:f3
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 217
usb 2-2: new full speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:02:04.1[A] -> GSI 20 (level, low) -> IRQ 177
PM: Adding info for ieee1394:fw-host0
PM: Adding info for usb:2-2
PM: Adding info for No Bus:usbdev2.2_ep00
usb 2-2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-2:1.0
PM: Adding info for No Bus:usbdev2.2_ep81
PM: Adding info for No Bus:usbdev2.2_ep82
PM: Adding info for No Bus:usbdev2.2_ep02
PM: Adding info for usb:2-2:1.1
PM: Adding info for No Bus:usbdev2.2_ep83
PM: Adding info for No Bus:usbdev2.2_ep03
PM: Adding info for usb:2-2:1.2
PM: Adding info for No Bus:usbdev2.2_ep84
PM: Adding info for No Bus:usbdev2.2_ep04
PM: Adding info for usb:2-2:1.3
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[177]  MMIO=[d4011000-d40117ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sdhci: SDHCI controller found at 0000:02:04.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:02:04.3[A] -> GSI 20 (level, low) -> IRQ 177
mmc0: SDHCI at 0xd4019000 irq 177 PIO
GSI 20 sharing vector 0x32 and IRQ 20
ACPI: PCI Interrupt 0000:30:00.0[A] -> GSI 18 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:30:00.0 to 64
bcm43xx: Chip ID 0x4311, rev 0x1
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243, enabled
usb 3-1: new full speed USB device using ohci_hcd and address 2
bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243, disabled
bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243, disabled
bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243, enabled
bcm43xx: PHY connected
bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
Bluetooth: Core ver 2.10
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PM: Adding info for usb:3-1
PM: Adding info for No Bus:usbdev3.2_ep00
usb 3-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-1:1.0
PM: Adding info for No Bus:usbdev3.2_ep81
PM: Adding info for No Bus:usbdev3.2_ep02
Bluetooth: HCI USB driver ver 2.9
usb 3-4: new low speed USB device using ohci_hcd and address 3
PM: Adding info for ieee1394:00023f9929613f0c
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f9929613f0c]
PM: Adding info for ieee1394:00023f9929613f0c-0
PM: Adding info for usb:3-4
PM: Adding info for No Bus:usbdev3.3_ep00
usb 3-4: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-4:1.0
PM: Adding info for No Bus:usbdev3.3_ep81
PM: Removing info for No Bus:usbdev2.2_ep83
PM: Removing info for No Bus:usbdev2.2_ep03
PM: Adding info for No Bus:usbdev2.2_ep83
PM: Adding info for No Bus:usbdev2.2_ep03
PM: Adding info for No Bus:hci0
usbcore: registered new driver hci_usb
usbcore: registered new driver hiddev
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:13.1-4
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
floppy0: no floppy controllers found
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
loop: loaded (max 8 devices)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Floppy drive(s): fd0 is 1.44M
Adding 1052216k swap on /dev/sda1.  Priority:-1 extents:1 across:1052216k
floppy0: no floppy controllers found
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (3583 buckets, 28664 max) - 304 bytes per conntrack
ACPI: AC Adapter [C1BD] (on-line)
ACPI: Battery Slot [C1BF] (battery present)
ACPI: Battery Slot [C1BE] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C25A]
ACPI: Lid Switch [C25B]
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
PM: Writing back config space on device 0000:02:01.0 at offset b (was 3ed173b, writing 30b0103c)
PM: Writing back config space on device 0000:02:01.0 at offset 3 (was 0, writing 4010)
PM: Writing back config space on device 0000:02:01.0 at offset 2 (was 2000000, writing 2000003)
PM: Writing back config space on device 0000:02:01.0 at offset 1 (was 2b00000, writing 2b00006)
PM: Writing back config space on device 0000:02:01.0 at offset 0 (was 3ed173b, writing 169c14e4)
ADDRCONF(NETDEV_UP): eth0: link is not ready
NET: Registered protocol family 17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
powernow-k8: Found 2 AMD Turion(tm) 64 X2 Mobile Technology TL-60 processors (version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x13
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x15
powernow-k8:    2 : fid 0x8 (1600 MHz), vid 0x17
powernow-k8:    3 : fid 0x0 (800 MHz), vid 0x1e
powernow-k8: ph2 null fid transition 0xc
eth0: no IPv6 routers present
hda-intel: Invalid position buffer, using LPIB read method instead.
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58993 DF PROTO=UDP SPT=62839 DPT=111 LEN=64 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58994 DF PROTO=UDP SPT=62839 DPT=111 LEN=64 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58995 DF PROTO=UDP SPT=62839 DPT=111 LEN=64 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58996 DF PROTO=UDP SPT=62845 DPT=111 LEN=64 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58997 DF PROTO=UDP SPT=62845 DPT=111 LEN=64 
SFW2-INext-DROP-DEFLT IN=eth0 OUT= MAC=00:17:08:2e:2e:f3:00:20:48:04:f1:bd:08:00 SRC=193.0.81.21 DST=193.0.83.66 LEN=84 TOS=0x00 PREC=0x00 TTL=255 ID=58998 DF PROTO=UDP SPT=62845 DPT=111 LEN=64 

--Boundary-00=_7GW/EQj4xESONke--
