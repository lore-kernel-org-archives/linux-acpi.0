Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A183214A9B;
	Wed, 22 Jul 2026 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682954; cv=none; b=UEtBsnX3fWavSYndJkyMxmU0d+Pgp0IXHY9MtUdXSFNYZ0QIeVWr4TNVQxw4tHwUx611iGPVhWNec3FaH0LG2SWy/38h1irf9L/QAW7eVKyKJqmq4FALaAWs6MTvKKFK5QVxatWFVmrLRzlG/Acp8mQELcJ4PLlyHlTw0ZTOFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682954; c=relaxed/simple;
	bh=aPBYGGTjJxbXyf0x5609DsOMFmCNEhPb6cKznwXV1g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fIAr82wcY16J+HZoOE1eBHUW9BPth2GGMQx6QER57UGuX6Q1ppkjeMDy2NHNrL+SbnmFSck+jPxh/Vhgxr3dPRPWTuopl2OTNJA/3AksryuiXE1Zj3lJT6gCmC/4KCVk7jCQK+vacYwIr+kpmwOGQ4JcXqLCMJY8jVeFxzUaqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=OsEA1k1R; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="OsEA1k1R"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aPBYGGTjJxbXyf0x5609DsOMFmCNEhPb6cKznwXV1g0=;
	b=OsEA1k1Rg+J2texVZv4M2zVj94/HLHZj+3ZDGrxo4/UruHiS6BkxrsxOR/NDdOyW72nZ3gJJM
	zYf/AASWqwDIs8ft2FeYLyMLVet6e76eNokDYkC8fq8DMZm8VgdIOka6esbmVOODI+yZhWk8M94
	6UndvmRzCwSIs3+aA1sOKHg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h4bgK5zrlzpStk;
	Wed, 22 Jul 2026 09:06:37 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A9294057F;
	Wed, 22 Jul 2026 09:15:42 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 09:15:41 +0800
Message-ID: <fcedb818-fb09-4a0b-a916-d65f762e5905@huawei.com>
Date: Wed, 22 Jul 2026 09:15:40 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ACPI: PCC: Free channel on OpRegion deactivation
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <acpica-devel@lists.linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuisong@huawei.com>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-4-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260717081005.470013-4-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> ACPICA calls the address space setup callback with
> ACPI_REGION_DEACTIVATE when a PCC OperationRegion is torn down.
>
> The PCC setup callback currently allocates a fresh pcc_data and requests
> the mailbox channel before looking at the function argument. If ACPICA
> deactivates a region, this can leave the existing region context and
> mailbox channel unreleased, and may also request a channel during
> teardown.
>
> Handle ACPI_REGION_DEACTIVATE before allocation. Free the PCC mailbox
> channel, release the region context and clear the context pointer.
>
> Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
How to trigger this region deactivate at runtime?

Overall looks good to me.
Reviewed-by: Huisong Li <lihuisong@huawei.com>
