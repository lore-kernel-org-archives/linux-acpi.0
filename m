From: Scott James Remnant <scott-Umf49k1wg4FWk0Htik3J/w@public.gmane.org>
Subject: Re: S3 resume problems on HP compaq nc4010
Date: Sun, 09 May 2004 23:00:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084140024.14657.8.camel@syndicate>
References: <1083777804.4093.71.camel@descent.netsplit.com>
	 <20040509015516.GA5487@elf.ucw.cz> <1084117826.2372.32.camel@syndicate>
	 <20040509213919.GA13603@atrey.karlin.mff.cuni.cz>
	 <1084139548.14657.4.camel@syndicate>
	 <20040509215621.GB15307@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qvXFoO1tajTefUriU1n2"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040509215621.GB15307-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-qvXFoO1tajTefUriU1n2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-09 at 23:56 +0200, Pavel Machek wrote:

> > S3 resume you get nothing, because the screen never comes back (and
> > nothing in the logs either).
> >=20
> > S4 you get the messages about restoring from swap, then the screen
> > switches to show the messages it showed whilst suspending and it
> > locks.
> >=20
> > Have tried by booting init=3D/bin/bash with no modules loaded.
>=20
> Can you confirm that you did not have intel-agp or similar (AGP or DRI
> drivers) loaded? Even loading then unloading it hurts.
>=20
I deliberately compiled those out as modules, and when booting with
init=3D/bin/bash the agpgart and ati_agp aren't loaded.  (if they're
loaded, it makes no difference).

> * go with minimal config, turn off drivers like USB, AGP you don't
>   really need
>=20
Tried it.

> * turn off APIC and preempt
>=20
Tried it.

> * use ext2. At least it has working fsck. [If something seemes to go
>   wrong, force fsck when you have a chance]
>=20
Would the filesystem really make a difference to whether it can or can't
come back?

> * turn off modules
>=20
Tried it.

> * use vga text console, shut down X. [If you really want X, you might
>   want to try vesafb later]
>=20
Tried it.

> * try running as few processes as possible, preferably go to single
>   user mode.
>=20
Tried it.

> * due to video issues, swsusp should be easier to get working than
>   S3. Try that first.
>=20
Doesn't work either.  I got swsusp2 to work, but that has to shut down X
and unload all the modules otherwise it won't resume; and that takes
longer than a simple shutdown and boot -- so I abandoned it.  Plus it
scared me -- too much pretty :)

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-qvXFoO1tajTefUriU1n2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAnqn4IexP3IStZ2wRAgXVAKCHf3lLkqP5ffRnxrXrwPX9fpQ4VACffHZN
W8RulzvEOd2/ILMMCgyMrF0=
=JhDT
-----END PGP SIGNATURE-----

--=-qvXFoO1tajTefUriU1n2--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
