Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2013C061E;
	Tue, 26 May 2026 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776923; cv=none; b=nHteXnauvgakmJkYC189fLucgwARg51OpmTjGyp7C7LNYPYi5jHNA39BQ5yW/FseJcrRqjQrkTGjP8UFdHmas1+gnFzPKf3ot61+COyNk0ETVWi6vnhxCX9rAbOKiDZUpq4g7T3lCnUSbx18V1JTznjJrshoBcTMvozLtGY9wMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776923; c=relaxed/simple;
	bh=mJfui2roC4nhqmIH2ULxht+JqCC+BJTRtlo+R4OE++w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=APWDZVLnlxSRmPBSH/MMLBvJ2zhvJ3I4enGkBTO/Ss7W2JxCknXHsFO80YexAUb2h88XhfUKbx+x3HcxgxKnMHtWxe+DNPlU5XOL9xrxiStysuWWfd0lXtYdokS0wdydvbqFBjHelTd568i63vhYh7k5uktf9FcCMQkfT4e2q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=rH0sDHfg; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="rH0sDHfg"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eUQXiKw8zvq+6xidFpWowMOGcsF/5I2728PWUv5GKDE=;
	b=rH0sDHfgzGJFnXCRUYbKFA7sc0U8Ng4+RKN3NgIdS0Faibcm7M0nK7BKsW4PUq26mvwixhZWZ
	JYgQXveOl31hNMz/uXC/W1bR0WoIpfzhB9oarPPJQyKAvtRtLrcOkb0hGWpJAPaKLJPS8AXm2Jr
	Q7XaFk1Bnnz3hcuQhqFOI7g=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gPjKx3kYgz1T4Hh;
	Tue, 26 May 2026 14:20:37 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C48940577;
	Tue, 26 May 2026 14:28:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 14:28:23 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 26 May
 2026 14:28:22 +0800
Message-ID: <72499009-892c-42b9-93b2-5729ddd5cc71@huawei.com>
Date: Tue, 26 May 2026 14:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
To: Robbie King <robbiek@xsightlabs.com>, Sudeep Holla
	<sudeep.holla@kernel.org>
CC: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
References: <20260417031429.2509443-1-lihuisong@huawei.com>
 <20260421-adventurous-victorious-caiman-dce291@sudeepholla>
 <27794f6b-cd8f-4b38-a5c0-eed30858f8e2@xsightlabs.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <27794f6b-cd8f-4b38-a5c0-eed30858f8e2@xsightlabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 4/27/2026 10:28 PM, Robbie King wrote:
> On 4/21/2026 6:05 AM, Sudeep Holla wrote:
>> On Fri, Apr 17, 2026 at 11:14:29AM +0800, Huisong Li wrote:
>>> In some scenarios, PCC command may experience probabilistic timeout.
>>> This is primarily caused by the chan_in_use flag being updated after
>>> ringing the doorbell, coupled with a lack of proper memory barriers
>>> across CPU cores.
>>>
>>> On fast platforms, a race condition occurs: the platform processing
>>> completes and triggers an interrupt before the local CPU sets
>>> chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
>>> it reads chan_in_use as false and incorrectly ignores the interrupt.
>>>
>>> This patch fixes the race by:
>>> 1. Moving the chan_in_use update before ringing the doorbell.
>>> 2. Using smp_store_release() to ensure the flag update is visible
>>>     to other cores before subsequent hardware or software actions
>>>     are triggered.
>>> 3. Using smp_load_acquire() in the interrupt handler to ensure the
>>>     latest flag value is read before deciding to skip the interrupt.
>>>
>> Are you seeing the issue on real platforms or you are just reviewing the
>> code. I would like to test it on the platform I use but I don't have it
>> handy, so may take some time.
>>
>> I have added Robbie King who also has helped in testing this PCC driver
>> in the past.
>>
> I was unable to apply the patch to our current kernel version.  We are in the
> process of updating our kernel modules to support 7.0, once that effort is
> finished I can run a few of our current regressions against the patch.
Hi Robbie King,
Can you help test this patch now?
Or we can fix the conflict to test it on your current kernel.
