From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 14:42:33 +0800
Message-ID: <66316e54-f8e5-f657-c6ce-459877a55889@linaro.org>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <46ea45ad-e2de-27f6-e71a-6908703a48cf@linaro.org>
 <94fde58d-0869-83e3-b095-7ce78690b04c@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34011 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdBOGng (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2017 01:43:36 -0500
Received: by mail-pg0-f47.google.com with SMTP id z67so2406907pgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2017 22:43:35 -0800 (PST)
In-Reply-To: <94fde58d-0869-83e3-b095-7ce78690b04c@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

On 2017/2/15 11:46, Dou Liyang wrote:
> Hi, Hanjun
>
> Thank you for your help!
>
> [...]
>>
>> Sorry, a little bit confused, local APIC entries are listed in
>> MADT by firmware, and MADT is a static table which means the OS
>> will not update the orders.
>>
>
> Yes, MADT will never be updated after booting time.
>
> My concern is how do the firmware arrange the order of the local
> APIC entries in MADT.
>
> I found the local APIC entries which its processor enable flag was
> 1 would be sorted close to the front of MADT.
>
> I startup the computer twice,
>
> 1. I don't use the local APIC IDs with 0x10 and 0x12.
> There are just 2 online CPUs in the computer in the booting time.
> The MADT likes:
>
> -------MADT---------
> Apic Id | Enable Flag
> 0x00        1
> 0x02        1

Digital order.

> 0x04        0
> 0x06        0
> 0x10        0
> 0x12        0
> 0x14        0
> 0x16        0

Same here...

> -------------------------------------
>
> 2. I use the local APIC IDs with 0x10 and 0x12. Then, startup the
> computer. There are 4 online CPUs.
> The MADT likes:
> ------MADT-------
> Apic Id | Enable Flag
> 0x00        1
> 0x02        1
> 0x10        1
> 0x12        1

And digital order...

> 0x04        0
> 0x16        0

0x06?

> 0x14        0
> 0x16        0
>
> The position of the 0x10 and 0x12 is changed.

So your firmware will list enabled CPUs first and
them disabled one, both in digital order, and lot of
firmware (but not all of them) doing the same thing.

Thanks
Hanjun
