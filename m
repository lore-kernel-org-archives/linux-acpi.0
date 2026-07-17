Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD33D3D02;
	Fri, 17 Jul 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270777; cv=none; b=jw7AZRSgq7qRxt/V3s13EWJrJoBE+HHvrFf4qTfVandYrwcMAjOLNJ7V5r6fnwwDIfoZUSzakqnZBIziuHg9dUKRy66g9o+R2AFWiH5S6Y2p6qCgURHgVglc4tOs81Rnddbs88ex9dSwGKi9qMi3Oz9BzcmEDb9ibGPmr0SHbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270777; c=relaxed/simple;
	bh=mWTrI58awMF6ODcljnNvZ2Rq9IfeCSWEdvrL1ftFW+8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cfovSx7yNnSHw5PLiH8r4/VyTqhkA0utBqpOnEtb3pR+NjtODx/bwbB8JdXkpigqXM1oIBtpxzi2f1+g7oMC3dgFczcgISZZVjJqs5qJQiNWvRr7Gmkfrw2+230FYs3QITC6ZxunGugPz7DdGa35HncPaZByEdz0B0CVcIjQXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WlhmqnPZ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WlhmqnPZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ljn3xSFIpmzgYfAeTiaxeOvaiTYt3QuwvY9djnL8ins=;
	b=WlhmqnPZsh63jvo26CQDWVtNRRhvNWtLqWeF9rp4b16t1wkqhJEYq79t8fgAIDUVdH4L1IOHp
	IrDGMi3nhrJFIsmt2KNNa5jOUgk5rC4JXv7/tSiLGwRDoot7yx0qvAcH8ejjeNRnokGPeF+tiMS
	iHiqIXMfm1Bk9Wzp5VZCXOU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h1gDV6s15z1T4HL;
	Fri, 17 Jul 2026 14:36:42 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BF8040538;
	Fri, 17 Jul 2026 14:45:56 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jul 2026 14:45:55 +0800
Subject: Re: [PATCH] ACPI: APMT: validate node bounds before device
 registration
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260706093811.81850-1-pengpeng@iscas.ac.cn>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e79f67b2-939a-8884-dc76-80e8c5e7278f@huawei.com>
Date: Fri, 17 Jul 2026 14:45:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260706093811.81850-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Pengpeng,

On 2026/7/6 17:38, Pengpeng Hou wrote:
> The APMT parser walks variable-length nodes from the ACPI table and
> passes each node pointer to the platform device that is later consumed by
> the Arm Coresight PMU driver. The loop only checked that the node start
> was before the table end before reading the full struct acpi_apmt_node and
> advancing by node->length.
> 
> Validate the fixed node body and the declared node length before using the
> node. This keeps malformed short nodes from being consumed locally or
> propagated to the runtime PMU driver as platform data.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/acpi/arm64/apmt.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index bb010f6164e5..5f341fa86fab 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -23,6 +23,21 @@
>   /* Root pointer to the mapped APMT table */
>   static struct acpi_table_header *apmt_table;
>   
> +static bool __init apmt_node_valid(struct acpi_table_apmt *apmt, u64 offset,
> +				   u64 end)
> +{
> +	struct acpi_apmt_node *node;
> +
> +	if (offset > end || end - offset < sizeof(*node))
> +		return false;
> +
> +	node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt, offset);
> +	if (node->length < sizeof(*node))
> +		return false;
> +
> +	return node->length <= end - offset;
> +}
> +
>   static int __init apmt_init_resources(struct resource *res,
>   				      struct acpi_apmt_node *node)
>   {
> @@ -129,8 +144,13 @@ static int __init apmt_init_platform_devices(void)
>   	apmt = (struct acpi_table_apmt *)apmt_table;
>   	offset = sizeof(*apmt);
>   	end = apmt->header.length;
> +	if (end < sizeof(*apmt))
> +		return -EINVAL;

This means the firmware reports the wrong length of the ACPI table, it's
better to print FW_BUG here.

It's a rare case because the APMT is not work at all if the length
is less than size of the head.

>   
>   	while (offset < end) {
> +		if (!apmt_node_valid(apmt, offset, end))
> +			return -EINVAL;
Do you have the real bad case? or can you trigger it?

Thanks
Hanjun
