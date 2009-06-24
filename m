From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
Date: Wed, 24 Jun 2009 15:47:03 +0800
Message-ID: <20090624074703.GA28458@sli10-desk.sh.intel.com>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com> <1245825558.19816.1861.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37395 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028AbZFXHrI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 03:47:08 -0400
Content-Disposition: inline
In-Reply-To: <1245825558.19816.1861.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "andi@firstfloor.org" <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>

On Wed, Jun 24, 2009 at 02:39:18PM +0800, Peter Zijlstra wrote:
> On Wed, 2009-06-24 at 12:13 +0800, Shaohua Li wrote:
> > This patch supports the processor aggregator device. When OS gets one ACPI
> > notification, the driver will idle some number of cpus.
> > 
> > To make CPU idle, the patch will create power saving thread. Scheduler
> > will migrate the thread to preferred CPU. The thread has max priority and
> > has SCHED_RR policy, so it can occupy one CPU. To save power, the thread will
> > keep calling C-state instruction. Routine power_saving_thread() is the entry
> > of the thread.
> > 
> > To avoid starvation, the thread will sleep 5% time for every second
> > (current RT scheduler has threshold to avoid starvation, but if other
> > CPUs are idle, the CPU can borrow CPU timer from other, so makes the mechanism
> > not work here)
> > 
> > This approach (to force CPU idle) should hasn't impact to scheduler and tasks
> > with affinity still can get chance to run even the tasks run on idled cpu. Any
> > comments/suggestions are welcome.
> 
> > +static int power_saving_thread(void *data)
> > +{
> > +	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1};
> > +	int do_sleep;
> > +
> > +	/*
> > +	 * we just create a RT task to do power saving. Scheduler will migrate
> > +	 * the task to any CPU.
> > +	 */
> > +	sched_setscheduler(current, SCHED_RR, &param);
> > +
> 
> This is crazy and wrong.
> 
> 1) cpusets can be so configured as to not have the full machine in a
> single load-balance domain, eg. the above comment about the scheduler is
> false.
Assume user will not assign such thread to a cpuset, if yes, it's user's
wrong.
 
> 2) you're running at MAX_RT_PRIO-1, this will mightily upset the
> migration thread and kstopmachine bits.
> 
> 3) you're going to starve RT processes by being of a higher priority,
> even though you might gain enough idle time by simply moving SCHED_OTHER
> tasks around.
for 2/3, the power saving thread has SCHED_RR, it will run out of its time slice
in 100ms. SCHED_OTHER might not work, because the system might be very busy.

Or we can lower the priority to not upset kernel RT threads. Usually applications
are not RT.

> 4) you're introducing 57s latencies to processes that happen to get
> scheduled on whatever CPU you end up on, not nice.
Sorry for my ignorance on scheduler, I don't understand what you mean.
Won't scheduler will migrate normal threads out the cpu?

Thanks,
Shaohua
