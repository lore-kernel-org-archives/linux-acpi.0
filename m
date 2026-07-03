Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE77318EDA;
	Fri,  3 Jul 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070010; cv=none; b=A9k9QbsCsQzcwsBS3GrWgjXqoCJMiET0XUTRktTx6mt3W4m7zkkzOU09pUS1z+oQlKZdfnyPBpjFnlw5nq0pN5fYw+tSbFC0NOMSUiiXV4Dsitt4nWX7ThkkfDe5zShHGDHdepMGWe/fDSY/u+TeRh6y4Pw90USIlxZt/n8NiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070010; c=relaxed/simple;
	bh=vur8IvfQRfAoT74KzFHsz8I0LevL/nMjf/dA3BQpGTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju8DNLw1cga/nt1tjbq3b67SH5LhGx/GEMdgnS1vTy7TYKXA7VPIOoYZeN8l0aIE/Bc93DvBWkjBMcDImalhTOyJHfC8duI1tUe4cCQH3X2rpDRHAwZi/R5J8KIVyDXQOsaawg8RnRsKk6l41CByMJB6fG/OkZzTZsdDIj2Y3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I9GjHP2g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I9GjHP2g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C931EDB;
	Fri,  3 Jul 2026 02:13:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80683F673;
	Fri,  3 Jul 2026 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783070007; bh=vur8IvfQRfAoT74KzFHsz8I0LevL/nMjf/dA3BQpGTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9GjHP2gqKTZ7r7a2mrhbFtmXqz8GULYW6+SFi7Oj+w+EzsQjDqZjfoDEFMrZsnX2
	 WuGirvBwu8M5UlSU7yzIWZaU2iRjWQYH//gvNEFTpVAXJ9CyRUMnNDixfKmV3LRo8w
	 uOTvBZrKRnm4EwPf66ZrVwcZD3FfOsUDzqsiNLho=
Date: Fri, 3 Jul 2026 11:13:18 +0200
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
Message-ID: <akd9LkY5A97dbfYT@arm.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <20260410094145.4132082-3-zhangpengjie2@huawei.com>
 <akNxo5HzHARnrCT1@arm.com>
 <20631d1e-b7a0-4270-a69c-e07c420b1505@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20631d1e-b7a0-4270-a69c-e07c420b1505@huawei.com>

On Wed, Jul 01, 2026 at 08:21:41PM +0800, Pengjie Zhang wrote:
> 
> On 6/30/2026 3:34 PM, Beata Michalska wrote:
> > On Fri, Apr 10, 2026 at 05:41:45PM +0800, Pengjie Zhang wrote:
> > > arm64 implements CPPC FFH feedback-counter reads using AMU counters.
> > > Because those counters must be sampled on the target CPU, reading the
> > > delivered and reference counters separately widens the observation window
> > > between them.
> > > 
> > > Implement the paired FFH feedback-counter read hook on arm64 and sample
> > > both AMU counters together before decoding the requested CPC register
> > > values.
> > > 
> > > Also factor the FFH bitfield extraction logic into a helper and reuse
> > > it from the existing single-counter FFH read path.
> > > 
> > > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > > ---
> > >   arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
> > >   1 file changed, 67 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > index b32f13358fbb..b90a767b2a1f 100644
> > > --- a/arch/arm64/kernel/topology.c
> > > +++ b/arch/arm64/kernel/topology.c
> > > @@ -50,6 +50,16 @@ struct amu_cntr_sample {
> > >   	unsigned long	last_scale_update;
> > >   };
> > > +struct amu_ffh_ctrs {
> > > +	u64 corecnt;
> > > +	u64 constcnt;
> > > +};
> > > +
> > > +enum cpc_ffh_ctr_id {
> > > +	CPC_FFH_CTR_CORE  = 0x0,
> > > +	CPC_FFH_CTR_CONST = 0x1,
> > > +};
> > > +
> > Those should probably go under the #ifdef CONFIG_ACPI_CPPC_LIB section.
> 
> yes
> 
> > >   static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
> > >   void update_freq_counters_refs(void)
> > > @@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
> > >   }
> > >   static inline
> > > -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
> > > +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
> > >   {
> > >   	/*
> > >   	 * Abort call on counterless CPU.
> > > @@ -447,24 +457,73 @@ bool cpc_ffh_supported(void)
> > >   	return true;
> > >   }
> > > +static void amu_read_core_const_ctrs(void *val)
> > > +{
> > > +	struct amu_ffh_ctrs *ctrs = val;
> > > +
> > > +	cpu_read_constcnt(&ctrs->constcnt);
> > > +	cpu_read_corecnt(&ctrs->corecnt);
> > > +}
> > > +
> > > +static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
> > > +{
> > > +	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> > > +			   reg->bit_offset);
> > > +	val >>= reg->bit_offset;
> > > +
> > > +	return val;
> > > +}
> > > +
> > > +static bool cpc_ffh_ctr_value(const struct cpc_reg *reg,
> > > +			      const struct amu_ffh_ctrs *ctrs, u64 *val)
> > > +{
> > > +	switch ((u64)reg->address) {
> > > +	case CPC_FFH_CTR_CORE:
> > > +		*val = ctrs->corecnt;
> > > +		break;
> > > +	case CPC_FFH_CTR_CONST:
> > > +		*val = ctrs->constcnt;
> > > +		break;
> > > +	default:
> > > +		return false;
> > > +	}
> > > +
> > > +	*val = cpc_ffh_extract_bits(reg, *val);
> > > +	return true;
> > > +}
> > > +
> > > +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
> > > +			 struct cpc_reg *reg2, u64 *val2)
> > > +{
> > > +	struct amu_ffh_ctrs ctrs;
> > > +	int ret;
> > > +
> > > +	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!cpc_ffh_ctr_value(reg1, &ctrs, val1) ||
> > > +	    !cpc_ffh_ctr_value(reg2, &ctrs, val2))
> > > +		return -EOPNOTSUPP;
> > Right, so there might be an issues with that:
> > If you return EOPNOTSUPP here, that would trigger reading the registers again,
> > this time one by one. Is that intentional ?
> > Also counters_read_on_cpu might also return EOPNOTSUPP, in which case trying
> > again to read the counters is pointless.
> > 
> > I'm not entirely sure I understand the condition itself though.
> > This will fail if either of the requested registers in not really expected.
> > And that should probably be verified upfront ?
> > 
> > 
> > ---
> > BR
> > Beata
> 
> Right. The following code may be more appropriate.
> 
> static bool is_valid_cpc_ffh_reg(const struct cpc_reg *reg)
SO that is all fine, though the naming here somehow doesn't sit with me.
Maybe is_amu_ctr_reg ?
Anyways - you can ignore that, that might be just me.
> {
>     return reg->address == CPC_FFH_CTR_CORE ||
>         reg->address == CPC_FFH_CTR_CONST;
> }
> 
> int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
>              struct cpc_reg *reg2, u64 *val2)
> {
>     struct amu_ffh_ctrs ctrs;
>     int ret;
> 
>     if (!is_valid_cpc_ffh_reg(reg1) || !is_valid_cpc_ffh_reg(reg2))
>         return -EINVAL;
> 
>     ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
>     if (ret)
>         return ret == -EOPNOTSUPP ? -ENODEV : ret;
> 
>     cpc_ffh_ctr_value(reg1, &ctrs, val1);
>     cpc_ffh_ctr_value(reg2, &ctrs, val2);
> 
>     return 0;
> }
> 
> thanks,
> 
>    Pengjie
> 
That does look better - thank you.
I'd just also add a comment why the error code flip is here.

---
BR
Beata
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> > >   {
> > >   	int ret = -EOPNOTSUPP;
> > >   	switch ((u64)reg->address) {
> > > -	case 0x0:
> > > +	case CPC_FFH_CTR_CORE:
> > >   		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
> > >   		break;
> > > -	case 0x1:
> > > +	case CPC_FFH_CTR_CONST:
> > >   		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
> > >   		break;
> > >   	}
> > > -	if (!ret) {
> > > -		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
> > > -				    reg->bit_offset);
> > > -		*val >>= reg->bit_offset;
> > > -	}
> > > +	if (!ret)
> > > +		*val = cpc_ffh_extract_bits(reg, *val);
> > >   	return ret;
> > >   }
> > > -- 
> > > 2.33.0
> > > 
