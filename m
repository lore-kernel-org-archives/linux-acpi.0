Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BF282F1F;
	Wed, 29 Apr 2026 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450593; cv=none; b=GJ/dooKlPYSevjoC5RTzFagiylp2k1U6wNmLV4mbBuHRNm9CunrQAtKk1wW1hXbPmvKXkarndOi4LU+mR04pxpvd49R3YgvrwJlhJ4MMDTzZ8Oi3lP4PynCZ7M08kgT8EAvrMIlpVIepWgnpZbo6OjQ8mWO5A5QvnN8HV4NhSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450593; c=relaxed/simple;
	bh=gryjn78eMUF+zOCTpZJjDS/stCUXEUz6BV2iTpCgtYo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NFMfgrX2yO03lAiBBiC/54PXmc1fxKtU/Efc8yIHiRS65d7eqH5L/1tRY8MAWPKBND5E8hNQ+Zn0l1Di+oRd3BAOQTwtSPg7OdpGpK1TcX8Bh5T7UBCY+yRsllmyvX/fs0/jOyxjXcAuokEi/f2pLyQdZvqzmyhd40ZZjmVjVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JJ1Iwtjm; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JJ1Iwtjm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Yv839y2XHhgI0Jh2EHSKtNcKxrMlaQAU1dnI5wAnyBg=;
	b=JJ1IwtjmHel1QgOPzhlePlVb0wFw/mrqbjACkZE9y4qFSattaqrJKoImZUotkp1smKbzb5Tir
	kI2QQ2Cvfvvh+gAu83lubCxF3CgVmWs/aaB6fcRp0jAyAIhn/Y8G4eLAF5GhmrfPum3Y5Oace0t
	SGB8Db10ms/ydvjLmQn4+C8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g592d1gnyzLlYv;
	Wed, 29 Apr 2026 16:10:01 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 58E3940539;
	Wed, 29 Apr 2026 16:16:27 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Apr 2026 16:16:26 +0800
Subject: Re: [PATCH] ACPI: APEI: check return value of task_work_add to
 prevent memory leaks
To: mawupeng <mawupeng1@huawei.com>, <rafael@kernel.org>,
	<tony.luck@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <lenb@kernel.org>,
	<jonathan.cameron@huawei.com>, <jane.chu@oracle.com>, <jarkko@kernel.org>,
	<wangkefeng.wang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20260417065021.4067113-1-mawupeng1@huawei.com>
 <bb2139ba-a7ff-440c-641f-57229a8389b3@huawei.com>
 <bdf9828c-a6e2-46be-aa39-9d222094d565@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e0117700-e635-2572-10c3-67c8fe1687a2@huawei.com>
Date: Wed, 29 Apr 2026 16:16:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bdf9828c-a6e2-46be-aa39-9d222094d565@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/4/21 17:18, mawupeng wrote:
> 
> 
> On 周二 2026-4-21 17:02, Hanjun Guo wrote:
>> Hi Wupeng,
>>
>> On 2026/4/17 14:50, Wupeng Ma wrote:
>>> task_work_add() can fail with -ESRCH if the target task is exiting.
>>> When it fails, the caller must handle the error and free any allocated
>>> resources.
>>>
>>> ghes_do_memory_failure() allocates a twcb structure from ghes_estatus_pool
>>> before calling task_work_add(). If task_work_add() fails, twcb is leaked.
>>>
>>> This can happen due to a race during task exit:
>>>
>>>     do_exit()
>>>       exit_mm()           # current->mm cleared
>>>       exit_task_work()    # task->task_works = &work_exited
>>>
>>> ghes_do_memory_failure() checks current->mm before allocating twcb,
>>> but exit_task_work() may run before task_work_add() completes.  At that
>>> point task->task_works == &work_exited, causing task_work_add() to fail.
>>
>> There are multi places in the kernel to call task_work_add() without
>> checking the return value, does this race only cause bug in
>> ghes_do_memory_failure()?
> 
> Thanks for the review.
> 
> We have analyzed all the called functions, and apart from this location, only
> binder_deferred_fd_close has a potential resource leak issue upon failure.

I think this is a real bugfix.

Would you mind explaining the race in this way in the commit log,

    CPU0                   CPU1

do_exit()               xxx

to explicitly show the problem?

Thanks
Hanjun
	
