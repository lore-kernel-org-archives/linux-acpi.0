Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295097;
	b=ngBgf5Y8DEWTz8S0afZ2vJLpWH5pKUv+koZND/eAAgfYCoUs7sKTiHchyJsTGQkmVHKS
	 4iZLaT6N+tF5I4g6mL0M1Yi/68Stu+dZhdmyPARCKgZvWSBi0aakgdC/5Q1BD9AG4aYCd
	 HhqKrEzp1KYn/gS9y3jjxbdC9NUWFcTpFKgKfr8FcOW/d7c/EqTtJnovOSg/C+e/iL8Pc
	 FXEOC1y9QFvEipz1+DE13OjoIhTDvCFnv/WPSd8g3rRcPCezDI6MR3fPfqhMjXZo68Wbi
	 EhypxnM5m6cZGiVWHAX9C4qCa+TkwziN5ttuZXfXPDVR6Ofs+mav8QOM05Bjuq7fbgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295097;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AdAheHZEWha9dAehEUE3zXja1Ighlj9AsimpUr1pvrE=;
	b=j2FUHUjJumrLPmyXRCNTYKH5zfvoUrImO1Osp6xgclVFuwxeTPgfIPI2OegXfLfg26FG
	 Lx3WumENZwIC/iVehCaSnkKALJnX0XPSb/yW5AylxH+bPGI89UdF+Al6tMg1VKs8jqo2H
	 d6MtCvL2Zo9KlCz9yg1ybes6cG0Q1zmfGrRgWqJ7BYy/v5vAz/35cB7IUuD0IRB6Io6Nl
	 HFRCTD31+smFDOOs9ORh3leB8KoTGqjFYlFUCAiDA5dVFdj4Sx6r6/2+h3jtFDC9JnQKh
	 pxHvAhpzyoXNqrCTCzHILRFrHWkbv4LzgIR5itot9+RXP79bw9OjtR6PE2rTn16ul9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="CEzYY/Lc";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD9606D61E;
	Tue, 10 Nov 2026 07:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71BD9606D61E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=CEzYY/Lc
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B57BD40E02A0;
	Tue, 10 Nov 2026 07:18:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PDmFULynP60D; Tue, 10 Nov 2026 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794295089; bh=AdAheHZEWha9dAehEUE3zXja1Ighlj9AsimpUr1pvrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEzYY/LcNnV752DyANYxRYqCdiauzIqFBIGjeUo6JWwRh0ZEG4G+xwcjd/4/pwNlo
	 SgC1zKTOZB8iZj1SDS/bnq28O2g1F9OToZcFVfOsDk8XmfPS4hbGyaDCsf+j3VDwre
	 cIfNdj6mhAsI24JcKwHYZRwtrzkX5OPIMiEOADgkoVPYE9kyOQhQHapkSWS6Vl7i6M
	 mb5gY8CoaZdZ+voHzb/N0bjI2U7yLfFgJwC+Gorbiw+wNd1dF19wLP2Chvvb6iL4ZW
	 9G/rstRfW2ee3NRHfVRqPxakhc8UEc+U9wzDzhMh7s2y43/WqXjxNLE9DfrkXcFmm3
	 cCGJh6S/X2KwesElRDcS4WRX6Ho6mvJpKvlvmqzdXrIgJ9Gt2l1tE0zlAdHPQIPHiB
	 U9FLw9v+3qrMxvthlBcLQDnBeR0RC0+p+Z3OzvQvyoOZPyaPIfRb8jbAK6UhPmAKE/
	 LgZhE85VY0O4WoaZPUllv4W5DulETM1Liy93VIjPi59oGnTu843OfF/+B48AnUfFEh
	 O8hFwxXE1ucYYRjs3Za94QTMFgl2E3vClWk4TvxxyPp/8j9fkibhVMuffhAaw/WGm2
	 zXb+zSbVyNXx9YL5sBT3MTKOfRUbrPaxHE1wMGKsAUGzY2OwEj5uSsnEy0Vaw0avhv
	 beFVzWRvzbf05CqvkRyxK/f8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A105A40E0255;
	Tue, 10 Nov 2026 07:17:32 +0000 (UTC)
Date: Mon, 9 Nov 2026 23:17:29 -0800
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	ashok.raj@oss.qualcomm.com, jic23@kernel.org, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v23 2/2] ras: mem: Add ACPI RAS2 memory driver
Message-ID: <20261110071729.GIavLFCfLKzPx8R0i0@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-3-shijujose2008@gmail.com>
 <20261017055852.GBatMOnEl66YObvU5k@fat_crate.local>
 <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>
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
In-Reply-To: <CAG4KcR+NOKHNzg6FN-oLLHgUxeitZHKXg9cN7dz24+Ap=RrwSA@mail.gmail.com>

On Sun, Oct 18, 2026 at 11:56:22PM +0100, Shiju Jose wrote:
> I have got an arm64 setup only, did not try to build for X86 recently
> after adding the following change
> of using iowrite64 and ioread64 as suggested by
> https://sashiko.dev/#/patchset/20260325165714.294-1-shiju.jose%40huawei.com
> 
> Following change is required to build for X86_64 build when using
> iowrite64 and ioread64, while it was
> fine for the ARM64 build.
> Note: I'm not sure whether RAS2 is needed for the 32 bit build or not
> and the result of the 32 bit build.

I'm not sure iowriteXX/readXX are needed here at all.

Documentation/driver-api/device-io.rst talks about all those different options
and the most generic ones are readq/writeq().

About those you're using, it says:

"ioread64(), ioread32(), ioread16(), ioread8(), 
iowrite64(), iowrite32(), iowrite16(), iowrite8()
        
  These are an alternative to the normal readl()/writel() functions, with almost
  identical behavior, but they can also operate on ``__iomem`` tokens returned
  for mapping PCI I/O space with pci_iomap() or ioport_map(). On architectures
  that require special instructions for I/O port access, this adds a small
  overhead for an indirect function call implemented in lib/iomap.c, while on
  other architectures, these are simply aliases."

and I don't see anywhere that you absolutely need those, judging by that
explanation there. But what do I know.

Unless there's a real reason you cannot use readq/writeq()...?

But those should give you the same fixed endianness when accessing little
endian ACPI so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
