From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fixing broken DSDT - code suggestions for comment   please!
Date: Wed, 26 May 2004 08:36:23 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055E08D59@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, marmon-GymH4r+vMzPQT0dZR+AlfA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

There *is* an interactive AML debugger in the ACPI CA package.  However,
it needs to be integrated into Linux.

As far as I can tell, the reason it hasn't been done yet is because the
whole concept of "interactive kernel debugging" is rather foreign to
Linux.

Bob


> -----Original Message-----
> From: Yu, Luming
> Sent: Tuesday, May 25, 2004 7:36 PM
> To: marmon-GymH4r+vMzPQT0dZR+AlfA@public.gmane.org; ACPI Developers
> Cc: linux-acpi
> Subject: RE: [ACPI] Fixing broken DSDT - code suggestions for comment
> please!
>=20
>  >
> >I've posted this question before, if its just a question that shall
go
> >unanswered someone please let me know so I stop reposting it
different
> >ways:
> >
> >Where would start searching for information on debugging a compiled
> >DSDT?  The iasl compiler believes it is fine, 0 errors, 0 warnings;
but
> >I kernel panic in the one_complete_parse phase when booting using the
> >custom dsdt table.
> >
>=20
>   AFAIK, there is no AML debugging tool under linux. To debug the
DSDT,
> you have to add some statement like "store ( xxx, debug) " in your ASL
> code.
>=20
>   PS, can you post the detailed message of the panic.
>=20
> Thanks,
> Luming


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
