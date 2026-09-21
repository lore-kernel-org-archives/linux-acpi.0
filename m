Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76C33A9E8;
	Mon, 21 Sep 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983685; cv=none; b=YGGnj0TMOAESCwbLpwyvb52UmlUjQe9yfBC/p3hbJRB+0Z2HV2QfwktUMXPgQJMzUkWpP9KLplxIw2TI+LLm/LtBGhyrrxXEUHJ9Az1A866OifRUZehyDDjSbNwIsw9wywLKzeScJ1tfOD8mPLT8UvUlJo4xp5zrJQSb6HE6i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983685; c=relaxed/simple;
	bh=LdPP824Z4tSnZp+/gkJ2fVeFAP4lRzI1VKHcEKIxk7s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dX7JV/7fe8ZqqO0IUCpaI1dcZ73/AukecTgFXpwbsz5mCpxFblH4o+4ciGlI5dy/EjZvtmQVt1Wk4ntAydDVQI8UBiuONsC2r3rICVoaoqUq1MqmYiBpVklUj8R3Nz8XIOB4TERDJnqIfzxjxEB5RLyL5NRALtQv/M8eEalb5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mF3DSM58; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mF3DSM58"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ALgdzPpL+d5iGiTM4u8eiBjjv1/dqGxtZxieX6YLc34=;
	b=mF3DSM58SovSu16LW40YbPOsYmFVvTLh0MnsbWOBwDW734nHimzz4ZzNWf7wPGecmNLQ8QF88
	blk2aJmHMH4AceVUSAMjAmlEkIzbXtxBKht00q9PUzucBH0fq0VMy4lH8qRJfMc6+WYlotpSN7j
	yX1i9VUqRP2I+MZva9fp5pM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hpHyH4LLzznTZf;
	Mon, 21 Sep 2026 17:30:15 +0800 (CST)
Received: from whupemk200014.china.huawei.com (unknown [7.152.185.79])
	by mail.maildlp.com (Postfix) with ESMTPS id C24E240563;
	Mon, 21 Sep 2026 17:41:17 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 whupemk200014.china.huawei.com (7.152.185.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 21 Sep 2026 17:41:16 +0800
Subject: Re: [PATCH v2 1/3] firmware: arm_ffa: Split the response out of
 ffa_msg_send_direct_req2()
To: Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260901192906.133670-2-jamien@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <348dfed7-6aa2-77a2-a0a9-3aeed22f46b8@huawei.com>
Date: Mon, 21 Sep 2026 17:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260901192906.133670-2-jamien@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk200014.china.huawei.com (7.152.185.79)

Hi Jamie,

On 2026/9/2 3:29, Jamie Nguyen wrote:
> ffa_msg_send_direct_req2() uses one buffer for both the request and the
> response, and it only ever reports a callee side FFA_ERROR as a translated
> errno. The ACPI FFH Operation Region handler added later in this series
> can work with neither. It has to hand every response register back to AML,
> including on the paths where the call failed.
> 
> Move the body into __ffa_msg_send_direct_req2(). It writes the response to
> a buffer of its own, returns X1-X3 through @resp_regs, and separates three
> outcomes: success, a callee that returned FFA_ERROR (-EIO, with the FF-A
> error code left in @resp_regs[1]), and anything else (-EPROTO).
> 
> ffa_msg_send_direct_req2() sits on top of that as a wrapper. It copies to
> the caller's buffer only on success and returns the same errnos it did
> before, so ffa_sync_send_receive2() and its users are untouched.
> 
> No functional change.
> 
> Assisted-by: Claude:claude-opus-5

Assited-by: LLM

The kernel document was updated for this, please update the
rest of two patches as well.

> Co-developed-by: Dat Mach <dmach@nvidia.com>
> Signed-off-by: Dat Mach <dmach@nvidia.com>
> Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
> ---
>   drivers/firmware/arm_ffa/driver.c | 51 ++++++++++++++++++++++++++-----
>   1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 8654b3365c9b6..3236cd0a731ab 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -560,8 +560,20 @@ static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t s
>   	return retval;
>   }
>   
> -static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
> -				    struct ffa_send_direct_data2 *data)
> +/*
> + * Sends @req and reports the callee's X1-X3 through @resp_regs and its
> + * X4-X17 through @resp, both unconditionally, so that a caller bound by
> + * DEN0048D section 2.3.1.2 can copy every register back to AML even when the
> + * callee returned FFA_ERROR. Keeping the response out of @req leaves the
> + * caller free to decide when, if ever, to overwrite its own buffer. Returns
> + * -EIO for FFA_ERROR (the FF-A error code is left in @resp_regs[1] as X2) and
> + * -EPROTO for an unexpected response; both mean the call was made. Callers
> + * that only need an errno should use ffa_msg_send_direct_req2().
> + */
> +static int __ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
> +				      const struct ffa_send_direct_data2 *req,
> +				      struct ffa_send_direct_data2 *resp,
> +				      u64 resp_regs[3])
>   {
>   	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
>   	union {
> @@ -574,21 +586,46 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
>   		.a2 = le64_to_cpu(uuid_regs.regs[0]),
>   		.a3 = le64_to_cpu(uuid_regs.regs[1]),
>   	};
> -	memcpy((void *)&args + offsetof(ffa_value_t, a4), data, sizeof(*data));
> +	memcpy((void *)&args + offsetof(ffa_value_t, a4), req, sizeof(*req));
>   
>   	invoke_ffa_fn(args, &ret);
>   
>   	ffa_msg_send_wait_for_completion(&ret);

As you noted in the cover letter, the AML thread will stall here if no
response, block the ACPI interpreter and the ACPI global lock when
the field is Lock-flagged, so do we have some warnings if that happened?

>   
> +	resp_regs[0] = ret.a1;
> +	resp_regs[1] = ret.a2;
> +	resp_regs[2] = ret.a3;
> +	memcpy(resp, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*resp));
> +
>   	if (ret.a0 == FFA_ERROR)
> -		return ffa_to_linux_errno((int)ret.a2);
> +		return -EIO;
> +
> +	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2)
> +		return 0;
> +
> +	return -EPROTO;
> +}
>   
> -	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2) {
> -		memcpy(data, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*data));
> +static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
> +				    struct ffa_send_direct_data2 *data)
> +{
> +	struct ffa_send_direct_data2 resp;
> +	u64 resp_regs[3];
> +	int ret;
> +
> +	ret = __ffa_msg_send_direct_req2(src_id, dst_id, uuid, data, &resp,
> +					 resp_regs);
> +	if (!ret) {
> +		*data = resp;
>   		return 0;
>   	}
>   
> -	return -EINVAL;
> +	if (ret == -EIO)
> +		return ffa_to_linux_errno((int)resp_regs[1]);

resp_regs[1] is confusing, comment here it links to X1 register
is better.

Thanks
Hanjun
