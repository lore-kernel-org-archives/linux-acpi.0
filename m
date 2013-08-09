From: "Adachi, Kenichi" <aileenja@s6.dion.ne.jp>
Subject: Re: [PATCH 6/9] ACPICA: Make ACPI Power Management Timer (PM Timer) optional.
Date: Fri, 9 Aug 2013 12:17:21 +0900
Message-ID: <CAEYoeW6oXnZtmBEquu8MZ9LyBKTibUtn4Pie+28v5MWCrJSyNQ@mail.gmail.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
	<f33e6e1b2775191444ab54142d5094583b5a8cd5.1375946725.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41285 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967411Ab3HIDRW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2013 23:17:22 -0400
Received: by mail-vc0-f178.google.com with SMTP id ha12so688533vcb.23
        for <linux-acpi@vger.kernel.org>; Thu, 08 Aug 2013 20:17:21 -0700 (PDT)
In-Reply-To: <f33e6e1b2775191444ab54142d5094583b5a8cd5.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Hi,

On Thu, Aug 8, 2013 at 4:29 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>
> From: Bob Moore <robert.moore@intel.com>
>
> PM Timer is now optional.
...
> The change doesn't affect Linux directly, because it has never relied
> on the presence of the PM timer.
>
Has it been so?

IIRC, there're a couple of accesses to PM Timer via:
-  inl(acpi_gbl_FADT.xpm_timer_block.address);
typically in processor driver code: ex) drivers/acpi/processor_idle.c
which seems to rely on the presence of the PM timer.

The below snippet shows how it was like (which can be seen in earlier
linux kernel such as 2.6 series...)

- drivers/acpi/processor_idle.c:acpi_processor_idle()

    switch (cx->type) {
    case ACPI_STATE_C1:
        ...
        break;

    case ACPI_STATE_C2:
        /* Get start time (ticks) */
-->   t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
        /* Tell the scheduler that we are going deep-idle: */
        sched_clock_idle_sleep_event();
        /* Invoke C2 */
        acpi_state_timer_broadcast(pr, cx, 1);
        acpi_cstate_enter(cx);
        /* Get end time (ticks) */
-->   t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);

#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86)
        /* TSC halts in C2, so notify users */
        if (tsc_halts_in_c(ACPI_STATE_C2))
            mark_tsc_unstable("possible TSC halt in C2");
#endif
        /* Compute time (ticks) that we were actually asleep */
===>   sleep_ticks = ticks_elapsed(t1, t2);

        /* Tell the scheduler how much we idled: */
===>   sched_clock_idle_wakeup_event(sleep_ticks*PM_TIMER_TICK_NS);
...
