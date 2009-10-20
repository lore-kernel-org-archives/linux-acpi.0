From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if
 it's already on.
Date: Tue, 20 Oct 2009 14:35:55 +0600
Message-ID: <20091020083555.GG19095@wrars-comp.wrarsdomain>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EUYUPHVNfBVWjsvu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from k66.ru ([87.224.128.21]:53658 "EHLO k66.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbZJTIfx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2009 04:35:53 -0400
Content-Disposition: inline
In-Reply-To: <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


--EUYUPHVNfBVWjsvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2009 at 10:22:47PM +0200, Corentin Chary wrote:
> Switching the camera takes 500ms, checking if it's on is almost free...
So if I don't want camera to be enabled, I should wait 500ms on boot to
enable it and then other 500ms to disable?

--=20
WBR, wRAR (ALT Linux Team)

--EUYUPHVNfBVWjsvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJK3XZqAAoJEOih81koZvPBrR8H/2BLDWns99DNDsUJgw6ULbyq
x3Bc4DK5jY7XSPss8NzTVHBfvKdHFP2rs7ltLh3yCQYWM3+lFC5BBQjRWbbsIYYd
0/TRSpSpWYqkAhGAAaCOSPD+iwaYKbr+J5Q+5szc8d4qwmpIdjwACTyLDhRgUsCJ
4KG1WjZIa/Vno4AZ8zVLDOymLaxVvaqL3GZP+OFNbZ/aWbpZQD0sqvZFM/ASlWzj
C+LUXfTdsyfHFZ1sb7uxwqnAOpBj855AMh4PzPbw+ccbcVNmtA7O02ntr9d8r4+K
3RBNzKVOULifTQAKQFr74utAJ3Fpx2JjiN2Wco+h4W1ptnVFiNKWbGUQ+LTK33U=
=2HXA
-----END PGP SIGNATURE-----

--EUYUPHVNfBVWjsvu--
