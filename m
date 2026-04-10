Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FB34321A;
	Fri, 10 Apr 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812511; cv=none; b=PROIq8Mqcf4e53xa0j/B8JDkzoEdA8UT5drm1fiJFl6lwU0B368uDAoI8YZIYPlOtbWaADvpZfss8xhB70gnznNCXAiEusDvHoodkjoKkUXIuj/uki8RtDvH41mBptJItdT+ooXrJZ6Uc1qE5KRLFkvbLm/bDzxSGCNjhN1ECGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812511; c=relaxed/simple;
	bh=JpJa58PoMonttvOLt93H63JO+wZyum3SsSQWwUbLqxk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=GFQsOlC7mPc9tnxMlCLUlCng/YS74Q45Ec4OFnCT9bEdAeTs6pb7O30SeVjR1UUy9QJylYJV0CTENg40UkOjwIPXBTaSeL5TTPzBURg37DiBzjaR3SCKOv4jSAAZyZHzvZuozfnpjhQJg2g9vFBnK1mIxWAuNSGJgpD9lX2hM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=cCNCogFy; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="cCNCogFy"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hiuHSJPUy25iXosBBBzHGzNPzJaExohOieP/SPCUJ9E=;
	b=cCNCogFyoEMDLJjkxhasTxsr0CJOI710rUJ/Bdich43SchhMHEeQIC57phcA9YN/+e4JenXC4
	DpKhWii83+c9hiNYN+c+adFe+TPwNTvmcfCnREwuE6Ob5Y0BUen+/szV43V5M1FAFgnPlfCfT7z
	UGH6ax3sq1OVqVPE5Nz74cQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fsWFG2HLvzRhTY;
	Fri, 10 Apr 2026 17:08:50 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 981B14048F;
	Fri, 10 Apr 2026 17:15:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Apr 2026 17:15:05 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 10 Apr
 2026 17:15:04 +0800
Message-ID: <750f63b0-2a66-4fe6-93fc-983cc5340a1c@huawei.com>
Date: Fri, 10 Apr 2026 17:15:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mailbox: pcc: Mark Tx as complete in PCC IRQ handler
From: "lihuisong (C)" <lihuisong@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
 <7c351acf-aa0e-4e2e-89de-f296b3abd956@huawei.com>
In-Reply-To: <7c351acf-aa0e-4e2e-89de-f296b3abd956@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Sudeep,

On 10/20/2025 12:08 PM, lihuisong (C) wrote:
>
> 在 2025/10/17 3:08, Sudeep Holla 写道:
>> The PCC IRQ handler clears channel-in-use and notifies clients with
>> mbox_chan_received_data(), but it does not explicitly mark the
>> transmit as complete. In IRQ completion mode this could leave Tx 
>> complete
>> waiters hanging or lead to generic timeouts in the mailbox core.
>>
>> Invoke mbox_chan_txdone() in the IRQ path once the platform has
>> acknowledged the transfer so the core can wake any waiters and update
>> state accordingly.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/mailbox/pcc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 327e022973db..33bd2d05704b 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -341,6 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>        */
>>       pchan->chan_in_use = false;
>>       mbox_chan_received_data(chan, NULL);
>> +    mbox_chan_txdone(chan, 0);
> Normally, this interface is called by mbox client.
> So, IMO, this added code is not ok for mbox client.
> AFAIS, this code should be for type4, right?
> If so, the mbox client of type 4 channel has  responsibility to call 
> this interface.
I found that this patch has been merged into master.
The mbox_chan_txdone will be called twice in some mbox client drivers.
Can you take a look at my above reply? Normally, the rx_callback is used 
to wake up waiter.

/Huisong
>>         pcc_chan_acknowledge(pchan);
>>
>
