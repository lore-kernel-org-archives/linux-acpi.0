Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B680480DE7;
	Thu,  2 Jul 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996624; cv=none; b=LYsaPlzUJNpeiZCZ0XSfyF4jefUpHD8kjvObyq6E5G5QmVX71CARR3nG+f542aiAH61d6mIO2ZwPCgV6hBO1ZsD26z328xNFYoC5bE0IWw/wnMd7Xtbt+L2hSC+HzjbciwSq6bySCu4B9gGhKZ3/p6RANp5C/GOj4fDGzHZ3dTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996624; c=relaxed/simple;
	bh=5vzS6NE9D+28kf5VM/3oPmc5JMLN1umtRQnRRLOjjwY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H0RoWFD9C+izF170c57qE4KUGa9ydna+W1jjL1uLNWkUPnizjgxZ+1dhyuBvm5TmCBIKInfFVT+KzO3JyOE+78bIeCOQTakkFhNB+qC1VcQjBIc5k1tjo6G2g4aroYSmkwB5ZVRE3rDcHITcRxfPBqaDqVbUmezCSiN9eUf6aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NCDLYVbJ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NCDLYVbJ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=d6fRqvgPlh2fHF2qAn1bAcg/KN5fo9O47FW0UNaksO4=;
	b=NCDLYVbJjQOkQQTwOw8WnZ2cu5ZnhOtXWphnjf1AhZhYjX8kZyCHEcB+StIa9iN1nDfc2Yd1b
	0natyLA5aFdfvflOKRWMKVuPCjacsy443DTTvQx50SiPAvxuu/OHSMbKeuv3cOMvWeH+aTj0iYn
	77urF6PiXNf2pZhzgf+6Iw0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4grc1x6TFLz1K96n;
	Thu,  2 Jul 2026 20:41:09 +0800 (CST)
Received: from kwepemo100013.china.huawei.com (unknown [7.202.195.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 153BD40578;
	Thu,  2 Jul 2026 20:50:19 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemo100013.china.huawei.com (7.202.195.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:50:18 +0800
Subject: Re: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
To: <rafael@kernel.org>, <tony.luck@intel.com>, <guohanjun@huawei.com>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <jarkko@kernel.org>,
	<yazen.ghannam@amd.com>, <jane.chu@oracle.com>, <lenb@kernel.org>,
	<linmiaohe@huawei.com>
References: <20260527082707.2013499-1-hejunhao3@h-partners.com>
CC: Junhao He <hejunhao3@h-partners.com>, <bp@alien8.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <liuyonglong@huawei.com>, <mawupeng1@huawei.com>
From: hejunhao <hejunhao3@h-partners.com>
Message-ID: <6ebea989-81c7-6237-1a31-8d6975796680@h-partners.com>
Date: Thu, 2 Jul 2026 20:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260527082707.2013499-1-hejunhao3@h-partners.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100013.china.huawei.com (7.202.195.244)

Gentle ping for this one, and it's ready.

Best regards,


On 2026/5/27 16:27, Junhao He wrote:
> When hardware memory corruption occurs and a user process accesses the
> corrupted page, the CPU triggers a Synchronous External Abort (SEA).
> The kernel invokes do_sea() to handle the exception, which calls
> memory_failure() to handle the faulty page.
>
> Scenario 1: Memory Error Interrupt First, then SEA
> The page is already poisoned by the memory error interrupt path. The
> subsequent SEA handler sends a SIGBUS to the task, which accesses the
> poisoned page. This flow is correct.
>
> Scenario 2: SEA first, then memory error interrupt (problematic scenario)
> If a user task directly accesses corrupted memory through a PFNMAP-style
> mapping (e.g., devmem), the page may still be in the free-buddy state when
> SEA is handled. In this case, memory_failure() will poison the page without
> invoking kill_accessing_process(), and then takes the free-buddy recovery
> path.
>
> After the CPU returns to the task context, the task re-enters the SEA
> handler due to the same access. However, ghes_estatus_cached() suppresses
> all subsequent entries during the 10-second window, preventing
> ghes_do_proc() from being called. This suppression blocks the
> MF_ACTION_REQUIRED-based SIGBUS delivery, causing the kernel to fail to
> kill the task immediately. Consequently, the process keeps re-entering
> the SEA handler, leading to an SEA storm. Later, the memory error
> interrupt path also cannot kill the task, leaving the system stuck in
> this repeated loop.
>
> The following error logs are explained using the devmem process:
>   NOTICE:  SEA Handle
>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>   [Hardware Error]: event severity: recoverable
>   [Hardware Error]:   section_type: ARM processor error
>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>   [T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>   [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
>            (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
>   NOTICE:  SEA Handle
>   NOTICE:  SEA Handle
>   ...
>   ...        ---> SEA storm
>   ...
>   NOTICE:  SEA Handle
>   [ T9955] Memory failure: 0x1000093: already hardware poisoned
>   ghes_print_estatus: 1 callbacks suppressed
>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>   [Hardware Error]: event severity: recoverable
>   [Hardware Error]:   section_type: ARM processor error
>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>   [T54990] Memory failure: 0x1000093: already hardware poisoned
>   [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
>
> To resolve this, return an error when encountering the same SEA again.
> The subsequent SEA handler invocation uses arm64_notify_die() to send a
> SIGBUS signal to the task, which terminates the process and prevents it
> from re-entering the handler loop.
>
> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Changes in V2:
> 1. update the commit message per suggestion from Xueshuai
> 2. Add a check to only return failure on the ghes_notify_sea() path,
>    avoiding impact on other NMI-type GHES handlers.
> Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejunhao3@h-partners.com/
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..787664740150 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>  	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>  
>  	/* This error has been reported before, don't process it again. */
> -	if (ghes_estatus_cached(estatus))
> +	if (ghes_estatus_cached(estatus)) {
> +		/*
> +		 * Return failure on duplicate SEA entries so that the
> +		 * subsequent SEA handler invocation sends a SIGBUS signal to
> +		 * the task to prevent it from re-entering the handler loop.
> +		 */
> +		if (is_hest_sync_notify(ghes))
> +			rc = -ECANCELED;
>  		goto no_work;
> +	}
>  
>  	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>  

