Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2959374185;
	Thu, 23 Jul 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824983; cv=none; b=kCP5vBKUw2eoVdD7dcqIOt8MiEfSUjg6p4CW7Wi/m+4bpxaK4wkaIqusFQl1aDI3KNtH1O9KiP8VdHW3UzCPI2FaaPoUXajqhgBNw8/uUvi8YemvmMO851zeuxlt6A33ypX5OA5ExMKkCMhzNvi7z/0ma1lS/DPrt+H3lrgPqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824983; c=relaxed/simple;
	bh=67AtmENqfuFWE+oaKz0IndJv4+zl6bSESpVaMM36Sg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afyQNH9RIwGZ26ETI/5VvZY4mCtQNBrsScynHuRK3Hnuus5eBhKZtCiFrcXzh59Voc2KjOhXaN+ANqEU/ZybRvvnOv5SthTzKKfawTmKRCF27gT4BwoYGzcv1Q4Enq/IK7gpOCFnD87Y+rG995rG60VREpCpqSi+IXdf5NqFtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=I1NMzxSp; arc=none smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="I1NMzxSp"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 440DA8020CF;
	Thu, 23 Jul 2026 16:03:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-104-242-227.trex-nlb.outbound.svc.cluster.local [100.104.242.227])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 961E1801217;
	Thu, 23 Jul 2026 16:03:48 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Towering: 6bd0abe008f3a9c0_1784822629115_985153538
X-MC-Loop-Signature: 1784822629115:2110027179
X-MC-Ingress-Time: 1784822629115
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.242.227 (trex/8.0.2);
	Thu, 23 Jul 2026 16:03:49 +0000
Received: from [10.41.33.250] (den-mail-01.amperecomputing.com [150.195.203.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4h5bX33cBnz1F;
	Thu, 23 Jul 2026 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1784822628;
	bh=unRrJiP3OlPcB4yOS3QOzCR8Ils30Vmt31Jcm0lMbEM=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=I1NMzxSpV8CC00vLCdpPgeHIwckzPTYdnOfABBsHxYrC0AZh4t+v9JPT3KosfJisf
	 GwS1rv6x5bw9gV4GvJErfA9Gy8oRWPuDX55uOBQeYV086VJqhvFyX31webzFzR8yMQ
	 bqiacnCJF99AzpjNI0/MPV51wbyDJtH16eOX9tFeO5S0dWQfAJE9se+vEXfPvKfOR4
	 16h6ZYbO7lolMXteqp60sE+EcG6cwl13fhtQa2GfHwvmyyWAj6HSKgliw2NbJFBjA2
	 JW5yjZWpxPQrrmy+Pm7UNfTvvYPLGBfoTHZ6wPrj1xP7zBRRFDkWqi57h3KbdXLXz4
	 bLrh7vUXJ+ERA==
Message-ID: <713e5efc-b0e3-45ca-b05f-eec36c977e8b@younglogic.com>
Date: Thu, 23 Jul 2026 12:03:45 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mailbox: pcc: Notify clients on polled completion
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-2-sudeep.holla@kernel.org>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260717075649.467172-2-sudeep.holla@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/17/26 03:56, Sudeep Holla wrote:
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

My code doesn't poll, so I cannot really claim to have tested it, but it 
does not break the existing IRQ based driver mechanism.

I can claim to have read through the code and confirm that it is 
comparable to what happens on the IRQ case:   It clears the cmd_complete 
field and calls mbox_chan_received_data. However, it does not clear 
pchan->chan_in_use = false; (Which should now be a WRITE_ONCE) and I 
would like to confirm that is not an oversight before providing a 
reviewed-by tag.


