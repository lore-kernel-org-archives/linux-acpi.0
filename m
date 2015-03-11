From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 13/22] ACPI: Change power supply ownership from driver
 to core
Date: Wed, 11 Mar 2015 03:09:41 +0100
Message-ID: <20150311020941.GB1017@earth>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-14-git-send-email-k.kozlowski@samsung.com>
 <20150310141759.GD11992@earth>
 <2313393.7LEYKI5LMJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42411 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbbCKCJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2015 22:09:59 -0400
Content-Disposition: inline
In-Reply-To: <2313393.7LEYKI5LMJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 10, 2015 at 08:52:50PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 10, 2015 03:17:59 PM Sebastian Reichel wrote:
> > >  [...]
> > >  drivers/acpi/ac.c                         |  32 ++--
> > >  drivers/acpi/battery.c                    |  55 ++++---
> > >  drivers/acpi/sbs.c                        |  68 +++++----
> > >  [...]
> > >  82 files changed, 2296 insertions(+), 1839 deletions(-)
> >=20
> > I would like to merge this patch via power-supply tree. Can you
> > please provide your Acked-By?
>=20
> I need more time to review this, sorry.

no problem.

> Also this patch was killed by spam filters on vger and in GMail, so I sup=
pose
> some people who need to see it are not able to.

Oh good to know. I didn't notice, since linux-kernel seems to be
fine with it. But it looks like there are problems with linux-input,
too.

https://lkml.org/lkml/2015/3/10/99
Google Cache: https://webcache.googleusercontent.com/search?q=3Dcache:-FhPl=
4Qzm4wJ:https://lkml.org/lkml/2015/3/10/99+&cd=3D2&hl=3Dde&ct=3Dclnk

-- Sebastian

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/6PhAAoJENju1/PIO/qaKkcP/2+nmh39fklupbMUH6A4wdO/
xSmJADWIGnXEBUP1pdyNM00CrkWxAPQbt9OQ9PfJFpZH2nswQbP1ZqwDNioX45xa
YLTjCQneCUS0VE2z9YOOcS+Nb/3qoiVGJ/PDIGL1ewRZCZiZjnryRTdUkKRO7KhI
WE6VfZDNVXMPp+IstBDh2bvy+g0Q2iSZxUUggGYmPY1u0vhszhvDwXefTZzvf7gJ
AXAkh+RPUe8bXaTa9uCHF1kufGrsfRAZOm0kT3emZAXHVpTIYwxf+OPIa+3+X318
xHqAISro/skhikxsJSa6114tGTSLHbvnUwUCNrB27eJ4YW333BVgshUuOa0NPm9W
amIQ+ebzxatq9UuYcM8adQgATb/YXRbkHWLBN6F1DWJFHk/er8CvpAj9MnFDAPYG
NWRnqFNHx4XL0qBcH7ZnPPj2U1WXgcCx5ta835rtp9hRnus5+CMexO/VnOMg2AK2
iF1XQwJnMImGxQK13ukAsRapKbh6BFLjqLFztrPif1BVglMVfNurwO5332+aKNZQ
VRI6n3JQwSREgLX69s3Hr+/VvkyCW9G3mqbmI9zZktlX8xgKIPn2Htx2hUubNq1L
AsIT8HcBlyqHzR7+KWjBBzjF713eTPbA2zmzlACOqYG7pnwuPgnBVsaVY5aWJEZf
9DmlxI2tp5Tc2SV5j9RF
=jJR8
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
