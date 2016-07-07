From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v6 03/10] clocksource/drivers/arm_arch_timer: Improve
 printk relevant code
Date: Fri, 8 Jul 2016 00:12:26 +0800
Message-ID: <CADyBb7tOfpnaaOvq-tVeW=VjTReoBzi8Xsthjq_ZR_y57kHcog@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <1467224153-22873-4-git-send-email-fu.wei@linaro.org> <c347a9d9-82b4-b469-4e64-6446e6282a19@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34553 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbcGGQM1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jul 2016 12:12:27 -0400
Received: by mail-oi0-f47.google.com with SMTP id s66so29615583oif.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jul 2016 09:12:27 -0700 (PDT)
In-Reply-To: <c347a9d9-82b4-b469-4e64-6446e6282a19@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Leo Duran <leo.duran@amd.com>

Hi Hanjun

On 30 June 2016 at 10:54, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2016/6/30 2:15, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patch defines pr_fmt(fmt) for all pr_* functions,
>> then the pr_* don't need to add "arch_timer:" everytime.
>>
>> Also delete some Blank Spaces in arch_timer_banner,
>> according to the suggestion from checkpatch.pl.
>>
>> No functional change.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 52
>> +++++++++++++++++++-----------------
>>  1 file changed, 27 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index 966c574..9540e9d 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -29,6 +29,9 @@
>>
>>  #include <clocksource/arm_arch_timer.h>
>>
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "arch_timer: " fmt
>> +
>>  #define CNTTIDR                0x08
>>  #define CNTTIDR_VIRT(n)        (BIT(1) << ((n) * 4))
>>
>> @@ -388,24 +391,24 @@ arch_timer_detect_rate(void __iomem *cntbase, struct
>> device_node *np)
>>
>>         /* Check the timer frequency. */
>>         if (arch_timer_rate == 0)
>> -               pr_warn("Architected timer frequency not available\n");
>> +               pr_warn("frequency not available\n");
>>  }
>>
>>  static void arch_timer_banner(unsigned type)
>>  {
>> -       pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz
>> (%s%s%s).\n",
>> -                    type & ARCH_CP15_TIMER ? "cp15" : "",
>> -                    type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and "
>> : "",
>> -                    type & ARCH_MEM_TIMER ? "mmio" : "",
>> -                    (unsigned long)arch_timer_rate / 1000000,
>> -                    (unsigned long)(arch_timer_rate / 10000) % 100,
>> -                    type & ARCH_CP15_TIMER ?
>> -                    (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
>> -                       "",
>> -                    type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" :
>> "",
>> -                    type & ARCH_MEM_TIMER ?
>> -                       arch_timer_mem_use_virtual ? "virt" : "phys" :
>> -                       "");
>> +       pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>> +               type & ARCH_CP15_TIMER ? "cp15" : "",
>> +               type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  " and " :
>> "",
>> +               type & ARCH_MEM_TIMER ? "mmio" : "",
>> +               (unsigned long)arch_timer_rate / 1000000,
>> +               (unsigned long)(arch_timer_rate / 10000) % 100,
>> +               type & ARCH_CP15_TIMER ?
>> +               (arch_timer_uses_ppi == VIRT_PPI) ? "virt" : "phys" :
>> +               "",
>> +               type == (ARCH_CP15_TIMER | ARCH_MEM_TIMER) ?  "/" : "",
>> +               type & ARCH_MEM_TIMER ?
>> +               arch_timer_mem_use_virtual ? "virt" : "phys" :
>> +               "");
>>  }
>>
>>  u32 arch_timer_get_rate(void)
>> @@ -498,7 +501,7 @@ static void __init arch_counter_register(unsigned
>> type)
>>
>>  static void arch_timer_stop(struct clock_event_device *clk)
>>  {
>> -       pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
>> +       pr_debug("teardown, disable IRQ%d cpu #%d\n",
>
>
> Not a problem of this patch, but arch_timer_teardown is a function
> name? I can't find where it's defined...
>
> I think we can leave arch_timer as it but update it to:
>
> pr_debug("arch_timer_stop disable IRQ%d cpu #%d\n",

If so, you will see "arch_timer: arch_timer_stop disable IRQ%d cpu #%d\n "

I think we can do :

pr_debug(" disable IRQ%d cpu #%d\n",


>
> Others are look good to me.
>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
