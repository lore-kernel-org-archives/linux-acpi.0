From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: APIC options 2.4.21 kernel + patch
Date: Fri, 22 Aug 2003 22:34:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC5@hdsmsx402.hd.intel.com>
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
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


It was a bug that building ACPI depended on the APIC.

So as the definition "latest ACPI patch" is changing over time,
the answer to your question was Yes last week, and is No today, and
going forward.

Cheers,
-Len


> -----Original Message-----
> From: Emma Jane Hogbin [mailto:emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org]=20
> Sent: Tuesday, July 01, 2003 1:20 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] APIC options 2.4.21 kernel + patch
>=20
>=20
> Hi:
>=20
> I'm currently working on an ACPI HOWTO. It was written for the 2.4.20
> kernel, and I'm getting some questions about the 2.4.21 kernel and the
> latest patch. I am hoping this is a quick question with an=20
> easy answer.
> http://xtrinsic.com/geek/articles/acpi.phtml
>=20
> Here is a copy of the email I received which outlines the=20
> problem behind
> the question:
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D2668793
&forum_id=3D7803

My question is this: Does the CONFIG_X86_UP_APIC module need to be set
to
"Y" for the 2.4.21 kernel + latest ACPI patch to work?=20

I've found the following APIC options in the 2.4.20 kernel:
	CONFIG_X86_GOOD_APIC=3Dy
	# CONFIG_X86_UP_APIC is not set
	# CONFIG_X86_UP_IOAPIC is not set

The reader who emailed me said that he had to enable the second option
in
order to get the 2.4.21 kernel + patch to work. Will this be true for
all
hardware configurations 2.4.21?

thanks!!

emma

--=20
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
