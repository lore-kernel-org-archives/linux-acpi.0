From: Nir Tzachar <tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org>
Subject: Re: ACPI Errors, battery info is lost.
Date: Thu, 03 Nov 2005 16:39:28 +0200
Message-ID: <1131028768.30456.23.camel@nexus.cs.bgu.ac.il>
Reply-To: tzachar-7iDlm8ZLfO0Zqb/kyJCLuA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DTPzl9T1exSHcCH2hgbO"
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


--=-DTPzl9T1exSHcCH2hgbO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi.

i also encounter this problem after upgrading to 2.6.14=20
im using gentoo on a thinkpad t43p.
the problem comes from the acpi parser (as far as i can tell, im not
familiar with the acpi code). the problematic method seems like
acpi_ds_begin_method_execution in
drivers/acpi/dispatcher/dsmethod.c .

it seems though that the semaphore being taken in this function is not
released after the bug is hit.

if you need more info, do tell. id really like to track down this bug.

my dmesg looks like this:
Nov  2 12:03:56 lapnir ACPI-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  2 12:03:56 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c1849360), AE_AML_METHOD_LIMIT
Nov  2 12:03:58 lapnir ACPI-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  2 12:03:58 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c1849360), AE_AML_METHOD_LIMIT
Nov  2 12:04:00 lapnir ACPI-0213: *** Error: Method reached maximum
reentrancy limit (255)
Nov  2 12:04:00 lapnir ACPI-0508: *** Error: Method execution failed
[\_SB_.PCI0.LPC_.EC__.BAT0._BIF] (Node c1849360), AE_AML_METHOD_LIMIT
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Nir Tzachar.

--=-DTPzl9T1exSHcCH2hgbO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDaiEgIHR+zI+Dam4RAvihAJ4mMsborBA+XSb7vYUwcjkO1Nx43ACePYrR
Epn42S1PguYYCm/wrLGWbjs=
=DsP9
-----END PGP SIGNATURE-----

--=-DTPzl9T1exSHcCH2hgbO--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
