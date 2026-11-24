Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494309;
	b=iDDBWr24g4BmpH3RPU8DeTguKzhQeKqccA56RWDtx2nf+XsI5i5OmoKrnOw/aeI4adeS
	 25/EP9zx+pm9RU9c7y1aMrJY0wcK6sM49f4v0HSMNuPcpKx1PUR+X2omKcQI+OxyB22lD
	 K3zUKqCm8SzcyPWVzbhuPmAtgfjjKwCKxNhMd5bZoqjna0RhFz1AJRfLVz4kb+sHsDh1n
	 4ZSzrnvKkShHXn/L0LjVzFbGNCgfo9GCtafQ1vRJJpwdcOunzFMr8n1ZS05nQB9BNBHYM
	 QMW4K9Tkf8dtjyLCxdENv8rd8lDAI92eHc6hTFqInRjdx3IVJC/s84HGP4VxFnIE0zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494309;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eNWO3EpiPwmHnNO60cMIGuW+yDmktqgkx2JQzl/eU3g=;
	b=rZm4kO8HepdpqY7kaalTapPoxi1jRhSsQNAkH02BCVg5VMS4wHt/afL6QRaVQr6BTcPU
	 MFbt11bPrb2GMNTSFcmLKhVlEU2JYXO9kD10ZglbxzFG4mX4W56k/QE+sHAT5HoyZwnFU
	 22B3mFVvAQuVYkbMiawVeRojwSzmN6o9Rd+LnebESzCiFkIH9YTC2RhXqakOWTfgW/Opi
	 NU6ksqfZBQ1Jj4ouGENRz8NFUSYgF8upv9aJK/yC23h82IoaqD9KXwZ6nLw3jjh5r7DDr
	 5X8C/uegFgwhN/7DL7qa2m50mWdJJS2umugtZMSNE5SadMn5pWNtD9ZArwjCp10cxvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hA4T4ixD;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD985606A31E;
	Tue, 24 Nov 2026 04:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD985606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hA4T4ixD
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 847A840E02CC;
	Tue, 24 Nov 2026 04:25:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xxH56HNX3bNB; Tue, 24 Nov 2026 04:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795494302; bh=eNWO3EpiPwmHnNO60cMIGuW+yDmktqgkx2JQzl/eU3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA4T4ixDuDgZ9yi2/PnIcEMObAR4VAR1hvQ5li4W49rSNbdwWKGkkZq89QtWRQt2p
	 OVHb5TJT+V6xkJjC7ijoXORjF5bAIHWd28wAICKTtgNJD15UzMSEtIkKcHydqSsQAF
	 6roG1vdAJC+2YILs4Q4xRMavbUMaC6BDAoVmDfg3+SWP7ZFqKLaRwv+j24CUQcmTd0
	 u7ts6nv09wWUqePKgwK9gc9JWEtcNkC6MQFc9sR6p7mi5lJJil9ukXsD1O8nrfbmR0
	 PHGyOdNTYbjwAgdSbssefbrqdaYHDqIbMPBYETtYceAl9JXPa42VAOzcvCbCzadFMU
	 2y84rcNj88IxZsjj6sR0PmoDXGDWipXcpMyfCOUn5rsmElHmxs7/rGTBDhHfW4lVR+
	 TRvP71Mu3jB7baCtSb4tpyMye/neeLq6/eOilNQuhG7s3aBhYpNhXfcWXpIOzMVVyI
	 9eqpKS7fTk+fr87Yc0t122iYwIPoTvvOjwm87E9Fk+VUBbXW3PgQ3CbzbJ4g8Dlf0b
	 eXzbZqcqZ+rX96uLpW0iN9bCN+DHSHvnsnvpCTLD7uEIn/GnMd7mbb7r6J6jwGMFz3
	 R8MM4SoTRH9KLrzmP193gwA0OEX4P35wnmURI6Iaqm1SsC6AvetKA7ogBekQ92Pd57
	 OKYC9Zur7wF3E1q9StArfqZg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FC8040E02B4;
	Tue, 24 Nov 2026 04:24:37 +0000 (UTC)
Date: Mon, 23 Nov 2026 20:24:34 -0800
From: Borislav Petkov <bp@alien8.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
Message-ID: <20261124042434.GMawURgn0Uap26S6US@fat_crate.local>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>

On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:

What in the h*ll is a Memory Error Section 2 record?

Your RFC doesn't explain it either:

https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t

so it must be something magical...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
