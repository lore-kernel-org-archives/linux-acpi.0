Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBC243367;
	Thu,  9 Jul 2026 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603073; cv=none; b=aB+fKPLBqe+CCeQrry39A5oPO2u0BAhWXDOKzQXx14dMSxtODsxqpxZE1uJrYqYzmV8hkwZaVIrgk4LtGHZkqdqUYaNOlePIo4YIi/xrtezF6c+bw57ZaCxd4/LQfL9IUrBryWmQsxyWCPW2A4YkhBe9q69yncfCNYu/sqIY+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603073; c=relaxed/simple;
	bh=0cF4ibeVD97h1awZK5wZBkdJ1W291Cs6ylQSrqG4ETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mj75t+qwmqzNslZcXX+/yWgA4V0qwhlFfPOiHkdpJAFG6JCSXBA9Ffthaj1tWMnfEw+AxDlXrO8Xlq8Pz63/gXW5qzL0VRamvwNhEKW3cK++0iCom5aWhXR67yVL/Zf+WAyFJBtIXnLaAtNAsLDzuuPDHuOr14OJxCpjVHG+yZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=H1fmWLyT; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="H1fmWLyT"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0cF4ibeVD97h1awZK5wZBkdJ1W291Cs6ylQSrqG4ETA=;
	b=H1fmWLyTQbhuwZJK4QrdVE51GieYxL1vrMoClxJ/hw0ngI6PS5piH1vKm/YoTTWMXU2YykAvk
	bK+glrtgyRQuGCKnXv2e6L/unojiHVLDsbOUaaTlPLrkgm+BvQC4TTOJoVR690z4o34r3JYt48X
	yh0ajoI1DjL0r0cTHJxPddI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwwJG4BGBz1prLD;
	Thu,  9 Jul 2026 21:08:30 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
	by mail.maildlp.com (Postfix) with ESMTPS id 527692012A;
	Thu,  9 Jul 2026 21:17:47 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemo100005.china.huawei.com
 (7.202.195.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 9 Jul
 2026 21:17:46 +0800
Message-ID: <56a266ac-f651-4551-9ce0-151f7320a916@huawei.com>
Date: Thu, 9 Jul 2026 21:17:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: pcc: Fix command timeout due to missed
 interrupt
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>
References: <20260709114115.3113315-1-lihuisong@huawei.com>
 <20260709-thick-quirky-dog-edfcf1@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260709-thick-quirky-dog-edfcf1@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100005.china.huawei.com (7.202.195.212)


On 7/9/2026 8:24 PM, Sudeep Holla wrote:
> On Thu, Jul 09, 2026 at 07:41:15PM +0800, Huisong Li wrote:
>> PCC command execution can time out when a fast platform completes a
>> transaction and signals the platform interrupt before pcc_send_data()
>> marks the channel as in use. For shared platform interrupts, the type 3
>> handler uses chan_in_use to decide whether the interrupt belongs to the
>> channel. If it observes false, it ignores the completion and the caller
>> waits until timeout.
>>
>> Publish chan_in_use before ringing the doorbell. Use WRITE_ONCE() for
>> the lockless flag update and READ_ONCE() in the interrupt handler when
>> filtering shared interrupts. The following ordered MMIO accessor used for
>> the doorbell keeps the earlier store visible before the platform is
>> notified.
>>
>> Clear chan_in_use with WRITE_ONCE() when completing the transaction,
>> matching the lockless flag protocol used by the interrupt and send paths.
>>
>> Fixes: 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple subspaces")
>> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> Sorry if I gave mixed feedback, you can't have both my signoff and reviewed-by
> at the same time. You need to drop one of them.
Sorry, will drop signoff.
>
