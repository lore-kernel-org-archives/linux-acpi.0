Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90BC14A;
	Tue,  7 Apr 2026 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523774; cv=none; b=n60DbmDEfft3c1pdUC8LTISquGWgPGfJpQ7RI3SLdiyttrGndAf1fhF8iNWepOSlMUNa/ht99yrBlaRy+XUBrHVSNBl6FG7IWM6HTspycuHDjJsRBdrMyGN3GDZQBEfOAnGVq9ARxdlshWo2Y9/61I/CMJpnfxjJQWrwJOcxGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523774; c=relaxed/simple;
	bh=JP5OerNvLi/etrm2E5TCrSaq000rxKICo30Bs8SDFtQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CPSFLl3ZpOCCFaJ+oZ00XG6qiIkd018V8QS75LIiQ2BsvxvBtaWkBbC43wSxLryp7MKM+cssnjQ8N3A+QmnJQRHCF8x4S7SrUgWe77pbQ5h4SNaIZz9+MAGEEGPUccYlKRV5UAgFfbcY/326Q53qBwmgzQ+mAPLFzZWZFF0zbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OSZX0oJL; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OSZX0oJL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t4uBYqWYsVWqxFeqRin7PtAzbavFo39gPsOS0lVPF/c=;
	b=OSZX0oJLKUIwC9RcfhF2uv2vy6AMPk42aQIsPZ6LdvAHav4fIw4WQtPCheqqvnVAT+t8JnScd
	UJe/fFf8IFM+8ccRkjukjq22UgXnrPh5wkunIBq1VdUCZJtRLfpViHnbfSUIbC2wkZ0gMHNBC7r
	vT/81Q5xtlxRDCADJ29/BNc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fqSSW6hgHz1prQX;
	Tue,  7 Apr 2026 08:56:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 043B340571;
	Tue,  7 Apr 2026 09:02:44 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 09:02:43 +0800
Subject: Re: [PATCH v2] ACPI: AGDI: fix missing newline in error message
To: Haoyu Lu <hechushiguitu666@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>
CC: Len Brown <lenb@kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Russell King <rmk+kernel@armlinux.org.uk>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260401022957.611-1-hechushiguitu666@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <620cd553-e1bb-77c1-7d35-504d9b1db0a3@huawei.com>
Date: Tue, 7 Apr 2026 09:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260401022957.611-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/4/1 10:29, Haoyu Lu wrote:
> Add the missing trailing newline to the dev_err() message
> printed when SDEI event registration fails.
> 
> This keeps the error output as a properly terminated log line.
> 

...

> Changes in v2:
> - Change subject prefix from "acpi: arm64: agdi:" to "ACPI: AGDI:"

Updates between versions don't need to add in commit log, for a single
patch, the change log needs to be placed below...

> 
> Fixes: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
> ---

...which is here.

>   drivers/acpi/arm64/agdi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index feb4b2cb4618..0c2d9d6c160b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -36,7 +36,7 @@ static int agdi_sdei_probe(struct platform_device *pdev,
> 
>   	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
>   	if (err) {
> -		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
> +		dev_err(&pdev->dev, "Failed to register for SDEI event %d\n",
>   			adata->sdei_event);
>   		return err;
>   	}

Thanks
Hanjun
