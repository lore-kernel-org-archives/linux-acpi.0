Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D638838A;
	Tue,  7 Apr 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543812; cv=none; b=K/YWQEuB9oTaM6tVlD7RjqJo6ioxa+I5TO+QkIprLiZd2KaBjnANmi/Jm4c2yYdI1DxKnCH5CeLSOCBXjZ0QLwK4w9Tpw3Pb7lyWGGz+9L/1BrhLFPASt3++IvPj7q6JrKy389WlT/gjREiT0GsqxVzTfzOyhRiKMD3tkdSBv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543812; c=relaxed/simple;
	bh=Q0xfphDZWpWzLvgeQV/FeyZvzyzk7zUGIeHSb/2hdIw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h6YG5HQa0l3bG5mmOdZcgMtnIaQmJUeKmDcf4YMEIBcq/MwRlCNI9QFtMiQtWBQdI/X8LnOwjbWS2n7uOxF0KTQsu0gtN/4YUAIaKhDVdVr8OUGBBDBajAptz2RkjpfymntOcBDVXFg75iH1SOvCt8FunzimzcZea2/lfX+2oN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KodDnzDX; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KodDnzDX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sOMRFVxkkjIdBVHHRMg1i4CxlVw1ZlggtUcOT1JfmRY=;
	b=KodDnzDXynX43R1YNENTD4eOOJlfHbew+wKDbQKhYzADoR5O2bpFYRP20JGABtq6R3nfrFW4H
	ii1VLlpyAPpp9MzAsO8YCJTCrAmH9rQGtkeoVJu4+VCwB71WTLYj7A6fH5qrayDHBiZYPKIfRZr
	izV54KdG6Y1+h3jeQGUK/rQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fqbtL06yhz1T4G8;
	Tue,  7 Apr 2026 14:30:50 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 381A040576;
	Tue,  7 Apr 2026 14:36:39 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 14:36:38 +0800
Subject: Re: [PATCH v3] ACPI: AGDI: fix missing newline in error message
To: Haoyu Lu <hechushiguitu666@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>
CC: Len Brown <lenb@kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Russell King <rmk+kernel@armlinux.org.uk>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260407033117.100-1-hechushiguitu666@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <714472c7-ec8b-9f6b-928a-3de62f14b4f2@huawei.com>
Date: Tue, 7 Apr 2026 14:36:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260407033117.100-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/4/7 11:31, Haoyu Lu wrote:
> Add the missing trailing newline to the dev_err() message
> printed when SDEI event registration fails.
> 
> This keeps the error output as a properly terminated log line.
> 
> Fixes: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
> ---
> Changes in v2:
> - Change subject prefix from "acpi: arm64: agdi:" to "ACPI: AGDI:"
> 
> Changes in v3:
> - Move version history below the "---" separator as per review feedback
> 
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

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
