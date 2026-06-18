Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8419DF55;
	Thu, 18 Jun 2026 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784406; cv=none; b=F2L/AB/WRuB4950zcwN9WzPLNHxUixT724j5UPGVjQR04wE4gORgYgPeXEeMXN0conMncDorUkUXnyYa3T8vYGVPxb7uDxKC/GWGGcNGYghuSrOpCk+G1imCaqXEsre7o7BqI0qzdzr9m8ml9hSmw76xTVcw+GZ5Zz+5wKB03+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784406; c=relaxed/simple;
	bh=ua/U8rgIQUTzIdUKXD1x8a8V9EImN1MtrWoNXBhBjp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaGLUPr4eJZ+YeN0SNFeweP2toUumn98T0OmzhwxBZkXzDvLQB4ovjlmGgCDh6QhNQAFfBstLuhbUCgnnIOnCua+WXKnytw8btz9mZk6D0nhPWw07nqPki1N4tmYOpP/RCB7rKceutix8Nas4hGKxtNTeIrhmpVVFumQHEFcLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7XoHkJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7XoHkJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF61F000E9;
	Thu, 18 Jun 2026 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781784404;
	bh=02pPgy3R3u6bNFx58bM3gMUsbpaFPn3tW5zDHhPtHkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j7XoHkJIqtRHCLMForHBos68VBpFOn/NI7rJwStieKXc6c6uWyfSLO3AmKtH8gQCS
	 dENnQZDvx272ZHm8+YVcMLr6q6kopZif0P3/ui6ujn7fVScDhIuDbfyTzveo3DPK8Z
	 7SBLWbcZNYa0WKl2TQhWMHSSiTOapM0RXc3NMYXD+wyIzolO//QoJQ1a0yUMN/YddT
	 IiPM47WTScZYR/7rv2UgVVEXZOz8VnXtmxYxMlzbq+jGCiE2NssreYHQoHtqP7QMzB
	 JiiaFkfVT36Di7sFqZvnOmLH7ocTLXoPmTm47HBSqhNhVw1x9ko8sUjLW/Qqug24It
	 aD1eb7xoWagiQ==
Date: Thu, 18 Jun 2026 13:06:41 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Notify clients on polled completion
Message-ID: <20260618-discreet-sparkling-dragon-7df7b2@sudeepholla>
References: <20260612170225.1063902-1-sudeep.holla@kernel.org>
 <4e2d023b-c651-4a80-ba14-3c66cd209214@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2d023b-c651-4a80-ba14-3c66cd209214@huawei.com>

On Thu, Jun 18, 2026 at 10:04:12AM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> On 6/13/2026 1:02 AM, Sudeep Holla wrote:
> > PCC channels without a platform interrupt rely on the mailbox
> > polling path to detect command completion.
> > 
> > That path currently only reports transmit completion to the mailbox
> > core, so clients that wait for their receive callback do not get
> > notified when the command completes.
> > 
> > Call mbox_chan_received_data() when polling observes completion on a
> > channel without a platform IRQ, matching the interrupt-driven
> > completion path.
> > 
> > Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > ---
> >   drivers/mailbox/pcc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 636879ae1db7..7c9451ab4527 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -447,9 +447,14 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
> >   static bool pcc_last_tx_done(struct mbox_chan *chan)
> >   {
> > +	bool ret;
> >   	struct pcc_chan_info *pchan = chan->con_priv;
> > -	return pcc_mbox_cmd_complete_check(pchan);
> > +	ret = pcc_mbox_cmd_complete_check(pchan);
> > +	if (ret && !pchan->plat_irq)
> > +		mbox_chan_received_data(chan, NULL);
> > +
> > +	return ret;
> >   }
> The mailbox_controller.h said that .last_tx_done() is used only if
> txdone_poll:=true && txdone_irq:=false.
> How about add a verification at the begining of this function? like "if
> (chan->txdone_method != MBOX_TXDONE_BY_POLL) return false;"
> And then call mbox_chan_received_data() directly if command completed.
> 

Thanks, it does makes sense to me. I will have look.

> This patch is ok to me if has above changes.
> Acked-by: lihuisong@huawei.com
> 
> 
> But pcc mbox controller can no longer work in MBOX_TXDONE_BY_ACK after your
> commit:
> 3349f800609e (mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags).
> This may lead to above client drivers fail to send mailbox command, like
> cppc_acpi,hisi_uncore_freq and kunpeng_hccs.
> Because these client driver knows tx_done(knows_txdone: true), work on this
> mode and need to call mbox_client_txdone.
> Do you have some idea for this?

I wonder if we can ask the platform to avoid generating interrupts in those
case by setting/clearing "Notify on completion" in shmem. Do you think that
would work ?

-- 
Regards,
Sudeep
