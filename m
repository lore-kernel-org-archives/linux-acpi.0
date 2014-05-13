From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS chips
Date: Tue, 13 May 2014 15:14:01 +0200
Message-ID: <17288023.xXIEp15spG@devpool02>
References: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1535949.fR9zKMKHD7"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.emlix.com ([88.198.240.195]:39154 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbaEMNWb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 May 2014 09:22:31 -0400
In-Reply-To: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org


--nextPart1535949.fR9zKMKHD7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 8. Mai 2014, 14:59:04 schrieb Heikki Krogerus:
> These IDs are used on Baytrail boards such as Lenovo Miix 2
> and Asus Transformer Book T100TA. On lenovo Miix 2 8",
> BCM4752 is called LNV4752. All the rest of the IDs are for
> Broadcom BCM43241 module with the ID referring to different
> revision number.

Hi,

the AzureWave AW-AH691A module looks similar to me, it is identified as=
=20
AAM4752. However if I add it to that list I don't get anything, even wi=
th the=20
brcmfmac driver loaded. Is there any magic missing?

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Bertha-von-Suttner-Str. 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source

--nextPart1535949.fR9zKMKHD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAAECAAYFAlNyGpkACgkQq+RR+17trfwjOAP+LGJmVTOy0G/S9Fg4CPc5Iuy/
sFJsjDNjpLfMeRL9wnPi80fRD1sutA7VbtwwLP2mek5+aXp01d8PkHZofgomSPop
ZXMyw49YxTAQbGOSlJIZMzB1Fz1mCCr1Rxl3Tdqc63Ri2Gp1dh7Y/R6UKuMSpNWU
Ts+EpYNj3gCLxvdHT+Y=
=vFgb
-----END PGP SIGNATURE-----

--nextPart1535949.fR9zKMKHD7--

