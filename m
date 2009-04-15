From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ACPI vs. hibernate on MacBook5,1
Date: Wed, 15 Apr 2009 17:48:51 +0200
Message-ID: <1239810531.6981.6.camel@johannes.local>
References: <1239802480.9071.14.camel@johannes.local>
	 <20090415135620.GB12481@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-dWnRYbUgo3dFexGlPD35"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:37726 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZDOPtZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 11:49:25 -0400
In-Reply-To: <20090415135620.GB12481@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>


--=-dWnRYbUgo3dFexGlPD35
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 22:56 +0900, Mattia Dongili wrote:
> On Wed, Apr 15, 2009 at 03:34:39PM +0200, Johannes Berg wrote:
> > Recently, since I upgraded to -rc1, I've been seeing this at hibernate:
> >=20
> > [13875.384603] ACPI: Preparing to enter system sleep state S4
> > [13875.385232] ACPI Error (hwvalid-0186): Denied AML access to port 0x0=
000000000000080/2 (DMA1 0x0081-0x0083) [20090320]
> > [13875.385745] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, =
Returned by Handler for [SystemIO] [20090320]
> > [13875.386244] ACPI Error (psparse-0537): Method parse/execution failed=
 [\P8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
> > [13875.386896] ACPI Error (psparse-0537): Method parse/execution failed=
 [\_PTS] (Node ffff88007e44edd0), AE_AML_ILLEGAL_ADDRESS
> > [13875.387584] PM: Saving platform NVS memory
>=20
> there are patches for this here:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D13036
> This should be the final one:
> http://bugzilla.kernel.org/attachment.cgi?id=3D20913
> Does it help?

Thanks, I'll give it a try later, but it seems like it would help to get
rid of the warnings, and the random delays I'm seeing are probably
something else.

johannes

--=-dWnRYbUgo3dFexGlPD35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5gHgAAoJEKVg1VMiehFY33cQAIMNgCcLe9VVxF1l5VPUaYan
XAs6NZiA1fu2QlBSD2v9snS6N6ksxBO8HXcrEfpD0zlVCi6fzwluCh36bBUdhur7
LYckoyWyztv98Kf6jdwzTI7Jjk5DeatxbpbE9OeX2qbjpojX0OA5JeXa86P0TUps
/IQ/HpskOT5LNq6zIvFllCOhZoUwtu9qZRIcdO2eEDBPM0ES3Vox1q6DGiPXcs5Z
tt5uC0/xPN65l6Qr8j6eMQlEYFFqQy8jFwqe5IvrZLMUeioO0b7ItjV/NeGQJgfa
0ZRV4joZz6AG95ZeqfYjtirOCReJjQCF4HQSbIs7iM/Rp7eirjbJTmiy4HwPIzzm
JFFcHii6bub3tC6wJR/Ce8yeKNHgU2vOEjhtKpLFkT/2bXt8cR15GxMtSPbu7rWA
00Oc1NM9fxqCbl7i27FFeyckzv6Aj/TSCd3Qg66OaKzt+sBJADV9Wk3b2crYLmR2
Mme30o8BKSC3L4gOGdG5fzftxpKYwNkGUa0+HVK1xjKM1foza0YM68kH/qyOZVz8
F4BECIjhYeI4jgWLz4yikTYGYAt6FI7GnmsNex5h71NCdxPjXNEu4aSC5/NsRm70
l3QNNRRD0bXK/kOPpr0qGDNKT/oBex2UURrB8Td3X3Rd3x0j1IOX/9nokyD6DktW
Lk3aY8ESYNriBD/UweAF
=6H4C
-----END PGP SIGNATURE-----

--=-dWnRYbUgo3dFexGlPD35--

