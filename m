Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813166;
	b=KFbjl+qIcOvfncK2aJNJGYN1xPoT12b4POIB00QqNKBWeA+OBTnDZrQ57ncE8etiIzQq
	 PJchODY+HP/OxFp48RIApUET5TvppZkJR3KVvKdrMdQbvATPxH9ip6LKnwa1/mjm9D5Kr
	 zdlXfUvWHBNCL3E4iG/BFoPSIh0HhQK/gN8kZ3tJwnNVA04QuEfiCFf399+v10MOwD2kh
	 9H9mKGj4Pxjd35IuSYsh+vlTyZvDp1Ui2V28aM6pI6Ne4G4Tte87C7TSt/Kv2SUb+acYK
	 hxd0m+Lv3z3xXisojRsgvR+/VTQHxzK/zVerXETs1PL//fQxm4pRjm3cZS3PxjeRyqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813166;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Cookie;
	bh=x9ff6M0sp5VgSXGtim1j8WATytOjQDQzXjDY2PMCYn4=;
	b=z2b7StmoojIMJC8gNZU/LhhGYCHwX8vppCCTpQ0WgAYNP/owv0KpPmIByd6UxG+JEaM5
	 SCTDIdFkgRZTFVqCQjKPlqxHHdcx1X59S7knUHcXQqHO22MgeXTobwnJjoWyOUhmoAPnT
	 zPWkH/S9wPXEvWtessbnCs7NsOZiKS1yxm9BuyN0rchce15E8NFfB2sJ709G6Ad8RT7+k
	 RwXQJlOgTYXQ1Nq3SRTVJ7JtX/Ciutk79tC4GmN69wkMbwMd/0Hq3nd+k6tmLGQoRI0fL
	 Do08OdxMfzT5qmLjr3U/A/DSUgYydtmuKvJZ3ke/SNvZvDFqyYy3p0oNefbgx4Es/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63458606A32F;
	Wed,  4 Nov 2026 17:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640CF1F00A02;
	Wed,  4 Nov 2026 17:26:01 +0000 (UTC)
Date: Wed, 4 Nov 2026 17:25:58 +0000
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
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 3/7] cper: add helpers to handle Memory Error Section 2
Message-ID: <6016f3f4-7bf7-4b71-9b8f-06a7f31095b0@sirena.org.uk>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <20261104110355.1437249-4-pierre.gondois@arm.com>
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
	protocol="application/pgp-signature"; boundary="YNGke8jv/OA0HEod"
Content-Disposition: inline
In-Reply-To: <20261104110355.1437249-4-pierre.gondois@arm.com>
X-Cookie: All rights reserved.


--YNGke8jv/OA0HEod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 12:03:11PM +0100, Pierre Gondois wrote:
> Add separate location and printing helpers for Memory Error
> Section 2:
> - cper_mem_err2_location()
> - cper_dimm_err2_location()
> - cper_print_mem2()

> +int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
> +{
> +	u32 len, n;
> +	const char *bank = NULL, *device = NULL;
> +
> +	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
> +		return 0;
> +
> +	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
> +	if (mem->mem_dev_handle <= U16_MAX)
> +		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> +	else
> +		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
> +			mem->mem_dev_handle);

Should this be rate limited?

> +	len = CPER_REC_LEN;
> +	if (bank && device)
> +		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
> +	else
> +		n = snprintf(msg, len,
> +			     "DIMM location: not present. DMI handle: 0x%.8x ",
> +			     mem->mem_dev_handle);

Shouldn't this be scnprintf(), especially in the first case where the
strings come from the firmware?

--YNGke8jv/OA0HEod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrraqYACgkQJNaLcl1U
h9AajAf/W7R0CEUqtpIYoBl2hZk1nuGn9tkyTqfdf9mJWE4vi9igIzfRMj75lpki
tgacOw5Dggxv6jSV6YoNll9CUeJy9h+OUFf/N7/IRFO1R/EpdtFJZjX3sX8AlKwS
2OgJFjrKBU6Ei4+9hKoUYr4eWuibp+zZ+0FOgT75l3jk1ro+VFnums5/kmsutjVd
ysMyZPaUj8HMLzqXnx3Zf/pmDG0NHukEAC02hPy/QqPNGhD2o+OzXLTW5jwH83zh
5yVaCX18ZoN+E6dWl2Ii+I+6XjJV/wDxfqnZcOnPv76KYsLQidPRqywHwHMz+Tt6
HZHePjuzQwwJJiWOhDhb+xKVIOXocA==
=6Yex
-----END PGP SIGNATURE-----

--YNGke8jv/OA0HEod--
