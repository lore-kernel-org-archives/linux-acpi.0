From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Acpica-20030619 and "-g" option
Date: Sun, 13 Jul 2003 16:57:17 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E9701F@orsmsx401.jf.intel.com>
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
To: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Hrvoje,

Well that's what I get for replying to 2 week old email without reading
everything first. Glad to see you took up the challenge.

However, it should be possible to add this support without modifying any
files *except* osunixxf.c. I don't mean to be too demanding but if you
wouldn't mind considering that approach, I'd appreciate it.

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Hrvoje Habjanic [mailto:hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org]=20
> Sent: Tuesday, July 01, 2003 3:34 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] [PATCH] Acpica-20030619 and "-g" option
>=20
>=20
>=20
> Well, hello again ... ;-)
>=20
>=20
> After few hours of grep/vi/grep , i've finally made this to=20
> work (that is,=20
> ./iasl -g to dump DSDT tables).
>=20
> Looking at it now, it seems very easy - mmap-ing memory was=20
> the most trickier=20
> part because of page aligement ....
>=20
> Patch is attached ... it will work on x86 (32bit) - for=20
> others - i'm not=20
> shure.
>=20
> And another thing. It currently dumps ONLY DSDT table, but, i=20
> think it could=20
> be nice to dump all tables ... maybe later.
>=20
>=20
> Hrvoje
>=20
>=20


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
