Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774733859F3;
	Tue, 21 Apr 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763117; cv=none; b=UuiCfedyfZ2a+P6h1zRDB1w8rh9F/lK3kEO5Gr316tFfUsrxmW4JoYV4xcYXNaVxHMxGuL0Vy3d8V18yGf/20P7e1ukiZ+SMThrRQL5hS3DqHNBaxXhPEo0T8u0MvurNkjTZMIEBQn13+JtSCeBtUNEiNFwPkbP8ayipTVUKDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763117; c=relaxed/simple;
	bh=tJBQyXHnQn9klIpcTcvvMyVpAPSnlRbDUcZ7r1NOyR0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pIl3ALPDQCB/hqVUloggzQE1u183/In/EI/zBUREuGn5AOFF86VkhIU4YA34/HstD5RWpLEPinT5+V5YZixDsXTk2AQMk8B02mJTDNEN7WrmBq3WZ4KUjv5zSrBTutgN6fenyJbTRw0sWIaNjvWF8f7Eqc0Mz4ngpOnZo/Wmj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Qaj8jFha; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Qaj8jFha"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pWbjYiWVPEVqHky0jkAvhpEA7GLMbv2D6J2rXjOjo0Q=;
	b=Qaj8jFhakGb9fUt1bL9RbOIAolX7LR9KcVJf9gEhqIL7/8QMTUDtpVx+7htuLBpLcXMvPt0eM
	BUn2UyXeBkNM3vcs8okLD57HR3fD2zDS49R+3tPQuZWqVPEYff4Lnhu4cdHwAHDq7ACmUErhVeD
	r9w/azxx2yA0fwXSGMzl2ds=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g0Gp032snzmV6X;
	Tue, 21 Apr 2026 17:12:08 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E1CF940565;
	Tue, 21 Apr 2026 17:18:31 +0800 (CST)
Received: from [10.174.177.15] (10.174.177.15) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 21 Apr 2026 17:18:30 +0800
Message-ID: <bdf9828c-a6e2-46be-aa39-9d222094d565@huawei.com>
Date: Tue, 21 Apr 2026 17:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: APEI: check return value of task_work_add to
 prevent memory leaks
To: <guohanjun@huawei.com>, <rafael@kernel.org>, <tony.luck@intel.com>,
	<bp@alien8.de>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <jonathan.cameron@huawei.com>, <jane.chu@oracle.com>,
	<jarkko@kernel.org>, <wangkefeng.wang@huawei.com>
References: <20260417065021.4067113-1-mawupeng1@huawei.com>
 <bb2139ba-a7ff-440c-641f-57229a8389b3@huawei.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <bb2139ba-a7ff-440c-641f-57229a8389b3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100016.china.huawei.com (7.202.194.10)



On 周二 2026-4-21 17:02, Hanjun Guo wrote:
> Hi Wupeng,
> 
> On 2026/4/17 14:50, Wupeng Ma wrote:
>> task_work_add() can fail with -ESRCH if the target task is exiting.
>> When it fails, the caller must handle the error and free any allocated
>> resources.
>>
>> ghes_do_memory_failure() allocates a twcb structure from ghes_estatus_pool
>> before calling task_work_add(). If task_work_add() fails, twcb is leaked.
>>
>> This can happen due to a race during task exit:
>>
>>    do_exit()
>>      exit_mm()           # current->mm cleared
>>      exit_task_work()    # task->task_works = &work_exited
>>
>> ghes_do_memory_failure() checks current->mm before allocating twcb,
>> but exit_task_work() may run before task_work_add() completes.  At that
>> point task->task_works == &work_exited, causing task_work_add() to fail.
> 
> There are multi places in the kernel to call task_work_add() without
> checking the return value, does this race only cause bug in
> ghes_do_memory_failure()?

Thanks for the review. 

We have analyzed all the called functions, and apart from this location, only
binder_deferred_fd_close has a potential resource leak issue upon failure.


> 
> Thanks
> Hanjun

