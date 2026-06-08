Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6E3B961F;
	Mon,  8 Jun 2026 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913234; cv=none; b=nr2mvqStvcwGCFu2SGAG0/d3/xGYi0abUuYFAEvIAZc4upZ9R+skhdF0CYUvO5h1vg5Wm9mv2r2O+Ek/v290fKzCuvnjWvA6ZBBcZDnVD5lLMhLni6BjZatHvu3TX/2Iv+i818oQEnpbVfu/jxQTt0pnDcgfdw/nY45NDwzMESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913234; c=relaxed/simple;
	bh=CkfdqoD5Fhnk1w2qCC1VV8kNohj5JWIwdoycn0sX2+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUbP0ibnZ42TQDiHdEmTFbf74qRwBYE0hJyDMT9L9d//8sesyBfK8pqh7HWzAn74MfYWFrjJBLprZU6RjYP7PD0XxALwIkaRQuLRnWU3eI3ESW/e7xrOKlGNSoa2zjLOhXFwVpeBvhYL8Mh9NYPhWaw91RciShcMYfuyu52qtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gVYeccAQ; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gVYeccAQ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b3MQoM2KKIBHNrnkwRQIZdVJq/gz8nDmJkTOeWFMQhI=;
	b=gVYeccAQjv/jJ0E3eEulHiaLxdX1SgqoQ0l60Kr6zVhoekXDlvKYqrpRUaPn9PQXVHNqRm7Dk
	JgJyDEXItpkmjIPml0dVFuzImoR6aPjFBPm4qSftJoyiTvX/VLhKig3MWWYkAozoRNXKQmUmJiG
	nNWJnnfgzN6xhh/xs0wTOVc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gYnZF1skdz1cyR3;
	Mon,  8 Jun 2026 17:59:17 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 16C1440573;
	Mon,  8 Jun 2026 18:07:09 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 18:07:08 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Jun
 2026 18:06:59 +0800
Message-ID: <15af5635-e3a3-4ffc-9f02-82e35a95154f@huawei.com>
Date: Mon, 8 Jun 2026 18:06:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: Add cpuidle driver check in
 acpi_processor_register_idle_driver
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <LindaChai@zhaoxin.com>, <lihuisong@huawei.com>
References: <20260608063812.2533-1-TonyWWang-oc@zhaoxin.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260608063812.2533-1-TonyWWang-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 6/8/2026 2:38 PM, Tony W Wang-oc wrote:
> Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> driver registration") moved the ACPI idle driver registration to
> acpi_processor_driver_init(), but it didn't check whether a cpuidle
> driver was already registered.
>
> For example, on Intel platforms, if the intel_idle driver is already
> loaded, the code would still evaluate the _CST object in the ACPI
> table and attempt to register the acpi_idle driver. This registration
> would fail with -EBUSY due to the existing check in cpuidle_register_driver.
>
> Add a check at the beginning of acpi_processor_register_idle_driver()
> to avoid unnecessary _CST evaluate and potential registration failures.
Now look good to me. Thanks.
> Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration")
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>   drivers/acpi/processor_idle.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index ee5facccbe10..0409411abb83 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1355,6 +1355,11 @@ void acpi_processor_register_idle_driver(void)
>   	int ret = -ENODEV;
>   	int cpu;
>   
Can you add some like below comment?
"No need to register the ACPI idle driver when platform don't use this 
driver."
> +	if (cpuidle_get_driver()) {
> +		pr_debug("cpuidle driver %pS already registered.\n", cpuidle_get_driver());
> +		return;
> +	}
> +
>   	acpi_processor_update_max_cstate();
>   
>   	/*
