From: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Is it possible to have more than two batteries in a
	laptop?
Date: 29 Sep 2002 22:52:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1033332750.1096.12.camel@momo>
References: <20020929195545.79555136.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-q6kBKRQ5X6cEPm9Kqvma"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020929195545.79555136.hanno-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-q6kBKRQ5X6cEPm9Kqvma
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Il dom, 2002-09-29 alle 19:55, Hanno B=F6ck ha scritto:
> I'm currently working on a patch for the gnome battery-applet (battstat-a=
pplet) to work with two batteries.
> Now I have a version working with two batteries, but it would not work if=
 there are more than two batteries.
> So I wanted to know if there are laptops which can have more than two bat=
teries at the same time?
> If not, my patch is fine. If yes, I would have to enhance it.

as any other people patching batstat-applet, you're hardcoding into it
the names of *your* apci devices. my ac/dc is names AC (and not ACDC
like yours) and the battery is BAT0. the _only_ way to have a battstat
working with any hardware is to scan the /proc directories and use the
names found here.

--=20
Federico Di Gregorio
Debian GNU/Linux Developer & Italian Press Contact        fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
INIT.D Developer                                           fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org
  Se si insegna a un bambino a programmare in qualche linguaggio
   informatico, questo esercizio logico lo render=E0 padrone e non
   schiavo del computer.                                  -- Umberto Eco

--=-q6kBKRQ5X6cEPm9Kqvma
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQA9l2gOvcCgrgZGjesRAkHZAKCBBMLVvs8Xe0caVk5mYGn7iK4S7gCgw39r
BKTxwD/SJF9NFxW7Mtd9U8k=
=TMLm
-----END PGP SIGNATURE-----

--=-q6kBKRQ5X6cEPm9Kqvma--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
