From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] x86, acpi, idle: Restructure the mwait idle routines
Date: Tue, 19 Nov 2013 06:22:43 -0800
Message-ID: <528B7433.7020507@linux.intel.com>
References: <20131119090019.GJ3866@twins.programming.kicks-ass.net> <20131119090859.GC3694@twins.programming.kicks-ass.net> <20131119113153.GD3694@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12803 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3KSOXE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Nov 2013 09:23:04 -0500
In-Reply-To: <20131119113153.GD3694@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shaohua.li@intel.com, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com

> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index 8f181b3f842b..e8275f2df9af 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -438,9 +438,7 @@ static int clamp_thread(void *arg)
>   			 */
>   			local_touch_nmi();
>   			stop_critical_timings();
> -			__monitor((void *)&current_thread_info()->flags, 0, 0);
> -			cpu_relax(); /* allow HT sibling to run */
> -			__mwait(eax, ecx);
> +			mwait_idle_with_hints(eax, ecx);
>   			start_critical_timings();
>   			atomic_inc(&idle_wakeup_counter);
>   		}
>

hmm I take it that mwait_idle_with_hints is the one that also checks need_resched() ?
if so... powerclamp may not want to use that (the whole point is to NOT give the cpu
to tasks!)
