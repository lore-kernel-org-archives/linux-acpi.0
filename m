Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454803A4F27;
	Tue, 21 Apr 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770507; cv=none; b=FxfN92q5wrE9vfbO7Mc9kMBXI2VsjIZU6fn0c7tUO758yX0fnqgDABraIq+AwT9u7MT1gY5+91E8ki1Ctj0a409h1LW7IyAmSiHUBrp0+viEUCzgWDZUYtEfYp2G6VSWdQHacOVCScml+Zg52uOETTbE8rjmCLjhfB2RfgeBrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770507; c=relaxed/simple;
	bh=J8hfM3s1Lmand7b4QHRAo+ScSPTBNTeZ2aG7R2AmlOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m+GF2teHaoQvFMy+9mXc6jjrWkzx7xWIs9IRW6O/RhY7CQZ64LxIPw95pZKSSqamgsx/RVz2/AN0538jYPRzV5v/Dh7uIjQ3HRJJnnccKodOvKtGLIUOwRBlM3jq+cOUThfsr6AWqktoCU6SZDjl0mh4A1p/NHJbmgCxYTwWnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=KNI0VGav; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="KNI0VGav"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=15Xq7ek14sZXnjRkTZwHXvQJA85fQWqMNFMUj4GZmxE=;
	b=KNI0VGavsdOu14VL6+AZb5okouRFzvvvzSa4r9Xfk1XYqBww3i9sEyq0J3Z3r3zGyTXRfuOcp
	WyfZurYXYZmqOo1O8IDkrpYN6Wvnz7skNkqrQkw0H/xtlOGQd+gdBT8qQ/NceT/0yStoYKyiXt+
	gpRCqA7gfbQkx6Ke2Esy1do=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4g0KX22zcMz1cyPZ;
	Tue, 21 Apr 2026 19:15:14 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E4940563;
	Tue, 21 Apr 2026 19:21:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 19:21:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 21 Apr
 2026 19:21:34 +0800
Message-ID: <b3c7b3b0-e885-4ded-8de4-064a5e482696@huawei.com>
Date: Tue, 21 Apr 2026 19:21:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>, Robbie King
	<robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
 <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/21/2026 6:05 PM, Sudeep Holla wrote:
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
> Are you seeing the issue on real platforms or you are just reviewing the
> code. I would like to test it on the platform I use but I don't have it
> handy, so may take some time.
Yeah, this is a real issue on my platform. It is probabilistic.
And the problem is gone after this modification.

Gemini AI help me to analyze and suggest that I fix it as this patch done.

>
> I have added Robbie King who also has helped in testing this PCC driver
> in the past.
Thanks. Please help review this patch.
>
