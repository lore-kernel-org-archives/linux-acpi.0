From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 11:46:21 +0800
Message-ID: <94fde58d-0869-83e3-b095-7ce78690b04c@cn.fujitsu.com>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <46ea45ad-e2de-27f6-e71a-6908703a48cf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:23590 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751509AbdBODqa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2017 22:46:30 -0500
In-Reply-To: <46ea45ad-e2de-27f6-e71a-6908703a48cf@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi, Hanjun

Thank you for your help!

[...]
>
> Sorry, a little bit confused, local APIC entries are listed in
> MADT by firmware, and MADT is a static table which means the OS
> will not update the orders.
>

Yes, MADT will never be updated after booting time.

My concern is how do the firmware arrange the order of the local
APIC entries in MADT.

I found the local APIC entries which its processor enable flag was
1 would be sorted close to the front of MADT.

I startup the computer twice,

1. I don't use the local APIC IDs with 0x10 and 0x12.
There are just 2 online CPUs in the computer in the booting time.
The MADT likes:

-------MADT---------
Apic Id | Enable Flag
0x00        1
0x02        1
0x04        0
0x06        0
0x10        0
0x12        0
0x14        0
0x16        0
-------------------------------------

2. I use the local APIC IDs with 0x10 and 0x12. Then, startup the
computer. There are 4 online CPUs.
The MADT likes:
------MADT-------
Apic Id | Enable Flag
0x00        1
0x02        1
0x10        1
0x12        1
0x04        0
0x16        0
0x14        0
0x16        0

The position of the 0x10 and 0x12 is changed.

>>
>>
>> 2: If the order rule can be changed ?
>> If it can be done, What should I do?
>
> What's the issue you are facing? any problem here?

Sorry, I do not describe it clearly.
please see the email, which i have cc-ed to you.

Thanks,
Liyang.

>
> Thanks
> Hanjun
>
>
>


