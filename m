From: Henrik Brix Andersen <brix@gentoo.org>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Mon, 20 Feb 2006 12:17:49 +0100
Message-ID: <20060220111749.GC28090@osgiliath.brixandersen.dk>
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com> <20060220102639.GA4342@srcf.ucam.org> <756b48450602200249k1b79b108u42bfef68e1e9dba8@mail.gmail.com> <20060220110145.GB4489@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([134.68.220.30]:14985 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932499AbWBTLRw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 06:17:52 -0500
Received: from 83.72.33.139.ip.tele2adsl.dk ([83.72.33.139] helo=osgiliath.brixandersen.dk)
	by smtp.gentoo.org with esmtpa (Exim 4.54)
	id 1FB939-0004th-G3
	for linux-acpi@vger.kernel.org; Mon, 20 Feb 2006 11:17:51 +0000
Content-Disposition: inline
In-Reply-To: <20060220110145.GB4489@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2006 at 11:01:45AM +0000, Matthew Garrett wrote:
> Doing it via the input layer adds flexibility - it makes it easier for=20
> non-root uesrspace to handle things, but you can still have a root-level=
=20
> daemon that monitors /dev/input/event* and runs commands in response to=
=20
> keycodes.

Except that this daemon isn't written yet?

Regards,
Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: GnuPG signed

iD8DBQFD+aVdv+Q4flTiePgRAmkEAJ9vefNQot38K0iVDSsNi2PJOlMJ5wCdGcO9
w7HwTwO6c0nQCCXfDmkklkc=
=goqU
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
