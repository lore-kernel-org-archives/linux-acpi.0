Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286CF3A3E7F;
	Tue, 21 Apr 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762157; cv=none; b=J5AMOHnQHPir5JBMOlbjHzxkLxDJCFw/uIQ9pNV2H3uPfBBIB3dwCzPHZJ4q4blX+pWDtcoIhmqW9uBy7aZnU1wtRUTVv+Fzdy2THUtvESERVpnzVsdFYE3Tw25RQS2bOEYyOtEn297G+zSRT+S6w4g4KaqXgr5W0R5UkfWrmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762157; c=relaxed/simple;
	bh=f2YjFxUIfOhbb5NkRgVbW+mts270N7mYVQgouJMEMf4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XSULGtXS6mIIqvYZo36eA6kxwxxgHTGokipTWCwkNeSBf6C77kcgmgR6EGIb/9/AR0y5BzpQ1YEe98uho/Nm1rISr6XQ0Nel1AbjU8KMbgRwLby0vL9WLthUfW58pzbgEde243BWYsC9xtBjc3ShKLHYuRKz8H9oQKjEcA0wmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JkWkmR2P; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JkWkmR2P"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fhD+1E2ZAOPbSN6MQDIuaqnEKbOo6hQ3zPMBLmbAmGw=;
	b=JkWkmR2PQagQ/PC8OGj0Mi4TjpXFPg86+bIPbUgV8tiixXDsY+c5FYDNwYeTYl1t/kz9DFAbu
	adEX5WNjAIFoc5AukMVrml9D6lnDMv62qDa1kB79ZpqLWpwZq3POwD7n4eE5jQJAqsiqz1TX2nb
	iKsp4aceeasmHFZue/ujL2A=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g0GRW337mzKm4w;
	Tue, 21 Apr 2026 16:56:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 518E640563;
	Tue, 21 Apr 2026 17:02:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 17:02:30 +0800
Subject: Re: [PATCH] ACPI: APEI: check return value of task_work_add to
 prevent memory leaks
To: Wupeng Ma <mawupeng1@huawei.com>, <rafael@kernel.org>,
	<tony.luck@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <lenb@kernel.org>,
	<jonathan.cameron@huawei.com>, <jane.chu@oracle.com>, <jarkko@kernel.org>,
	<wangkefeng.wang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20260417065021.4067113-1-mawupeng1@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bb2139ba-a7ff-440c-641f-57229a8389b3@huawei.com>
Date: Tue, 21 Apr 2026 17:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260417065021.4067113-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Wupeng,

On 2026/4/17 14:50, Wupeng Ma wrote:
> task_work_add() can fail with -ESRCH if the target task is exiting.
> When it fails, the caller must handle the error and free any allocated
> resources.
> 
> ghes_do_memory_failure() allocates a twcb structure from ghes_estatus_pool
> before calling task_work_add(). If task_work_add() fails, twcb is leaked.
> 
> This can happen due to a race during task exit:
> 
>    do_exit()
>      exit_mm()           # current->mm cleared
>      exit_task_work()    # task->task_works = &work_exited
> 
> ghes_do_memory_failure() checks current->mm before allocating twcb,
> but exit_task_work() may run before task_work_add() completes.  At that
> point task->task_works == &work_exited, causing task_work_add() to fail.

There are multi places in the kernel to call task_work_add() without
checking the return value, does this race only cause bug in
ghes_do_memory_failure()?

Thanks
Hanjun
