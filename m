Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B74A3D52;
	Thu, 17 Sep 2026 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636278; cv=none; b=Mqgm7DeAIQX82WJaScxrpWUxpZ/MHd1dbMUaZL1fhaXQuWHG5T65BWXt1CemNh59xuuLnnto214oxtDCpunzOihSB1RIi8xygyQMzjETATVjQIFKn99/RBTLVuvAqMueLJc7tQBtorc+zwlxOtVepz0OG0at9wv+RSR0s07fYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636278; c=relaxed/simple;
	bh=Fi8U/5R9ouWq3gC3h4XdjmjtQgIhxaWjzBgD9YtimQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tZ7M4h2wAKaDgUEyMpVtz0x0tUF90DSZ3UqQoY/3+XvYZ5fFnQVr2pCYNgaDShwtWueSXYs+tT2H1qc9jxxpgQugrlhyDA0fjRmQYZWpPTGnpZ61RzaQfaOGmK3CRHzpS9pScuTftjAr4tooFDHKiE2DG4OOjLa6CfCL4sCkzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hlqSV3hhHz1T4Mc;
	Thu, 17 Sep 2026 16:59:22 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 625914057F;
	Thu, 17 Sep 2026 17:11:05 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 17 Sep
 2026 17:11:04 +0800
Message-ID: <ac3b17af-c6bb-4e91-b9bb-6cf2d43f8107@hisilicon.com>
Date: Thu, 17 Sep 2026 17:11:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: RISC-V: CPPC: Implement cpc_read_ffh_fb_ctrs()
To: Yufan Dou <douyufan@picoheart.com>, Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yuchao.46@picoheart.com>, <yang.yicong@picoheart.com>,
	<lihuisong@picoheart.com>, <geshijian@picoheart.com>,
	<wang.yechao255@zte.com.cn>
References: <20260902083450.2348-1-douyufan@picoheart.com>
 <20260909071541.1545-1-douyufan@picoheart.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260909071541.1545-1-douyufan@picoheart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/9/2026 3:15 PM, Yufan Dou wrote:
> On RISC-V, reading FFH feedback counters on a remote hart through
> cpc_read_ffh() requires a separate IPI for each register.
> cppc_get_perf_ctrs() therefore samples the delivered and reference
> counters in two separate IPIs. Variation in the delay between these
> reads distorts the delivered/reference ratio and thus the frequency
> reported by cpufreq.
> 
> Implement cpc_read_ffh_fb_ctrs() to read both counters back-to-back
> in a single callback on the target hart. For remote reads, this
> reduces two IPIs to one and narrows the separation between the
> counter samples. Support CSR-type, SBI-type and mixed-type pairs.
> Pairing SBI reads does not reduce the number of SBI calls, but
> still avoids a separate IPI for each counter.
> 
> Factor the execution-context handling into cppc_ffh_read_on_cpu(),
> shared by cpc_read_ffh() and cpc_read_ffh_fb_ctrs(). CPPC frequency
> invariance (FIE) reads non-PCC counters directly from the scheduler
> tick, with local interrupts disabled. Unconditionally rejecting
> such reads prevents the frequency scale from being updated.
> 
> Following arm64's counters_read_on_cpu(), invoke the callback
> directly when interrupts are disabled and the target is the current
> CPU. Reject remote reads in that context. Otherwise, use
> smp_call_function_single() and propagate its return value before
> accessing the callback results.
> 
> Frequency accuracy testing used CSR-type delivered and reference
> counters, with CPU1 kept busy by:
> 
>   # stress-ng --cpu 1 --taskset 1
> 
> On a CPU with cpuinfo_max_freq of 3000000 kHz:
> 
> Before:
> 
>   Maximum observed cpuinfo_cur_freq: 3201369 kHz
>   Maximum observed deviation:        +201369 kHz (+6.71%)
> 
> After:
> 
>   Maximum observed cpuinfo_cur_freq: 3009646 kHz
>   Maximum observed deviation:          +9646 kHz (+0.32%)
> 
> The maximum observed deviation from cpuinfo_max_freq decreased
> by 95.2%.
> 
> Additional testing covered the CPPC FIE tick path and SBI-type
> FFH register reads.
> 
> Co-developed-by: Yicong Yang <yang.yicong@picoheart.com>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
LGTM, thanks!
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com> 
> ---
> Changes in v2:
> - Support SBI-type and mixed-type counter pairs in a single callback
>   on the target hart, reducing remote reads to one IPI.
> - Factor out cppc_ffh_read_on_cpu() for both FFH read interfaces.
>   Allow local reads with interrupts disabled and reject remote reads
>   in that context, following arm64's counters_read_on_cpu().
> - Propagate synchronous cross-CPU call errors in cpc_read_ffh().
> - Test the CPPC FIE tick path and SBI-type FFH register reads.
> 
> v1:
> https://lore.kernel.org/all/20260902083450.2348-1-douyufan@picoheart.com/
> 
>  drivers/acpi/riscv/cppc.c | 102 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 5 deletions(-)
> 
[ ... ]
