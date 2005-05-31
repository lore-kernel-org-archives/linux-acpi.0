From: Hannes Diethelm <hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem
	depends on sound-playing: irq 10: nobody cared!
Date: Tue, 31 May 2005 21:20:33 +0200
Message-ID: <1117567234.4711.1.camel@localhost.localdomain>
References: <20050525224328.734adc03.akpm@osdl.org>
	 <200505310957.28789.bjorn.helgaas@hp.com>
	 <1117564793.4816.11.camel@localhost.localdomain>
	 <200505311249.07949.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-w0/JahAwSBj7j61Llyv2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200505311249.07949.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-w0/JahAwSBj7j61Llyv2
Content-Type: text/plain
Content-Transfer-Encoding: 7Bit

Am Dienstag, den 31.05.2005, 12:49 -0600 schrieb Bjorn Helgaas:

> Can you please collect the complete dmesg log and contents of
> /proc/interrupts?

Something to read ;)

--=-w0/JahAwSBj7j61Llyv2
Content-Disposition: attachment; filename=dmesg_after_sound.txt
Content-Type: text/plain; name=dmesg_after_sound.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7Bit

Linux version 2.6.12-rc5-mm1 (hannes@linux-server) (gcc-Version 3.3.5 (Debian 1:3.3.5-12)) #2 SMP Tue May 31 19:57:32 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5290
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f6590
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff57c0
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: root=/dev/hda1 ro vga=791
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 868.755 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514100k/524224k available (3016k kernel code, 9636k reserved, 1162k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1740.70 BogoMIPS (lpj=3481416)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.41 BogoMIPS (lpj=3474821)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3478.11 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
audit: initializing netlink socket (disabled)
audit(1117565920.316:1): initialized
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.23-WIP [Flags: R/O].
PCI: Enabling Via external APIC routing
vesafb: framebuffer at 0xd9000000, mapped to 0xe0880000, using 3072k, total 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c7d6:0000
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
cn_fork is registered
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 18 (level, low) -> IRQ 16
eth0: 0000:00:0f.0, 00:08:9B:09:A9:4B, IRQ 16.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 17
eth1: 0000:00:10.0, 00:08:9B:09:A9:4C, IRQ 17.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6B160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/8192KiB Cache, CHS=19929/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
ide-disk: probe of 1.0 failed with error 1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugs is not available
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OPTi Inc. 82C861
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xd9a02000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:07.2, from 12 to 2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.2: irq 18, io base 0x0000b000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:07.3, from 12 to 2
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:07.3: irq 18, io base 0x0000b400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:13.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 10:33:39 2005 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:07.5, from 11 to 3
PCI: Setting latency timer of device 0000:00:07.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
ALSA device list:
  #0: VIA 82C686A/B rev50 with ALC200,200P at 0xb800, irq 19
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.2: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 5
Starting balanced_irq
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 240k freed
Adding 1510068k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 20
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
[drm] Loading R200 Microcode
irq 20: nobody cared (try booting with the "irqpoll" option.
 [<c014117a>] __report_bad_irq+0x2a/0xa0
 [<c01409a0>] handle_IRQ_event+0x30/0x70
 [<c0141290>] note_interrupt+0x80/0xf0
 [<c0140b1c>] __do_IRQ+0x13c/0x140
 [<c0105969>] do_IRQ+0x19/0x30
 [<c0103b62>] common_interrupt+0x1a/0x20
 [<c0100d70>] default_idle+0x0/0x30
 [<c0100d93>] default_idle+0x23/0x30
 [<c0100e60>] cpu_idle+0x80/0x90
 [<c05189dd>] start_kernel+0x18d/0x1d0
 [<c05183c0>] unknown_bootoption+0x0/0x1e0
handlers:
[<e0c56e20>] (radeon_driver_irq_handler+0x0/0xc0 [radeon])
Disabling IRQ #20
Unable to handle kernel paging request at virtual address b587f060
 printing eip:
c03354d7
*pde = 0c167067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: radeon drm
CPU:    0
EIP:    0060:[<c03354d7>]    Not tainted VLI
EFLAGS: 00210282   (2.6.12-rc5-mm1) 
EIP is at snd_pcm_mmap_data_close+0x7/0x12
eax: b587f000   ebx: c03354d0   ecx: ddb03a20   edx: cc4897d0
esi: dfb59ec4   edi: ddb03a20   ebp: cc489750   esp: cc1d3f40
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 4650, threadinfo=cc1d2000 task=d518da30)
Stack: c01542b6 cc489750 cc489778 dfb59e98 00000000 d878bcc0 cc489750 d878bcc0 
       c0155c2f cc489750 cc489750 b587f000 b586f000 c015604b d878bcc0 cc489750 
       cc4896f8 b586f000 b587f000 cc4896f8 d878bcc0 d878bcf0 00000002 cc1d2000 
Call Trace:
 [<c01542b6>] remove_vm_struct+0x96/0xa0
 [<c0155c2f>] unmap_vma_list+0x1f/0x30
 [<c015604b>] do_munmap+0x11b/0x150
 [<c01560c5>] sys_munmap+0x45/0x70
 [<c01031a5>] syscall_call+0x7/0xb
Code: 00 00 00 00 8b 44 24 04 8b 40 50 8b 40 60 f0 ff 80 a4 00 00 00 c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 8b 44 24 04 8b 40 50 <8b> 40 60 f0 ff 88 a4 00 00 00 c3 51 52 e8 37 b8 0b 00 5a 59 e9 
 

--=-w0/JahAwSBj7j61Llyv2
Content-Disposition: attachment; filename=dmesg_before_sound.txt
Content-Type: text/plain; name=dmesg_before_sound.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7Bit

Linux version 2.6.12-rc5-mm1 (hannes@linux-server) (gcc-Version 3.3.5 (Debian 1:3.3.5-12)) #2 SMP Tue May 31 19:57:32 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5290
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f6590
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff57c0
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: root=/dev/hda1 ro vga=791
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 868.755 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514100k/524224k available (3016k kernel code, 9636k reserved, 1162k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1740.70 BogoMIPS (lpj=3481416)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1737.41 BogoMIPS (lpj=3474821)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3478.11 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
audit: initializing netlink socket (disabled)
audit(1117565920.316:1): initialized
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.23-WIP [Flags: R/O].
PCI: Enabling Via external APIC routing
vesafb: framebuffer at 0xd9000000, mapped to 0xe0880000, using 3072k, total 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c7d6:0000
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
cn_fork is registered
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 18 (level, low) -> IRQ 16
eth0: 0000:00:0f.0, 00:08:9B:09:A9:4B, IRQ 16.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 17
eth1: 0000:00:10.0, 00:08:9B:09:A9:4C, IRQ 17.
  Board assembly 729757-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6B160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/8192KiB Cache, CHS=19929/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
ide-disk: probe of 1.0 failed with error 1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugs is not available
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 18 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OPTi Inc. 82C861
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xd9a02000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:07.2, from 12 to 2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.2: irq 18, io base 0x0000b000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:07.3, from 12 to 2
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:07.3: irq 18, io base 0x0000b400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using ohci_hcd and address 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:13.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 10:33:39 2005 UTC).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:07.5, from 11 to 3
PCI: Setting latency timer of device 0000:00:07.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
ALSA device list:
  #0: VIA 82C686A/B rev50 with ALC200,200P at 0xb800, irq 19
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.2: Stephen Frost <sfrost-vhD3WmCyG/PR7s880joybQ@public.gmane.org>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 5
Starting balanced_irq
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Freeing unused kernel memory: 240k freed
Adding 1510068k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 20
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
[drm] Loading R200 Microcode

--=-w0/JahAwSBj7j61Llyv2
Content-Disposition: attachment; filename=interrupts_after_sound.txt
Content-Type: text/plain; name=interrupts_after_sound.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7Bit

           CPU0       CPU1       
  0:      33929      28893    IO-APIC-edge  timer
  1:        383        232    IO-APIC-edge  i8042
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 14:       5687       3339    IO-APIC-edge  ide0
 15:       1012       1065    IO-APIC-edge  ide1
 16:      12155         13   IO-APIC-level  ohci_hcd:usb1, eth0
 18:       1650        916   IO-APIC-level  uhci_hcd:usb2, uhci_hcd:usb3
 19:      11948       9029   IO-APIC-level  VIA686A
 20:     199254        746   IO-APIC-level  radeon@PCI:2:7:0
NMI:          0          0 
LOC:      62702      62701 
ERR:          0
MIS:          0

--=-w0/JahAwSBj7j61Llyv2
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7Bit

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d7000000-d8ffffff
	Prefetchable memory behind bridge: d9000000-d97fffff
	Capabilities: <available only to root>

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at cc00 [size=16]
	Capabilities: <available only to root>

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at b000 [size=32]
	Capabilities: <available only to root>

0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at b400 [size=32]
	Capabilities: <available only to root>

0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel, IRQ 9
	Capabilities: <available only to root>

0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Flags: medium devsel, IRQ 19
	I/O ports at b800 [size=256]
	I/O ports at bc00 [size=4]
	I/O ports at c000 [size=4]
	Capabilities: <available only to root>

0000:00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at d9a01000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c400 [size=64]
	Memory at d9800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

0000:00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	Memory at d9a00000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at c800 [size=64]
	Memory at d9900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

0000:00:11.0 PCI bridge: Texas Instruments PCI2031 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: d5000000-d6ffffff
	Prefetchable memory behind bridge: c0000000-cfffffff
	Capabilities: <available only to root>

0000:00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc. 82C861
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at d9a02000 (32-bit, non-prefetchable) [size=4K]

0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 0b) (prog-if 00 [VGA])
	Subsystem: Yuan Yuan Enterprise Co., Ltd.: Unknown device 6326
	Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 255
	Memory at d9000000 (32-bit, prefetchable) [size=8M]
	Memory at d8000000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at 9000 [size=128]
	Capabilities: <available only to root>

0000:02:07.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
	Subsystem: Hightech Information System Ltd.: Unknown device 2020
	Flags: bus master, medium devsel, latency 32, IRQ 20
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a000 [disabled] [size=256]
	Memory at d6000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:02:07.1 Display controller: ATI Technologies Inc: Unknown device 5940 (rev 01)
	Subsystem: Hightech Information System Ltd.: Unknown device 2021
	Flags: bus master, medium devsel, latency 32
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	Memory at d6010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>


--=-w0/JahAwSBj7j61Llyv2
Content-Disposition: attachment; filename=syslog
Content-Type: text/plain; name=syslog; charset=iso-8859-1
Content-Transfer-Encoding: Quoted-Printable

May 31 20:58:58 localhost syslogd 1.4.1#16: restart.
May 31 20:58:58 localhost udev[3315]: removing device node '/dev/vcsa1'
May 31 20:58:58 localhost udev[3320]: creating device node '/dev/vcs1'
May 31 20:58:58 localhost udev[3328]: creating device node '/dev/vcsa1'
May 31 20:58:58 localhost kernel: klogd 1.4.1#16, log source =3D /proc/km=
sg started.
May 31 20:58:58 localhost kernel: Cannot find map file.
May 31 20:58:58 localhost kernel: No module symbols loaded - kernel modul=
es not enabled.=20
May 31 20:58:58 localhost kernel: Linux version 2.6.12-rc5-mm1 (hannes@li=
nux-server) (gcc-Version 3.3.5 (Debian 1:3.3.5-12)) #2 SMP Tue May 31 19:=
57:32 CEST 2005
May 31 20:58:58 localhost kernel: BIOS-provided physical RAM map:
May 31 20:58:58 localhost kernel:  BIOS-e820: 0000000000000000 - 00000000=
000a0000 (usable)
May 31 20:58:58 localhost kernel:  BIOS-e820: 00000000000f0000 - 00000000=
00100000 (reserved)
May 31 20:58:58 localhost kernel:  BIOS-e820: 0000000000100000 - 00000000=
1fff0000 (usable)
May 31 20:58:58 localhost kernel:  BIOS-e820: 000000001fff0000 - 00000000=
1fff3000 (ACPI NVS)
May 31 20:58:58 localhost kernel:  BIOS-e820: 000000001fff3000 - 00000000=
20000000 (ACPI data)
May 31 20:58:58 localhost kernel:  BIOS-e820: 00000000fec00000 - 00000001=
00000000 (reserved)
May 31 20:58:58 localhost kernel: 511MB LOWMEM available.
May 31 20:58:58 localhost kernel: found SMP MP-table at 000f5290
May 31 20:58:58 localhost kernel: On node 0 totalpages: 131056
May 31 20:58:58 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
May 31 20:58:58 localhost kernel:   Normal zone: 126960 pages, LIFO batch=
:31
May 31 20:58:58 localhost kernel:   HighMem zone: 0 pages, LIFO batch:1
May 31 20:58:58 localhost kernel: DMI not present.
May 31 20:58:58 localhost kernel: ACPI: RSDP (v000 VIA694                =
                ) @ 0x000f6590
May 31 20:58:58 localhost kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x1fff3000
May 31 20:58:58 localhost kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x1fff3040
May 31 20:58:58 localhost kernel: ACPI: MADT (v001 VIA694 AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x1fff57c0
May 31 20:58:58 localhost kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x0000=
1000 MSFT 0x0100000c) @ 0x00000000
May 31 20:58:58 localhost kernel: ACPI: Local APIC address 0xfee00000
May 31 20:58:58 localhost kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x0=
0] enabled)
May 31 20:58:58 localhost kernel: Processor #0 6:8 APIC version 17
May 31 20:58:58 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x0=
1] enabled)
May 31 20:58:58 localhost kernel: Processor #1 6:8 APIC version 17
May 31 20:58:58 localhost kernel: ACPI: IOAPIC (id[0x02] address[0xfec000=
00] gsi_base[0])
May 31 20:58:58 localhost kernel: IOAPIC[0]: apic_id 2, version 17, addre=
ss 0xfec00000, GSI 0-23
May 31 20:58:58 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 glob=
al_irq 2 dfl dfl)
May 31 20:58:58 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 glob=
al_irq 9 dfl dfl)
May 31 20:58:58 localhost kernel: ACPI: IRQ0 used by override.
May 31 20:58:58 localhost kernel: ACPI: IRQ2 used by override.
May 31 20:58:58 localhost kernel: ACPI: IRQ9 used by override.
May 31 20:58:58 localhost kernel: Enabling APIC mode:  Flat.  Using 1 I/O=
 APICs
May 31 20:58:58 localhost kernel: Using ACPI (MADT) for SMP configuration=
 information
May 31 20:58:58 localhost kernel: Allocating PCI resources starting at 20=
000000 (gap: 20000000:dec00000)
May 31 20:58:58 localhost kernel: Built 1 zonelists
May 31 20:58:58 localhost kernel: mapped APIC to ffffd000 (fee00000)
May 31 20:58:58 localhost kernel: mapped IOAPIC to ffffc000 (fec00000)
May 31 20:58:58 localhost kernel: Initializing CPU#0
May 31 20:58:58 localhost kernel: Kernel command line: root=3D/dev/hda1 r=
o vga=3D791
May 31 20:58:58 localhost kernel: PID hash table entries: 2048 (order: 11=
, 32768 bytes)
May 31 20:58:58 localhost kernel: Detected 868.755 MHz processor.
May 31 20:58:58 localhost kernel: Using tsc for high-res timesource
May 31 20:58:58 localhost kernel: Console: colour dummy device 80x25
May 31 20:58:58 localhost kernel: Dentry cache hash table entries: 131072=
 (order: 7, 524288 bytes)
May 31 20:58:58 localhost kernel: Inode-cache hash table entries: 65536 (=
order: 6, 262144 bytes)
May 31 20:58:58 localhost kernel: Memory: 514100k/524224k available (3016=
k kernel code, 9636k reserved, 1162k data, 240k init, 0k highmem)
May 31 20:58:58 localhost kernel: Checking if this processor honours the =
WP bit even in supervisor mode... Ok.
May 31 20:58:58 localhost kernel: Calibrating delay using timer specific =
routine.. 1740.70 BogoMIPS (lpj=3D3481416)
May 31 20:58:58 localhost kernel: Mount-cache hash table entries: 512
May 31 20:58:58 localhost kernel: CPU: After generic identify, caps: 0387=
fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: CPU: After vendor identify, caps: 0387f=
bff 00000000 00000000 00000000 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 31 20:58:58 localhost kernel: CPU: L2 cache: 256K
May 31 20:58:58 localhost kernel: CPU serial number disabled.
May 31 20:58:58 localhost kernel: CPU: After all inits, caps: 0383fbff 00=
000000 00000000 00000040 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: Intel machine check architecture suppor=
ted.
May 31 20:58:58 localhost kernel: Intel machine check reporting enabled o=
n CPU#0.
May 31 20:58:58 localhost kernel: Enabling fast FPU save and restore... d=
one.
May 31 20:58:58 localhost kernel: Enabling unmasked SIMD FPU exception su=
pport... done.
May 31 20:58:58 localhost kernel: Checking 'hlt' instruction... OK.
May 31 20:58:58 localhost kernel: CPU0: Intel Pentium III (Coppermine) st=
epping 0a
May 31 20:58:58 localhost kernel: Booting processor 1/1 eip 2000
May 31 20:58:58 localhost kernel: Initializing CPU#1
May 31 20:58:58 localhost kernel: Calibrating delay using timer specific =
routine.. 1737.41 BogoMIPS (lpj=3D3474821)
May 31 20:58:58 localhost kernel: CPU: After generic identify, caps: 0387=
fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: CPU: After vendor identify, caps: 0387f=
bff 00000000 00000000 00000000 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 31 20:58:58 localhost kernel: CPU: L2 cache: 256K
May 31 20:58:58 localhost kernel: CPU serial number disabled.
May 31 20:58:58 localhost kernel: CPU: After all inits, caps: 0383fbff 00=
000000 00000000 00000040 00000000 00000000 00000000
May 31 20:58:58 localhost kernel: Intel machine check architecture suppor=
ted.
May 31 20:58:58 localhost kernel: Intel machine check reporting enabled o=
n CPU#1.
May 31 20:58:58 localhost kernel: CPU1: Intel Pentium III (Coppermine) st=
epping 0a
May 31 20:58:58 localhost kernel: Total of 2 processors activated (3478.1=
1 BogoMIPS).
May 31 20:58:58 localhost kernel: ENABLING IO-APIC IRQs
May 31 20:58:58 localhost kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D=
-1
May 31 20:58:58 localhost kernel: checking TSC synchronization across 2 C=
PUs: passed.
May 31 20:58:58 localhost kernel: Brought up 2 CPUs
May 31 20:58:58 localhost kernel: NET: Registered protocol family 16
May 31 20:58:58 localhost kernel: ACPI: bus type pci registered
May 31 20:58:58 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0x=
fb4a0, last bus=3D2
May 31 20:58:58 localhost kernel: PCI: Using configuration type 1
May 31 20:58:58 localhost kernel: mtrr: v2.0 (20020519)
May 31 20:58:58 localhost kernel: mtrr: your CPUs had inconsistent variab=
le MTRR settings
May 31 20:58:58 localhost kernel: mtrr: probably your BIOS does not setup=
 all CPUs.
May 31 20:58:58 localhost kernel: mtrr: corrected configuration.
May 31 20:58:58 localhost kernel: ACPI: Subsystem revision 20050408
May 31 20:58:58 localhost kernel: ACPI: Interpreter enabled
May 31 20:58:58 localhost kernel: ACPI: Using IOAPIC for interrupt routin=
g
May 31 20:58:58 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
May 31 20:58:58 localhost kernel: PCI: Probing PCI hardware (bus 00)
May 31 20:58:58 localhost kernel: ACPI: Assume root bridge [\_SB_.PCI0] s=
egment is 0
May 31 20:58:58 localhost kernel: ACPI: Assume root bridge [\_SB_.PCI0] b=
us is 0
May 31 20:58:58 localhost kernel: Boot video device is 0000:01:00.0
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB=
_.PCI0._PRT]
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1=
 3 4 5 6 7 10 11 12 14 15) *0, disabled.
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1=
 3 4 5 6 7 *10 11 12 14 15)
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1=
 3 4 5 6 7 10 *11 12 14 15)
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1=
 3 4 5 6 7 10 11 *12 14 15)
May 31 20:58:58 localhost kernel: Linux Plug and Play Support v0.97 (c) A=
dam Belay
May 31 20:58:58 localhost kernel: pnp: PnP ACPI init
May 31 20:58:58 localhost kernel: pnp: PnP ACPI: found 11 devices
May 31 20:58:58 localhost kernel: PnPBIOS: Disabled by ACPI PNP
May 31 20:58:58 localhost kernel: SCSI subsystem initialized
May 31 20:58:58 localhost kernel: usbcore: registered new driver usbfs
May 31 20:58:58 localhost kernel: usbcore: registered new driver hub
May 31 20:58:58 localhost kernel: PCI: Using ACPI for IRQ routing
May 31 20:58:58 localhost kernel: PCI: If a device doesn't work, try "pci=
=3Drouteirq".  If it helps, post a report
May 31 20:58:58 localhost kernel: audit: initializing netlink socket (dis=
abled)
May 31 20:58:58 localhost kernel: audit(1117565920.316:1): initialized
May 31 20:58:58 localhost kernel: inotify device minor=3D63
May 31 20:58:58 localhost kernel: Installing knfsd (copyright (C) 1996 ok=
ir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
May 31 20:58:58 localhost kernel: NTFS driver 2.1.23-WIP [Flags: R/O].
May 31 20:58:58 localhost kernel: PCI: Enabling Via external APIC routing
May 31 20:58:58 localhost kernel: vesafb: framebuffer at 0xd9000000, mapp=
ed to 0xe0880000, using 3072k, total 4096k
May 31 20:58:58 localhost kernel: vesafb: mode is 1024x768x16, linelength=
=3D2048, pages=3D1
May 31 20:58:58 localhost kernel: vesafb: protected mode interface info a=
t c7d6:0000
May 31 20:58:58 localhost kernel: vesafb: scrolling: redraw
May 31 20:58:58 localhost kernel: vesafb: Truecolor: size=3D0:5:6:5, shif=
t=3D0:11:5:0
May 31 20:58:58 localhost kernel: Console: switching to colour frame buff=
er device 128x48
May 31 20:58:58 localhost kernel: fb0: VESA VGA frame buffer device
May 31 20:58:58 localhost kernel: isapnp: Scanning for PnP cards...
May 31 20:58:58 localhost kernel: isapnp: No Plug & Play device found
May 31 20:58:58 localhost kernel: lp: driver loaded but no devices found
May 31 20:58:58 localhost kernel: Linux agpgart interface v0.101 (c) Dave=
 Jones
May 31 20:58:58 localhost kernel: agpgart: Detected VIA Apollo Pro 133 ch=
ipset
May 31 20:58:58 localhost kernel: agpgart: AGP aperture is 64M @ 0xd00000=
00
May 31 20:58:58 localhost kernel: cn_fork is registered
May 31 20:58:58 localhost kernel: PNP: PS/2 controller doesn't have AUX i=
rq; using default 0xc
May 31 20:58:58 localhost kernel: PNP: PS/2 Controller [PNP0303:PS2K] at =
0x60,0x64 irq 1,12
May 31 20:58:58 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq =
12
May 31 20:58:58 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq =
1
May 31 20:58:58 localhost kernel: Serial: 8250/16550 driver $Revision: 1.=
90 $ 8 ports, IRQ sharing disabled
May 31 20:58:58 localhost kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 165=
50A
May 31 20:58:58 localhost kernel: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 165=
50A
May 31 20:58:58 localhost kernel: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 165=
50A
May 31 20:58:58 localhost kernel: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 165=
50A
May 31 20:58:58 localhost kernel: parport_pc: VIA 686A/8231 detected
May 31 20:58:58 localhost kernel: parport_pc: probing current configurati=
on
May 31 20:58:58 localhost kernel: parport_pc: Current parallel port base:=
 0x378
May 31 20:58:58 localhost kernel: parport0: PC-style at 0x378, irq 7 [PCS=
PP(,...)]
May 31 20:58:58 localhost kernel: lp0: using parport0 (interrupt-driven).
May 31 20:58:58 localhost kernel: parport_pc: VIA parallel port: io=3D0x3=
78, irq=3D7
May 31 20:58:58 localhost kernel: io scheduler noop registered
May 31 20:58:58 localhost kernel: io scheduler anticipatory registered
May 31 20:58:58 localhost kernel: io scheduler deadline registered
May 31 20:58:58 localhost kernel: io scheduler cfq registered
May 31 20:58:58 localhost kernel: Floppy drive(s): fd0 is 1.44M
May 31 20:58:58 localhost kernel: FDC 0 is a post-1991 82077
May 31 20:58:58 localhost kernel: RAMDISK driver initialized: 16 RAM disk=
s of 4096K size 1024 blocksize
May 31 20:58:58 localhost kernel: loop: loaded (max 8 devices)
May 31 20:58:58 localhost kernel: eepro100.c:v1.09j-t 9/29/99 Donald Beck=
er http://www.scyld.com/network/eepro100.html
May 31 20:58:58 localhost kernel: eepro100.c: $Revision: 1.36 $ 2000/11/1=
7 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:0f.0[A] -> =
GSI 18 (level, low) -> IRQ 16
May 31 20:58:58 localhost kernel: eth0: 0000:00:0f.0, 00:08:9B:09:A9:4B, =
IRQ 16.
May 31 20:58:58 localhost kernel:   Board assembly 729757-006, Physical c=
onnectors present: RJ45
May 31 20:58:58 localhost kernel:   Primary interface chip i82555 PHY #1.
May 31 20:58:58 localhost kernel:   General self-test: passed.
May 31 20:58:58 localhost kernel:   Serial sub-system self-test: passed.
May 31 20:58:58 localhost kernel:   Internal registers self-test: passed.
May 31 20:58:58 localhost kernel:   ROM checksum self-test: passed (0x04f=
4518b).
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> =
GSI 17 (level, low) -> IRQ 17
May 31 20:58:58 localhost kernel: eth1: 0000:00:10.0, 00:08:9B:09:A9:4C, =
IRQ 17.
May 31 20:58:58 localhost kernel:   Board assembly 729757-006, Physical c=
onnectors present: RJ45
May 31 20:58:58 localhost kernel:   Primary interface chip i82555 PHY #1.
May 31 20:58:58 localhost kernel:   General self-test: passed.
May 31 20:58:58 localhost kernel:   Serial sub-system self-test: passed.
May 31 20:58:58 localhost kernel:   Internal registers self-test: passed.
May 31 20:58:58 localhost kernel:   ROM checksum self-test: passed (0x04f=
4518b).
May 31 20:58:58 localhost kernel: Uniform Multi-Platform E-IDE driver Rev=
ision: 7.00alpha2
May 31 20:58:58 localhost kernel: ide: Assuming 33MHz system bus speed fo=
r PIO modes; override with idebus=3Dxx
May 31 20:58:58 localhost kernel: VP_IDE: IDE controller at PCI slot 0000=
:00:07.1
May 31 20:58:58 localhost kernel: PCI: Via IRQ fixup for 0000:00:07.1, fr=
om 255 to 0
May 31 20:58:58 localhost kernel: VP_IDE: chipset revision 6
May 31 20:58:58 localhost kernel: VP_IDE: not 100%% native mode: will pro=
be irqs later
May 31 20:58:58 localhost kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA=
100 controller on pci0000:00:07.1
May 31 20:58:58 localhost kernel:     ide0: BM-DMA at 0xcc00-0xcc07, BIOS=
 settings: hda:DMA, hdb:pio
May 31 20:58:58 localhost kernel:     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS=
 settings: hdc:DMA, hdd:pio
May 31 20:58:58 localhost kernel: Probing IDE interface ide0...
May 31 20:58:58 localhost kernel: hda: Maxtor 6B160P0, ATA DISK drive
May 31 20:58:58 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 31 20:58:58 localhost kernel: Probing IDE interface ide1...
May 31 20:58:58 localhost kernel: hdc: PLEXTOR DVDR PX-716A, ATAPI CD/DVD=
-ROM drive
May 31 20:58:58 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 31 20:58:58 localhost kernel: Probing IDE interface ide2...
May 31 20:58:58 localhost kernel: Probing IDE interface ide3...
May 31 20:58:58 localhost kernel: Probing IDE interface ide4...
May 31 20:58:58 localhost kernel: Probing IDE interface ide5...
May 31 20:58:58 localhost kernel: hda: max request size: 1024KiB
May 31 20:58:58 localhost kernel: hda: 320173056 sectors (163928 MB) w/81=
92KiB Cache, CHS=3D19929/255/63, UDMA(100)
May 31 20:58:58 localhost kernel: hda: cache flushes supported
May 31 20:58:58 localhost kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 h=
da9 >
May 31 20:58:58 localhost kernel: ide-disk: probe of 1.0 failed with erro=
r 1
May 31 20:58:58 localhost kernel: hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW dr=
ive, 8192kB Cache, UDMA(66)
May 31 20:58:58 localhost kernel: Uniform CD-ROM driver Revision: 3.20
May 31 20:58:58 localhost kernel: usbmon: debugs is not available
May 31 20:58:58 localhost kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' =
Host Controller (OHCI) Driver (PCI)
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> =
GSI 18 (level, low) -> IRQ 16
May 31 20:58:58 localhost kernel: ohci_hcd 0000:00:13.0: OPTi Inc. 82C861
May 31 20:58:58 localhost kernel: ohci_hcd 0000:00:13.0: new USB bus regi=
stered, assigned bus number 1
May 31 20:58:58 localhost kernel: ohci_hcd 0000:00:13.0: irq 16, io mem 0=
xd9a02000
May 31 20:58:58 localhost kernel: hub 1-0:1.0: USB hub found
May 31 20:58:58 localhost kernel: hub 1-0:1.0: 2 ports detected
May 31 20:58:58 localhost kernel: USB Universal Host Controller Interface=
 driver v2.3
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKD] enabled=
 at IRQ 11
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:07.2[D] -> =
Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
May 31 20:58:58 localhost kernel: PCI: Via IRQ fixup for 0000:00:07.2, fr=
om 12 to 2
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.2: VIA Technologies=
, Inc. VT82xxxxx UHCI USB 1.1 Controller
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.2: new USB bus regi=
stered, assigned bus number 2
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.2: irq 18, io base =
0x0000b000
May 31 20:58:58 localhost kernel: hub 2-0:1.0: USB hub found
May 31 20:58:58 localhost kernel: hub 2-0:1.0: 2 ports detected
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:07.3[D] -> =
Link [LNKD] -> GSI 11 (level, low) -> IRQ 18
May 31 20:58:58 localhost kernel: PCI: Via IRQ fixup for 0000:00:07.3, fr=
om 12 to 2
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.3: VIA Technologies=
, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.3: new USB bus regi=
stered, assigned bus number 3
May 31 20:58:58 localhost kernel: uhci_hcd 0000:00:07.3: irq 18, io base =
0x0000b400
May 31 20:58:58 localhost kernel: hub 3-0:1.0: USB hub found
May 31 20:58:58 localhost kernel: hub 3-0:1.0: 2 ports detected
May 31 20:58:58 localhost kernel: usb 1-1: new low speed USB device using=
 ohci_hcd and address 2
May 31 20:58:58 localhost kernel: usbcore: registered new driver usblp
May 31 20:58:58 localhost kernel: drivers/usb/class/usblp.c: v0.13: USB P=
rinter Device Class driver
May 31 20:58:58 localhost kernel: Initializing USB Mass Storage driver...
May 31 20:58:58 localhost kernel: usbcore: registered new driver usb-stor=
age
May 31 20:58:58 localhost kernel: USB Mass Storage support registered.
May 31 20:58:58 localhost kernel: input: USB HID v1.10 Mouse [Logitech US=
B-PS/2 Optical Mouse] on usb-0000:00:13.0-1
May 31 20:58:58 localhost kernel: usbcore: registered new driver usbhid
May 31 20:58:58 localhost kernel: drivers/usb/input/hid-core.c: v2.01:USB=
 HID core driver
May 31 20:58:58 localhost kernel: mice: PS/2 mouse device common for all =
mice
May 31 20:58:58 localhost kernel: Advanced Linux Sound Architecture Drive=
r Version 1.0.9rc3  (Thu Mar 24 10:33:39 2005 UTC).
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled=
 at IRQ 10
May 31 20:58:58 localhost kernel: ACPI: PCI Interrupt 0000:00:07.5[C] -> =
Link [LNKC] -> GSI 10 (level, low) -> IRQ 19
May 31 20:58:58 localhost kernel: PCI: Via IRQ fixup for 0000:00:07.5, fr=
om 11 to 3
May 31 20:58:58 localhost kernel: PCI: Setting latency timer of device 00=
00:00:07.5 to 64
May 31 20:58:58 localhost kernel: input: AT Translated Set 2 keyboard on =
isa0060/serio0
May 31 20:58:58 localhost kernel: ALSA device list:
May 31 20:58:58 localhost kernel:   #0: VIA 82C686A/B rev50 with ALC200,2=
00P at 0xb800, irq 19
May 31 20:58:58 localhost kernel: NET: Registered protocol family 2
May 31 20:58:58 localhost kernel: IP: routing cache hash table of 2048 bu=
ckets, 32Kbytes
May 31 20:58:58 localhost kernel: TCP established hash table entries: 327=
68 (order: 7, 524288 bytes)
May 31 20:58:58 localhost kernel: TCP bind hash table entries: 32768 (ord=
er: 6, 393216 bytes)
May 31 20:58:58 localhost kernel: TCP: Hash tables configured (establishe=
d 32768 bind 32768)
May 31 20:58:58 localhost kernel: ip_conntrack version 2.1 (4095 buckets,=
 32760 max) - 212 bytes per conntrack
May 31 20:58:58 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core=
 team
May 31 20:58:58 localhost kernel: ipt_recent v0.3.2: Stephen Frost <sfros=
t@snowman.net>.  http://snowman.net/projects/ipt_recent/
May 31 20:58:58 localhost kernel: arp_tables: (C) 2002 David S. Miller
May 31 20:58:58 localhost kernel: NET: Registered protocol family 1
May 31 20:58:58 localhost kernel: NET: Registered protocol family 17
May 31 20:58:58 localhost kernel: NET: Registered protocol family 5
May 31 20:58:58 localhost kernel: Starting balanced_irq
May 31 20:58:58 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
May 31 20:58:58 localhost kernel: VFS: Mounted root (ext3 filesystem) rea=
donly.
May 31 20:58:58 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
May 31 20:58:58 localhost kernel: Freeing unused kernel memory: 240k free=
d
May 31 20:58:58 localhost kernel: Adding 1510068k swap on /dev/hda7.  Pri=
ority:-1 extents:1
May 31 20:58:58 localhost kernel: EXT3 FS on hda1, internal journal
May 31 20:58:58 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
May 31 20:58:58 localhost kernel: EXT3 FS on hda9, internal journal
May 31 20:58:58 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
May 31 20:58:58 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
May 31 20:58:58 localhost kernel: EXT3 FS on hda8, internal journal
May 31 20:58:58 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
May 31 20:58:58 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
May 31 20:58:58 localhost kernel: EXT3 FS on hda5, internal journal
May 31 20:58:58 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
May 31 20:58:58 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
May 31 20:58:58 localhost kernel: EXT3 FS on hda6, internal journal
May 31 20:58:58 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
May 31 20:58:58 localhost udev[3343]: removing device node '/dev/vcsa1'
May 31 20:58:58 localhost udev[3344]: removing device node '/dev/vcs1'
May 31 20:58:58 localhost udev[3361]: creating device node '/dev/vcsa1'
May 31 20:58:58 localhost udev[3367]: creating device node '/dev/vcs1'
May 31 20:58:58 localhost udev[3378]: removing device node '/dev/vcs1'
May 31 20:58:58 localhost udev[3386]: creating device node '/dev/vcs1'
May 31 20:59:04 localhost mysqld_safe[3781]: started
May 31 20:59:04 localhost mysqld[3785]: 050531 20:59:04  InnoDB: Started
May 31 20:59:04 localhost mysqld[3785]: /usr/sbin/mysqld: ready for conne=
ctions.
May 31 20:59:04 localhost mysqld[3785]: Version: '4.0.24_Debian-10-log'  =
socket: '/var/run/mysqld/mysqld.sock'  port: 3306  Source distribution
May 31 20:59:05 localhost /etc/mysql/debian-start[3822]: Checking for cra=
shed MySQL tables.
May 31 20:59:05 localhost atalkd[3838]: restart (2.0.2)
May 31 20:59:06 localhost atalkd[3838]: zip_getnetinfo for eth0
May 31 20:59:06 localhost smartd[3844]: smartd version 5.32 Copyright (C)=
 2002-4 Bruce Allen=20
May 31 20:59:06 localhost smartd[3844]: Home page is http://smartmontools=
.sourceforge.net/ =20
May 31 20:59:06 localhost smartd[3844]: Opened configuration file /etc/sm=
artd.conf=20
May 31 20:59:06 localhost smartd[3844]: Configuration file /etc/smartd.co=
nf parsed.=20
May 31 20:59:06 localhost smartd[3844]: Device: /dev/hda, opened=20
May 31 20:59:06 localhost smartd[3844]: Device: /dev/hda, not found in sm=
artd database.=20
May 31 20:59:07 localhost smartd[3844]: Device: /dev/hda, enabled SMART A=
ttribute Autosave.=20
May 31 20:59:07 localhost smartd[3844]: Device: /dev/hda, enabled SMART A=
utomatic Offline Testing.=20
May 31 20:59:07 localhost smartd[3844]: Device: /dev/hda, is SMART capabl=
e. Adding to "monitor" list.=20
May 31 20:59:07 localhost smartd[3844]: Monitoring 1 ATA and 0 SCSI devic=
es=20
May 31 20:59:07 localhost smartd[3847]: smartd has fork()ed into backgrou=
nd mode. New PID=3D3847.=20
May 31 20:59:07 localhost smartd[3847]: file /var/run/smartd.pid written =
containing PID 3847=20
May 31 20:59:08 localhost rpc.statd[3923]: Version 1.0.6 Starting
May 31 20:59:08 localhost rpc.statd[3923]: statd running as root. chown /=
var/lib/nfs/sm to choose different user=20
May 31 20:59:09 localhost /usr/sbin/cron[3961]: (CRON) INFO (pidfile fd =3D=
 3)
May 31 20:59:09 localhost /usr/sbin/cron[3965]: (CRON) STARTUP (fork ok)
May 31 20:59:09 localhost Xprt_64: No matching visual for __GLcontextMode=
 with visual class =3D 0 (32775), nplanes =3D 8
May 31 20:59:09 localhost /usr/sbin/cron[3965]: (CRON) INFO (Running @reb=
oot jobs)
May 31 20:59:11 localhost udev[3993]: creating device node '/dev/vcs2'
May 31 20:59:11 localhost udev[3998]: creating device node '/dev/vcsa3'
May 31 20:59:11 localhost udev[3996]: creating device node '/dev/vcs3'
May 31 20:59:11 localhost udev[3994]: creating device node '/dev/vcsa2'
May 31 20:59:11 localhost udev[4024]: creating device node '/dev/vcs4'
May 31 20:59:11 localhost udev[4026]: creating device node '/dev/vcsa4'
May 31 20:59:11 localhost udev[4031]: creating device node '/dev/vcs5'
May 31 20:59:11 localhost udev[4033]: creating device node '/dev/vcsa5'
May 31 20:59:11 localhost udev[4056]: creating device node '/dev/vcs7'
May 31 20:59:11 localhost udev[4053]: creating device node '/dev/vcsa6'
May 31 20:59:11 localhost udev[4038]: creating device node '/dev/vcs6'
May 31 20:59:11 localhost udev[4077]: creating device node '/dev/vcsa7'
May 31 20:59:11 localhost udev[4078]: removing device node '/dev/vcs5'
May 31 20:59:11 localhost udev[4110]: removing device node '/dev/vcsa6'
May 31 20:59:11 localhost udev[4112]: removing device node '/dev/vcsa4'
May 31 20:59:11 localhost udev[4126]: removing device node '/dev/vcs6'
May 31 20:59:11 localhost udev[4139]: removing device node '/dev/vcs3'
May 31 20:59:11 localhost udev[4138]: removing device node '/dev/vcsa5'
May 31 20:59:11 localhost udev[4149]: removing device node '/dev/vcs4'
May 31 20:59:11 localhost udev[4167]: removing device node '/dev/vcsa3'
May 31 20:59:11 localhost udev[4172]: creating device node '/dev/vcs6'
May 31 20:59:11 localhost udev[4188]: creating device node '/dev/vcsa6'
May 31 20:59:11 localhost udev[4187]: creating device node '/dev/vcsa4'
May 31 20:59:11 localhost udev[4206]: creating device node '/dev/vcsa5'
May 31 20:59:11 localhost udev[4203]: creating device node '/dev/vcs5'
May 31 20:59:11 localhost udev[4205]: creating device node '/dev/vcsa3'
May 31 20:59:11 localhost udev[4218]: creating device node '/dev/vcs4'
May 31 20:59:11 localhost udev[4240]: creating device node '/dev/vcs3'
May 31 20:59:16 localhost atalkd[3838]: zip_getnetinfo for eth0
May 31 20:59:26 localhost udev[4268]: creating device node '/dev/vcs8'
May 31 20:59:26 localhost udev[4270]: creating device node '/dev/vcsa8'
May 31 20:59:26 localhost udev[4290]: removing device node '/dev/vcsa8'
May 31 20:59:26 localhost udev[4289]: removing device node '/dev/vcs8'
May 31 20:59:26 localhost udev[4305]: creating device node '/dev/vcs8'
May 31 20:59:26 localhost udev[4307]: creating device node '/dev/vcsa8'
May 31 20:59:26 localhost atalkd[3838]: zip_getnetinfo for eth0
May 31 20:59:28 localhost hald[3415]: Timed out waiting for hotplug event=
 898. Rebasing to 914
May 31 20:59:36 localhost atalkd[3838]: config for no router
May 31 20:59:37 localhost atalkd[3838]: ready 0/0/0
May 31 20:59:39 localhost udev[4335]: creating device node '/dev/vcs9'
May 31 20:59:39 localhost udev[4336]: creating device node '/dev/vcsa9'
May 31 20:59:43 localhost kernel: [drm] Initialized drm 1.0.0 20040925
May 31 20:59:43 localhost kernel: ACPI: PCI Interrupt 0000:02:07.0[A] -> =
GSI 19 (level, low) -> IRQ 20
May 31 20:59:43 localhost kernel: [drm] Initialized radeon 1.16.0 2005031=
1 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
May 31 20:59:43 localhost udev[4383]: configured rule in '/etc/udev/rules=
.d/udev.rules[37]' applied, 'card0' becomes 'dri/%k'
May 31 20:59:43 localhost udev[4383]: creating device node '/dev/dri/card=
0'
May 31 20:59:43 localhost kernel: [drm] Loading R200 Microcode
May 31 20:59:49 localhost papd[4403]: restart (2.0.2)
May 31 20:59:49 localhost papd[4403]: CUPS support enabled (1.1)
May 31 20:59:49 localhost afpd[4405]: Registering CNID module [last]
May 31 20:59:49 localhost afpd[4405]: Registering CNID module [cdb]
May 31 20:59:49 localhost afpd[4405]: Registering CNID module [dbd]
May 31 20:59:49 localhost afpd[4405]: Loading ConfigFile
May 31 20:59:49 localhost afpd[4405]: Finished parsing Config File
May 31 20:59:55 localhost afpd[4405]: localhost:AFPServer@* started on 65=
280.221:128 (2.0.2)
May 31 20:59:55 localhost afpd[4405]: dsi_tcp: hostname 'linux-server' re=
solves to loopback address
May 31 20:59:55 localhost afpd[4405]: dsi_tcp: '192.168.1.2' on interface=
 'eth0' will be used instead.
May 31 20:59:55 localhost afpd[4405]: ASIP started on 192.168.1.2:548(5) =
(2.0.2)
May 31 20:59:55 localhost afpd[4405]: DSIConfigInit: Error registering af=
p://192.168.1.2/?NAME=3Dlocalhost&ZONE=3D with SRVLOC
May 31 20:59:55 localhost afpd[4405]: uam: loading (/usr/lib/netatalk/uam=
s_dhx.so)
May 31 20:59:55 localhost afpd[4405]: uam: uam not found (status=3D-1)
May 31 20:59:55 localhost afpd[4405]: uam: loading (/usr/lib/netatalk/uam=
s_clrtxt.so)
May 31 20:59:55 localhost afpd[4405]: uam: uams_clrtxt.so loaded
May 31 20:59:55 localhost afpd[4405]: uam: loading (/usr/lib/netatalk/uam=
s_randnum.so)
May 31 20:59:55 localhost afpd[4405]: uam: uam not found (status=3D-1)
May 31 20:59:55 localhost afpd[4405]: uam: "Cleartxt Passwrd" available
May 31 21:00:16 localhost gconfd (hannes-4484): (Version 2.8.1) wird gest=
artet, Prozesskennung 4484, Benutzer =BBhannes=AB
May 31 21:00:16 localhost gconfd (hannes-4484): Die Adresse =BBxml:readon=
ly:/etc/gconf/gconf.xml.mandatory=AB wurde an der Position 0 zu einer nur=
 lesbaren Konfigurationsquelle aufgel=F6st
May 31 21:00:16 localhost gconfd (hannes-4484): Die Adresse =BBxml:readwr=
ite:/home/hannes/.gconf=AB wurde an der Position 1 zu einer schreibbaren =
Konfigurationsquelle aufgel=F6st
May 31 21:00:16 localhost gconfd (hannes-4484): Die Adresse =BBxml:readon=
ly:/etc/gconf/gconf.xml.defaults=AB wurde an der Position 2 zu einer nur =
lesbaren Konfigurationsquelle aufgel=F6st
May 31 21:00:30 localhost gconfd (hannes-4484): Die Adresse =BBxml:readwr=
ite:/home/hannes/.gconf=AB wurde an der Position 0 zu einer schreibbaren =
Konfigurationsquelle aufgel=F6st

>> I've started xmms

May 31 21:01:28 localhost kernel: irq 20: nobody cared (try booting with =
the "irqpoll" option.
May 31 21:01:28 localhost kernel:  [<c014117a>] __report_bad_irq+0x2a/0xa=
0
May 31 21:01:28 localhost kernel:  [<c01409a0>] handle_IRQ_event+0x30/0x7=
0
May 31 21:01:28 localhost kernel:  [<c0141290>] note_interrupt+0x80/0xf0
May 31 21:01:28 localhost kernel:  [<c0140b1c>] __do_IRQ+0x13c/0x140
May 31 21:01:28 localhost kernel:  [<c0105969>] do_IRQ+0x19/0x30
May 31 21:01:28 localhost kernel:  [<c0103b62>] common_interrupt+0x1a/0x2=
0
May 31 21:01:28 localhost kernel:  [<c0100d70>] default_idle+0x0/0x30
May 31 21:01:28 localhost kernel:  [<c0100d93>] default_idle+0x23/0x30
May 31 21:01:28 localhost kernel:  [<c0100e60>] cpu_idle+0x80/0x90
May 31 21:01:28 localhost kernel:  [<c05189dd>] start_kernel+0x18d/0x1d0
May 31 21:01:28 localhost kernel:  [<c05183c0>] unknown_bootoption+0x0/0x=
1e0
May 31 21:01:28 localhost kernel: handlers:
May 31 21:01:28 localhost kernel: [<e0c56e20>] (radeon_driver_irq_handler=
+0x0/0xc0 [radeon])
May 31 21:01:28 localhost kernel: Disabling IRQ #20

>> I've stopped xmms

May 31 21:02:01 localhost kernel: Unable to handle kernel paging request =
at virtual address b587f060
May 31 21:02:01 localhost kernel:  printing eip:
May 31 21:02:01 localhost kernel: c03354d7
May 31 21:02:01 localhost kernel: *pde =3D 0c167067
May 31 21:02:01 localhost kernel: *pte =3D 00000000
May 31 21:02:01 localhost kernel: Oops: 0000 [#1]
May 31 21:02:01 localhost kernel: PREEMPT SMP=20
May 31 21:02:01 localhost kernel: Modules linked in: radeon drm
May 31 21:02:01 localhost kernel: CPU:    0
May 31 21:02:01 localhost kernel: EIP:    0060:[<c03354d7>]    Not tainte=
d VLI
May 31 21:02:01 localhost kernel: EFLAGS: 00210282   (2.6.12-rc5-mm1)=20
May 31 21:02:01 localhost kernel: EIP is at snd_pcm_mmap_data_close+0x7/0=
x12
May 31 21:02:01 localhost kernel: eax: b587f000   ebx: c03354d0   ecx: dd=
b03a20   edx: cc4897d0
May 31 21:02:01 localhost kernel: esi: dfb59ec4   edi: ddb03a20   ebp: cc=
489750   esp: cc1d3f40
May 31 21:02:01 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 31 21:02:01 localhost kernel: Process xmms (pid: 4650, threadinfo=3Dc=
c1d2000 task=3Dd518da30)
May 31 21:02:01 localhost kernel: Stack: c01542b6 cc489750 cc489778 dfb59=
e98 00000000 d878bcc0 cc489750 d878bcc0=20
May 31 21:02:01 localhost kernel:        c0155c2f cc489750 cc489750 b587f=
000 b586f000 c015604b d878bcc0 cc489750=20
May 31 21:02:01 localhost kernel:        cc4896f8 b586f000 b587f000 cc489=
6f8 d878bcc0 d878bcf0 00000002 cc1d2000=20
May 31 21:02:01 localhost kernel: Call Trace:
May 31 21:02:01 localhost kernel:  [<c01542b6>] remove_vm_struct+0x96/0xa=
0
May 31 21:02:01 localhost kernel:  [<c0155c2f>] unmap_vma_list+0x1f/0x30
May 31 21:02:01 localhost kernel:  [<c015604b>] do_munmap+0x11b/0x150
May 31 21:02:01 localhost kernel:  [<c01560c5>] sys_munmap+0x45/0x70
May 31 21:02:01 localhost kernel:  [<c01031a5>] syscall_call+0x7/0xb
May 31 21:02:01 localhost kernel: Code: 00 00 00 00 8b 44 24 04 8b 40 50 =
8b 40 60 f0 ff 80 a4 00 00 00 c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 0=
0 8b 44 24 04 8b 40 50 <8b> 40 60 f0 ff 88 a4 00 00 00 c3 51 52 e8 37 b8 =
0b 00 5a 59 e9=20

--=-w0/JahAwSBj7j61Llyv2--



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
