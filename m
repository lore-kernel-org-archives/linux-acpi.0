Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15373655CB;
	Tue, 30 Jun 2026 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810227; cv=none; b=gO3ovkR0UxSC+pfDRYWqwvl4F1QSZNxJHsuPAvZe4cDsFgGs96biWpGClNdFgqTIWVCCY0V5k/IqtlRBevp0m5z96uErXhU7XYk+K+h7NXv1of9buydV2FkUrbfZiUQ7oDKqxBZSlPUsVemE/eVpzf3WzwKOpymVRW+zxTxH4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810227; c=relaxed/simple;
	bh=ccd+x6k/UqurC+m0gxQIAMomtJmhBTW/hYIdMS0HA2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KNBRONsOdXdR7j/JHi+w9cR02f1kM+gaUdUGhq/TTxCo5vom7doXM33ng5CLT3y5+JFeeAwgzPzus9IpN+TG8loEjyrz178Fk8ilcmeIHN6BpW/mcFYthwDdnEDwKuO3U3bw55hTM8gVrUJATFdldk4rMyj+D38M0BZ4vq3ttE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=CIsKbS07; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="CIsKbS07"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nFj6R8fbgtiiO1OZxNhDI3Aff4U5TV735lceCrG91QQ=;
	b=CIsKbS07p3efJm/sLY/bGKSGE2HYqAi+ykAHPBCmwwkibu6TGI2fad1tYLX8Tjho8GX3psKxl
	pxbWyMX4jlERbC0bcsegrZypTYxGINlqH7ymwTTojobzrAWf2hNYa0lceKQ7mDdbcXpXTGiBh6V
	nYFSuJJXmy6u4RSaa1Z0TQk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gqH4R0KVdz1T4M4;
	Tue, 30 Jun 2026 16:53:43 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 58DDC40579;
	Tue, 30 Jun 2026 17:02:32 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 30 Jun
 2026 17:02:31 +0800
Message-ID: <53b369fc-6ad0-4b0e-8f0d-e1e4ceec2937@huawei.com>
Date: Tue, 30 Jun 2026 17:02:31 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mailbox: pcc: Validate shared memory signature on
 request
To: Sudeep Holla <sudeep.holla@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, <lihuisong@huawei.com>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-1-c1b7268d4fdc@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260627-acpi_pcc_signature-v1-1-c1b7268d4fdc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/28/2026 12:37 AM, Sudeep Holla wrote:
> ACPI defines the PCC shared memory signature as the bitwise OR of
> 0x50434300 and the PCC subspace ID. The signature is located at byte
> offset 0 for the generic, extended and reduced PCC shared memory region
> layouts.
>
> Validate the signature when a client requests a PCC mailbox channel, after
> mapping the shared memory and before binding the mailbox client. This
> keeps PCC shared memory validation in the PCC mailbox controller instead
> of duplicating it in individual clients.
>
> ACPI 6.6 added clarification that the signature is populated by the
> platform and verified by OSPM.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>   drivers/mailbox/pcc.c | 38 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db7..6fbc17d41774 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -345,6 +345,28 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	return IRQ_HANDLED;
>   }
>   
> +static int pcc_mbox_validate_signature(struct pcc_mbox_chan *pcc_mchan,
> +				       int subspace_id)
> +{
> +	u32 expected_signature = PCC_SIGNATURE | subspace_id;
> +	u32 signature;
> +
> +	if (pcc_mchan->shmem_size < sizeof(signature)) {
> +		pr_err("PCC subspace %d shared memory is too small\n",
> +		       subspace_id);
> +		return -EINVAL;
> +	}
> +
> +	signature = ioread32(pcc_mchan->shmem);
> +	if (signature != expected_signature) {
> +		pr_err("PCC subspace %d has invalid signature: %#x expected %#x\n",
> +		       subspace_id, signature, expected_signature);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
If the signature is incorrect, there must be an issue with the PCCT 
table reporting.
So how about place this verification in pcc_mbox_probe?
We can mark the channel as unavailable so that other normal channels can 
continue to be used.
And the impact is minimal.
>   /**
>    * pcc_mbox_request_channel - PCC clients call this function to
>    *		request a pointer to their PCC subspace, from which they
> @@ -381,14 +403,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	if (!pcc_mchan->shmem)
>   		return ERR_PTR(-ENXIO);
>   
> +	rc = pcc_mbox_validate_signature(pcc_mchan, subspace_id);
> +	if (rc)
> +		goto err_unmap_shmem;
> +
>   	rc = mbox_bind_client(chan, cl);
> -	if (rc) {
> -		iounmap(pcc_mchan->shmem);
> -		pcc_mchan->shmem = NULL;
> -		return ERR_PTR(rc);
> -	}
> +	if (rc)
> +		goto err_unmap_shmem;
>   
>   	return pcc_mchan;
> +
> +err_unmap_shmem:
> +	iounmap(pcc_mchan->shmem);
> +	pcc_mchan->shmem = NULL;
> +	return ERR_PTR(rc);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
>
