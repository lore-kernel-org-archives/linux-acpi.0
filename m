Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C637700A;
	Wed,  1 Jul 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907278; cv=none; b=QW9U804Yg7pVqr1Bu87CT8xsrl6QLOYFGJyN5OXUPJkv27c4OgaABP7lbYH4ATlBC3pC/7MekE5P/038l5I77vDgEzvpHSQ04XyZgN65fCfRJ/eQMy3Xpu0Ada7/jqu/KdzmML+VSGSEi+uiag1/ex0mABfDM5QoFmpMFY2S9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907278; c=relaxed/simple;
	bh=LP6iUDy0sw25FSsv98e/88cuc8oAihAVd3Q7Uj5xtA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pKLV54YdAvqM1Bz9roX8jkd7UBkj+AIrV60chwrm699/TOD4PystIiY5lKQWtkWQi8MkKTFDbkFB7efEwUIEQCKub2ReV6mGXs24PbB2Dbg3qfqxROHoRNMB8bdhZrMzvnxs2HNmUQBWRGYhaQz7WFCXcY43C86VTGkwIWxbY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3ahc3ltq; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3ahc3ltq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wb7A/TS/HEDvAZgwyCH1DqONn9Dswjv2acmk5jyqSNo=;
	b=3ahc3ltqmkkXN9QOuiqpU41Hl9c7g10bPEsmpLbdkxKl22rY8Ydsv3Y7DuF/IsXfToBelOvol
	G9z6KYaKaF1ZDJEg+drbNGABLUE41nf239pKGy6A898SbEduRuZUdGZMmCMTzDG3r1JMeIkSjv1
	swsO0K9vl0hnPnhv2DueDpQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gqyzb4XVxz1K96Z;
	Wed,  1 Jul 2026 19:51:55 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 28B134055B;
	Wed,  1 Jul 2026 20:01:04 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Jul
 2026 20:01:03 +0800
Message-ID: <d3e43723-82da-415f-ab79-5be49e92969e@huawei.com>
Date: Wed, 1 Jul 2026 20:01:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
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
 <20260410094145.4132082-2-zhangpengjie2@huawei.com>
 <akNyNKSGf5yKwtwN@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <akNyNKSGf5yKwtwN@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)

Hi Beata,

Thanks for taking the time to review this patch.
Please see my inline comments below.

On 6/30/2026 3:37 PM, Beata Michalska wrote:
> Gonna be a bit picky with wording so do bear with me ...
>
> On Fri, Apr 10, 2026 at 05:41:44PM +0800, Pengjie Zhang wrote:
>> cppc_get_perf_ctrs() reads the delivered and reference performance
>> counters one at a time.
>>
>> Allow architectures to provide both FFH feedback counters in one
>> operation when that either narrows the sampling window or avoids extra
>> cross-CPU reads. Add a small FFH-specific hook for that case and fall
>> back to the existing per-register reads when unsupported.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 58 ++++++++++++++++++++++++++++++++++++----
>>   include/acpi/cppc_acpi.h |  7 +++++
>>   2 files changed, 60 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 2e91c5a97761..7b3e8b0597dc 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -988,6 +988,23 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
>>   	return -ENOTSUPP;
>>   }
>>   
>> +/**
>> + * cpc_read_ffh_fb_ctrs() - Read FFH feedback counters together
>> + * @cpunum:	CPU number to read
> This reads bit awkward. Target CPU maybe ?
>> + * @reg1:	first CPPC register information
>> + * @val1:	place holder for first return value
>> + * @reg2:	second CPPC register information
>> + * @val2:	place holder for second return value
>> + *
>> + * Return: 0 for success and error code
> 0 on success, error code otherwise ?

Will update the wording as suggested.

>> + */
>> +int __weak cpc_read_ffh_fb_ctrs(int cpunum, struct cpc_reg *reg1,
>> +				u64 *val1, struct cpc_reg *reg2, u64 *val2)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +
>>   /**
>>    * cpc_write_ffh() - Write FFH register
>>    * @cpunum:	CPU number to write
>> @@ -1504,6 +1521,40 @@ bool cppc_perf_ctrs_in_pcc(void)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>>   
>> +static int cppc_read_perf_fb_ctrs(int cpunum,
>> +				  struct cpc_register_resource *delivered_reg,
>> +				  struct cpc_register_resource *reference_reg,
>> +				  u64 *delivered, u64 *reference)
> The signature here differs from cpc_read_ffh_fb_ctrs.
> It's not an issue but it might be good idea to stay consistent maybe ?
> Also ... was about to suggest to stick to either perf_ctrs or feedback_ctrs
> in naming but it seems the is no clear pattern  withint the file
> ...
You're right about the mixed naming.
I will use the _fb_ctrs suffix for all new functions in v2.
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * For FFH feedback counters, try a paired read first to reduce
>> +	 * sampling skew between delivered and reference counters. Fall
>> +	 * back to the existing per-register reads if unsupported.
>> +	 */
>> +	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
>> +		ret = cpc_read_ffh_fb_ctrs(cpunum,
>> +					&delivered_reg->cpc_entry.reg, delivered,
>> +					&reference_reg->cpc_entry.reg, reference);
>> +		if (!ret)
>> +			return 0;
>> +
>> +		if (ret != -EOPNOTSUPP)
>> +			return ret;
> Shouldn't this one be enough ? Don't think you need the first condition.
right，I will drop the redundant if (!ret) check in v2
>> +	}
>> +
>> +	ret = cpc_read(cpunum, delivered_reg, delivered);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = cpc_read(cpunum, reference_reg, reference);
>> +	if (ret)
>> +		return ret;
> As you are not doing anything with 'ret' this could just be:
> 	ret = cpc_read(cpunum, delivered_reg, delivered);
> 	if (ret) return ret;
> 	return cpc_read(cpunum, reference_reg, reference);
>
> Though that's minor.
Good catch, this is much cleaner. I will apply this change.
Thanks again for the constructive feedback!

Best regards,
  Pengjie
>
> ---
> BR
> Beata
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>>    * @cpunum: CPU from which to read counters.
>> @@ -1547,11 +1598,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>   		}
>>   	}
>>   
>> -	ret = cpc_read(cpunum, delivered_reg, &delivered);
>> -	if (ret)
>> -		goto out_err;
>> -
>> -	ret = cpc_read(cpunum, reference_reg, &reference);
>> +	ret = cppc_read_perf_fb_ctrs(cpunum, delivered_reg, reference_reg,
>> +				     &delivered, &reference);
>>   	if (ret)
>>   		goto out_err;
>>   
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index d1f02ceec4f9..006b42dbbd4b 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -172,6 +172,8 @@ extern int cppc_get_transition_latency(int cpu);
>>   extern bool cpc_ffh_supported(void);
>>   extern bool cpc_supported_by_cpu(void);
>>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>> +extern int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
>> +				struct cpc_reg *reg2, u64 *val2);
>>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>> @@ -246,6 +248,11 @@ static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> +static inline int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1,
>> +				       struct cpc_reg *reg2, u64 *val2)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>>   {
>>   	return -EOPNOTSUPP;
>> -- 
>> 2.33.0
>>
