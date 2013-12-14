From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Sat, 14 Dec 2013 08:42:43 -0500
Message-ID: <20131214134243.GB2823@gchen.bj.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
 <20131126065456.GB26098@gchen.bj.intel.com>
 <20131126072335.GA20917@pd.tnic>
 <20131127021541.GA32135@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9725 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196Ab3LNOAs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Dec 2013 09:00:48 -0500
Content-Disposition: inline
In-Reply-To: <20131127021541.GA32135@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com, linux-acpi@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 09:15:42PM -0500, Chen, Gong wrote:
> Date:	Tue, 26 Nov 2013 21:15:42 -0500
> From: "Chen, Gong" <gong.chen@linux.intel.com>
> To: Borislav Petkov <bp@alien8.de>
> Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com,
>  linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memo=
ry
>  error handling
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Tue, Nov 26, 2013 at 08:23:35AM +0100, Borislav Petkov wrote:
> > Date: Tue, 26 Nov 2013 08:23:35 +0100
> > From: Borislav Petkov <bp@alien8.de>
> > To: "Chen, Gong" <gong.chen@linux.intel.com>
> > Cc: tony.luck@intel.com, naveen.n.rao@linux.vnet.ibm.com,
> >  linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for me=
mory
> >  error handling
> > User-Agent: Mutt/1.5.21 (2010-09-15)
> >=20
> > On Tue, Nov 26, 2013 at 01:54:57AM -0500, Chen, Gong wrote:
> > > In this patch so-called cleanup includes an implied PFN check for UC
> > > error but missed in current codes.
> >=20
> > Right, I was about to look at it. You probably should add this to the
> > commit message so that it is clear.
> >=20
>=20
> How about this:
>=20
> Add proper PFN validity check for UC error and cleanup the code logic
> to make it simpler and cleaner.
>=20
> If OK and reasonable for this patch, would you mind helping to update the
> introduction in the patch before merging it?

Hi, Boris

Will you pick up this patch in your RAS request pull?

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSrGBTAAoJEI01n1+kOSLHrgUP/RHhRH6Xc8qnks80pg8lwkk2
PQy2hvUgKtTBEcHpGeDNqCohVhCSLml4C6Pha3YI4uvNXfNNCA7XKgyorce2AXUx
WOt5FoCCcoe7Jf+zOR9Q6N2mEmXiUyMbmE/BcrICsDp4Gfj64TJHd/K2YCM03BBf
Y5sAOvKf1FzJa44p7tqEkzDJrUHnFkuH8flyGaoFNxE3HoLC8WSg5FVf62J8PwE3
jiFYoMlH98fK3uSDCyMor22JSbAN1HF37zZeUt+Go/KGcrnADyu91cwdG90Xifbd
e53O22XMScbSRNb1AyZ7eRQnamfZsdXvbOCgl4lLE2Xwk5gssUL2/9003CE2PNb4
/2QqPpZsumx20j1x6qAPdrQ1Xck+lZC8iVSs1eFXxjV2R59o2+r5j4usqpkPxPNr
jU7NqWP3p2V9p2NLBWaxCy8iyNn3l5NkswuoS3YgVM16BGbRB+DpQ6XUcZsV9A90
vlCY2wILIvD2AVIKPtTLi616/SjlH5UTZiHBPvTqAKvk6eC0C93Nwddg5BamUy10
06NQB/nD+uh+m/7vJEIV9ISVWGkLnZUdxKc4F2vOvF/UPWAK+qKHiNtoPiqagqYL
WtduDzaMML68cE0Y1E6nWVi8z0FfTshCC6zo/O1UlycZ7yICBWLGmiEmurn2drFY
LYOaN90qYXd+sMtJzawP
=rm1O
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
