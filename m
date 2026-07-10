Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACF19DF4F;
	Fri, 10 Jul 2026 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690563; cv=none; b=M6+o2vXrn4QZ//MqfjnO6zGSj85+B1FGOYgMVGiqasYWQW4iDkcIBV1my/ZqLe43S8L5SpbsKMSGTwqA7inTY6i8e9066ebx8rj5K6RksgX8vl/aqY03syOyZ+VwyYeGO5MxV5eQNwHtHFbTYjyedmmz0Rs2CKilVjC25WG5FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690563; c=relaxed/simple;
	bh=O6yfiHmVjh++kj3mIFoELPTa5h6lT7CwpxKruuuvLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onlg8YiHRdqmMulI0Xf97VyozQNSx/DZ/SF33d2ZWj9F7ls3vWng4ocX/bUxz+K9AohTtqkcwVRjqigIov4Hm00ZA3g68G5xnUqupUtXEyUWVkLifZWIVG+TK6s7L5MotBwGqalG6b7R5hDJRaRwcmAGZ1yY4WCcY9LXZRGZsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GOhfvWkt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GOhfvWkt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39421176A;
	Fri, 10 Jul 2026 06:35:56 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F2B3F66F;
	Fri, 10 Jul 2026 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783690560; bh=O6yfiHmVjh++kj3mIFoELPTa5h6lT7CwpxKruuuvLMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOhfvWktQwk8Z6pT+9xg9fGgKpYRyGuz87RGFGcQRsoQU9yRQL/g8kW4uoBdmwIMj
	 9BcXC/cGWW13telbDkMt7/LPm4bToQIOMAo/WnFLixmG8wuOriEbn36MPX6ezToN8f
	 Gj4d3NcjYxIlNJ9i6dP1Kwu/VH91CgYwwxQ52VKk=
Date: Fri, 10 Jul 2026 15:35:48 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Pengjie Zhang <zhangpengjie2@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, rafael@kernel.org, lenb@kernel.org,
	saket.dumbre@intel.com, zhenglifeng1@huawei.com, sumitg@nvidia.com,
	zhanjie9@hisilicon.com, geert+renesas@glider.be,
	cuiyunhui@bytedance.com, vanshikonda@os.amperecomputing.com,
	ionela.voinescu@arm.com, viresh.kumar@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, prime.zeng@hisilicon.com,
	wanghuiqiang@huawei.com, xuwei5@huawei.com, lihuisong@huawei.com,
	yubowen8@huawei.com, wangzhi12@huawei.com
Subject: Re: [PATCH v2 2/2] arm64: topology: read CPPC FFH feedback counters
 in one operation
Message-ID: <alD1NDEpHHLZtf9g@arm.com>
References: <20260708082818.808041-1-zhangpengjie2@huawei.com>
 <20260708082818.808041-3-zhangpengjie2@huawei.com>
 <fcf60ce5-7e8c-431d-aea9-218da5445fb5@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf60ce5-7e8c-431d-aea9-218da5445fb5@arm.com>

On Thu, Jul 09, 2026 at 01:11:13AM -0500, Jeremy Linton wrote:
> Hi,
> 
> On 7/8/26 3:28 AM, Pengjie Zhang wrote:
> > arm64 implements CPPC FFH feedback-counter reads using AMU counters.
> > Because those counters must be sampled on the target CPU, reading the
> > delivered and reference counters separately widens the observation window
> > between them.
> > 
> > Implement the paired FFH feedback-counter read hook on arm64 and sample
> > both AMU counters together before decoding the requested CPC register
> > values.
> > 
> > Also factor the FFH bitfield extraction logic into a helper and reuse
> > it from the existing single-counter FFH read path.
> > 
> > Tested-by: Sumit Gupta <sumitg@nvidia.com>
> > Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> > Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >   arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
> >   1 file changed, 84 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index b32f13358fbb..d28438f8b83f 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -373,6 +373,16 @@ core_initcall(init_amu_fie);
> >   #ifdef CONFIG_ACPI_CPPC_LIB
> >   #include <acpi/cppc_acpi.h>
> > +struct amu_ffh_ctrs {
> > +	u64 corecnt;
> > +	u64 constcnt;
> > +};
> > +
> > +enum cpc_ffh_ctr_id {
> > +	CPC_FFH_CTR_CORE  = 0x0,
> > +	CPC_FFH_CTR_CONST = 0x1,
> > +};
> > +
> >   static void cpu_read_corecnt(void *val)
> >   {
> >   	/*
> > @@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
> >   }
> >   static inline
> > -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> > +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
> >   {
> >   	/*
> >   	 * Abort call on counterless CPU.
> > @@ -447,24 +457,90 @@ bool cpc_ffh_supported(void)
> >   	return true;
> >   }
> > +static void amu_read_core_const_ctrs(void *val)
> > +{
> > +	struct amu_ffh_ctrs *ctrs = val;
> > +
> > +	/*
> > +	 * cpu_read_constcnt() incurs slight latency due to the
> > +	 * ARM64_WORKAROUND_2457168 check. Read it first to minimize
> > +	 * the sampling skew between the const and core counters.
> > +	 */
> > +	cpu_read_constcnt(&ctrs->constcnt);
> > +	cpu_read_corecnt(&ctrs->corecnt);
> > +}
> > +
> > +static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
> > +{
> > +	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> > +			   reg->bit_offset);
> > +	val >>= reg->bit_offset;
> > +
> > +	return val;
> > +}
> > +
> > +static void cpc_ffh_ctr_value(const struct cpc_reg *reg,
> > +			      const struct amu_ffh_ctrs *ctrs, u64 *val)
> > +{
> > +	switch ((u64)reg->address) {
> > +	case CPC_FFH_CTR_CORE:
> > +		*val = ctrs->corecnt;
> > +		break;
> > +	case CPC_FFH_CTR_CONST:
> > +		*val = ctrs->constcnt;
> > +		break;
> > +	}
> > +
> > +	*val = cpc_ffh_extract_bits(reg, *val);
> > +}
> > +
> > +static bool is_amu_ctr_reg(const struct cpc_reg *reg)
> > +{
> > +	return reg->address == CPC_FFH_CTR_CORE ||
> > +		reg->address == CPC_FFH_CTR_CONST;
> > +}
> > +
> > +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> > +			 struct cpc_reg *reg2, u64 *val2)
> > +{
> > +	struct amu_ffh_ctrs ctrs;
> > +	int ret;
> > +
> > +	if (!is_amu_ctr_reg(reg1) || !is_amu_ctr_reg(reg2))
> > +		return -EINVAL;
> > +
> > +	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
> > +	if (ret) {
> > +		/*
> > +		 * If AMU is unsupported (-EOPNOTSUPP), translate the error
> > +		 * to -ENODEV. This explicitly tells the generic CPPC layer
> > +		 * to abort immediately and avoid falling back to pointless
> > +		 * single-counter reads.
> > +		 */
> > +		return ret == -EOPNOTSUPP ? -ENODEV : ret;
> > +	}
> > +
> > +	cpc_ffh_ctr_value(reg1, &ctrs, val1);
> > +	cpc_ffh_ctr_value(reg2, &ctrs, val2);
> > +
> > +	return 0;
> > +}
> > +
> >   int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> >   {
> >   	int ret = -EOPNOTSUPP;
> >   	switch ((u64)reg->address) {
> > -	case 0x0:
> > +	case CPC_FFH_CTR_CORE:
> >   		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
> >   		break;
> > -	case 0x1:
> > +	case CPC_FFH_CTR_CONST:
> >   		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
> >   		break;
> >   	}
> > -	if (!ret) {
> > -		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> > -				    reg->bit_offset);
> > -		*val >>= reg->bit_offset;
> > -	}
> > +	if (!ret)
> > +		*val = cpc_ffh_extract_bits(reg, *val);
> >   	return ret;
> >   }
> 
> 
> So, more a nitpik that only applies if this set gets respun, but:
> 
> I don't think this FFH counter logic belongs in the arm64 topology.c file,
> its not really topology related.

I agree. Those bits should be moved.
That said, I think it would be best to land this first,
as it addresses a rather long-standing issue.
We can do the cleanup later. If needed, I'd pick it up soon'ish.

---
BR
Beata
> 
> 
> 
> 
> 
