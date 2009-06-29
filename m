From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Mon, 29 Jun 2009 10:54:55 +0800
Message-ID: <20090629025455.GA20614@sli10-desk.sh.intel.com>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins> <20090624074703.GA28458@sli10-desk.sh.intel.com> <1245830585.31755.11.camel@twins> <20090624082112.GA20844@sli10-desk.sh.intel.com> <20090626181623.GF7717@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57274 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbZF2Cyy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Jun 2009 22:54:54 -0400
Content-Disposition: inline
In-Reply-To: <20090626181623.GF7717@dirshya.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Sat, Jun 27, 2009 at 02:16:23AM +0800, Vaidyanathan Srinivasan wrote:
> * Shaohua Li <shaohua.li@intel.com> [2009-06-24 16:21:12]:
> 
> > On Wed, Jun 24, 2009 at 04:03:05PM +0800, Peter Zijlstra wrote:
> > > On Wed, 2009-06-24 at 15:47 +0800, Shaohua Li wrote:
> > > > On Wed, Jun 24, 2009 at 02:39:18PM +0800, Peter Zijlstra wrote:
> > > > > On Wed, 2009-06-24 at 12:13 +0800, Shaohua Li wrote:
> > > > > > This patch supports the processor aggregator device. When OS gets one ACPI
> > > > > > notification, the driver will idle some number of cpus.
> > > > > > 
> > > > > > To make CPU idle, the patch will create power saving thread. Scheduler
> > > > > > will migrate the thread to preferred CPU. The thread has max priority and
> > > > > > has SCHED_RR policy, so it can occupy one CPU. To save power, the thread will
> > > > > > keep calling C-state instruction. Routine power_saving_thread() is the entry
> > > > > > of the thread.
> > > > > > 
> > > > > > To avoid starvation, the thread will sleep 5% time for every second
> > > > > > (current RT scheduler has threshold to avoid starvation, but if other
> > > > > > CPUs are idle, the CPU can borrow CPU timer from other, so makes the mechanism
> > > > > > not work here)
> > > > > > 
> > > > > > This approach (to force CPU idle) should hasn't impact to scheduler and tasks
> > > > > > with affinity still can get chance to run even the tasks run on idled cpu. Any
> > > > > > comments/suggestions are welcome.
> > > > > 
> > > > > > +static int power_saving_thread(void *data)
> > > > > > +{
> > > > > > +	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1};
> > > > > > +	int do_sleep;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * we just create a RT task to do power saving. Scheduler will migrate
> > > > > > +	 * the task to any CPU.
> > > > > > +	 */
> > > > > > +	sched_setscheduler(current, SCHED_RR, &param);
> > > > > > +
> > > > > 
> > > > > This is crazy and wrong.
> > > > > 
> > > > > 1) cpusets can be so configured as to not have the full machine in a
> > > > > single load-balance domain, eg. the above comment about the scheduler is
> > > > > false.
> > > > Assume user will not assign such thread to a cpuset, if yes, it's user's
> > > > wrong.
> > > 
> > > No its user policy, and esp on large machines cpusets are very useful.
> > > The kernel not taking that into account is simply not an option.
> > > 
> > > Any thermal facility that doesn't take cpusets into account, or worse
> > > destroys user policy (the hotplug road), is a full stop in my book.
> > > 
> > > Is similar to the saying the customer is always right, sure the admin
> > > can indeed configure the machine so that any thermal policy is indeed
> > > doomed to fail, and in that case I would print some warnings into syslog
> > > and let the machine die of thermal overload -- not our problem.
> > > 
> > > The thing is, the admin configures it in a way, and then expects it to
> > > work like that. If any random event can void the guarantees what good
> > > are they?
> > > 
> > > Now, if ACPI-4.0 is so broken that it simply cannot support a sane
> > > thermal model, then I suggest we simply not support this feature and
> > > hope they will grow clue for 4.1 and try again next time.
> > The assumption is user not assigns power saving thread to a specific cpuset.
> > I thought the assumption is feasible, user can assign threads they care about
> > to a cpuset, but not all.
> > Power saving thread stays at the top cpuset, so it still has chance to run on any
> > cpus. If power saving thread runs on a cpu, the tasks on the cpu still have chance
> > to run (at least 0.05s), so it does not completely break user policy.
> 
> How do we handle interrupts and timers during this interval?  You seem
> to disable interrupts and hold the cpu at idle for 0.95 sec.  It may
> cause timeouts and overflows for network interrupts right?
The x86 mwait/monitor instruction can detect interrupt and complete execution
even interrupt is disabled, so this isn't an issue.

> Next issue is halting sibling threads belonging to a core at the same
> time to have any power/thermal benefit.  Who does the coordination for
> forced idle in this approach?
Nobody does the coordination. Halt some threads even they belong to a core
is the best we can provide now. For future, if the scheduler approach really
works, we will happily use it.

Thanks,
Shaohua
