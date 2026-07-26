Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1182EEE86;
	Sun, 26 Jul 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785044369; cv=none; b=f5U/ANFORdZnpWrMWTYMNt8K9Nc0px4qQT52dx2eDgBzo0OjA4TOnLNmrHjhsXVdMHFh9xNjkykV0Xer2n2AEmfFwmdWjV6qwCc91VYvFeFgLYJ9JNh2dLxHXhGizgF92EmYDQ7/GscOABTB7AYdQ+VXNlPqOkth8Y6c8pQifiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785044369; c=relaxed/simple;
	bh=HBYfVa8gmizXLa+yjbjadGQKf+wbooqRpoG2WxtTMHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2Yhm1WrUSFCxl78wlKkq+KlP7bOrI2O+xHge5r1fsGzgBO4Wd6wdRHrDIxRXdkoVZw7Hf01G7y8US4GK+4txnmPX3eX/8fViXO6S7PNLjYbZOEYb0+GnqIfhe+pfUTzsXbWGD7rDYsPnLi7SuxvjBb2sBZYCZAUO9fL3+jZz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=XhVPf9V8; arc=none smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="XhVPf9V8"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CEE704C1A63;
	Sun, 26 Jul 2026 05:32:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.104.243.140])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8B3C54C0495;
	Sun, 26 Jul 2026 05:32:23 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Whispering: 50d0094d185e8fcb_1785043946650_507907691
X-MC-Loop-Signature: 1785043946650:1936039323
X-MC-Ingress-Time: 1785043946650
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.243.140 (trex/8.0.2);
	Sun, 26 Jul 2026 05:32:26 +0000
Received: from [10.0.0.45] (unknown [73.4.247.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4h79N65l0Wz103m;
	Sat, 25 Jul 2026 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1785043943;
	bh=m93/EWvBIHQV25gBZDzomg2dymT5iT2hyFHdJQLz/PU=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=XhVPf9V8epc8vYtEEkWsFa39GV/5K7aOg2ZwH0n3l6OkvDznAg2Pgu5VXcfuZqg3c
	 B3jKIYTzsVhBCz+cog/u6muUeYV+nS/pWH6XIdCb1km69qeItfhpqz39vjIex1KqOs
	 ZLiYuGMGW/2/KBQ6kBgPwX4QVnzK7ywLUbUW7EQlfuaXOGE8VupuRi5XalAzf+pm/1
	 ERUJ5Kb82M01oXidRHk9xGUY5wEa2jUR7f0ILrCnCxChgmChgSeNFMhrQuw41i6bPv
	 TttyG5nC3lla4y773B/jXFP7saPZvioAzTOKVP7eiPGk0JgofHPpaQNnH4HzYSJLT0
	 4FW8jBB9TxgKA==
Message-ID: <c1872aa5-087b-41b8-b65e-53037769edc8@younglogic.com>
Date: Sun, 26 Jul 2026 01:32:12 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mailbox: pcc: Notify clients on polled completion
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20260723143928.2625970-1-sudeep.holla@kernel.org>
 <20260723143928.2625970-2-sudeep.holla@kernel.org>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260723143928.2625970-2-sudeep.holla@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/23/26 10:39, Sudeep Holla wrote:
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
> Acked-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>   drivers/mailbox/pcc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 636879ae1db7..d96b8b54e77e 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -449,7 +449,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
>   {
>   	struct pcc_chan_info *pchan = chan->con_priv;
>   
> -	return pcc_mbox_cmd_complete_check(pchan);
> +	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
> +		return false;
> +
> +	if (!pcc_mbox_cmd_complete_check(pchan))
> +		return false;
> +
> +	mbox_chan_received_data(chan, NULL);
> +
> +	return true;
>   }
>   
>   /**
Reviewed-by: Adam Young <admiyo@os.amperecomputing.com>
