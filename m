From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Compaq evo n800c and instant reboots
Date: 23 Feb 2004 06:09:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87smh2755l.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

I've enjoyed working ACPI up untill about 2.6.0-something, and after
that I cannot even run the battery gauge in Gnome; the machine will
instantly reboot as soon as it reads the battery state. How do I go
about finding what causes the crash, as it is instant reboot when I
test it?

Attached is .config and dmesg output:


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=config.gz
Content-Transfer-Encoding: base64

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
en0+hgAA
--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.3-mm2 (alexh-XxaQISg1LpM@public.gmane.org) (gcc version 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #3 Sat Feb 21 11:24:22 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002ffd0000 (usable)
 BIOS-e820: 000000002ffd0000 - 000000002fff0c00 (reserved)
 BIOS-e820: 000000002fff0c00 - 000000002fffc000 (ACPI NVS)
 BIOS-e820: 000000002fffc000 - 0000000030000000 (reserved)
767MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 196560
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192464 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f9970
ACPI: RSDT (v001 COMPAQ CPQ004A  0x30040320 CPQ  0x00000001) @ 0x2fff0c84
ACPI: FADT (v002 COMPAQ CPQ004A  0x00000002 CPQ  0x00000001) @ 0x2fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000d) @ 0x2fff65d4
ACPI: SSDT (v001 COMPAQ   CPQMag 0x00001001 MSFT 0x0100000d) @ 0x2fff66e2
ACPI: DSDT (v001 COMPAQ  EVON800 0x00010000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: root=/dev/hda3 ro elevator=cfq
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1694.860 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 775108k/786240k available (1520k kernel code, 10384k reserved, 705k data, 128k init, 0k highmem)
Calibrating delay loop... 3342.33 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040211
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C03C] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C03C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C03D._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03C.C04E._PRT]
ACPI: Embedded Controller [C0D0] (gpe 29)
ACPI: Power Resource [C141] (off)
ACPI: Power Resource [C155] (off)
ACPI: Power Resource [C159] (off)
ACPI: Power Resource [C15D] (off)
ACPI: Power Resource [C166] (on)
ACPI: PCI Interrupt Link [C0B6] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0B7] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0B8] (IRQs 5 10 11)
ACPI: PCI Interrupt Link [C0B9] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [C0BB] (IRQs)
ACPI: PCI Interrupt Link [C0BC] (IRQs)
ACPI: PCI Interrupt Link [C0BD] (IRQs)
ACPI: Power Resource [C0CF] (on)
ACPI: Power Resource [C1D5] (off)
ACPI: Power Resource [C1D6] (off)
ACPI: Power Resource [C1D7] (off)
ACPI: Power Resource [C1D8] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f3d30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x3d5e, dseg 0xf0000
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
ACPI: PCI Interrupt Link [C0B8] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0B7] enabled at IRQ 5
ACPI: PCI Interrupt Link [C0B6] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0B9] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 0 of device 0000:02:0e.2
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ACPI: AC Adapter [C11B] (on-line)
ACPI: Battery Slot [C11D] (battery present)
ACPI: Battery Slot [C11C] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C11F]
ACPI: Lid Switch [C11E]
ACPI: Fan [C1D9] (off)
ACPI: Fan [C1DA] (off)
ACPI: Fan [C1DB] (off)
ACPI: Fan [C1DC] (off)
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (49 C)
ACPI: Thermal Zone [TZ2] (44 C)
ACPI: Thermal Zone [TZ3] (16 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK6022GAX, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 51
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: Synaptics pass-through port at isa0060/serio4/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
BIOS EDD facility v0.12 2004-Jan-26, 1 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
ACPI: (supports S0 S3 S4 S4bios S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
NET: Registered protocol family 1
Adding 317512k swap on /dev/hda4.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 58474 usecs
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 256M @ 0xa0000000
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=1)
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:06.0 [0e11:004a]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x00d8, PCI irq 11
Socket status: 30000006
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw-5bpFXmC1L3aJ4eUNlOKu3Q@public.gmane.org> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:08:02:63:41:CB, IRQ 10.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:02:0e.0: OHCI Host Controller
ohci_hcd 0000:02:0e.0: irq 10, pci mem f093c000
ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:02:0e.1: OHCI Host Controller
ohci_hcd 0000:02:0e.1: irq 10, pci mem f093e000
ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ehci_hcd 0000:02:0e.2: EHCI Host Controller
ehci_hcd 0000:02:0e.2: irq 10, pci mem f0940400
ehci_hcd 0000:02:0e.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:02:0e.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02f9580(lo)
IPv6 over IPv4 tunneling driver
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 10471 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Radeon LW Mobility 7500 M7
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
/dev/vmnet: open called by PID 10986 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 11006 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
vmnet1: no IPv6 routers present
/dev/vmnet: open called by PID 11392 (vmware-vmx)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 11392 (vmware-vmx)
bridge-eth0: set IFF_PROMISC
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: clear IFF_PROMISC

--=-=-=


I know the dmesg output shows I'm running VMWare, but that makes
no difference at all, it reboots just as nice without.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy

--=-=-=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
