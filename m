From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Fri, 28 Jul 2017 10:28:34 +0800
Message-ID: <f3652999-a0a2-6c35-ac5d-e4e4bbd20235@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <1AE640813FDE7649BE1B193DEA596E886CEE2130@SHSMSX101.ccr.corp.intel.com>
 <d0ce9178-4b06-081b-6b12-a8cd1c5352b7@cn.fujitsu.com>
 <20170718084521.GC2344@x1>
 <0c13e0de-9a37-2992-ef00-20b6ad67dbc5@cn.fujitsu.com>
 <1AE640813FDE7649BE1B193DEA596E886CEE8365@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:28809 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751722AbdG1C2v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2017 22:28:51 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEE8365@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "bhe@redhat.com" <bhe@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "peterz@infradead.org" <peterz@infradead.org>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "tokunaga.keiich@jp.fujitsu.com" <tokunaga.keiich@jp.fujitsu.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Julian Wollrath <jwollrath@web.de>

Hi, Zheng

At 07/28/2017 09:53 AM, Zheng, Lv wrote:
[...]
>>
>>> Dmar hardware support interrupt remapping and io remapping separately. But
>>> intel_iommu_init() is called later than intel_prepare_irq_remapping().
>>> So what if make dmar_table_init() a reentrant function? You can just
>>> have a try, but maybe not a good idea, the dmar table will be parsed
>>> twice.
>>
>> Yes, It is precisely one reason that I gave up invoking
>> acpi_put_table().
>
> Parsing a table twice is not a problem on x86.
> If you check the code, there are many examples.
> It's actually required if you want to use a table both in early stage and late stage.
>

I am sorry I don't explain clearly.

Yeah, in current kernel, The DMAR table has been parsed twice as well.
one is in detect_intel_iommu(), the other is in dmar_table_init().

Here we focus on the reentrant dmar_table_init(), this func contains
many callback for parsing different DMAR type structures, such as DRHD,
RMRR.

acpi_put_table() can release the mapped DMAR address, but we should
clear the remapping structure types manually. and I think parsing these
DMAR type structures again may have an influence on interrupt remapping.


Thanks,

	dou.

> Thanks
>
>>
>> Thanks,
>>
>> 	dou.
>>
>>>
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> 	dou.
>>>>>
>>>>> Thanks
>>>>> Lv
>>>>>
>>>>>> From: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
>>>>>> Sent: Friday, July 14, 2017 1:53 PM
>>>>>> To: x86@kernel.org; linux-kernel@vger.kernel.org
>>>>>> Cc: tglx@linutronix.de; mingo@kernel.org; hpa@zytor.com; ebiederm@xmission.com; bhe@redhat.com;
>>>>>> peterz@infradead.org; izumi.taku@jp.fujitsu.com; tokunaga.keiich@jp.fujitsu.com; Dou Liyang
>>>>>> <douly.fnst@cn.fujitsu.com>; linux-acpi@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>;
>> Zheng,
>>>>>> Lv <lv.zheng@intel.com>; Julian Wollrath <jwollrath@web.de>
>>>>>> Subject: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization earlier
>>>>>>
>>>>>> Linux uses acpi_early_init() to put the ACPI table management into
>>>>>> the late stage from the early stage where the mapped ACPI tables is
>>>>>> temporary and should be unmapped.
>>>>>>
>>>>>> But, now initializing interrupt delivery mode should map and parse the
>>>>>> DMAR table earlier in the early stage. This causes an ACPI error when
>>>>>> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
>>>>>> the DMAR table after using in the early stage.
>>>>>>
>>>>>> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
>>>>>> be mapped and parsed in late stage like before.
>>>>>>
>>>>>> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
>>>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>>>>> Cc: linux-acpi@vger.kernel.org
>>>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>>> Cc: Zheng, Lv <lv.zheng@intel.com>
>>>>>> Cc: Julian Wollrath <jwollrath@web.de>
>>>>>> ---
>>>>>> Test in my own PC(Lenovo M4340).
>>>>>> Ask help for doing regression testing for the bug said in commit c4e1acbb35e4
>>>>>> ("ACPI / init: Invoke early ACPI initialization later").
>>>>>>
>>>>>>  init/main.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/init/main.c b/init/main.c
>>>>>> index df58a41..7a09467 100644
>>>>>> --- a/init/main.c
>>>>>> +++ b/init/main.c
>>>>>> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
>>>>>>  	kmemleak_init();
>>>>>>  	setup_per_cpu_pageset();
>>>>>>  	numa_policy_init();
>>>>>> +	acpi_early_init();
>>>>>>  	if (late_time_init)
>>>>>>  		late_time_init();
>>>>>>  	calibrate_delay();
>>>>>>  	pidmap_init();
>>>>>>  	anon_vma_init();
>>>>>> -	acpi_early_init();
>>>>>>  #ifdef CONFIG_X86
>>>>>>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>>>>>>  		efi_enter_virtual_mode();
>>>>>> --
>>>>>> 2.5.5
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>
>
>
>


