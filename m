Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34A26E165;
	Mon, 27 Apr 2026 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256974; cv=none; b=N074YHg6Ue/yJZyP0mGGuYSRdXikJB8pKytSvyc0lNn7DV512rreDZCJRMovPwqno4j1ZgqSOJh2AzxCq/DPy2LEtxWcQT4Jz72o3BPwN/nS09sa78cbYXKVmfGCWxd5hxQ9J/DobkyfqLXQV5yMnPqdS0nf72LjMWesB93z/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256974; c=relaxed/simple;
	bh=pEjV00guXRk7R85kasRyk2kbMdmiWyoCCULC4fs20/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OVqP8yiSiTI2fsuqeQzMT5bVAS1Mht85SBVXcoS0xx26z+Lg5cwHdq5oVA+z18+yoPqz4KoHp1/NLiuLxtFxA/drg/l5mdhyn8LgQQ2erLNAKILBLBSENgKwdJsd85izvvTQMy205Cp8Iz9kAhAJ6cVlXTnAsLuGhETbjY7c014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YqWWTk1Z; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YqWWTk1Z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2nPvN/WnUcI9toeSqSMQiTieSQGwCWoNkcyQ9PMuhvY=;
	b=YqWWTk1Zs80Cseo0yR4WsGXxqTfnKLsbwTJ9XvittDs77OLxOPOQjezNKPFC1LMgHi4/I73sC
	7aPvWUtahssLv5gFDOvZjuWMkHPDwVzVvPZwcp+WwjHrE/RCvnHaO8Ebl/JPhnyi4NDEQ9+t7GU
	yauFf2YaIn4R6ZJR2gMC0HI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g3nR55zJ4zRhR4;
	Mon, 27 Apr 2026 10:22:57 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D9FA40571;
	Mon, 27 Apr 2026 10:29:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 10:29:22 +0800
Message-ID: <93e1f576-cde9-4c9a-823f-84953d26f455@huawei.com>
Date: Mon, 27 Apr 2026 10:29:24 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: CPPC: Fix related_cpus inconsistency during CPU
 hotplug
To: <rafael@kernel.org>, <lenb@kernel.org>, <skelley@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260417040112.3727756-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260417040112.3727756-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 4/17/2026 12:01 PM, Jinjie Ruan wrote:
> When concurrently bringing up and down two SMT threads of a physical
> core, many warning call traces occur as below:
> 
> The issue timeline is as follows:
> 
> 1. when the system starts,
> 	cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus: 220-221
> 
> 2. Offline cpu 220 and cpu 221.
> 
> 3. Online cpu 220
> - cpu 221 is now offline, as acpi_get_psd_map() use for_each_online_cpu(),
>   so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus has only
>   cpu 220.
> 	cpufreq: cpu: 220, policy->related_cpus: 220, policy->cpus: 220
> 
> 4. offline cpu 220
> 
> 5. online cpu 221, the below call trace occurs:
> - Because cpu 220 and cpu 221 share one policy, and policy->related_cpus
>   = 220 after step 3, so cpu 221 is not in policy->related_cpus
>   but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
> 
> After revert commit 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
> for_each_possible_cpu() to use online CPUs"), the issue disappeared.
> 
> The _PSD (P-State Dependency) defines the hardware-level dependency of
> frequency control across CPU cores. Since this relationship is a physical
> attribute of the hardware topology, it remains constant regardless of the
> online or offline status of the CPUs.
> 
> Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
> CPU is offline, it will be excluded from the shared_cpu_map.
> Consequently, if that CPU is brought online later, the kernel will fail to
> recognize it as part of any shared frequency domain.
> 
> Switch back to for_each_possible_cpu() to ensure that all cores defined
> in the ACPI tables are correctly mapped into their respective performance
> domains from the start. This aligns with the logic of policy->related_cpus,
> which must encompass all potentially available cores in the domain to
> prevent logic gaps during CPU hotplug operations.
> 
> To resolve the original issue regarding the "nosmt" or "nosmt=force"
> boot parameter, as send_pcc_cmd() function already does if (!desc)
> continue, so reverting that loop back to for_each_possible_cpu() is ok,
> only need to change the match_cpc_ptr NULL case in acpi_get_psd_map() to
> continue as Sean suggested.
> 
> How to reproduce, on arm64 machine with SMT support which use acpi cppc
> cpufreq driver:
> 
> 	bash test.sh 220 & bash test.sh 221 &
> 
> 	The test.sh is as below:
> 		while true
> 			do
> 			echo 0 > /sys/devices/system/cpu/cpu${1}/online
> 			sleep 0.5
> 			cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
> 			echo 1 >  /sys/devices/system/cpu/cpu${1}/online
> 			cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
> 		done
> 
> 	CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted 6.6.0debug+ #5
> 	Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z, BIOS 20.39 09/04/2024
> 	pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> 	pc : cpufreq_online+0x8ac/0xa90
> 	lr : cpuhp_cpufreq_online+0x18/0x30
> 	sp : ffff80008739bce0
> 	x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
> 	x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
> 	x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
> 	x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
> 	x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
> 	x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
> 	x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
> 	x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
> 	x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
> 	x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
> 	Call trace:
> 	 cpufreq_online+0x8ac/0xa90
> 	 cpuhp_cpufreq_online+0x18/0x30
> 	 cpuhp_invoke_callback+0x128/0x580
> 	 cpuhp_thread_fun+0x110/0x1b0
> 	 smpboot_thread_fn+0x140/0x190
> 	 kthread+0xec/0x100
> 	 ret_from_fork+0x10/0x20
> 	---[ end trace 0000000000000000 ]---

Gentle ping.

> 
> Cc: stable@vger.kernel.org
> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining for_each_possible_cpu() to use online CPUs")
> Co-developed-by: Sean Kelley <skelley@nvidia.com>
> Signed-off-by: Sean Kelley <skelley@nvidia.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Fix the original issue by continue if per_cpu(cpc_desc_ptr, i) is NULL.
> - Update the commit message
> ---
>  drivers/acpi/cppc_acpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f0e513e9ed5d..bcfe2e6b8445 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>  end:
>  	if (cmd == CMD_WRITE) {
>  		if (unlikely(ret)) {
> -			for_each_online_cpu(i) {
> +			for_each_possible_cpu(i) {
>  				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>  
>  				if (!desc)
> @@ -524,13 +524,13 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
>  	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>  		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>  
> -	for_each_online_cpu(i) {
> +	for_each_possible_cpu(i) {
>  		if (i == cpu)
>  			continue;
>  
>  		match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
>  		if (!match_cpc_ptr)
> -			goto err_fault;
> +			continue;
>  
>  		match_pdomain = &(match_cpc_ptr->domain_info);
>  		if (match_pdomain->domain != pdomain->domain)

