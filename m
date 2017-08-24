From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 12/13] ACPI / init: Invoke early ACPI initialization
 earlier
Date: Thu, 24 Aug 2017 11:54:28 +0800
Message-ID: <8d662105-2ff5-02fd-9072-73167e5f49c1@cn.fujitsu.com>
References: <1500011554-9784-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1500011554-9784-13-git-send-email-douly.fnst@cn.fujitsu.com>
 <a8024347-ce0b-c59b-74ea-45a822e54ee6@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46191 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751019AbdHXDyk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Aug 2017 23:54:40 -0400
In-Reply-To: <a8024347-ce0b-c59b-74ea-45a822e54ee6@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, ebiederm@xmission.com, bhe@redhat.com, peterz@infradead.org, izumi.taku@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-acpi@vger.kernel.org, Julian Wollrath <jwollrath@web.de>, Borislav Petkov <bp@alien8.de>

Hi Rafael, Zheng,

At 07/31/2017 06:50 PM, Dou Liyang wrote:
> Hi,
>
> At 07/14/2017 01:52 PM, Dou Liyang wrote:
>> Linux uses acpi_early_init() to put the ACPI table management into
>> the late stage from the early stage where the mapped ACPI tables is
>> temporary and should be unmapped.
>>
>> But, now initializing interrupt delivery mode should map and parse the
>> DMAR table earlier in the early stage. This causes an ACPI error when
>> Linux reallocates the ACPI root tables. Because Linux doesn't unmapped
>> the DMAR table after using in the early stage.
>>
>> Invoke acpi_early_init() earlier before late_time_init(), Keep the DMAR
>> be mapped and parsed in late stage like before.
>>
>> Reported-by: Xiaolong Ye <xiaolong.ye@intel.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Zheng, Lv <lv.zheng@intel.com>
>> Cc: Julian Wollrath <jwollrath@web.de>
>> ---
>> Test in my own PC(Lenovo M4340).
>> Ask help for doing regression testing for the bug said in commit
>> c4e1acbb35e4
>> ("ACPI / init: Invoke early ACPI initialization later").
>>
>
> Now, I can prove this patch doesn't result in the bug[1] which made the
> fast TSC calibration using PIT failed in a Thinkpad x121e (AMD E-450
> APU).
>
> The true reason of the bug is enabling ACPI subsystem earlier than
> using PIT, not the SCI setup. invoking acpi_enable_subsystem() later
> could fix this bug as Julian tested and said[2].
>
> And, I found that Commit b064a8fa77df (" ACPI / init: Switch over
> platform to the ACPI mode later") split the ACPI early initialization
> code into acpi_early_init() and acpi_subsystem_init(). executing
> acpi_enable_subsystem() at the original early ACPI initialization spot.
>
> The sequence of them shows below:
>
>  start_kernel
> +---------------+
> |
> +--> .......
> |
> |    late_time_init()
> +--> +-------+
> |
> +--> .......
> |
> |    acpi_early_init()
> +--> +-------+
> |
> +--> .......
> |
> |   acpi_subsystem_init()
> +-> +--------+
>
> We make sure the acpi_subsystem_init() is called later than
> late_time_init(), the bug will be avoided.
>
> This patch changes the sequence of late_time_init() and
> acpi_early_init(), doesn't effect acpi_subsystem_init().
>
> So, this patch is OK.
>
> Btw, Thanks very much for Borislav Petkov, he will have access to
> Thinkpad x121e from Mid-August and will test this series.
>

Almost one month passed, Borislav have tested this series in Thinkpad
x121e and I also have tested in my box and QEmu again. It is OK.

BTW,
1) I found your commit b064a8fa77df (" ACPI / init: Switch over
platform to the ACPI mode later") split the ACPI early initialization
code into acpi_early_init() and acpi_subsystem_init(). Actually enabling
the ACPI subsystem is in acpi_subsystem_init().

2) As we discussed earlier, invoking acpi_put_table() is not good for
this situation.

So I do this patch, Is that goot to you? Any comments will be welcome.

If it is OK, As the patches need to be re-based, and I also found
several spelling mistake, I will send a new version next week.

Thanks,
	dou.

> [1] https://lkml.org/lkml/2014/3/10/123
> [2] https://lkml.org/lkml/2014/3/12/311
>
>
> Thanks
>     dou.
>
>>  init/main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index df58a41..7a09467 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -654,12 +654,12 @@ asmlinkage __visible void __init start_kernel(void)
>>      kmemleak_init();
>>      setup_per_cpu_pageset();
>>      numa_policy_init();
>> +    acpi_early_init();
>>      if (late_time_init)
>>          late_time_init();
>>      calibrate_delay();
>>      pidmap_init();
>>      anon_vma_init();
>> -    acpi_early_init();
>>  #ifdef CONFIG_X86
>>      if (efi_enabled(EFI_RUNTIME_SERVICES))
>>          efi_enter_virtual_mode();
>>


