From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Patch]fix EC GPE context error
Date: Tue, 4 Nov 2003 01:50:42 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC87FB@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, =?iso-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Looks like shaohua has attached a 2.4 version of the patch to the bug =
report:
http://bugzilla.kernel.org/show_bug.cgi?id=3D1171

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
> Ducrot Bruno
> Sent: Sunday, November 02, 2003 2:22 PM
> To: S=E9rgio Monteiro Basto
> Cc: Li, Shaohua; ACPI Developers
> Subject: Re: [ACPI] [Patch]fix EC GPE context error
>=20
>=20
> On Sun, Nov 02, 2003 at 07:29:38PM +0000, S=E9rgio Monteiro Basto =
wrote:
> > Hi
> > I can't apply this patch to 2.23-pre9 neither pre8 or pre7 .
> > I got one big rejected file (on osl.c I think)
> >=20
>=20
> That patch have been written for 2.6 series.
> For 2.4, since that touch a part a little bit too dependant of
> the OS (workqueues are onyl in 2.6 for example, and supersed task
> queues).
>=20
> I guess that you have to wait that someone kindly backport it.
>=20
> --=20
> Ducrot Bruno
>=20
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
