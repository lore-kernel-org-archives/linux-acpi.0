Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD83D45CF;
	Tue, 23 Jun 2026 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216427; cv=none; b=LYt42U7o6g+eLHl0C5YC5r9HQDbmUqsfCHmCmhUomGQe2SeFqgIgWU0O6TJaIk33iJwmgs/8iUEPC5dFD/Z/XDlmCIHQEAamLysDWp7eAx0SLnOa8iSarPFvQ0phO6j7iyWopWxGot8GzGpxXEEyQDuBIRL/2rXG+ZGFPf0upFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216427; c=relaxed/simple;
	bh=On34ita2nAvS8lprK3YhCxor2vIWtZmMF1SpZM4SP8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1EmC9OO/yhUwKjjXYV2rtwLogFIN8Gjig7PKyF1rXQ8JdlB50yMLyh5XEUh/Wl1rndLlFxYda87SRFOc8uTwbyuwNr0l9TYKriUfcxZx7u5gZ2RNLkJIk9ykfym5QQIum+Z1TPriqaVrgyzJSHlp0Lq3L1EiWN+PQiVDxM8eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbwZAtiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbwZAtiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AD71F000E9;
	Tue, 23 Jun 2026 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782216426;
	bh=cvovPyg8ZSCUX7iJQAPw2UOA7YGXY8BWMaRT34BQcm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EbwZAtiKaYfnO//6uMTCthoBr3Z8E394Xk5iInLQV8c8CTaSMkIWmLXRxvbj/x9Cl
	 O8dnNGqTH7jYdSLjSFM1aBJUyGkgI26x4+Y9oxXdO5tb+/OKx8/Ecnf1/3+t5V09G1
	 LD8Hp7/xpZjOBgyJR1pvlwe8e3R+FI/mSzTMbohoHG9zzlMwq73lDCP7fukcM4g6It
	 u85+JcRCpULU2l+BCjpy+nDFJocln3s/y2DRd+s3UaxeuFRtLkm0PRXE58l9gV3mCx
	 IdmV8ceoit79kq5j0JdiIhGQ+Qg6dd7hFYX68EtfGRm9mfM5iOQ5j9vDUgZ9Zg8lTm
	 NAI7a1k/Pv6bg==
Date: Tue, 23 Jun 2026 13:07:00 +0100
From: Will Deacon <will@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: lpieralisi@kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, guohanjun@huawei.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rafael@kernel.org,
	sudeep.holla@kernel.org
Subject: Re: [RFC] arm64: early_ioremap fails to map ACPI MADT on 64K pages
Message-ID: <ajp25MIQJWWE1ziY@willie-the-truck>
References: <ajkFE6TmwW6B/huP@lpieralisi>
 <20260623024712.3480399-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623024712.3480399-1-pengyu@kylinos.cn>

On Tue, Jun 23, 2026 at 10:47:12AM +0800, Yu Peng wrote:
> Hi Lorenzo, Hanjun, Will,
> 
> Thanks for confirming.
> 
> I will send a proper patch for this. The change I plan to post is along
> these lines:
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index ... .. ...
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -79,7 +79,11 @@ enum fixed_addresses {
>  	 * Temporary boot-time mappings, used by early_ioremap(),
>  	 * before ioremap() is functional.
>  	 */
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define NR_FIX_BTMAPS		(SZ_512K / PAGE_SIZE)
> +#else
>  #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
> +#endif
>  #define FIX_BTMAPS_SLOTS	7
>  #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)

I still don't understand why this issue is specific to 64k pages, though.

In the example you gave, the thing wasn't even 4k aligned.

Will
