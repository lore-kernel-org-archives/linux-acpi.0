From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: [PATCH] ACPI / platform: add IDs for Broadcom Bluetooth and GPS chips
Date: Thu, 15 May 2014 09:50:45 +0200
Message-ID: <1965215.zv0fvIVbHP@devpool02>
References: <1399550344-26952-1-git-send-email-heikki.krogerus@linux.intel.com> <17288023.xXIEp15spG@devpool02> <20140514115611.GB12238@xps8300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1593497.y9aMIXIuDE"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.emlix.com ([88.198.240.195]:44336 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbaEOHus (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 03:50:48 -0400
In-Reply-To: <20140514115611.GB12238@xps8300>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org


--nextPart1593497.y9aMIXIuDE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Heikki Krogerus wrote:
> Hi Rolf,
>=20
> On Tue, May 13, 2014 at 03:14:01PM +0200, Rolf Eike Beer wrote:
> > Am Donnerstag, 8. Mai 2014, 14:59:04 schrieb Heikki Krogerus:
> > > These IDs are used on Baytrail boards such as Lenovo Miix 2
> > > and Asus Transformer Book T100TA. On lenovo Miix 2 8",
> > > BCM4752 is called LNV4752. All the rest of the IDs are for
> > > Broadcom BCM43241 module with the ID referring to different
> > > revision number.
> >=20
> > the AzureWave AW-AH691A module looks similar to me, it is identifie=
d as
> > AAM4752. However if I add it to that list I don't get anything, eve=
n with
> > the brcmfmac driver loaded. Is there any magic missing?
>=20
> Which machine are you using? Could you attach the output of acpidump?=


Hi Heikki,

this is an Aava Inari 8 tablet (pre-release hardware). To avoid spammin=
g the=20
list with the same DSDT twice, please have a look at my reply in the th=
read=20
"Re: [Patch V2 0/9] I2C ACPI operation region handler support".

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Bertha-von-Suttner-Str. 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source

--nextPart1593497.y9aMIXIuDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAAECAAYFAlN0cdYACgkQq+RR+17trfzKeAP/aqZ0+jlIQ6Cyel/2oZ7w+yFw
OsuAhjr2ha5wdeNgXt3eNRQtBAzH7tPSt27J/l/bv2d4XVE+r6gFyjpYtnICe6Jx
gfu5DKNJzt3+kXL2kNr/2nRUu+8VpTRtQdUa0RUINOn8RoihlQ6VzVLUhM8bD/N8
cIj5rFhco1vh2gw8Dpk=
=xDOB
-----END PGP SIGNATURE-----

--nextPart1593497.y9aMIXIuDE--

