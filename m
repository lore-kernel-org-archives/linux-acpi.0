From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Toshiba ACPI battery status - ACPI errors
Date: Mon, 24 Nov 2003 13:04:22 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D37200173618752@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernt Hansen <bernt-CNteSEi18yz3fQ9qLvQP4Q@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I suspect this is a known issue with AML code from Toshiba. Their _STA
does not return a value explicitly, but (wrongly) expects the AML
interpreter to get the return value returned by the function _STA is
calling, like
	Method (_STA, ....) {
		AAA(...)
	}
Instead of=20
	Method (_STA, ....) {
		Return (AAA(...))
	}

If you can provide ACPI dump data of the machine, that would be helpful
when identifying the cause. Copy the ACPI mailing list and Len.

	Jun

> -----Original Message-----
> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-kernel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Bernt Hansen
> Sent: Monday, November 24, 2003 12:45 PM
> To: Linux Kernel Mailing List
> Subject: Toshiba ACPI battery status - ACPI errors
>=20
> Hi,
>=20
> I have a new Toshiba Tecra S1 laptop which I cannot get ACPI battery
> status from.  I grepped my dmesg output for ACPI and got the following
> messages:
>=20
>  BIOS-e820: 000000001fff0000 - 000000001fffffc0 (ACPI data)
>  BIOS-e820: 000000001fffffc0 - 0000000020000000 (ACPI NVS)
> ACPI: RSDP (v000 OID_00                                    ) @
> 0x000e6010
> ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @
> 0x1fffaaf0
> ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @
> 0x1ffffb00
> ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @
> 0x1ffffb90
> ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @
> 0x1ffffbc0
> ACPI: SSDT (v001 INSYDE   GV3Ref 0x00002000 INTL 0x20021002) @
> 0x1fffab30
> ACPI: DSDT (v001 TOSINV   INT810 0x00001002 INTL 0x02002036) @
> 0x00000000
> ACPI: Subsystem revision 20031002
> ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
>     ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._STA]
> (Node dff61fe0), AE_NOT_EXIST
>     ACPI-1120: *** Error: Method execution failed [\_SB_.BAT1._STA]
> (Node dff61ea0), AE_NOT_EXIST
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 7 *10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 6)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 7 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 7 10 *11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 7 10 11)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 7 10 11)
> ACPI: Embedded Controller [EC0] (gpe 16)
> ACPI: Power Resource [PUT2] (on)
> ACPI: Power Resource [PFA1] (off)
> ACPI: Power Resource [PFA0] (off)
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=3Dnoacpi' or =
even
> 'acpi=3Doff'
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
> acpiphp_glue: can't get bus number, assuming 0
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Fan [FAN0] (off)
> ACPI: Fan [FAN1] (off)
>=20
> The errors with "Method execution failed" seem to be my problem.  Any
> ideas what I can try to get the status of the batteries in this
laptop?
> There are two batteries in this thing.
>=20
> I have attached the full dmesg output in case it is helpful.  Let me
> know what I can do to help solve this problem.
>=20
> Thanks,
> Bernt.
>=20
> --
> Bernt Hansen     Norang Consulting Inc.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
