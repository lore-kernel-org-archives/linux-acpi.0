From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 5/8] acpi-cpufreq: Move average performance funtions
 into separate file and KConfig
Date: Mon, 20 Apr 2009 10:04:18 -0700
Message-ID: <1240247058.4529.8732.camel@localhost.localdomain>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
	 <1239978132-6261-6-git-send-email-trenn@suse.de>
	 <1239989529.4529.8651.camel@localhost.localdomain>
	 <200904201341.55382.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63575 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZDTRHG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 13:07:06 -0400
In-Reply-To: <200904201341.55382.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

On Mon, 2009-04-20 at 04:41 -0700, Thomas Renninger wrote:
> On Friday 17 April 2009 19:32:09 Pallipadi, Venkatesh wrote:
> >
> > There has been changes in this code recently changing work_on_cpu to
> > smp_call_function_single. So, you will have to rebase this patch.
> It can be adjusted easily with an on-top patch. This discussion should
> not hold off this patch series.
> 

Agree about not holding of this patch series. I just mentioned as I saw
conflicting changes, that this patch has to be rebased.

> > Also, I am not full certain whether cpufreq_stats is the right place
> > to do this. Why not have a userspace library (in cpufreq utils) that
> > reads the MSR and does the same calculation.
> I started with a userspace tool for that. In fact it's finish, I just
> wanted to add some parameters (-r reset MPERF/APERF registers, -i
> interval to (re-)read the MSRs, ...).
> Then cpufreq_stats.c came into my mind, which is IMO much more useful.
> 

I have thought about this in cpufreq_stats vs in userspace long and
hard. My feeling is this stuff belongs more in userspace than
cpufreq_stats. This has no direct relation to cpufreq. There is no
clear-cut way to export the information in cpufreq_stats. Average freq
since last read is not a good interface that multiple users can use.

> > Main issue I have with kernel API
> > is that I will never know what you are getting from this interface.
> > I mean there may be 10 other users other than me, calling this API
> > and from last call does not mean much in that situation.
> 
> Every caller has to remember the last read APERF/MPERF values.
> Therefore every caller knows it gets the average performance since the
> last time *he* called the function.
> Look at the cpufreq_stats changes, there you have:
> static DEFINE_PER_CPU(u64, saved_aperf);
> static DEFINE_PER_CPU(u64, saved_mperf);
> which remembers the values of the registers for *cpufreq_stats*.

One userspace tool (say for example top) reads this cpufreq_stats
average_freq and sleeps for 10 seconds.
After 9 seconds, another userspace tool (say for example vmstate) reads
this cpufreq_stats and sleeps for 10 seconds.
After 1 sec, top comes back to read the interface and gets average_freq
for 1 sec. But, it was expecting avg_freq for 10 secs and thats what it
will display as it have no way to know it got average freq for only 1
sec.

That is the biggest issue with having simplistic kernel interface that
apps will end up using wrongly and there is no way to control it.

This can be done in more clean way where multiple users can use this
MSRs and share it among themselves. That can be done using existing MSR
and CPUID drivers and no new kernel APIs.

> The same can be done for e.g. scheduler debug code in the kernel
> itself.
> I could imagine sched_mc_power developers will find this call
> convenient as it should be the only way to find out about the real
> frequency a core is running on. And they probably want to get this
> info *in the kernel* at least for debugging/monitoring. There are
> probably other use-cases.
> 
> This patch series is for splitting out average frequency into an own
> function and export it. I consider, getting the current running
> frequency of a processor, as an elementary function for upcoming
> machines where the cpufreq subsystem's values can be wrong (due to
> boost mode or HW restrictions).
> It may be that other kernel parts are really needing this or it could
> be that it's only used for monitoring/debugging, but I am pretty sure
> this interface will be useful. Hmm, I should have added lkml or x86
> list so that others could comment whether getting the average freq
> will be useful for developing, I thought this is obvious.
> Do you agree that the split and re-use of this code should happen?
> Should I repost with lkml added for broader discussion?
> 

I agree with splitting this code out and having some in kernel APIs for
scheduler, debugger, perfmon etc to use it. I don't like the new
kernel-user API. So, my comments are for your next patch

[PATCH 6/8] CPUFREQ: Add average frequency to sysfs exported files of
cpufreq_stats
  
> > Userlevel lib that can keep track of pid or some handle and track
> > multiple callers seems a better match for this.
> You can track multiple callers.
> I don't see the need of duplicating this in userspace, what exactly
> do you expect from a userspace implementation?
> Having this in cpufreq_stats should satisfy userspace monitoring
> needs. It avoids duplicated code and tests the in-kernel averg_perf
> implementation. It does only add 2 u64 per_cpu variables memory usage
> in a driver which is thought for debugging/monitoring anyway.
> 
> Will this (these) be accepted?

No, As I mentioned above having a userspace API not clearly defined is a
problem. And I dont like to add verhead of tracking each individual
caller (like ps or vmstat in above example) and returning appropriate
values for each caller from kernel. 

Thanks,
Venki


> PS: A general thing about such close to HW userspace tools:
> Could there be some cpuid library call in x86info propagated
> which makes checking for CPU features much more easy in C-/C++ code
> than parsing /proc/cpuinfo and /dev/cpu/X/{cpuid,msr}?
> I started with read_msr() and write_msr() library calls. Every little
> tool implementing the access to /dev/cpu/*/msr and parsing
> /proc/cpuinfo for CPU capabilities looks wrong.
> 
> Then the mysterious CPU flags could be replaced (longterm) at some
> time with a userspace tool, explaining what exactly they are for.
> Hmm, I better open an own thread for that, maybe Dave is even
> reading this...
> 

Agreed. Everytime I write some tiny app to look at cpuid and msr, I end
up reusing read_msr, write_msr kind of routines that I have in one of my
common lib file. They should be in some cpuid related library. May be it
is already there somewhere that we don't know about...


