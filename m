From: Pere =?ISO-8859-1?Q?Casta=F1er?= <XaRz69-pCzzcW6XgXY@public.gmane.org>
Subject: Re: About dsdt of clevo 5600N
Date: Fri, 16 May 2003 03:56:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030516035605.18dc60b8.XaRz69@terra.es>
References: <20030516021732.69eca85d.XaRz69@terra.es>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.)PN/+4YH.Lkxic"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030516021732.69eca85d.XaRz69-pCzzcW6XgXY@public.gmane.org>
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

--=.)PN/+4YH.Lkxic
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2003 02:17:32 +0200
Pere Casta=F1er <XaRz69-pCzzcW6XgXY@public.gmane.org> wrote:

>=20
> Hi all.
> I'm interested of fixing the dsdt tables of my clevo 5600N but I don't fi=
nd any clear information how can do it (yeah newbie here!).
>=20
> I checked acpi.sf.net/dsdt and I have all the howto's and guides for begi=
n, only I want to ask if there's any dsdt of any clevo already patched (in =
the repository, I can't see any).
>=20
> I think that the patch of Markus Gaugush is a clean way to do what I must=
 do for obtain the suspend on ram state on my clevo.
>=20
> Thanks for any addintional information, or tips that you could tell me fo=
r helping me to do this whole thing.


Well dsdt tables fixed and loaded by initrd patch! in dmesg I could see:
-----------
Looking for DSDT in initrd ... found at beginning!
   tbget-0292: *** Info: Table [DSDT] replaced by host OS
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
...........................................................................=
................
Table [DSDT] - 519 Objects with 49 Devices 138 Methods 14 Regions
ACPI Namespace successfully loaded at root c0379ebc
-----
Now is right. But now which useful information can I extract from this?

How can I know if my laptop is capable of doing suspend on Ram (I supose th=
e tipical windows supend mode)? throght the dmesg?=20
Or I need more patches?


(I upload the dmesg here:  http://xarz.no-ip.org/dmesg_acpi_tables.txt)

Thanks for your info and patience.
--=20
"The Wheel of Time turns, and Ages come and pass, leaving memories
that become legends. Legend fades to myth, and even myth is long=20
forgotten when the Age that gave it birth comes again. In one Age,
called Third Age by some, an Age yet to come,an Age long past,=20
wind rose in the Rhannon Hills. the wind was not the beginning.=20
There are neither beginnings nor endings to turning of the Wheel=20
of Time...But it was a beginning."
					  	   Robert Jordan=20
					  Wheel of Time(book 10)
					  Crossroads of twilight
------
Pere Casta=F1er Sard=E0 - http://xarz.no-ip.org
GnuPG Public key available - http://xarz.no-ip.org/keys.html
Computer Science Student on UOC - http://www.uoc.edu
Linux Registered User #232073=20
Debian/GNU User - http://www.debian.org
---------------------

--=.)PN/+4YH.Lkxic
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xEVDz9pL9wbHcwIRAi9NAJ41qBJtPhHnJY5iZDYSx6yIlkypBACeM6gO
f+UV0SUcE2UyUqo9ZFVyNOc=
=62Qx
-----END PGP SIGNATURE-----

--=.)PN/+4YH.Lkxic--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
