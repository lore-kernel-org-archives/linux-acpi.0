From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: - Kernel 2.6.3 - Error ACPI-0279 & ACPI-1120
Date: Mon, 8 Mar 2004 10:35:55 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C72D7@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jerome Poggi <Jerome.Poggi-5fwdxd2ikk8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a known issue... Check out..

http://bugme.osdl.org/show_bug.cgi?id=3D2066

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of=20
> Jerome Poggi
> Sent: Friday, March 05, 2004 11:43 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] - Kernel 2.6.3 - Error ACPI-0279 & ACPI-1120
>=20
>=20
>=20
>=20
> I use a Gentoo kernel linux-2.6.3-gentoo-r2 and I get this error
> suddenly :
>=20
> Mar  3 17:21:30 efflam ACPI-0279: *** Error: Looking up=20
> [BUFF] in namespace, AE_ALREADY_EXISTS
> Mar  3 17:21:30 efflam ACPI-1120: *** Error: Method execution=20
> failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
> Mar  3 17:21:34 efflam ACPI-0279: *** Error: Looking up=20
> [BUFF] in namespace, AE_ALREADY_EXISTS
> Mar  3 17:21:34 efflam ACPI-1120: *** Error: Method execution=20
> failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
> Mar  3 17:21:35 efflam ACPI-0279: *** Error: Looking up=20
> [BUFF] in namespace, AE_ALREADY_EXISTS
> Mar  3 17:21:35 efflam ACPI-1120: *** Error: Method execution=20
> failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
> Mar  3 17:21:40 efflam ACPI-0279: *** Error: Looking up=20
> [BUFF] in namespace, AE_ALREADY_EXISTS
> Mar  3 17:21:40 efflam ACPI-1120: *** Error: Method execution=20
> failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
> Mar  3 17:21:45 efflam ACPI-0279: *** Error: Looking up=20
> [BUFF] in namespace, AE_ALREADY_EXISTS
> Mar  3 17:21:45 efflam ACPI-1120: *** Error: Method execution=20
> failed [\_SB_.BAT1._BST] (Node c12d3fa0), AE_ALREADY_EXISTS
>=20
> so I take a look at /proc and I see this :
>=20
> root-mvppoxjXWBo@public.gmane.org:/proc/acpi/battery/BAT1 # ls=20
> alarm  info  state
> root-mvppoxjXWBo@public.gmane.org:/proc/acpi/battery/BAT1 # cat *
> alarm:                   68 mAh
> present:                 yes
> design capacity:         3600 mAh
> last full capacity:      3400 mAh
> battery technology:      rechargeable
> design voltage:          10800 mV
> design capacity warning: 68 mAh
> design capacity low:     0 mAh
> capacity granularity 1:  1 mAh
> capacity granularity 2:  1 mAh
> model number:            XM2030P02  =20
> serial number:           1000010554
> battery type:            Li-ION =20
> OEM info:               =20
> present:                 yes
> ERROR: Unable to read battery status
>=20
> If I extract my battery all error messages stop.
> I don't have a oops in this session.
>=20
> When I boot all ACPI messages are :
> [...]
> Mar  3 16:28:38 efflam ACPI: RSDP (v000 TOSHIB               =20
>                     ) @ 0x000f01b0
> Mar  3 16:28:38 efflam ACPI: RSDT (v001 TOSHIB 750     =20
> 0x00970814 TASM 0x04010000) @ 0x0ff60000
> Mar  3 16:28:38 efflam ACPI: FADT (v001 TOSHIB 750     =20
> 0x00970814 TASM 0x04010000) @ 0x0ff60054
> Mar  3 16:28:38 efflam ACPI: DSDT (v001 TOSHIB 8200    =20
> 0x20001220 MSFT 0x0100000a) @ 0x00000000
> Mar  3 16:28:38 efflam Built 1 zonelists
> Mar  3 16:28:38 efflam Kernel command line: auto=20
> BOOT_IMAGE=3DLinux263 ro root=3D305 pmdisk=3D/dev/hda1=20
> resume=3D/dev/hda1 pci=3Dnoacpi
> Mar  3 16:28:38 efflam ACPI: Subsystem revision 20040116
> Mar  3 16:28:38 efflam ACPI: IRQ9 SCI: Level Trigger.
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKA._STA] (Node cff5e820), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKB._STA] (Node cff5e920), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKC._STA] (Node cff4d5e0), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKD._STA] (Node cff4d4e0), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKE._STA] (Node cff4d3e0), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.LNKH._STA] (Node cff4d2e0), AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node c12d6b20),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node c12d69e0),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.FSIR._STA] (Node c12d5860),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node c12d5720),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node c12d5640),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI-0109: *** Error: No object was=20
> returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node c12d5540),=20
> AE_NOT_EXIST
> Mar  3 16:28:38 efflam ACPI: Interpreter enabled
> Mar  3 16:28:38 efflam ACPI: Using PIC for interrupt routing
> Mar  3 16:28:38 efflam ACPI: PCI Root Bridge [PCI0] (00:00)
> Mar  3 16:28:38 efflam PCI: Probing PCI hardware (bus 00)
> Mar  3 16:28:38 efflam Transparent bridge - 0000:00:1e.0
> Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table=20
> [\_SB_.PCI0._PRT]
> Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table=20
> [\_SB_.PCI0.PCIB._PRT]
> Mar  3 16:28:38 efflam ACPI: Power Resource [PIHD] (on)
> Mar  3 16:28:38 efflam ACPI: Power Resource [PMHD] (on)
> Mar  3 16:28:38 efflam ACPI: PCI Interrupt Routing Table=20
> [\_SB_.PCI0.PCI1._PRT]
> Mar  3 16:28:38 efflam ACPI: Power Resource [PFAN] (off)
> [...]
> Mar  3 16:28:38 efflam ACPI: AC Adapter [ADP1] (on-line)
> Mar  3 16:28:38 efflam ACPI: Battery Slot [BAT1] (battery present)
> Mar  3 16:28:38 efflam ACPI: Battery Slot [BAT2] (battery absent)
> Mar  3 16:28:38 efflam ACPI: Power Button (FF) [PWRF]
> Mar  3 16:28:38 efflam ACPI: Lid Switch [LID]
> Mar  3 16:28:38 efflam ACPI: Fan [FAN] (off)
> Mar  3 16:28:38 efflam ACPI: Processor [CPU0] (supports C1 C2)
> Mar  3 16:28:38 efflam ACPI: Thermal Zone [THRM] (66 C)
> Mar  3 16:28:38 efflam toshiba_acpi: Toshiba Laptop ACPI=20
> Extras version 0.17
> Mar  3 16:28:38 efflam toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
> [...]
> Mar  3 16:28:38 efflam Resume Machine: resuming from /dev/hda1
> Mar  3 16:28:38 efflam Resuming from device hda1
> Mar  3 16:28:38 efflam Resume Machine: This is normal swap space
> Mar  3 16:28:38 efflam PM: Reading pmdisk image.
> Mar  3 16:28:38 efflam PM: Resume from disk failed.
> Mar  3 16:28:38 efflam ACPI: (supports S0 S1 S3 S4 S4bios S5)
> [...]
>=20
>=20
> Did somebody know how I can stop this error, exept reboot or=20
> pull out my
> BAT1.
>=20
> If you need any other informations, ask me.
>=20
> --
> Jerome POGGI                                     Jerome.Poggi-5fwdxd2ikk8@public.gmane.org
> Herve Schauer Consultants       -=3D-      Network security consultant
> http://www.hsc.fr/                             Tel : +33 141 409 700
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> =
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
