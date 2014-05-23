From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Thu, 22 May 2014 21:49:10 -0400
Message-ID: <20140523014910.GB16945@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13521 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbaEWCQ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 22:16:57 -0400
Content-Disposition: inline
In-Reply-To: <20140522105242.GG4383@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 12:52:42PM +0200, Borislav Petkov wrote:
> > > > +const char *cper_mem_err_type_str(unsigned int etype)
> > > >  {
> > > > -	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > > > -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> > > > -	if (mem->validation_bits & CPER_MEM_VALID_PA)
> > > > -		printk("%s""physical_address: 0x%016llx\n",
> > > > -		       pfx, mem->physical_addr);
> > > > -	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> > > > -		printk("%s""physical_address_mask: 0x%016llx\n",
> > >=20
> > > The physical address mask is still not part of the tracepoint as a u8=
 as
> > > we talked.
> > >=20
> > I thought out discussion is only for trace part. But it is OK to me to
> > make whole style aligned.
>=20
> No, I'm not talking about style - I'm talking about adding the physical a=
ddress
> mask to the tracepoint call:

If so, it has been there already. Maybe you should check patch 5/7. I merge
pa/pa_mask into pa_info as a whole to avoid too much calculation/logic in
trace.

> +TRACE_EVENT(extlog_mem_event,
> +       TP_PROTO(u32 etype,
> +                const uuid_le *fru_id,
> +                u64 error_count,
>=20
> Btw, is that the error_count we're reporting?? You surely can't claim
> that we'll ever report 2^64-1 errors, right?
>=20
> I'd make that u32 and I'd call it
>=20
> 		u32 error_number;
Fine.
>=20
> as it is a counter we're incrementing.
>=20
> +                u32 severity,
Fine.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfqkWAAoJEI01n1+kOSLHU+4P/RBAbP/GktSak+ifwnMTCLZG
9zXjw42duJA3AU1Obh7C+OVXwRj6rrX38HRdD9YirieTh+qYOF1ffp16bQrvXIZe
NSUOF7iqk0UOW36AyIWvM3mk+NlPHHP8pd1LwHL+JhNmz2AUjQakDoL8+N6aP69a
I4oExvIPUUPA1K+0f72zLp25EM5dLY70sbrl8Dh3obiotdQoojn0JQcZwNonROVC
0TbruEH70ft5OGLc/chnOwr+nsMAukLpzBtdz2FpPiLqRUbvC3RcSFWrQ7pqRio0
qMRznniW2bSb1Au8ckSNas3oyPY1GettDmSJUeNJ/yiJDGhTbKAFT8S4JfpF3XIS
3IF5T1BIv9gvF4NmnTre+pzHtihIabPMQ9K2lGrRpm3kZc1k/SrA8NiWYVfhN7kY
MgjeaWWTgzBL16lSdQW1vCct0+3MG2hpwNvxrr+wHvzrmx2N0ChWdWw+IcE258qP
IlvTWP9EnEYAW8vORVN2KYgSrDq6vDmwwk5DcOrpezFCDepwoKUo7PG86HJp0yRz
Mf1Oj31MYs7mnCpX+xCu14Ckm5E5/U7PRXYRpk3+4odSIVWJoWiidJ5DgbiWx8s6
JEiVQFM/Fyz+CrgmsSCPjmeXRCbf0ATl2/6VBVKyB3UsoRHA7Xm1DJhwyE2FIbor
uufXJ7l+/klWS6H701XB
=ZAxS
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
