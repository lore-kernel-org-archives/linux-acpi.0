From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Sat, 27 May 2017 13:14:15 +0200
Message-ID: <201705271314.16241@pali>
References: <cover.1495862272.git.dvhart@infradead.org> <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1752123.4sULdKiinR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36287 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756240AbdE0LOU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 07:14:20 -0400
In-Reply-To: <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart1752123.4sULdKiinR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi! Note that in WMI is stored binary MOF (BMOF; .bmf file; compiled=20
MOF), not ordinary MOF data which are plain text. So maybe it could make=20
sense to include "B" into name of sysfs entry? Or not? (Just suggestion)

On Saturday 27 May 2017 07:31:29 Darren Hart wrote:
> From: Andy Lutomirski <luto@kernel.org>
>=20
> Quite a few laptops (and maybe servers?) have embedded WMI MOF

Not "a few", but "lots of" :-)

> metadata. I think that Samba has tools to interpret it, but there is
> currently no interface to get the data in the first place.

No, there is no non-ms-windows tool for interpreting those binary MOF=20
(BMF) data yet.

> +	priv->mofdata =3D wmidev_block_query(wdev, 0);
> +	if (!priv->mofdata) {
> +		dev_warn(&wdev->dev, "failed to read MOF\n");
> +		return -EIO;
> +	}
> +
> +	if (priv->mofdata->type !=3D ACPI_TYPE_BUFFER) {
> +		dev_warn(&wdev->dev, "MOF is not a buffer\n");
> +		ret =3D -EIO;
> +		goto err_free;
> +	}

Are not those problems fatal for driver and therefore dev_err() better?

> +	sysfs_bin_attr_init(&priv->mof_bin_attr);
> +	priv->mof_bin_attr.attr.name =3D "mof";
> +	priv->mof_bin_attr.attr.mode =3D 0400;

0400 means to be readable only by root? Is there then reason why normal=20
user should not be able to read it?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1752123.4sULdKiinR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlkpX4gACgkQi/DJPQPkQ1LY2ACgknoeLlTvMmcMj4lH2IkiPaFo
6xwAn1tNoP4Qp2lqKrE1V9GMMfKJAR5E
=x/mB
-----END PGP SIGNATURE-----

--nextPart1752123.4sULdKiinR--
