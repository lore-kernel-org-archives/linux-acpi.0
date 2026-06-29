Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81F21B905;
	Mon, 29 Jun 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740778; cv=none; b=gJ2caEnxmKbaR3CLU58wLDn8kzj3TTuDRfuYJfOCxKjMyk9RJMNyZ+5SQ80e3tCgKx7uz7ZFEembfHOMX5+PPGnso04Ink0wOThh0FWPo2qQrO0IdA0apouuGpK+lclL4VrIFW8eWR8wYErf4odvUDlfxJF4bfVl6mmNUNLLtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740778; c=relaxed/simple;
	bh=FClJmBF0SnDcBjDWIMXZgtSDKS267DSNV3DXarKEAxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZZtHW6yLUHH9i4xw4s1/HEzbT0AvA/Yt0Fu08lfpSXR4pKDMvBWg2xSVWexaEbEsDToujGsz+Dn1Wc/3b4stuwGWeZK72nMNFbG3yDjPi8gH3f0GQkG6OmtSsmm7aupqt2bNOqcuWHiXfUVWDSfWujsiiWIiLiAj+ItZwDbY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gWoT4Riq; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gWoT4Riq"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hoeZQKAKCytmy4Zg2rze4SoX4o9W/WSO8p/KqP/VkfQ=;
	b=gWoT4RiqLCUsy7v7qeexTY7/ZqSSNtOP++fFRT2iok4wLmMC/MVKneqz6R5OHw/2V8pO6iSGe
	3xRfvZp7e8a5fMGyks7ZgocNcAYVbl5pG7U/kuEIV8C/m7pKAuwoMtBVzU+7L24cHp4qUVwzz0O
	E39dgQhp5dCvAwHdwVyGD+o=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gpnPn1Mp5zKm5T;
	Mon, 29 Jun 2026 21:37:01 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C7C84048B;
	Mon, 29 Jun 2026 21:46:12 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Jun
 2026 21:46:11 +0800
Message-ID: <1c8b36dd-ce0e-444e-b8f8-26566d3cce05@huawei.com>
Date: Mon, 29 Jun 2026 21:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
 <20260627-bright-objective-bloodhound-db3fde@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260627-bright-objective-bloodhound-db3fde@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/27/2026 10:31 PM, Sudeep Holla wrote:
> Hi Huisong,
>
> Sorry for the delay, this seem to have slipped through the cracks.
>
> On Fri, Apr 17, 2026 at 11:14:29AM +0800, Huisong Li wrote:
>> In some scenarios, PCC command may experience probabilistic timeout.
>> This is primarily caused by the chan_in_use flag being updated after
>> ringing the doorbell, coupled with a lack of proper memory barriers
>> across CPU cores.
>>
>> On fast platforms, a race condition occurs: the platform processing
>> completes and triggers an interrupt before the local CPU sets
>> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
>> it reads chan_in_use as false and incorrectly ignores the interrupt.
>>
>> This patch fixes the race by:
>> 1. Moving the chan_in_use update before ringing the doorbell.
>> 2. Using smp_store_release() to ensure the flag update is visible
>>     to other cores before subsequent hardware or software actions
>>     are triggered.
>> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>>     latest flag value is read before deciding to skip the interrupt.
>>
> I don't think we need store_release/load_acquire semantics here. IIUC
> we don't need to make all preceding memory updates visible to the IRQ handler.
> i.e. seeing the flag updated doesn't require observing all the updates before
> the flag itself. This flag is not publishing extra data to be consumed after
> the check.
Ack.
>
> How about something like below ? If you agree and it works, add my
> Reviewed-by and post.
It's nice.
Many thanks for your improvements.

I will test it again.
>
> Regards,
> Sudeep
>
> -->8
> mailbox: pcc: Fix command timeout due to missed interrupt
>
> PCC command execution can time out when a fast platform completes a
> transaction and signals the platform interrupt before pcc_send_data()
> marks the channel as in use. For shared platform interrupts, the type 3
> handler uses chan_in_use to decide whether the interrupt belongs to the
> channel. If it observes false, it ignores the completion and the caller
> waits until timeout.
>
> Publish chan_in_use before ringing the doorbell. Use WRITE_ONCE() for
> the lockless flag update and READ_ONCE() in the interrupt handler when
> filtering shared interrupts. The following ordered MMIO accessor used for
> the doorbell keeps the earlier store visible before the platform is
> notified.
>
> Clear chan_in_use with WRITE_ONCE() when completing the transaction,
> matching the lockless flag protocol used by the interrupt and send paths.
>
> Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Link: https://patch.msgid.link/20260417031429.2509443-1-lihuisong@huawei.com
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>   drivers/mailbox/pcc.c | 41 +++++++++++++++++++++++++++--------------
>   1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 6fbc17d41774..bde5e0852157 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -91,12 +91,11 @@ struct pcc_chan_reg {
>    * @plat_irq: platform interrupt
>    * @type: PCC subspace type
>    * @plat_irq_flags: platform interrupt flags
> - * @chan_in_use: this flag is used just to check if the interrupt needs
> - *		handling when it is shared. Since only one transfer can occur
> - *		at a time and mailbox takes care of locking, this flag can be
> - *		accessed without a lock. Note: the type only support the
> - *		communication from OSPM to Platform, like type3, use it, and
> - *		other types completely ignore it.
> + * @chan_in_use: lockless flag used by initiator subspaces, such as type 3,
> + *		to filter shared platform interrupts. Only one transfer can occur
> + *		at a time, but the interrupt handler may sample the flag on another
> + *		CPU, so all accesses must use READ_ONCE() or WRITE_ONCE().
> + *		Other subspace types ignore it.
>    */
>   struct pcc_chan_info {
>   	struct pcc_mbox_chan chan;
> @@ -320,8 +319,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>   		return IRQ_NONE;
>
> +	/*
> +	 * Master subspaces use this flag to filter shared interrupts. Use
> +	 * READ_ONCE() to sample the lockless flag written by pcc_send_data()
> +	 * on another CPU.
> +	 */
>   	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
> -	    !pchan->chan_in_use)
> +	    !READ_ONCE(pchan->chan_in_use))
>   		return IRQ_NONE;
>
>   	if (!pcc_mbox_cmd_complete_check(pchan))
> @@ -331,12 +335,12 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   		return IRQ_NONE;
>
>   	/*
> -	 * Clear this flag after updating interrupt ack register and just
> -	 * before mbox_chan_received_data() which might call pcc_send_data()
> -	 * where the flag is set again to start new transfer. This is
> -	 * required to avoid any possible race in updatation of this flag.
> +	 * Clear this flag after updating the interrupt ack register and just
> +	 * before mbox_chan_received_data(), which might call pcc_send_data()
> +	 * and set the flag again to start a new transfer. Use WRITE_ONCE()
> +	 * for the lockless update observed by the send and interrupt paths.
>   	 */
> -	pchan->chan_in_use = false;
> +	WRITE_ONCE(pchan->chan_in_use, false);
>   	mbox_chan_received_data(chan, NULL);
>   	mbox_chan_txdone(chan, 0);
>
> @@ -466,9 +470,18 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	if (ret)
>   		return ret;
>
> +	/*
> +	 * Set chan_in_use before ringing the doorbell so a fast completion
> +	 * interrupt is not mistaken for a shared interrupt from another
> +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
> +	 * ordered MMIO accessor used to ring the doorbell keeps this store
> +	 * visible before the platform is notified.
> +	 */
> +	if (pchan->plat_irq > 0)
> +		WRITE_ONCE(pchan->chan_in_use, true);
>   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> -	if (!ret && pchan->plat_irq > 0)
> -		pchan->chan_in_use = true;
> +	if (ret && pchan->plat_irq > 0)
> +		WRITE_ONCE(pchan->chan_in_use, false);
>
>   	return ret;
>   }
> --
> 2.43.0
>
