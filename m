From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: S3 Woes
Date: Mon, 10 May 2004 19:12:49 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084230769.16068.5.camel@300mlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lBUrb7YRip5xULZIRjI7"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-lBUrb7YRip5xULZIRjI7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I had S3 working on my laptop for a while, and now it will not resume if
any USB devices are plugged in. It doesn't mind the bus drivers
(uhci-hcd and ehci-hcd), and it doesn't seem to mind the device drivers
themselves being present (usb-storage, hid usually), but if there's a
USB device plugged into this laptop, the laptop powers on, asks for my
BIOS password, and then goes blank. Caps/Num/Scroll Lock work for a
short period, and then the whole machine appears to freeze (of course
there's no good way to know for absolute sure, but if Caps Lock doesn't
work then there's a definite problem :)). Anyone know why this is
happening, or more importantly what could have changed (most likely in
kernel config) to cause this to happen? Preempt is off.

--
Andrew Barr

/usr/games/fortune says:
If Karl, instead of writing a lot about Capital, had made a lot of Capital,
it would have been much better.
		-- Karl Marx's Mother

--=-lBUrb7YRip5xULZIRjI7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAoAxwhuM+Z62a52oRAojSAKD9ZUe5cAv7W75p9mWZX1Ouw89VzACg8Tz2
eM5wreM3M8Z8w9pfrhMpCYw=
=Yy+L
-----END PGP SIGNATURE-----

--=-lBUrb7YRip5xULZIRjI7--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
