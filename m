From: maximilian attems <max-Aga/KQc5HWxW3WIO4DnKWw@public.gmane.org>
Subject: acpi support questions on gericom webgine laptop
Date: Fri, 14 Nov 2003 20:39:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031114193931.GA1168@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello acpi developpers,

without acpi before 2.4.20 this laptop did not switch off
by himself after shutdown, and there was no indication of
the remaining capacity of its battery,
when compiling with CONFIG_ACPI_RELAXED_AML
acpi -V  even outputs the Thermal temperature
in short acpi support for this laptop is a _real_ gain  :)

whithout CONFIG_ACPI_RELAXED_AML dmesg states:
 ACPI-1120: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node c151=
0240), AE_AML_REGION_LIMIT

 CONFIG_ACPI_DEBUG for details is recommended in dmesg:
 *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG =
for details.

i hope the output below helps for any further developpment
and enhancement of the acpi support of his laptop,
i'll test any recommanded patches?
the original DSDT seems broken or?
what does the "apm: BIOS not found." in dmesg mean,
when dmidecode says "APM is supported"?

i mantain a suuport site for debian on this laptop,
any further recommandations are highly welcome:
http://www.sternwelten.at/~maks/webgine_debian.htm

regards
maximilian



-- grep ACPI /boot/config-2.6.0-test9-mm3.031113

# Power management options (ACPI, APM)
# ACPI (Advanced Configuration and Power Interface) Support
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_ACPI_RELAXED_AML=3Dy
# CONFIG_HOTPLUG_PCI_ACPI is not set


-- syslog output

Nov 14 18:52:19 sputnik syslog-ng[205]: syslog-ng version 1.6.0rc1 starting
Nov 14 18:52:19 sputnik syslog-ng[205]: Changing permissions on special fil=
e /dev/xconsole
Nov 14 18:52:19 sputnik kernel: Linux version 2.6.0-test9-mm3.031113 (root@=
sputnik) (gcc version 3.3.2 (Debian)) #1 Thu Nov 13 22:46:38 CET 2003
Nov 14 18:52:19 sputnik kernel: BIOS-provided physical RAM map:
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 0000000000000000 - 000000000009f=
c00 (usable)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 000000000009fc00 - 00000000000a0=
000 (reserved)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 00000000000e8000 - 0000000000100=
000 (reserved)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 0000000000100000 - 000000001f7f0=
000 (usable)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 000000001f7f0000 - 000000001f7f8=
000 (ACPI data)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 000000001f7f8000 - 000000001f800=
000 (ACPI NVS)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 00000000ffef0000 - 00000000fff00=
000 (reserved)
Nov 14 18:52:19 sputnik kernel: BIOS-e820: 00000000ffff0000 - 0000000100000=
000 (reserved)
Nov 14 18:52:19 sputnik kernel: 503MB LOWMEM available.
Nov 14 18:52:19 sputnik kernel: On node 0 totalpages: 129008
Nov 14 18:52:19 sputnik kernel: DMA zone: 4096 pages, LIFO batch:1
Nov 14 18:52:19 sputnik kernel: Normal zone: 124912 pages, LIFO batch:16
Nov 14 18:52:19 sputnik kernel: HighMem zone: 0 pages, LIFO batch:1
Nov 14 18:52:19 sputnik kernel: DMI 2.3 present.
Nov 14 18:52:19 sputnik kernel: ACPI: RSDP (v000 AMI                       =
                ) @ 0x000fc740
Nov 14 18:52:19 sputnik kernel: ACPI: RSDT (v001 AMIINT AMIINT09 0x00001000=
 MSFT 0x0100000b) @ 0x1f7f0000
Nov 14 18:52:19 sputnik kernel: ACPI: FADT (v001 AMIINT AMIINT09 0x00001000=
 MSFT 0x0100000b) @ 0x1f7f0030
Nov 14 18:52:19 sputnik kernel: ACPI: DSDT (v001    SiS      630 0x00001000=
 MSFT 0x0100000d) @ 0x00000000
Nov 14 18:52:19 sputnik kernel: Building zonelist for node : 0
Nov 14 18:52:19 sputnik kernel: Kernel command line: auto BOOT_IMAGE=3DLinu=
x.2.6-mm3 ro root=3D303 video=3Dsisfb:mode:1024x768x16,rate:75,mem:12288 ac=
pi=3Dforce psmouse_noext=3D1
Nov 14 18:52:19 sputnik kernel: sisfb: Options mode:1024x768x16,rate:75,mem=
:12288
Nov 14 18:52:19 sputnik kernel: Local APIC disabled by BIOS -- reenabling.
Nov 14 18:52:19 sputnik kernel: Found and enabled local APIC!
Nov 14 18:52:19 sputnik kernel: current: c031ca60
Nov 14 18:52:19 sputnik kernel: current->thread_info: c0382000
Nov 14 18:52:19 sputnik kernel: Initializing CPU#0
Nov 14 18:52:19 sputnik kernel: PID hash table entries: 2048 (order 11: 163=
84 bytes)
Nov 14 18:52:19 sputnik kernel: Detected 1097.324 MHz processor.
Nov 14 18:52:19 sputnik kernel: Using tsc for high-res timesource
Nov 14 18:52:19 sputnik kernel: Console: colour VGA+ 80x25
Nov 14 18:52:19 sputnik kernel: Memory: 507216k/516032k available (1835k ke=
rnel code, 8048k reserved, 730k data, 152k init, 0k highmem)
Nov 14 18:52:19 sputnik kernel: zapping low mappings.
Nov 14 18:52:19 sputnik kernel: Calibrating delay loop... 2170.88 BogoMIPS
Nov 14 18:52:19 sputnik kernel: Dentry cache hash table entries: 65536 (ord=
er: 6, 262144 bytes)
Nov 14 18:52:19 sputnik kernel: Inode-cache hash table entries: 32768 (orde=
r: 5, 131072 bytes)
Nov 14 18:52:19 sputnik kernel: Mount-cache hash table entries: 512 (order:=
 0, 4096 bytes)
Nov 14 18:52:19 sputnik kernel: CPU:     After generic identify, caps: 0383=
fbff 00000000 00000000 00000000
Nov 14 18:52:19 sputnik kernel: CPU:     After vendor identify, caps: 0383f=
bff 00000000 00000000 00000000
Nov 14 18:52:19 sputnik kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 14 18:52:19 sputnik kernel: CPU: L2 cache: 256K
Nov 14 18:52:19 sputnik kernel: CPU:     After all inits, caps: 0383fbff 00=
000000 00000000 00000040
Nov 14 18:52:19 sputnik kernel: CPU: Intel Pentium III (Coppermine) steppin=
g 0a
Nov 14 18:52:19 sputnik kernel: Enabling fast FPU save and restore... done.
Nov 14 18:52:19 sputnik kernel: Enabling unmasked SIMD FPU exception suppor=
t... done.
Nov 14 18:52:19 sputnik kernel: Checking 'hlt' instruction... OK.
Nov 14 18:52:19 sputnik kernel: POSIX conformance testing by UNIFIX
Nov 14 18:52:19 sputnik kernel: enabled ExtINT on CPU#0
Nov 14 18:52:19 sputnik kernel: ESR value before enabling vector: 00000000
Nov 14 18:52:19 sputnik kernel: ESR value after enabling vector: 00000000
Nov 14 18:52:19 sputnik kernel: Using local APIC timer interrupts.
Nov 14 18:52:19 sputnik kernel: calibrating APIC timer ...
Nov 14 18:52:19 sputnik kernel: ..... CPU clock speed is 1097.0112 MHz.
Nov 14 18:52:19 sputnik kernel: ..... host bus clock speed is 99.0737 MHz.
Nov 14 18:52:19 sputnik kernel: NET: Registered protocol family 16
Nov 14 18:52:19 sputnik kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb3=
1, last bus=3D1
Nov 14 18:52:19 sputnik kernel: PCI: Using configuration type 1
Nov 14 18:52:19 sputnik kernel: mtrr: v2.0 (20020519)
Nov 14 18:52:19 sputnik kernel: ACPI: Subsystem revision 20031002
Nov 14 18:52:19 sputnik kernel: tbxface-0117 [03] acpi_load_tables      : A=
CPI Tables successfully acquired
Nov 14 18:52:19 sputnik kernel: Parsing all Control Methods:...............=
=2E........................................................................=
=2E......................................
Nov 14 18:52:19 sputnik kernel: Table [DSDT](id F004) - 411 Objects with 36=
 Devices 127 Methods 20 Regions
Nov 14 18:52:19 sputnik kernel: ACPI Namespace successfully loaded at root =
c03bf7fc
Nov 14 18:52:19 sputnik kernel: evxfevnt-0093 [04] acpi_enable           : =
Transition to ACPI mode successful
Nov 14 18:52:19 sputnik kernel: evgpeblk-0748 [06] ev_create_gpe_block   : =
GPE 00 to 15 [_GPE] 2 regs at 0000000000005020 on int 9
Nov 14 18:52:19 sputnik kernel: evgpeblk-0748 [06] ev_create_gpe_block   : =
GPE 16 to 31 [_GPE] 2 regs at 0000000000005030 on int 9
Nov 14 18:52:19 sputnik kernel: Completing Region/Field/Buffer/Package init=
ialization:................................................................=
=2E...
Nov 14 18:52:19 sputnik kernel: Initialized 20/20 Regions 0/0 Fields 29/29 =
Buffers 19/19 Packages (419 nodes)
Nov 14 18:52:19 sputnik kernel: Executing all Device _STA and_INI methods:.=
=2E...................................
Nov 14 18:52:19 sputnik kernel: 37 Devices found containing: 37 _STA, 1 _IN=
I methods
Nov 14 18:52:19 sputnik kernel: ACPI: Interpreter enabled
Nov 14 18:52:19 sputnik kernel: ACPI: Using PIC for interrupt routing
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov 14 18:52:19 sputnik kernel: PCI: Probing PCI hardware (bus 00)
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PC=
I0._PRT]
Nov 14 18:52:19 sputnik kernel: ACPI: Embedded Controller [EC0] (gpe 11)
Nov 14 18:52:19 sputnik kernel: ACPI: Power Resource [FDDP] (off)
Nov 14 18:52:19 sputnik kernel: ACPI: Power Resource [LPTP] (off)
Nov 14 18:52:19 sputnik kernel: ACPI: Power Resource [URP2] (off)
Nov 14 18:52:19 sputnik kernel: ACPI: Power Resource [URP1] (off)
Nov 14 18:52:19 sputnik kernel: pci_link-0262 [10] acpi_pci_link_get_curr: =
No IRQ resource found
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 4 6 7=
 11 12 14 15)
Nov 14 18:52:19 sputnik kernel: pci_link-0262 [13] acpi_pci_link_get_curr: =
No IRQ resource found
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 6 7 1=
0 12 14 15)
Nov 14 18:52:19 sputnik kernel: pci_link-0262 [16] acpi_pci_link_get_curr: =
No IRQ resource found
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 11)
Nov 14 18:52:19 sputnik kernel: ACPI: Power Resource [FN10] (on)
Nov 14 18:52:19 sputnik kernel: Linux Kernel Card Services
Nov 14 18:52:19 sputnik kernel: options:  [pci] [cardbus] [pm]
Nov 14 18:52:19 sputnik kernel: drivers/usb/core/usb.c: registered new driv=
er usbfs
Nov 14 18:52:19 sputnik kernel: drivers/usb/core/usb.c: registered new driv=
er hub
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKC] enabled at =
IRQ 10
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKD] enabled at =
IRQ 11
Nov 14 18:52:19 sputnik kernel: ACPI: PCI Interrupt Link [LNKB] enabled at =
IRQ 11
Nov 14 18:52:19 sputnik kernel: PCI: Using ACPI for IRQ routing
Nov 14 18:52:19 sputnik kernel: PCI: if you experience problems, try using =
option 'pci=3Dnoacpi' or even 'acpi=3Doff'
Nov 14 18:52:19 sputnik kernel: sisfb: Video ROM found and mapped to c00c00=
00
Nov 14 18:52:19 sputnik kernel: sisfb: Framebuffer at 0xd0000000, mapped to=
 0xe000e000, size 8192k
Nov 14 18:52:19 sputnik kernel: sisfb: MMIO at 0xdfee0000, mapped to 0xe080=
f000, size 128k
Nov 14 18:52:19 sputnik kernel: sisfb: Memory heap starting at 4096K
Nov 14 18:52:19 sputnik kernel: sisfb: LVDS transmitter and Chrontel TV enc=
oder detected
Nov 14 18:52:19 sputnik kernel: sisfb: Detected LCD PanelDelayCompensation =
32
Nov 14 18:52:19 sputnik kernel: sisfb: Default mode is 1024x768x16 (75Hz)
Nov 14 18:52:19 sputnik kernel: sisfb: Added MTRRs
Nov 14 18:52:19 sputnik kernel: sisfb: Installed SISFB_GET_INFO ioctl (8004=
6ef8)
Nov 14 18:52:19 sputnik kernel: sisfb: 2D acceleration is enabled, scrollin=
g mode ypan
Nov 14 18:52:19 sputnik kernel: fb0: SIS 630/730 VGA frame buffer device, V=
ersion 1.6.01
Nov 14 18:52:19 sputnik kernel: apm: BIOS not found.
Nov 14 18:52:19 sputnik kernel: Initializing Cryptographic API
Nov 14 18:52:19 sputnik kernel: ACPI: AC Adapter [AC0] (on-line)
Nov 14 18:52:19 sputnik kernel: ACPI: Battery Slot [BAT0] (battery present)
Nov 14 18:52:19 sputnik kernel: ACPI: Lid Switch [LIDD]
Nov 14 18:52:19 sputnik kernel: ACPI: Sleep Button (CM) [SLPB]
Nov 14 18:52:19 sputnik kernel: ACPI: Power Button (CM) [PWRB]
Nov 14 18:52:19 sputnik kernel: ACPI: Fan [FAN1] (off)
Nov 14 18:52:19 sputnik kernel: ACPI: Processor [CPU1] (supports C1 C2, 8 t=
hrottling states)
Nov 14 18:52:19 sputnik kernel: exfldio-0153 [40] ex_setup_region       : F=
ield [TMPS] Base+Offset+Width 4+0+4 is beyond end of region [M4D0] (length =
6)
Nov 14 18:52:19 sputnik kernel: exfldio-0178: *** Warning: The ACPI AML in =
your computer contains errors, please nag the manufacturer to correct it.
Nov 14 18:52:19 sputnik kernel: exfldio-0153 [40] ex_setup_region       : F=
ield [TMPS] Base+Offset+Width 4+0+4 is beyond end of region [M4D0] (length =
6)
Nov 14 18:52:19 sputnik kernel: ACPI: Thermal Zone [THRM] (31 C)
Nov 14 18:52:19 sputnik kernel: pty: 256 Unix98 ptys configured
Nov 14 18:52:19 sputnik kernel: Linux agpgart interface v0.100 (c) Dave Jon=
es
Nov 14 18:52:19 sputnik kernel: agpgart: Detected SiS 630 chipset
Nov 14 18:52:19 sputnik kernel: agpgart: Maximum main memory to use for agp=
 memory: 431M
Nov 14 18:52:19 sputnik kernel: agpgart: AGP aperture is 64M @ 0xe0000000
Nov 14 18:52:19 sputnik kernel: [drm] Initialized sis 1.1.0 20030826 on min=
or 0
Nov 14 18:52:19 sputnik kernel: Uniform Multi-Platform E-IDE driver Revisio=
n: 7.00alpha2
Nov 14 18:52:19 sputnik kernel: ide: Assuming 33MHz system bus speed for PI=
O modes; override with idebus=3Dxx
Nov 14 18:52:19 sputnik kernel: SIS5513: IDE controller at PCI slot 0000:00=
:00.1
Nov 14 18:52:19 sputnik kernel: SIS5513: chipset revision 208
Nov 14 18:52:19 sputnik kernel: SIS5513: not 100% native mode: will probe i=
rqs later
Nov 14 18:52:19 sputnik kernel: SIS5513: SiS630 ATA 100 (1st gen) controller
Nov 14 18:52:19 sputnik kernel: ide0: BM-DMA at 0xff00-0xff07, BIOS setting=
s: hda:DMA, hdb:DMA
Nov 14 18:52:19 sputnik kernel: ide1: BM-DMA at 0xff08-0xff0f, BIOS setting=
s: hdc:DMA, hdd:DMA
Nov 14 18:52:19 sputnik kernel: hda: TOSHIBA MK3017GAP, ATA DISK drive
Nov 14 18:52:19 sputnik kernel: Using anticipatory io scheduler
Nov 14 18:52:19 sputnik kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 14 18:52:19 sputnik kernel: hdc: UJDA710, ATAPI CD/DVD-ROM drive
Nov 14 18:52:19 sputnik kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 14 18:52:19 sputnik kernel: hda: max request size: 128KiB
Nov 14 18:52:19 sputnik kernel: hda: 58605120 sectors (30005 MB), CHS=3D581=
40/16/63
Nov 14 18:52:19 sputnik kernel: hda: hda1 hda2 hda3 hda4
Nov 14 18:52:19 sputnik kernel: Yenta: CardBus bridge found at 0000:00:03.0=
 [1584:3000]
Nov 14 18:52:19 sputnik kernel: Yenta: ISA IRQ list 00b8, PCI irq11
Nov 14 18:52:19 sputnik kernel: Socket status: 30000007
Nov 14 18:52:19 sputnik kernel: Intel PCIC probe: not found.
Nov 14 18:52:19 sputnik kernel: mice: PS/2 mouse device common for all mice
Nov 14 18:52:19 sputnik kernel: i8042.c: Detected active multiplexing contr=
oller, rev 1.0.
Nov 14 18:52:19 sputnik kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Nov 14 18:52:19 sputnik kernel: input: PS/2 Generic Mouse on isa0060/serio2
Nov 14 18:52:19 sputnik kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Nov 14 18:52:19 sputnik kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Nov 14 18:52:19 sputnik kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Nov 14 18:52:19 sputnik kernel: input: AT Translated Set 2 keyboard on isa0=
060/serio0
Nov 14 18:52:19 sputnik kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 14 18:52:19 sputnik kernel: NET: Registered protocol family 2
Nov 14 18:52:19 sputnik kernel: IP: routing cache hash table of 4096 bucket=
s, 32Kbytes
Nov 14 18:52:19 sputnik kernel: TCP: Hash tables configured (established 32=
768 bind 65536)
Nov 14 18:52:19 sputnik kernel: NET: Registered protocol family 1
Nov 14 18:52:19 sputnik kernel: NET: Registered protocol family 17
Nov 14 18:52:19 sputnik kernel: PM: Reading pmdisk image.
Nov 14 18:52:19 sputnik kernel: ACPI: (supports S0 S1 S4 S5)


-- dmidecode

# dmidecode 2.3
SMBIOS 2.3 present.
24 structures occupying 1677 bytes.
Table at 0x000F0610.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: American Megatrends Inc.       =20
		Version: 062710                         =20
		Release Date: 07/15/97                       =20
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 256 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
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
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Gericom                        =20
		Product Name: 1AAJG                          =20
		Version: 1.0                            =20
		Serial Number: 00000000                       =20
		UUID: Not Settable
		Wake-up Type: Modem Ring
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: American Megatrends Inc.       =20
		Product Name: 340S8                          =20
		Version: 1.0                            =20
		Serial Number: 00000000                       =20
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Uknown Chassis Manufacture     =20
		Type: Desktop
		Lock: Not Present
		Version: Version 1.00                   =20
		Serial Number: 123456890                      =20
		Asset Tag: 0123ABC                        =20
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 32 bytes.
	Processor Information
		Socket Designation: Socket 370                     =20
		Type: Central Processor
		Family: Other
		Manufacturer: Intel                          =20
		ID: 8A 06 00 00 55 00 00 00
		Version: Pentium III                    =20
		Voltage: 3.3 V 2.9 V
		External Clock: 100 MHz
		Max Speed: 1000 MHz
		Current Speed: 1100 MHz
		Status: Populated, Enabled
		Upgrade: 370-pin Socket
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: Not Provided
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal Cache                 =20
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: None
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal Cache                 =20
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 256 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: None
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0007
	DMI type 5, 20 bytes.
	Memory Controller Information
		Error Detecting Method: 32-bit ECC
		Error Correcting Capabilities:
			Single-bit Error Correcting
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 512 MB
		Maximum Total Memory Size: 1024 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			Standard
			FPM
			EDO
			Parity
			ECC
			SIMM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 2
			0x0008
			0x0009
		Enabled Error Correcting Capabilities:
			Single-bit Error Correcting
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: ROW-0                          =20
		Bank Connections: 2 7
		Current Speed: Unknown
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: ROW-1                          =20
		Bank Connections: 2 7
		Current Speed: Unknown
		Type: DIMM SDRAM
		Installed Size: 256 MB (Double-bank Connection)
		Enabled Size: 256 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI1                           =20
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 1
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x000B
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI2                           =20
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 2
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x000C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI3                           =20
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 3
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x000D
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI4                           =20
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 4
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x000E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI5                           =20
		Type: 32-bit PCI
		Current Usage: Unknown
		Length: Long
		ID: 5
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x000F
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: ISA1                           =20
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x0010
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: ISA2                           =20
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics:
			3.3 V is provided
			Opening is shared
			PME signal is supported
Handle 0x0011
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: SMBIOS Support from AMI        =20
		String 2: Tested by James                =20
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: USB                            =20
		Internal Connector Type: Mini Centronics
		External Reference Designator: Def                            =20
		External Connector Type: DB-25 male
		Port Type: SSA SCSI
Handle 0x0013
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: System Management BIOS from Atlanta
		Option 2: SMBIOS from AMI                =20
Handle 0x0014
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 4
			English                        =20
			Traditional Chinese            =20
			Simplified Chinese             =20
			Japanese                       =20
		Currently Installed Language: Not Specified
Handle 0x0015
	DMI type 31, 28 bytes.
	Boot Integrity Services Entry Point
Handle 0x0016
	DMI type 127, 4 bytes.
	End Of Table
Handle 0x0017
	DMI type 64, 11 bytes.
	Unknown Type
		Header and Data:
			40 0B 17 00 00 A0 CC C2 25 3B 71


-- acpidmp

RSDP "AMI" @ 0x000fc740
  0000: 52 53 44 20 50 54 52 20 0c 41 4d 49 20 20 20 00  RSD PTR .AMI   .
  0010: 00 00 7f 1f                                      ....

RSDT @ 0x1f7f0000
  0000: 52 53 44 54 28 00 00 00 01 89 41 4d 49 49 4e 54  RSDT(.....AMIINT
  0010: 41 4d 49 49 4e 54 30 39 00 10 00 00 4d 53 46 54  AMIINT09....MSFT
  0020: 0b 00 00 01 30 00 7f 1f                          ....0...

FACP @ 0x1f7f0030
  0000: 46 41 43 50 74 00 00 00 01 42 41 4d 49 49 4e 54  FACPt....BAMIINT
  0010: 41 4d 49 49 4e 54 30 39 00 10 00 00 4d 53 46 54  AMIINT09....MSFT
  0020: 0b 00 00 01 00 80 7f 1f b0 00 7f 1f 00 00 09 00  ................
  0030: 48 50 00 00 e1 1e 1f 00 00 50 00 00 00 00 00 00  HP.......P......
  0040: 04 50 00 00 00 00 00 00 16 50 00 00 08 50 00 00  .P.......P...P..
  0050: 20 50 00 00 30 50 00 00 04 02 01 04 04 04 10 00   P..0P..........
  0060: 0a 00 e9 03 00 04 10 00 01 03 0d 00 00 00 00 00  ................
  0070: 31 00 00 00                                      1...

DSDT @ 0x1f7f00b0
  0000: 44 53 44 54 b0 26 00 00 01 6f 53 69 53 00 00 00  DSDT.&...oSiS...
  0010: 36 33 30 00 00 00 00 00 00 10 00 00 4d 53 46 54  630.........MSFT
  0020: 0d 00 00 01 10 13 5c 5f 50 52 5f 5b 83 0b 43 50  ......\_PR_[..CP
  0030: 55 31 01 10 50 00 00 06 08 5c 5f 53 30 5f 12 0a  U1..P....\_S0_..
  0040: 04 0a 00 0a 00 0a 00 0a 00 08 5c 5f 53 31 5f 12  ..........\_S1_.
  0050: 0a 04 0a 07 0a 00 0a 00 0a 00 08 5c 5f 53 34 5f  ...........\_S4_
  0060: 12 0a 04 0a 04 0a 00 0a 00 0a 00 08 5c 5f 53 35  ............\_S5
  0070: 5f 12 0a 04 0a 05 0a 00 0a 00 0a 00 14 2d 4d 54  _............-MT
  0080: 43 48 01 a0 09 93 87 68 0a 11 a4 0a 01 a1 1c a0  CH.....h........
  0090: 09 93 87 68 0a 14 a4 0a 02 a1 10 a0 09 93 87 68  ...h...........h
  00a0: 0a 27 a4 0a 03 a1 04 a4 0a 00 08 46 47 45 43 0a  .'.........FGEC.
  00b0: 00 10 8d 2f 02 5c 5f 53 42 5f 08 41 50 49 43 0a  .../.\_SB_.APIC.
  00c0: 00 14 0c 5f 50 49 43 01 70 68 41 50 49 43 5b 82  ..._PIC.phAPIC[.
  00d0: 89 24 02 50 43 49 30 08 5f 48 49 44 0c 41 d0 0a  .$.PCI0._HID.A..
  00e0: 03 08 5f 41 44 52 0a 00 08 5f 42 42 4e 0a 00 08  .._ADR..._BBN...
  00f0: 43 52 53 5f 11 4c 08 0a 88 88 0d 00 02 0c 00 00  CRS_.L..........
  0100: 00 00 00 ff 00 00 00 00 01 47 01 f8 0c f8 0c 01  .........G......
  0110: 08 88 0d 00 01 0c 03 00 00 00 00 f7 0c 00 00 f8  ................
  0120: 0c 88 0d 00 01 0c 03 00 00 00 0d ff ff 00 00 00  ................
  0130: f3 87 17 00 00 0c 03 00 00 00 00 00 00 0a 00 ff  ................
  0140: ff 0b 00 00 00 00 00 00 00 02 00 87 17 00 00 0c  ................
  0150: 03 00 00 00 00 00 b0 0c 00 ff ff 0d 00 00 00 00  ................
  0160: 00 00 50 01 00 87 17 00 00 0c 03 00 00 00 00 00  ..P.............
  0170: 00 00 20 ff ff df ff 00 00 00 00 00 00 e0 df 79  .. ............y
  0180: 00 5b 80 54 4d 45 4d 02 0a 60 0a 04 5b 81 21 54  .[.TMEM..`..[.!T
  0190: 4d 45 4d 01 4d 45 4d 31 08 4d 45 4d 32 08 4d 45  MEM.MEM1.MEM2.ME
  01a0: 4d 33 08 4d 45 4d 50 03 00 01 4d 45 4d 53 04 08  M3.MEMP...MEMS..
  01b0: 53 52 41 4d 12 22 10 0a 02 0a 08 0a 08 0a 10 0a  SRAM."..........
  01c0: 04 0a 10 0a 10 0a 20 0a 08 0a 20 0a 20 0a 40 0a  ...... ... . .-4b8TPpkIZ3Q@public.gmane.org
  01d0: 04 0a 40 0a 40 0a 80 08 56 52 41 4d 12 08 03 0a  ..-4b8TPpkIZ3Q@public.gmane.org@...VRAM....
  01e0: 08 0a 10 0a 20 08 54 4f 4d 5f 0a 00 14 43 05 4d  .... .TOM_...C.M
  01f0: 53 49 5a 02 7b 69 4d 45 4d 50 60 7b 68 0a 0f 61  SIZ.{iMEMP`{h..a
  0200: 70 00 62 7b 68 0a 20 64 7b 68 0a 80 63 a0 30 60  p.b{h. d{h..c.0`
  0210: a0 0c 63 70 83 88 56 52 41 4d 61 00 62 a1 0b 70  ..cp..VRAMa.b..p
  0220: 83 88 53 52 41 4d 61 00 62 79 62 0a 02 62 a0 07  ..SRAMa.byb..b..
  0230: 64 79 62 0a 01 62 77 62 0c 00 00 10 00 62 a4 62  dyb..bwb.....b.b
  0240: 14 4f 06 4d 44 45 54 00 a0 05 54 4f 4d 5f a1 4c  .O.MDET...TOM_.L
  0250: 05 a0 41 05 46 4c 41 47 70 4d 53 49 5a 4d 45 4d  ..A.FLAGpMSIZMEM
  0260: 31 0a 01 60 72 4d 53 49 5a 4d 45 4d 32 0a 02 60  1..`rMSIZMEM2..`
  0270: 60 72 4d 53 49 5a 4d 45 4d 33 0a 04 60 60 7b 4d  `rMSIZMEM3..``{M
  0280: 45 4d 53 0a 08 61 a0 16 61 7b 4d 45 4d 53 0a 07  EMS..a..a{MEMS..
  0290: 62 79 0c 00 00 20 00 62 63 74 60 63 60 70 60 54  by... .bct`c`p`T
  02a0: 4f 4d 5f a1 07 a4 0c 00 00 00 20 a4 54 4f 4d 5f  OM_....... .TOM_
  02b0: 14 11 54 46 43 53 00 74 4d 44 45 54 0b c0 7f 60  ..TFCS.tMDET...`
  02c0: a4 60 08 46 4c 41 47 0a 01 08 4f 53 46 4c 0a 01  .`.FLAG...OSFL..
  02d0: 14 42 07 5f 49 4e 49 00 5c 2f 04 5f 53 42 5f 50  .B._INI.\/._SB_P
  02e0: 43 49 30 53 42 52 47 49 4f 44 54 a0 1b 93 4d 54  CI0SBRGIODT...MT
  02f0: 43 48 5c 5f 4f 53 5f 0a 01 70 0a 01 46 4c 41 47  CH\_OS_..p..FLAG
  0300: 70 0a 01 4f 53 46 4c a1 3b a0 1b 93 4d 54 43 48  p..OSFL.;...MTCH
  0310: 5c 5f 4f 53 5f 0a 02 70 0a 00 46 4c 41 47 70 0a  \_OS_..p..FLAGp.
  0320: 02 4f 53 46 4c a1 1d a0 1b 93 4d 54 43 48 5c 5f  .OSFL.....MTCH\_
  0330: 4f 53 5f 0a 03 70 0a 01 46 4c 41 47 70 0a 03 4f  OS_..p..FLAGp..O
  0340: 53 46 4c 14 12 5f 52 45 47 02 a0 0b 93 68 0a 02  SFL.._REG....h..
  0350: 70 69 46 4c 41 47 14 38 5f 43 52 53 00 8a 43 52  piFLAG.8_CRS..CR
  0360: 53 5f 0a 76 54 4d 45 4d 8a 43 52 53 5f 0a 82 54  S_.vTMEM.CRS_..T
  0370: 4c 45 4e 70 4d 44 45 54 54 4d 45 4d 74 0c 00 00  LENpMDETTMEMt...
  0380: e0 ff 54 4d 45 4d 54 4c 45 4e a4 43 52 53 5f 08  ..TMEMTLEN.CRS_.
  0390: 5f 50 52 54 12 43 07 07 12 0f 04 0c ff ff 01 00  _PRT.C..........
  03a0: 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 01 00  ..LNKB..........
  03b0: 0a 02 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 01 00  ..LNKC..........
  03c0: 0a 03 4c 4e 4b 44 0a 00 12 0f 04 0c ff ff 02 00  ..LNKD..........
  03d0: 0a 01 4c 4e 4b 42 0a 00 12 0f 04 0c ff ff 02 00  ..LNKB..........
  03e0: 0a 02 4c 4e 4b 43 0a 00 12 0f 04 0c ff ff 02 00  ..LNKC..........
  03f0: 0a 03 4c 4e 4b 44 0a 00 12 0f 04 0c ff ff 03 00  ..LNKD..........
  0400: 0a 00 4c 4e 4b 42 0a 00 5b 82 84 c4 01 53 42 52  ..LNKB..[....SBR
  0410: 47 08 5f 41 44 52 0c 00 00 01 00 08 5c 2e 5f 53  G._ADR......\._S
  0420: 42 5f 49 50 52 41 11 0b 0a 08 30 23 d8 d4 18 38  B_IPRA....0#...8
  0430: 79 00 08 5c 2e 5f 53 42 5f 49 50 52 42 11 0b 0a  y..\._SB_IPRB...
  0440: 08 30 23 d0 d8 18 38 79 00 08 5c 2e 5f 53 42 5f  .0#...8y..\._SB_
  0450: 49 50 52 43 11 0b 0a 08 30 23 c0 d4 18 38 79 00  IPRC....0#...8y.
  0460: 08 5c 2e 5f 53 42 5f 49 50 52 44 11 0b 0a 08 30  .\._SB_IPRD....0
  0470: 23 00 08 18 38 79 00 5b 80 50 49 58 30 02 0a 41  #...8y.[.PIX0..A
  0480: 0a 04 5b 80 50 49 58 31 02 0a 62 0a 01 10 48 21  ..[.PIX1..b...H!
  0490: 5c 5f 53 42 5f 5b 81 24 2f 03 50 43 49 30 53 42  \_SB_[.$/.PCI0SB
  04a0: 52 47 50 49 58 30 01 50 49 52 41 08 50 49 52 42  RGPIX0.PIRA.PIRB
  04b0: 08 50 49 52 43 08 50 49 52 44 08 5b 81 15 2f 03  .PIRC.PIRD.[../.
  04c0: 50 43 49 30 53 42 52 47 50 49 58 31 01 50 49 52  PCI0SBRGPIX1.PIR
  04d0: 55 08 08 42 55 46 41 11 09 0a 06 23 00 80 18 79  U..BUFA....#...y
  04e0: 00 5b 82 45 09 4c 4e 4b 42 08 5f 48 49 44 0c 41  .[.E.LNKB._HID.A
  04f0: d0 0c 0f 08 5f 55 49 44 0a 02 14 19 5f 53 54 41  ...._UID...._STA
  0500: 00 7b 50 49 52 42 0a 80 60 a0 05 60 a4 0a 09 a1  .{PIRB..`..`....
  0510: 04 a4 0a 0b 14 0b 5f 50 52 53 00 a4 49 50 52 42  ......_PRS..IPRB
  0520: 14 11 5f 44 49 53 00 7d 50 49 52 42 0a 80 50 49  .._DIS.}PIRB..PI
  0530: 52 42 14 28 5f 43 52 53 00 8b 42 55 46 41 0a 01  RB.(_CRS..BUFA..
  0540: 49 52 41 30 7b 50 49 52 42 0a 0f 60 70 01 61 79  IRA0{PIRB..`p.ay
  0550: 61 60 49 52 41 30 a4 42 55 46 41 14 1c 5f 53 52  a`IRA0.BUFA.._SR
  0560: 53 01 8b 68 0a 01 49 52 41 5f 82 49 52 41 5f 60  S..h..IRA_.IRA_`
  0570: 76 60 70 60 50 49 52 42 5b 82 45 09 4c 4e 4b 43  v`p`PIRB[.E.LNKC
  0580: 08 5f 48 49 44 0c 41 d0 0c 0f 08 5f 55 49 44 0a  ._HID.A...._UID.
  0590: 03 14 19 5f 53 54 41 00 7b 50 49 52 43 0a 80 60  ..._STA.{PIRC..`
  05a0: a0 05 60 a4 0a 09 a1 04 a4 0a 0b 14 0b 5f 50 52  ..`.........._PR
  05b0: 53 00 a4 49 50 52 43 14 11 5f 44 49 53 00 7d 50  S..IPRC.._DIS.}P
  05c0: 49 52 43 0a 80 50 49 52 43 14 28 5f 43 52 53 00  IRC..PIRC.(_CRS.
  05d0: 8b 42 55 46 41 0a 01 49 52 41 30 7b 50 49 52 43  .BUFA..IRA0{PIRC
  05e0: 0a 0f 60 70 01 61 79 61 60 49 52 41 30 a4 42 55  ..`p.aya`IRA0.BU
  05f0: 46 41 14 1c 5f 53 52 53 01 8b 68 0a 01 49 52 41  FA.._SRS..h..IRA
  0600: 5f 82 49 52 41 5f 60 76 60 70 60 50 49 52 43 5b  _.IRA_`v`p`PIRC[
  0610: 82 45 09 4c 4e 4b 44 08 5f 48 49 44 0c 41 d0 0c  .E.LNKD._HID.A..
  0620: 0f 08 5f 55 49 44 0a 04 14 19 5f 53 54 41 00 7b  .._UID...._STA.{
  0630: 50 49 52 44 0a 80 60 a0 05 60 a4 0a 09 a1 04 a4  PIRD..`..`......
  0640: 0a 0b 14 0b 5f 50 52 53 00 a4 49 50 52 44 14 11  ...._PRS..IPRD..
  0650: 5f 44 49 53 00 7d 50 49 52 44 0a 80 50 49 52 44  _DIS.}PIRD..PIRD
  0660: 14 28 5f 43 52 53 00 8b 42 55 46 41 0a 01 49 52  .(_CRS..BUFA..IR
  0670: 41 30 7b 50 49 52 44 0a 0f 60 70 01 61 79 61 60  A0{PIRD..`p.aya`
  0680: 49 52 41 30 a4 42 55 46 41 14 1c 5f 53 52 53 01  IRA0.BUFA.._SRS.
  0690: 8b 68 0a 01 49 52 41 5f 82 49 52 41 5f 60 76 60  .h..IRA_.IRA_`v`
  06a0: 70 60 50 49 52 44 5b 82 41 2f 53 59 53 52 08 5f  p`PIRD[.A/SYSR._
  06b0: 48 49 44 0c 41 d0 0c 02 14 21 5f 53 54 41 00 a0  HID.A....!_STA..
  06c0: 17 92 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4f 53  ...\/._SB_PCI0OS
  06d0: 46 4c 0a 02 a4 0a 0f a4 0a 00 08 49 4f 52 47 11  FL.........IORG.
  06e0: 46 0e 0a e2 4b 10 00 10 4b 22 00 1e 4b 44 00 1c  F...K...K"..KD..
  06f0: 4b 63 00 01 4b 65 00 01 4b 67 00 09 4b 72 00 0e  Kc..Ke..Kg..Kr..
  0700: 4b 80 00 01 4b 84 00 03 4b 88 00 01 4b 8c 00 03  K...K...K...K...
  0710: 4b 90 00 10 4b a2 00 1e 4b e0 00 10 47 01 80 04  K...K...K...G...
  0720: 80 04 00 10 47 01 d0 04 d0 04 00 02 47 01 00 08  ....G.......G...
  0730: 00 08 00 20 47 01 00 50 00 50 00 80 47 01 80 50  ... G..P.P..G..P
  0740: 80 50 00 80 85 11 00 00 00 00 e0 fe 00 00 e0 fe  .P..............
  0750: 00 00 00 00 00 10 00 00 85 11 00 00 00 00 f8 ff  ................
  0760: 00 00 f8 ff 00 00 00 00 00 80 00 00 85 11 00 00  ................
  0770: 00 a0 f8 ff 00 a0 f8 ff 00 00 00 00 00 60 04 00  .............`..
  0780: 85 11 00 00 00 00 ee ff 00 00 ee ff 00 00 00 00  ................
  0790: 00 00 01 00 85 11 00 00 00 00 fd ff 00 00 fd ff  ................
  07a0: 00 00 00 00 00 00 01 00 85 11 00 00 00 00 fe ff  ................
  07b0: 00 00 fe ff 00 00 00 00 00 00 01 00 47 01 f0 03  ............G...
  07c0: f0 03 00 02 79 00 08 49 4f 32 4b 11 46 06 0a 62  ....y..IO2K.F..b
  07d0: 4b 10 00 10 4b 22 00 1e 4b 44 00 1c 4b 63 00 01  K...K"..KD..Kc..
  07e0: 4b 65 00 01 4b 67 00 09 4b 72 00 0e 4b 80 00 01  Ke..Kg..Kr..K...
  07f0: 4b 84 00 03 4b 88 00 01 4b 8c 00 03 4b 90 00 10  K...K...K...K...
  0800: 4b a2 00 1e 4b e0 00 10 47 01 80 04 80 04 00 10  K...K...G.......
  0810: 47 01 d0 04 d0 04 00 02 47 01 00 50 00 50 00 80  G.......G..P.P..
  0820: 47 01 80 50 80 50 00 80 47 01 f0 03 f0 03 00 02  G..P.P..G.......
  0830: 79 00 14 46 16 5f 43 52 53 00 a0 48 0b 92 93 5c  y..F._CRS..H...\
  0840: 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46 4c 0a 02  /._SB_PCI0OSFL..
  0850: 8b 49 4f 52 47 0a 52 50 4d 30 30 8b 49 4f 52 47  .IORG.RPM00.IORG
  0860: 0a 54 50 4d 30 31 8c 49 4f 52 47 0a 57 50 4d 4c  .TPM01.IORG.WPML
  0870: 4e 8b 49 4f 52 47 0a 5a 53 4d 30 30 8b 49 4f 52  N.IORG.ZSM00.IOR
  0880: 47 0a 5c 53 4d 30 31 8c 49 4f 52 47 0a 5f 53 4d  G.\SM01.IORG._SM
  0890: 4c 4e 70 5c 2f 04 5f 53 42 5f 50 43 49 30 53 42  LNp\/._SB_PCI0SB
  08a0: 52 47 50 4d 42 53 50 4d 30 30 70 50 4d 30 30 50  RGPMBSPM00pPM00P
  08b0: 4d 30 31 a0 0c 50 4d 30 30 70 0a 80 50 4d 4c 4e  M01..PM00p..PMLN
  08c0: 70 5c 2f 04 5f 53 42 5f 50 43 49 30 53 42 52 47  p\/._SB_PCI0SBRG
  08d0: 53 4d 42 53 53 4d 30 30 70 53 4d 30 30 53 4d 30  SMBSSM00pSM00SM0
  08e0: 31 a0 0c 53 4d 30 30 70 0a 80 53 4d 4c 4e a4 49  1..SM00p..SMLN.I
  08f0: 4f 52 47 a1 45 0a 8b 49 4f 32 4b 0a 4a 50 4b 30  ORG.E..IO2K.JPK0
  0900: 30 8b 49 4f 32 4b 0a 4c 50 4b 30 31 8c 49 4f 32  0.IO2K.LPK01.IO2
  0910: 4b 0a 4f 50 4b 4c 4e 8b 49 4f 32 4b 0a 52 53 4b  K.OPKLN.IO2K.RSK
  0920: 30 30 8b 49 4f 32 4b 0a 54 53 4b 30 31 8c 49 4f  00.IO2K.TSK01.IO
  0930: 32 4b 0a 57 53 4b 4c 4e 70 5c 2f 04 5f 53 42 5f  2K.WSKLNp\/._SB_
  0940: 50 43 49 30 53 42 52 47 50 4d 42 53 50 4b 30 30  PCI0SBRGPMBSPK00
  0950: 70 50 4b 30 30 50 4b 30 31 a0 0c 50 4b 30 30 70  pPK00PK01..PK00p
  0960: 0a 80 50 4b 4c 4e 70 5c 2f 04 5f 53 42 5f 50 43  ..PKLNp\/._SB_PC
  0970: 49 30 53 42 52 47 53 4d 42 53 53 4b 30 30 70 53  I0SBRGSMBSSK00pS
  0980: 4b 30 30 53 4b 30 31 a0 0c 53 4b 30 30 70 0a 80  K00SK01..SK00p..
  0990: 53 4b 4c 4e a4 49 4f 32 4b 5b 82 43 0a 5c 2e 5f  SKLN.IO2K[.C.\._
  09a0: 53 42 5f 4d 45 4d 5f 08 5f 48 49 44 0c 41 d0 0c  SB_MEM_._HID.A..
  09b0: 01 14 21 5f 53 54 41 00 a0 17 92 93 5c 2f 03 5f  ..!_STA.....\/._
  09c0: 53 42 5f 50 43 49 30 4f 53 46 4c 0a 02 a4 0a 0f  SB_PCI0OSFL.....
  09d0: a4 0a 00 08 4d 45 4d 31 11 35 0a 32 86 09 00 01  ....MEM1.5.2....
  09e0: 00 00 00 00 00 00 0a 00 86 09 00 00 00 00 0f 00  ................
  09f0: 00 00 01 00 86 09 00 01 00 00 10 00 00 00 f0 1f  ................
  0a00: 86 09 00 00 00 00 ff ff 00 00 01 00 79 00 14 2f  ............y../
  0a10: 5f 43 52 53 00 8a 4d 45 4d 31 0a 20 54 4f 50 31  _CRS..MEM1. TOP1
  0a20: 74 5c 2f 03 5f 53 42 5f 50 43 49 30 4d 44 45 54  t\/._SB_PCI0MDET
  0a30: 0c 00 00 10 00 54 4f 50 31 a4 4d 45 4d 31 5b 82  .....TOP1.MEM1[.
  0a40: 46 04 50 49 43 5f 08 5f 48 49 44 0b 41 d0 14 21  F.PIC_._HID.A..!
  0a50: 5f 53 54 41 00 a0 17 92 93 5c 2f 03 5f 53 42 5f  _STA.....\/._SB_
  0a60: 50 43 49 30 4f 53 46 4c 0a 02 a4 0a 0f a4 0a 00  PCI0OSFL........
  0a70: 08 5f 43 52 53 11 10 0a 0d 4b 20 00 02 4b a0 00  ._CRS....K ..K..
  0a80: 02 22 04 00 79 00 5b 82 35 44 4d 41 44 08 5f 48  ."..y.[.5DMAD._H
  0a90: 49 44 0c 41 d0 02 00 08 5f 43 52 53 11 20 0a 1d  ID.A...._CRS. ..
  0aa0: 2a 10 04 4b 00 00 10 4b 81 00 03 4b 87 00 01 4b  *..K...K...K...K
  0ab0: 89 00 03 4b 8f 00 01 4b c0 00 20 79 00 5b 82 21  ...K...K.. y.[.!
  0ac0: 54 4d 52 5f 08 5f 48 49 44 0c 41 d0 01 00 08 5f  TMR_._HID.A...._
  0ad0: 43 52 53 11 0c 0a 09 4b 40 00 04 22 01 00 79 00  CRS....K-rVxdn2TrCWA@public.gmane.org"..y.
  0ae0: 5b 82 21 52 54 43 5f 08 5f 48 49 44 0c 41 d0 0b  [.!RTC_._HID.A..
  0af0: 00 08 5f 43 52 53 11 0c 0a 09 4b 70 00 02 22 00  .._CRS....Kp..".
  0b00: 01 79 00 5b 82 1e 53 50 4b 52 08 5f 48 49 44 0c  .y.[..SPKR._HID.
  0b10: 41 d0 08 00 08 5f 43 52 53 11 09 0a 06 4b 61 00  A...._CRS....Ka.
  0b20: 01 79 00 5b 82 21 43 4f 50 52 08 5f 48 49 44 0c  .y.[.!COPR._HID.
  0b30: 41 d0 0c 04 08 5f 43 52 53 11 0c 0a 09 4b f0 00  A...._CRS....K..
  0b40: 10 22 00 20 79 00 5b 80 50 53 52 47 00 0b 10 04  .". y.[.PSRG....
  0b50: 0a 01 5b 81 0d 50 53 52 47 01 00 02 50 53 32 45  ..[..PSRG...PS2E
  0b60: 01 5b 82 3c 50 53 32 4d 08 5f 48 49 44 0c 41 d0  .[.<PS2M._HID.A.
  0b70: 0f 03 08 5f 43 49 44 0c 41 d0 0f 13 14 14 5f 53  ..._CID.A....._S
  0b80: 54 41 00 a0 08 50 53 32 45 a4 0a 0f a1 04 a4 0a  TA...PS2E.......
  0b90: 00 08 5f 43 52 53 11 08 0a 05 22 00 10 79 00 5b  .._CRS...."..y.[
  0ba0: 82 25 50 53 32 4b 08 5f 48 49 44 0c 41 d0 03 03  .%PS2K._HID.A...
  0bb0: 08 5f 43 52 53 11 10 0a 0d 4b 60 00 01 4b 64 00  ._CRS....K`..Kd.
  0bc0: 01 22 02 00 79 00 14 07 52 52 49 4f 04 a3 14 07  ."..y...RRIO....
  0bd0: 52 47 4e 52 04 a3 14 07 52 44 4d 41 03 a3 5b 82  RGNR....RDMA..[.
  0be0: 4d 38 45 43 30 5f 08 5f 48 49 44 0c 41 d0 0c 09  M8EC0_._HID.A...
  0bf0: 08 5f 43 52 53 11 15 0a 12 47 01 62 00 62 00 00  ._CRS....G.b.b..
  0c00: 01 47 01 66 00 66 00 00 01 79 00 14 12 5f 52 45  .G.f.f...y..._RE
  0c10: 47 02 a0 0b 93 68 0a 03 70 69 46 47 45 43 08 5f  G....h..piFGEC._
  0c20: 47 50 45 0a 0b 08 5f 50 52 57 12 06 02 0a 0b 0a  GPE..._PRW......
  0c30: 04 5b 80 53 4d 43 4d 03 0a 00 0a 80 5b 81 1a 53  .[.SMCM.....[..S
  0c40: 4d 43 4d 01 00 40 20 00 01 57 4e 53 45 01 57 4e  MCM..@ ..WNSE.WN
  0c50: 4d 45 01 57 4e 32 4b 01 14 0d 5f 51 30 31 00 70  ME.WN2K..._Q01.p
  0c60: 0a 33 50 34 38 5f 14 42 13 5f 51 30 36 00 a0 46  .3P48_.B._Q06..F
  0c70: 06 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46  ..\/._SB_PCI0OSF
  0c80: 4c 0a 01 70 0a 32 50 34 38 5f a0 17 42 54 49 4e  L..p.2P48_..BTIN
  0c90: 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54 30  .\/._SB_PCI0BAT0
  0ca0: 0a 01 a1 13 86 5c 2f 03 5f 53 42 5f 50 43 49 30  .....\/._SB_PCI0
  0cb0: 42 41 54 30 0a 00 86 5c 2f 03 5f 53 42 5f 50 43  BAT0...\/._SB_PC
  0cc0: 49 30 42 41 54 30 0a 80 86 5c 2e 5f 53 42 5f 50  I0BAT0...\._SB_P
  0cd0: 43 49 30 0a 00 a0 4d 09 93 5c 2f 03 5f 53 42 5f  CI0...M..\/._SB_
  0ce0: 50 43 49 30 4f 53 46 4c 0a 03 70 0a 01 46 41 4b  PCI0OSFL..p..FAK
  0cf0: 45 86 5c 2f 03 5f 53 42 5f 50 43 49 30 41 43 30  E.\/._SB_PCI0AC0
  0d00: 5f 0a 00 70 0a 00 46 41 4b 45 86 5c 2f 03 5f 53  _..p..FAKE.\/._S
  0d10: 42 5f 50 43 49 30 41 43 30 5f 0a 00 70 0a 32 50  B_PCI0AC0_..p.2P
  0d20: 34 38 5f a0 17 42 54 49 4e 86 5c 2f 03 5f 53 42  48_..BTIN.\/._SB
  0d30: 5f 50 43 49 30 42 41 54 30 0a 01 a1 13 86 5c 2f  _PCI0BAT0.....\/
  0d40: 03 5f 53 42 5f 50 43 49 30 42 41 54 30 0a 00 86  ._SB_PCI0BAT0...
  0d50: 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54 30 0a  \/._SB_PCI0BAT0.
  0d60: 81 86 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54  ..\/._SB_PCI0BAT
  0d70: 30 0a 80 a0 25 93 5c 2f 03 5f 53 42 5f 50 43 49  0...%.\/._SB_PCI
  0d80: 30 4f 53 46 4c 0a 02 86 5c 2f 03 5f 53 42 5f 50  0OSFL...\/._SB_P
  0d90: 43 49 30 42 41 54 30 0a 00 14 44 09 5f 51 30 37  CI0BAT0...D._Q07
  0da0: 00 a0 39 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4f  ..9.\/._SB_PCI0O
  0db0: 53 46 4c 0a 01 70 0a 00 46 41 4b 45 86 5c 2f 03  SFL..p..FAKE.\/.
  0dc0: 5f 53 42 5f 50 43 49 30 41 43 30 5f 0a 00 86 5c  _SB_PCI0AC0_...\
  0dd0: 2e 5f 53 42 5f 50 43 49 30 0a 00 a0 2c 93 5c 2f  ._SB_PCI0...,.\/
  0de0: 03 5f 53 42 5f 50 43 49 30 4f 53 46 4c 0a 03 70  ._SB_PCI0OSFL..p
  0df0: 0a 00 46 41 4b 45 86 5c 2f 03 5f 53 42 5f 50 43  ..FAKE.\/._SB_PC
  0e00: 49 30 41 43 30 5f 0a 00 a0 25 93 5c 2f 03 5f 53  I0AC0_...%.\/._S
  0e10: 42 5f 50 43 49 30 4f 53 46 4c 0a 02 86 5c 2f 03  B_PCI0OSFL...\/.
  0e20: 5f 53 42 5f 50 43 49 30 42 41 54 30 0a 00 14 14  _SB_PCI0BAT0....
  0e30: 5f 51 30 39 00 70 0a 09 50 33 37 38 70 0a 2a 50  _Q09.p..P378p.*P
  0e40: 34 38 5f 14 13 5f 51 30 41 00 86 5c 2e 5f 53 42  48_.._Q0A..\._SB
  0e50: 5f 53 4c 50 42 0a 80 14 0d 5f 51 30 44 00 70 0a  _SLPB...._Q0D.p.
  0e60: 23 50 34 38 5f 14 0d 5f 51 30 45 00 70 0a 24 50  #P48_.._Q0E.p.$P
  0e70: 34 38 5f 14 0d 5f 51 30 46 00 70 0a 25 50 34 38  48_.._Q0F.p.%P48
  0e80: 5f 14 14 5f 51 31 31 00 70 0a 08 50 33 37 38 70  _.._Q11.p..P378p
  0e90: 0a 27 50 34 38 5f 14 14 5f 51 31 32 00 70 0a 09  .'P48_.._Q12.p..
  0ea0: 50 33 37 38 70 0a 28 50 34 38 5f 14 14 5f 51 31  P378p.(P48_.._Q1
  0eb0: 33 00 70 0a 10 50 33 37 38 70 0a 29 50 34 38 5f  3.p..P378p.)P48_
  0ec0: 14 27 5f 51 31 43 00 70 0a 78 50 33 37 38 70 0a  .'_Q1C.p.xP378p.
  0ed0: 00 4c 49 44 53 70 01 4c 44 4f 46 86 5c 2e 5f 53  .LIDSp.LDOF.\._S
  0ee0: 42 5f 4c 49 44 44 0a 80 14 1a 5f 51 31 45 00 70  B_LIDD...._Q1E.p
  0ef0: 0a 01 4c 49 44 53 86 5c 2e 5f 53 42 5f 4c 49 44  ..LIDS.\._SB_LID
  0f00: 44 0a 80 14 0d 5f 51 31 46 00 70 0a 26 50 34 38  D...._Q1F.p.&P48
  0f10: 5f 14 1f 5f 51 31 37 00 70 0a 17 50 33 37 38 86  _.._Q17.p..P378.
  0f20: 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54 30 0a  \/._SB_PCI0BAT0.
  0f30: 80 14 27 5f 51 31 44 00 70 0a a1 50 34 38 5f 86  ..'_Q1D.p..P48_.
  0f40: 5c 2e 5f 54 5a 5f 54 48 52 4d 0a 80 86 5c 2e 5f  \._TZ_THRM...\._
  0f50: 54 5a 5f 54 48 52 4d 0a 81 14 13 5f 51 31 39 00  TZ_THRM...._Q19.
  0f60: 86 5c 2e 5f 53 42 5f 50 57 52 42 0a 80 5b 82 43  .\._SB_PWRB..[.C
  0f70: 20 5c 2f 03 5f 53 42 5f 50 43 49 30 42 41 54 30   \/._SB_PCI0BAT0
  0f80: 08 5f 48 49 44 0c 41 d0 0c 0a 08 5f 55 49 44 0a  ._HID.A...._UID.
  0f90: 00 08 5f 50 43 4c 12 0c 01 5c 2e 5f 53 42 5f 50  .._PCL...\._SB_P
  0fa0: 43 49 30 08 50 41 4b 31 12 32 0d 0a 00 0b 56 0c  CI0.PAK1.2....V.
  0fb0: 0b 56 0c 0a 00 0b 30 2a 0b 3b 01 0a 9d 0a 10 0a  .V....0*.;......
  0fc0: 08 0d 33 34 30 53 38 00 0d 30 30 30 30 32 00 0d  ..340S8..00002..
  0fd0: 4c 69 49 6f 6e 00 0d 4f 45 4d 00 14 4b 08 5f 42  LiIon..OEM..K._B
  0fe0: 49 46 00 70 42 49 46 30 88 50 41 4b 31 0a 00 00  IF.pBIF0.PAK1...
  0ff0: 70 42 49 46 31 88 50 41 4b 31 0a 01 00 70 42 49  pBIF1.PAK1...pBI
  1000: 46 32 88 50 41 4b 31 0a 02 00 70 42 49 46 33 88  F2.PAK1...pBIF3.
  1010: 50 41 4b 31 0a 03 00 70 42 49 46 34 88 50 41 4b  PAK1...pBIF4.PAK
  1020: 31 0a 04 00 70 78 42 49 46 32 0a 0a 00 00 88 50  1...pxBIF2.....P
  1030: 41 4b 31 0a 05 00 70 78 42 49 46 32 0a 14 00 00  AK1...pxBIF2....
  1040: 88 50 41 4b 31 0a 06 00 70 42 49 46 37 88 50 41  .PAK1...pBIF7.PA
  1050: 4b 31 0a 07 00 70 42 49 46 42 88 50 41 4b 31 0a  K1...pBIFB.PAK1.
  1060: 0b 00 a4 50 41 4b 31 08 42 46 42 30 12 0c 04 0a  ...PAK1.BFB0....
  1070: 00 0a 00 0b 34 10 0b 30 2a 14 47 04 5f 42 53 54  ....4..0*.G._BST
  1080: 00 70 0a 32 50 34 38 5f 70 42 53 54 30 88 42 46  .p.2P48_pBST0.BF
  1090: 42 30 0a 00 00 70 42 53 54 31 88 42 46 42 30 0a  B0...pBST1.BFB0.
  10a0: 01 00 70 42 53 54 32 88 42 46 42 30 0a 02 00 70  ..pBST2.BFB0...p
  10b0: 42 53 54 33 88 42 46 42 30 0a 03 00 a4 42 46 42  BST3.BFB0....BFB
  10c0: 30 14 2b 5f 42 54 50 01 70 0a 88 50 33 37 38 a0  0.+_BTP.p..P378.
  10d0: 0e 41 43 49 4e 70 42 49 46 35 42 54 50 30 a1 07  .ACINpBIF5BTP0..
  10e0: 70 68 42 54 50 30 70 0a 32 50 34 38 5f 14 44 08  phBTP0p.2P48_.D.
  10f0: 5f 53 54 41 00 70 0a 00 60 a0 4d 06 90 46 47 45  _STA.p..`.M..FGE
  1100: 43 53 43 49 46 70 0a 32 50 34 38 5f 70 42 54 49  CSCIFp.2P48_pBTI
  1110: 4e 60 a0 1a 93 5c 2f 03 5f 53 42 5f 50 43 49 30  N`...\/._SB_PCI0
  1120: 4f 53 46 4c 0a 01 70 0a 03 4f 53 45 43 a1 39 a0  OSFL..p..OSEC.9.
  1130: 1a 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46  ..\/._SB_PCI0OSF
  1140: 4c 0a 02 70 0a 09 4f 53 45 43 a1 1c a0 1a 93 5c  L..p..OSEC.....\
  1150: 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46 4c 0a 03  /._SB_PCI0OSFL..
  1160: 70 0a 05 4f 53 45 43 a0 05 60 a4 0a 1f a1 04 a4  p..OSEC..`......
  1170: 0a 0f 5b 82 44 05 5c 2f 03 5f 53 42 5f 50 43 49  ..[.D.\/._SB_PCI
  1180: 30 41 43 30 5f 08 5f 48 49 44 0d 41 43 50 49 30  0AC0_._HID.ACPI0
  1190: 30 30 33 00 08 5f 50 43 4c 12 0c 01 5c 2e 5f 53  003.._PCL...\._S
  11a0: 42 5f 50 43 49 30 14 21 5f 50 53 52 00 a0 0c 92  B_PCI0.!_PSR....
  11b0: 93 46 41 4b 45 0a 00 a4 0a 00 a1 0d 70 0a 32 50  .FAKE.......p.2P
  11c0: 34 38 5f a4 41 43 49 4e 10 4b 0d 5c 5f 54 5a 5f  48_.ACIN.K.\_TZ_
  11d0: 08 46 41 4e 53 0a 00 5b 84 2f 46 4e 31 30 00 00  .FANS..[./FN10..
  11e0: 00 14 16 5f 53 54 41 00 7f 46 41 4e 53 0a 01 46  ..._STA..FANS..F
  11f0: 41 4e 53 a4 46 41 4e 53 14 07 5f 4f 4e 5f 00 a3  ANS.FANS.._ON_..
  1200: 14 07 5f 4f 46 46 00 a3 5b 82 1b 46 41 4e 31 08  .._OFF..[..FAN1.
  1210: 5f 48 49 44 0c 41 d0 0c 0b 08 5f 50 52 30 12 06  _HID.A...._PR0..
  1220: 01 46 4e 31 30 5b 85 4d 07 54 48 52 4d 14 30 4b  .FN10[.M.THRM.0K
  1230: 45 4c 56 01 a0 1a 94 68 0a 7f 7f 68 0a ff 60 72  ELV....h...h..`r
  1240: 60 0a 01 60 77 60 0a 0a 60 74 0b ac 0a 60 61 a1  `..`w`..`t...`a.
  1250: 0c 77 68 0a 0a 60 72 60 0b ac 0a 61 a4 61 14 16  .wh..`r`...a.a..
  1260: 5f 54 4d 50 00 70 0a a1 50 34 38 5f a4 4b 45 4c  _TMP.p..P48_.KEL
  1270: 56 54 4d 50 53 14 0d 5f 41 43 30 00 a4 4b 45 4c  VTMPS.._AC0..KEL
  1280: 56 0a 46 08 5f 41 4c 30 12 06 01 46 41 4e 31 14  V.F._AL0...FAN1.
  1290: 0d 5f 43 52 54 00 a4 4b 45 4c 56 0a 55 14 06 5f  ._CRT..KELV.U.._
  12a0: 53 43 50 01 5b 82 2a 5c 2e 5f 53 42 5f 4c 49 44  SCP.[.*\._SB_LID
  12b0: 44 08 5f 48 49 44 0c 41 d0 0c 0d 14 14 5f 4c 49  D._HID.A....._LI
  12c0: 44 00 70 4c 49 44 53 50 33 37 38 a4 4c 49 44 53  D.pLIDSP378.LIDS
  12d0: 08 53 50 49 4f 0a 2e 5b 01 53 49 4f 46 00 5b 80  .SPIO..[.SIOF.[.
  12e0: 57 49 4e 31 01 53 50 49 4f 0a 02 5b 81 10 57 49  WIN1.SPIO..[..WI
  12f0: 4e 31 01 49 4e 44 58 08 44 41 54 41 08 5b 86 48  N1.INDX.DATA.[.H
  1300: 08 49 4e 44 58 44 41 54 41 01 00 38 4c 44 4e 5f  .INDXDATA..8LDN_
  1310: 08 00 40 0c 43 46 47 30 08 43 46 47 31 08 43 46  ..-jOHg+bGSpLw7zw9eURiVuQ@public.gmane.org
  1320: 47 32 08 43 46 47 33 08 43 46 47 34 08 43 46 47  G2.CFG3.CFG4.CFG
  1330: 35 08 43 46 47 36 08 43 46 47 37 08 43 46 47 38  5.CFG6.CFG7.CFG8
  1340: 08 43 46 47 39 08 43 46 47 41 08 00 28 41 43 54  .CFG9.CFGA..(ACT
  1350: 52 08 00 48 17 49 4f 41 48 08 49 4f 41 4c 08 00  R..H.IOAH.IOAL..
  1360: 40 07 49 4e 54 52 08 00 08 49 4e 54 31 08 00 08  @.INTR...INT1...
  1370: 44 4d 43 48 08 00 48 3d 4f 50 54 30 08 4f 50 54  DMCH..H=3DOPT0.OPT
  1380: 31 08 4f 50 54 32 08 08 4c 44 46 44 0a 00 08 4c  1.OPT2..LDFD...L
  1390: 44 4c 50 0a 01 08 4c 44 55 32 0a 02 08 4c 44 49  DLP...LDU2...LDI
  13a0: 52 0a 02 08 4c 44 55 31 0a 03 08 4c 44 58 42 0a  R...LDU1...LDXB.
  13b0: 0f 08 46 44 53 54 0a 00 08 55 31 53 54 0a 00 08  ..FDST...U1ST...
  13c0: 55 32 53 54 0a 00 08 49 52 53 54 0a 00 08 4c 50  U2ST...IRST...LP
  13d0: 53 54 0a 00 14 4a 06 49 4f 44 54 00 a0 13 93 47  ST...J.IODT....G
  13e0: 53 54 41 4c 44 46 44 0a 0f 70 0a 01 46 44 53 54  STALDFD..p..FDST
  13f0: a0 13 93 47 53 54 41 4c 44 55 31 0a 0f 70 0a 01  ...GSTALDU1..p..
  1400: 55 31 53 54 a0 26 93 47 53 54 41 4c 44 55 32 0a  U1ST.&.GSTALDU2.
  1410: 0f a0 10 49 53 49 52 4c 44 55 32 70 0a 01 49 52  ...ISIRLDU2p..IR
  1420: 53 54 a1 08 70 0a 01 55 32 53 54 a0 13 93 47 53  ST..p..U2ST...GS
  1430: 54 41 4c 44 4c 50 0a 0f 70 0a 01 4c 50 53 54 14  TALDLP..p..LPST.
  1440: 1f 49 53 49 52 01 70 68 4c 44 4e 5f a0 0b 93 44  .ISIR.phLDN_...D
  1450: 4d 43 48 0a 04 70 00 60 a1 04 70 01 60 a4 60 14  MCH..p.`..p.`.`.
  1460: 30 47 53 54 41 01 70 68 4c 44 4e 5f a0 09 41 43  0GSTA.phLDN_..AC
  1470: 54 52 70 0a 0f 60 a1 17 a0 0f 7d 49 4f 41 48 49  TRp..`....}IOAHI
  1480: 4f 41 4c 00 70 0a 0d 60 a1 05 70 0a 00 60 a4 60  OAL.p..`..p..`.`
  1490: 14 12 44 44 49 53 01 70 68 4c 44 4e 5f 70 00 41  ..DDIS.phLDN_p.A
  14a0: 43 54 52 14 12 44 45 4e 42 01 70 68 4c 44 4e 5f  CTR..DENB.phLDN_
  14b0: 70 01 41 43 54 52 14 43 0b 50 43 52 53 03 8c 50  p.ACTR.C.PCRS..P
  14c0: 42 55 46 0a 02 49 4f 4c 4f 8c 50 42 55 46 0a 03  BUF..IOLO.PBUF..
  14d0: 49 4f 48 49 8b 50 42 55 46 0a 02 49 4f 48 4c 8b  IOHI.PBUF..IOHL.
  14e0: 50 42 55 46 0a 04 49 4f 52 4c 8c 50 42 55 46 0a  PBUF..IORL.PBUF.
  14f0: 06 41 4c 4d 4e 8c 50 42 55 46 0a 07 4c 45 4e 47  .ALMN.PBUF..LENG
  1500: 8c 50 42 55 46 0a 09 49 52 51 4c 70 68 4c 44 4e  .PBUF..IRQLphLDN
  1510: 5f 70 49 4f 41 48 49 4f 48 49 70 49 4f 41 4c 49  _pIOAHIOHIpIOALI
  1520: 4f 4c 4f 70 49 4f 48 4c 49 4f 52 4c 70 69 41 4c  OLOpIOHLIORLpiAL
  1530: 4d 4e a0 0f 93 49 4f 4c 4f 0a bc 70 0a 04 4c 45  MN...IOLO..p..LE
  1540: 4e 47 a1 07 70 6a 4c 45 4e 47 70 01 60 79 60 49  NG..pjLENGp.`y`I
  1550: 4e 54 52 49 52 51 4c a0 0d 93 49 4e 54 52 00 70  NTRIRQL...INTR.p
  1560: 00 49 52 51 4c a4 50 42 55 46 14 3f 47 53 52 53  .IRQL.PBUF.?GSRS
  1570: 02 8c 68 0a 02 47 4d 4c 42 8c 68 0a 03 47 4d 48  ..h..GMLB.h..GMH
  1580: 42 70 69 4c 44 4e 5f 74 47 4d 4c 42 0a 01 47 4d  BpiLDN_tGMLB..GM
  1590: 4c 42 70 47 4d 4c 42 49 4f 41 4c 70 47 4d 48 42  LBpGMLBIOALpGMHB
  15a0: 49 4f 41 48 70 01 41 43 54 52 14 4b 05 50 53 52  IOAHp.ACTR.K.PSR
  15b0: 53 02 8c 68 0a 02 50 4f 4c 42 8c 68 0a 03 50 4f  S..h..POLB.h..PO
  15c0: 48 42 8c 68 0a 09 50 49 52 51 70 69 4c 44 4e 5f  HB.h..PIRQpiLDN_
  15d0: 70 50 4f 4c 42 49 4f 41 4c 70 50 4f 48 42 49 4f  pPOLBIOALpPOHBIO
  15e0: 41 48 a0 0d 93 50 49 52 51 00 70 00 49 4e 54 52  AH...PIRQ.p.INTR
  15f0: a1 0f 82 50 49 52 51 60 74 60 0a 01 49 4e 54 52  ...PIRQ`t`..INTR
  1600: 70 01 41 43 54 52 14 4b 10 45 43 52 53 01 8c 45  p.ACTR.K.ECRS..E
  1610: 42 55 46 0a 02 45 50 4c 4f 8c 45 42 55 46 0a 03  BUF..EPLO.EBUF..
  1620: 45 50 48 49 8b 45 42 55 46 0a 02 45 50 48 4c 8b  EPHI.EBUF..EPHL.
  1630: 45 42 55 46 0a 04 45 50 52 4c 8b 45 42 55 46 0a  EBUF..EPRL.EBUF.
  1640: 06 41 4c 4d 31 8b 45 42 55 46 0a 0a 45 34 4c 4f  .ALM1.EBUF..E4LO
  1650: 8b 45 42 55 46 0a 0c 45 34 52 4c 8b 45 42 55 46  .EBUF..E4RL.EBUF
  1660: 0a 0e 45 34 41 4c 8b 45 42 55 46 0a 11 45 49 52  ..E4AL.EBUF..EIR
  1670: 51 8b 45 42 55 46 0a 14 45 44 4d 41 70 68 4c 44  Q.EBUF..EDMAphLD
  1680: 4e 5f 70 49 4f 41 48 45 50 48 49 70 49 4f 41 4c  N_pIOAHEPHIpIOAL
  1690: 45 50 4c 4f 70 45 50 48 4c 45 50 52 4c 72 45 50  EPLOpEPHLEPRLrEP
  16a0: 48 4c 0b 00 04 45 34 4c 4f 70 45 34 4c 4f 45 34  HL...E4LOpE4LOE4
  16b0: 52 4c a0 19 93 45 50 48 4c 0b bc 03 70 0b 01 04  RL...EPHL...p...
  16c0: 41 4c 4d 31 70 0b 01 04 45 34 41 4c a1 11 70 0b  ALM1p...E4AL..p.
  16d0: 01 08 41 4c 4d 31 70 0b 01 08 45 34 41 4c 70 01  ..ALM1p...E4ALp.
  16e0: 60 70 49 4e 54 52 61 79 60 61 45 49 52 51 70 44  `pINTRay`aEIRQpD
  16f0: 4d 43 48 61 a0 0c 94 61 0a 03 70 0a 00 45 44 4d  MCHa...a..p..EDM
  1700: 41 a1 0b 70 01 60 79 60 61 45 44 4d 41 a4 45 42  A..p.`y`aEDMA.EB
  1710: 55 46 14 40 07 45 53 52 53 02 8c 68 0a 02 4c 4f  UF.-VCzBQH90/MZFz/k3AGBT5Q@public.gmane.org
  1720: 45 50 8c 68 0a 03 48 49 45 50 8b 68 0a 11 49 52  EP.h..HIEP.h..IR
  1730: 51 45 8b 68 0a 14 44 4d 41 45 70 69 4c 44 4e 5f  QE.h..DMAEpiLDN_
  1740: 70 4c 4f 45 50 49 4f 41 4c 70 48 49 45 50 49 4f  pLOEPIOALpHIEPIO
  1750: 41 48 82 49 52 51 45 60 74 60 0a 01 49 4e 54 52  AH.IRQE`t`..INTR
  1760: a0 13 44 4d 41 45 82 44 4d 41 45 60 74 60 0a 01  ..DMAE.DMAE`t`..
  1770: 44 4d 43 48 a1 08 70 0a 04 44 4d 43 48 70 01 41  DMCH..p..DMCHp.A
  1780: 43 54 52 14 4d 0d 52 43 52 53 03 8c 46 42 55 46  CTR.M.RCRS..FBUF
  1790: 0a 02 46 52 4c 4f 8c 46 42 55 46 0a 03 46 52 48  ..FRLO.FBUF..FRH
  17a0: 49 8b 46 42 55 46 0a 02 46 52 48 4c 8b 46 42 55  I.FBUF..FRHL.FBU
  17b0: 46 0a 04 46 52 52 4c 8c 46 42 55 46 0a 06 46 41  F..FRRL.FBUF..FA
  17c0: 4c 4e 8c 46 42 55 46 0a 07 46 4c 45 4e 8c 46 42  LN.FBUF..FLEN.FB
  17d0: 55 46 0a 09 52 49 52 51 8b 46 42 55 46 0a 0c 52  UF..RIRQ.FBUF..R
  17e0: 44 4d 41 70 68 4c 44 4e 5f 70 49 4f 41 48 46 52  DMAphLDN_pIOAHFR
  17f0: 48 49 70 49 4f 41 4c 46 52 4c 4f 70 46 52 48 4c  HIpIOALFRLOpFRHL
  1800: 46 52 52 4c 70 69 46 41 4c 4e a0 0f 93 46 52 4c  FRRLpiFALN...FRL
  1810: 4f 0a bc 70 0a 04 46 4c 45 4e a1 07 70 6a 46 4c  O..p..FLEN..pjFL
  1820: 45 4e 70 01 60 79 60 49 4e 54 52 52 49 52 51 a0  ENp.`y`INTRRIRQ.
  1830: 0d 93 49 4e 54 52 00 70 00 52 49 52 51 70 44 4d  ..INTR.p.RIRQpDM
  1840: 43 48 61 a0 0c 94 61 0a 03 70 0a 00 52 44 4d 41  CHa...a..p..RDMA
  1850: a1 0b 70 01 60 79 60 61 52 44 4d 41 a4 46 42 55  ..p.`y`aRDMA.FBU
  1860: 46 14 40 08 46 53 52 53 02 8c 68 0a 02 4c 4f 46  F.-bM+W84E7KpCBY4Er2a5asg@public.gmane.org
  1870: 52 8c 68 0a 03 48 49 46 52 8c 68 0a 09 46 49 52  R.h..HIFR.h..FIR
  1880: 51 8c 68 0a 0c 46 44 4d 41 70 69 4c 44 4e 5f 70  Q.h..FDMApiLDN_p
  1890: 4c 4f 46 52 49 4f 41 4c 70 48 49 46 52 49 4f 41  LOFRIOALpHIFRIOA
  18a0: 48 a0 0d 93 46 49 52 51 00 70 00 49 4e 54 52 a1  H...FIRQ.p.INTR.
  18b0: 0f 82 46 49 52 51 60 74 60 0a 01 49 4e 54 52 a0  ..FIRQ`t`..INTR.
  18c0: 13 46 44 4d 41 82 46 44 4d 41 60 74 60 0a 01 44  .FDMA.FDMA`t`..D
  18d0: 4d 43 48 a1 08 70 0a 04 44 4d 43 48 70 01 41 43  MCH..p..DMCHp.AC
  18e0: 54 52 08 46 43 52 53 11 23 0a 20 47 01 f2 03 f2  TR.FCRS.#. G....
  18f0: 03 01 02 47 01 f4 03 f4 03 01 02 47 01 f7 03 f7  ...G.......G....
  1900: 03 01 01 22 40 00 2a 04 00 79 00 08 50 42 55 46  ..."@.*..y..PBUF
  1910: 11 10 0a 0d 47 01 00 00 00 00 01 08 22 01 00 79  ....G......."..y
  1920: 00 08 46 42 55 46 11 13 0a 10 47 01 00 00 00 00  ..FBUF....G.....
  1930: 01 08 22 01 00 2a 00 00 79 00 08 45 42 55 46 11  .."..*..y..EBUF.
  1940: 1b 0a 18 47 01 78 03 78 03 01 08 47 01 78 07 78  ...G.x.x...G.x.x
  1950: 07 01 08 22 80 00 2a 00 00 79 00 5b 80 5c 46 44  ..."..*..y.[.\FD
  1960: 43 43 01 0b f0 03 0a 08 5b 81 0e 5c 46 44 43 43  CC......[..\FDCC
  1970: 01 00 20 46 44 43 34 08 08 46 50 52 53 11 26 0a  .. FDC4..FPRS.&.
  1980: 23 31 00 47 01 f2 03 f2 03 01 02 47 01 f4 03 f4  #1.G.......G....
  1990: 03 01 02 47 01 f7 03 f7 03 01 01 22 40 00 2a 04  ...G......."@.*.
  19a0: 00 38 79 00 5b 82 4f 0a 46 44 43 30 08 5f 48 49  .8y.[.O.FDC0._HI
  19b0: 44 0c 41 d0 07 00 14 4c 04 5f 53 54 41 00 a0 41  D.A....L._STA..A
  19c0: 04 46 44 53 54 5b 23 53 49 4f 46 ff ff 70 4c 44  .FDST[#SIOF..pLD
  19d0: 46 44 4c 44 4e 5f a0 09 41 43 54 52 70 0a 0f 60  FDLDN_..ACTRp..`
  19e0: a1 17 a0 0f 7d 49 4f 41 48 49 4f 41 4c 00 70 0a  ....}IOAHIOAL.p.
  19f0: 0d 60 a1 05 70 0a 00 60 5b 27 53 49 4f 46 a4 60  .`..p..`['SIOF.`
  1a00: a4 0a 00 14 1c 5f 44 49 53 00 5b 23 53 49 4f 46  ....._DIS.[#SIOF
  1a10: ff ff 44 44 49 53 4c 44 46 44 5b 27 53 49 4f 46  ..DDISLDFD['SIOF
  1a20: 14 0b 5f 43 52 53 00 a4 46 43 52 53 14 0b 5f 50  .._CRS..FCRS.._P
  1a30: 52 53 00 a4 46 50 52 53 14 1c 5f 53 52 53 01 5b  RS..FPRS.._SRS.[
  1a40: 23 53 49 4f 46 ff ff 44 45 4e 42 4c 44 46 44 5b  #SIOF..DENBLDFD[
  1a50: 27 53 49 4f 46 08 46 44 50 53 0a 00 5b 84 30 46  'SIOF.FDPS..[.0F
  1a60: 44 44 50 00 00 00 14 0b 5f 53 54 41 00 a4 46 44  DDP....._STA..FD
  1a70: 50 53 14 0d 5f 4f 4e 5f 00 70 0a 01 46 44 50 53  PS.._ON_.p..FDPS
  1a80: 14 0d 5f 4f 46 46 00 70 0a 00 46 44 50 53 08 4c  .._OFF.p..FDPS.L
  1a90: 50 50 52 11 37 0a 34 31 00 47 01 78 03 78 03 01  PPR.7.41.G.x.x..
  1aa0: 08 22 80 00 30 47 01 78 03 78 03 01 08 22 a0 00  ."..0G.x.x..."..
  1ab0: 30 47 01 78 02 78 02 01 08 22 a0 00 30 47 01 bc  0G.x.x..."..0G..
  1ac0: 03 bc 03 01 04 22 a0 00 38 79 00 08 45 50 52 53  ....."..8y..EPRS
  1ad0: 11 49 0a 0a a5 31 00 47 01 78 03 78 03 01 08 47  .I...1.G.x.x...G
  1ae0: 01 78 07 78 07 01 08 22 80 00 2a 02 00 30 47 01  .x.x..."..*..0G.
  1af0: 78 03 78 03 01 08 47 01 78 07 78 07 01 08 22 a0  x.x...G.x.x...".
  1b00: 00 2a 0b 00 30 47 01 78 02 78 02 01 08 47 01 78  .*..0G.x.x...G.x
  1b10: 06 78 06 01 08 22 a0 00 2a 0b 00 30 47 01 bc 03  .x..."..*..0G...
  1b20: bc 03 01 04 47 01 bc 07 bc 07 01 04 22 a0 00 2a  ....G......."..*
  1b30: 0b 00 30 47 01 78 03 78 03 01 08 47 01 78 07 78  ..0G.x.x...G.x.x
  1b40: 07 01 04 22 a0 00 2a 00 00 30 47 01 78 02 78 02  ..."..*..0G.x.x.
  1b50: 01 08 47 01 78 06 78 06 01 04 22 a0 00 2a 00 00  ..G.x.x..."..*..
  1b60: 30 47 01 bc 03 bc 03 01 04 47 01 bc 07 bc 07 01  0G.......G......
  1b70: 04 22 a0 00 2a 00 00 38 79 00 5b 82 40 0c 4c 50  ."..*..8y.[.-cthDQAQR1OQ@public.gmane.org
  1b80: 54 5f 08 5f 48 49 44 0c 41 d0 04 00 14 4a 06 5f  T_._HID.A....J._
  1b90: 53 54 41 00 5b 23 53 49 4f 46 ff ff 70 4c 44 4c  STA.[#SIOF..pLDL
  1ba0: 50 4c 44 4e 5f 70 44 4d 43 48 61 5b 27 53 49 4f  PLDN_pDMCHa['SIO
  1bb0: 46 a0 41 04 93 61 0a 04 5b 23 53 49 4f 46 ff ff  F.A..a..[#SIOF..
  1bc0: 70 4c 44 4c 50 4c 44 4e 5f a0 09 41 43 54 52 70  pLDLPLDN_..ACTRp
  1bd0: 0a 0f 60 a1 17 a0 0f 7d 49 4f 41 48 49 4f 41 4c  ..`....}IOAHIOAL
  1be0: 00 70 0a 0d 60 a1 05 70 0a 00 60 5b 27 53 49 4f  .p..`..p..`['SIO
  1bf0: 46 a4 60 a1 03 a4 00 14 06 5f 44 49 53 00 14 13  F.`......_DIS...
  1c00: 5f 43 52 53 00 a4 50 43 52 53 4c 44 4c 50 0a 01  _CRS..PCRSLDLP..
  1c10: 0a 08 14 1d 5f 53 52 53 01 5b 23 53 49 4f 46 ff  ...._SRS.[#SIOF.
  1c20: ff 50 53 52 53 68 4c 44 4c 50 5b 27 53 49 4f 46  .PSRShLDLP['SIOF
  1c30: 14 0b 5f 50 52 53 00 a4 4c 50 50 52 5b 82 45 0a  .._PRS..LPPR[.E.
  1c40: 45 43 50 5f 08 5f 48 49 44 0c 41 d0 04 01 14 47  ECP_._HID.A....G
  1c50: 05 5f 53 54 41 00 5b 23 53 49 4f 46 ff ff 70 4c  ._STA.[#SIOF..pL
  1c60: 44 4c 50 4c 44 4e 5f 70 44 4d 43 48 61 5b 27 53  DLPLDN_pDMCHa['S
  1c70: 49 4f 46 a0 07 93 61 0a 04 a4 00 a1 2a 5b 23 53  IOF...a.....*[#S
  1c80: 49 4f 46 ff ff 70 4c 44 4c 50 4c 44 4e 5f a0 09  IOF..pLDLPLDN_..
  1c90: 41 43 54 52 70 0a 0f 60 a1 05 70 0a 00 60 5b 27  ACTRp..`..p..`['
  1ca0: 53 49 4f 46 a4 60 14 06 5f 44 49 53 00 14 0d 5f  SIOF.`.._DIS..._
  1cb0: 43 52 53 00 a4 45 43 52 53 0a 01 14 1b 5f 53 52  CRS..ECRS...._SR
  1cc0: 53 01 5b 23 53 49 4f 46 ff ff 45 53 52 53 68 0a  S.[#SIOF..ESRSh.
  1cd0: 01 5b 27 53 49 4f 46 14 0b 5f 50 52 53 00 a4 45  .['SIOF.._PRS..E
  1ce0: 50 52 53 08 4c 50 50 53 0a 00 5b 84 30 4c 50 54  PRS.LPPS..[.0LPT
  1cf0: 50 00 00 00 14 0b 5f 53 54 41 00 a4 4c 50 50 53  P....._STA..LPPS
  1d00: 14 0d 5f 4f 4e 5f 00 70 0a 01 4c 50 50 53 14 0d  .._ON_.p..LPPS..
  1d10: 5f 4f 46 46 00 70 0a 00 4c 50 50 53 08 55 32 50  _OFF.p..LPPS.U2P
  1d20: 52 11 44 04 0a 40 31 00 47 01 f8 02 f8 02 04 08  R.D..-KTiyNQFeV66tXF2fZOsJYA@public.gmane.org
  1d30: 22 08 00 30 47 01 f8 02 f8 02 04 08 22 18 0c 30  "..0G......."..0
  1d40: 47 01 f8 03 f8 03 04 08 22 18 0c 30 47 01 e8 03  G......."..0G...
  1d50: e8 03 04 08 22 18 0c 30 47 01 e8 02 e8 02 04 08  ...."..0G.......
  1d60: 22 18 0c 38 79 00 08 49 52 50 52 11 43 05 0a 4f  "..8y..IRPR.C..O
  1d70: 31 00 47 01 f8 02 f8 02 04 08 22 08 00 2a 01 00  1.G......."..*..
  1d80: 30 47 01 f8 02 f8 02 04 08 22 18 0c 2a 0b 00 30  0G......."..*..0
  1d90: 47 01 f8 03 f8 03 04 08 22 18 0c 2a 0b 00 30 47  G......."..*..0G
  1da0: 01 e8 03 e8 03 04 08 22 18 0c 2a 0b 00 30 47 01  ......."..*..0G.
  1db0: e8 02 e8 02 04 08 22 18 0c 2a 0b 00 38 79 00 5b  ......"..*..8y.[
  1dc0: 82 40 0d 49 52 44 41 14 1a 5f 48 49 44 00 a0 0b  .-tghZWgRHstfJipH/VUJ44Q@public.gmane.org
  1dd0: 49 52 53 54 a4 0c 3a 63 60 01 a1 07 a4 0c 41 d0  IRST..:c`.....A.
  1de0: 05 10 08 5f 55 49 44 0a 02 14 2f 5f 53 54 41 00  ..._UID.../_STA.
  1df0: 5b 23 53 49 4f 46 ff ff 70 4c 44 55 32 4c 44 4e  [#SIOF..pLDU2LDN
  1e00: 5f a0 09 41 43 54 52 70 0a 0f 60 a1 05 70 0a 00  _..ACTRp..`..p..
  1e10: 60 5b 27 53 49 4f 46 a4 60 14 06 5f 44 49 53 00  `['SIOF.`.._DIS.
  1e20: 14 28 5f 43 52 53 00 a0 12 49 52 53 54 a4 52 43  .(_CRS...IRST.RC
  1e30: 52 53 4c 44 49 52 0a 01 0a 08 a1 0e a4 50 43 52  RSLDIR.......PCR
  1e40: 53 4c 44 55 32 0a 01 0a 08 14 2e 5f 53 52 53 01  SLDU2......_SRS.
  1e50: 5b 23 53 49 4f 46 ff ff a0 0e 49 52 53 54 46 53  [#SIOF....IRSTFS
  1e60: 52 53 68 4c 44 49 52 a1 0a 50 53 52 53 68 4c 44  RShLDIR..PSRShLD
  1e70: 55 32 5b 27 53 49 4f 46 14 18 5f 50 52 53 00 a0  U2['SIOF.._PRS..
  1e80: 0a 49 52 53 54 a4 49 52 50 52 a1 06 a4 55 32 50  .IRST.IRPR...U2P
  1e90: 52 08 49 52 50 53 0a 00 5b 84 30 55 52 50 32 01  R.IRPS..[.0URP2.
  1ea0: 00 00 14 0b 5f 53 54 41 00 a4 49 52 50 53 14 0d  ...._STA..IRPS..
  1eb0: 5f 4f 4e 5f 00 70 0a 01 49 52 50 53 14 0d 5f 4f  _ON_.p..IRPS.._O
  1ec0: 46 46 00 70 0a 00 49 52 50 53 08 55 31 50 52 11  FF.p..IRPS.U1PR.
  1ed0: 44 04 0a 40 31 00 47 01 f8 03 f8 03 04 08 22 10  D..-KTiyNQFeV66tXF2fZOsJYA@public.gmane.org".
  1ee0: 00 30 47 01 f8 03 f8 03 04 08 22 18 0c 30 47 01  .0G......."..0G.
  1ef0: f8 02 f8 02 04 08 22 18 0c 30 47 01 e8 03 e8 03  ......"..0G.....
  1f00: 04 08 22 18 0c 30 47 01 e8 02 e8 02 04 08 22 18  .."..0G.......".
  1f10: 0c 38 79 00 5b 82 4f 0b 55 41 52 31 08 5f 48 49  .8y.[.O.UAR1._HI
  1f20: 44 0c 41 d0 05 01 08 5f 55 49 44 0a 01 14 4c 04  D.A...._UID...L.
  1f30: 5f 53 54 41 00 a0 41 04 55 31 53 54 5b 23 53 49  _STA..A.U1ST[#SI
  1f40: 4f 46 ff ff 70 4c 44 55 31 4c 44 4e 5f a0 09 41  OF..pLDU1LDN_..A
  1f50: 43 54 52 70 0a 0f 60 a1 17 a0 0f 7d 49 4f 41 48  CTRp..`....}IOAH
  1f60: 49 4f 41 4c 00 70 0a 0d 60 a1 05 70 0a 00 60 5b  IOAL.p..`..p..`[
  1f70: 27 53 49 4f 46 a4 60 a4 0a 00 14 1c 5f 44 49 53  'SIOF.`....._DIS
  1f80: 00 5b 23 53 49 4f 46 ff ff 44 44 49 53 4c 44 55  .[#SIOF..DDISLDU
  1f90: 31 5b 27 53 49 4f 46 14 13 5f 43 52 53 00 a4 50  1['SIOF.._CRS..P
  1fa0: 43 52 53 4c 44 55 31 0a 01 0a 08 14 1d 5f 53 52  CRSLDU1......_SR
  1fb0: 53 01 5b 23 53 49 4f 46 ff ff 50 53 52 53 68 4c  S.[#SIOF..PSRShL
  1fc0: 44 55 31 5b 27 53 49 4f 46 14 0b 5f 50 52 53 00  DU1['SIOF.._PRS.
  1fd0: a4 55 31 50 52 08 43 41 50 53 0a 00 5b 84 30 55  .U1PR.CAPS..[.0U
  1fe0: 52 50 31 01 00 00 14 0b 5f 53 54 41 00 a4 43 41  RP1....._STA..CA
  1ff0: 50 53 14 0d 5f 4f 4e 5f 00 70 0a 01 43 41 50 53  PS.._ON_.p..CAPS
  2000: 14 0d 5f 4f 46 46 00 70 0a 00 43 41 50 53 14 12  .._OFF.p..CAPS..
  2010: 50 4d 42 53 00 7d 79 0a 50 0a 08 00 0a 00 60 a4  PMBS.}y.P.....`.
  2020: 60 14 12 53 4d 42 53 00 7d 79 0a 50 0a 08 00 0a  `..SMBS.}y.P....
  2030: 80 60 a4 60 5b 80 50 57 52 47 01 50 4d 42 53 0a  .`.`[.PWRG.PMBS.
  2040: 80 5b 80 53 4d 52 47 01 53 4d 42 53 0a 20 5b 82  .[.SMRG.SMBS. [.
  2050: 4b 29 49 44 45 43 08 5f 41 44 52 0a 01 08 52 54  K)IDEC._ADR...RT
  2060: 54 5f 12 22 10 0a 0c 0a 01 0a 02 0a 03 0a 04 0a  T_."............
  2070: 05 0a 06 0a 07 0a 08 0a 09 0a 0a 0a 0b 0a 0d 0a  ................
  2080: 0e 0a 0f 0a 0f 08 44 41 54 54 12 12 08 0a 08 0a  ......DATT......
  2090: 01 0a 02 0a 03 0a 04 0a 05 0a 06 0a 0c 08 55 44  ..............UD
  20a0: 54 54 12 12 08 0a 14 0a 1e 0a 32 0a 3c 0a 50 0a  TT........2.<.P.
  20b0: 5a 0a 6e 0a 78 5b 80 50 43 49 31 02 0a 40 0a 08  Z.n.x[.PCI1..-rVxdn2TrCWA@public.gmane.org
  20c0: 5b 81 1a 50 43 49 31 03 50 4d 54 4d 10 50 53 54  [..PCI1.PMTM.PST
  20d0: 4d 10 53 4d 54 4d 10 53 53 54 4d 10 08 47 4d 42  M.SMTM.SSTM..GMB
  20e0: 55 11 04 0a 14 00 14 48 15 47 54 4d 5f 02 70 47  U......H.GTM_.pG
  20f0: 4d 42 55 60 8a 60 0a 00 50 49 4f 30 8a 60 0a 04  MBU`.`..PIO0.`..
  2100: 44 4d 41 30 8a 60 0a 08 50 49 4f 31 8a 60 0a 0c  DMA0.`..PIO1.`..
  2110: 44 4d 41 31 8a 60 0a 10 46 4c 41 47 70 7b 68 0a  DMA1.`..FLAGp{h.
  2120: 0f 00 62 70 83 88 52 54 54 5f 62 00 61 70 7a 7b  ..bp..RTT_b.apz{
  2130: 68 0b 00 07 00 0a 08 00 62 70 83 88 44 41 54 54  h.......bp..DATT
  2140: 62 00 62 72 61 62 61 77 61 0a 1e 50 49 4f 30 70  b.brabawa..PIO0p
  2150: 7a 7b 68 0b 00 70 00 0a 0c 00 62 70 83 88 55 44  z{h..p....bp..UD
  2160: 54 54 62 00 44 4d 41 30 a0 1d 7b 68 0b 00 80 00  TTb.DMA0..{h....
  2170: 7d 46 4c 41 47 0a 01 46 4c 41 47 7d 46 4c 41 47  }FLAG..FLAG}FLAG
  2180: 0a 02 46 4c 41 47 a1 20 a0 14 93 7b 68 0a 07 00  ..FLAG. ...{h...
  2190: 0a 03 7d 46 4c 41 47 0a 02 46 4c 41 47 70 0c ff  ..}FLAG..FLAGp..
  21a0: ff ff ff 44 4d 41 30 70 7b 69 0a 0f 00 62 70 83  ...DMA0p{i...bp.
  21b0: 88 52 54 54 5f 62 00 61 70 7a 7b 69 0b 00 07 00  .RTT_b.apz{i....
  21c0: 0a 08 00 62 70 83 88 44 41 54 54 62 00 62 72 61  ...bp..DATTb.bra
  21d0: 62 61 77 61 0a 1e 50 49 4f 31 70 7a 7b 69 0b 00  bawa..PIO1pz{i..
  21e0: 70 00 0a 0c 00 62 70 83 88 55 44 54 54 62 00 44  p....bp..UDTTb.D
  21f0: 4d 41 31 a0 1d 7b 69 0b 00 80 00 7d 46 4c 41 47  MA1..{i....}FLAG
  2200: 0a 04 46 4c 41 47 7d 46 4c 41 47 0a 08 46 4c 41  ..FLAG}FLAG..FLA
  2210: 47 a1 20 a0 14 93 7b 69 0a 07 00 0a 03 7d 46 4c  G. ...{i.....}FL
  2220: 41 47 0a 08 46 4c 41 47 70 0c ff ff ff ff 44 4d  AG..FLAGp.....DM
  2230: 41 31 7d 46 4c 41 47 0a 10 46 4c 41 47 a4 60 5b  A1}FLAG..FLAG.`[
  2240: 82 44 05 50 52 49 4d 08 5f 41 44 52 0a 00 08 53  .D.PRIM._ADR...S
  2250: 54 41 54 0a 00 14 1c 5f 47 54 4d 00 70 47 4d 42  TAT...._GTM.pGMB
  2260: 55 60 70 47 54 4d 5f 50 4d 54 4d 50 53 54 4d 60  U`pGTM_PMTMPSTM`
  2270: a4 60 14 06 5f 53 54 4d 03 5b 82 0c 4d 41 53 54  .`.._STM.[..MAST
  2280: 08 5f 41 44 52 0a 00 5b 82 0c 53 4c 41 56 08 5f  ._ADR..[..SLAV._
  2290: 41 44 52 0a 01 5b 82 44 05 53 45 43 4e 08 5f 41  ADR..[.D.SECN._A
  22a0: 44 52 0a 01 08 53 54 41 54 0a 00 14 1c 5f 47 54  DR...STAT...._GT
  22b0: 4d 00 70 47 4d 42 55 60 70 47 54 4d 5f 53 4d 54  M.pGMBU`pGTM_SMT
  22c0: 4d 53 53 54 4d 60 a4 60 14 06 5f 53 54 4d 03 5b  MSSTM`.`.._STM.[
  22d0: 82 0c 4d 41 53 54 08 5f 41 44 52 0a 00 5b 82 0c  ..MAST._ADR..[..
  22e0: 53 4c 41 56 08 5f 41 44 52 0a 01 5b 82 1b 4c 41  SLAV._ADR..[..LA
  22f0: 4e 5f 08 5f 41 44 52 0c 01 00 01 00 08 5f 50 52  N_._ADR......_PR
  2300: 57 12 06 02 0a 0c 0a 01 5b 82 0f 41 55 44 5f 08  W.......[..AUD_.
  2310: 5f 41 44 52 0c 04 00 01 00 08 53 4c 50 53 0a 00  _ADR......SLPS..
  2320: 5b 82 45 07 53 4c 50 42 08 5f 48 49 44 0c 41 d0  [.E.SLPB._HID.A.
  2330: 0c 0e 14 09 5f 53 54 41 00 a4 0a 0b 14 2a 53 42  ...._STA.....*SB
  2340: 45 56 00 a0 13 53 4c 50 53 70 0a 00 53 4c 50 53  EV...SLPSp..SLPS
  2350: 86 53 4c 50 42 0a 02 a1 0f 70 0a 01 53 4c 50 53  .SLPB....p..SLPS
  2360: 86 53 4c 50 42 0a 80 10 23 5c 5f 47 50 45 14 15  .SLPB...#\_GPE..
  2370: 5f 4c 30 46 00 5c 2f 03 5f 53 42 5f 53 4c 50 42  _L0F.\/._SB_SLPB
  2380: 53 42 45 56 14 06 5f 4c 30 32 00 08 5f 50 52 57  SBEV.._L02.._PRW
  2390: 12 06 02 0a 0f 0a 04 08 50 42 53 54 0a 00 5b 82  ........PBST..[.
  23a0: 0f 50 57 52 42 08 5f 48 49 44 0c 41 d0 0c 0c 5b  .PWRB._HID.A...[
  23b0: 80 46 4e 4f 52 01 0b 95 02 0a 02 5b 81 10 46 4e  .FNOR......[..FN
  23c0: 4f 52 01 46 49 4e 44 08 46 44 54 41 08 14 48 08  OR.FIND.FDTA..H.
  23d0: 5f 50 54 53 01 a0 34 93 68 0a 01 70 68 50 33 37  _PTS..4.h..phP37
  23e0: 38 70 0a b1 50 34 38 5f a0 21 4c 44 4f 46 a0 1b  8p..P48_.!LDOF..
  23f0: 92 93 5c 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46  ..\/._SB_PCI0OSF
  2400: 4c 0a 02 70 0a 31 50 34 38 5f a0 17 93 68 0a 04  L..p.1P48_...h..
  2410: 5b 22 0b b8 0b 70 68 50 33 37 38 70 0a b4 50 34  ["...phP378p..P4
  2420: 38 5f a0 12 93 68 0a 05 70 68 50 33 37 38 70 0a  8_...h..phP378p.
  2430: 01 4d 55 54 45 70 0a 01 5c 2e 5f 53 42 5f 53 4c  .MUTEp..\._SB_SL
  2440: 50 53 70 0a 01 5c 2e 5f 53 42 5f 50 42 53 54 70  PSp..\._SB_PBSTp
  2450: 0a 00 4c 44 4f 46 14 4c 06 5f 57 41 4b 01 72 68  ..LDOF.L._WAK.rh
  2460: 0a 06 60 7d 60 0a b0 60 70 60 50 34 38 5f 79 68  ..`}`..`p`P48_yh
  2470: 0a 04 44 42 47 38 a0 12 93 68 0a 04 86 5c 2e 5f  ..DBG8...h...\._
  2480: 53 42 5f 50 57 52 42 0a 02 a1 39 a0 21 92 93 5c  SB_PWRB...9.!..\
  2490: 2f 03 5f 53 42 5f 50 43 49 30 4f 53 46 4c 0a 02  /._SB_PCI0OSFL..
  24a0: 86 5c 2e 5f 53 42 5f 53 4c 50 42 0a 02 a1 15 a0  .\._SB_SLPB.....
  24b0: 13 92 52 54 43 57 86 5c 2e 5f 53 42 5f 53 4c 50  ..RTCW.\._SB_SLP
  24c0: 42 0a 02 5b 80 54 45 4d 50 01 0b 78 03 0a 01 5b  B..[.TEMP..x...[
  24d0: 81 0b 54 45 4d 50 01 44 42 47 38 08 5b 80 44 45  ..TEMP.DBG8.[.DE
  24e0: 42 30 01 0a 90 0a 02 5b 81 0b 44 45 42 30 02 44  B0.....[..DEB0.D
  24f0: 42 47 39 10 5b 80 50 52 34 38 01 0b 48 50 0a 01  BG9.[.PR48..HP..
  2500: 5b 81 0b 50 52 34 38 01 50 34 38 5f 08 5b 80 4d  [..PR48.P48_.[.M
  2510: 34 44 30 00 0b d0 04 0a 06 5b 81 35 4d 34 44 30  4D0......[.5M4D0
  2520: 03 52 43 41 50 10 46 43 41 50 10 00 01 42 41 54  .RCAP.FCAP...BAT
  2530: 50 01 42 41 54 43 01 41 43 43 50 01 46 42 41 54  P.BATC.ACCP.FBAT
  2540: 02 46 41 4e 46 01 52 54 43 57 01 54 4d 50 53 08  .FANF.RTCW.TMPS.
  2550: 5b 80 53 4d 42 50 01 0b 80 50 0a 10 5b 81 47 05  [.SMBP...P..[.G.
  2560: 53 4d 42 50 01 53 53 54 53 08 53 45 4e 42 08 53  SMBP.SSTS.SENB.S
  2570: 43 54 4c 08 53 48 43 54 08 53 41 44 52 08 53 43  CTL.SHCT.SADR.SC
  2580: 4d 44 08 53 50 43 54 08 53 43 4e 54 08 53 44 54  MD.SPCT.SCNT.SDT
  2590: 30 08 53 44 54 31 08 53 44 54 32 08 53 44 54 33  0.SDT1.SDT2.SDT3
  25a0: 08 53 44 54 34 08 53 44 54 35 08 53 44 54 36 08  .SDT4.SDT5.SDT6.
  25b0: 53 44 54 37 08 5b 80 50 4d 52 47 01 0b 00 50 0a  SDT7.[.PMRG...P.
  25c0: 80 5b 81 17 50 4d 52 47 01 00 20 53 43 49 46 01  .[..PMRG.. SCIF.
  25d0: 00 47 1b 00 02 4d 55 54 45 01 5b 80 50 4f 36 31  .G...MUTE.[.PO61
  25e0: 01 0a 61 0a 01 5b 81 0b 50 4f 36 31 01 50 36 31  ..a..[..PO61.P61
  25f0: 5f 08 5b 80 58 58 58 58 01 0b 78 03 0a 01 5b 81  _.[.XXXX..x...[.
  2600: 0b 58 58 58 58 01 50 33 37 38 08 08 56 41 52 30  .XXXX.P378..VAR0
  2610: 0a 0f 08 46 41 4b 45 0a 00 08 4c 49 44 53 0a 01  ...FAKE...LIDS..
  2620: 08 4c 44 4f 46 0a 00 5b 80 42 53 4d 4d 00 0c 00  .LDOF..[.BSMM...
  2630: f0 7f 1f 0b 00 01 5b 81 48 07 42 53 4d 4d 01 42  ......[.H.BSMM.B
  2640: 49 46 30 10 42 49 46 31 10 42 49 46 32 10 42 49  IF0.BIF1.BIF2.BI
  2650: 46 33 10 42 49 46 34 10 42 49 46 35 10 42 49 46  F3.BIF4.BIF5.BIF
  2660: 36 10 42 49 46 37 10 42 49 46 38 10 42 49 46 39  6.BIF7.BIF8.BIF9
  2670: 40 04 42 49 46 41 40 04 42 49 46 42 40 04 42 49  @.BIFA-hjOBl/4Ks2A@public.gmane.org@.BI
  2680: 46 43 40 04 42 53 54 30 10 42 53 54 31 10 42 53  FC-aCm63R4sOnWqbcg9QqdPFQ@public.gmane.org
  2690: 54 32 10 42 53 54 33 10 42 54 50 30 10 41 43 49  T2.BST3.BTP0.ACI
  26a0: 4e 01 00 01 42 54 49 4e 01 00 1d 4f 53 45 43 08  N...BTIN...OSEC.

FACS @ 0x1f7f8000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS-BlbsxGdv4A7jshiNgxcy3g@public.gmane.org
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................


-- lspci -vv

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=3D64M]
	Capabilities: <available only to root>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)=
 (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B s=
tep)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 16
	Region 4: I/O ports at ff00 [size=3D16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100=
 Ethernet (rev 82)
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d000 [size=3D256]
	Region 1: Memory at dffc0000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at dffa0000 [disabled] [size=3D128K]
	Capabilities: <available only to root>

00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller=
 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at dffd0000 (32-bit, non-prefetchable) [size=3D4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller=
 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] Onboard USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at dffe0000 (32-bit, non-prefetchable) [size=3D4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS P=
CI Audio Accelerator (rev 02)
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d400 [size=3D256]
	Region 1: Memory at dfff0000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <available only to root>

00:01.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (r=
ev a0) (prog-if 00 [Generic])
	Subsystem: Uniwill Computer Corp: Unknown device 4003
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=3D256]
	Region 1: I/O ports at d800 [size=3D128]
	Capabilities: <available only to root>

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual PCI-to=
-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: Uniwill Computer Corp: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 1f800000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D00, secondary=3D02, subordinate=3D05, sec-latency=3D176
	Memory window 0: 1fc00000-1ffff000 (prefetchable)
	Memory window 1: 20000000-203ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 =
GUI Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	BIST result: 00
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at ac80 [size=3D128]
	Capabilities: <available only to root>


-- cat /proc/interrupts

           CPU0      =20
  0:    3500151          XT-PIC  timer
  1:      10259          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      19089          XT-PIC  eth0
 11:          6          XT-PIC  yenta, Trident Audio
 12:      23423          XT-PIC  i8042
 14:      44553          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0=20
LOC:    3500294=20
ERR:          0


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tS9z6//kSTNjoX0RAiL4AJ9cakJZ93FwoULYeK2xW77vjiDN3wCghIRT
SPAuD9VFb6VkXKspWVnZW5o=
=i1kd
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
