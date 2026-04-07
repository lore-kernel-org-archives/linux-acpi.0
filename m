Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47827211A09;
	Tue,  7 Apr 2026 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528612; cv=none; b=VZx5KISZxmh1y/zVlfNqangVCveMESal4Kf3Ue79Flo1Kh6pKpnco5EulbGJ+8oEse1MF+DvcLbra0X/MhHeKr8eTOhrN3TpRCn/38kQVP6gn9/rvUAwW4iGySIfPRrbshVaU9wienv7FpS8qrV/bbybDptwQDx3Pzpf46kPXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528612; c=relaxed/simple;
	bh=WT35EaiiI2wG3Aqi6/1F7mRUz5SUi4a8F5gVdVdUCWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHThh8h5PW32DLug2zSkeVBmLXrn6xtxMSMLkzpmreUOyHGkWa1dE5GyGkGRCUXFYTboeevep9SBovXE+SJd7uDVWKFVgNmWn49L0ZJMQfrZ6rJO1FQIQS5iRr/gNkLU1doAAsJdT8eGv0qJStM/VRNzvbrwOAFfSmT2aqto484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VzWiAt82; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VzWiAt82"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775528601; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SXoPgiI179buPSBOl3aS/BrBqYYugvAZrk75loH4u7M=;
	b=VzWiAt82kC+Ni/ba8WRaLB/QDCU7WoEDc1z7EI9b8DO5NcGLcx8uYlVl+PcT3/3IC8wM8tPJucr79v7ql2ZQHKijVzE07/2c+qsBQK+HGs+Z48ISAL/zd/mySWsBEy8Ml1gu3Pgjm1sSGs3JwFLSt/OrXu8mp7fD9nafYYJCM4c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X0a91TB_1775528598;
Received: from 30.246.177.235(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X0a91TB_1775528598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 10:23:20 +0800
Message-ID: <08c7aee3-b3a6-4696-b54f-0c7bc70a2929@linux.alibaba.com>
Date: Tue, 7 Apr 2026 10:23:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: Handle repeated SEA error interrupts storm
 scenarios
To: hejunhao <hejunhao3@h-partners.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 jarkko@kernel.org, yazen.ghannam@amd.com, jane.chu@oracle.com,
 lenb@kernel.org, Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, shiju.jose@huawei.com, tanxiaofei@huawei.com,
 Linuxarm <linuxarm@huawei.com>
References: <20251030071321.2763224-1-hejunhao3@h-partners.com>
 <CAJZ5v0h=QtcT7zhZEgrTjUk7EAk2OfbGG6BoEEv-3toKODMXQA@mail.gmail.com>
 <bf42a19d-0f5d-48d8-91f5-febb8bfd06d3@linux.alibaba.com>
 <9817f221-5b5f-7c25-ab94-cb04a854553a@h-partners.com>
 <70b85b7c-5107-4f79-abf7-3cc5b7e1438d@linux.alibaba.com>
 <ea31b6d3-fae5-ab5c-c10c-ed6901296498@h-partners.com>
 <c72680a4-5133-4b93-8efb-2e72ce0ed7fa@linux.alibaba.com>
 <22567fce-992c-89df-28fe-3d5959b8b205@h-partners.com>
 <96f505ac-dc5e-45df-8641-deabb973b5f3@linux.alibaba.com>
 <6e0b0ee0-2d1c-d0c1-fbaf-29438f62c502@h-partners.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6e0b0ee0-2d1c-d0c1-fbaf-29438f62c502@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/26/26 9:26 PM, hejunhao wrote:
> 
> On 2026/3/25 20:40, Shuai Xue wrote:
>>
>>
>> On 3/25/26 5:24 PM, hejunhao wrote:
>>>
>>>
>>> On 2026/3/25 10:12, Shuai Xue wrote:
>>>> Hi, junhao
>>>>
>>>> On 3/24/26 6:04 PM, hejunhao wrote:
>>>>> Hi shuai xue,
>>>>>
>>>>>
>>>>> On 2026/3/3 22:42, Shuai Xue wrote:
>>>>>> Hi, junhao,
>>>>>>
>>>>>> On 2/27/26 8:12 PM, hejunhao wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025/11/4 9:32, Shuai Xue wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> 在 2025/11/4 00:19, Rafael J. Wysocki 写道:
>>>>>>>>> On Thu, Oct 30, 2025 at 8:13 AM Junhao He <hejunhao3@h-partners.com> wrote:
>>>>>>>>>>
>>>>>>>>>> The do_sea() function defaults to using firmware-first mode, if supported.
>>>>>>>>>> It invoke acpi/apei/ghes ghes_notify_sea() to report and handling the SEA
>>>>>>>>>> error, The GHES uses a buffer to cache the most recent 4 kinds of SEA
>>>>>>>>>> errors. If the same kind SEA error continues to occur, GHES will skip to
>>>>>>>>>> reporting this SEA error and will not add it to the "ghes_estatus_llist"
>>>>>>>>>> list until the cache times out after 10 seconds, at which point the SEA
>>>>>>>>>> error will be reprocessed.
>>>>>>>>>>
>>>>>>>>>> The GHES invoke ghes_proc_in_irq() to handle the SEA error, which
>>>>>>>>>> ultimately executes memory_failure() to process the page with hardware
>>>>>>>>>> memory corruption. If the same SEA error appears multiple times
>>>>>>>>>> consecutively, it indicates that the previous handling was incomplete or
>>>>>>>>>> unable to resolve the fault. In such cases, it is more appropriate to
>>>>>>>>>> return a failure when encountering the same error again, and then proceed
>>>>>>>>>> to arm64_do_kernel_sea for further processing.
>>>>>>
>>>>>> There is no such function in the arm64 tree. If apei_claim_sea() returns
>>>>>
>>>>> Sorry for the mistake in the commit message. The function arm64_do_kernel_sea() should
>>>>> be arm64_notify_die().
>>>>>
>>>>>> an error, the actual fallback path in do_sea() is arm64_notify_die(),
>>>>>> which sends SIGBUS?
>>>>>>
>>>>>
>>>>> If apei_claim_sea() returns an error, arm64_notify_die() will call arm64_force_sig_fault(inf->sig /* SIGBUS */, , , ),
>>>>> followed by force_sig_fault(SIGBUS, , ) to force the process to receive the SIGBUS signal.
>>>>
>>>> So the process is expected to killed by SIGBUS?
>>>
>>> Yes. The devmem process is expected to terminate upon receiving a SIGBUS signal, you can
>>> see this at the last line of the test log after the patch is applied.
>>> For other processes whether it terminates depends on whether it catches the signal; the kernel is
>>> responsible for sending it immediately.
>>>
>>>>
>>>>>
>>>>>>>>>>
>>>>>>>>>> When hardware memory corruption occurs, a memory error interrupt is
>>>>>>>>>> triggered. If the kernel accesses this erroneous data, it will trigger
>>>>>>>>>> the SEA error exception handler. All such handlers will call
>>>>>>>>>> memory_failure() to handle the faulty page.
>>>>>>>>>>
>>>>>>>>>> If a memory error interrupt occurs first, followed by an SEA error
>>>>>>>>>> interrupt, the faulty page is first marked as poisoned by the memory error
>>>>>>>>>> interrupt process, and then the SEA error interrupt handling process will
>>>>>>>>>> send a SIGBUS signal to the process accessing the poisoned page.
>>>>>>>>>>
>>>>>>>>>> However, if the SEA interrupt is reported first, the following exceptional
>>>>>>>>>> scenario occurs:
>>>>>>>>>>
>>>>>>>>>> When a user process directly requests and accesses a page with hardware
>>>>>>>>>> memory corruption via mmap (such as with devmem), the page containing this
>>>>>>>>>> address may still be in a free buddy state in the kernel. At this point,
>>>>>>>>>> the page is marked as "poisoned" during the SEA claim memory_failure().
>>>>>>>>>> However, since the process does not request the page through the kernel's
>>>>>>>>>> MMU, the kernel cannot send SIGBUS signal to the processes. And the memory
>>>>>>>>>> error interrupt handling process not support send SIGBUS signal. As a
>>>>>>>>>> result, these processes continues to access the faulty page, causing
>>>>>>>>>> repeated entries into the SEA exception handler. At this time, it lead to
>>>>>>>>>> an SEA error interrupt storm.
>>>>>>
>>>>>> In such case, the user process which accessing the poisoned page will be killed
>>>>>> by memory_fauilre?
>>>>>>
>>>>>> // memory_failure():
>>>>>>
>>>>>>        if (TestSetPageHWPoison(p)) {
>>>>>>            res = -EHWPOISON;
>>>>>>            if (flags & MF_ACTION_REQUIRED)
>>>>>>                res = kill_accessing_process(current, pfn, flags);
>>>>>>            if (flags & MF_COUNT_INCREASED)
>>>>>>                put_page(p);
>>>>>>            action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>>>>>>            goto unlock_mutex;
>>>>>>        }
>>>>>>
>>>>>> I think this problem has already been fixed by commit 2e6053fea379 ("mm/memory-failure:
>>>>>> fix infinite UCE for VM_PFNMAP pfn").
>>>>>>
>>>>>> The root cause is that walk_page_range() skips VM_PFNMAP vmas by default when
>>>>>> no .test_walk callback is set, so kill_accessing_process() returns 0 for a
>>>>>> devmem-style mapping (remap_pfn_range, VM_PFNMAP), making the caller believe
>>>>>> the UCE was handled properly while the process was never actually killed.
>>>>>>
>>>>>> Did you try the lastest kernel version?
>>>>>>
>>>>>
>>>>> I retested this issue on the kernel v7.0.0-rc4 with the following debug patch and was still able to reproduce it.
>>>>>
>>>>>
>>>>> @@ -1365,8 +1365,11 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>>>>            ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>>>>>
>>>>>            /* This error has been reported before, don't process it again. */
>>>>> -       if (ghes_estatus_cached(estatus))
>>>>> +       if (ghes_estatus_cached(estatus)) {
>>>>> +               pr_info("This error has been reported before, don't process it again.\n");
>>>>>                    goto no_work;
>>>>> +       }
>>>>>
>>>>> the test log Only some debug logs are retained here.
>>>>>
>>>>> [2026/3/24 14:51:58.199] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32 0
>>>>> [2026/3/24 14:51:58.369] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32
>>>>> [2026/3/24 14:51:58.458] [  130.558038][   C40] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>> [2026/3/24 14:51:58.459] [  130.572517][   C40] {1}[Hardware Error]: event severity: recoverable
>>>>> [2026/3/24 14:51:58.459] [  130.578861][   C40] {1}[Hardware Error]:  Error 0, type: recoverable
>>>>> [2026/3/24 14:51:58.459] [  130.585203][   C40] {1}[Hardware Error]:   section_type: ARM processor error
>>>>> [2026/3/24 14:51:58.459] [  130.592238][   C40] {1}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>> [2026/3/24 14:51:58.459] [  130.598492][   C40] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081010400
>>>>> [2026/3/24 14:51:58.459] [  130.607871][   C40] {1}[Hardware Error]:   error affinity level: 0
>>>>> [2026/3/24 14:51:58.459] [  130.614038][   C40] {1}[Hardware Error]:   running state: 0x1
>>>>> [2026/3/24 14:51:58.459] [  130.619770][   C40] {1}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>> [2026/3/24 14:51:58.459] [  130.627673][   C40] {1}[Hardware Error]:   Error info structure 0:
>>>>> [2026/3/24 14:51:58.459] [  130.633839][   C40] {1}[Hardware Error]:   num errors: 1
>>>>> [2026/3/24 14:51:58.459] [  130.639137][   C40] {1}[Hardware Error]:    error_type: 0, cache error
>>>>> [2026/3/24 14:51:58.459] [  130.645652][   C40] {1}[Hardware Error]:    error_info: 0x0000000020400014
>>>>> [2026/3/24 14:51:58.459] [  130.652514][   C40] {1}[Hardware Error]:     cache level: 1
>>>>> [2026/3/24 14:51:58.551] [  130.658073][   C40] {1}[Hardware Error]:     the error has not been corrected
>>>>> [2026/3/24 14:51:58.551] [  130.665194][   C40] {1}[Hardware Error]:    physical fault address: 0x0000001351811800
>>>>> [2026/3/24 14:51:58.551] [  130.673097][   C40] {1}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>> [2026/3/24 14:51:58.551] [  130.680744][   C40] {1}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:51:58.551] [  130.690471][   C40] {1}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:51:58.552] [  130.700198][   C40] {1}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:51:58.552] [  130.710083][ T9767] Memory failure: 0x1351811: recovery action for free buddy page: Recovered
>>>>> [2026/3/24 14:51:58.638] [  130.790952][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:51:58.903] [  131.046994][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:51:58.991] [  131.132360][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:51:59.969] [  132.071431][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:00.860] [  133.010255][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:01.927] [  134.034746][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:02.906] [  135.058973][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:03.971] [  136.083213][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:04.860] [  137.021956][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:06.018] [  138.131460][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:06.905] [  139.070280][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:07.886] [  140.009147][   C40] This error has been reported before, don't process it again.
>>>>> [2026/3/24 14:52:08.596] [  140.777368][   C40] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>> [2026/3/24 14:52:08.683] [  140.791921][   C40] {2}[Hardware Error]: event severity: recoverable
>>>>> [2026/3/24 14:52:08.683] [  140.798263][   C40] {2}[Hardware Error]:  Error 0, type: recoverable
>>>>> [2026/3/24 14:52:08.683] [  140.804606][   C40] {2}[Hardware Error]:   section_type: ARM processor error
>>>>> [2026/3/24 14:52:08.683] [  140.811641][   C40] {2}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>> [2026/3/24 14:52:08.684] [  140.817895][   C40] {2}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081010400
>>>>> [2026/3/24 14:52:08.684] [  140.827274][   C40] {2}[Hardware Error]:   error affinity level: 0
>>>>> [2026/3/24 14:52:08.684] [  140.833440][   C40] {2}[Hardware Error]:   running state: 0x1
>>>>> [2026/3/24 14:52:08.684] [  140.839173][   C40] {2}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>> [2026/3/24 14:52:08.684] [  140.847076][   C40] {2}[Hardware Error]:   Error info structure 0:
>>>>> [2026/3/24 14:52:08.684] [  140.853241][   C40] {2}[Hardware Error]:   num errors: 1
>>>>> [2026/3/24 14:52:08.684] [  140.858540][   C40] {2}[Hardware Error]:    error_type: 0, cache error
>>>>> [2026/3/24 14:52:08.684] [  140.865055][   C40] {2}[Hardware Error]:    error_info: 0x0000000020400014
>>>>> [2026/3/24 14:52:08.684] [  140.871917][   C40] {2}[Hardware Error]:     cache level: 1
>>>>> [2026/3/24 14:52:08.684] [  140.877475][   C40] {2}[Hardware Error]:     the error has not been corrected
>>>>> [2026/3/24 14:52:08.764] [  140.884596][   C40] {2}[Hardware Error]:    physical fault address: 0x0000001351811800
>>>>> [2026/3/24 14:52:08.764] [  140.892499][   C40] {2}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>> [2026/3/24 14:52:08.766] [  140.900145][   C40] {2}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:52:08.767] [  140.909872][   C40] {2}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:52:08.767] [  140.919598][   C40] {2}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>> [2026/3/24 14:52:08.768] [  140.929346][ T9767] Memory failure: 0x1351811: already hardware poisoned
>>>>> [2026/3/24 14:52:08.768] [  140.936072][ T9767] Memory failure: 0x1351811: Sending SIGBUS to busybox:9767 due to hardware memory corruption
>>>>
>>>> Did you cut off some logs here?
>>>
>>> I just removed some duplicate debug logs: "This error has already been...", these were added by myself.
> 
> Hi, Shuai

Hi, Junhao,

Sorry for late reply.

> 
> Compared to the original commit message and the logs reproducing this issue
> on kernel v7.0.0-rc4, perhaps you are asking whether the current log is missing
> information such as 'NOTICE: SEA Handle'?
> These miss logs are from the firmware. To reduce serial output, the firmware has
> hidden these debug prints. However, using my own custom debug logs, I can
> still see that the kernel's do_sea() process is continuously running during the
> 10-second cache timeout. Although only one debug log is retained per second.
> This confirms that the issue is still present on the latest kernel v7.0.0-rc4.
> 
>>>> The error log also indicates that the SIGBUS is delivered as expected.
>>>
>>> An SError occurs at kernel time 130.558038. Then, after 10 seconds, the kernel
>>> can re-enter the SEA processing flow and send the SIGBUS signal to the process.
>>> This 10-second delay corresponds to the cache timeout threshold of the
>>> ghes_estatus_cached() feature.
>>> Therefore, the purpose of this patch is to send the SIGBUS signal to the process
>>> immediately, rather than waiting for the timeout to expire.
>>
>> Hi, hejun,
>>
>> Sorry, but I am still not convinced by the log you provided.
>>
>> As I understand your commit message, there are two different cases being discussed:
>>
>> Case 1: memory error interrupt first, then SEA
>>
>> When hardware memory corruption occurs, a memory error interrupt is
>> triggered first. If the kernel later accesses the corrupted data, it may
>> then enter the SEA handler. In this case, the faulty page would already
>> have been marked poisoned by the memory error interrupt path, and the SEA
>> handling path would eventually send SIGBUS to the task accessing that page.
>>
>> Case 2: SEA first, then memory error interrupt
>>
>> Your commit message describes this as the problematic scenario:
>>
>> A user process directly accesses hardware-corrupted memory through a
>> PFNMAP-style mapping such as devmem. The page may still be in the free
>> buddy state when SEA is handled first. In that case, memory_failure()
>> poisons the page during SEA handling, but the process is not killed
>> immediately. Since the task continues accessing the same corrupted
>> location, it keeps re-entering the SEA handler, leading to an SEA storm.
>> Later, the memory error interrupt path also cannot kill the task, so the
>> system remains stuck in this repeated SEA loop.
> Yes.
>>
>> My concern is that your recent explanation and log seem to demonstrate
>> something different from what the commit message claims to fix.
>>
>>  From the log, what I can see is:
>>
>> the first SEA occurs,
>> the page is marked poisoned as a free buddy page,
>> repeated SEAs are suppressed by ghes_estatus_cached(),
>> after the cache timeout expires, the SEA path runs again,
>> then memory_failure() reports "already hardware poisoned" and SIGBUS is
>> sent to the busybox devmem process.
>> This seems to show a delayed SIGBUS delivery caused by the GHES cache
>> timeout, rather than clearly demonstrating the SEA storm problem described
>> in the commit message.
>>
>> So I think there is still a mismatch here:
>>
>> If the patch is intended to fix the SEA storm described in case 2,
>> then I would expect evidence that the storm still exists on the latest
>> kernel and that this patch is what actually breaks that loop.
>> If instead the patch is intended to avoid the 10-second delay before
>> SIGBUS delivery, then that should be stated explicitly, because that is
>> a different problem statement from what the current commit message says.
>> Also, regarding the devmem/PFNMAP case: I previously pointed to commit
>> 2e6053fea379 ("mm/memory-failure: fix infinite UCE for VM_PFNMAP pfn"),
>> which was meant to address the failure to kill tasks accessing poisoned
>> VM_PFNMAP mappings.
>>
> 
> This patch was already merged prior to kernel v7.0.0-rc4, therefore, it cannot fix this issue.
> 
> I reverted the patch on kernel v7.0.0-rc4 to reproduce the issue.
> The debug logs show that the message 'This error has already been...' persists
> for more than 10 seconds, and the printing cannot be stopped. so it fixes other issue.

Thanks for confirm.

> 
>> So my main question is:
>>
>> Does the SEA storm issue still exist on the latest kernel version, or is
>> the remaining issue only that SIGBUS is delayed by the GHES estatus cache
>> timeout?
> 
> We should not treat them separately.

Agreed. Please update the commit message to explain the causal chain explicitly:

- The first SEA poisons the free buddy page but does not kill the
   accessing task, because memory_failure() takes the free-buddy recovery
   path and never reaches kill_accessing_process().

- The task re-enters the SEA handler repeatedly, but
   ghes_estatus_cached() suppresses all subsequent entries during the
   10-second window, preventing ghes_do_proc() from being called and
   blocking the MF_ACTION_REQUIRED-based SIGBUS delivery.

- This suppression is what sustains the SEA storm.

> 
> In case 2, First SEA can only poisons the page, and then re-enter the SEA processing flow.
> Due to the reporting throttle of the ghes_estatus_cached(), SEA cannot timely invoke
> memory_failure()  to kill the task, the task will continues accessing the same corrupted
> location, then re-enter the SEA processing flow loop, so causing the SEA storm...
> Perhaps I never clearly explained why the SEA storm occurred.

+cc Lin Miaohe for the memory_failure() discussion.

Regarding the memory_failure() path: since SEA is a synchronous
notification, is_hest_syncnotify() returns true, ghesdo_proc() sets sync
= true, and MF_ACTION_REQUIRED is passed into ghes_do_memory_failure().
This means that on the second and subsequent SEAs (after cache expiry),
memory_failure() would reach the already-poisoned branch and call
kill_accessing_process() to terminate the task:


	if (TestSetPageHWPoison(p)) {
		res = -EHWPOISON;
		if (flags & MF_ACTION_REQUIRED)
			res = kill_accessing_process(current, pfn, flags);
		if (flags & MF_COUNT_INCREASED)
			put_page(p);
		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
		goto unlock_mutex;
	}

The patch short-circuits this by terminating the task earlier, via
arm64_notify_die(), on every cache-suppressed SEA. I have no objection
to killing the process early in this way.

+cc Tony Luck for the ghes_notify_nmi path.

One concern is the impact on ghes_notify_nmi().

ghes_in_nmi_queue_one_entry() is shared between two callers:

ghes_notify_sea() → ghes_in_nmi_spool_from_list(&ghes_sea, ...)
ghes_notify_nmi() → ghes_in_nmi_spool_from_list(&ghes_nmi, ...)

For the NMI path, if ghes_estatuscached() hits and
ghesin_nmi_queue_one_entry() now returns -ECANCELED instead of 0,
ghesinnmi_spool_from_list() will not set ret = 0, and ghes_notify_nmi()
will return NMI_DONE instead of NMI_HANDLED. This tells the NMI handler
chain that no handler claimed the interrupt, which is semantically
incorrect — an active hardware error was observed, but deliberately
suppressed by the cache. NMI errors are asynchronous (sync = false,
MF_ACTION_REQUIRED not set), so there is no practical impact on the kill
path. However, returning NMI_DONE for a cache-suppressed NMI could cause
spurious warnings from the NMI dispatcher on some platforms. To avoid
this, I suggest scoping the -ECANCELED return to the synchronous (SEA)
case only. One approach is to pass a bool sync parameter down through
ghes_in_nmi_spool_from_list() and ghes_innmiqueue_one_entry(), returning
-ECANCELED on cache-hit only when sync is true. Alternatively, this
logic can be handled at the ghes_notify_sea() call site directly.

Shuai
Thanks.
Shuai
