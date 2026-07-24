Received: from dormouse.ash.relay.mailchannels.net (dormouse.ash.relay.mailchannels.net [23.83.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD641F7ED;
	Fri, 24 Jul 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913077; cv=none; b=Nfm0LPk/zSISMyqovQr96moSDLvlEcnco0n2nKihUl2JF9HOjy0LQ9N/PbIeY1dZEgjGbOVEnlKroYVTTXITmlPe6+4tfIyy3FnDnwr8tYANbZUEuesgjkwm97f8tSvK6Gg39DxtY2vLG/17GWGYrJD+pg7xfuhg7nGg9ivik/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913077; c=relaxed/simple;
	bh=02eF2+hrig1XRxqcXwPZnvdHu8chYfAZfUtE3IK5JAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmeZ64G5vgaceTBVa5pyuUrHwzQvYzmFJiAuyRZvSV92j0tHCfzZafoE/n9Oi91g8Tev9r5LZ7f9B/GcJwNlUNNB3OR5J3SAq8OhmqYTacIvuxtQwkbcFf77W2O+tudsETBipH9SFsIX2UE2o69pNAZI6LR5+JpDPkIclWFw7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com; spf=pass smtp.mailfrom=younglogic.com; dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b=67JGOiqc; arc=none smtp.client-ip=23.83.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=younglogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=younglogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=younglogic.com header.i=@younglogic.com header.b="67JGOiqc"
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CC1D161EDF;
	Fri, 24 Jul 2026 17:11:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-103-95-215.trex-nlb.outbound.svc.cluster.local [100.103.95.215])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 68B7A6228E;
	Fri, 24 Jul 2026 17:11:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|adam@younglogic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|adam@younglogic.com
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Shrill: 3fe3b2452d5d150e_1784913068695_3447824502
X-MC-Loop-Signature: 1784913068695:2772906171
X-MC-Ingress-Time: 1784913068695
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.95.215 (trex/8.0.2);
	Fri, 24 Jul 2026 17:11:08 +0000
Received: from [10.41.38.43] (unknown [150.195.203.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: adam@younglogic.com)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4h6DzH3l8vzWW;
	Fri, 24 Jul 2026 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=younglogic.com;
	s=dreamhost; t=1784913068;
	bh=yPjONmTf7tOfkOTSE0UXtdPhvY9WAoHjzqnGtEFo1+4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=67JGOiqc/C789SXkFeC+N5fWtx5VsfLjnX+79cKd+j+1KRgZNxNygcs+yacNx+LFW
	 df4zRf///tYj3fy4FF3Bhp4hYexz2Hy3Jj++1m5uLKwihsTN57xOjW8PgAEpXm3iKh
	 ZozEHNWlrpWyGXP+6MHeGP9KfjVk3HplGQfuKQ2BPQz7iXp92zQM61OMnHefW/up5f
	 l7kP0dFIreUw+RWK2PXbdPXhCILOcZ2dAe2qdtRfBMgBbD+AqCWlEe+ZjEpYRH+Xyo
	 yrvCvQnTZ8e6dOAtujDcKC3cLKcYY1M+6ccatDWVd1t16uKXwGoPtn+nQlm2WPmnHE
	 rSXGnWVsrMZrg==
Message-ID: <d26cd94e-c809-4268-8bee-e42828019127@younglogic.com>
Date: Fri, 24 Jul 2026 13:11:06 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mailbox: pcc: Notify clients on polled completion
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huisong Li <lihuisong@huawei.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20260717075649.467172-1-sudeep.holla@kernel.org>
 <20260717075649.467172-2-sudeep.holla@kernel.org>
 <713e5efc-b0e3-45ca-b05f-eec36c977e8b@younglogic.com>
 <20260723-vegan-capybara-of-tranquility-ba5c7f@sudeepholla>
Content-Language: en-US
From: Adam Young <adam@younglogic.com>
In-Reply-To: <20260723-vegan-capybara-of-tranquility-ba5c7f@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/23/26 15:45, Sudeep Holla wrote:
> On Thu, Jul 23, 2026 at 12:03:45PM -0400, Adam Young wrote:
>> On 7/17/26 03:56, Sudeep Holla wrote:
>>> PCC channels without a platform interrupt rely on the mailbox
>>> polling path to detect command completion.
>>>
>>> That path currently only reports transmit completion to the mailbox
>>> core, so clients that wait for their receive callback do not get
>>> notified when the command completes.
>>>
>>> Call mbox_chan_received_data() when polling observes completion on a
>>> channel without a platform IRQ, matching the interrupt-driven
>>> completion path.
>>>
>>> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Acked-by: Huisong Li <lihuisong@huawei.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
>>> ---
>>>    drivers/mailbox/pcc.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>> index 636879ae1db7..d96b8b54e77e 100644
>>> --- a/drivers/mailbox/pcc.c
>>> +++ b/drivers/mailbox/pcc.c
>>> @@ -449,7 +449,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
>>>    {
>>>    	struct pcc_chan_info *pchan = chan->con_priv;
>>> -	return pcc_mbox_cmd_complete_check(pchan);
>>> +	if (!(chan->txdone_method & MBOX_TXDONE_BY_POLL))
>>> +		return false;
>>> +
>>> +	if (!pcc_mbox_cmd_complete_check(pchan))
>>> +		return false;
>>> +
>>> +	mbox_chan_received_data(chan, NULL);
>>> +
>>> +	return true;
>>>    }
>>>    /**
>> My code doesn't poll, so I cannot really claim to have tested it, but it
>> does not break the existing IRQ based driver mechanism.
>>
> Thanks for testing IRQ mode.
>
>> I can claim to have read through the code and confirm that it is comparable
>> to what happens on the IRQ case:   It clears the cmd_complete field and
>> calls mbox_chan_received_data.
> Thanks for taking a look and reviewing it.
>
>> However, it does not clear pchan->chan_in_use
>> = false; (Which should now be a WRITE_ONCE) and I would like to confirm that
>> is not an oversight before providing a reviewed-by tag.
>>
> IIRC I think we set the flag only when irq > 0, no ?

That is right.  So, this code is good.

Reviewed-by: Adam Young <admiyo@os.amperecomputing.com>




>
