Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39E34844C;
	Thu,  2 Jul 2026 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033457; cv=none; b=B4+rhr3/wbv5BKzApC+ZI8sdhQAy8CaBbwOGCbyV0vqgnLT9dAYxCVlnbycUKuYKRSeGH9KthrT9HD+KImeEVkGzpTb66J/AQgJMteQ9f+XWwABEWwwObpCD9/utypyu8dtc2gM7LsH6nJHvYg2lJzs6UFzloz5zOEHTlyg80ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033457; c=relaxed/simple;
	bh=EYEsuiiHwcDZ0vxkQ9+K4ECvaRQaNKVj2ASUFUUKMW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaCcpnEFFA45aY2Mnkn8GYYPHutQ1ukY8xpt3o9NIvzO4olND8A15OkhFud7SOG2Klr2q4gf5u3g0fJwt6bjKvlLRYqEWFtPGJBJB9mP3nTiwzOQ4uoQlVvBSQb8dzIDeLz8MI1Lv0dx8vHtwJtRKzBaCu9t2ns9Gpn9P7fEtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e6MH4MXh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e6MH4MXh"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B69640E01CE;
	Thu,  2 Jul 2026 23:04:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4Ol7s9FKvBF9; Thu,  2 Jul 2026 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783033435; bh=fdKL0FEG6Gpj1fGVCDj7e23AAN55G66gRVnQURKxz5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6MH4MXh1ReBBzajIqk2URavbTtdhx9Pi3Tkl25t/nDi50K1qLkNnaWtcrQxAQUlC
	 h5Fn64qcMdO+yXL6Ymafdn5aDzUQyNS/Lk4181fFNhTF0HEiWxm/E7O+F/4XbG3rHy
	 +QSUGiSgtpNsUXavdI/Stf6+vrzAQW8RP0dawzW91QyEXBuGGK+NmLZgBpznzu1t0b
	 F2+9Jbn5UUvALkG36+9a9OnhHkYM5hxaH7VrgWiU4/Yds7HDpCmGxaFFxpedYmYTcp
	 reTsTn8dhJG2zaXFyQjF4NZHH0dsQDcrb7gse35gFLmUh3elk4U23x8dhX5YonFGUD
	 CeUKXySBkeHtCVaiZN76/lxugTGTcbY9MOkqluMwt1iEscP9aYvcA3OCh/nwlnakCw
	 ZDpkOMTgcxUUgqxkcV4CGx7B99nVvHoeHpeDN/CqkQRPhPgIDx5oxg/b+4SDtr+ziZ
	 HuRP2Y35GeV1bK3zyMUkEBfpL4pCino0Wb9ZTildzPIeVCjAwk4pV2zlA/P3Q4mnxI
	 evmjh4xkiqRke3riYkMSXpGrEGZdy6QzbKBE9Nv2wc2WQiOwcmuwU9DoIU6cUoJfA7
	 0OshTWkbw5bozO4wN4bbMqmgI/IHg/Ye6kDbSMcyJm9eFNV85qdd1KPS1zkmBdRCsA
	 bjEgl6rKKPmS3QzwM+1gAwAU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9315D40E0140;
	Thu,  2 Jul 2026 23:03:40 +0000 (UTC)
Date: Thu, 2 Jul 2026 16:03:37 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Vishal Badole <Vishal.Badole@amd.com>, dave.hansen@linux.intel.com,
	mingo@redhat.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, peterz@infradead.org,
	tony.luck@intel.com, chang.seok.bae@intel.com,
	wei.w.wang@hotmail.com
Subject: Re: [PATCH 1/2] x86/topology: Name the AMD core-type values
Message-ID: <20260702230337.GAakbuSfEOuD2K-d0I@fat_crate.local>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
 <20260629094349.533301-2-Vishal.Badole@amd.com>
 <20260702002704.GGakWwWMHxbRnSsfiO@fat_crate.local>
 <8733y1nj13.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8733y1nj13.ffs@fw13>

On Fri, Jul 03, 2026 at 12:06:32AM +0200, Thomas Gleixner wrote:
> Just do the mapping to vendor-agnostic types _once_ when you enumerate the CPU
> and store that information in the per CPU data.
> 
> Then you can do proper vendor agnostic matching against that and define
> the TYPE_ANY value as you want without ever colliding with vendor
> muck.
> 
> As a bonus get_topology_cpu_type() goes away too as the translation has
> been done already.

Yeah, we should've done it from the very beginning this way. Lemme hack it up
and see how it looks like.

Thanks for the cool idea.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
