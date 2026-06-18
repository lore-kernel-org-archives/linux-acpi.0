Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065564C6D;
	Thu, 18 Jun 2026 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781748266; cv=none; b=cSndbSagO+2DZI6U/5fSlQgkqMBifbGnR0ScKM3X6rWGtqnG7UbN/PH7MHtdN1SCcETXXtyK7PEUk4VaaGF3pBLkyZ552/rSzfMdHBt/VeVH60IqPun/j3UeBFrrIyX3y+cYn2qoU+wF/9QDAJmFjIUgsTsKYSnOldYj/HkqVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781748266; c=relaxed/simple;
	bh=JH4AG6MKV9VEEZE62x7Naz53GjGNZ9zkIYGzxSACCMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2SdNCAWA1vE56B/AiVoMI0fx9skId0tmTn+TrAoDewyNz5vby1GGy4n327sCcZvjY6+punO1xGXh5sbCu46wEXF0CeBlNGQPyySrbK5EXnBQvqg1jmM+FWx8uT+0Wh/Iv2HRblQUpl9sK0qXEXcmQuHkCvtKjbWdcFntVvdd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=qCyrFBnc; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="qCyrFBnc"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DbZJjc5h9uKk8QzODTVsbKgZl7i6wnTMlqRD64AODNs=;
	b=qCyrFBncl9rDNU74uRQRvLdh9ITEbw5sBvdZZ0+f0ZhQ+IDT7F8zWDZoqEvLT4JRWCeFenM+f
	N5zUBDMHYAwDYN5GfBWEGvNtMTEEi4uaQt2JOTalgLre5+HCWh1c73j/GRtwecNrJjhpJRqnH4z
	lLtg44akGn48pYPUK8wRTlU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ggkND4x7fzKm4C;
	Thu, 18 Jun 2026 09:56:12 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 2062240563;
	Thu, 18 Jun 2026 10:04:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Jun
 2026 10:04:13 +0800
Message-ID: <4e2d023b-c651-4a80-ba14-3c66cd209214@huawei.com>
Date: Thu, 18 Jun 2026 10:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Notify clients on polled completion
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Cristian Marussi
	<cristian.marussi@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260612170225.1063902-1-sudeep.holla@kernel.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260612170225.1063902-1-sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)

Hi Sudeep,

On 6/13/2026 1:02 AM, Sudeep Holla wrote:
> PCC channels without a platform interrupt rely on the mailbox
> polling path to detect command completion.
>
> That path currently only reports transmit completion to the mailbox
> core, so clients that wait for their receive callback do not get
> notified when the command completes.
>
> Call mbox_chan_received_data() when polling observes completion on a
> channel without a platform IRQ, matching the interrupt-driven
> completion path.
>
> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>   drivers/mailbox/pcc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db7..7c9451ab4527 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -447,9 +447,14 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   
>   static bool pcc_last_tx_done(struct mbox_chan *chan)
>   {
> +	bool ret;
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> -	return pcc_mbox_cmd_complete_check(pchan);
> +	ret = pcc_mbox_cmd_complete_check(pchan);
> +	if (ret && !pchan->plat_irq)
> +		mbox_chan_received_data(chan, NULL);
> +
> +	return ret;
>   }
The mailbox_controller.h said that .last_tx_done() is used only if 
txdone_poll:=true && txdone_irq:=false.
How about add a verification at the begining of this function? like "if 
(chan->txdone_method != MBOX_TXDONE_BY_POLL) return false;"
And then call mbox_chan_received_data() directly if command completed.

This patch is ok to me if has above changes.
Acked-by: lihuisong@huawei.com


But pcc mbox controller can no longer work in MBOX_TXDONE_BY_ACK after 
your commit:
3349f800609e (mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags).
This may lead to above client drivers fail to send mailbox command, like 
cppc_acpi,hisi_uncore_freq and kunpeng_hccs.
Because these client driver knows tx_done(knows_txdone: true), work on 
this mode and need to call mbox_client_txdone.
Do you have some idea for this?
>   
>   /**
