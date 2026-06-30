Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E31D39E19A;
	Tue, 30 Jun 2026 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804923; cv=none; b=ArXfJ2VD69zaqWju2fOg/Ct/rdASxGUnL4at0rXC17kuUu4ahQCamt+JYHnvwPLEV/0UynGu81pAkexBZxkNQe1uoNy3iytZwA341L8Vi85ZxH2J9di0s+Jptwo59HxlmvwhOl01oY9IuoVmhayLxjB4+wrohNYjtRy87qT10tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804923; c=relaxed/simple;
	bh=0taVGT1m4jf8+Bd5/fvY49UWd51JJF0GPZjMsn5vOUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwilp8s5gZS8ef5pWndAyuadDWnltg0rbE7XEttJwkaelL2+vkB6TGpmzDV+zin75/K6A0jIqUbOw3k35LamstOvbMjxtey8eUGNGpSlpV2fAd/mBO1faGenzz9TaGxnZ1n/tVsS/ZbFs7sCEtBuNJOiKxE6PKXKeKS+q8G+xBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oLTfMik4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oLTfMik4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EBDC22D9;
	Tue, 30 Jun 2026 00:35:10 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4483F3F836;
	Tue, 30 Jun 2026 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782804914; bh=0taVGT1m4jf8+Bd5/fvY49UWd51JJF0GPZjMsn5vOUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLTfMik4Sv9mAkGsjjAf+7Vw1YD65vPjYpiOO3eGivwLAIwZEOqZbFzuzd+SthVgY
	 4DZsFldgSMW0BIm8uAG1typFraDU8wUL2m8mY3apZUbABO0JI7DWl03d1yxkjK4JVY
	 KxYC9wZpnXlleUIJyHY1t/26eMymZHQbTBDKcMw4=
Date: Tue, 30 Jun 2026 09:34:59 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	lenb@kernel.org, robert.moore@intel.com, zhenglifeng1@huawei.com,
	zhanjie9@hisilicon.com, sumitg@nvidia.com, cuiyunhui@bytedance.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com,
	xuwei5@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
	wangzhi12@huawei.com
Subject: Re: [PATCH 2/2] arm64: topology: read CPPC FFH feedback counters in
 one operation
Message-ID: <akNxo5HzHARnrCT1@arm.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <20260410094145.4132082-3-zhangpengjie2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410094145.4132082-3-zhangpengjie2@huawei.com>

On Fri, Apr 10, 2026 at 05:41:45PM +0800, Pengjie Zhang wrote:
> arm64 implements CPPC FFH feedback-counter reads using AMU counters.
> Because those counters must be sampled on the target CPU, reading the
> delivered and reference counters separately widens the observation window
> between them.
> 
> Implement the paired FFH feedback-counter read hook on arm64 and sample
> both AMU counters together before decoding the requested CPC register
> values.
> 
> Also factor the FFH bitfield extraction logic into a helper and reuse
> it from the existing single-counter FFH read path.
> 
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b32f13358fbb..b90a767b2a1f 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -50,6 +50,16 @@ struct amu_cntr_sample {
>  	unsigned long	last_scale_update;
>  };
>  
> +struct amu_ffh_ctrs {
> +	u64 corecnt;
> +	u64 constcnt;
> +};
> +
> +enum cpc_ffh_ctr_id {
> +	CPC_FFH_CTR_CORE  = 0x0,
> +	CPC_FFH_CTR_CONST = 0x1,
> +};
> +
Those should probably go under the #ifdef CONFIG_ACPI_CPPC_LIB section.
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
>  
>  void update_freq_counters_refs(void)
> @@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
>  }
>  
>  static inline
> -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
>  {
>  	/*
>  	 * Abort call on counterless CPU.
> @@ -447,24 +457,73 @@ bool cpc_ffh_supported(void)
>  	return true;
>  }
>  
> +static void amu_read_core_const_ctrs(void *val)
> +{
> +	struct amu_ffh_ctrs *ctrs = val;
> +
> +	cpu_read_constcnt(&ctrs->constcnt);
> +	cpu_read_corecnt(&ctrs->corecnt);
> +}
> +
> +static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
> +{
> +	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> +			   reg->bit_offset);
> +	val >>= reg->bit_offset;
> +
> +	return val;
> +}
> +
> +static bool cpc_ffh_ctr_value(const struct cpc_reg *reg,
> +			      const struct amu_ffh_ctrs *ctrs, u64 *val)
> +{
> +	switch ((u64)reg->address) {
> +	case CPC_FFH_CTR_CORE:
> +		*val = ctrs->corecnt;
> +		break;
> +	case CPC_FFH_CTR_CONST:
> +		*val = ctrs->constcnt;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	*val = cpc_ffh_extract_bits(reg, *val);
> +	return true;
> +}
> +
> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +			 struct cpc_reg *reg2, u64 *val2)
> +{
> +	struct amu_ffh_ctrs ctrs;
> +	int ret;
> +
> +	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
> +	if (ret)
> +		return ret;
> +
> +	if (!cpc_ffh_ctr_value(reg1, &ctrs, val1) ||
> +	    !cpc_ffh_ctr_value(reg2, &ctrs, val2))
> +		return -EOPNOTSUPP;
Right, so there might be an issues with that:
If you return EOPNOTSUPP here, that would trigger reading the registers again,
this time one by one. Is that intentional ?
Also counters_read_on_cpu might also return EOPNOTSUPP, in which case trying
again to read the counters is pointless.

I'm not entirely sure I understand the condition itself though.
This will fail if either of the requested registers in not really expected.
And that should probably be verified upfront ?


---
BR
Beata
> +
> +	return 0;
> +}
> +
>  int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>  {
>  	int ret = -EOPNOTSUPP;
>  
>  	switch ((u64)reg->address) {
> -	case 0x0:
> +	case CPC_FFH_CTR_CORE:
>  		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
>  		break;
> -	case 0x1:
> +	case CPC_FFH_CTR_CONST:
>  		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
>  		break;
>  	}
>  
> -	if (!ret) {
> -		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> -				    reg->bit_offset);
> -		*val >>= reg->bit_offset;
> -	}
> +	if (!ret)
> +		*val = cpc_ffh_extract_bits(reg, *val);
>  
>  	return ret;
>  }
> -- 
> 2.33.0
> 
