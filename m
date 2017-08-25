From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Fri, 25 Aug 2017 22:09:16 +0800
Message-ID: <b1144abb-da81-9975-6a10-918bd9ecba3f@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <4971374.QgHTRTZW1k@aspire.rjw.lan>
 <5cf1fea0-3f7f-8eda-bc89-4ad42e8d4f25@cn.fujitsu.com>
 <2641234.UytgA7eGhA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24772 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755202AbdHYOJX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Aug 2017 10:09:23 -0400
In-Reply-To: <2641234.UytgA7eGhA@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "Zheng, Lv" <lv.zheng@intel.com>, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, bhe@redhat.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-acpi@vger.kernel.org, Julian Wollrath <jwollrath@web.de>, Borislav Petkov <bp@alien8.de>

Hi Rafael,

At 08/25/2017 08:27 PM, Rafael J. Wysocki wrote:
> On Friday, August 25, 2017 4:06:11 AM CEST Dou Liyang wrote:
[...]
>>>>
>>>> BTW,
>>>> 1) I found your commit b064a8fa77df (" ACPI / init: Switch over
>>>> platform to the ACPI mode later") split the ACPI early initialization
>>>> code into acpi_early_init() and acpi_subsystem_init(). Actually enabling
>>>> the ACPI subsystem is in acpi_subsystem_init().
>>>>
>>>> 2) As we discussed earlier, invoking acpi_put_table() is not good for
>>>> this situation.
>>>>
>>>> So I do this patch, Is that goot to you? Any comments will be welcome.
>>>>
>>>> If it is OK, As the patches need to be re-based, and I also found
>>>> several spelling mistake, I will send a new version next week.
>>>
>>> OK, but does it depend on anything?  Or does anything depend on it?
>>>
>>
>> It depends on nothing and can be considered independent.
>
> OK
>
> Please send it as an independent patch, then.
>
>> [11/13] patch in this series depends on it. [11/13] patch caused an
>> ACPI error, we used this patch to fix it.
>
> So the ordering of patches in the series should be different, then.
>
> It should be ordered so as to avoid triggering the warning at all,
> so this patch should go before the [11/13].

Yes, Indeed.

>
>>> It is [12/13] in a series, so it looks like it doesn't depend on the
>>> previous patches in it, but the next one may depend on it?  Which is the
>>> case?
>>>
>>
>> The second case(the next one may depend on it) is what I want.
>>
>> But, seems I made a mistake about the order of the patches. I should
>> put it before [11/13] to avoid the ACPI error.
>
> Right.
>
>> I will adjust the order of the patches in the next version, and post
>> the whole series to you.
>
> Please just CC it to linux-acpi.

Got it. Will just CC it to linux-acpi, and CC the whole series to you.

Thanks,
	dou.
>
> Thanks,
> Rafael
>
>
>
>


