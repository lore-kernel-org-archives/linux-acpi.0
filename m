Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4163CAA3F;
	Tue, 23 Jun 2026 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201958; cv=none; b=GozL1ii4d5UJE/kkHYVgMA+iWYQz2RypCpkc3NfS9Q+Dtn8GVF2TlukRD/DDXoSg0TZLG59jqks2NkDtprCWeXRdPmw4qFcwIkNrdje/VcCO2pyckMZ9efb6GYjfElEOdD68SiOfjsLauG0yYK57rnO39URSXtJgwISVewfu1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201958; c=relaxed/simple;
	bh=153lM0pzEINHCDuMADyMsYaAYOMwYx72MIPvO1rqads=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nWHUwgR2ctzRBQFVP4IF0dLv0dXdU/JPleVvo20PdLM9bkojtx817244jEtlDVsBNTA1PnTWSz7gHDnGtDPxOtGGaE9ey+X6/+EXz6kEL+7Y6ibZYaGsOAArn2cVt/Ydgf6hs9VbzXV0cIXU5drq8r2mMAsRqaHoJB0u4Q2heu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=khnuqoaV; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="khnuqoaV"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TOkmwWE8Lsuu53M8hlWmYt6+438LfZXwtjLUkQZtUvA=;
	b=khnuqoaVQZJpdcE1I/3sgCY0Oga5pg3eQ+sJFZ/MDxJkkKELMrga5Ym6k0FfL5NepIEIhn3tC
	fIdk3cyhU62MDloTv3wfbL7glTPKMxfGLOpbErwOslD2kdARYWUv8T9SsNh8lcJgGlI2U8gjdTL
	Ikyeq5aGFGfPP1qv9tyAM/c=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gky7r2FDdzmV97;
	Tue, 23 Jun 2026 15:56:40 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B955402AB;
	Tue, 23 Jun 2026 16:05:45 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Jun
 2026 16:05:44 +0800
Message-ID: <81899d1b-fd49-467f-8e64-1dd0632e76c8@huawei.com>
Date: Tue, 23 Jun 2026 16:05:43 +0800
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
	<linux-kernel@vger.kernel.org>, <lihuisong@huawei.com>
References: <20260612170225.1063902-1-sudeep.holla@kernel.org>
 <4e2d023b-c651-4a80-ba14-3c66cd209214@huawei.com>
 <20260618-discreet-sparkling-dragon-7df7b2@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260618-discreet-sparkling-dragon-7df7b2@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 6/18/2026 8:06 PM, Sudeep Holla wrote:
> On Thu, Jun 18, 2026 at 10:04:12AM +0800, lihuisong (C) wrote:
>> Hi Sudeep,
>>
>> On 6/13/2026 1:02 AM, Sudeep Holla wrote:
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
>>> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
>>> ---
>>>    drivers/mailbox/pcc.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>> index 636879ae1db7..7c9451ab4527 100644
>>> --- a/drivers/mailbox/pcc.c
>>> +++ b/drivers/mailbox/pcc.c
>>> @@ -447,9 +447,14 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>>>    static bool pcc_last_tx_done(struct mbox_chan *chan)
>>>    {
>>> +	bool ret;
>>>    	struct pcc_chan_info *pchan = chan->con_priv;
>>> -	return pcc_mbox_cmd_complete_check(pchan);
>>> +	ret = pcc_mbox_cmd_complete_check(pchan);
>>> +	if (ret && !pchan->plat_irq)
>>> +		mbox_chan_received_data(chan, NULL);
>>> +
>>> +	return ret;
>>>    }
>> The mailbox_controller.h said that .last_tx_done() is used only if
>> txdone_poll:=true && txdone_irq:=false.
>> How about add a verification at the begining of this function? like "if
>> (chan->txdone_method != MBOX_TXDONE_BY_POLL) return false;"
>> And then call mbox_chan_received_data() directly if command completed.
>>
> Thanks, it does makes sense to me. I will have look.
>
>> This patch is ok to me if has above changes.
>> Acked-by: lihuisong@huawei.com
>>
>>
>> But pcc mbox controller can no longer work in MBOX_TXDONE_BY_ACK after your
>> commit:
>> 3349f800609e (mailbox: pcc: Set txdone_irq/txdone_poll based on PCCT flags).
>> This may lead to above client drivers fail to send mailbox command, like
>> cppc_acpi,hisi_uncore_freq and kunpeng_hccs.
>> Because these client driver knows tx_done(knows_txdone: true), work on this
>> mode and need to call mbox_client_txdone.
>> Do you have some idea for this?
> I wonder if we can ask the platform to avoid generating interrupts in those
> case by setting/clearing "Notify on completion" in shmem. Do you think that
> would work ?
Hi Sudeep，

Review this logic again.
The mbox_bind_client is called on requesting PCC channel.
And mbox_bind_client could modify chan->txdone_method to 
MBOX_TXDONE_BY_ACK if client knows txdone and 'txdone_method' is 
MBOX_TXDONE_BY_POLL.
So I think your above commit is ok for these client drivers.

/Huisong

