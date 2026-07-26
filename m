Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1F288B8;
	Sun, 26 Jul 2026 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785044001; cv=none; b=Oo5YHH0UJeAIu5S5nk1N0n9+GGcvoQSscloyJJr6dhSzONmURSIDc0MY9s9IYrLeVcsxK5LHghloHL4WstCZiZo4ZBpZEtuWogTWhVLPRWbFmMZ2FrVw02lX51BKH2mm8wygIu9VWSVcdm8YXq0R8LE59ih3HJB2+W00PqoYl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785044001; c=relaxed/simple;
	bh=zSEGJaZStLiHD2evfoXtabZXgiq4YX6Y16Pk9b0cY6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAurvku3Xk/hQpKYAQvCbPymJDGOUMQp0edNgORa292u48BQRn5oSjmz1bo0XfCJ1KGtfZvNjugUld0fVg6rXx914rYKd9jbRw+ZH2qaD5LjxyaWdUmE0taOgtNg5+zkANzFRGdOAecd/MrQbhOsYy7ytY8+k7V+hA7EtZOcR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=UB4CmFLk; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="UB4CmFLk"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 258878006A8;
	Sun, 26 Jul 2026 05:33:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.104.241.241])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F16C28003DF;
	Sun, 26 Jul 2026 05:33:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Plucky-White: 6843e12b0b3c8631_1785043999069_2509741249
X-MC-Loop-Signature: 1785043999069:1996877942
X-MC-Ingress-Time: 1785043999069
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.241.241 (trex/8.0.2);
	Sun, 26 Jul 2026 05:33:19 +0000
Received: from [10.0.0.45] (unknown [73.4.247.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4h79P72L5Zz103m;
	Sat, 25 Jul 2026 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1785043995;
	bh=V3sc6DWqNkpnwenul6gXb926tfqryg6Ys91wEA0Wpag=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=UB4CmFLkfLlyH/Hs+e0zDDSsZBUjTIV5kdhnKYJ/NQgadU/4lA6aHd76lXOQDHr7N
	 sb7Z7erjozEcflnbIF9sPgT28atp1ClLtczrw7Ac48txjKl1VKwNwUh/nwKBGN6A3v
	 s3ZRPNWmVWnLuz3z78YbIf53P3Tw0PYSn3FAufHvvxrIrVaXqL0+CRfe4Txu6d8nqv
	 cC/d2xie9lMsDJAFBBiNENSimwcoZRzRWAdB8NIbWsQHT6G9wttEDNioWXWZHoY0mA
	 5yOUnf4FqGO3JS74ad3zQ6m+kSmaubvsFw8CsRWqbFcm67TGocfqHmY4AALZS9XxVK
	 VtTS1jCUC/41A==
Message-ID: <0cf2480f-01b2-4960-be78-a1d35bb9f964@younglogic.com>
Date: Sun, 26 Jul 2026 01:33:04 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mailbox: pcc: Fix command timeout due to missed
 interrupt
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>
References: <20260723143928.2625970-1-sudeep.holla@kernel.org>
 <20260723143928.2625970-4-sudeep.holla@kernel.org>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260723143928.2625970-4-sudeep.holla@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/23/26 10:39, Sudeep Holla wrote:
> From: Huisong Li <lihuisong@huawei.com>
>
> PCC command execution can time out when a fast platform completes a
> transaction and signals the platform interrupt before pcc_send_data()
> marks the channel as in use. For shared platform interrupts, the type 3
> handler uses chan_in_use to decide whether the interrupt belongs to the
> channel. If it observes false, it ignores the completion and the caller
> waits until timeout.
>
> Publish chan_in_use before ringing the doorbell. Use WRITE_ONCE() for
> the lockless flag updates and READ_ONCE() in the interrupt handler. The
> following ordered I/O accessor orders the flag store before the platform
> is notified.
>
> Clear chan_in_use if ringing the doorbell fails. Otherwise, leave it set
> until the interrupt handler completes the transaction, clearing it before
> the mailbox core can submit another transfer.
>
> Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>   drivers/mailbox/pcc.c | 41 +++++++++++++++++++++++++++--------------
>   1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 8dfa80b0a90f..9888dab64639 100644
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
> + * @chan_in_use: lockless flag used by type 3 initiator subspaces to filter
> + *		platform interrupts. Only one transfer can occur at a time, but
> + *		the interrupt handler may sample the flag on another CPU, so all
> + *		accesses must use READ_ONCE() or WRITE_ONCE(). Other subspace
> + *		types do not test it.
>    */
>   struct pcc_chan_info {
>   	struct pcc_mbox_chan chan;
> @@ -320,8 +319,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>   		return IRQ_NONE;
>   
> +	/*
> +	 * Initiator subspaces use this flag to filter shared interrupts. Use
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
> +	 * Clear this flag after updating the interrupt ack register and before
> +	 * notifying the client and mailbox core. mbox_chan_txdone() may submit
> +	 * the next queued transfer and set the flag again. Use WRITE_ONCE() for
> +	 * the lockless update observed by the send and interrupt paths.
>   	 */
> -	pchan->chan_in_use = false;
> +	WRITE_ONCE(pchan->chan_in_use, false);
>   	mbox_chan_received_data(chan, NULL);
>   	mbox_chan_txdone(chan, 0);
>   
> @@ -464,9 +468,18 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * Set chan_in_use before ringing the doorbell so a fast completion
> +	 * interrupt is not mistaken for a shared interrupt from another
> +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
> +	 * ordered I/O accessor used to ring the doorbell orders this store
> +	 * before the platform is notified.
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

Tested-by: Adam Young <admiyo@os.amperecomputing.com>


