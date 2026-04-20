Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D5383C64;
	Mon, 20 Apr 2026 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667148; cv=none; b=sR4TPJwDTn9Cbth/S289+8OUjZqKowOS6/NHzsxJWyv+2hEjNjTARlycBDqah92huuqYbV+5GlTV8oUtJSYX8LzUhGSZNpBuv6hPPL91BNOThHa35acrL/OIVlYfs2QsUs/hCilHVXKQeYdYjsJjDxVBaBibqc4OlovIGE7rOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667148; c=relaxed/simple;
	bh=OhoTxxbzrYK8IWiHGeJeR9X1HsF47EYImLqWV13FIFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hyfWBuyfrA0YAlvy/cK7XMBPXAlPIJ1soqviPJE07HldubwzrslxaYGE7TN5kbnxehB53gEIcDBmJMWpu/NeXriEIXfRnIh9R4W2lKOuzUDpwS85DzKgbXEMThocnvL2FhFTzUFQ6Z6rgEqgHwKA/Od40E6nFthDf4MVsnYaCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=JIjSEVb+; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="JIjSEVb+"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Mrw7URIBnOfrToS+iqPJJEUHnwfTM67mGoZmCht0I3A=;
	b=JIjSEVb+06We5sYzebMrx/frEYR3n/MmtjPDW4d4GCFk2iVmVAf8YCCntT7LQtg6eIfSQ1pdw
	cqm87EsoOcGRGp8Zgq0+tcEeY/h+nvNxQ2rvNtgV/cMhJCu2S5M7vT2g30DOt3k29JOq4h4MUJc
	9eHAvYn/VD51MYBlI01Yyhw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fzbJT23H4z12LCb;
	Mon, 20 Apr 2026 14:32:41 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 703AA40571;
	Mon, 20 Apr 2026 14:38:56 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 14:38:56 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 20 Apr
 2026 14:38:55 +0800
Message-ID: <bdaaa661-f5cb-406d-8792-454b057ae9c9@huawei.com>
Date: Mon, 20 Apr 2026 14:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ACPI: processor: idle: Do not propagate
 acpi_processor_ffh_lpi_probe() -ENODEV
To: "Rafael J. Wysocki" <rafael@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Sudeep Holla <sudeep.holla@kernel.org>, Len Brown <lenb@kernel.org>,
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
 <33c15199-25ea-4d39-bff9-91af0b49633e@huawei.com>
 <CAJZ5v0hftnagiLTPCEjqviyug5g5NQCztX1o0w5NOY8d=5cz+g@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hftnagiLTPCEjqviyug5g5NQCztX1o0w5NOY8d=5cz+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/15/2026 10:03 PM, Rafael J. Wysocki wrote:
> On Wed, Apr 15, 2026 at 3:32 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> On 4/14/2026 8:25 PM, Sudeep Holla wrote:
>>> On Tue, Apr 14, 2026 at 07:31:29PM +0800, lihuisong (C) wrote:
>>>> On 4/14/2026 6:21 PM, Breno Leitao wrote:
>>>>> Hello Huisong,
>>>>>
>>>>> On Tue, Apr 14, 2026 at 05:43:51PM +0800, lihuisong (C) wrote:
>>>>>> But it is a real issue. Thanks for your report.
>>>>>> I think the best way to fix your issue is that remove this verification in
>>>>>> psci_acpi_cpu_init_idle().
>>>>>> Because it is legal for platform to report one LPI state.
>>>>>> This function just needs to verify the LPI states which are FFH.
>>>>> Thank you for the prompt feedback.
>>>>>
>>>>> Would this approach work?
>>>>>
>>>>> commit 6c9d52840a4f778cc989838ba76ee51416e85de3
>>>>> Author: Breno Leitao <leitao@debian.org>
>>>>> Date:   Tue Apr 14 03:16:08 2026 -0700
>>>>>
>>>>>        ACPI: processor: idle: Allow platforms with only one LPI state
>>>>>        psci_acpi_cpu_init_idle() rejects platforms where power.count - 1 <= 0
>>>>>        by returning -ENODEV. However, having a single LPI state (WFI) is a
>>>>>        valid configuration. The function's purpose is to verify FFH idle states,
>>>>>        and when count is zero, there are simply no FFH states to validate —
>>>>>        this is not an error.
>>>>>        On NVIDIA Grace (aarch64) systems with PSCIv1.1, power.count is 1 for
>>>>>        all 72 CPUs, so the probe fails with -ENODEV. After commit cac173bea57d
>>>>>        ("ACPI: processor: idle: Rework the handling of
>>>>>        acpi_processor_ffh_lpi_probe()"), this failure propagates up and prevents
>>>>>        cpuidle registration entirely.
>>>>>        Change the check from (count <= 0) to (count < 0) so that platforms
>>>>>        with only WFI are accepted. The for loop naturally handles count == 0
>>>>>        by not iterating.
>>>>>        Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
>>>>>        Signed-off-by: Breno Leitao <leitao@debian.org>
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
>>>>> index 801f9c4501425..7791b751042ce 100644
>>>>> --- a/drivers/acpi/arm64/cpuidle.c
>>>>> +++ b/drivers/acpi/arm64/cpuidle.c
>>>>> @@ -31,7 +31,7 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>>>>              return -EOPNOTSUPP;
>>>>>      count = pr->power.count - 1;
>>>>> -   if (count <= 0)
>>>>> +   if (count < 0)
>>>>>              return -ENODEV;
>>>>>      for (i = 0; i < count; i++) {
>>>> This count already verified in acpi_processor_get_lpi_info.
>>>>
>>>> I suggest modifing it as below:
>>>>
>>>> -->
>>>>
>>>> git diff
>>>> diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
>>>> index 801f9c450142..c68a5db8ebba 100644
>>>> --- a/drivers/acpi/arm64/cpuidle.c
>>>> +++ b/drivers/acpi/arm64/cpuidle.c
>>>> @@ -16,7 +16,7 @@
>>>>
>>>>    static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>>>    {
>>>> -       int i, count;
>>>> +       int i;
>>>>           struct acpi_lpi_state *lpi;
>>>>           struct acpi_processor *pr = per_cpu(processors, cpu);
>>>>
>>>> @@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
>>>>           if (!psci_ops.cpu_suspend)
>>>>                   return -EOPNOTSUPP;
>>>>
>>>> -       count = pr->power.count - 1;
>>>> -       if (count <= 0)
>>>> -               return -ENODEV;
>>>> -
>>> It was intentionally designed this way, as there is little value in defining
>>> only WFI in the _LPI tables. In the absence of a cpuidle driver/LPI entry,
>>> arch_cpu_idle() is invoked, which is sufficient and avoids unnecessary
>>> complexity, only to ultimately execute wfi() anyway.
>> Yeah, it's correct. The code flow will be more simple and high-efficiency.
>> This looks good to me.
>>
>>
>> But cpuidle sysfs under per CPU is created when firmware just reports
>> WFI state before
>> my commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
>> acpi_processor_ffh_lpi_probe()").
>> However, these platforms will no longer be created now and some
>> statistics for state0 are also missing.
>> This change in behavor is visiable to user space.I'm not sure if it is
>> acceptable.
>> What do you think, Rafael?
> I think that it would be good to restore the previous behavior,
> especially if it has been changed inadvertently.
Agreed.

Can you send it again using my proposal, @breno?
We can send out other patch to discuss it if need to optimize the point 
Sudeep mentioned.
>
