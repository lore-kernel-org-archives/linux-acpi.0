From: Scott James Remnant <scott-Umf49k1wg4FWk0Htik3J/w@public.gmane.org>
Subject: Re: S3 resume problems on HP compaq nc4010
Date: Sun, 09 May 2004 22:52:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084139548.14657.4.camel@syndicate>
References: <1083777804.4093.71.camel@descent.netsplit.com>
	 <20040509015516.GA5487@elf.ucw.cz> <1084117826.2372.32.camel@syndicate>
	 <20040509213919.GA13603@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U8l/E8ir1CtHmkg9tiJU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040509213919.GA13603-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
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


--=-U8l/E8ir1CtHmkg9tiJU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-09 at 23:39 +0200, Pavel Machek wrote:

> > > > This seemed like the most likely place to bring up my ACPI woes :) =
 I've
> > > > recently purchased an HP compaq nc4010 (it's mostly identical to th=
e
> > > > nc4000) and haven't been able to get ACPI S3 (memory) suspend
> > > > working.
> > >=20
> > > Does ACPI S4 work for you? Try that first, its easier.
> > >=20
> > Nope, swsusp does actually resume the keyboard and screen but then lock=
s
> > up.  pm-disk doesn't even suspend.
>=20
> What are the last messages? Do you suspend from singleuser mode, no
> modules?
>=20
For both S3 and S4 you get a message about switching to the sleep state,
S4 you get some messages as it writes the pages to the disk, then the
machine powers off.

S3 resume you get nothing, because the screen never comes back (and
nothing in the logs either).

S4 you get the messages about restoring from swap, then the screen
switches to show the messages it showed whilst suspending and it locks.


Have tried by booting init=3D/bin/bash with no modules loaded.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-U8l/E8ir1CtHmkg9tiJU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAnqgbIexP3IStZ2wRAgl+AKCCdJXthGM/qVjj1raqCaKzkejxSgCfUjq/
bU5GB0VdVNgtGwWodYc0vFU=
=13bf
-----END PGP SIGNATURE-----

--=-U8l/E8ir1CtHmkg9tiJU--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
