From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.3 + D600 + battery state + BUG?? [Was] Battery status sometimes missing
Date: Fri, 27 Feb 2004 13:05:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720D9B@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

In osl.c , Change code like :

  884         if (ACPI_FAILURE(status)) {
  885                 dump_stack();
  886                 ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to
acquire semaphore[%p|%d|%d], %s\n",
  887                         handle, units, timeout,
acpi_format_exception(status)));
  888         }

And send oops-like infomation to me.

--Luming


> -----Original Message-----
> From: Ow Mun Heng [mailto:ow.mun.heng-Sjgp3cTcYWE@public.gmane.org]=20
> Sent: Friday, February 27, 2004 12:06 PM
> To: Yu, Luming; Acpi-List (E-mail)
> Subject: RE: [ACPI] 2.6.3 + D600 + battery state + BUG??=20
> [Was] Battery status sometimes missing
>=20
>=20
>=20
>=20
> > -----Original Message-----
> > From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Sent: Friday, February 27, 2004 11:20 AM
> > To: Ow Mun Heng; Acpi-List (E-mail)
> > Subject: RE: [ACPI] 2.6.3 + D600 + battery state + BUG??=20
> [Was] Battery
> > status sometimes missing
> >=20
> >=20
> > > Note : I still see this soometimes
> > > osl-0886[80] os_wait_semaphore:Failed to acquire=20
> > > semaphore[dffac580|1|0],
> > > AE_TIME
> >=20
> > Hmm, this is unusual inforation. I'm curious about the=20
> semaphore which
> > is timeout to
> > be acquired by whom?  Would you help with add dump_stack just before
> > that debug
> > message? This is a interesting bug. :)
> >=20
> > I'm not sure, but maybe the following two patch can help,=20
> only because
> > they aim  to
> >  global lock/mutex issue.
> > 1.) http://bugme.osdl.org/show_bug.cgi?id=3D1781#c18
> > 2.) http://bugme.osdl.org/show_bug.cgi?id=3D1669#c6
>=20
> Can you tell me how to add the dump_stack??
>=20
> in /proc/acpi/debug_layer ??? how to do it?? Echo what??
>=20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
