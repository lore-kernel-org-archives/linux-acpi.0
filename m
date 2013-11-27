From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Tue, 26 Nov 2013 21:15:42 -0500
Message-ID: <20131127021541.GA32135@gchen.bj.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
 <20131126065456.GB26098@gchen.bj.intel.com>
 <20131126072335.GA20917@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16664 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3K0Ccs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Nov 2013 21:32:48 -0500
Content-Disposition: inline
In-Reply-To: <20131126072335.GA20917@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, linux-acpi@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 08:23:35AM +0100, Borislav Petkov wrote:
> Date: Tue, 26 Nov 2013 08:23:35 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com,
>  linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memo=
ry
>  error handling
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Tue, Nov 26, 2013 at 01:54:57AM -0500, Chen, Gong wrote:
> > In this patch so-called cleanup includes an implied PFN check for UC
> > error but missed in current codes.
>=20
> Right, I was about to look at it. You probably should add this to the
> commit message so that it is clear.
>=20

How about this:

Add proper PFN validity check for UC error and cleanup the code logic
to make it simpler and cleaner.

If OK and reasonable for this patch, would you mind helping to update the
introduction in the patch before merging it?

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlVXNAAoJEI01n1+kOSLHNdcP/1v2mfdDGf9eoy7QRsXRZn2u
2nj6up2XK4irEoT/iQ1pyWU4/ERpqssFVTTIkNdWAtVKxGQOC01moiArS/GMen8E
Qfi/dXrjbNB0S7OAvBClyvhwrjU1lcrBjhqssC4fMGTnGyFz4QzYEIOv1vPAzr1B
vAPGSdVQqSWMgwZGA0Z0I24GVDxxkJG3Q0gTAHi95oVfvSqoWq1BvBGay6n97W9S
aDc1smX1S1hqOIR9MYDFPQg+DHlrtC3PaGkVFlGg0FkzN0BuDoAaGK2i8AxNA+xo
YspwlygmWYVDHrr5BMyDnZksJ32/wtj8g1HsoUYGckOZuZF/6hiZ10YPmuCms1m9
EA1dx6qannaFhxgSk6kNlnxqgROVoOWZ2wRqDiUD24cCHyNLxz0ZZDoCIhJMYXwq
X4pEdfT6ab+0rhcfEA/A/44wQo0ZkILsEt9P8DJwCC2faIpwJn8X7juPJTszMYUN
8VbFkCknwzHRc5NdZcbMhFMe0NodB/ibGT5tuvFwVcpdrUW/lKuyOtHCc3aAdUqb
6ofxT3Amq5Ysprmii9gS6CzeG0CXCTy1h4nGeP+1p3W85J2PDcHbFDPSucxlKZLG
Wwp74zPZgng3F+SDYptupTaIJDV0ExOmUJCNZtoEpSn+Fz6aoQfhFVpxxyci7FRt
6zlI1QP5LiSBO3E5XiRd
=pWVp
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
