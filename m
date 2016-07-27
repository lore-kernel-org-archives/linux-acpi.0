From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
Date: Wed, 27 Jul 2016 12:19:39 +0800
Message-ID: <CADyBb7s8Lmbc8Gqzn_ZV+PUJ9YiosixjcsNsaxDc696+EYhtiA@mail.gmail.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org> <20160725153118.GD19209@arm.com>
 <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg@mail.gmail.com>
 <20160725163144.GE19209@arm.com> <57976FA5.2070802@codeaurora.org> <20160727113342.2a839c1a@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160727113342.2a839c1a@xhacker>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel>
List-Id: linux-acpi@vger.kernel.org

Hi all,

On 27 July 2016 at 11:33, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:
> +1
>
> On Tue, 26 Jul 2016 09:11:49 -0500 Timur Tabi  wrote:
>
>> Will Deacon wrote:
>> > The kernel really needs to support both of those platforms :/
>> >
>> > For the memory-mapped counter registers, the architecture says:
>> >
>> >    `If the implementation supports 64-bit atomic accesses, then the
>> >     CNTV_CVAL register must be accessible as an atomic 64-bit value.'
>> >
>> > which is borderline tautological. If we take the generous reading that
>> > this means AArch64 CPUs can use readq (and I'm not completely
>> > comfortable with that assertion, particularly as you say that it breaks
>> > the model), then you still need to use readq_relaxed here to avoid a
>> > DSB. Furthermore, what are you going to do for AArch32? readq doesn't
>> > exist over there, and if you use the generic implementation then it's
>> > not atomic. In which case, we end up with the current code, as well as a
>> > readq_relaxed guarded by a questionable #ifdef that is known to break a
>> > supported platform for an unknown performance improvement. Hardly a big
>> > win.
>>
>> I know Fu dropped this patch, and I don't want to kick a dead horse, but
>> I was wondering if it would be okay to do this:
>>
>> static u64 arch_counter_get_cntvct_mem(void)
>> {
>> #ifdef readq_relaxed
>>       return readq_relaxed(arch_counter_base + CNTVCT_LO);
>> #else
>>       u32 vct_lo, vct_hi, tmp_hi;
>>
>>       do {
>>               vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>>               vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>>               tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>>       } while (vct_hi != tmp_hi);
>>
>>       return ((u64) vct_hi << 32) | vct_lo;
>> #endif
>> }
>>
>> readq and readq_relaxed are defined in arch/arm64/include/asm/io.h.  Why
>> would the function exist if AArch64 CPUs can't use it?

yes, that is a good idea. Thanks Timur! :-)

>
> +1

I like this idea too, but please allow me to upstream this patch separately,
because this GTDT patchset can work without it, this readq support is
a  optimizing.

I also can see another arm-related driver are using readq in this way(
#ifdef readq): bus/arm-ccn.c
And some other drivers are also doing this.

>
> I measured the performance on berlin arm64 platforms:
>
> compared with original version, using readq_relaxed could reduce
> time of arch_counter_get_cntvct_mem() by about 42%!

Great thanks for your data, :-)

>
> Thanks,
> Jisheng



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
