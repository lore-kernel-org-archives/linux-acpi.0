From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: _PRT question
Date: Mon, 14 Jul 2003 11:57:54 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E9702D@orsmsx401.jf.intel.com>
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
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org]=20
> Why is it then I see the following in my dmesg:
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ...
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14=20
> 15, disabled)
> ...
> ACPI: PCI Interrupt Link [APCS] (IRQs 23, disabled)
>=20
>=20
> In fact, I see all the link devices from both the PICM and=20
> the APIC packages.=20
> How is this possible? _PIC is only called once from=20
> bus.c/apic_bus_init_irq().=20
>=20
> As far as I can see, the only way you could get the behaviour=20
> I see would be=20
> to call _PIC(0), then _PRT, then _PIC(1), then _PRT. But this=20
> doesn't seem to=20
> occur.
>=20
> There are no other references to the LSMB link device in my BIOS.
>=20
> Can someone tell me what is happening here?

I think we are printing status lines for found link devices even if they
are not being used.

Kinda confusing, yeah.

-- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
