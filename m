From: Hugo Haas <hugo-rQR7RsZM/uVeoWH0uzbU5w@public.gmane.org>
Subject: Can set all but active[2] temperature via trip_points
Date: Sun, 25 Apr 2004 07:57:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040425055737.GA7358@home.larve.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I have found a weird problem: using
/proc/acpi/thermal_zone/TZ1/trip_points, I can set all but the
active[2] temperature.

root-bb4ugweF86o@public.gmane.org:/proc/acpi/thermal_zone/TZ1# cat *
<not supported>
<polling disabled>
state:                   active[2]
temperature:             44 C
critical (S5):           94 C
passive:                 90 C: tc1=3D1 tc2=3D2 tsp=3D100 devices=3D0xc1522c=
00=20
active[0]:               80 C: devices=3D0xc1524d20=20
active[1]:               65 C: devices=3D0xc1524c80=20
active[2]:               40 C: devices=3D0xc1524c00=20

root-bb4ugweF86o@public.gmane.org:/proc/acpi/thermal_zone/TZ1# echo -n "95:0:91:81:66:41" > trip_p=
oints=20

root-bb4ugweF86o@public.gmane.org:/proc/acpi/thermal_zone/TZ1# cat *
<not supported>
<polling disabled>
state:                   active[2]
temperature:             44 C
critical (S5):           95 C
passive:                 91 C: tc1=3D1 tc2=3D2 tsp=3D100 devices=3D0xc1522c=
00=20
active[0]:               81 C: devices=3D0xc1524d20=20
active[1]:               66 C: devices=3D0xc1524c80=20
active[2]:               40 C: devices=3D0xc1524c00

This is using a 2.6.5 kernel + swsusp2. I don't see any error message
anywhere.

dmesg says:

Linux version 2.6.5 (root-bb4ugweF86o@public.gmane.org) (gcc version 3.3.3 (Debian 20040401)) #1 S=
at Apr 24 14:44:33 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
 BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
 BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131024
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126928 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f6a60
ACPI: RSDT (v001 COMPAQ CPQ004C  0x15120320 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 COMPAQ CPQ004C  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ   CPQCPU 0x00001001 MSFT 0x0100000e) @ 0x1fff6dd7
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff6e22
ACPI: DSDT (v001 COMPAQ EVON410C 0x00010000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=3D/dev/hda2 ro resume2=3Dswap:/dev/hda4=20
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1196.168 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515660k/524096k available (1578k kernel code, 7668k reserved, 636k =
data, 108k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2367.48 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf03a2, last bus=3D3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C03E] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C03E._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C03F._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C03E.C053._PRT]
ACPI: Power Resource [C14D] (on)
ACPI: Power Resource [C161] (on)
ACPI: Power Resource [C165] (on)
ACPI: Power Resource [C168] (on)
ACPI: Power Resource [C171] (on)
ACPI: PCI Interrupt Link [C0BB] (IRQs 5 10 11)
ACPI: PCI Interrupt Link [C0BC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0BD] (IRQs 5 10 11)
ACPI: PCI Interrupt Link [C0BE] (IRQs 5 10 11)
ACPI: PCI Interrupt Link [C0BF] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [C0C0] (IRQs *5 10 11)
ACPI: PCI Interrupt Link [C0C1] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [C0C2] (IRQs 5 10 11)
ACPI: Power Resource [C1E0] (off)
ACPI: Power Resource [C1E1] (off)
ACPI: Power Resource [C1E2] (off)
ACPI: PCI Interrupt Link [C0BD] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0BC] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0BF] enabled at IRQ 10
ACPI: PCI Interrupt Link [C0C1] enabled at IRQ 11
ACPI: PCI Interrupt Link [C0C0] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Software Suspend LZF Compression Driver v1.0
Software Suspend Swap Writer v1.0
Initializing Cryptographic API
ACPI: AC Adapter [C18F] (on-line)
    ACPI-1133: *** Error: Method execution failed [\_SB_.C03E.C054.C0D2.C12=
F] (Node c1529200), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.C03E.C054.C0D2.C13=
E] (Node c1529f20), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.C18B._BTP] (Node c=
15261e0), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C18B] (battery present)
    ACPI-1133: *** Error: Method execution failed [\_SB_.C03E.C054.C0D2.C12=
F] (Node c1529200), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.C03E.C054.C0D2.C13=
E] (Node c1529f20), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1133: *** Error: Method execution failed [\_SB_.C18C._BTP] (Node c=
1526ec0), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C18C] (battery present)
ACPI: Battery Slot [C18D] (battery absent)
ACPI: Battery Slot [C18E] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C190]
ACPI: Lid Switch [C191]
ACPI: Fan [C1E3] (off)
ACPI: Fan [C1E4] (off)
ACPI: Fan [C1E5] (off)
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (69 C)
ACPI: Thermal Zone [C1DF] (35 C)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0x60000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23DA-30, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=3D58140/16/63, UDMA(1=
00)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 > hda4
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.6
 Sensor: 22
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Software Suspend 2.0.0.56: Swap space signature found.
Software Suspend 2.0.0.56: Suspending enabled.
Software Suspend 2.0.0.56: Checking for image...
Software Suspend 2.0.0.56: This is normal swap space.
ACPI: (supports S0 S3 S4 S4bios S5)

If necessary, I can send the output of acpidmp (as it was big and I
wasn't sure it was useful, I didn't attach it).

Thank you.

Regards,

Hugo

--=20
Hugo Haas - http://larve.net/people/hugo/

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQItTUaN/9WeKWvkNAQFLgQQAuTxCgAHKWZuXrojKL6e11Kct9cXjh6xe
JmNcg3xEpuX4T1fe+t/9fErCq3lHY1Nv3fKV9sk0ML4vWBkE4r20otvPYsep09Y4
MWuw4niH9Cb5tjV74pp4a5j5kuuPLA99DqLLdSN+amOeajgbAkfd9rh7HZHPborT
enzptDQSxzg=
=TlMw
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
