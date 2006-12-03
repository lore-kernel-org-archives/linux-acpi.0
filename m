From: Seblu <seblu@seblu.net>
Subject: ACPI Thermal Zone with Asus a7n8x
Date: Sun, 03 Dec 2006 03:30:11 +0100
Message-ID: <457236B3.70502@seblu.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC480864277F5997C787E0CAE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5-g19.free.fr ([212.27.42.35]:8412 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1759615AbWLCCaP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Dec 2006 21:30:15 -0500
Received: from [192.168.42.12] (rke75-2-82-224-222-4.fbx.proxad.net [82.224.222.4])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 7BCAE277D0
	for <linux-acpi@vger.kernel.org>; Sun,  3 Dec 2006 03:30:14 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC480864277F5997C787E0CAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Good evening,

I have a trouble with my motherbord. "My" linux kernel (2.6.18.3) don't
found thermal sensors.

Directory /proc/acpi/thermal_zone is empty, like you can see below.

> root@trinity:/proc/acpi/thermal_zone:0# ll
> total 0
> dr-xr-xr-x  2 root root 0 2006-12-03 03:23 ./
> dr-xr-xr-x 11 root root 0 2006-12-03 01:05 ../
I think I have tick all necessary options in the kernel
> root@trinity:/usr/src/linux:1# cat .config|grep -i acpi
> # Power management options (ACPI, APM)
> # ACPI (Advanced Configuration and Power Interface) Support
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> # CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dy
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_ASUS=3Dy
> # CONFIG_ACPI_IBM is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_BLACKLIST_YEAR=3D0
> CONFIG_ACPI_DEBUG=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_SYSTEM=3Dy

When i run mbmon, i can see my processor temperature.
> > root@trinity:/usr/src/linux:0# mbmon
> > Temp.=3D 38.0, 25.0, 22.5; Rot.=3D    0,    0,    0
> > Vcore =3D 1.66, 1.66; Volt. =3D 3.25, 4.73, 11.80, -10.79, -4.66

I've make research about this bug, but i don't found anything.

So, do you think the probleme come from my kernel configuration ?

--=20
Sebastien Luttringer



--------------enigC480864277F5997C787E0CAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcja15mLU1UQgQ9YRApOLAJ9oZn431f9o+tcTMnGtVvaqNhD7EACfRq8B
7Fo++hy2igKT9Y5mipKfbDk=
=CYT5
-----END PGP SIGNATURE-----

--------------enigC480864277F5997C787E0CAE--
