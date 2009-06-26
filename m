From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Fri, 26 Jun 2009 23:46:23 +0530
Message-ID: <20090626181623.GF7717@dirshya.in.ibm.com>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins> <20090624074703.GA28458@sli10-desk.sh.intel.com> <1245830585.31755.11.camel@twins> <20090624082112.GA20844@sli10-desk.sh.intel.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:37133 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbZFZSQw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 14:16:52 -0400
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5R48jVc010913
	for <linux-acpi@vger.kernel.org>; Sat, 27 Jun 2009 14:08:45 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5QIGsZU1044708
	for <linux-acpi@vger.kernel.org>; Sat, 27 Jun 2009 04:16:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5QIGrDd009415
	for <linux-acpi@vger.kernel.org>; Sat, 27 Jun 2009 04:16:54 +1000
Content-Disposition: inline
In-Reply-To: <20090624082112.GA20844@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

* Shaohua Li <shaohua.li@intel.com> [2009-06-24 16:21:12]:

> On Wed, Jun 24, 2009 at 04:03:05PM +0800, Peter Zijlstra wrote:
> > On Wed, 2009-06-24 at 15:47 +0800, Shaohua Li wrote:
> > > On Wed, Jun 24, 2009 at 02:39:18PM +0800, Peter Zijlstra wrote:
> > > > On Wed, 2009-06-24 at 12:13 +0800, Shaohua Li wrote:
> > > > > This patch supports the processor aggregator device. When OS gets one ACPI
> > > > > notification, the driver will idle some number of cpus.
> > > > > 
> > > > > To make CPU idle, the patch will create power saving thread. Scheduler
> > > > > will migrate the thread to preferred CPU. The thread has max priority and
> > > > > has SCHED_RR policy, so it can occupy one CPU. To save power, the thread will
> > > > > keep calling C-state instruction. Routine power_saving_thread() is the entry
> > > > > of the thread.
> > > > > 
> > > > > To avoid starvation, the thread will sleep 5% time for every second
> > > > > (current RT scheduler has threshold to avoid starvation, but if other
> > > > > CPUs are idle, the CPU can borrow CPU timer from other, so makes the mechanism
> > > > > not work here)
> > > > > 
> > > > > This approach (to force CPU idle) should hasn't impact to scheduler and tasks
> > > > > with affinity still can get chance to run even the tasks run on idled cpu. Any
> > > > > comments/suggestions are welcome.
> > > > 
> > > > > +static int power_saving_thread(void *data)
> > > > > +{
> > > > > +	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1};
> > > > > +	int do_sleep;
> > > > > +
> > > > > +	/*
> > > > > +	 * we just create a RT task to do power saving. Scheduler will migrate
> > > > > +	 * the task to any CPU.
> > > > > +	 */
> > > > > +	sched_setscheduler(current, SCHED_RR, &param);
> > > > > +
> > > > 
> > > > This is crazy and wrong.
> > > > 
> > > > 1) cpusets can be so configured as to not have the full machine in a
> > > > single load-balance domain, eg. the above comment about the scheduler is
> > > > false.
> > > Assume user will not assign such thread to a cpuset, if yes, it's user's
> > > wrong.
> > 
> > No its user policy, and esp on large machines cpusets are very useful.
> > The kernel not taking that into account is simply not an option.
> > 
> > Any thermal facility that doesn't take cpusets into account, or worse
> > destroys user policy (the hotplug road), is a full stop in my book.
> > 
> > Is similar to the saying the customer is always right, sure the admin
> > can indeed configure the machine so that any thermal policy is indeed
> > doomed to fail, and in that case I would print some warnings into syslog
> > and let the machine die of thermal overload -- not our problem.
> > 
> > The thing is, the admin configures it in a way, and then expects it to
> > work like that. If any random event can void the guarantees what good
> > are they?
> > 
> > Now, if ACPI-4.0 is so broken that it simply cannot support a sane
> > thermal model, then I suggest we simply not support this feature and
> > hope they will grow clue for 4.1 and try again next time.
> The assumption is user not assigns power saving thread to a specific cpuset.
> I thought the assumption is feasible, user can assign threads they care about
> to a cpuset, but not all.
> Power saving thread stays at the top cpuset, so it still has chance to run on any
> cpus. If power saving thread runs on a cpu, the tasks on the cpu still have chance
> to run (at least 0.05s), so it does not completely break user policy.

How do we handle interrupts and timers during this interval?  You seem
to disable interrupts and hold the cpu at idle for 0.95 sec.  It may
cause timeouts and overflows for network interrupts right?

Next issue is halting sibling threads belonging to a core at the same
time to have any power/thermal benefit.  Who does the coordination for
forced idle in this approach?

--Vaidy

