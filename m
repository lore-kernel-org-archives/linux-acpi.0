From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] ACPI updates
Date: Tue, 12 Aug 2003 18:09:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC3D@hdsmsx402.hd.intel.com>
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
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yes, this is intentional.

We got complaints about the code duplication in 2.4 as table parsing
code appeared both in both in mini-acpi (acpitable.c) as well as in the
acpi driver.  Also, we want to keep 2.4 and 2.6 as similar as possible.

Note that no functionality is lost, the CONFIG_ACPI_HT option simply
pulls in the CONFIG_ACPI_BOOT table parsing code instead of the largely
similar code in acpitable.c.
If there was something you like about acpitable.c that we neglecected to
learn from and could be used to improve the code in the driver -- let me
know and we'll improve the code in the driver.  But maintaining two
versions has already proven to be a mistake.

Thanks,
-Len

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org]=20
> Sent: Tuesday, August 12, 2003 3:14 PM
> To: Brown, Len
> Cc: Grover, Andrew; acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
> Subject: Re: [ACPI] [BK PATCH] ACPI updates
>=20
>=20
> On Tue, Aug 12, 2003 at 02:55:21PM -0400, Brown, Len wrote:
> >  arch/i386/kernel/acpi/acpitable.c         |  553 ------------------
> >  arch/i386/kernel/acpi/acpitable.h         |  260 --------
>=20
> umm.. are these really supposed to go away?  I thought for 2.4, they
> would be left intact.
>=20
> --=20
> "It's not Hollywood.  War is real, war is primarily not about=20
> defeat or
> victory, it is about death.  I've seen thousands and=20
> thousands of dead bodies.
> Do you think I want to have an academic debate on this=20
> subject?" -- Robert Fisk
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
