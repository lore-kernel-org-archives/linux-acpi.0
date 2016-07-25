From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
Date: Mon, 25 Jul 2016 17:31:45 +0100
Message-ID: <20160725163144.GE19209@arm.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
 <20160725153118.GD19209@arm.com>
 <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADyBb7ubKceQiB7+u7sSA=1+9_VMUrGjiabf_FkN2-n4rq7Kgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, wei-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Suravee
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 25, 2016 at 11:55:49PM +0800, Fu Wei wrote:
> On 25 July 2016 at 23:31, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Mon, Jul 25, 2016 at 11:27:02PM +0800, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>
> >> This patch simplify arch_counter_get_cntvct_mem function by
> >> using readq to get 64-bit CNTVCT value instead of readl_relaxed.
> >>
> >> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> ---
> >>  drivers/clocksource/arm_arch_timer.c | 10 +---------
> >>  1 file changed, 1 insertion(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> >> index e6fd42d..483d2f9 100644
> >> --- a/drivers/clocksource/arm_arch_timer.c
> >> +++ b/drivers/clocksource/arm_arch_timer.c
> >> @@ -418,15 +418,7 @@ u32 arch_timer_get_rate(void)
> >>
> >>  static u64 arch_counter_get_cntvct_mem(void)
> >>  {
> >> -     u32 vct_lo, vct_hi, tmp_hi;
> >> -
> >> -     do {
> >> -             vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> >> -             vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
> >> -             tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
> >> -     } while (vct_hi != tmp_hi);
> >> -
> >> -     return ((u64) vct_hi << 32) | vct_lo;
> >> +     return readq(arch_counter_base + CNTVCT_LO);
> >
> > Please drop this patch. It doesn't work.
> 
> I am OK to drop this, but could you let me know why it doesn't work?
> 
> I did get some problem on Foundation model about readq, but it works on Seattle.
> I guess that is a problem of model, but not a code problem.
> So I just got confused, why readq  doesn't work,  :-)

The kernel really needs to support both of those platforms :/

For the memory-mapped counter registers, the architecture says:

  `If the implementation supports 64-bit atomic accesses, then the
   CNTV_CVAL register must be accessible as an atomic 64-bit value.'

which is borderline tautological. If we take the generous reading that
this means AArch64 CPUs can use readq (and I'm not completely
comfortable with that assertion, particularly as you say that it breaks
the model), then you still need to use readq_relaxed here to avoid a
DSB. Furthermore, what are you going to do for AArch32? readq doesn't
exist over there, and if you use the generic implementation then it's
not atomic. In which case, we end up with the current code, as well as a
readq_relaxed guarded by a questionable #ifdef that is known to break a
supported platform for an unknown performance improvement. Hardly a big
win.

Did you see any performance advantage from this? Given that you've added
a DSB, this looks to be extremely premature.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
