From: Michael wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/11] sched/cleanup: remove the extra parm of sched_clock_idle_wakeup_event()
Date: Thu, 22 Aug 2013 16:07:50 +0800
Message-ID: <5215C6D6.3030309@linux.vnet.ibm.com>
References: <5215C233.9060907@linux.vnet.ibm.com> <5215C484.5010407@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5215C484.5010407@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: open list <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, John Stultz <john.stultz@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Feng Tang <feng.tang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 08/22/2013 03:57 PM, Michael wang wrote:
> Parm 'delta_ns' has not been used, remove it to make code clean.
[snip]
>  
> -extern void sched_clock_idle_sleep_event(void);
> -extern void sched_clock_idle_wakeup_event(u64 delta_ns);

Also remove the extra declaration here.

Regards,
Michael Wang

> -
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void idle_task_exit(void);
>  #else
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index c3ae144..d111c58 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -294,7 +294,7 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_sleep_event);
>  /*
>   * We just idled delta nanoseconds (called with irqs disabled):
>   */
> -void sched_clock_idle_wakeup_event(u64 delta_ns)
> +void sched_clock_idle_wakeup_event(void)
>  {
>  	if (timekeeping_suspended)
>  		return;
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 3612fc7..4b24d9e 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -433,7 +433,7 @@ static void tick_nohz_stop_idle(int cpu, ktime_t now)
>  	update_ts_time_stats(cpu, ts, now, NULL);
>  	ts->idle_active = 0;
>  
> -	sched_clock_idle_wakeup_event(0);
> +	sched_clock_idle_wakeup_event();
>  }
>  
>  static ktime_t tick_nohz_start_idle(int cpu, struct tick_sched *ts)
> 
