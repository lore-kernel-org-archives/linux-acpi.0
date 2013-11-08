From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Thu, 7 Nov 2013 21:33:39 -0500
Message-ID: <20131108023339.GA32312@gchen.bj.intel.com>
References: <1383811873-27654-1-git-send-email-gong.chen@linux.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F31D5A29A@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32507 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473Ab3KHCtm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Nov 2013 21:49:42 -0500
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31D5A29A@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2013 at 08:51:32PM +0000, Luck, Tony wrote:
> Date: Thu, 7 Nov 2013 20:51:32 +0000
> From: "Luck, Tony" <tony.luck@intel.com>
> To: "Chen, Gong" <gong.chen@linux.intel.com>, "bp@alien8.de" <bp@alien8.d=
e>
> CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
> Subject: RE: [PATCH] ACPI, APEI: Cleanup alignment related codes for APEI
>=20
> > We ever used *memcpy* to avoid access alignment issue between
> > firmware and OS. Now we can use a better and standard way
> > to avoid this issue. No functional changes.
>=20
> There are some other cleanups in here (changing variable names,
> using structure assignment instead of memcpy).  Commit message
> should describe them all, not just the change that you started out
> to make.
>=20
> -Tony
How about this:

We ever used *memcpy* to avoid access alignment issue between
firmware and OS. Now we can use a better and standard way
to avoid this issue. In the meanwhile, simplify some variable names
to avoid the limit of 80 characters per line and use structure
assignment instead of unnecessary memcpy. No functional changes.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSfE2CAAoJEI01n1+kOSLH0q4P/3Pt+yIX7rep90VVbMGPwQDY
BcUTFZpQPm1ybRBKua6gwKN4kfzkwrK0JGHl+gz86e1GFIBSXjL3y67RxBFhgOwa
plrvryRnVtdfdEdlNgfM2hqUwOjpZ+Db+TzwNuuZZDtLKGxyNzh8t3UqvNE1hXlL
OCxvDfXQED+bnieWQYhWLZfIWL7pg5+zf4QgICYZYmxQjCT2W/Db4rewV2QnxCw/
/x3f2vSjHsApE5lok7VFqLKMh/mjhncxQU65I41ir7lvxNNxZ1tcLpyY0D/Ngg2l
vgPD6kSv9BZ6o2ycrBFANiXqwBEiAFuJGPpZE1++Mt6yCkYuHyL1WW6nLelNKLCu
mdPARXLGnu7PMyBCfbXW12PZ8PXDGYtQsQP2mGB5WV+Fse/Vyd9MTunjzVaMNnVp
JBJEW5XCKDaj7Ssc1MhJvbIwW2wpXFPZCwh6hh2SO0zU3bhaWvrE/EkQuBuCq7s8
h7fBmWIkvVbRWa9cewqVwbKhoZlpA/wW/EdkOZFwSi4pjqaLOgnMJ3F+9ENclEnA
uDtXxkyZeQBtc1SDU2UN3LRk1VZxAbEPH8WM61SJir+xEajpMYA0M39B8x+MSOdg
FvhXBUgs47p6KZ8K4w745jiU9QLbHcIkpeJ0NNkqfhMEoHY+lx8skMuKDeybw8B/
m7okx9v2WV8qQsEZLedX
=rNlQ
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
