From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Fri, 26 Mar 2004 17:41:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080322903.2325.113.camel@darkstar>
References: <20040308205444.GH484@elf.ucw.cz>
	 <20040309233325.GA22953@alpha.home.local>
	 <1079279490.10225.10.camel@darkstar>
	 <20040315210729.GA19306@alpha.home.local>
	 <1079389434.3695.2.camel@darkstar>
	 <20040315231927.GA19829@alpha.home.local>
	 <20040322105946.GC1505@openzaurus.ucw.cz>
	 <1080253327.3755.20.camel@darkstar> <20040325222934.GF2179@elf.ucw.cz>
	 <1080255058.4187.1.camel@darkstar>  <20040325230037.GK2179@elf.ucw.cz>
	 <1080262910.4144.39.camel@darkstar>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080262910.4144.39.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Sorry about that patch this really doesn't make sence,

in kernels 2.4.x now in drives/acpi/Config.in

if [ "$CONFIG_ACPI" =3D "y" ]; then
ACPI_SLEEP =3D y

if acpi support (CONFIG_ACPI) is equal to no =3D>
the drives/acpi/system.c is not compiled at all.

the only thing just don't make sense (for me) is permission to compile
ACPI without CONFIG_PM ?

in conclusion without any patch acpi_system_save_state never is "return
ok", so you can ignore my patch.

and arch/i386/config.in shouldn't be like this:

if [ "$CONFIG_PM" =3D "y" ]; then
source drivers/acpi/Config.in
fi

thanks=20
I will investe more ...

On Fri, 2004-03-26 at 01:01, S=E9rgio Monteiro Basto wrote:
> Preamble :
> I can be confused, but far as I know, you propose a patch for a _very
> wrong_ thing, ( I believe that you are right ).
> acpi_system_save_state is one reality, at least in kernel 2.4.26-pre2,
> but what you propose looks like, that just resolve half of the problem.
> if it a recently patch that made this problem I don't know.
>=20
> Seeing the code yes, you are right.
> I don't know if as make any sense to you but, what do you think put
> acpi_system_save_state under #ifdef CONFIG_PM instead of CONFIG_SLEEP ?
> like this=20
>=20
> thanks
> On Thu, 2004-03-25 at 23:00, Pavel Machek wrote:
> > Hi!
> >=20
> > > so acpi_system_save_state(state) does do nothing at all ?
> > > or does return nothing at all ?
> >=20
> > IIRC there was patch that made acpi_system_save_state() do nothing at
> > all if !CONFIG_ACPI_SLEEP. I'm arguing thats very wrong.
> > 								Pavel
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
