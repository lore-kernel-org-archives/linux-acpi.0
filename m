From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Fri, 25 Aug 2017 10:06:11 +0800
Message-ID: <5cf1fea0-3f7f-8eda-bc89-4ad42e8d4f25@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <a8024347-ce0b-c59b-74ea-45a822e54ee6@cn.fujitsu.com>
 <8d662105-2ff5-02fd-9072-73167e5f49c1@cn.fujitsu.com>
 <4971374.QgHTRTZW1k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19775 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754191AbdHYCGV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2017 22:06:21 -0400
In-Reply-To: <4971374.QgHTRTZW1k@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "Zheng, Lv" <lv.zheng@intel.com>, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, bhe@redhat.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-acpi@vger.kernel.org, Julian Wollrath <jwollrath@web.de>, Borislav Petkov <bp@alien8.de>

Hi Rafael,

At 08/25/2017 12:38 AM, Rafael J. Wysocki wrote:
> On Thursday, August 24, 2017 5:54:28 AM CEST Dou Liyang wrote:
>> Hi Rafael, Zheng,
>>
>> At 07/31/2017 06:50 PM, Dou Liyang wrote:
>>> Hi,
>>>
>>> At 07/14/2017 01:52 PM, Dou Liyang wrote:
>>>> Linux uses acpi_early_init() to put the ACPI table management into
>>>> the late stage from the early stage where the mapped ACPI tables is
>>>> temporary and should be unmapped.
>>>>
>>>> But, now initializing interrupt delivery mode should map and parse the
>>>> DMAR table earlier in the early stage. This causes an ACPI error when
>>>> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
>>>> the DMAR table after using in the early stage.
>>>>
>>>> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
>>>> be mapped and parsed in late stage like before.
>>>>
>>>> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>> Cc: linux-acpi@vger.kernel.org
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Zheng, Lv <lv.zheng@intel.com>
>>>> Cc: Julian Wollrath <jwollrath@web.de>
>>>> ---
>>>> Test in my own PC(Lenovo M4340).
>>>> Ask help for doing regression testing for the bug said in commit
>>>> c4e1acbb35e4
>>>> ("ACPI / init: Invoke early ACPI initialization later").
>>>>
>>>
>>> Now, I can prove this patch doesn't result in the bug[1] which made the
>>> fast TSC calibration using PIT failed in a Thinkpad x121e (AMD E-450
>>> APU).
>>>
>>> The true reason of the bug is enabling ACPI subsystem earlier than
>>> using PIT, not the SCI setup. invoking acpi_enable_subsystem() later
>>> could fix this bug as Julian tested and said[2].
>>>
>>> And, I found that Commit b064a8fa77df (" ACPI / init: Switch over
>>> platform to the ACPI mode later") split the ACPI early initialization
>>> code into acpi_early_init() and acpi_subsystem_init(). executing
>>> acpi_enable_subsystem() at the original early ACPI initialization spot.
>>>
>>> The sequence of them shows below:
>>>
>>>  start_kernel
>>> +---------------+
>>> |
>>> +--> .......
>>> |
>>> |    late_time_init()
>>> +--> +-------+
>>> |
>>> +--> .......
>>> |
>>> |    acpi_early_init()
>>> +--> +-------+
>>> |
>>> +--> .......
>>> |
>>> |   acpi_subsystem_init()
>>> +-> +--------+
>>>
>>> We make sure the acpi_subsystem_init() is called later than
>>> late_time_init(), the bug will be avoided.
>>>
>>> This patch changes the sequence of late_time_init() and
>>> acpi_early_init(), doesn't effect acpi_subsystem_init().
>>>
>>> So, this patch is OK.
>>>
>>> Btw, Thanks very much for Borislav Petkov, he will have access to
>>> Thinkpad x121e from Mid-August and will test this series.
>>>
>>
>> Almost one month passed, Borislav have tested this series in Thinkpad
>> x121e and I also have tested in my box and QEmu again. It is OK.
>>
>> BTW,
>> 1) I found your commit b064a8fa77df (" ACPI / init: Switch over
>> platform to the ACPI mode later") split the ACPI early initialization
>> code into acpi_early_init() and acpi_subsystem_init(). Actually enabling
>> the ACPI subsystem is in acpi_subsystem_init().
>>
>> 2) As we discussed earlier, invoking acpi_put_table() is not good for
>> this situation.
>>
>> So I do this patch, Is that goot to you? Any comments will be welcome.
>>
>> If it is OK, As the patches need to be re-based, and I also found
>> several spelling mistake, I will send a new version next week.
>
> OK, but does it depend on anything?  Or does anything depend on it?
>

It depends on nothing and can be considered independent.

[11/13] patch in this series depends on it. [11/13] patch caused an
ACPI error, we used this patch to fix it.

> It is [12/13] in a series, so it looks like it doesn't depend on the
> previous patches in it, but the next one may depend on it?  Which is the
> case?
>

The second case(the next one may depend on it) is what I want.

But, seems I made a mistake about the order of the patches. I should
put it before [11/13] to avoid the ACPI error.

I will adjust the order of the patches in the next version, and post
the whole series to you.

Thanks,
	dou.


