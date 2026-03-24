Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32669387372;
	Tue, 24 Mar 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346681; cv=none; b=fNDgFoY/VINVsQpBs2reWUJ4Bt2NsiEo1pHPCf8VW+zKTt27Wcd+SlTkFygn5GvT0RySqI/cAkO9ATbycZKXzq/HJ5kI0fyD8aDvJfUZVmG3f454phVWdUnbcVZr2sLPCR+ycQMbtaubNBx0WpaPbDXcjTC+8E9xYnMjWhOKYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346681; c=relaxed/simple;
	bh=ua7RMGs8ZvU/Ubt9WSXTvr1L2b97a/zgpDzQZ4GZR5k=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FdvF79B6LcaPkvkokvemqAcW9heUClRDEJzE18CWa3sYkkCLf1lOW+RKqVDQaUS8fxJgl0kG1ekhP8wnDPOoiOrCI4g8clhhlNzfNgGoKr7lCoWuz4ALxxbMfySRqG40GRZFFDofcqGPlMRb1K+JpOe1XTVDmwX5tHnkq90A4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=DxPsPQqK; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="DxPsPQqK"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wjExReJmFT7Fk6tQCpDsuNqHznPyCQq1rV5Qr/miUcE=;
	b=DxPsPQqKPQ1BQ6XaxYQsOtsXEjqAV3ctemkqdXmxv1dEQcswpCurQbkhaW0/jaacAeC38SY9+
	+mwtKeogP3G43OonCqKpRdF0ZOQ4xLGvCsKCptyBdB9Y29CAx8GmBlTm1TVD5eNl89ptQhySXqf
	1XoR3+eJ7wVqEge7JudsSgc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fg58B5JnGzmVYX;
	Tue, 24 Mar 2026 17:58:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AC6340565;
	Tue, 24 Mar 2026 18:04:25 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 18:04:25 +0800
Received: from [10.67.120.218] (10.67.120.218) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Mar 2026 18:04:24 +0800
Subject: Re: [PATCH] ACPI: APEI: Handle repeated SEA error interrupts storm
 scenarios
To: Shuai Xue <xueshuai@linux.alibaba.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
References: <20251030071321.2763224-1-hejunhao3@h-partners.com>
 <CAJZ5v0h=QtcT7zhZEgrTjUk7EAk2OfbGG6BoEEv-3toKODMXQA@mail.gmail.com>
 <bf42a19d-0f5d-48d8-91f5-febb8bfd06d3@linux.alibaba.com>
 <9817f221-5b5f-7c25-ab94-cb04a854553a@h-partners.com>
 <70b85b7c-5107-4f79-abf7-3cc5b7e1438d@linux.alibaba.com>
CC: <bp@alien8.de>, <guohanjun@huawei.com>, <mchehab@kernel.org>,
	<jarkko@kernel.org>, <yazen.ghannam@amd.com>, <jane.chu@oracle.com>,
	<lenb@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<shiju.jose@huawei.com>, <tanxiaofei@huawei.com>, Junhao He
	<hejunhao3@h-partners.com>, Linuxarm <linuxarm@huawei.com>
From: hejunhao <hejunhao3@h-partners.com>
Message-ID: <ea31b6d3-fae5-ab5c-c10c-ed6901296498@h-partners.com>
Date: Tue, 24 Mar 2026 18:04:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70b85b7c-5107-4f79-abf7-3cc5b7e1438d@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn500004.china.huawei.com (7.202.194.145)

Hi shuai xue,


On 2026/3/3 22:42, Shuai Xue wrote:
> Hi, junhao,
>
> On 2/27/26 8:12 PM, hejunhao wrote:
>>
>>
>> On 2025/11/4 9:32, Shuai Xue wrote:
>>>
>>>
>>> 在 2025/11/4 00:19, Rafael J. Wysocki 写道:
>>>> On Thu, Oct 30, 2025 at 8:13 AM Junhao He <hejunhao3@h-partners.com> wrote:
>>>>>
>>>>> The do_sea() function defaults to using firmware-first mode, if supported.
>>>>> It invoke acpi/apei/ghes ghes_notify_sea() to report and handling the SEA
>>>>> error, The GHES uses a buffer to cache the most recent 4 kinds of SEA
>>>>> errors. If the same kind SEA error continues to occur, GHES will skip to
>>>>> reporting this SEA error and will not add it to the "ghes_estatus_llist"
>>>>> list until the cache times out after 10 seconds, at which point the SEA
>>>>> error will be reprocessed.
>>>>>
>>>>> The GHES invoke ghes_proc_in_irq() to handle the SEA error, which
>>>>> ultimately executes memory_failure() to process the page with hardware
>>>>> memory corruption. If the same SEA error appears multiple times
>>>>> consecutively, it indicates that the previous handling was incomplete or
>>>>> unable to resolve the fault. In such cases, it is more appropriate to
>>>>> return a failure when encountering the same error again, and then proceed
>>>>> to arm64_do_kernel_sea for further processing.
>
> There is no such function in the arm64 tree. If apei_claim_sea() returns

Sorry for the mistake in the commit message. The function arm64_do_kernel_sea() should
be arm64_notify_die().

> an error, the actual fallback path in do_sea() is arm64_notify_die(),
> which sends SIGBUS?
>

If apei_claim_sea() returns an error, arm64_notify_die() will call arm64_force_sig_fault(inf->sig /* SIGBUS */, , , ),
followed by force_sig_fault(SIGBUS, , ) to force the process to receive the SIGBUS signal.

>>>>>
>>>>> When hardware memory corruption occurs, a memory error interrupt is
>>>>> triggered. If the kernel accesses this erroneous data, it will trigger
>>>>> the SEA error exception handler. All such handlers will call
>>>>> memory_failure() to handle the faulty page.
>>>>>
>>>>> If a memory error interrupt occurs first, followed by an SEA error
>>>>> interrupt, the faulty page is first marked as poisoned by the memory error
>>>>> interrupt process, and then the SEA error interrupt handling process will
>>>>> send a SIGBUS signal to the process accessing the poisoned page.
>>>>>
>>>>> However, if the SEA interrupt is reported first, the following exceptional
>>>>> scenario occurs:
>>>>>
>>>>> When a user process directly requests and accesses a page with hardware
>>>>> memory corruption via mmap (such as with devmem), the page containing this
>>>>> address may still be in a free buddy state in the kernel. At this point,
>>>>> the page is marked as "poisoned" during the SEA claim memory_failure().
>>>>> However, since the process does not request the page through the kernel's
>>>>> MMU, the kernel cannot send SIGBUS signal to the processes. And the memory
>>>>> error interrupt handling process not support send SIGBUS signal. As a
>>>>> result, these processes continues to access the faulty page, causing
>>>>> repeated entries into the SEA exception handler. At this time, it lead to
>>>>> an SEA error interrupt storm.
>
> In such case, the user process which accessing the poisoned page will be killed
> by memory_fauilre?
>
> // memory_failure():
>
>     if (TestSetPageHWPoison(p)) {
>         res = -EHWPOISON;
>         if (flags & MF_ACTION_REQUIRED)
>             res = kill_accessing_process(current, pfn, flags);
>         if (flags & MF_COUNT_INCREASED)
>             put_page(p);
>         action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>         goto unlock_mutex;
>     }
>
> I think this problem has already been fixed by commit 2e6053fea379 ("mm/memory-failure:
> fix infinite UCE for VM_PFNMAP pfn").
>
> The root cause is that walk_page_range() skips VM_PFNMAP vmas by default when
> no .test_walk callback is set, so kill_accessing_process() returns 0 for a
> devmem-style mapping (remap_pfn_range, VM_PFNMAP), making the caller believe
> the UCE was handled properly while the process was never actually killed.
>
> Did you try the lastest kernel version?
>

I retested this issue on the kernel v7.0.0-rc4 with the following debug patch and was still able to reproduce it.


@@ -1365,8 +1365,11 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
        ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);

        /* This error has been reported before, don't process it again. */
-       if (ghes_estatus_cached(estatus))
+       if (ghes_estatus_cached(estatus)) {
+               pr_info("This error has been reported before, don't process it again.\n");
                goto no_work;
+       }

the test log Only some debug logs are retained here.

[2026/3/24 14:51:58.199] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32 0
[2026/3/24 14:51:58.369] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32
[2026/3/24 14:51:58.458] [  130.558038][   C40] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
[2026/3/24 14:51:58.459] [  130.572517][   C40] {1}[Hardware Error]: event severity: recoverable
[2026/3/24 14:51:58.459] [  130.578861][   C40] {1}[Hardware Error]:  Error 0, type: recoverable
[2026/3/24 14:51:58.459] [  130.585203][   C40] {1}[Hardware Error]:   section_type: ARM processor error
[2026/3/24 14:51:58.459] [  130.592238][   C40] {1}[Hardware Error]:   MIDR: 0x0000000000000000
[2026/3/24 14:51:58.459] [  130.598492][   C40] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081010400
[2026/3/24 14:51:58.459] [  130.607871][   C40] {1}[Hardware Error]:   error affinity level: 0
[2026/3/24 14:51:58.459] [  130.614038][   C40] {1}[Hardware Error]:   running state: 0x1
[2026/3/24 14:51:58.459] [  130.619770][   C40] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[2026/3/24 14:51:58.459] [  130.627673][   C40] {1}[Hardware Error]:   Error info structure 0:
[2026/3/24 14:51:58.459] [  130.633839][   C40] {1}[Hardware Error]:   num errors: 1
[2026/3/24 14:51:58.459] [  130.639137][   C40] {1}[Hardware Error]:    error_type: 0, cache error
[2026/3/24 14:51:58.459] [  130.645652][   C40] {1}[Hardware Error]:    error_info: 0x0000000020400014
[2026/3/24 14:51:58.459] [  130.652514][   C40] {1}[Hardware Error]:     cache level: 1
[2026/3/24 14:51:58.551] [  130.658073][   C40] {1}[Hardware Error]:     the error has not been corrected
[2026/3/24 14:51:58.551] [  130.665194][   C40] {1}[Hardware Error]:    physical fault address: 0x0000001351811800
[2026/3/24 14:51:58.551] [  130.673097][   C40] {1}[Hardware Error]:   Vendor specific error info has 48 bytes:
[2026/3/24 14:51:58.551] [  130.680744][   C40] {1}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:51:58.551] [  130.690471][   C40] {1}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:51:58.552] [  130.700198][   C40] {1}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:51:58.552] [  130.710083][ T9767] Memory failure: 0x1351811: recovery action for free buddy page: Recovered
[2026/3/24 14:51:58.638] [  130.790952][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:51:58.903] [  131.046994][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:51:58.991] [  131.132360][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:51:59.969] [  132.071431][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:00.860] [  133.010255][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:01.927] [  134.034746][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:02.906] [  135.058973][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:03.971] [  136.083213][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:04.860] [  137.021956][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:06.018] [  138.131460][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:06.905] [  139.070280][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:07.886] [  140.009147][   C40] This error has been reported before, don't process it again.
[2026/3/24 14:52:08.596] [  140.777368][   C40] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
[2026/3/24 14:52:08.683] [  140.791921][   C40] {2}[Hardware Error]: event severity: recoverable
[2026/3/24 14:52:08.683] [  140.798263][   C40] {2}[Hardware Error]:  Error 0, type: recoverable
[2026/3/24 14:52:08.683] [  140.804606][   C40] {2}[Hardware Error]:   section_type: ARM processor error
[2026/3/24 14:52:08.683] [  140.811641][   C40] {2}[Hardware Error]:   MIDR: 0x0000000000000000
[2026/3/24 14:52:08.684] [  140.817895][   C40] {2}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081010400
[2026/3/24 14:52:08.684] [  140.827274][   C40] {2}[Hardware Error]:   error affinity level: 0
[2026/3/24 14:52:08.684] [  140.833440][   C40] {2}[Hardware Error]:   running state: 0x1
[2026/3/24 14:52:08.684] [  140.839173][   C40] {2}[Hardware Error]:   Power State Coordination Interface state: 0
[2026/3/24 14:52:08.684] [  140.847076][   C40] {2}[Hardware Error]:   Error info structure 0:
[2026/3/24 14:52:08.684] [  140.853241][   C40] {2}[Hardware Error]:   num errors: 1
[2026/3/24 14:52:08.684] [  140.858540][   C40] {2}[Hardware Error]:    error_type: 0, cache error
[2026/3/24 14:52:08.684] [  140.865055][   C40] {2}[Hardware Error]:    error_info: 0x0000000020400014
[2026/3/24 14:52:08.684] [  140.871917][   C40] {2}[Hardware Error]:     cache level: 1
[2026/3/24 14:52:08.684] [  140.877475][   C40] {2}[Hardware Error]:     the error has not been corrected
[2026/3/24 14:52:08.764] [  140.884596][   C40] {2}[Hardware Error]:    physical fault address: 0x0000001351811800
[2026/3/24 14:52:08.764] [  140.892499][   C40] {2}[Hardware Error]:   Vendor specific error info has 48 bytes:
[2026/3/24 14:52:08.766] [  140.900145][   C40] {2}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:52:08.767] [  140.909872][   C40] {2}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:52:08.767] [  140.919598][   C40] {2}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
[2026/3/24 14:52:08.768] [  140.929346][ T9767] Memory failure: 0x1351811: already hardware poisoned
[2026/3/24 14:52:08.768] [  140.936072][ T9767] Memory failure: 0x1351811: Sending SIGBUS to busybox:9767 due to hardware memory corruption


Apply the patch:

@@ -1365,8 +1365,11 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
        ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);

        /* This error has been reported before, don't process it again. */
-       if (ghes_estatus_cached(estatus))
+       if (ghes_estatus_cached(estatus)) {
+               pr_info("This error has been reported before, don't process it again.\n");
+               rc = -ECANCELED;
                goto no_work;
+       }

[2026/3/24 16:45:40.084] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32 0
[2026/3/24 16:45:40.272] [root@localhost ~]# taskset -c 40 busybox devmem 0x1351811824 32
[2026/3/24 16:45:40.362] [  112.279324][   C40] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
[2026/3/24 16:45:40.362] [  112.293797][   C40] {1}[Hardware Error]: event severity: recoverable
[2026/3/24 16:45:40.362] [  112.300139][   C40] {1}[Hardware Error]:  Error 0, type: recoverable
[2026/3/24 16:45:40.363] [  112.306481][   C40] {1}[Hardware Error]:   section_type: ARM processor error
[2026/3/24 16:45:40.363] [  112.313516][   C40] {1}[Hardware Error]:   MIDR: 0x0000000000000000
[2026/3/24 16:45:40.363] [  112.319771][   C40] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081010400
[2026/3/24 16:45:40.363] [  112.329151][   C40] {1}[Hardware Error]:   error affinity level: 0
[2026/3/24 16:45:40.363] [  112.335317][   C40] {1}[Hardware Error]:   running state: 0x1
[2026/3/24 16:45:40.363] [  112.341049][   C40] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[2026/3/24 16:45:40.363] [  112.348953][   C40] {1}[Hardware Error]:   Error info structure 0:
[2026/3/24 16:45:40.363] [  112.355119][   C40] {1}[Hardware Error]:   num errors: 1
[2026/3/24 16:45:40.363] [  112.360418][   C40] {1}[Hardware Error]:    error_type: 0, cache error
[2026/3/24 16:45:40.363] [  112.366932][   C40] {1}[Hardware Error]:    error_info: 0x0000000020400014
[2026/3/24 16:45:40.363] [  112.373795][   C40] {1}[Hardware Error]:     cache level: 1
[2026/3/24 16:45:40.453] [  112.379354][   C40] {1}[Hardware Error]:     the error has not been corrected
[2026/3/24 16:45:40.453] [  112.386475][   C40] {1}[Hardware Error]:    physical fault address: 0x0000001351811800
[2026/3/24 16:45:40.453] [  112.394378][   C40] {1}[Hardware Error]:   Vendor specific error info has 48 bytes:
[2026/3/24 16:45:40.453] [  112.402027][   C40] {1}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
[2026/3/24 16:45:40.453] [  112.411754][   C40] {1}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
[2026/3/24 16:45:40.453] [  112.421480][   C40] {1}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
[2026/3/24 16:45:40.453] [  112.431639][ T9769] Memory failure: 0x1351811: recovery action for free buddy page: Recovered
[2026/3/24 16:45:40.531] [  112.512520][   C40] This error has been reported before, don't process it again.
[2026/3/24 16:45:40.757] Bus error (core dumped)

>>>>>
>>>>> Fixes this by returning a failure when encountering the same error again.
>>>>>
>>>>> The following error logs is explained using the devmem process:
>>>>>     NOTICE:  SEA Handle
>>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>>     NOTICE:  Hest Set GenericError Data
>>>>>     [ 1419.542401][    C1] {57}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>>     [ 1419.551435][    C1] {57}[Hardware Error]: event severity: recoverable
>>>>>     [ 1419.557865][    C1] {57}[Hardware Error]:  Error 0, type: recoverable
>>>>>     [ 1419.564295][    C1] {57}[Hardware Error]:   section_type: ARM processor error
>>>>>     [ 1419.571421][    C1] {57}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>>     [ 1419.571434][    C1] {57}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
>>>>>     [ 1419.586813][    C1] {57}[Hardware Error]:   error affinity level: 0
>>>>>     [ 1419.586821][    C1] {57}[Hardware Error]:   running state: 0x1
>>>>>     [ 1419.602714][    C1] {57}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>>     [ 1419.602724][    C1] {57}[Hardware Error]:   Error info structure 0:
>>>>>     [ 1419.614797][    C1] {57}[Hardware Error]:   num errors: 1
>>>>>     [ 1419.614804][    C1] {57}[Hardware Error]:    error_type: 0, cache error
>>>>>     [ 1419.629226][    C1] {57}[Hardware Error]:    error_info: 0x0000000020400014
>>>>>     [ 1419.629234][    C1] {57}[Hardware Error]:     cache level: 1
>>>>>     [ 1419.642006][    C1] {57}[Hardware Error]:     the error has not been corrected
>>>>>     [ 1419.642013][    C1] {57}[Hardware Error]:    physical fault address: 0x0000001000093c00
>>>>>     [ 1419.654001][    C1] {57}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>>     [ 1419.654014][    C1] {57}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1419.670685][    C1] {57}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1419.670692][    C1] {57}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1419.783606][T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>>>>>     [ 1419.919580][ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory (node:0 card:1 module:71 bank:7 row:0 col:0 page:0x1000093 offset:0xc00 grain:1 - APEI location: node:0 card:257 module:71 bank:7 row:0 col:0)
>>>>>     NOTICE:  SEA Handle
>>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>>     NOTICE:  Hest Set GenericError Data
>>>>>     NOTICE:  SEA Handle
>>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>>     NOTICE:  Hest Set GenericError Data
>>>>>     ...
>>>>>     ...        ---> Hapend SEA error interrupt storm
>>>>>     ...
>>>>>     NOTICE:  SEA Handle
>>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>>     NOTICE:  Hest Set GenericError Data
>>>>>     [ 1429.818080][ T9955] Memory failure: 0x1000093: already hardware poisoned
>>>>>     [ 1429.825760][    C1] ghes_print_estatus: 1 callbacks suppressed
>>>>>     [ 1429.825763][    C1] {59}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>>     [ 1429.843731][    C1] {59}[Hardware Error]: event severity: recoverable
>>>>>     [ 1429.861800][    C1] {59}[Hardware Error]:  Error 0, type: recoverable
>>>>>     [ 1429.874658][    C1] {59}[Hardware Error]:   section_type: ARM processor error
>>>>>     [ 1429.887516][    C1] {59}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>>     [ 1429.901159][    C1] {59}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
>>>>>     [ 1429.901166][    C1] {59}[Hardware Error]:   error affinity level: 0
>>>>>     [ 1429.914896][    C1] {59}[Hardware Error]:   running state: 0x1
>>>>>     [ 1429.914903][    C1] {59}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>>     [ 1429.933319][    C1] {59}[Hardware Error]:   Error info structure 0:
>>>>>     [ 1429.946261][    C1] {59}[Hardware Error]:   num errors: 1
>>>>>     [ 1429.946269][    C1] {59}[Hardware Error]:    error_type: 0, cache error
>>>>>     [ 1429.970847][    C1] {59}[Hardware Error]:    error_info: 0x0000000020400014
>>>>>     [ 1429.970854][    C1] {59}[Hardware Error]:     cache level: 1
>>>>>     [ 1429.988406][    C1] {59}[Hardware Error]:     the error has not been corrected
>>>>>     [ 1430.013419][    C1] {59}[Hardware Error]:    physical fault address: 0x0000001000093c00
>>>>>     [ 1430.013425][    C1] {59}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>>     [ 1430.025424][    C1] {59}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1430.053736][    C1] {59}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1430.066341][    C1] {59}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>>     [ 1430.294255][T54990] Memory failure: 0x1000093: already hardware poisoned
>>>>>     [ 1430.305518][T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
>>>>>
>>>>> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
>>>>> ---
>>>>>    drivers/acpi/apei/ghes.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>>> index 005de10d80c3..eebda39bfc30 100644
>>>>> --- a/drivers/acpi/apei/ghes.c
>>>>> +++ b/drivers/acpi/apei/ghes.c
>>>>> @@ -1343,8 +1343,10 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>>>>           ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>>>>>
>>>>>           /* This error has been reported before, don't process it again. */
>>>>> -       if (ghes_estatus_cached(estatus))
>>>>> +       if (ghes_estatus_cached(estatus)) {
>>>>> +               rc = -ECANCELED;
>>>>>                   goto no_work;
>>>>> +       }
>>>>>
>>>>>           llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>>>>>
>>>>> -- 
>>>>
>>>> This needs a response from the APEI reviewers as per MAINTAINERS, thanks!
>>>
>>> Hi, Rafael and Junhao,
>>>
>>> Sorry for late response, I try to reproduce the issue, it seems that
>>> EINJ systems broken in 6.18.0-rc1+.
>>>
>>> [ 3950.741186] CPU: 36 UID: 0 PID: 74112 Comm: einj_mem_uc Tainted: G            E       6.18.0-rc1+ #227 PREEMPT(none)
>>> [ 3950.751749] Tainted: [E]=UNSIGNED_MODULE
>>> [ 3950.755655] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 1.91 07/29/2022
>>> [ 3950.763797] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [ 3950.770729] pc : acpi_os_write_memory+0x108/0x150
>>> [ 3950.775419] lr : acpi_os_write_memory+0x28/0x150
>>> [ 3950.780017] sp : ffff800093fbba40
>>> [ 3950.783319] x29: ffff800093fbba40 x28: 0000000000000000 x27: 0000000000000000
>>> [ 3950.790425] x26: 0000000000000002 x25: ffffffffffffffff x24: 000000403f20e400
>>> [ 3950.797530] x23: 0000000000000000 x22: 0000000000000008 x21: 000000000000ffff
>>> [ 3950.804635] x20: 0000000000000040 x19: 000000002f7d0018 x18: 0000000000000000
>>> [ 3950.811741] x17: 0000000000000000 x16: ffffae52d36ae5d0 x15: 000000001ba8e890
>>> [ 3950.818847] x14: 0000000000000000 x13: 0000000000000000 x12: 0000005fffffffff
>>> [ 3950.825952] x11: 0000000000000001 x10: ffff00400d761b90 x9 : ffffae52d365b198
>>> [ 3950.833058] x8 : 0000280000000000 x7 : 000000002f7d0018 x6 : ffffae52d5198548
>>> [ 3950.840164] x5 : 000000002f7d1000 x4 : 0000000000000018 x3 : ffff204016735060
>>> [ 3950.847269] x2 : 0000000000000040 x1 : 0000000000000000 x0 : ffff8000845bd018
>>> [ 3950.854376] Call trace:
>>> [ 3950.856814]  acpi_os_write_memory+0x108/0x150 (P)
>>> [ 3950.861500]  apei_write+0xb4/0xd0
>>> [ 3950.864806]  apei_exec_write_register_value+0x88/0xc0
>>> [ 3950.869838]  __apei_exec_run+0xac/0x120
>>> [ 3950.873659]  __einj_error_inject+0x88/0x408 [einj]
>>> [ 3950.878434]  einj_error_inject+0x168/0x1f0 [einj]
>>> [ 3950.883120]  error_inject_set+0x48/0x60 [einj]
>>> [ 3950.887548]  simple_attr_write_xsigned.constprop.0.isra.0+0x14c/0x1d0
>>> [ 3950.893964]  simple_attr_write+0x1c/0x30
>>> [ 3950.897873]  debugfs_attr_write+0x54/0xa0
>>> [ 3950.901870]  vfs_write+0xc4/0x240
>>> [ 3950.905173]  ksys_write+0x70/0x108
>>> [ 3950.908562]  __arm64_sys_write+0x20/0x30
>>> [ 3950.912471]  invoke_syscall+0x4c/0x110
>>> [ 3950.916207]  el0_svc_common.constprop.0+0x44/0xe8
>>> [ 3950.920893]  do_el0_svc+0x20/0x30
>>> [ 3950.924194]  el0_svc+0x38/0x160
>>> [ 3950.927324]  el0t_64_sync_handler+0x98/0xe0
>>> [ 3950.931491]  el0t_64_sync+0x184/0x188
>>> [ 3950.935140] Code: 14000006 7101029f 54000221 d50332bf (f9000015)
>>> [ 3950.941210] ---[ end trace 0000000000000000 ]---
>>> [ 3950.945807] Kernel panic - not syncing: Oops: Fatal exception
>>>
>>> We need to fix it first.
>>
>> Hi shuai xue,
>>
>> Sorry for my late reply. Thank you for the review.
>> To clarify the issue:
>> This problem was introduced in v6.18-rc1 via a suspicious ARM64
>> memory mapping change [1]. I can reproduce the crash consistently
>> using the v6.18-rc1 kernel with this patch applied.
>>
>> Crucially, the crash disappears when the change is reverted — error
>> injection completes successfully without any kernel panic or oops.
>> This confirms that the ARM64 memory mapping change is the root cause.
>>
>> As noted in the original report, the change was reverted in v6.19-rc1, and
>> subsequent kernels (including v6.19-rc1 and later) are stable and do not
>> exhibit this problem.
>>
>> reproduce  logs:
>> [  216.347073] Unable to handle kernel write to read-only memory at virtual address ffff800084825018
>> ...
>> [  216.475949] CPU: 75 UID: 0 PID: 11477 Comm: sh Kdump: loaded Not tainted 6.18.0-rc1+ #60 PREEMPT
>> [  216.486561] Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 1.91 07/29/2022
>> [  216.587297] Call trace:
>> [  216.589904]  acpi_os_write_memory+0x188/0x1c8 (P)
>> [  216.594763]  apei_write+0xcc/0xe8
>> [  216.598238]  apei_exec_write_register_value+0x90/0xd0
>> [  216.603437]  __apei_exec_run+0xb0/0x128
>> [  216.607420]  __einj_error_inject+0xac/0x450
>> [  216.611750]  einj_error_inject+0x19c/0x220
>> [  216.615988]  error_inject_set+0x4c/0x68
>> [  216.619962]  simple_attr_write_xsigned.constprop.0.isra.0+0xe8/0x1b0
>> [  216.626445]  simple_attr_write+0x20/0x38
>> [  216.630502]  debugfs_attr_write+0x58/0xa8
>> [  216.634643]  vfs_write+0xdc/0x408
>> [  216.638088]  ksys_write+0x78/0x118
>> [  216.641610]  __arm64_sys_write+0x24/0x38
>> [  216.645648]  invoke_syscall+0x50/0x120
>> [  216.649510]  el0_svc_common.constprop.0+0xc8/0xf0
>> [  216.654318]  do_el0_svc+0x24/0x38
>> [  216.657742]  el0_svc+0x38/0x150
>> [  216.660996]  el0t_64_sync_handler+0xa0/0xe8
>> [  216.665286]  el0t_64_sync+0x1ac/0x1b0
>> [  216.669054] Code: d65f03c0 710102ff 540001e1 d50332bf (f9000295)
>> [  216.675244] ---[ end trace 0000000000000000 ]---
>>
>> [1] https://lore.kernel.org/all/20251121224611.07efa95a@foz.lan/
>>
>> Best regards,
>> Junhao.
>
> Thanks for clarify the issue.
>
> Thanks.
> Shuai
>
> .
>

