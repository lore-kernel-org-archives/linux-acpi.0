From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI status in 2.4 tree
Date: Wed, 19 Nov 2003 13:09:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE00147D1FD@hdsmsx402.hd.intel.com>
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
To: wwp <subscript-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We use BK to merge into the baseline kernel, so as of this morning,
everything in the ACPI release tree
http://linux-acpi.bkbits.net:8080/linux-acpi-release-2.4.23 is also in
marcelo's 2.4 tree http://linux.bkbits.net:8080/linux-2.4 which is where
2.4.23-rc2 comes from.

So the patch on kernel.org is already obsolete, as it has already been
applied to the 2.4.23 baseline.

This is not true for a base release that is frozen, such as 2.4.22
because it stopped accepting patches long ago.  So for 2.4.22 (and soon
2.4.23) you'd grab the frozen base release and then apply the ACPI
release patch on top of it to get the latest ACPI changes.

See this README for more info
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.A
CPI
and let me know if there is anything I can do or document that would
clarify the process.

Thanks,
-Len


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of wwp
> Sent: Wednesday, November 19, 2003 10:47 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] ACPI status in 2.4 tree
>=20
>=20
> Hi Luca Capello,
>=20
>=20
> On Wed, 19 Nov 2003 16:12:00 +0100 Luca Capello <luca-wlebWZzHoyE@public.gmane.org> wrote:
>=20
> > on 11/19/03 15:29, Ducrot Bruno wrote:
> > | Why not just looking in the log? at ?
> > |>From=20
> ftp.kernel.org:/pub/linux/kernel/v2.4/testing/patch-2.4.23.log

> it's not simpler look at ACPI patches release section?
>
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/

Yep, that's also what I did. Found patches against 2.4.23-rc1.. and
it says nothing about rc2 merging status.

How funny that people cannot say "yes" or "no" and prefer sending
unclear answers :-\.


Regards,

--=20
wwp


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
