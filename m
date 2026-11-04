Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814729;
	b=oQVFQU0jyc2o0V7UhZXuwgElziGZejM0GwL4u3vitdsWH4HRAowSKz2bwQ4sQsjbduxm
	 S5uVta9b+wCcNg9LiEMVV4mCfh7jda/wb6O6tiFGT1YA2Thp415k87GaRE173b3yxcAQ6
	 ysLBHz84kG429rTosVQSY/mIVzHTSqyr5a42OZzFfW0VmTCa3OVEGBNeTusr3RJ5HHZYW
	 +aQOCtb/cAHxCjrhONfgi32KXky7Yg2RpQIDO9W2kHoHuOVPkQzn0hNv9OeZAgdBfT07F
	 qtN/O6bp4nTi00B/s9EbJAdci7qnvE5AIpBw1XK/CV23u/ttaOQorcfs8pdNcG9+Cvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814729;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Cookie;
	bh=ac1TdzMdRVAfu/3pdJwOc0sC5HEYhrnVimqwcvhMZuY=;
	b=nq3/BN/r/GoFzzuEPTbQqKtFNjLWNLIpdWJbV17pc28U2dnSOkMFkybW68jlvc2m3UUV
	 Pp4y5++f9imWxZFP23VZ5VQX/9RCLNyc2if2lSEuqKD8fuN0NsAbg6NgO00l6VNDZ5c4G
	 QyMAWWcJPri9WZdVlq8l/SgPyvTdzw7WSH/o5yb+5W96WR83Gp8UauJjuVTLZswavYudz
	 YaofRNdEqd2VcZqyq5Bghlh/JoKTbE6KFGRjZPpAIgrgPTHERDpWlU+KQE420fkycjhfi
	 Pisbuit1GbdBN3T5iADWQrhoB/DsavntJmqVu7Fo0nGeAq4spCDUOfoYaLSDo679KnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D46071F41;
	Wed,  4 Nov 2026 17:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57251F000C1;
	Wed,  4 Nov 2026 17:51:51 +0000 (UTC)
Date: Wed, 4 Nov 2026 17:51:45 +0000
From: Mark Brown <broonie@debian.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/7] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <94b213b2-dabc-46b4-8d21-a5dc8e8e51bb@sirena.org.uk>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <20261104110355.1437249-7-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8UKtglv2OUYLjMwF"
Content-Disposition: inline
In-Reply-To: <20261104110355.1437249-7-pierre.gondois@arm.com>
X-Cookie: All rights reserved.


--8UKtglv2OUYLjMwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 12:03:14PM +0100, Pierre Gondois wrote:
> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
> records. Use a separate GHES notifier chain so existing consumers
> continue to receive legacy memory error sections.

> @@ -1008,6 +1021,16 @@ static void ghes_do_proc(struct ghes *ghes,
> =20
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued |=3D ghes_handle_memory_failure(gdata, sev, sync);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem_err =3D acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length < sizeof(*mem_err)) {
> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");

The v1 code uses pr_warn_ratelimited() which seems sensible.

> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
> +				       unsigned long val, void *data)
> +{
> +	struct cper_sec_mem_err2 *mem_err =3D data;
> +	struct edac_raw_error_desc *e;
> +	struct mem_ctl_info *mci;
> +	struct ghes_pvt *pvt;
> +	char *p;

> +	/* Memory error location, mapped on e->location */
> +	p =3D e->location;
> +	p +=3D cper_mem_err2_location(mem_err, p);
> +
> +	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
> +		struct dimm_info *dimm =3D NULL;
> +
> +		p +=3D cper_dimm_err2_location(mem_err, p);

Do we need to raise the size of e->location?  It's 256 bytes and
there's an awful ot of potential fields that could be decoded here,
including some with 64 bit IDs.

> +		if (mem_err->mem_dev_handle <=3D U16_MAX)
> +			dimm =3D find_dimm_by_handle(mci, mem_err->mem_dev_handle);
> +		else
> +			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SM=
BIOS range\n",
> +				mem_err->mem_dev_handle);

There's an equivalent print in cper_dimm_err2_location().

--8UKtglv2OUYLjMwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrcLAACgkQJNaLcl1U
h9Cbiwf8CL414tJA0b71RDfEqi+/59cDTX6lTkzXJzKGchYn2YCqF5pNEgaNIP4L
U8b9QzaaMJSQ7bwzHIZ8op0nj/yMBG47ggbuj0DEweeu9004HssW1o0DS3epuFps
ccL0B2DpwfoqfNtKL/N4kwTzZgZGEwxF1jJ02Up4H/nQ3DoX4D0h0SExGpJK/Aqo
pb9cDiTpII+1YMP8bw1Sd4CihbraxI30q313c4CCMkSDUGq85NLYZ4K85IwwATZF
Y2+bX8uL1Hd5jm+xsPTrDOdtT40Wr/mMUAKa0IxlzDCK3kGoYXlMeoYm7e1HI4KO
Oce91tEKWOpPveVa1U3hVyyHRvJI7w==
=0wR+
-----END PGP SIGNATURE-----

--8UKtglv2OUYLjMwF--
