From: Claudio Miranda <claudio-t9N6cZjhxLQ39yzSjRtAkw@public.gmane.org>
Subject: Mouse issues with ACPI under Dell C600 (Kernel 2.6.7)
Date: Fri, 25 Jun 2004 10:47:16 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DC2CE4.8000209@claudius.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010106050709090402060508"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010106050709090402060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Does this mailing list is right for ask the question below ?

My system:
- Dell C600 Laptop with BIOS upgrade A23 (latest)
- Kernel 2.6.7 (without patches)
- XFree86 4.3
- ACPI turned on
/boot/grub/menu.lst (just the kernel default)
kernel (hd0,5)/boot/vmlinuz-2.6.7 root=/dev/hda6 noapic devfs=mount
acpi=on resume=/dev/hda5 vga=791

	Attached is the dmesg output, and the lines of /var/log/messages
related to the issue (mess file)


    When the system is turned on from the power off state, everything
works fine.
     If I do a "echo 4 > /proc/acpi/sleep" (suspend to disk), the system
goes to hibernate. Ok again.
     But when the system is turned on again, the external USB mouse
doesn't works.
      Before the system goes to hibernate, I had a look to /dev/input/ and
there are: /dev/input/mice /dev/input/mouse0 and /dev/input/mouse1
/dev/input/mouse2, when the system come back from hibernate, /dev/input
reports /dev/input/mouse0 /dev/input/mouse1 and /dev/input/mice and the
USB mouse doesn't works. Even if I switch to tty1 (ctrl  F1) and unplug
/ plug the usb mouse doesn't works.

	Can you suggest something ? Is it a issue for: Dell BIOS, Linux Kernel,
XFree86, ACPI code ?

Thank you very much

- Claudio Miranda



--------------010106050709090402060508
Content-Type: text/plain;
 name="dmesg1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg1"

Linux version 2.6.7 (root-kxyRmgnf7stQFI55V6+gNQ@public.gmane.org) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #1 Fri Jun 18 17:41:04 BRT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffdb000 (usable)
 BIOS-e820: 000000001ffdb000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131035
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126939 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Dell Latitude C600 machine detected. Mousepad Resume Bug workaround hopefully not needed.
Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
ACPI: RSDP (v000 DELL                                      ) @ 0x000f4c00
ACPI: RSDT (v001 DELL    CPi R   0x27d30708 ASL  0x00000061) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d30708 ASL  0x00000061) @ 0x1fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: root=/dev/hda6 noapic devfs=mount acpi=on resume=/dev/hda5 vga=791
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 601.464 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 515332k/524140k available (2456k kernel code, 8064k reserved, 954k data, 256k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1191.93 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfc13e, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PADA] (on)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
vesafb: framebuffer at 0xf8000000, mapped to 0xe0807000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:6294
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
IA-32 Microcode Update Driver: v1.13 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
devfs: 2004-01-31 Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:10.0: 3Com PCI 3c556 Laptop Tornado at 0xd400. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124 (blacklisted)
ide1 at 0x170-0x177,0x376 on irq 15
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.5
 180 degree mounted touchpad
 Sensor: 27
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ALSA device list:
  #0: ESS Maestro3 PCI at 0xd800, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hda5
Resuming from device hda5
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 256k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 11, io base 0000dce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
EXT3 FS on hda6, internal journal
input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:07.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 523616k swap on /dev/hda5.  Priority:-1 extents:1
NET: Registered protocol family 17
Bluetooth: Core ver 2.5
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
mtrr: 0xf8000000,0x800000 overlaps existing 0xf8000000,0x200000
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
eth0: Setting full-duplex based on MII #0 link partner capability of 01e1.
Stopping tasks: =========================================================
 stopping tasks failed (1 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, mysqld not stopped
 done
Stopping tasks: ==========================================================
 stopping tasks failed (1 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, mysqld not stopped
 done
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
Stopping tasks: =================================================|
Freeing memory: .......|
/critical section: counting pages to copy..[nosave pfn 0x450][nosave pfn 0x451]............................ (pages needed: 9632+512=10144 free: 121401)
Alloc pagedir
..[nosave pfn 0x450][nosave pfn 0x451]Freeing prev allocated pagedir
done, devices
hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124 (blacklisted)
Fixing swap signatures... ok
Restarting tasks... done
usb 1-1: USB disconnect, address 2
usb 1-1: new low speed USB device using address 3
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 3, error -110
usb 1-1: new low speed USB device using address 4
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 4, error -110



--------------010106050709090402060508
Content-Type: text/plain;
 name="mess"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mess"

Jun 23 09:13:18 demolidor kernel: Stopping tasks: =================================================|
Jun 23 09:13:18 demolidor kernel: Freeing memory: .......|
Jun 23 09:13:18 demolidor kernel: /critical section: counting pages to copy..[nosave pfn 0x450][nosave pfn 0x45
1]............................ (pages needed: 9632+512=10144 free: 121401)
Jun 23 09:13:18 demolidor kernel: Alloc pagedir
Jun 23 09:13:18 demolidor kernel: ..[nosave pfn 0x450][nosave pfn 0x451]Freeing prev allocated pagedir
Jun 23 09:13:18 demolidor kernel: done, devices
Jun 23 09:13:18 demolidor kernel: hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124 (blacklisted)
Jun 23 09:13:18 demolidor kernel: Fixing swap signatures... ok
Jun 23 09:13:18 demolidor kernel: Restarting tasks... done
Jun 23 09:13:19 demolidor ifplugd(eth0)[1179]: Link beat detected.
Jun 23 09:13:20 demolidor ifplugd(eth0)[1179]: Executing '/etc/ifplugd/ifplugd.action eth0 up'.
Jun 23 09:13:40 demolidor ifplugd(eth0)[1179]: Program executed successfully.
Jun 23 09:16:19 demolidor kernel: usb 1-1: USB disconnect, address 2
Jun 23 09:16:33 demolidor sudo:  claudio : TTY=pts/3 ; PWD=/home/claudio ; USER=root ; COMMAND=/etc/init.d/hotp
lug start
Jun 23 09:16:36 demolidor usb.agent[3044]: ... no modules for USB product 0/0/0
Jun 23 09:17:09 demolidor kernel: usb 1-1: new low speed USB device using address 3
Jun 23 09:17:14 demolidor kernel: usb 1-1: control timeout on ep0out
Jun 23 09:17:19 demolidor kernel: usb 1-1: control timeout on ep0out
Jun 23 09:17:20 demolidor kernel: usb 1-1: device not accepting address 3, error -110
Jun 23 09:17:20 demolidor kernel: usb 1-1: new low speed USB device using address 4
Jun 23 09:17:25 demolidor kernel: usb 1-1: control timeout on ep0out
Jun 23 09:17:30 demolidor kernel: usb 1-1: control timeout on ep0out
Jun 23 09:17:30 demolidor kernel: usb 1-1: device not accepting address 4, error -110
Jun 23 10:21:35 demolidor kernel: usb 1-1: new low speed USB device using address 5
Jun 23 10:21:40 demolidor kernel: usb 1-1: control timeout on ep0out
Jun 23 10:22:13 demolidor login(pam_unix)[1375]: session closed for user claudio
Jun 23 10:23:20 demolidor kernel: usb 1-1: device not accepting address 5, error -71



--------------010106050709090402060508--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
