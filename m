Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA207390203;
	Fri, 27 Mar 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592608; cv=none; b=QlNlKCKO4eM2KTSoDPaIRPqH5r0/pKzx+ddCLld0S6fEaxwd1MDcCmN2p+K+mdfuGkE/7feBNbz3KolaFmmCesxGu6c57kVbruBp8XZpLA60N0OHhIlDRZSLpCQfdWKwFfu/7rqNH7oCqYY2Riu7RQFw9t7jYaHwJ+HdIHwNsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592608; c=relaxed/simple;
	bh=ce4RQ7hXrAiq8pfqE5vhgI8aoDUwiPrx1s6qvLSG1XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BOmr42+XsqqYV+DFAE+XbvLZQFv5CGBgwI9/vXPGdffWM5lwOO+u3xR0tGWYdIjj8VXjYsWMO1kH2FBaa8OPeODvD09dQpPW/UJz79m9K1nYLnvyj8Cd1wBLz9mMiFMlHrury/RowVDCzPHj536Jxw7U8YJ4IPdjstqtnX9Otrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Y374bQQY; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Y374bQQY"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ng6Qd2zdF+2nQBS2USkwcFgr03S5OOX6iEJmZlKhJ0g=;
	b=Y374bQQYKO2qdVjXZTgxIX9VafM4EaZxWu/R5QPG22vFZjLVehg/N3AekpMBO/Sa9dh830YzW
	cahf068gMCjS8dM/mfz0cTKgO9dUuxnulIFuwASQIr4ujmXZxYSx0OIi3AygdO+0/nQjrUZDOfP
	WYw2btGsBFaF3XFbufNC7zM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fhr6W47ZYz12LD3;
	Fri, 27 Mar 2026 14:17:55 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D34274056A;
	Fri, 27 Mar 2026 14:23:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Mar 2026 14:23:21 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 27 Mar
 2026 14:23:21 +0800
Message-ID: <3948b6fe-2aa6-4e38-9d58-c0e25e48fe93@huawei.com>
Date: Fri, 27 Mar 2026 14:23:16 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com>
 <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
 <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
 <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com>
 <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
> On Thu, Mar 26, 2026 at 1:17 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>> Hi Rafael,
>>
>> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
>>> Hi Rafael,
>>>
>>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
>>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
>>>>> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com>
>>>>> wrote:
>>>>>> The global switch of cpuidle can be turned back on in some case.
>>>>>> So add enable_cpuidle().
>>>>> No, this is not going to work.  The "off" switch only affects
>>>>> initialization AFAICS.
>>>> I think it would be work.
>>>> The cpuidle_not_available() also see the "off" on do_idle().
>>>> And cpuidle_idle_call() check this function first and then select
>>>> idle state.
>>>> Cpuidle doesn't select and enter idle state if this fuction return true.
>>> I verified that disable_cpuidle() effectively prevents all CPUs from
>>> entering any idle states and the cpuidle function is correctly
>>> restored after calling enable_cpuidle().
>>> What do you think?
>> Could you pleasetake a look atmy reply?
>> If not ok, I will drop this from my upstream list.
> Sorry, can you please remind me what problem you wanted to address
> with the help of this?
Regarding the discussion in the link[1], if driver fail to get power 
info in power notify,
the old idle states may no longer be reliable. Therefore, patch 2/3 
disables ACPI idle
via the new interface introduced in patch 1/3.

However, our discussion on whether this new interface can disable ACPI 
idle has not yet reached a conclusion.
Could you please revisit this thread? It's quite brief, and I'd 
appreciate your further input.

[1] 
https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com
