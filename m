From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: ACPI ignoring IRQ flags in PRT
Date: Sun, 13 Jul 2003 17:56:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE87@orsmsx401.jf.intel.com>
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
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Andrew de Quincey [mailto:adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org]=20
> > I think what was throwing Matthew is that the interupt=20
> trigger types are
> > specified in  _PRS objects
> > The _PRT object is a mapping from PCI device to a particular "PCI
> > Interrupt Link device" and in the defintion of the link=20
> device, the IRQs
> > are defined in _PRS objects.
>=20
> Yeah, I suspected I wasn't using the right terminology.
>=20
> Where are the parameters for "global system interrupts"=20
> defined? It looks like=20
> we have to support this configuration method as well. The=20
> MADT table sounded=20
> likely, but that is only for overriding ISA IRQs. Where are=20
> >15 IRQs defined?

Hi Andrew,

Great to see someone's digging into this. BTW have you looked at the
ACPI 2.0 spec section 6.2.8? It talks about the contents of _PRT.
Basically, it can contain either the interrupt number itself OR point to
a link device, which in turn lets ACPI read (via _CRS) write (via _SRS)
and see the possiblities (_BRS) for controlling the interrupt routing
for that device.

The code *should* be handling both these cases, but obviously there are
still some bugs lurking.

Regards -- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
