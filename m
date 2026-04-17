Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90E280CF6;
	Fri, 17 Apr 2026 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391241; cv=none; b=Xd/DG1RjTM++qrwTkT4Ip8UrrtiF3/Gn9Pw6HR831ucyQXZb2UOrlIUtbUI2ntJWEJiBmPwOZORj4S53BgTdM7S8ptJQTM9Sm3vl0Vthm/u0lMW8MCkGfjFDGRvlWCewQIxcVXeZqSM9JMkpPe0vsxcwHZV/Tq4CitAGCbd5BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391241; c=relaxed/simple;
	bh=D5bc7A/7BVmWoUTx4QKkoma42prNOUCitU35BVBsDh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=py9Hgjk+vumsq3HWnHDWWwk76vsdLZcWt2R73/zUDFFoY4BbK8GumyHdKgFz7H57CVxJUBnG6YbapHeJZTDaR4skuhYWATnMHfWQnp68UiHYTDTN4IfSQaU/vxf/PfOd+zNuDDyZNo5Tc7OTxgzWMvuaTrHzeml2l+v0BlLdMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xjGS1TUl; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xjGS1TUl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vaeqWMFfmCPozBEnnnjEjgFkwQoaY5ibWVpj0g49NNc=;
	b=xjGS1TUld0DWzNvRdGtnzlecOV2i9eJh4/aorR7XHQD0xnZvUJx+93VSxMFi+SRQ2I4lQGwuh
	0cXP72DJFSb0Dr8o1sgZ6jQcu4WexPP2L1EZUkhplpJoVM2Vc8QgF9mm8WKPAEfoGwO6qAVSGdu
	i7av/vGgRfr98WErH/ufMHA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fxdGw3h9Pz1T4Gh;
	Fri, 17 Apr 2026 09:54:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 88AAC40561;
	Fri, 17 Apr 2026 10:00:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 10:00:35 +0800
Message-ID: <407dc9c3-cd83-4881-a859-d7f14cb1b498@huawei.com>
Date: Fri, 17 Apr 2026 10:00:33 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <c2669823-a057-466b-9e86-114386764f8c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 4/17/2026 3:36 AM, Sean Kelley wrote:
> On 4/16/26 1:52 AM, Jinjie Ruan wrote:
>> This reverts commit 56eb0c0ed345da7815274aa821a8546a073d7e97, because
>> this commit cause warning call trace below when concurrently bringing up
>> and down two SMT threads of a physical core.
>>
>> The issue timeline is as follows:
>>
>> 1. when the system starts,
>>     cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus:
>> 220-221
>>
>> 2. Offline cpu 220 and cpu 221.
>>
>> 3. Online cpu 220
>> - cpu 221 is now offline, as acpi_get_psd_map() use
>> for_each_online_cpu(),
>>     so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus
>> has only
>>     cpu 220.
>>     cpufreq: cpu: 220, related_cpus: 220, cpus: 220
>>
>> 4. offline cpu 220
>>
>> 5. online cpu 221, the below call trace occurs:
>> - Because cpu 220 and cpu 221 share one policy, and policy->related_cpus
>>    = 220 after step 3, so cpu 221 is not in policy->related_cpus
>>    but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
>>
>> The _PSD (P-State Dependency) defines the hardware-level dependency of
>> frequency control across CPU cores. Since this relationship is a physical
>> attribute of the hardware topology, it remains constant regardless of the
>> online or offline status of the CPUs.
>>
>> Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
>> CPU is offline, it will be excluded from the shared_cpu_map.
>> Consequently, if that CPU is brought online later, the kernel will
>> fail to
>> recognize it as part of any shared frequency domain.
>>
>> Switch back to for_each_possible_cpu() to ensure that all cores defined
>> in the ACPI tables are correctly mapped into their respective performance
>> domains from the start. This aligns with the logic of policy-
>> >related_cpus,
>> which must encompass all potentially available cores in the domain to
>> prevent logic gaps during CPU hotplug operations.
> 
> 
> Yep, agree that using for_each_online_cpu() in acpi_get_psd_map()
> drops valid domain members and breaks the hotplug case you described.
> 
> But a plain revert also re-exposes the nosmt bug. On systems where a
> possible CPU is never probed, per_cpu(cpc_desc_ptr, i) is NULL and
> acpi_get_psd_map() currently hits goto err_fault instead of just
> skipping that CPU.

I have a question regarding the original issue where it states 'This
breaks systems booted with "nosmt" or "nosmt=force"'. As far as I know,
the 'nosmt' parameter is only supported on x86. However, it seems the
current x86 kernel does not support enabling CONFIG_ACPI_CPPC_CPUFREQ
(only supported on arm64/arm/riscv). Could you please share the details
of your testing environment?

> 
> So I think the fix is to restore for_each_possible_cpu() for the PSD
> map, but change the NULL case to continue:

I agree.

> 
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -530,7 +530,7 @@
> 
>                 match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
>                 if (!match_cpc_ptr)
> -                       goto err_fault;
> +                       continue;
> 
>                 match_pdomain = &(match_cpc_ptr->domain_info);
> 
> That way offline CPUs with valid descriptors remain in shared_cpu_map
> (fixing the hotplug trace), while never-probed CPUs are skipped
> instead of failing map construction.
> 
> The send_pcc_cmd() hunk already does if (!desc) continue, so reverting
> that loop back to for_each_possible_cpu() looks fine as-is.
> 
> Happy to send the continue fix as a patch on top, or please feel free
> to fold it into yours if that makes sense.

Thanks! I will fold your fix into my patch and add your Co-developed-by
tag in the next version.

> 
> Sean
> 
>>
>> How to reproduce, on arm64 machine with SMT support which use acpi cppc
>> cpufreq driver:
>>
>>     bash test.sh 220 & bash test.sh 221 &
>>
>>     The test.sh is as below:
>>         while true
>>             do
>>             echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>             sleep 0.5
>>             cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>             echo 1 >  /sys/devices/system/cpu/cpu${1}/online
>>             cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>         done
>>
>>     CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted
>> 6.6.0debug+ #5
>>     Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z,
>> BIOS 20.39 09/04/2024
>>     pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>     pc : cpufreq_online+0x8ac/0xa90
>>     lr : cpuhp_cpufreq_online+0x18/0x30
>>     sp : ffff80008739bce0
>>     x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
>>     x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
>>     x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
>>     x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
>>     x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
>>     x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
>>     x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
>>     x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
>>     x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
>>     x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
>>     Call trace:
>>      cpufreq_online+0x8ac/0xa90
>>      cpuhp_cpufreq_online+0x18/0x30
>>      cpuhp_invoke_callback+0x128/0x580
>>      cpuhp_thread_fun+0x110/0x1b0
>>      smpboot_thread_fn+0x140/0x190
>>      kthread+0xec/0x100
>>      ret_from_fork+0x10/0x20
>>     ---[ end trace 0000000000000000 ]---
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
>> for_each_possible_cpu() to use online CPUs")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index f0e513e9ed5d..9ae29f2c6db8 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>   end:
>>       if (cmd == CMD_WRITE) {
>>           if (unlikely(ret)) {
>> -            for_each_online_cpu(i) {
>> +            for_each_possible_cpu(i) {
>>                   struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>>                     if (!desc)
>> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct
>> cppc_cpudata *cpu_data)
>>       else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>>           cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>>   -    for_each_online_cpu(i) {
>> +    for_each_possible_cpu(i) {
>>           if (i == cpu)
>>               continue;
>>   
> 
> 

