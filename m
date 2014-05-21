From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Wed, 21 May 2014 19:51:59 -0400
Message-ID: <20140521235159.GB1644@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4735 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbaEVATP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 20:19:15 -0400
Content-Disposition: inline
In-Reply-To: <20140521110521.GF21205@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2014 at 01:05:21PM +0200, Borislav Petkov wrote:
> > +const char *cper_mem_err_type_str(unsigned int etype)
> >  {
> > -	if (mem->validation_bits & CPER_MEM_VALID_ERROR_STATUS)
> > -		printk("%s""error_status: 0x%016llx\n", pfx, mem->error_status);
> > -	if (mem->validation_bits & CPER_MEM_VALID_PA)
> > -		printk("%s""physical_address: 0x%016llx\n",
> > -		       pfx, mem->physical_addr);
> > -	if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> > -		printk("%s""physical_address_mask: 0x%016llx\n",
>=20
> The physical address mask is still not part of the tracepoint as a u8 as
> we talked.
>=20
I thought out discussion is only for trace part. But it is OK to me to
make whole style aligned.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfTwfAAoJEI01n1+kOSLHehUP/RRMOM5LGrTgl8DkR7o3mbBa
mOpNtGijSKa5RWZunTSeZ8aXLjXblodH8doGgcuJlCsw9rH/7/8B48hFFPWoH0et
r1Nc2UjLWUjUksNc1VwdyL/ehe++3N8kcVXFhRF/OoPT6XlZWmv8ZQpT55MTtQsu
wPy0cglfBZ+OVMPtua5mGne/FCuThKWYf/MNtARAUD8wOLmga8/wcpYJCPi1wVCW
GnzBuQMEM/dD1ebvg0q/m3i8lL/QwXmBYdLF0g8eWXFuW6Dn7Hnmo4cVhrA7DJr3
BCxemgkmdwoEtbJrBCadkbjRT4Hsj/setzsmZMRa8NWMfYDuGxvSGYDcgX9BcJqx
F/v+HF/+7xhNtFC+38NIyqRWNXU1lChRCP7jmm3td/IJXZ1I355wn/QxyJIXApDW
extpwR8fLTrFCZnSpTs0nmgFh0CFEmXwCMsWu+2GRrThugxGzkYWFao24FS+1jNr
jfHvs9lb+X+XDBfavo2oJxSOTFavQNUVDRoGd9f92XeDbexJySQX2tADHLSwJjeV
eugYMoupzLtdSfKXoppvLxdsZR7dAqssnaTt2W+VLc0loqsBuw7QA1auERs7NsWQ
nU+BWSyuWv9SzEFYYNPtA7MxUG/YTERu1ysGdoXKhnVle/7YG1fT9QJkoBvVQrDK
Aay2zXcI8ytbj/MMiqIZ
=y37q
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
