From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 11:54:44 +0800
Message-ID: <9e98a77d-5ffd-36f1-2515-916b3450a097@cn.fujitsu.com>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <CAJZ5v0hSJUi8UEayDGmCRirW7GuzWbHvoZsveDLkVmNh_-sswg@mail.gmail.com>
 <97d15525-d344-1bd8-d9e0-27a444e8d24f@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:1369 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751410AbdBODyz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2017 22:54:55 -0500
In-Reply-To: <97d15525-d344-1bd8-d9e0-27a444e8d24f@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>

Adding a simple example:

I startup a pc twice.

*1.* There are just 2 online CPUs in the pc at booting time.
The MADT likes:

-------MADT---------
Apic Id | Enable Flag
0x00        1
0x02        1
0x04        0
0x06        0
*0x10*        0
*0x12*        0
0x14        0
0x16        0
-------------------------------------

*2.*  There are 4 online CPUs in the pc. Then, startup it.
The new CPUs use the local APIC IDs with 0x10 and 0x12.
The MADT likes:
------MADT-------
Apic Id | Enable Flag
0x00        1
0x02        1
*0x10*       1
*0x12*       1
0x04        0
0x16        0
0x14        0
0x16        0

The position of the 0x10 and 0x12 is changed.

[...]

>> Are you asking about Local APIC IDs?
>>
>
> Yes, it is. Something about *Processor Local APIC Structure*.
>
> In MADT, Their arrangement may be different between the usable
> processors and unusable processors(Processor Enabled is 1 or 0
> in MADT).
>
> The rule of the arrangement seems like that it makes the usable
> processors in front of the unusable processors, when we generate
> the MADT at the booting time. And it seems do not care about the
> arrangement of the unusable processors.
>
> Unfortunately, the unusable processors will be used in CPU hotplug.
> And we also make the cpu_id <-> apic_id fixed according to the MADT
> after linux-4.9. So the arrangement may be influence on the value of
> CPUIds.
>
> I am investigating this. So I hope to know:
>
> 1. How the MADT is generated, Where can I find the Method/Function of
> the generation?
>
> 2. Is there a rule used for the order of the Local APIC/x2APIC IDs?
>
> Thanks,
>  Liyang


