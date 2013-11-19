From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86, acpi, idle: Restructure the mwait idle routines
Date: Tue, 19 Nov 2013 15:51:43 +0100
Message-ID: <20131119145143.GK10022@twins.programming.kicks-ass.net>
References: <20131119090019.GJ3866@twins.programming.kicks-ass.net>
 <20131119090859.GC3694@twins.programming.kicks-ass.net>
 <20131119113153.GD3694@twins.programming.kicks-ass.net>
 <528B7433.7020507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528B7433.7020507@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shaohua.li@intel.com, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2013 at 06:22:43AM -0800, Arjan van de Ven wrote:
> >diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> >index 8f181b3f842b..e8275f2df9af 100644
> >--- a/drivers/thermal/intel_powerclamp.c
> >+++ b/drivers/thermal/intel_powerclamp.c
> >@@ -438,9 +438,7 @@ static int clamp_thread(void *arg)
> >  			 */
> >  			local_touch_nmi();
> >  			stop_critical_timings();
> >-			__monitor((void *)&current_thread_info()->flags, 0, 0);
> >-			cpu_relax(); /* allow HT sibling to run */
> >-			__mwait(eax, ecx);
> >+			mwait_idle_with_hints(eax, ecx);
> >  			start_critical_timings();
> >  			atomic_inc(&idle_wakeup_counter);
> >  		}
> >
> 
> hmm I take it that mwait_idle_with_hints is the one that also checks need_resched() ?
> if so... powerclamp may not want to use that (the whole point is to NOT give the cpu
> to tasks!)

That said, that drive is completely wrecked. It uses
preempt_enable_no_resched() wrong too, it has uncommented barriers..

Dude, wtf are you guys smoking?
