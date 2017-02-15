From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 14:36:06 +0800
Message-ID: <c1973231-d7c3-ef76-888c-a6371bd5982f@linaro.org>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <CAJZ5v0hSJUi8UEayDGmCRirW7GuzWbHvoZsveDLkVmNh_-sswg@mail.gmail.com>
 <97d15525-d344-1bd8-d9e0-27a444e8d24f@cn.fujitsu.com>
 <be0c3ff6-321d-e3c1-2b19-6d917281368e@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35215 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdBOGhA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2017 01:37:00 -0500
Received: by mail-pf0-f172.google.com with SMTP id 202so26060275pfx.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2017 22:37:00 -0800 (PST)
In-Reply-To: <be0c3ff6-321d-e3c1-2b19-6d917281368e@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2017/2/15 11:18, Dou Liyang wrote:
> ccing Hanjun

Thank you for adding me in the loop.

>
> At 02/15/2017 10:53 AM, Dou Liyang wrote:
>> Dear, Rafael
>>
>> At 02/14/2017 06:18 AM, Rafael J. Wysocki wrote:
>>> On Mon, Feb 13, 2017 at 2:31 PM, Dou Liyang
>>> <douly.fnst@cn.fujitsu.com> wrote:
>>>> Hi, Rafael, Lv
>>>>
>>>> May I ask for your help.
>>>>
>>>> Recently, I am very confused about the generation of the MADT
>>>> in ACPI table.
>>>>
>>>> 1: Why we put all the Apic Ids which flag==1 in front of the
>>>> one which flag==0 in MADT?
>>>>
>>>> Just like that:
>>>>
>>>> -----orginal----------|-------MADT-------
>>>> Apic Id | Enable Flag |   Apic Id | Enable Flag
>>>> 0x00        1               0x00    1
>>>> 0x02        1               0x02    1
>>>> 0x04        0               0x10    1
>>>> 0x06        0               0x12    1
>>>> 0x10        1               0x04    0
>>>> 0x12        1               0x06    0
>>>> 0x14       0               0x14    0
>>>> 0x16        0               0x16    0
>>>>
>>>> If the flag is the same, It will not change the order.
>>>>
>>>> -----orginal----------|-------MADT---------
>>>> Apic Id | Enable Flag |  Apic Id | Enable Flag
>>>> 0x00        0               0x00    0
>>>> 0x02        0               0x02    0
>>>> 0x04        0               0x04    0
>>>> 0x06        0               0x06    0
>>>> 0x10        0               0x10    0
>>>> 0x12        0               0x12    0
>>>> 0x14        0               0x14    0
>>>> 0x16        0               0x16    0
>>>>
>>>>
>>>> 2: If the order rule can be changed ?
>>>> If it can be done, What should I do?
>>>
>>> Are you asking about Local APIC IDs?
>>>
>>
>> Yes, it is. Something about *Processor Local APIC Structure*.
>>
>> In MADT, Their arrangement may be different between the usable
>> processors and unusable processors(Processor Enabled is 1 or 0
>> in MADT).
>>
>> The rule of the arrangement seems like that it makes the usable
>> processors in front of the unusable processors, when we generate
>> the MADT at the booting time. And it seems do not care about the
>> arrangement of the unusable processors.
>>
>> Unfortunately, the unusable processors will be used in CPU hotplug.
>> And we also make the cpu_id <-> apic_id fixed according to the MADT
>> after linux-4.9. So the arrangement may be influence on the value of
>> CPUIds.

Can you specify the issues? maybe the logical CPU IDs are not
continuous in a numa node even two CPUs are hyper-threadings
in one core?

>>
>> I am investigating this. So I hope to know:
>>
>> 1. How the MADT is generated, Where can I find the Method/Function of
>> the generation?

It depends on the firmware I think and lots of them are not open source,
you may try the UEFI tianocore project (www.tianocore.org).

>>
>> 2. Is there a rule used for the order of the Local APIC/x2APIC IDs?

I think not, there is no rules in the ACPI spec for the ordering
of processor entries (local apic/x2apic/gicc).

Thanks
Hanjun
