Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA14371885;
	Thu, 25 Jun 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378092; cv=none; b=ZYHRXWXixseaTKqXecwoXDrGBL3jQySNigAmoHXmL2TD6weJhet2qr71rxbCKLeOwYdB9xBRErME7XUX2Z6DPXx/ru0vaasJNNDRYBlJ6q8lPK6RvKLgNRwTFQYwbFEGEO5PbEJh1xyeOgTgvP4PYE0zeRdDyrRIOoKzL9t5620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378092; c=relaxed/simple;
	bh=Y6UlfQl19QLdCQmWpr5qE9xZ1FXln+Q0ShXB4rYstrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a4tk07xi0zM1AG8SAFQL4YkRNFkP5Fl6wMZOGNioGCBDjLrDiDzoVaqtW/yU+d+UcUoi3rb/XKAPZD1FcZrMXCaHePzWJ1D5c3JuSgSySnr0i1Mg4o6s4St+TEkgCq7jCPU/S+0yELqMZ7vQDVnL+Ff/6BqbRvFEkGPcsrruDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=faGoHyLF; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="faGoHyLF"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I2jD2fq3MvmBS7F3VvmNKPfQHzDeGMBMqymqNOs3bpg=;
	b=faGoHyLF4GWutvuHyqz3P5YBxvwAXik/Nzul0ZQ8EktmaZGGLQXCPkxCmLmRKux+u23pmbzr5
	1xpzHBG8iGylKqK3yheIBRBpGVE4oW8kwa/BJqiD5yg5rJ6pXS9We6iB9Xc05WbfJlS6VraXdqN
	M62qlJENdUmveRJB14wGgnA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gmCHb0gw4znTVZ;
	Thu, 25 Jun 2026 16:52:43 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D184048B;
	Thu, 25 Jun 2026 17:01:26 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 25 Jun
 2026 17:01:25 +0800
Message-ID: <28cc8e74-617a-4c20-829a-99d0ebaea5f0@huawei.com>
Date: Thu, 25 Jun 2026 17:01:24 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
To: <sudeep.holla@kernel.org>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260417031429.2509443-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100005.china.huawei.com (7.202.195.212)

Hi Sudeep,

Can you help review this patch?


On 4/17/2026 11:14 AM, Huisong Li wrote:
> In some scenarios, PCC command may experience probabilistic timeout.
> This is primarily caused by the chan_in_use flag being updated after
> ringing the doorbell, coupled with a lack of proper memory barriers
> across CPU cores.
>
> On fast platforms, a race condition occurs: the platform processing
> completes and triggers an interrupt before the local CPU sets
> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
> it reads chan_in_use as false and incorrectly ignores the interrupt.
>
> This patch fixes the race by:
> 1. Moving the chan_in_use update before ringing the doorbell.
> 2. Using smp_store_release() to ensure the flag update is visible
>     to other cores before subsequent hardware or software actions
>     are triggered.
> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>     latest flag value is read before deciding to skip the interrupt.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/mailbox/pcc.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db7..f45fccd635b6 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -320,8 +320,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>   		return IRQ_NONE;
>   
> +	/*
> +	 * For Master Subspaces, we must ensure we see the latest chan_in_use
> +	 * value updated by pcc_send_data() on another core. smp_load_acquire
> +	 * provides the necessary barrier to avoid probabilistic IRQ misses.
> +	 */
>   	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
> -	    !pchan->chan_in_use)
> +	    !smp_load_acquire(&pchan->chan_in_use))
>   		return IRQ_NONE;
>   
>   	if (!pcc_mbox_cmd_complete_check(pchan))
> @@ -336,7 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 * where the flag is set again to start new transfer. This is
>   	 * required to avoid any possible race in updatation of this flag.
>   	 */
> -	pchan->chan_in_use = false;
> +	smp_store_release(&pchan->chan_in_use, false);
>   	mbox_chan_received_data(chan, NULL);
>   	mbox_chan_txdone(chan, 0);
>   
> @@ -438,9 +443,16 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * Set chan_in_use before ringing the doorbell. Using smp_store_release
> +	 * ensures the flag is visible to the interrupt handler before the
> +	 * hardware is actually notified.
> +	 */
> +	if (pchan->plat_irq > 0)
> +		smp_store_release(&pchan->chan_in_use, true);
>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> -	if (!ret && pchan->plat_irq > 0)
> -		pchan->chan_in_use = true;
> +	if (ret && pchan->plat_irq > 0)
> +		smp_store_release(&pchan->chan_in_use, false);
>   
>   	return ret;
>   }
