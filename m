From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 08/13] ACPI/processor: Replace racy task affinity logic.
Date: Thu, 13 Apr 2017 14:52:24 +0200
Message-ID: <20170413125224.5uu36nekq4r72b4y@hirez.programming.kicks-ass.net>
References: <20170412200726.941336635@linutronix.de>
 <20170412201042.785920903@linutronix.de>
 <20170413113945.mkdsk24rovzcrod6@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.20.1704131345160.2408@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdDMMwl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2017 08:52:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704131345160.2408@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org

On Thu, Apr 13, 2017 at 02:01:42PM +0200, Thomas Gleixner wrote:
> On Thu, 13 Apr 2017, Peter Zijlstra wrote:
> > 
> > That makes my machine sad...
> > [    9.786610]  work_on_cpu+0x82/0x90
> > [    9.790404]  ? __usermodehelper_disable+0x110/0x110
> > [    9.795846]  ? __acpi_processor_get_throttling+0x20/0x20
> > [    9.801773]  acpi_processor_set_throttling+0x199/0x220
> > [    9.807506]  ? trace_hardirqs_on_caller+0xfb/0x1d0
> > [    9.812851]  acpi_processor_get_throttling_ptc+0xec/0x180
> > [    9.818876]  __acpi_processor_get_throttling+0xf/0x20
> > [    9.824511]  work_for_cpu_fn+0x14/0x20
> > [    9.828692]  process_one_work+0x261/0x670
> > [    9.833165]  worker_thread+0x21b/0x3f0
> > [    9.837348]  kthread+0x108/0x140
> > [    9.840947]  ? process_one_work+0x670/0x670
> > [    9.845611]  ? kthread_create_on_node+0x40/0x40
> > [    9.850667]  ret_from_fork+0x31/0x40
> 
> Yuck. So the call chain is:
> 
> acpi_processor_get_throttling()
>   work_on_cpu(acpi_processor_get_throttling)
> 
> That work does:
> 
> __acpi_processor_get_throttling()
>     acpi_processor_get_throttling_ptc()
>       acpi_processor_set_throttling()
>         work_on_cpu(__acpi_processor_set_throttling)
> 
> Why the heck calls a get_throttling() function set_throttling()? I'm mildly
> surprised.
> 
> Does the delta patch below cure the problem?

Yes, aside from a compile warn.

But that's disgusting... then again, you merely reintroduced this hack.
