From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Button events lost after S3 on Thinkpad R32
Date: Mon, 8 Dec 2003 08:34:20 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84E18@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Brian Perkins <bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi,
I have tested S3 in many machines, and all tests show ACPI interrupt =
lost after S3. /proc/interrupts shows no ACPI interrupt increases; power =
button and any ACPI related button can't generate any events. I guess =
ACPI need be re-initialized after S3. Patch in bug 1409 can resolve S1 =
problem but not S3.

Thanks,
Shaohua


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
> Sent: 2003=C4=EA12=D4=C27=C8=D5 20:36
> To: Brian Perkins
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Button events lost after S3 on Thinkpad R32
>=20
> Thus wrote Brian Perkins:
> > Hi all.
> > I understand that this problem also shows up in the R40
> >
> > After doing echo 3 > /proc/acpi/sleep
> >
> > and then resuming, events no longer arrive in /proc/acpi/event.
>=20
> How's the /proc/interrupts after that? Does it show any ACPI =
interrupts
> occuring? Anyway, you moight want to check on this:
> http://bugme.osdl.org/show_bug.cgi?id=3D1409
>=20
> Best regards,
>=20
> --
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
