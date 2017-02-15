From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: Two questions about the MADT in ACPI table
Date: Wed, 15 Feb 2017 16:01:01 +0800
Message-ID: <67d1764f-b740-c79b-2f24-9adb6dc79609@cn.fujitsu.com>
References: <5f035cfc-3de1-235d-b387-cd7add94a5e1@cn.fujitsu.com>
 <CAJZ5v0hSJUi8UEayDGmCRirW7GuzWbHvoZsveDLkVmNh_-sswg@mail.gmail.com>
 <97d15525-d344-1bd8-d9e0-27a444e8d24f@cn.fujitsu.com>
 <be0c3ff6-321d-e3c1-2b19-6d917281368e@cn.fujitsu.com>
 <c1973231-d7c3-ef76-888c-a6371bd5982f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:30964 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751067AbdBOIBO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2017 03:01:14 -0500
In-Reply-To: <c1973231-d7c3-ef76-888c-a6371bd5982f@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi,

>>>>
>>>> Are you asking about Local APIC IDs?
>>>>
>>>
>>> Yes, it is. Something about *Processor Local APIC Structure*.
>>>
>>> In MADT, Their arrangement may be different between the usable
>>> processors and unusable processors(Processor Enabled is 1 or 0
>>> in MADT).
>>>
>>> The rule of the arrangement seems like that it makes the usable
>>> processors in front of the unusable processors, when we generate
>>> the MADT at the booting time. And it seems do not care about the
>>> arrangement of the unusable processors.
>>>
>>> Unfortunately, the unusable processors will be used in CPU hotplug.
>>> And we also make the cpu_id <-> apic_id fixed according to the MADT
>>> after linux-4.9. So the arrangement may be influence on the value of
>>> CPUIds.
>
> Can you specify the issues?

OK,

maybe the logical CPU IDs are not
> continuous in a numa node even two CPUs are hyper-threadings
> in one core?
>

Yes, it is. The logical CPU IDs may be not serial, when we
use "lscpu" in the OS. it may like that:

NUMA node0 CPU：    0-23,256-279
NUMA node1 CPU：    24-47,280-303

Or even like

Node2: 64-69, 72-77, 80-85, 88-93, 320-325, 328-333, 336-341 344-349
Node3: 96-101, 104-109, 112-117, 120-125, 352-357, 360-365, 368-373, 376-381

The reason :

1. We make the cpu_id <-> apic_id fixed according to the MADT. details
see in commit f7c28833c252031bc in kernel upstream tree.
2. We may have a Local APIC entry in MADT, but it has not Corresponding
processor device in DSDT. and the Local APIC entry also occupy an
logical CPU ID.

So, the seqence of logical CPU IDs will skip it. and will not be serial.

As the ACPI table is not reliable, if we fix it, we may need do in
software level.

And now, I don't have a good way to fix it.
So, I guess I need more knowledge about the ACPI table.

>>>
>>> I am investigating this. So I hope to know:
>>>
>>> 1. How the MADT is generated, Where can I find the Method/Function of
>>> the generation?
>
> It depends on the firmware I think and lots of them are not open source,
> you may try the UEFI tianocore project (www.tianocore.org).
>

I will have a look.

>>>
>>> 2. Is there a rule used for the order of the Local APIC/x2APIC IDs?
>
> I think not, there is no rules in the ACPI spec for the ordering
> of processor entries (local apic/x2apic/gicc).
>

As you say, normally, by digital order default.

Thanks
Liyang.


