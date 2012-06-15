From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Fri, 15 Jun 2012 17:17:22 +0200
Message-ID: <4FDB5202.706@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF83AC81C5EF485582399D4E5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from babioch.de ([176.9.120.167]:37056 "EHLO babioch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab2FOPR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2012 11:17:29 -0400
In-Reply-To: <20120615113637.GA5904@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF83AC81C5EF485582399D4E5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi again,

Am 15.06.2012 13:36, schrieb Mattia Dongili:
> could you please test it?
Well, I've applied the patch (as well as the six others you submitted to
Matthew since the inclusion into 3.5-rc1 found here [1]), but it still
doesn't work. It's just the same as before. When booting without any
special parameters I'll get the brightness pop up when pressing the
appropriate fn keys.

With "acpi_backlight=3Dvendor" I don't get this pop-up at all.

In both cases the actual brightness of the screen doesn't change.

I've once again uploaded the output of dmesg in both cases to
pastebin.mozilla.org. You can find the version without any special boot
parameters here [2] and the one with "acpi_backlight=3Dvendor" here [3].

Anyway, thanks for your help so far. Any other clues?

Best regards,
Karol Babioch

[1] http://www.spinics.net/lists/platform-driver-x86/msg03384.html
[2] http://pastebin.mozilla.org/1662635
[3] http://pastebin.mozilla.org/1662636


--------------enigF83AC81C5EF485582399D4E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP21IGAAoJEHSaZc1HnzIVX1kQAIeEjMVLTVcVlnALLHoUM9mn
sr5pvOYTFrdANKoy910IEa+ERJeKXtWKLWBt6fyiTPpPFuuFePOO4QT0l7EupGOR
9ZG7kdHSaPSM4tZRslCAKtruDP5zXoaKvsMA/L6KfmZLAfAeqs3CukQz3KuBS3iv
Nv+ix2rh2ae7LTnJ40ffC8NSM29bQK585HHfi2bNZf1jeJ4KU6XaDDEsgqqRLkI0
xBUllKmwvYl+mVNpm19rNqGk9iftKH31pDZPONEskPeMyyV/F1FPkdczjfrsYZFe
gvOx+kLfOr1oavnoMOwufEQA/IPRAufk15Lc7yTHPq5zx8W94qPQEqR6RmIUjqBy
dBAc5H8PW9GHKZc28vSmR6iLxQ4bIntoptnC8Eu8nmyfEUVw2Og9BW5NHgn+6rL/
L6K8o7jeLPn9M9q5XuPHBlX8flyxgtPBRBNOdSZDd6er/5Nz11zn3OhBdTxOdnC0
no7by6VyKuEPxIfJJSMLc0ksMH5fQ6LjhqFKF67cTWxM3ak34tbKdrFg613majA9
o4EiefEloCGZzJE+tcvnYQy9pAvayS4T5f37YaqLdZX6/oN/+I5OTvOzLcaEqqe1
91VTd4g/RCvtkdVGgxaq/hpfgm2Ts5PD3PBrlzXzOBeJ8ZLGgHuiMTZ186KSQA5D
S5EdTSjtFIL9BCRDAZpG
=rY6X
-----END PGP SIGNATURE-----

--------------enigF83AC81C5EF485582399D4E5--
