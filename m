From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Subject: Getting very high CPU-load with new acpi
Date: Sun, 22 Jun 2003 22:59:42 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030622225942.528a5dc2.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Zh5OxpGwtn:UC="
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=.Zh5OxpGwtn:UC=
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I own a fujitsu-siemens lifebook C6155.
With several linux-kernels containing the new acpi (2.5.x, 2.4.21+patch,
2.4.21-ac1), I get very high CPU-load every few seconds. It's even
impossible to listen mp3s.
top shows me that it's the process events on 2.5-kernels and keventd on
2.4-kernels. This does not happen with 2.4.21-vanilla (without
acpi-patch, but with acpi enabled and working).
So the bug seems to be in the new acpi-system.

dmesg-output, lspci-output, dsdt and other information is available
through
http://bugzilla.kernel.org/show_bug.cgi?id=3D843

--=20
Hanno B=F6ck - hanno-Mmb7MZpHnFY@public.gmane.org

--=.Zh5OxpGwtn:UC=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9hjBr2QksT29OyARAnwEAKCicUorOHpuidTYOrlBDCR3JR9SggCfWJ4X
cvMG7lOdO4OcxI4hReJyNFk=
=gPzB
-----END PGP SIGNATURE-----

--=.Zh5OxpGwtn:UC=--
