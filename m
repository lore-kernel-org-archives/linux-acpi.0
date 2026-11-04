Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809347;
	b=nLMi88ZqJ0JoNYn01T/jpgud5pXGcyeWQ2FWweEnYGTomSjPDDXpZrITDzgvXZDlVW3F
	 jRrCTt17mWDtCEwnOOFPTtF+hqM6e9hPQJw7w1vQF26GRaghbjN+J8XrQoejAXnTameyl
	 fHp/MZi15gt06RK72rt70vE9/qrw9yENyF8qHneDia0e/DC0MyWpz07VckmBdL+tlcO5l
	 K00iyLp89sj6L7IwNLat+a8yij8sPLk+ABHX5JI29hLLgUmDLGiCdKgVy7xfo6KLYY6S1
	 ce9+vCsId3L/AifGjSHMA2zto/4iyyC4XTH/BQxXzlkhZQRoEltJi7xsPoinj7XLbCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809347;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Cookie;
	bh=9U0/oc9XJY+Xacm4T/vZDVqd4pBBW7XgYn3Q3DVvguY=;
	b=QJN7u8TOTejKG7fevgJ5FGVerJpQ6c+srJ5S5WthKIETBzcxbOZfnKwStCtZb5dlDLIt
	 GLnjVFWO3zB0NYkz4ZzdKZ7ZfRRfN1aptgUCc+i02Y6gmukvg8ejkh7yrLjtJCn0+eND+
	 /0NEZjPJpMi+N2M3NMi1SX0dWPdzeMI9MMjvJt6Vyej5miTyOhQXvJz7FBb0E/Z3xMOD/
	 JWpwIpqfkUJfP2qqsUE63wNwM5nxlnS3kDsTsjIpuveCAnCMvdMNSZAj2SE7usD/J4+z1
	 hnNFtPPlxWWo+xoqtgO7JMAs6UU8R3ytTAei9x3CgC+nuTdx/Yme0DCTyYrbh+eaPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2C606AAC1;
	Wed,  4 Nov 2026 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68B71F000C1;
	Wed,  4 Nov 2026 16:22:22 +0000 (UTC)
Date: Wed, 4 Nov 2026 16:22:20 +0000
From: Mark Brown <broonie@debian.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/7] cper: use BIT_ULL() for processor and memory
 validation bits
Message-ID: <6d03947b-a5ba-4b06-88aa-98b277f87b8f@sirena.org.uk>
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <20261104110355.1437249-2-pierre.gondois@arm.com>
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
	protocol="application/pgp-signature"; boundary="jzUhbb9OnNJAWSS4"
Content-Disposition: inline
In-Reply-To: <20261104110355.1437249-2-pierre.gondois@arm.com>
X-Cookie: All rights reserved.


--jzUhbb9OnNJAWSS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2026 at 12:03:09PM +0100, Pierre Gondois wrote:
> Use the BIT_ULL() macro to describe flag bits instead of
> hexadecimal values which are harder to read.

This should explicitly incldue linux/bits.h - we're getting it via
implicit inclusion at the minute.

--jzUhbb9OnNJAWSS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrrW7sACgkQJNaLcl1U
h9Az4wf/WivK4KDFJ0wch956/CEIh+bACDWA56wnmvVsoE/J/nn8c1ukSvxYsDFq
zi6R9dtsLogp2aiwgQYzjNG/Jbh/j/p1X8z11U3yz9FlSuuqMKfP17PFfIc5ztaU
MWdIHm0Us70USugN9Ztj1rPwZn/cB2TTjs6eFOq2W/281453JX3q9vFkYueRCxnq
uxJeqTS0dXGI8DaGr9Gq7hmFWjXpFMxa3rWh6kiV6hBXKrA0VMRLPJrE0PWABAO9
Q18g2O0KzAQTQAGYAT7NvaqOfdSZtDBlzhLDdFQjrTaQY9xBpfGPcrriciZh+QYS
UzHOjdz9sF6BbDVrGvUmTWWyXCN9VQ==
=rQbU
-----END PGP SIGNATURE-----

--jzUhbb9OnNJAWSS4--
