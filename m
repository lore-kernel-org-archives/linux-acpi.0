From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 08/13] ACPI/processor: Replace racy task affinity logic.
Date: Thu, 13 Apr 2017 13:39:45 +0200
Message-ID: <20170413113945.mkdsk24rovzcrod6@hirez.programming.kicks-ass.net>
References: <20170412200726.941336635@linutronix.de>
 <20170412201042.785920903@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36691 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdDMLkA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2017 07:40:00 -0400
Content-Disposition: inline
In-Reply-To: <20170412201042.785920903@linutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org

On Wed, Apr 12, 2017 at 10:07:34PM +0200, Thomas Gleixner wrote:
> acpi_processor_get_throttling() requires to invoke the getter function on
> the target CPU. This is achieved by temporarily setting the affinity of the
> calling user space thread to the requested CPU and reset it to the original
> affinity afterwards.
> 
> That's racy vs. CPU hotplug and concurrent affinity settings for that
> thread resulting in code executing on the wrong CPU and overwriting the
> new affinity setting.
> 
> acpi_processor_get_throttling() is invoked in two ways:
> 
> 1) The CPU online callback, which is already running on the target CPU and
>    obviously protected against hotplug and not affected by affinity
>    settings.
> 
> 2) The ACPI driver probe function, which is not protected against hotplug
>    during modprobe.
> 
> Switch it over to work_on_cpu() and protect the probe function against CPU
> hotplug.
> 

> +static int acpi_processor_get_throttling(struct acpi_processor *pr)
> +{
>  	if (!pr)
>  		return -EINVAL;
>  
>  	if (!pr->flags.throttling)
>  		return -ENODEV;
>  
> +	 * This is either called from the CPU hotplug callback of
> +	 * processor_driver or via the ACPI probe function. In the latter
> +	 * case the CPU is not guaranteed to be online. Both call sites are
> +	 * protected against CPU hotplug.
>  	 */
> +	if (!cpu_online(pr->id))
>  		return -ENODEV;
>  
> +	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
>  }

That makes my machine sad...


[    9.583030] =============================================
[    9.589053] [ INFO: possible recursive locking detected ]
[    9.595079] 4.11.0-rc6-00385-g5aee78a-dirty #678 Not tainted
[    9.601393] ---------------------------------------------
[    9.607418] kworker/0:0/3 is trying to acquire lock:
[    9.612954]  ((&wfc.work)){+.+.+.}, at: [<ffffffff8110c172>] flush_work+0x12/0x2a0
[    9.621406] 
[    9.621406] but task is already holding lock:
[    9.627915]  ((&wfc.work)){+.+.+.}, at: [<ffffffff8110df17>] process_one_work+0x1e7/0x670
[    9.637044] 
[    9.637044] other info that might help us debug this:
[    9.644330]  Possible unsafe locking scenario:
[    9.644330] 
[    9.650934]        CPU0
[    9.653660]        ----
[    9.656386]   lock((&wfc.work));
[    9.659987]   lock((&wfc.work));
[    9.663586] 
[    9.663586]  *** DEADLOCK ***
[    9.663586] 
[    9.670189]  May be due to missing lock nesting notation
[    9.670189] 
[    9.677765] 2 locks held by kworker/0:0/3:
[    9.682332]  #0:  ("events"){.+.+.+}, at: [<ffffffff8110df17>] process_one_work+0x1e7/0x670
[    9.691654]  #1:  ((&wfc.work)){+.+.+.}, at: [<ffffffff8110df17>] process_one_work+0x1e7/0x670
[    9.701267] 
[    9.701267] stack backtrace:
[    9.706127] CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.11.0-rc6-00385-g5aee78a-dirty #678
[    9.715545] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[    9.726999] Workqueue: events work_for_cpu_fn
[    9.731860] Call Trace:
[    9.734591]  dump_stack+0x86/0xcf
[    9.738290]  __lock_acquire+0x790/0x1620
[    9.742667]  ? __lock_acquire+0x4a5/0x1620
[    9.747237]  lock_acquire+0x100/0x210
[    9.751319]  ? lock_acquire+0x100/0x210
[    9.755596]  ? flush_work+0x12/0x2a0
[    9.759583]  flush_work+0x47/0x2a0
[    9.763375]  ? flush_work+0x12/0x2a0
[    9.767362]  ? queue_work_on+0x47/0xa0
[    9.771545]  ? __this_cpu_preempt_check+0x13/0x20
[    9.776792]  ? trace_hardirqs_on_caller+0xfb/0x1d0
[    9.782139]  ? trace_hardirqs_on+0xd/0x10
[    9.786610]  work_on_cpu+0x82/0x90
[    9.790404]  ? __usermodehelper_disable+0x110/0x110
[    9.795846]  ? __acpi_processor_get_throttling+0x20/0x20
[    9.801773]  acpi_processor_set_throttling+0x199/0x220
[    9.807506]  ? trace_hardirqs_on_caller+0xfb/0x1d0
[    9.812851]  acpi_processor_get_throttling_ptc+0xec/0x180
[    9.818876]  __acpi_processor_get_throttling+0xf/0x20
[    9.824511]  work_for_cpu_fn+0x14/0x20
[    9.828692]  process_one_work+0x261/0x670
[    9.833165]  worker_thread+0x21b/0x3f0
[    9.837348]  kthread+0x108/0x140
[    9.840947]  ? process_one_work+0x670/0x670
[    9.845611]  ? kthread_create_on_node+0x40/0x40
[    9.850667]  ret_from_fork+0x31/0x40
