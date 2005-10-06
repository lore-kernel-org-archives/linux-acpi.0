From: Hein-Pieter van Braam <hp-KOxqMzujAKlWk0Htik3J/w@public.gmane.org>
Subject: Compaq 2552EA suspend/resume
Date: Thu, 06 Oct 2005 08:51:01 +0200
Message-ID: <1128581461.8134.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Sc+fRkiEZI2UZrw7GIgl"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Sc+fRkiEZI2UZrw7GIgl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all!

I've got a compaq 2552EA laptop, and I have been trying to get suspend
to ram and suspend to disk to work forever, and, well, failed :)

I've patched my DSDT, and it is a little better now, but I think there's
a bit more wrong with it than just syntax :) but.

Anyway, I would really like to debug this problem, either from my DSDT
or from linux's acpi implementation. But, I've got no real clue where to
start. The AML language is pretty simple, but not really understandable
without intimate knowledge of the hardware I feel :)

anyway, what happens when I try to enter S3, is (without patched DSDT)
it tried to resume, then just sits there doing nothing. I can then
switch to another console, and continue working, but I can't suspend
again.=20
With my patched DSDT it suspends then immediately wakes up again.

Hibernation just crashes during disk write (I think, can't be sure as
there is no output) but the harddisk led just keeps burning without
generating any actual harddisk activity (I can tell because the disks
isn't making 'writing noises') :)

I would really appreciate some pointers as to where to start looking for
trouble.=20

thanks in advance

hp

--=-Sc+fRkiEZI2UZrw7GIgl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDRMlV5iHdtUqHskMRAuUdAJ4tu2C2spFJAATUy3eEZHw9Uk7RjACffY3n
DYtedT214EzJPulKP5d1dRo=
=CE8w
-----END PGP SIGNATURE-----

--=-Sc+fRkiEZI2UZrw7GIgl--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
