From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Thu, 24 Aug 2017 18:44:41 +0800
Message-ID: <86d22404-2a5c-dc53-e476-ab3de8c6ccca@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <a8024347-ce0b-c59b-74ea-45a822e54ee6@cn.fujitsu.com>
 <8d662105-2ff5-02fd-9072-73167e5f49c1@cn.fujitsu.com>
 <20170824080528.GD19768@x1>
 <6b800d1a-d924-6dec-8c3e-299e4a67ed68@cn.fujitsu.com>
 <20170824102112.GE19768@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824102112.GE19768@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-acpi@vger.kernel.org, Julian Wollrath <jwollrath@web.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-acpi@vger.kernel.org



At 08/24/2017 06:21 PM, Baoquan He wrote:
> On 08/24/17 at 05:28pm, Dou Liyang wrote:
>> Hi Baoquan,
>>
>> Thanks for your reply.
>>
>> At 08/24/2017 04:05 PM, Baoquan He wrote:
>>> Hi Liyang,
>>>
>>> On 08/24/17 at 11:54am, Dou Liyang wrote:
>>>>>> Test in my own PC(Lenovo M4340).
>>>>>> Ask help for doing regression testing for the bug said in commit
>>>>>> c4e1acbb35e4
>>>>>> ("ACPI / init: Invoke early ACPI initialization later").
>>>>>>
>>>>>
>>>>> Now, I can prove this patch doesn't result in the bug[1] which made the
>>>>> fast TSC calibration using PIT failed in a Thinkpad x121e (AMD E-450
>>>>> APU).
>>>>>
>>>>> The true reason of the bug is enabling ACPI subsystem earlier than
>>>>> using PIT, not the SCI setup. invoking acpi_enable_subsystem() later
>>>
>>> Seems redhat mail server was down earlier, I didn't receive new mail in
>>> this thread.  Just curious, do you know why the fast tsc calibration
>>> using PIT will fail if enabling ACPI subsystem earlier than using PIT?
>>>
>> It's related to particular hardware, As you know, I tested in many
>> kinds of PC and laptop and PIT works well no matter before or after
>> enabling ACPI subsystem.
>>
>> In pit_verify_msb(), we use inb(0x42) to read the current MSB,
>>
>> Normally, the value is continuously, like following shows:
>>
>> msb = fe
>> msb = fd
>> msb = fc
>> msb = fb
>> msb = fa
>> msb = f9
>> msb = f8
>> msb = f7
>> msb = f6
>> ...
>>
>> But, if in some particular hardware, you will see like that:
>>
>> msb = fe
>> msb = f0
>> msb = ed
>> msb = e9
>> msb = e0
>> msb = db
>> ...
>>
>> In this case, the count in pit_expect_msb() is always zero.
>> So we will see "Fast TSC calibration failed" in our dmesg log.
>
> Thanks for telling!
>
> It's truly weird that the TSC becomes unstable only if enabling ACPI
> subsystem earlier than using PIT.
>
> Let's see what other people say about this.
>
> Btw, you will resend another round, right? Then I would like to test
> your new post.

Yes, I am waiting ACPI maintainers advice and I prepare to re-base it
next week when rc7 is out.

Thanks,
	dou.

>
> Thanks
> Baoquan
>
>>
>> For the further deep reason why the hardware failed, I'm sorry
>> I can't answer and don't know how to investigate. For hardware,
>> I usually change a new one directly and know very little.
>>
>> Thanks,
>> 	dou.
>>
>>
>>> Thanks
>>> Baoquan
>>>
>>>>> could fix this bug as Julian tested and said[2].
>>>>>
>>>>> And, I found that Commit b064a8fa77df (" ACPI / init: Switch over
>>>>> platform to the ACPI mode later") split the ACPI early initialization
>>>>> code into acpi_early_init() and acpi_subsystem_init(). executing
>>>>> acpi_enable_subsystem() at the original early ACPI initialization spot.
>>>>>
>>>>> The sequence of them shows below:
>>>>>
>>>>>  start_kernel
>>>>> +---------------+
>>>>> |
>>>>> +--> .......
>>>>> |
>>>>> |    late_time_init()
>>>>> +--> +-------+
>>>>> |
>>>>> +--> .......
>>>>> |
>>>>> |    acpi_early_init()
>>>>> +--> +-------+
>>>>> |
>>>>> +--> .......
>>>>> |
>>>>> |   acpi_subsystem_init()
>>>>> +-> +--------+
>>>>>
>>>>> We make sure the acpi_subsystem_init() is called later than
>>>>> late_time_init(), the bug will be avoided.
>>>>>
>>>>> This patch changes the sequence of late_time_init() and
>>>>> acpi_early_init(), doesn't effect acpi_subsystem_init().
>>>>>
>>>>> So, this patch is OK.
>>>>>
>>>>> Btw, Thanks very much for Borislav Petkov, he will have access to
>>>>> Thinkpad x121e from Mid-August and will test this series.
>>>>>
>>>>
>>>> Almost one month passed, Borislav have tested this series in Thinkpad
>>>> x121e and I also have tested in my box and QEmu again. It is OK.
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
>>>>
>>>> Thanks,
>>>> 	dou.
>>>>
>>>>> [1] https://lkml.org/lkml/2014/3/10/123
>>>>> [2] https://lkml.org/lkml/2014/3/12/311
>>>>>
>>>>>
>>>>> Thanks
>>>>>     dou.
>>>>>
>>>>>>  init/main.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/init/main.c b/init/main.c
>>>>>> index df58a41..7a09467 100644
>>>>>> --- a/init/main.c
>>>>>> +++ b/init/main.c
>>>>>> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
>>>>>>      kmemleak_init();
>>>>>>      setup_per_cpu_pageset();
>>>>>>      numa_policy_init();
>>>>>> +    acpi_early_init();
>>>>>>      if (late_time_init)
>>>>>>          late_time_init();
>>>>>>      calibrate_delay();
>>>>>>      pidmap_init();
>>>>>>      anon_vma_init();
>>>>>> -    acpi_early_init();
>>>>>>  #ifdef CONFIG_X86
>>>>>>      if (efi_enabled(EFI_RUNTIME_SERVICES))
>>>>>>          efi_enter_virtual_mode();
>>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>>
>
>
>
