From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Wed, 13 Nov 2013 20:49:24 -0500
Message-ID: <20131114014924.GA17790@gchen.bj.intel.com>
References: <1384135666-1929-1-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13168 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab3KNCGE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Nov 2013 21:06:04 -0500
Content-Disposition: inline
In-Reply-To: <1384135666-1929-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2013 at 09:07:46PM -0500, Chen, Gong wrote:
> Date: Sun, 10 Nov 2013 21:07:46 -0500
> From: "Chen, Gong" <gong.chen@linux.intel.com>
> To: tony.luck@intel.com, bp@alien8.de
> Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
> Subject: [PATCH V2] ACPI, APEI: Cleanup alignment related codes for APEI
> X-Mailer: git-send-email 1.8.4.rc3
>=20
> We ever used *memcpy* to avoid access alignment issue between
> firmware and OS. Now we can use a better and standard way
> to avoid this issue. In the meanwhile, simplify some variable names
> to avoid the limit of 80 characters per line and use structure
> assignment instead of unnecessary memcpy. No functional changes.
>=20
> v2->v1: Make description information clearer.
>=20
Any comments? Boris/Tony?


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJShCwkAAoJEI01n1+kOSLHDlAP+wT3LlC0orcm2NywwK8BPAPD
3WW2nvNEcMWEhBabyj7gJhT7xWGSG25g46kEk/yNLyrs9YkTWC8F7YpPpz/BGtVe
3950iRVpLpjmYyxGm2STlOPEHCaC1ttvv5HfN0m1nFy1p5w+AcGBjs34IrXq+aId
mhwcW9RBw/FAEFlWYZ/GGsbb177oG+fzwCGQ9o63d3Mn4c5yIWn/y8MNpMM38kcb
DxRMCMaqF2P0ckP4yhyNG44W6RKO/DO7VUVbvdcVXovBhwdntMnmC2d7V2AVKuIe
MiD+ctLnusXbSzs+7BsYNe2XeTdZAZmkePd/kIYB0NuFGjqFv7mkfWtDhJBYMByD
x+xQbaSUu1vMh7mAzKyvp7OzmqFSf9x2/SXm+PgHeFwy/InKEOzLRPDGBJNwiUiX
4YCyINtkeasYPCKDbLyzSfdhd3smIcxyr1abZihVE4KU2w3F1DWIR2ldRjZPs1uI
2+d4/+LAsN0qR3f9F35+aS+6nsQ6Lst+LHlPnVQkU8l/weOrO5v31vlW9uZq3iw9
vNFtyAtP3eQgEUD7P5AhWKJoNUo2+WxG8+r3q0QTeIuscFKGa61yVYxxyNh00xg0
4964UW8l1GBqZQnfCdu0FSchrfEAnA1hiL/ngUEjlihpANr2jbI+ORXaGOmyXDtg
k3Dxs2mwfdCz618aiso7
=X6Ww
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
