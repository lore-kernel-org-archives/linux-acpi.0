Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A73AD516;
	Wed,  8 Jul 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474987; cv=none; b=rZFhzKP6maKLmbDSuEQqtiaop+8/wJgkBybp5eTVNIN+SE4sYsTneMgKZOy5jQ558/VlUB/XYhDNSrs/BfsvEDfe5IhkA1itwe9Uhr9vnLmuK88V7KGCbvhjc6cHgD1sikoQa/M3CxT0acHGK2OtVEVVqkpcvE57yXSBMqenSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474987; c=relaxed/simple;
	bh=o5sm/K9wcF6RwXPf5G6qhLxB7jDXq+R96eprh4tGwfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDKiOjtPVDiE02XIRy2d0MoOh86qqUPlkNW6HNiol+6Rit83aRN2NjwnM6oyxs2mTJ+mRFp7nV4CMK6R9c2KyV+DXfXrkYTJqOzrLjtIH+QIBee1NPGgMtwi3QRH/U2PAQeC9FQWYC2y1VvefZu45cYEgN5P3oP8JF8fGjl7v6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zsyx5RMQ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zsyx5RMQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783474981; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9Dd0yo6CrKwB47yF27tbjHU5QXAXcxL+TJZdWwmiNyk=;
	b=Zsyx5RMQ5UpLEZ2pxkV+ayPvZPvztfSSqCTkAfFB6g4B1olNJfQCo0zzan7TVzQ+FQlUjRXm9e6/UnLXnvkcJG7anvr48ALice2TK9BFM/+GL8rzrLHq5rDI8mohs5/YVS11UEZ8p/yUFBCGK8vwP+ZDVwE8o8W1Cf0TNEO8M9Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X6fqE44_1783474978;
Received: from 30.246.161.237(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X6fqE44_1783474978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 09:43:00 +0800
Message-ID: <3f77c23d-5f04-4617-99f9-b08b1740cc21@linux.alibaba.com>
Date: Wed, 8 Jul 2026 09:42:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
To: hejunhao <hejunhao3@h-partners.com>, rafael@kernel.org,
 tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org,
 jarkko@kernel.org, yazen.ghannam@amd.com, jane.chu@oracle.com,
 lenb@kernel.org, linmiaohe@huawei.com, Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 tanxiaofei@huawei.com, liuyonglong@huawei.com, mawupeng1@huawei.com
References: <20260527082707.2013499-1-hejunhao3@h-partners.com>
 <6ebea989-81c7-6237-1a31-8d6975796680@h-partners.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6ebea989-81c7-6237-1a31-8d6975796680@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Tony, and BP,

On 7/2/26 8:50 PM, hejunhao wrote:
> Gentle ping for this one, and it's ready.
> 
> Best regards,
> 
> 
> On 2026/5/27 16:27, Junhao He wrote:
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
>>    NOTICE:  SEA Handle
>>    [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>    [Hardware Error]: event severity: recoverable
>>    [Hardware Error]:   section_type: ARM processor error
>>    [Hardware Error]:    physical fault address: 0x0000001000093c00
>>    [T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>>    [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
>>             (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
>>    NOTICE:  SEA Handle
>>    NOTICE:  SEA Handle
>>    ...
>>    ...        ---> SEA storm
>>    ...
>>    NOTICE:  SEA Handle
>>    [ T9955] Memory failure: 0x1000093: already hardware poisoned
>>    ghes_print_estatus: 1 callbacks suppressed
>>    [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>    [Hardware Error]: event severity: recoverable
>>    [Hardware Error]:   section_type: ARM processor error
>>    [Hardware Error]:    physical fault address: 0x0000001000093c00
>>    [T54990] Memory failure: 0x1000093: already hardware poisoned
>>    [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
>>
>> To resolve this, return an error when encountering the same SEA again.
>> The subsequent SEA handler invocation uses arm64_notify_die() to send a
>> SIGBUS signal to the task, which terminates the process and prevents it
>> from re-entering the handler loop.
>>
>> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> Changes in V2:
>> 1. update the commit message per suggestion from Xueshuai
>> 2. Add a check to only return failure on the ghes_notify_sea() path,
>>     avoiding impact on other NMI-type GHES handlers.
>> Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejunhao3@h-partners.com/
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3236a3ce79d6..787664740150 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>   	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>>   
>>   	/* This error has been reported before, don't process it again. */
>> -	if (ghes_estatus_cached(estatus))
>> +	if (ghes_estatus_cached(estatus)) {
>> +		/*
>> +		 * Return failure on duplicate SEA entries so that the
>> +		 * subsequent SEA handler invocation sends a SIGBUS signal to
>> +		 * the task to prevent it from re-entering the handler loop.
>> +		 */
>> +		if (is_hest_sync_notify(ghes))
>> +			rc = -ECANCELED;
>>   		goto no_work;
>> +	}
>>   
>>   	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>>   

Hello Tony, BP,

Could you please take a look at this patch?

Since `ghes_in_nmi_queue_one_entry()` is a common path for both ARM64
and x86, an Ack from the x86 side would be appreciated.

For ARM part, look good to me.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
