From: Marc Franquesa <mark-KaoEA2pfkXWsTnJN9+BGXg@public.gmane.org>
Subject: Re: Suspend 2 disk: It Works!
Date: Sat, 15 Nov 2003 18:18:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068916684.945.5.camel@nexus.l3jane.net>
References: <1068895745.944.9.camel@nexus.l3jane.net>
	 <20031115130211.GA12062@server.by>
	 <1068903849.940.45.camel@nexus.l3jane.net>
	 <20031115154041.GB24320@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ESzW73jYLB9jOwEfJhGy"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031115154041.GB24320-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-ESzW73jYLB9jOwEfJhGy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On ds, 2003-11-15 at 16:40, Karol Kozimor wrote:

> See if cat /proc/acpi/sleep reports S4BIOS or something similar. If so, y=
ou
> probably can (echo 4b > /proc/acpi/sleep).=20

It works!, I'm very happy thanks very much.

Some notes only for documentation to reporting if someone is interested:

- The suspend and resume process is very slow (in apm was very fast)
- I need to boot from the suspend partition (in the past with apm, the
Laptop automagically boots from it without user-action).
- ... the typical 'usb-controller halted' messages floods the screen on
resume, I need to prepare some scripts to avoid it.. ;)

Again thank very much for your answer.

Salut


--=-ESzW73jYLB9jOwEfJhGy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/tl/M4CVRFTc6wP8RAg9mAJ0VfpwCu43ohSFQ2n8LW1tX4I99OwCg2HrA
JUORt1UzG1cm02pmx1Bml9g=
=zdHM
-----END PGP SIGNATURE-----

--=-ESzW73jYLB9jOwEfJhGy--



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
