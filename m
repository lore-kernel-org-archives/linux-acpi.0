From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [2.6.25-rc1] System no longer powers off after shutdown
Date: Thu, 14 Feb 2008 19:45:58 -0800
Message-ID: <86802c440802141945v85a2754i31bf7908957fe5a@mail.gmail.com>
References: <200802111623.38478.elendil@planet.nl>
	 <200802122139.14840.elendil@planet.nl>
	 <20080212205622.GA21986@suse.de>
	 <200802131239.14305.elendil@planet.nl>
	 <20080213165837.GA10129@suse.de>
	 <86802c440802141538m44d64b6as827426174874979d@mail.gmail.com>
	 <20080214234832.GA14363@elte.hu>
	 <86802c440802141814t39b8082bx7ceb7eaf37c1142c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:58150 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762849AbYBODqB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 22:46:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so939856wah.23
        for <linux-acpi@vger.kernel.org>; Thu, 14 Feb 2008 19:45:59 -0800 (PST)
In-Reply-To: <86802c440802141814t39b8082bx7ceb7eaf37c1142c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <gregkh@suse.de>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Feb 14, 2008 at 6:14 PM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
> On Thu, Feb 14, 2008 at 3:48 PM, Ingo Molnar <mingo@elte.hu> wrote:
>  >
>  >  * Yinghai Lu <yhlu.kernel@gmail.com> wrote:
>  >
>  >  > after disable cpufreq, i got
>  >  >
>  >  > ACPI: Preparing to enter system sleep state S5
>  >  > Disabling non-boot CPUs ...
>  >  > kvm: disabling virtualization on CPU1
>  >  > CPU 1 is now offline
>  >  > CPU1 is down
>  >  > kvm: disabling virtualization on CPU2
>  >  > CPU 2 is now offline
>  >  > ================> hang here.
>  >  >
>  >  > but x86.git/mm could go through down all the cpus....
>  >  >
>  >  > interesting...
>  >
>  >  i suspect some kobject related race, and i have the feeling this all is
>  >  timing dependent.
>  >
>  >  Andrew started seeing reboot hangs roughly around the time when the
>  >  kobject changes went upstream. Given that x86.git had flux in that
>  >  timeframe too i couldnt be sure what caused them.
>
>  it seems only happen
>  1. first hang with cpufreq enabled.
>  2. reboot to kernel with cpufreq disable will have problem.
>
>  wonder if different cpu freq out sync and next kernel with reboot
>  doesn't have cpufreq so it ....
>  -- with warm reset doesn't do the right job to sync freq again.

ACPI: Preparing to enter system sleep state S5
Disabling non-boot CPUs ...
kvm: disabling virtualization on CPU1
CPU 1 is now offline
1
2
3
4
5
CPU1 is down
kvm: disabling virtualization on CPU2
CPU 2 is now offline
1
2
3
4
5
CPU2 is down
kvm: disabling virtualization on CPU3
CPU 3 is now offline
========> some time later
Clocksource tsc unstable (delta = 515397918052 ns)
Time: hpet clocksource has been installed.


it hangs in

raw_notifier_call_chain(&cpu_chain, CPU_DEAD | mode, hcpu)== NOTIFY_BAD);

there are several nb, not sure which one cause hang.

8 hrtimer.c        hrtimers_init            1505
register_cpu_notifier(&hrtimers_nb);
9 rcuclassic.c     __rcu_init                570 register_cpu_notifier(&rcu_nb);
a rcupreempt.c     __rcu_init                892
register_cpu_notifier(&rcu_nb); ===> not used
b sched.c          migration_init           5951
register_cpu_notifier(&migration_notifier);
c softirq.c        spawn_ksoftirqd           645
register_cpu_notifier(&cpu_nfb);
d softlockup.c     spawn_softlockup_task     310
register_cpu_notifier(&cpu_nfb);
e timer.c          init_timers              1367
register_cpu_notifier(&timers_nb);
f page-writeback.c page_writeback_init       775
register_cpu_notifier(&ratelimit_nb);
g page_alloc.c     setup_per_cpu_pageset    2744
register_cpu_notifier(&pageset_notifier);
h slab.c           kmem_cache_init          1638
register_cpu_notifier(&cpucache_notifier);  ==> not used
i slub.c           kmem_cache_init          3036
register_cpu_notifier(&slab_notifier);
j vmstat.c         setup_vmstat              855
register_cpu_notifier(&vmstat_notifier);
k kvm_main.c       kvm_init                 1328 r =
register_cpu_notifier(&kvm_cpu_notifier);

maybe the one in softlockup.c?

YH
