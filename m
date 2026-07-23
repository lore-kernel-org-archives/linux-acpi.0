Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC93F326D;
	Thu, 23 Jul 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795534; cv=none; b=fQwBg1hmOSHceBT4+g6sK7ZC2/9+ROCnNMN1Go5DMMvj3vR/YjXhQEaBGoUop/CP5xE1Uaa5fiX1dgzXk9wWTEt2Q2LhiCHxuD6/4t8ARogHLJD3C/oC/eZlFnOWMrbP5LNHHhu0g4YoZzNC9Q7EQ0dcJzZumgcJjfSbVZK+IQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795534; c=relaxed/simple;
	bh=O9S+Zx1MFP8MjWiP3AQn1zUvIjc53n+1shcmoy8/qeA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uBL4JOx1VVotSd/5xHvc9B3ioycNa718vCKPxOV6aYMxcp3FRQ2bFVDg/dbx1NIAeFBmXUyYIeKE+k+xY4EaLRhjkoXx/w9SibgUql9WpHprmzVDxmgss2fMhmuKujvagFGYr6yTXdTCYp9frtbQFtNEZ/BZjGUc0Bta5afiCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=fFWS6go+; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="fFWS6go+"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y/9XXgvQgnbrfhKY7HHK5P14uN3l5FZlyAZ6wRmPKb0=;
	b=fFWS6go+gEfKiQFMZgNKxTCLoxXC1BwVvPCsHG1ROGwD9rpd8/t4oKJDiMKqByTOimo5JNvcL
	zduVtaa5QAEJBAgLwGiA4i/WkbWR8kfxCWRz37x0neJAEg3TgezQ3YB7hUamAXQhc4qpfxLTCM9
	envgQUCjkZTMWgG5WPHiIdc=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5PHy1ZVrz1prKd;
	Thu, 23 Jul 2026 16:22:38 +0800 (CST)
Received: from kwepemo100013.china.huawei.com (unknown [7.202.195.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 85A4340538;
	Thu, 23 Jul 2026 16:32:03 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemo100013.china.huawei.com (7.202.195.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 16:32:02 +0800
Subject: Re: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
To: "Luck, Tony" <tony.luck@intel.com>
References: <20260527082707.2013499-1-hejunhao3@h-partners.com>
 <ak6FfacJrg8Elnl6@agluck-desk3>
CC: <rafael@kernel.org>, <guohanjun@huawei.com>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <jarkko@kernel.org>, <yazen.ghannam@amd.com>,
	<jane.chu@oracle.com>, <lenb@kernel.org>, <linmiaohe@huawei.com>,
	<bp@alien8.de>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, <mawupeng1@huawei.com>, Junhao He
	<hejunhao3@h-partners.com>
From: hejunhao <hejunhao3@h-partners.com>
Message-ID: <3a6e3281-de8a-ae5c-249c-316eaa886636@h-partners.com>
Date: Thu, 23 Jul 2026 16:32:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ak6FfacJrg8Elnl6@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100013.china.huawei.com (7.202.195.244)



On 2026/7/9 1:14, Luck, Tony wrote:
> On Wed, May 27, 2026 at 04:27:07PM +0800, Junhao He wrote:
>> When hardware memory corruption occurs and a user process accesses the
>> corrupted page, the CPU triggers a Synchronous External Abort (SEA).
>> The kernel invokes do_sea() to handle the exception, which calls
>> memory_failure() to handle the faulty page.
>>
>> Scenario 1: Memory Error Interrupt First, then SEA
>> The page is already poisoned by the memory error interrupt path. The
>> subsequent SEA handler sends a SIGBUS to the task, which accesses the
>> poisoned page. This flow is correct.
>>
>> Scenario 2: SEA first, then memory error interrupt (problematic scenario)
>> If a user task directly accesses corrupted memory through a PFNMAP-style
>> mapping (e.g., devmem), the page may still be in the free-buddy state when
>> SEA is handled. In this case, memory_failure() will poison the page without
>> invoking kill_accessing_process(), and then takes the free-buddy recovery
>> path.
>>
>> After the CPU returns to the task context, the task re-enters the SEA
>> handler due to the same access. However, ghes_estatus_cached() suppresses
>> all subsequent entries during the 10-second window, preventing
>> ghes_do_proc() from being called. This suppression blocks the
>> MF_ACTION_REQUIRED-based SIGBUS delivery, causing the kernel to fail to
>> kill the task immediately. Consequently, the process keeps re-entering
>> the SEA handler, leading to an SEA storm. Later, the memory error
>> interrupt path also cannot kill the task, leaving the system stuck in
>> this repeated loop.
>>
>> The following error logs are explained using the devmem process:
>>   NOTICE:  SEA Handle
>>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>   [Hardware Error]: event severity: recoverable
>>   [Hardware Error]:   section_type: ARM processor error
>>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>>   [T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>>   [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
>>            (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
>>   NOTICE:  SEA Handle
>>   NOTICE:  SEA Handle
>>   ...
>>   ...        ---> SEA storm
>>   ...
>>   NOTICE:  SEA Handle
>>   [ T9955] Memory failure: 0x1000093: already hardware poisoned
>>   ghes_print_estatus: 1 callbacks suppressed
>>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>   [Hardware Error]: event severity: recoverable
>>   [Hardware Error]:   section_type: ARM processor error
>>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>>   [T54990] Memory failure: 0x1000093: already hardware poisoned
>>   [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
>>
>> To resolve this, return an error when encountering the same SEA again.
>> The subsequent SEA handler invocation uses arm64_notify_die() to send a
>> SIGBUS signal to the task, which terminates the process and prevents it
>> from re-entering the handler loop.
>>
>> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> Changes in V2:
>> 1. update the commit message per suggestion from Xueshuai
>> 2. Add a check to only return failure on the ghes_notify_sea() path,
>>    avoiding impact on other NMI-type GHES handlers.
>> Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejunhao3@h-partners.com/
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3236a3ce79d6..787664740150 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
> ghes_in_nmi_queue_one_entry() is called from two places:
>
> __ghes_sdei_callback()
>
> I think, but I'm not sure, that you are addressing call from here. By
> returning -ECANCELLED this code skips the irq_work_queue() call and
> returns -ENOENT (instead of zero).
>
> ghes_in_nmi_spool_from_list()
>
> Effect here is more complex. Depends on whether there are multiple
> ghes entries on the rcu_list. If there was just one, and you return
> -ECANCELLED, then irq_work_queue() is skipped. But if there are multiple
> entries on the list and at least one of them gets a zero return from
> ghes_in_nmi_queue_one_entry() then irq_work_queue() is called.

Hi Luck Tony,

Thanks for the comments.

This fix is only for the call to ghes_in_nmi_spool_from_list() from ghes_notify_sea() on
ARM platforms (ACPI_HEST_NOTIFY_SEA); other paths are unchanged.

If multiple SEA errors occur simultaneously, multiple entries in ghes_sea are active
and one of them returns 0, then -ECANCELED is discarded, but the unhandled
SEA will simply trigger again and re-enter the SEA handler to be processed.

The worst case is when multiple valid SEA entries persist within the 10-second
ghes_estatus_cached() window — the fact is that a great many SEA errors are
produced, which actually constitutes a real SEA storm, not one triggered by a single
SEA, and in this situation not delivering SIGBUS in time to kill the process is acceptable.

Best regards,
Junhao.

>
>
> So which of these callers is the one that needs this fix? And is the
> other called OK with getting -ECANCELLED error?
>
>>  	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>>  
>>  	/* This error has been reported before, don't process it again. */
>> -	if (ghes_estatus_cached(estatus))
>> +	if (ghes_estatus_cached(estatus)) {
>> +		/*
>> +		 * Return failure on duplicate SEA entries so that the
>> +		 * subsequent SEA handler invocation sends a SIGBUS signal to
>> +		 * the task to prevent it from re-entering the handler loop.
>> +		 */
>> +		if (is_hest_sync_notify(ghes))
>> +			rc = -ECANCELED;
>>  		goto no_work;
>> +	}
>>  
>>  	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>>  
>> -- 
>> 2.33.0
>>
> -Tony
>
> .
>

