Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0C3793C8;
	Fri, 17 Apr 2026 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411858; cv=none; b=tk0CO89WpFv5/pc0YTjgXvqGMB0TaMu6+AkET958lzRfOuz2TsDrGtKX/StWSlX2JvdhApdAxJ5vYWmplUcjXzQR40gHHD1t6yl4Uo7G/+iijJdyJXSvifyUW51+DJwFOWkSzGZS3TPFKbuzxmGvcPlXOw85xUjp+ELRNYe9KIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411858; c=relaxed/simple;
	bh=raWhD/wjd80EE5e6/EoZ2LLlxsbdxyBOkj2wMgr/Lyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e6TgYSugEaU7GUHHjc5HXlTJT5+6ZmoHhMzc2jvABU1R3JK3YYsWFj0mF7GBofrVPe5pgEIP2W4oSJJJCgmgwSuwvtkC8yoD/hKuNWevDKZXGQ7bbo86d7bMewCRhfxIUb7QyvcFT6TN2RPAhgASxCK74Zaj2MmJ3wMhK+A1Vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FNV90r65; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FNV90r65"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P0F8BDlWYTDl3AY8wrYv0T7O6GdBOsFWTc2QaofLY48=;
	b=FNV90r65FrBgxsEDFQCc/owbeFL4NlihK0i4I1WivDrhN5nfJUb7CFQGDBxg1fZaeu/iNOEdG
	A/r3Pq9Am39XRVXbaCCGmGEj3N5/xpNh9nURiujTCBy1+x+eR0S8VPjHatIwUdn0vemfTtfDep7
	7Wj6k529GEyuZ7bGP2b6Yes=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fxmty00vbzKm6S;
	Fri, 17 Apr 2026 15:37:45 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 627DC40604;
	Fri, 17 Apr 2026 15:44:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 15:44:06 +0800
Message-ID: <7b36beef-b369-455e-a6af-bf5e9ba2c2b0@huawei.com>
Date: Fri, 17 Apr 2026 15:44:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ACPI: CPPC: Fix remaining for_each_possible_cpu()
 to use online CPUs"
To: Sean Kelley <skelley@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260416085221.3476726-1-ruanjinjie@huawei.com>
 <c2669823-a057-466b-9e86-114386764f8c@nvidia.com>
 <407dc9c3-cd83-4881-a859-d7f14cb1b498@huawei.com>
 <f925dbeb-27be-48e5-90e0-2a22a12e740a@nvidia.com>
 <0523407c-de2c-4463-bde2-8753e01971d5@huawei.com>
 <f2e926b4-b82d-4036-8098-484d3d72f3d1@nvidia.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <f2e926b4-b82d-4036-8098-484d3d72f3d1@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 4/17/2026 3:22 PM, Sean Kelley wrote:
> On 4/16/26 8:46 PM, Jinjie Ruan wrote:
>>
>>
>> On 4/17/2026 11:00 AM, Sean Kelley wrote:
>>> On 4/16/26 7:00 PM, Jinjie Ruan wrote:
>>>>
>>>>
>>>> On 4/17/2026 3:36 AM, Sean Kelley wrote:
>>>>> On 4/16/26 1:52 AM, Jinjie Ruan wrote:
>>>>>> This reverts commit 56eb0c0ed345da7815274aa821a8546a073d7e97, because
>>>>>> this commit cause warning call trace below when concurrently
>>>>>> bringing up
>>>>>> and down two SMT threads of a physical core.
>>>>>>
>>>>>> The issue timeline is as follows:
>>>>>>
>>>>>> 1. when the system starts,
>>>>>>       cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus:
>>>>>> 220-221
>>>>>>
>>>>>> 2. Offline cpu 220 and cpu 221.
>>>>>>
>>>>>> 3. Online cpu 220
>>>>>> - cpu 221 is now offline, as acpi_get_psd_map() use
>>>>>> for_each_online_cpu(),
>>>>>>       so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus
>>>>>> has only
>>>>>>       cpu 220.
>>>>>>       cpufreq: cpu: 220, related_cpus: 220, cpus: 220
>>>>>>
>>>>>> 4. offline cpu 220
>>>>>>
>>>>>> 5. online cpu 221, the below call trace occurs:
>>>>>> - Because cpu 220 and cpu 221 share one policy, and policy-
>>>>>>> related_cpus
>>>>>>      = 220 after step 3, so cpu 221 is not in policy->related_cpus
>>>>>>      but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
>>>>>>
>>>>>> The _PSD (P-State Dependency) defines the hardware-level
>>>>>> dependency of
>>>>>> frequency control across CPU cores. Since this relationship is a
>>>>>> physical
>>>>>> attribute of the hardware topology, it remains constant regardless
>>>>>> of the
>>>>>> online or offline status of the CPUs.
>>>>>>
>>>>>> Using for_each_online_cpu() in acpi_get_psd_map() is problematic.
>>>>>> If a
>>>>>> CPU is offline, it will be excluded from the shared_cpu_map.
>>>>>> Consequently, if that CPU is brought online later, the kernel will
>>>>>> fail to
>>>>>> recognize it as part of any shared frequency domain.
>>>>>>
>>>>>> Switch back to for_each_possible_cpu() to ensure that all cores
>>>>>> defined
>>>>>> in the ACPI tables are correctly mapped into their respective
>>>>>> performance
>>>>>> domains from the start. This aligns with the logic of policy-
>>>>>>> related_cpus,
>>>>>> which must encompass all potentially available cores in the domain to
>>>>>> prevent logic gaps during CPU hotplug operations.
>>>>>
>>>>>
>>>>> Yep, agree that using for_each_online_cpu() in acpi_get_psd_map()
>>>>> drops valid domain members and breaks the hotplug case you described.
>>>>>
>>>>> But a plain revert also re-exposes the nosmt bug. On systems where a
>>>>> possible CPU is never probed, per_cpu(cpc_desc_ptr, i) is NULL and
>>>>> acpi_get_psd_map() currently hits goto err_fault instead of just
>>>>> skipping that CPU.
>>>>
>>>> I have a question regarding the original issue where it states 'This
>>>> breaks systems booted with "nosmt" or "nosmt=force"'. As far as I know,
>>>> the 'nosmt' parameter is only supported on x86. However, it seems the
>>>> current x86 kernel does not support enabling CONFIG_ACPI_CPPC_CPUFREQ
>>>> (only supported on arm64/arm/riscv). Could you please share the details
>>>> of your testing environment?
>>>
>>> Yeah, good question. However, nosmt is actually defined generically in
>>> kernel/cpu.c
>>> (early_param("nosmt", smt_cmdline_disable)), not in any
>>> arch-specific code, so it works on anything that selects HOTPLUG_SMT.
>>>
>>> arm64 does:
>>>    arch/arm64/Kconfig    select HOTPLUG_SMT if HOTPLUG_CPU
>>>
>>> And acpi_get_psd_map() is called from drivers/cpufreq/cppc_cpufreq.c,
>>> which has: depends on ARM || ARM64 || RISCV.
>>>
>>> So the overlap where this bug actually triggers is arm64. Testing was
>>> on an NVIDIA Vera (Olympus) platform booted with "nosmt". That's the
>>> environment where the original -EFAULT failure in acpi_get_psd_map()
>>> was reproduced.
>>
>> After reverting commit 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
>> for_each_possible_cpu() to use online CPUs"), I tried to reproduce your
>> original issue on my local ARM64 machine with the 'nosmt' boot parameter
>> enabled and I have confirmed that it works., but I couldn't trigger it
>> and the acpi cppc cpufreq driver successfully registered. Could you
>> please help test if the new fix resolves the problem you encountered
>> previously?
>>
>> Best regards,
>> Jinjie
>>
> 
> 
> Hi Jinjie,
> 
> Applied v2 on current master and built for arm64 (NVIDIA Vera, has SMT).
> 
> Tested both scenarios:
> 
> 1. nosmt boot -- cppc_cpufreq registers cleanly, no -EFAULT, no
>    warnings in dmesg.
> 
> 2. Concurrent hotplug of SMT siblings (your original reproducer
>    adapted to valid CPU indices on my system). Ran the dual
>    offline/online loop for 30s. No WARN, no cpufreq_online call
>    trace.
> 
> Both pass.

Many thanks for the testing. It's good to hear that the results are
positive.

> 
> Thanks!
> 
> Sean
> 
> 
> 
> 
>>>
>>>>
>>>>>
>>>>> So I think the fix is to restore for_each_possible_cpu() for the PSD
>>>>> map, but change the NULL case to continue:
>>>>
>>>> I agree.
>>>>
>>>>>
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -530,7 +530,7 @@
>>>>>
>>>>>                   match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
>>>>>                   if (!match_cpc_ptr)
>>>>> -                       goto err_fault;
>>>>> +                       continue;
>>>>>
>>>>>                   match_pdomain = &(match_cpc_ptr->domain_info);
>>>>>
>>>>> That way offline CPUs with valid descriptors remain in shared_cpu_map
>>>>> (fixing the hotplug trace), while never-probed CPUs are skipped
>>>>> instead of failing map construction.
>>>>>
>>>>> The send_pcc_cmd() hunk already does if (!desc) continue, so reverting
>>>>> that loop back to for_each_possible_cpu() looks fine as-is.
>>>>>
>>>>> Happy to send the continue fix as a patch on top, or please feel free
>>>>> to fold it into yours if that makes sense.
>>>>
>>>> Thanks! I will fold your fix into my patch and add your Co-developed-by
>>>> tag in the next version.
>>>>
>>>
>>> Sounds good, thanks.
>>>
>>> Sean
>>>
>>>>>
>>>>> Sean
>>>>>
>>>>>>
>>>>>> How to reproduce, on arm64 machine with SMT support which use acpi
>>>>>> cppc
>>>>>> cpufreq driver:
>>>>>>
>>>>>>       bash test.sh 220 & bash test.sh 221 &
>>>>>>
>>>>>>       The test.sh is as below:
>>>>>>           while true
>>>>>>               do
>>>>>>               echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>>>>>               sleep 0.5
>>>>>>               cat /sys/devices/system/cpu/cpu${1}/cpufreq/
>>>>>> related_cpus
>>>>>>               echo 1 >  /sys/devices/system/cpu/cpu${1}/online
>>>>>>               cat /sys/devices/system/cpu/cpu${1}/cpufreq/
>>>>>> related_cpus
>>>>>>           done
>>>>>>
>>>>>>       CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted
>>>>>> 6.6.0debug+ #5
>>>>>>       Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z,
>>>>>> BIOS 20.39 09/04/2024
>>>>>>       pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>>>>>       pc : cpufreq_online+0x8ac/0xa90
>>>>>>       lr : cpuhp_cpufreq_online+0x18/0x30
>>>>>>       sp : ffff80008739bce0
>>>>>>       x29: ffff80008739bce0 x28: 0000000000000000 x27:
>>>>>> ffff28400ca32200
>>>>>>       x26: 0000000000000000 x25: 0000000000000003 x24:
>>>>>> ffffd483503ff000
>>>>>>       x23: ffffd483504051a0 x22: ffffd48350024a00 x21:
>>>>>> 00000000000000dd
>>>>>>       x20: 000000000000001d x19: ffff28400ca32000 x18:
>>>>>> 0000000000000000
>>>>>>       x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15:
>>>>>> 0000000000000020
>>>>>>       x14: 0000000000000008 x13: 0000000000000001 x12:
>>>>>> 00000000ffffffff
>>>>>>       x11: 0000000000000040 x10: ffffd48350430728 x9 :
>>>>>> ffffd4834f087c78
>>>>>>       x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 :
>>>>>> ffffd483504264f0
>>>>>>       x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 :
>>>>>> 0000000000000000
>>>>>>       x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 :
>>>>>> 0000000000000000
>>>>>>       Call trace:
>>>>>>        cpufreq_online+0x8ac/0xa90
>>>>>>        cpuhp_cpufreq_online+0x18/0x30
>>>>>>        cpuhp_invoke_callback+0x128/0x580
>>>>>>        cpuhp_thread_fun+0x110/0x1b0
>>>>>>        smpboot_thread_fn+0x140/0x190
>>>>>>        kthread+0xec/0x100
>>>>>>        ret_from_fork+0x10/0x20
>>>>>>       ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
>>>>>> for_each_possible_cpu() to use online CPUs")
>>>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>>>> ---
>>>>>>     drivers/acpi/cppc_acpi.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>> index f0e513e9ed5d..9ae29f2c6db8 100644
>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>>>>>     end:
>>>>>>         if (cmd == CMD_WRITE) {
>>>>>>             if (unlikely(ret)) {
>>>>>> -            for_each_online_cpu(i) {
>>>>>> +            for_each_possible_cpu(i) {
>>>>>>                     struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>>>>>>                       if (!desc)
>>>>>> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct
>>>>>> cppc_cpudata *cpu_data)
>>>>>>         else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>>>>>>             cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>>>>>>     -    for_each_online_cpu(i) {
>>>>>> +    for_each_possible_cpu(i) {
>>>>>>             if (i == cpu)
>>>>>>                 continue;
>>>>>>     
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 

