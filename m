From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [BK PATCH] ACPI updates
Date: Tue, 12 Aug 2003 13:31:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEC9@orsmsx401.jf.intel.com>
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
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org]=20
> >  arch/i386/kernel/acpi/acpitable.c         |  553 ------------------
> >  arch/i386/kernel/acpi/acpitable.h         |  260 --------
>=20
> umm.. are these really supposed to go away?  I thought for 2.4, they
> would be left intact.

Obviously there's been some waffling here (my fault). What happened was:

1) ACPI table parsing code written, but not separable from interpreter

2) People wanted just MADT parsing for HT logical CPUs without all of
ACPI, and whipped up acpitable.[ch]. They added an "acpismp=3Dforce"
cmdline option.

3) Main ACPI patch doesn't get merged for a loooOOOOooong time. One of
the criteria for merging is "don't lose the current functionality!"

4) I put acpitable.[ch] and acpismp=3Dforce back in the ACPI patch, in a
somewhat rushed manner.

5) ACPI patch gets merged into 2.4.

6) We realize that in the meantime acpismp=3Dforce has become obsolete
anyways (replaced by a HT cpu feature flag check)

7) Len starts looking at integrating SuSE improvements and sorting out
ACPI's config option and cmdline option mess. He determines it is
redundant, so it's gone again.

Since Len has had his brain deep in the code and thinks it is not
necessary, I think that in retrospect putting it back was the wrong
thing to do, and so it should go away. Again. For the last time.

Regards -- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
