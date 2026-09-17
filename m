Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C6379C3E;
	Thu, 17 Sep 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611274; cv=none; b=JMGAdMUWUh5B74UfJGgOJRvNs/KDiH8EOKipudetXwOzV6KCmzu7JnPBj3jXYdieTnv3/GjZC4d3AjwIRDMnTIvKoaGMwiFCHiYLDJPlQd3J0VTCGxvoW6ZjfTPeJ2U49r7NlrmlKRM0EmGvHFLrl6jOiQTlGa4rSq7BOgp78ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611274; c=relaxed/simple;
	bh=GqxAlTZz0NqrzuMUZJ+b0UwuxHIMC/Nm/d2kNrr3NLY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Flqbfy4k6n0orz2eHgUhRUUr3okwUDFTpfJIEXw9wfUT7q7Z9HYqCmsI3BnOMkVgvT2U+i2N//qpX87IWtEx9LOT1flJZPOOKpT/qj/a15pgfsCH9KETNXn1jpq+h8DWI0oBt+YVx3Vkf0UqT7ERbC/RD6bCGdcrdKYFA7pbeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X1l3EFXC; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X1l3EFXC; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X1l3EFXC";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X1l3EFXC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IYRc1XP4apk0bziWvvCWjelPNrXlOohILCKMvg7fKR8=;
	b=X1l3EFXCPZi5re2DqWbcoupTkMTXFQvdAk/Fu4owIV1civSd2VpGzBINs5mWqquP541rKpv5U
	1P7wRmIg/Rq3a8lkBTHYs02sx7oruILy2KCCd8UcEx5iC3j6ww1SK4jmHWQCOCSRxZChszNtept
	Gd78nBy429mMKW4GDJ1yAOk=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hlfS51SNsz1BFt7;
	Thu, 17 Sep 2026 10:13:25 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IYRc1XP4apk0bziWvvCWjelPNrXlOohILCKMvg7fKR8=;
	b=X1l3EFXCPZi5re2DqWbcoupTkMTXFQvdAk/Fu4owIV1civSd2VpGzBINs5mWqquP541rKpv5U
	1P7wRmIg/Rq3a8lkBTHYs02sx7oruILy2KCCd8UcEx5iC3j6ww1SK4jmHWQCOCSRxZChszNtept
	Gd78nBy429mMKW4GDJ1yAOk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hlfCW5jJFzpStW;
	Thu, 17 Sep 2026 10:02:31 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E76440561;
	Thu, 17 Sep 2026 10:14:18 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 17 Sep 2026 10:14:16 +0800
Subject: Re: [PATCH v4 2/3] RAS: Fix out-of-bounds read when tracing arm_event
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
 <20260909112832.805314-3-liuwenliang@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6783acb8-61ef-3990-dfc2-1d2bad30d805@huawei.com>
Date: Thu, 17 Sep 2026 10:14:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260909112832.805314-3-liuwenliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemk200014.china.huawei.com (7.152.185.79)

On 2026/9/9 19:28, Abbott Liu wrote:
> The vsei_len < 0 error path did not verify the pei_len and ctx_len.
> When vsei_len is negative, section_length is too small to hold the
> full record, yet pei_len and ctx_len were derived from
> err_info_num/context_info_num and may describe regions beyond the
> (long)err .. err + section_length buffer. To prevent trace_arm_event
> from reading past the allocated record, sanitize the parameters:
> recalculate ctx_len and pei_len based on section_length, limit them,
> and set the corresponding pointers to NULL and lengths to 0 when
> there is no remaining space.
> 
> pei_len and ctx_len become s32 so that the recalculated lengths can
> be checked for negative values.
> 
> Fixes: 05954511b73e ("RAS: Report all ARM processor CPER information to userspace")
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> ---
>   drivers/ras/ras.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 2540538a16a8..085fe2d980e5 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -58,10 +58,10 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>   	struct cper_arm_err_info *err_info;
>   	struct cper_arm_ctx_info *ctx_info;
>   	u8 *ven_err_data;
> -	u32 ctx_len = 0;
> +	s32 ctx_len = 0;
>   	int n, sz, cpu;
>   	s32 vsei_len;
> -	u32 pei_len;
> +	s32 pei_len;
>   	u8 *pei_err, *ctx_err;
>   
>   	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
> @@ -87,14 +87,28 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>   		pr_warn(FW_BUG "section length is too small\n");
>   		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
>   		vsei_len = 0;
> +		ven_err_data = NULL;
> +
> +		ctx_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len);
> +		if (ctx_len < 0) {
> +			ctx_len = 0;
> +			ctx_err = NULL;
> +
> +			pei_len = err->section_length - sizeof(struct cper_sec_proc_arm);
> +			if (pei_len < 0) {
> +				pei_len = 0;
> +				pei_err = NULL;
> +			}
> +		}
> +	} else {
> +		ven_err_data = (u8 *)ctx_info;
>   	}
> -	ven_err_data = (u8 *)ctx_info;
>   
>   	cpu = GET_LOGICAL_INDEX(err->mpidr);
>   	if (cpu < 0)
>   		cpu = -1;
>   
> -	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
> +	trace_arm_event(err, pei_err, (u32)pei_len, ctx_err, (u32)ctx_len,
>   			ven_err_data, (u32)vsei_len, sev, cpu);
>   }

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
