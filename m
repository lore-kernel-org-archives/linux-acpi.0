From: The Holy ettlz <theholyettlz@googlemail.com>
Subject: Re: "I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
 region SMBI"
Date: Mon, 29 Dec 2008 14:42:17 +0000
Message-ID: <1230561737.2328.7.camel@rhapsody>
References: <1230560872.2328.4.camel@rhapsody>
	 <20081229143508.GD31266@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nsus2nRmyFc2BoUuhjM0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:41213 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbYL2Omj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Dec 2008 09:42:39 -0500
Received: by ewy10 with SMTP id 10so5042091ewy.13
        for <linux-acpi@vger.kernel.org>; Mon, 29 Dec 2008 06:42:37 -0800 (PST)
In-Reply-To: <20081229143508.GD31266@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org


--=-nsus2nRmyFc2BoUuhjM0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-29 at 14:35 +0000, Matthew Garrett wrote:
> On Mon, Dec 29, 2008 at 02:27:52PM +0000, The Holy ettlz wrote:
> > Hello,
> >=20
> > I see the following in dmesg. I don't know how report-worthy it is, but
> > anyway:
> >=20
> > ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI
> > region SMBI=20
> > [0x1c00-0x1c0f]
> > ACPI: Device needs an ACPI driver
>=20
> Your ACPI tables use the smbus controller themselves, so using a native=20
> Linux driver could potentially result in race conditions and bizarre=20
> failures. If you're not trying to use your smbus controller directly=20
> then it's not really an issue.

Well, i2c-i801 is loaded:

i915                   67080  2=20
drm                   201328  3 i915
i2c_i801               17820  0=20
i2c_core               29216  2 drm,i2c_i801

Should I be worried?

James

--=20
The Holy ettlz                              TheHolyettlz@googlemail.com
PGP key ID: 03F94B5D
-----------------------------------------------------------------------


--=-nsus2nRmyFc2BoUuhjM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklY4ckACgkQL/Is9AP5S13opwCfde+9BcFEnTIPaC5Y8peoN5KN
q/4An0l08dvBx4Arw0RQYICY1eExcT8/
=R4iW
-----END PGP SIGNATURE-----

--=-nsus2nRmyFc2BoUuhjM0--

