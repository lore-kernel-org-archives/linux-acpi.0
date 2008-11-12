From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: [Linux 2.6.28-rc4] BUG: using smp_processor_id() in preemptible [00000000] code: suspend_to_disk/2934
Date: Wed, 12 Nov 2008 21:34:54 +0100
Message-ID: <8db1092f0811121234p3be15e29n5fd684e387977dab@mail.gmail.com>
References: <8db1092f0811121030t1977b3bbu8340b582694d1e65@mail.gmail.com>
	 <alpine.LFD.2.00.0811121046360.3468@nehalem.linux-foundation.org>
	 <20081112192128.GA17667@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:5259 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbYKLUe4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2008 15:34:56 -0500
Received: by qw-out-2122.google.com with SMTP id 3so349378qwe.37
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2008 12:34:55 -0800 (PST)
In-Reply-To: <20081112192128.GA17667@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi@vger.kernel.org

2008/11/12 Ingo Molnar <mingo@elte.hu>:

>
> i've queued up the fix below in tip/sched/urgent - Maciej, could you
> please test it? I've build and boot tested it.
>

Suspend to disk works OK now. Thanks.

Tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>
>
> Reported-by: Maciej Rutecki <maciej.rutecki@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/sched.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 3bafbe3..c94baf2 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -5870,6 +5870,8 @@ void __cpuinit init_idle(struct task_struct *idle, int cpu)
>        struct rq *rq = cpu_rq(cpu);
>        unsigned long flags;
>
> +       spin_lock_irqsave(&rq->lock, flags);
> +
>        __sched_fork(idle);
>        idle->se.exec_start = sched_clock();
>
> @@ -5877,7 +5879,6 @@ void __cpuinit init_idle(struct task_struct *idle, int cpu)
>        idle->cpus_allowed = cpumask_of_cpu(cpu);
>        __set_task_cpu(idle, cpu);
>
> -       spin_lock_irqsave(&rq->lock, flags);
>        rq->curr = rq->idle = idle;
>  #if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
>        idle->oncpu = 1;
>
>

Regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
