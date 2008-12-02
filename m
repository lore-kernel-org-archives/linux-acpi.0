From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: Huge wakeups number from i1915
Date: Wed, 03 Dec 2008 00:11:47 +0100
Message-ID: <1228259507.4266.8.camel@hidalgo>
References: <1228236501.3873.2.camel@hidalgo>
	 <20081202171125.GA20405@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TZgqv8PavFrGJzHqGWqo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from molly.corsac.net ([81.57.48.219]:43712 "EHLO molly.corsac.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbYLBXLj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Dec 2008 18:11:39 -0500
In-Reply-To: <20081202171125.GA20405@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--=-TZgqv8PavFrGJzHqGWqo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mar, 2008-12-02 at 17:11 +0000, Matthew Garrett wrote:
> On Tue, Dec 02, 2008 at 05:48:21PM +0100, Yves-Alexis Perez wrote:
> > Hi, I have a problem with 2.6.28-rc6-00209-g6a12141. Not sure if I
> > should mail to acpi@ or drm.
>=20
> The interrupt code on i915 has been heavily rewritten. This sounds
> like=20
> an interrupt that isn't being acked correctly, so the drm list is=20
> probably your best bet.

done, thanks
--=20
Yves-Alexis

--=-TZgqv8PavFrGJzHqGWqo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk1wLMACgkQTUTAIMXAW67e0QCgr8M0hbF7sMhOZ1p8bdQMFEDt
+gYAn3shAtuZWpvIxqnZ8pkiHbO9IXYO
=mRGv
-----END PGP SIGNATURE-----

--=-TZgqv8PavFrGJzHqGWqo--
