From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Mon, 25 Nov 2013 02:09:30 -0500
Message-ID: <20131125070930.GB15621@gchen.bj.intel.com>
References: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
 <1385099825-31765-2-git-send-email-gong.chen@linux.intel.com>
 <20131125061209.GB2233@naverao1-tp.in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36133 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab3KYH0c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 02:26:32 -0500
Content-Disposition: inline
In-Reply-To: <20131125061209.GB2233@naverao1-tp.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 11:42:09AM +0530, Naveen N. Rao wrote:
> > +
> > +	/* ensure iff events by strictly check can be handled */
>=20
> Comment can probably be removed - not sure it conveys anything useful.
>
I think comments are always meaningful only if it is correct. BTW, this
comment is used to tell only following two scenarios can be handled
properly.

> > +	if (sec_sev =3D=3D GHES_SEV_CORRECTED &&
> > +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> > +		flags =3D MF_SOFT_OFFLINE;
> > +	if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RECOVE=
RABLE)
> > +		flags =3D 0;
> > +
> > +	if (flag !=3D -1)
>=20
> Wonder if this even compiles! That should be 'flags'.
>=20

I'm sorry for that. I must forget to select CONFIG_ACPI_APEI_MEMORY_FAILURE.
Thanks for your careful observation.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSkveqAAoJEI01n1+kOSLHnDsQAKUiyhTF7cgnThcqOZjPBZmS
iF+UZgL4/SuhfuEvgIhLtX44jWQhhvDcsq9CW+UR4TajtzXONdQxQmRK3w21296t
vssAjJ6itNQSMtAUp0944MhZKWkPOgw18vn32W45WfNGkUU25JhL0PWuTHfVrk06
kHLdFUa3pHVuIvT1uhrDfEQDtIM5u4w5C0ffJNRuxgDiPbTa3NZ4HvxCah0NX1Yc
ZT+l/UDprfqrLFGg9YbemKmD+D0c2O+bdlFQMluOwtUL81pO23dKCPUAI9Wut890
UmYBc9/YdJ37r7bWzJ0luhVZR1KmO+ZCGB80yVzA9wuPt0eCHQT1IUEQ8ZK4oW98
eVMPSEitnCec34AkEiyjylz4gjUgavmxBVygYoMKquBI1o6BFXwUjt/+LPZfIAy6
/tcGtJtHmRPYtqasZsO0Ix/u/cLfIZJx89lV8axF5ZQZLpEIKA2fwpqJTsnP30AI
7txY9QLPhr8Uptb2GSjiPnZaqeSDwadS29+yoe6TVQ9JjNr2voP9g/1Y+5VpN55v
8coLK4pTWuo8TPvHehYxyJgQJf+ysdXjLc735ajyfbtuPxIf0I/bx2WAkSJtDr0D
9RO9op3peIFYaXv3oaPH//ai2n1jr64AL9Ua0+ShV4VTwpTzEvLpx0YxGJRM88kb
lTH5d9XwRjM1UZDDmDmi
=lMdW
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
