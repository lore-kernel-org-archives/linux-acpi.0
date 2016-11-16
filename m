From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v15 01/13] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
Date: Wed, 16 Nov 2016 10:15:13 +0800
Message-ID: <CADyBb7uCMpyiHNm0KWSiQPZ=siFW5gHueGjHrQUs0k4iwCexQw@mail.gmail.com>
References: <1479215615-26950-2-git-send-email-fu.wei@linaro.org> <201611160359.fuY2etTU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201611160359.fuY2etTU%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al
List-Id: linux-acpi@vger.kernel.org

Hi Marc,

On 16 November 2016 at 03:23, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Fu,
>
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on v4.9-rc5 next-20161115]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161116-004444
> config: arm-hisi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> Note: the linux-review/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161116-004444 HEAD 47004b0566d2fd65c05836078319b02c5af2a1fc builds fine.
>       It only hurts bisectibility.
>
> All error/warnings (new ones prefixed by >>):
>
>>> drivers/clocksource/arm_arch_timer.c:70:13: error: variable 'arch_timer_uses_ppi' has initializer but incomplete type
>     static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;

I have figured out this,  I should move a change from patch 4/15 to
here to avoid the problem.

it should be static enum arch_timer_ppi_nr arch_timer_uses_ppi = VIRT_PPI;
will improve this

Thanks

>                 ^~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function '__arch_timer_setup':
>>> drivers/clocksource/arm_arch_timer.c:358:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>       clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
>       ^~~
>    drivers/clocksource/arm_arch_timer.c:359:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>       switch (arch_timer_uses_ppi) {
>       ^~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_has_nonsecure_ppi':
>    drivers/clocksource/arm_arch_timer.c:447:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      return (arch_timer_uses_ppi == PHYS_SECURE_PPI &&
>      ^~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_starting_cpu':
>    drivers/clocksource/arm_arch_timer.c:471:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
>      ^~~~~
>    drivers/clocksource/arm_arch_timer.c:472:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
>      ^~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_banner':
>    drivers/clocksource/arm_arch_timer.c:512:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
>      ^~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_counter_register':
>    drivers/clocksource/arm_arch_timer.c:589:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>       if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
>       ^~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_stop':
>    drivers/clocksource/arm_arch_timer.c:624:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
>      ^~~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_register':
>    drivers/clocksource/arm_arch_timer.c:687:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      ppi = arch_timer_ppi[arch_timer_uses_ppi];
>      ^~~
>    drivers/clocksource/arm_arch_timer.c:688:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      switch (arch_timer_uses_ppi) {
>      ^~~~~~
>    drivers/clocksource/arm_arch_timer.c:737:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>      free_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], arch_timer_evt);
>      ^~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_init':
>    drivers/clocksource/arm_arch_timer.c:838:4: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>        arch_timer_uses_ppi = HYP_PPI;
>        ^~~~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c:841:4: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>        arch_timer_uses_ppi = PHYS_SECURE_PPI;
>        ^~~~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_of_init':
>    drivers/clocksource/arm_arch_timer.c:897:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
>       arch_timer_uses_ppi = PHYS_SECURE_PPI;
>       ^~~~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: At top level:
>>> drivers/clocksource/arm_arch_timer.c:70:20: error: storage size of 'arch_timer_uses_ppi' isn't known
>     static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
>                        ^~~~~~~~~~~~~~~~~~~
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_has_nonsecure_ppi':
>>> drivers/clocksource/arm_arch_timer.c:449:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
>
> vim +/arch_timer_uses_ppi +70 drivers/clocksource/arm_arch_timer.c
>
> 220069945 Stephen Boyd      2013-07-18  64
> 8a4da6e36 Mark Rutland      2012-11-12  65  static u32 arch_timer_rate;
> 8a4da6e36 Mark Rutland      2012-11-12  66  static int arch_timer_ppi[MAX_TIMER_PPI];
> 8a4da6e36 Mark Rutland      2012-11-12  67
> 8a4da6e36 Mark Rutland      2012-11-12  68  static struct clock_event_device __percpu *arch_timer_evt;
> 8a4da6e36 Mark Rutland      2012-11-12  69
> f81f03fa2 Marc Zyngier      2014-02-20 @70  static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
> 82a561941 Lorenzo Pieralisi 2014-04-08  71  static bool arch_timer_c3stop;
> 220069945 Stephen Boyd      2013-07-18  72  static bool arch_timer_mem_use_virtual;
> 8a4da6e36 Mark Rutland      2012-11-12  73
>
> :::::: The code at line 70 was first introduced by commit
> :::::: f81f03fa231a8c3aacd580759e73b9238b92ba29 arm64: Allow the arch timer to use the HYP timer
>
> :::::: TO: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> :::::: CC: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
