From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
Date: Mon, 25 Jul 2016 23:50:19 +0800
Message-ID: <CADyBb7tR4+78k52JrVZGo9FMuO8a8RBTTYK7PBx1RzP3Lx9snQ@mail.gmail.com>
References: <1468952284-28942-1-git-send-email-fu.wei@linaro.org>
 <1468952284-28942-5-git-send-email-fu.wei@linaro.org> <20160725090258.GA15864@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160725090258.GA15864-5wv7dgnIgG8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Suravee
List-Id: linux-acpi@vger.kernel.org

Hi Will,

On 25 July 2016 at 17:02, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jul 20, 2016 at 02:17:59AM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> This patch simplify arch_counter_get_cntvct_mem function by
>> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
>>
>> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index e6fd42d..483d2f9 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
>>
>>  static u64 arch_counter_get_cntvct_mem(void)
>>  {
>> -     u32 vct_lo, vct_hi, tmp_hi;
>> -
>> -     do {
>> -             vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> -             vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>> -             tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> -     } while (vct_hi != tmp_hi);
>> -
>> -     return ((u64) vct_hi << 32) | vct_lo;
>> +     return readq(arch_counter_base + CNTVCT_LO);
>

Sorry, right after posting v9, I got your comment,

> What's the benefit of doing this? If you use readq here, how can we

benefit:
1. simplify the code
2. from arch/arm64/include/asm/io.h, I guess readq is more efficient

> guarantee that (a) the endpoint won't generate a SLVERR or similar and
> (b) that we get ?

I think so, according to arch/arm64/include/asm/io.h.
readq Implement by "LDR" and "LDAR", So I think It is an atomic read.

Please correct me, If I misunderstand something, thanks

>
> "If it ain't broke, don't fix it"
>
> Will



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
