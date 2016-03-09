From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI, APEI: Fix leaked resources
Date: Wed, 9 Mar 2016 09:11:29 +0800
Message-ID: <20160309011129.GA19756@gchen-ros.bj.intel.com>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com>
 <1457452332-2673-2-git-send-email-johunt@akamai.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31804 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbcCIBQC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Mar 2016 20:16:02 -0500
Content-Disposition: inline
In-Reply-To: <1457452332-2673-2-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Hunt <johunt@akamai.com>
Cc: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2016 at 10:52:11AM -0500, Joshua Hunt wrote:
> Date:	Tue,  8 Mar 2016 10:52:11 -0500
> From: Joshua Hunt <johunt@akamai.com>
> To: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
>  lenb@kernel.org, ying.huang@intel.com
> Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, Joshua Hunt
>  <johunt@akamai.com>
> Subject: [PATCH v2 1/2] ACPI, APEI: Fix leaked resources
> X-Mailer: git-send-email 1.7.9.5
>=20
> We leak the NVS and arch resources (if used), in apei_resources_request.
> They are allocated to make sure we exclude them from the APEI resources,
> but they are never freed at the end of the function. Free them now.
>=20
> Signed-off-by: Josh Hunt <johunt@akamai.com>
>
Reviewed-by: Chen, Gong <gong.chen@linux.intel.com>

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW33hBAAoJEI01n1+kOSLHUkEP/3b6DEDDItLI7O4gE4go2QRH
UwuZklkMNq/WXOjbxCP/TZ8vBNFmvWq1HxU78qU84WJh8h6v+ybL5n4lY6q4OKrx
CWxjtWjABdqxLexrWKDbA3s9fEWiTQ8aYMWgrYCMGh0GWJdyzHWsc0T0mCdT2G4k
xahnSyo7LYIpy+7/sP68CFKNK6AMGaMab4tDOVqA4xlaRP2MNBQLtIVM+p7HPB3y
HfHU7knP7JQZuWguKNRWXH15GwGscbyeDDiHjxiykj3psz27XB/dskN8yDYd0W6X
d93LhJtXi936UabcgGr81aIkqsR28Hd+yhFZeOOosgkYnfn9ZoyjRKO1mlB1qdFZ
pGzg2/wLkNX2Z9PW50KLnMO0r8PlRFisU6EVKZvTTBHMjg1ylRfu70Z88gCA9tO8
xdXtwQhuaiS8nT6TELoRF8zvKVLzXa9eiTb+xN4TkIe+gnnK27Holn/uLU3qPffm
/f5KttUd/Q9abWDOZqC7OaAX/48jt8iABDCHmv7wIqaTQWzVU76lB55tHlHccoI9
6H3C3VZ85h6Kcb6yHyFwuZYfPRl3VxUqQPCA4kYol6jzgX7sh38lVBXTfdvs68hq
HoZn8YNblf4S36rMYGsrYBYrMgcYrjY1S371YvBiDwzHgl3ypVjGyoBiibJwQiqf
D2ARYm+7v6k70DMkQ8R7
=oyj3
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
