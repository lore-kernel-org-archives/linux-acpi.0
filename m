From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Thu, 25 Mar 2004 23:29:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040325222934.GF2179@elf.ucw.cz>
References: <20040308183228.GD484@elf.ucw.cz> <20040308201411.GA18636@alpha.home.local> <20040308205444.GH484@elf.ucw.cz> <20040309233325.GA22953@alpha.home.local> <1079279490.10225.10.camel@darkstar> <20040315210729.GA19306@alpha.home.local> <1079389434.3695.2.camel@darkstar> <20040315231927.GA19829@alpha.home.local> <20040322105946.GC1505@openzaurus.ucw.cz> <1080253327.3755.20.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1080253327.3755.20.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On =C4=8Ct 25-03-04 22:22:07, S=C3=A9rgio Monteiro Basto wrote:
> hi(gh)!
> On Mon, 2004-03-22 at 10:59, Pavel Machek wrote:
> > Hi!
> >=20
> > > > and status =3D acpi_system_save_state(state);=20
> > > > on line 341 of drivers/acpi/system.c ?
> > >=20
> > > OK sorry, I didn't notice it. So you'll simply have to remove the
> > > first hunk of the patch so that acpi_system_save_state() stays defi=
ned
> > > at least when CONFIG_ACPI_SLEEP is defined.
> >=20
> > In such case... at least insert BUG() into fake acpi_system_save_stat=
e method.
>=20
> Well you say that is a bug and I ask how do you translate=20
> status =3D acpi_system_save_state(state); if not I think that will be
> inefficient.=20

? Sorry, parse error on my part.

*If* you replace acpi_system_save_state() with stub that does nothing
based on config option *and* someone tries to use it, they are not
getting the functionality they want, right? And therefore calling it
is a BUG().
								Pavel
--=20
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
