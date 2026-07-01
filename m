Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52B4DBD63;
	Wed,  1 Jul 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908515; cv=none; b=QmO7sTUK3EX4IvRRdCGcQNDLGDlvBRMoI4t1RAE3Bcdk4a40qjgiC6bNe9pKe4aSQK3Cy4wuQkWy3yBrhUUGfckF2FlizaGUPugOw+XVF5ePFsGCACu6ZikV38aZUdctKFoq6Q81OGgNwAHlza9Rq4XMBuwu1s4IJ6rR/HMvHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908515; c=relaxed/simple;
	bh=/abY86rwxSeDKedgCcxxsCmpPAqpGss1JdixMfylqMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fZB6JEdj3l545T+Aw0E+TE1qfM2j8ExTxiHSuEjBRv85xTfFdh/Me9C2kEezYO0zcXSFEFgiCBb1LxeSE2n1XNbkxQfz2P1PXx+LoqP/yI9tTjAfXIzcB6kQg0b5Fb+dxD/39zZmH30l0jTAjvZb3znZ048whYstQ1MqKjmqVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xhhPRLKA; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xhhPRLKA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S/hf+q9b0Imft89tr7ZBqATJk9FmRe3I1tT3paesQfw=;
	b=xhhPRLKApC1ymyEUY24zz+xLOawyLVoBkhRJmtUi1b/Em0d7SEFcndducAFvVeRZ32AyKx4MG
	Hr3IwQpojMuZ+5AsbcULwmdjJF3WWkfo/LJRBo4cgLUXUVHuKMoAqzzX0Cv8hJI2/B6LxkidA2m
	RlvwxoIk5TJe+7bltpy+nkk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gqzRR0g5Tz1cyT2;
	Wed,  1 Jul 2026 20:12:35 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 68A0440580;
	Wed,  1 Jul 2026 20:21:43 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Jul
 2026 20:21:42 +0800
Message-ID: <20631d1e-b7a0-4270-a69c-e07c420b1505@huawei.com>
Date: Wed, 1 Jul 2026 20:21:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: topology: read CPPC FFH feedback counters in
 one operation
To: Beata Michalska <beata.michalska@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <sumitg@nvidia.com>, <cuiyunhui@bytedance.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <wangzhi12@huawei.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <20260410094145.4132082-3-zhangpengjie2@huawei.com>
 <akNxo5HzHARnrCT1@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <akNxo5HzHARnrCT1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 6/30/2026 3:34 PM, Beata Michalska wrote:
> On Fri, Apr 10, 2026 at 05:41:45PM +0800, Pengjie Zhang wrote:
>> arm64 implements CPPC FFH feedback-counter reads using AMU counters.
>> Because those counters must be sampled on the target CPU, reading the
>> delivered and reference counters separately widens the observation window
>> between them.
>>
>> Implement the paired FFH feedback-counter read hook on arm64 and sample
>> both AMU counters together before decoding the requested CPC register
>> values.
>>
>> Also factor the FFH bitfield extraction logic into a helper and reuse
>> it from the existing single-counter FFH read path.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 67 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index b32f13358fbb..b90a767b2a1f 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -50,6 +50,16 @@ struct amu_cntr_sample {
>>   	unsigned long	last_scale_update;
>>   };
>>   
>> +struct amu_ffh_ctrs {
>> +	u64 corecnt;
>> +	u64 constcnt;
>> +};
>> +
>> +enum cpc_ffh_ctr_id {
>> +	CPC_FFH_CTR_CORE  = 0x0,
>> +	CPC_FFH_CTR_CONST = 0x1,
>> +};
>> +
> Those should probably go under the #ifdef CONFIG_ACPI_CPPC_LIB section.

yes

>>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
>>   
>>   void update_freq_counters_refs(void)
>> @@ -397,7 +407,7 @@ static void cpu_read_constcnt(void *val)
>>   }
>>   
>>   static inline
>> -int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
>> +int counters_read_on_cpu(int cpu, smp_call_func_t func, void *val)
>>   {
>>   	/*
>>   	 * Abort call on counterless CPU.
>> @@ -447,24 +457,73 @@ bool cpc_ffh_supported(void)
>>   	return true;
>>   }
>>   
>> +static void amu_read_core_const_ctrs(void *val)
>> +{
>> +	struct amu_ffh_ctrs *ctrs = val;
>> +
>> +	cpu_read_constcnt(&ctrs->constcnt);
>> +	cpu_read_corecnt(&ctrs->corecnt);
>> +}
>> +
>> +static u64 cpc_ffh_extract_bits(const struct cpc_reg *reg, u64 val)
>> +{
>> +	val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
>> +			   reg->bit_offset);
>> +	val >>= reg->bit_offset;
>> +
>> +	return val;
>> +}
>> +
>> +static bool cpc_ffh_ctr_value(const struct cpc_reg *reg,
>> +			      const struct amu_ffh_ctrs *ctrs, u64 *val)
>> +{
>> +	switch ((u64)reg->address) {
>> +	case CPC_FFH_CTR_CORE:
>> +		*val = ctrs->corecnt;
>> +		break;
>> +	case CPC_FFH_CTR_CONST:
>> +		*val = ctrs->constcnt;
>> +		break;
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	*val = cpc_ffh_extract_bits(reg, *val);
>> +	return true;
>> +}
>> +
>> +int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
>> +			 struct cpc_reg *reg2, u64 *val2)
>> +{
>> +	struct amu_ffh_ctrs ctrs;
>> +	int ret;
>> +
>> +	ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!cpc_ffh_ctr_value(reg1, &ctrs, val1) ||
>> +	    !cpc_ffh_ctr_value(reg2, &ctrs, val2))
>> +		return -EOPNOTSUPP;
> Right, so there might be an issues with that:
> If you return EOPNOTSUPP here, that would trigger reading the registers again,
> this time one by one. Is that intentional ?
> Also counters_read_on_cpu might also return EOPNOTSUPP, in which case trying
> again to read the counters is pointless.
>
> I'm not entirely sure I understand the condition itself though.
> This will fail if either of the requested registers in not really expected.
> And that should probably be verified upfront ?
>
>
> ---
> BR
> Beata

Right. The following code may be more appropriate.

static bool is_valid_cpc_ffh_reg(const struct cpc_reg *reg)
{
     return reg->address == CPC_FFH_CTR_CORE ||
         reg->address == CPC_FFH_CTR_CONST;
}

int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
              struct cpc_reg *reg2, u64 *val2)
{
     struct amu_ffh_ctrs ctrs;
     int ret;

     if (!is_valid_cpc_ffh_reg(reg1) || !is_valid_cpc_ffh_reg(reg2))
         return -EINVAL;

     ret = counters_read_on_cpu(cpu, amu_read_core_const_ctrs, &ctrs);
     if (ret)
         return ret == -EOPNOTSUPP ? -ENODEV : ret;

     cpc_ffh_ctr_value(reg1, &ctrs, val1);
     cpc_ffh_ctr_value(reg2, &ctrs, val2);

     return 0;
}

thanks,

    Pengjie

>> +
>> +	return 0;
>> +}
>> +
>>   int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>>   {
>>   	int ret = -EOPNOTSUPP;
>>   
>>   	switch ((u64)reg->address) {
>> -	case 0x0:
>> +	case CPC_FFH_CTR_CORE:
>>   		ret = counters_read_on_cpu(cpu, cpu_read_corecnt, val);
>>   		break;
>> -	case 0x1:
>> +	case CPC_FFH_CTR_CONST:
>>   		ret = counters_read_on_cpu(cpu, cpu_read_constcnt, val);
>>   		break;
>>   	}
>>   
>> -	if (!ret) {
>> -		*val &= GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
>> -				    reg->bit_offset);
>> -		*val >>= reg->bit_offset;
>> -	}
>> +	if (!ret)
>> +		*val = cpc_ffh_extract_bits(reg, *val);
>>   
>>   	return ret;
>>   }
>> -- 
>> 2.33.0
>>
