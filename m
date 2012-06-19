From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Tue, 19 Jun 2012 15:57:17 +0200
Message-ID: <4FE0853D.7050503@babioch.de>
References: <4FDA2051.3050108@babioch.de>  <20120614203914.GA2645@kamineko.org> <1340067574.1682.5.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA83E46E41F28B7D921863DA4"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1340067574.1682.5.camel@rui.sh.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Mattia Dongili <malattia@linux.it>, platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA83E46E41F28B7D921863DA4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 19.06.2012 02:59, schrieb Zhang Rui:
> so ACPI video driver is used before 3.3 and it works?
> please try this patch
> https://bugzilla.kernel.org/attachment.cgi?id=3D73576
> and boot without acpi_backlight=3Dvendor and see if it helps.
First of all: Unfortunately I still can't change the brightness. But I
couldn't reproduce a working solution with 3.3 and earlier (although it
definitely worked with 3.0/3.1 at some point in the past), so it
probably isn't your fault.

But the patch fixes another huge problem: It finally let's me boot a
3.4 kernel with KMS enabled. Beforehand I would get a black/blank
screen with kernels 3.4 and higher. This was some kind of a regression,
as I've experienced this kind of issue also with 2.6.38 and earlier. The
bug is filed here [1] and there are quite a few people affected by
it. So, thanks a lot for that!

Best regards,
Karol Babioch

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D50175


--------------enigA83E46E41F28B7D921863DA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP4IVAAAoJEHSaZc1HnzIVgfsQAJds9OUmyNF24GgBGuIH+WiA
W0/oQEDVBy1+NpxhVnrM7CyC4wM9EDNc0l0WHs+xFq4oaNVE1MMFMvrHhM08o1GS
BgsD5hwC3EbjP5eCYm2qucut8ZX/TerRlKlV55bVEk1rCz762g/Z5rLJ8Md8kR52
wDMi2wmiG2GYalaKCRKSg1J6+uoggjHpX1oZjnmewl8TalqGPOKP7jxuxO2rGG2P
4m06XuJ+oPaYCEXmcWRjWVwmqQ0zI415GX3/IgrPvKHBXsU9fkIzuYDN8ogq/3+f
0vn0CxVv42DQE9B5pe4xnPMRBtGUTSwphJWEkLa2vyZraUyaT9NkJ22p7E70/znL
qoHC0nOY/W37G0fFqG9cpzivf65SJhzya5IVfVL9PZFp5A4dv1fRT29MQkILT/+d
cACatjlDKMpvLUUMKdNyxNc1SkCEsDTh5hPpFbzBunoOejnrJiG7me1tbpqH4e3Y
4UsWal7wNk19tk6qtTcG2uWDnhCteTJVoXppGXWC/tEkVSwff5baqUSt0lydu3dF
800jm2tqpSXY45NoCiv2c0ODdJkXJLpscdNtLjIQcKnMtqNLjeJbMhcE6a/ow9SM
1E2EdOtGR507nRTLlsjDX3AUO+h4gV2zwSsibkn4fiEsttSBw1uRBVu/02eLlZyq
O8w9+IuXvf6YnkwxoLVZ
=Nw67
-----END PGP SIGNATURE-----

--------------enigA83E46E41F28B7D921863DA4--
