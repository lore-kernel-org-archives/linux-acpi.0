From: "Mark M." <maalox-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Subject: RE: acpi-20031203-2.6.0.diff brokes the battery status readings with
 2.6.0 in DELL Inspiron 8500
Date: Fri, 26 Dec 2003 18:33:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FECC541.10001@videotron.ca>
References: <E1Aa16k-00089f-Ft@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040001080101040606090300"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1Aa16k-00089f-Ft-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
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
--------------040001080101040606090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by deluge.cc.mcgill.ca id hBQNXaY8020101

I have the same problem with my Dell Inspiron 5150. Battery status AND=20
temperature reading stopped working when I upgraded from 2.6.0-test11-mm=20
to 2.6.0-mm1. I noticed it because klaptop stopped showing the battery=20
charge status, and gkrellm2 stopped showing the battery and temperature=20
status (stuck at 25C). Actually, the only thing that still works with=20
the battery is wether the AC is plugged in or not. Here is my /proc and=20
dmesg from 2.6.0-mm1. I can reboot and show you the working test11-mm=20
stuff as well, if needed.

root-2T+B9ReNDUQ@public.gmane.org maalox # cat /proc/acpi/thermal_zone/THM/temperature
temperature:             25 C

root-2T+B9ReNDUQ@public.gmane.org maalox # cat /proc/acpi/battery/BAT0/alarm
alarm:                   unsupported

root-2T+B9ReNDUQ@public.gmane.org maalox # cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:
serial number:
battery type:
OEM info:

root-2T+B9ReNDUQ@public.gmane.org maalox # cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mW
remaining capacity:      0 mWh
present voltage:         0 mV

All the 0 readings have actual numbers with test11-mm, as well as model=20
number, serial number, ...

Thanks,
Mark


From: Brown, Len <len-lUQJ9CVx3tM@public.gmane.org>
RE: acpi-20031203-2.6.0.diff brokes the battery status readings with=20
2.6.0 in DELL Inspiron 8500
2003-12-19 08:11

  dmesg from before and after would help, plus the info under=20
/proc/acpi/battery.

  Thanks,
  -Len

  > -----Original Message-----
  > From: acpi-devel-admin-I+uqrFQUvWk@public.gmane.org
  > [mailto:acpi-devel-admin-I+uqrFQUvWk@public.gmane.org] On Behalf Of
  > Pere Casta=F1er
  > Sent: Thursday, December 18, 2003 7:00 PM
  > To: acpi-devel
  > Subject: [ACPI] acpi-20031203-2.6.0.diff brokes the battery
  > status readings with 2.6.0 in DELL Inspiron 8500
  >
  >
  > I've just aplyied last patch into 2.6.0 stable release and it
  > brokes the battery monitor from acpi in
  > /proc/acpi/battery/BAT0/status...because of this
  > gnome-battery applet don't shows any information.
  >
  > Do you need more information?
  >
  > PS:with acpi included on 2.6.0 all works fine.

--------------040001080101040606090300
Content-Type: text/plain;
 name="dmesg"
Content-Disposition: inline;
 filename="dmesg"
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-mm1 (root-2T+B9ReNDUQ@public.gmane.org) (gcc version 3.3.2 20031201 (Gentoo Linux 3.3.2-r4, propolice)) #3 Fri Dec 26 02:58:15 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffcf800 (usable)
 BIOS-e820: 000000001ffcf800 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131023
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126927 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fdea0
ACPI: RSDT (v001 DELL    CPi R   0x27d30b03 ASL  0x00000061) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d30b03 ASL  0x00000061) @ 0x1fff0400
ACPI: MADT (v001 DELL    CPi R   0x27d30b03 ASL  0x00000047) @ 0x1fff0c00
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hdc7
current: c0400a60
current->thread_info: c0482000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3057.353 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514220k/524092k available (2642k kernel code, 9128k reserved, 948k data, 128k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 6045.69 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcf1e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031203
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
pnp: 00:01: ioport range 0x1000-0x105f has been reserved
pnp: 00:01: ioport range 0x1060-0x107f has been reserved
pnp: 00:01: ioport range 0x1080-0x10bf has been reserved
pnp: 00:01: ioport range 0x10c0-0x10ff has been reserved
pnp: 00:01: ioport range 0xf400-0xf4fe has been reserved
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] Initialized i830 1.3.2 20021108 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
b44.c:v0.92 (Nov 4, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0d:56:33:d4:af
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
hda: PHILIPS DVD+RW SDVD6004, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: FUJITSU MHT2040AT PL, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p4 < p5 p6 p7 >
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
cdrom: : unknown mrw mode page
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1045 $ Ben Collins <bcollins-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[faffb800-faffbfff]  Max Packet=[2048]
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem e0835c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0000bf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0000bf40
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0000bf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
i8042.c: Warning: Keylock active.
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[314fc0001f5a3061]
intel8x0_measure_ac97_clock: measured 49443 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801DB-ICH4 at 0xf4fff800, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc7) for (hdc7)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
Adding 506008k swap on /dev/hdc6.  Priority:-1 extents:1
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Thermal Zone [THM] (25 C)
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org)
ndiswrapper version 0.3 loaded
NTFS volume version 3.1.
Real Time Clock Driver v1.12
b44: eth0: Link is down.
eth1: power management not possible
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
nvidia: no version for "struct_module" found: kernel tainted.
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
cisco_ipsec: no version magic, tainting kernel.
cisco_ipsec: module license 'Proprietary' taints kernel.
Cisco Systems VPN Client Version 4.0.1 (A) kernel module loaded
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes

--------------040001080101040606090300--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
