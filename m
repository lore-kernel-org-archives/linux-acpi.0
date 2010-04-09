From: Tony Vroon <tony@linx.net>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff - bug?
Date: Fri, 09 Apr 2010 22:20:27 +0100
Message-ID: <1270848027.3071.0.camel@localhost>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	 <20100408094905.GA3948@tiehlicka.suse.cz> <201004082243.18393.rjw@sisk.pl>
	 <201004092242.17341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-LhGhoRgUsXJhAY6xP2i5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:51699 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab0DIVUY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Apr 2010 17:20:24 -0400
In-Reply-To: <201004092242.17341.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michal Hocko <mhocko@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


--=-LhGhoRgUsXJhAY6xP2i5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> Please check if the patch below changes anything.
>  drivers/acpi/wakeup.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

That didn't change the behaviour for me, sorry.
(I made sure to go through a full power down session before trying the
patched kernel)

Regards,
--=20
Tony Vroon
UNIX systems administrator
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net

--=-LhGhoRgUsXJhAY6xP2i5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAku/mhsACgkQp5vW4rUFj5oFtwCdEJewDO5KuuQ4Tbd09adP//xf
gcEAn0e2wNiShRNPAFRBR4YRgvLUF78q
=nmBI
-----END PGP SIGNATURE-----

--=-LhGhoRgUsXJhAY6xP2i5--

