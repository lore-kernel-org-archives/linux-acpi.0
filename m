Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20642A80;
	Wed, 15 Apr 2026 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776216778; cv=none; b=SQFMbenVlyrGuHvyN/uoIwTGpFJoKP7v1rpj1kHGO/9a9wUJvgJTboHQt7I2Nuhhpy/3bZ/RxPADpNHuzA6Rypm2ovL84t85fLs/Lo788QwqEJkf6LjKqrps1PalQGy8OhXy/lWPQvcq44sQQ5Mbkp49npA2az7yF+FT1riTtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776216778; c=relaxed/simple;
	bh=5rcl9FD1fZM5h/bD7b1NahAi6PX8APIZNxveMQ4IwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nye5IJXjQUA0mSe+F3OjMsGa7wTREONMzIobfKBEyH+yDthKUHOPDKflMQVtdrQ5OvSDtkgPQbfXO2P7hgqN08xLgT4OXW1meDlzM5NLfjkERYsyVTEdkz7v9EiILsbULxLh5B82tN/Ss6sXgkIKvxSNu+R61gTGS6SLdLE1nAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gaA/rGn4; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gaA/rGn4"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O2kZvsNPH9LHVBECqKSB4VWfMUhvRVjvwKNwWXu2iiI=;
	b=gaA/rGn4O25rIzd73vQzt3VvnO0dQzUwEpEQMCnjyvQBByRZGGIUrgTFPHej+rEKlHVeMAc1b
	olOQfRTI3eK8HKsejGlMsRt5s65hiS5g3oio9HyzQedZn4oTzhhjxUC3MEFzmS0XXa1DrUhSZX/
	HOexY74PX6sSyqpdOsEeiV8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fwNlG2XlQzcb3c;
	Wed, 15 Apr 2026 09:26:18 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id D3CD340576;
	Wed, 15 Apr 2026 09:32:47 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 09:32:47 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 15 Apr
 2026 09:32:47 +0800
Message-ID: <33c15199-25ea-4d39-bff9-91af0b49633e@huawei.com>
Date: Wed, 15 Apr 2026 09:32:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
To: Sudeep Holla <sudeep.holla@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Breno Leitao <leitao@debian.org>, Len Brown <lenb@kernel.org>,
	<lpieralisi@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<pjaroszynski@nvidia.com>, <guohanjun@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <rmikey@meta.com>,
	<kernel-team@meta.com>, <lihuisong@huawei.com>
References: <20260413-ffh-v1-1-301704f69e2f@debian.org>
 <af9c679d-899c-4832-b902-e621b5987f12@huawei.com>
 <ad4UWJ__dnDQtrj8@gmail.com>
 <6694ca7c-13bf-4e7d-9621-bc992cbf96a7@huawei.com>
 <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260414-cute-shapeless-dolphin-c5b2fc@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/14/2026 8:25 PM, Sudeep Holla wrote:
> On Tue, Apr 14, 2026 at 07:31:29PM +0800, lihuisong (C) wrote:
>> On 4/14/2026 6:21 PM, Breno Leitao wrote:
>>> Hello Huisong,
>>>
>>> On Tue, Apr 14, 2026 at 05:43:51PM +0800, lihuisong (C) wrote:
>>>> But it is a real issue. Thanks for your report.
>>>> I think the best way to fix your issue is that remove this verification in
>>>> psci_acpi_cpu_init_idle().
>>>> Because it is legal for platform to report one LPI state.
>>>> This function just needs to verify the LPI states which are FFH.
>>> Thank you for the prompt feedback.
>>>
>>> Would this approach work?
>>>
>>> commit 6c9d52840a4f778cc989838ba76ee51416e85de3
>>> Author: Breno Leitao <leitao@debian.org>
>>> Date:   Tue Apr 14 03:16:08 2026 -0700
>>>
>>>       ACPI: processor: idle: Allow platforms with only one LPI state
>>>       psci_acpi_cpu_init_idle() rejects platforms where power.count - 1 <= 0
>>>       by returning -ENODEV. However, having a single LPI state (WFI) is a
>>>       valid configuration. The function's purpose is to verify FFH idle states,
>>>       and when count is zero, there are simply no FFH states to validate —
>>>       this is not an error.
>>>       On NVIDIA Grace (aarch64) systems with PSCIv1.1, power.count is 1 for
>>>       all 72 CPUs, so the probe fails with -ENODEV. After commit cac173bea57d
>>>       ("ACPI: processor: idle: Rework the handling of
>>>       acpi_processor_ffh_lpi_probe()"), this failure propagates up and prevents
>>>       cpuidle registration entirely.
>>>       Change the check from (count <= 0) to (count < 0) so that platforms
>>>       with only WFI are accepted. The for loop naturally handles count == 0
>>>       by not iterating.
>>>       Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
>>>       Signed-off-by: Breno Leitao <leitao@debian.org>
>>>
>>> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
>>> index 801f9c4501425..7791b751042ce 100644
>>> --- a/drivers/acpi/arm64/cpuidle.c
>>> +++ b/drivers/acpi/arm64/cpuidle.c
>>> @@ -31,7 +31,7 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>>    		return -EOPNOTSUPP;
>>>    	count = pr->power.count - 1;
>>> -	if (count <= 0)
>>> +	if (count < 0)
>>>    		return -ENODEV;
>>>    	for (i = 0; i < count; i++) {
>> This count already verified in acpi_processor_get_lpi_info.
>>
>> I suggest modifing it as below:
>>
>> -->
>>
>> git diff
>> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
>> index 801f9c450142..c68a5db8ebba 100644
>> --- a/drivers/acpi/arm64/cpuidle.c
>> +++ b/drivers/acpi/arm64/cpuidle.c
>> @@ -16,7 +16,7 @@
>>
>>   static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>   {
>> -       int i, count;
>> +       int i;
>>          struct acpi_lpi_state *lpi;
>>          struct acpi_processor *pr = per_cpu(processors, cpu);
>>
>> @@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>          if (!psci_ops.cpu_suspend)
>>                  return -EOPNOTSUPP;
>>
>> -       count = pr->power.count - 1;
>> -       if (count <= 0)
>> -               return -ENODEV;
>> -
> It was intentionally designed this way, as there is little value in defining
> only WFI in the _LPI tables. In the absence of a cpuidle driver/LPI entry,
> arch_cpu_idle() is invoked, which is sufficient and avoids unnecessary
> complexity, only to ultimately execute wfi() anyway.
Yeah, it's correct. The code flow will be more simple and high-efficiency.
This looks good to me.


But cpuidle sysfs under per CPU is created when firmware just reports 
WFI state before
my commit cac173bea57d ("ACPI: processor: idle: Rework the handling of 
acpi_processor_ffh_lpi_probe()").
However, these platforms will no longer be created now and some 
statistics for state0 are also missing.
This change in behavor is visiable to user space.I'm not sure if it is 
acceptable.
What do you think, Rafael?
> So while I understand that the kernel did not report an error previously, that
> does not mean the _LPI table is merely moot on this platform when it contains
> only a WFI state.
>
>
