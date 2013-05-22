From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/2 V2] ACPI/APEI: Add parameter check before error
 injection
Date: Wed, 22 May 2013 02:10:29 -0400
Message-ID: <20130522061029.GA25406@gchen.bj.intel.com>
References: <1369034433-13666-1-git-send-email-gong.chen@linux.intel.com>
 <1369034433-13666-2-git-send-email-gong.chen@linux.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F2DA69843@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46413 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369Ab3EVGRK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 02:17:10 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA69843@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2013 at 08:19:16PM +0000, Luck, Tony wrote:
> Date: Tue, 21 May 2013 20:19:16 +0000
> From: "Luck, Tony" <tony.luck@intel.com>
> To: Chen Gong <gong.chen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>
> CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
> Subject: RE: [PATCH 1/2 V2] ACPI/APEI: Add parameter check before error
>  injection
>=20
> +	/* ensure param1/param2 existed */
> +	if (!(param_extension || acpi5))
> +		goto inject;
> +
> +	/* ensure injection is memory related */
> +	if (type & ACPI5_VENDOR_BIT) {
> +		if (vendor_flags !=3D SETWA_FLAGS_MEM)
> +			goto inject;
> +	} else if (!(type & MEM_ERROR_MASK))
> +		goto inject;
>=20
> Maybe a comment before all these three goto blocks saying why we are jump=
ing
> around.  Perhaps:
>=20
> 	/* We need extra sanity checks for memory errors. Other types leap direc=
tly to injection */
>=20
Thanks, this comment is great.

> +
> +	/*
> +	 * When error injection type is memory related, param2 is the address
> +	 * mask of param1. This mask is used to ensure that the final address
> +	 * (param1 & param2) is meaningful. If param2 has a *weird* style
> +	 * like 0xf0f0f0f0f0f0f0f0, it means the injection address can be
> +	 * anywhere around param1, and that must be forbidden. In that reason,
> +	 * PAGE_MASK is employed to avoid injection address discontinuous.
> +	 * If one finds a special case not to satisfy this requirement, please
> +	 * fix it.
> +	 */
> +	pfn =3D PFN_DOWN(param1 & param2);
> +	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) !=3D PAGE_MASK))
> +		return -EINVAL;
>=20
> This has too much comment (rare!) and is still too complicated. Split the=
 tests apart?

Your comment is great to me. Boris ever mentioned that
"(param2 & PAGE_MASK) !=3D PAGE_MASK)" is not usual, most of situations are
like "(param2 & PAGE_MASK) !=3D param2). So he wants here I can give a clear
explanation for it. Maybe I can move my explanation into patch description.

>=20
> 	/*
> 	 * Disallow crazy address masks that give BIOS leeway to pick injection =
address
> 	 * almost anywhere. Insist on page or better granularity
> 	 */
> 	if ((param2 & PAGE_MASK) !=3D PAGE_MASK)
> 		return -EINVAL;
>=20
> 	/* make sure target address is normal memory */
> 	pfn =3D PFN_DOWN(param1 & param2);
> 	if (!page_is_ram(pfn))
> 		return -EINVAL;
>=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRnGFVAAoJEI01n1+kOSLHQFoP/2hEuDgSCguS0tY5/zmjyd8j
SlKOIBzVISxr4RntBu14MTdM6Tzmp0lVovaGBkx30CYg7OFASOopSSFyFCCbMoVp
mDi/1fLD5hIWbxQOtaGbe/ysbmMzhxQA/Jiq4ChQCvsl0tFeH8YHiDPu1r6HmnS9
4Da7hL0NCWyhXClx5xRjZNswZ2Zc4CKbZtJWDL9yqG1xpf2D57a48gYfj6xiiPZs
WQh63tZc4QPdzEgc9vQzv/QRNe+e5XAaFhvsm+WOVMJ2VDyFo5tc3hpcCa94+hp9
2Lj+hdf4TKmZobZve9DBwqsqEMrD96+kbcGNjav8ksCJCwlDVKlQl9IFP9fs6QRT
EHB0+5izZUMPnqjfeGwEfY1VyIBk56+HCxbdETOR4ca5oEez5+UuSdlnockZ5qyy
NHHwFoWPTFdAcSYrvXLp5DAO0A+hg4TnFwkwVQaKaS1aFkwhHxzeM9QmCRMeAc2I
c1/BF1GhcMFwBqyf8FtQib2pBM1fdVQ6rydHiKD+z5kd0IqHkclSGrf0YEZwAAjg
xm6Gq2opOcCYBtC+n7ojtuFsHpUQ3ZgfMJqZ7v/DqRVAnqqQuLjzkkkLuu6VbIFh
9yZBXLRrvN9KVBrhdiozcIffZJvNurO/+kZ3Q65r68D+1FVKO6tTvX3+sflfPvvR
9XypcoJcUG5yJpvonqQs
=a0Sh
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
