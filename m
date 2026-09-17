Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCD351C2E;
	Thu, 17 Sep 2026 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611207; cv=none; b=qnArnxgCAQoxTYZSWo+z7zHQeoEIZ8do0mG4SwuIjFb73mlRlmhBM0fTNs6sTPSmJHKqi+rtC22LE+greFzBnFfUsmms488j42lH484guO2R+WAz70XlcEsDK13D0V0Lz8dKEFaC+1nNGrXT+D1nVZ8gTbCjEaQ64cfOoiipWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611207; c=relaxed/simple;
	bh=Ito34hIZ5NPw9kRJ6XsglDhkv2eNuqKtvpYi3myN748=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HwUIynKRwY51AN33Ol++SC1Q4wDjBjS8BjRbpaeIQtYG1L24wpwadk8gMMugqoWqtreU9kfUZAoWfOLkFoyy6lYayG0NdjN/mxHDJ+mbAvHRBNQp1XE4xHX2HmiXy6wWPoD/mTbSyl7GU1W11qRe+TJk6V5aG8ec8hoVjAiveJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=u6a9FiNd; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="u6a9FiNd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NY/KaMce+VjwVt0dOR8ch7NEguPF4WSe3KMxe/KFxiI=;
	b=u6a9FiNdZ6v2gLFp7ofUcRzMJ5gMtkpaKpnr32U9lXNn0lGb/zM+n9vbfzS1BdqVqhaToZS0e
	F3EcZqb1AY1CXT8bNb/1sid9A0qp0OrB99RRCJYMlhe5UR6UDvtgoEY7g5SU9/oCy0pRLOLiw0M
	07kYSQHr/yvbAU0iEmS0Gwc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hlfC40zL1z12LHk;
	Thu, 17 Sep 2026 10:02:08 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id DB7F2203C1;
	Thu, 17 Sep 2026 10:13:15 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 10:13:13 +0800
Subject: Re: [PATCH v4 1/3] RAS: Fix inverted context info bounds check in ARM
 processor errors
To: Abbott Liu <liuwenliang@huawei.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <ardb@kernel.org>, <mchehab+huawei@kernel.org>,
	<rafael.j.wysocki@intel.com>, <jic23@kernel.org>,
	<jason@os.amperecomputing.com>, <danielf@os.amperecomputing.com>,
	<luoshengwei@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangzhuohao1@huawei.com>, <douzhaolei@huawei.com>,
	<zouyipeng@huawei.com>, <wangbing6@huawei.com>, <nixiaoming@huawei.com>, ACPI
 Devel Maling List <linux-acpi@vger.kernel.org>
References: <20260909112832.805314-1-liuwenliang@huawei.com>
 <20260909112832.805314-2-liuwenliang@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <46b53a0e-b2f8-d179-113d-0b7030e78058@huawei.com>
Date: Thu, 17 Sep 2026 10:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260909112832.805314-2-liuwenliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk200014.china.huawei.com (7.152.185.79)

On 2026/9/9 19:28, Abbott Liu wrote:
> Commit 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past
> allocated memory") added bounds checks for malformed ARM processor
> error records but contained a bug:
> 
>    In log_arm_hw_error(), the ctx_info bounds check is inverted. The
>    condition "sz + (long)ctx_info - (long)err >= err->section_length"
>    adds ctx_info->size when the context header is already past the end
>    of the section instead of when it is within bounds. So change the
>    comparison to <=.
> 
> Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> ---
>   drivers/ras/ras.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 03df3db62334..2540538a16a8 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -74,7 +74,7 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>   	for (n = 0; n < err->context_info_num; n++) {
>   		sz = sizeof(struct cper_arm_ctx_info);
>   
> -		if (sz + (long)ctx_info - (long)err >= err->section_length)
> +		if (sz + (long)ctx_info - (long)err <= err->section_length)
>   			sz += ctx_info->size;
>   
>   		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> 

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
