From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Wed, 25 Aug 2004 13:19:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040825111907.GA6119@gamma.logic.tuwien.ac.at>
References: <412B2E16.1040904@optonline.net> <20040824142219.GA13607@gamma.logic.tuwien.ac.at> <412B516B.8030704@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <412B516B.8030704-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Nathan, hello list!

On Die, 24 Aug 2004, Nathan Bryant wrote:
> >Unfortunately neither of the workarounds fixed the problem.
> 
> Please send the entire output of dmesg after a suspend/resume. And also 

Attached is dmesg.txt which gives the dmesg output
after 
- booting kernel with workaround 2 (late_...) into full running system
- stopped USB (hotplug stop)
- stopped mysqld (necessary, cannot be stopped by swsusp)
- echo -n "disk" > /sys/power/state
- restarted the computer
- modprobe b44

But as soon as I tried to transmit anything via the eth0 link I get the
problems described (b44: Error, poll already scheduled) and kernel
does not react to Sysrq.

> the output of "cat /proc/interrupts" from a point in time when your 

In a good system:
           CPU0       
  0:    1436822          XT-PIC  timer
  1:       9487          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      15431          XT-PIC  uhci_hcd, eth0
  7:          3          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:      28386          XT-PIC  acpi
 10:      89750          XT-PIC  Intel 82801CA-ICH3, eth1, uhci_hcd, uhci_hcd, uhci_hcd, ICH, yenta, yenta, ohci1394, ehci_hcd, radeon@PCI:1:0:0
 12:      19044          XT-PIC  i8042
 14:      10550          XT-PIC  ide0
 15:         26          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

After suspend-resume cycle AND loading b44, but NOT loading usb
           CPU0       
  0:     227498          XT-PIC  timer
  1:        949          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:       3481          XT-PIC  acpi
 10:        306          XT-PIC  Intel 82801CA-ICH3, eth1, ICH, yenta, yenta, ohci1394, radeon@PCI:1:0:0
 12:        624          XT-PIC  i8042
 14:       7275          XT-PIC  ide0
 15:         27          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

> system has all the possible drivers for your hardware loaded. Keep 
> acpi-devel on the CC: list.

Sorry for this, I always do group reply and your first email was
off-list.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
VIRGINSTOW (n.)
A Durex machine which doesn't have the phrase 'So was the Titanic'
scrawled on it. The word has now fallen into disuse.
			--- Douglas Adams, The Meaning of Liff

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg.txt
Content-Disposition: attachment; filename="dmesg.after-s2d-after-loading-b44"

Linux version 2.6.8.1-mm4n (root@gandalf) (gcc version 3.3.4 (Debian 1:3.3.4-9)) #9 Tue Aug 24 15:52:30 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7c000 (ACPI data)
 BIOS-e820: 000000001ff7c000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f5e80
ACPI: RSDT (v001 ACER     RSDT   0x20020630  LTP 0x00000000) @ 0x1ff75a7b
ACPI: FADT (v001 ACER   IBIS     0x20020630 PTL  0x0000001e) @ 0x1ff7bf64
ACPI: BOOT (v001 ACER   IBIS     0x20020630  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: DSDT (v001 ACER   IBIS     0x20020630 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.8.1-mm4n ro root=304
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2193.184 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514972k/523712k available (1899k kernel code, 8232k reserved, 967k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4325.37 BogoMIPS (lpj=2162688)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 2.20GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd731, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10) *0, disabled.
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5f10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x913b, dseg 0x400
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f could not be reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (58 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: RNG not detected
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4021GAS, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
perfctr: driver 2.7.5, cpu type Intel P4 at 2193394 kHz
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49328 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801CA-ICH3 at 0x1c00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Suspend partition has wrong signature?
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
MDM0  HUB GLAN USB1 USB2 USB1 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda4: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 179892
ext3_orphan_cleanup: deleting unreferenced inode 179884
EXT3-fs: hda4: 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 682752k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
b44.c:v0.94 (May 4, 2004)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:1f:59:38
orinoco 0.15rc2HEAD (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>, et al)
orinoco_pci 0.15rc2HEAD (Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>, David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> & Jean Tourrilhes <jt-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>)
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
orinoco_pci: Detected PCI device 0000:02:04.0, memory 0xf8000000-0xf8000fff, irq 10
eth1: Hardware identity 8022:0000:0001:0000
eth1: Station identity  001f:0000:0001:0008
eth1: Firmware determined as Intersil 1.8.0
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:02:8A:95:EE:C0
eth1: Station name "Prism  I"
eth1: ready
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xec000000
Acer Travelmate hotkey driver v0.5.13
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Enabling device 0000:00:1d.0 (0004 -> 0005)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:02:09.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:02:09.0: irq 10, io base 00005000
uhci_hcd 0000:02:09.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:02:09.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:02:09.1: irq 10, io base 00005020
uhci_hcd 0000:02:09.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: Flash R/W         Rev: 2002
  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
slamr: module license 'Smart Link Ltd.' taints kernel.
slamr: SmartLink AMRMO modem.
slamr: probe 8086:2486 ICH card...
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
slamr: mc97 codec is SIL27
slamr: slamr0 is ICH card.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.0 [1025:0020]
Yenta: ISA IRQ mask 0x0818, PCI irq 10
Socket status: 30000006
PCI: Enabling device 0000:02:06.1 (0104 -> 0106)
ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:06.1 [1025:0020]
Yenta: ISA IRQ mask 0x0818, PCI irq 10
Socket status: 30000410
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1226 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8208000-e82087ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:02:09.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:02:09.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:02:09.2: irq 10, pci mem e0942800
ehci_hcd 0000:02:09.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:02:09.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00000b36ba]
ip1394: $Rev: 1231 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Access to /proc/cpufreq is deprecated and will be removed from (new) 2.6. kernels soon after 2005-01-01
NET: Registered protocol family 23
b44: eth0: Link is down.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
eth1: New link status: Disconnected (0002)
Renicing XFree86 for you
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
ehci_hcd 0000:02:09.2: remove, state 1
usb usb5: USB disconnect, address 1
ehci_hcd 0000:02:09.2: USB bus 5 deregistered
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
usb 2-2: USB disconnect, address 2
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:02:09.0: remove, state 1
usb usb3: USB disconnect, address 1
uhci_hcd 0000:02:09.0: USB bus 3 deregistered
uhci_hcd 0000:02:09.1: remove, state 1
usb usb4: USB disconnect, address 1
uhci_hcd 0000:02:09.1: USB bus 4 deregistered
usbcore: deregistering driver usb-storage
usbcore: deregistering driver usbfs
usbcore: deregistering driver hub
Stopping tasks: ====================================================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, mysqld not stopped
 done
Stopping tasks: ================================================|
Freeing memory: ...........................................................................|
eth1: Orinoco-PCI entering sleep mode (state=3)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section: 
.<7>[nosave pfn 0x3c1]<7>[nosave pfn 0x3c2]......................swsusp: Need to copy 12536 pages
suspend: (pages needed: 12536 + 512 free: 118390)
.<7>[nosave pfn 0x3c1]<7>[nosave pfn 0x3c2]<7>PM: Image restored successfully.
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
eth1: Orinoco-PCI waking up
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:09.2[C] -> GSI 10 (level, low) -> IRQ 10
Restarting tasks... done
mtrr: MTRR 2 not used
mtrr: no MTRR for f0000000,2000000 found
mtrr: MTRR 2 not used
Warning: CPU frequency is 2200000, cpufreq assumed 1200000 kHz.
eth1: New link status: Disconnected (0002)
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
b44.c:v0.94 (May 4, 2004)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:1f:59:38

--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
