From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Thu, 08 Sep 2016 11:28:48 -0700
Message-ID: <1473359328.154359.61.camel@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
         <20160908075955.GS10153@twins.programming.kicks-ass.net>
         <20160908180928.GB23509@linux.intel.com>
         <20160908182215.GA10153@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7226 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbcIHS2u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Sep 2016 14:28:50 -0400
In-Reply-To: <20160908182215.GA10153@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2016-09-08 at 20:22 +0200, Peter Zijlstra wrote:
> On Thu, Sep 08, 2016 at 11:09:28AM -0700, Tim Chen wrote:
> > 
> > On Thu, Sep 08, 2016 at 09:59:55AM +0200, Peter Zijlstra wrote:
> > > 
> > > I think there's a race here, if two tasks were to write to the
> > > sysctl
> > > they'd both change the value before getting stuck on the mutex in
> > > enable_sched_itmt().
> > > 
> > > One way around that is doing something like:
> > > 
> > > 
> > > 	struct ctl_table t;
> > > 	int val = sysctl_sched_itmt_enabled;
> > > 
> > > 	t = *table;
> > > 	t.data = &val;
> > > 
> > > 	proc_dointvec_minmax(&t, ...);
> > > 
> > > 	/* and update the sysctl_sched_itmt_enabled value inside the
> > > mutex */
> > > 	enable_sched_itmi(val);
> > 
> > Peter,
> > 
> > Since enable_sched_itmt is only used by sched_itmt_update_handler,
> > I've moved the mutex locking to sched_itmt_update_handler to
> > eliminate
> > the race condition in the code path you mentioned.
> 
> That is indeed simpler. Thanks!
Do we need to send v3 to include these changes?

Thanks,
Srinivas

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
