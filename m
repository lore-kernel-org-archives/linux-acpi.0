Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F03A9DAE;
	Thu,  9 Jul 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577478; cv=none; b=IIAS7NtgMMegNOegThCg23LaHE1LCY9WJHCLTAOKIHlFnT1OjbzfRimwqio1KZdNXy9AotfzHJ1Ow64XE0A9l84RQb75/SB+9mxIJjmLGX2R4f4/+NrgEowdz+Lp81YgesmsLr+57v2OCMS8hoZTAeIC4Prn2gX0JQxzRnETZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577478; c=relaxed/simple;
	bh=itxWaBlqVRCmP2fYWMzcg4qz2935JTm2SC8Oi54uD1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GshKrmA2RDhRXuTBYx6G2AVWUg073sbV4bsIWUtEs4wPmP7D+QJPbFodBUSXfLnsGslzjD2KJPHyeheZ//yKCevNnkfJeJn1UEQDmAAwUNTzUJt02w/8ArWPQOhEoT/Z8q61LIwHgR8MQz3BaUvKU90iESPQRmvkaRWM07RTfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=icQinZeR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="icQinZeR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8E524C0;
	Wed,  8 Jul 2026 23:11:12 -0700 (PDT)
Received: from [192.168.20.93] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E23D3F7B4;
	Wed,  8 Jul 2026 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783577476; bh=itxWaBlqVRCmP2fYWMzcg4qz2935JTm2SC8Oi54uD1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=icQinZeRKNzsPzk3/sSNE8qPqW9LFBFGtTPSElV0lnunbteAnCiDydJ4UBcBmtFa7
	 MSXv/CAhmLYPPJRAjRnQGessemvefVbaO8LLLV72R+KTDg/YQIIoU6o+IaQORCdmXy
	 JNuFaxk4S6O1hX6P+uR2HMPCD8fmbOi9gA6fFSbM=
Message-ID: <fcf60ce5-7e8c-431d-aea9-218da5445fb5@arm.com>
Date: Thu, 9 Jul 2026 01:11:13 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: topology: read CPPC FFH feedback counters
 in one operation
To: Pengjie Zhang <zhangpengjie2@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
 beata.michalska@arm.com, zhenglifeng1@huawei.com, sumitg@nvidia.com,
 zhanjie9@hisilicon.com, geert+renesas@glider.be, cuiyunhui@bytedance.com,
 vanshikonda@os.amperecomputing.com, ionela.voinescu@arm.com,
 viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linuxarm@huawei.com
Cc: prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com,
 lihuisong@huawei.com, yubowen8@huawei.com, wangzhi12@huawei.com
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
 <20260708082818.808041-3-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260708082818.808041-3-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/8/26 3:28 AM, Pengjie Zhang wrote:
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
> Tested-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
>   1 file changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b32f13358fbb..d28438f8b83f 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -373,6 +373,16 @@ core_initcall(init_amu_fie);
>   #ifdef CONFIG_ACPI_CPPC_LIB
>   #include <acpi/cppc_acpi.h>
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
>   static void cpu_read_corecnt(void *val)
>   {
>   	/*
> @@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
>   }
>   
>   static inline
> -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
>   {
>   	/*
>   	 * Abort call on counterless CPU.
> @@ -447,24 +457,90 @@ bool cpc_ffh_supported(void)
>   	return true;
>   }
>   
> +static void amu_read_core_const_ctrs(void *val)
> +{
> +	struct amu_ffh_ctrs *ctrs = val;
> +
> +	/*
> +	 * cpu_read_constcnt() incurs slight latency due to the
> +	 * ARM64_WORKAROUND_2457168 check. Read it first to minimize
> +	 * the sampling skew between the const and core counters.
> +	 */
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
> +static void cpc_ffh_ctr_value(const struct cpc_reg *reg,
> +			      const struct amu_ffh_ctrs *ctrs, u64 *val)
> +{
> +	switch ((u64)reg->address) {
> +	case CPC_FFH_CTR_CORE:
> +		*val = ctrs->corecnt;
> +		break;
> +	case CPC_FFH_CTR_CONST:
> +		*val = ctrs->constcnt;
> +		break;
> +	}
> +
> +	*val = cpc_ffh_extract_bits(reg, *val);
> +}
> +
> +static bool is_amu_ctr_reg(const struct cpc_reg *reg)
> +{
> +	return reg->address == CPC_FFH_CTR_CORE ||
> +		reg->address == CPC_FFH_CTR_CONST;
> +}
> +
> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> +			 struct cpc_reg *reg2, u64 *val2)
> +{
> +	struct amu_ffh_ctrs ctrs;
> +	int ret;
> +
> +	if (!is_amu_ctr_reg(reg1) || !is_amu_ctr_reg(reg2))
> +		return -EINVAL;
> +
> +	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
> +	if (ret) {
> +		/*
> +		 * If AMU is unsupported (-EOPNOTSUPP), translate the error
> +		 * to -ENODEV. This explicitly tells the generic CPPC layer
> +		 * to abort immediately and avoid falling back to pointless
> +		 * single-counter reads.
> +		 */
> +		return ret == -EOPNOTSUPP ? -ENODEV : ret;
> +	}
> +
> +	cpc_ffh_ctr_value(reg1, &ctrs, val1);
> +	cpc_ffh_ctr_value(reg2, &ctrs, val2);
> +
> +	return 0;
> +}
> +
>   int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>   {
>   	int ret = -EOPNOTSUPP;
>   
>   	switch ((u64)reg->address) {
> -	case 0x0:
> +	case CPC_FFH_CTR_CORE:
>   		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
>   		break;
> -	case 0x1:
> +	case CPC_FFH_CTR_CONST:
>   		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
>   		break;
>   	}
>   
> -	if (!ret) {
> -		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> -				    reg->bit_offset);
> -		*val >>= reg->bit_offset;
> -	}
> +	if (!ret)
> +		*val = cpc_ffh_extract_bits(reg, *val);
>   
>   	return ret;
>   }


So, more a nitpik that only applies if this set gets respun, but:

I don't think this FFH counter logic belongs in the arm64 topology.c 
file, its not really topology related.





