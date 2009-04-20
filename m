From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 5/8] acpi-cpufreq: Move average performance funtions into separate file and KConfig
Date: Mon, 20 Apr 2009 13:41:54 +0200
Message-ID: <200904201341.55382.trenn@suse.de>
References: <1239978132-6261-1-git-send-email-trenn@suse.de> <1239978132-6261-6-git-send-email-trenn@suse.de> <1239989529.4529.8651.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56991 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784AbZDTLl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 07:41:57 -0400
In-Reply-To: <1239989529.4529.8651.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>

On Friday 17 April 2009 19:32:09 Pallipadi, Venkatesh wrote:
> 
> There has been changes in this code recently changing work_on_cpu to
> smp_call_function_single. So, you will have to rebase this patch.
It can be adjusted easily with an on-top patch. This discussion should 
not hold off this patch series.
 
> Also, I am not full certain whether cpufreq_stats is the right place
> to do this. Why not have a userspace library (in cpufreq utils) that
> reads the MSR and does the same calculation.
I started with a userspace tool for that. In fact it's finish, I just 
wanted to add some parameters (-r reset MPERF/APERF registers, -i 
interval to (re-)read the MSRs, ...).
Then cpufreq_stats.c came into my mind, which is IMO much more useful.

> Main issue I have with kernel API
> is that I will never know what you are getting from this interface.
> I mean there may be 10 other users other than me, calling this API
> and from last call does not mean much in that situation.

Every caller has to remember the last read APERF/MPERF values.
Therefore every caller knows it gets the average performance since the 
last time *he* called the function.
Look at the cpufreq_stats changes, there you have:
static DEFINE_PER_CPU(u64, saved_aperf);
static DEFINE_PER_CPU(u64, saved_mperf);
which remembers the values of the registers for *cpufreq_stats*.
The same can be done for e.g. scheduler debug code in the kernel 
itself.
I could imagine sched_mc_power developers will find this call 
convenient as it should be the only way to find out about the real 
frequency a core is running on. And they probably want to get this 
info *in the kernel* at least for debugging/monitoring. There are 
probably other use-cases.

This patch series is for splitting out average frequency into an own
function and export it. I consider, getting the current running 
frequency of a processor, as an elementary function for upcoming 
machines where the cpufreq subsystem's values can be wrong (due to 
boost mode or HW restrictions).
It may be that other kernel parts are really needing this or it could 
be that it's only used for monitoring/debugging, but I am pretty sure 
this interface will be useful. Hmm, I should have added lkml or x86 
list so that others could comment whether getting the average freq 
will be useful for developing, I thought this is obvious.
Do you agree that the split and re-use of this code should happen?
Should I repost with lkml added for broader discussion?

> Userlevel lib that can keep track of pid or some handle and track
> multiple callers seems a better match for this.
You can track multiple callers.
I don't see the need of duplicating this in userspace, what exactly
do you expect from a userspace implementation?
Having this in cpufreq_stats should satisfy userspace monitoring 
needs. It avoids duplicated code and tests the in-kernel averg_perf 
implementation. It does only add 2 u64 per_cpu variables memory usage 
in a driver which is thought for debugging/monitoring anyway.

Will this (these) be accepted?

Thanks,

    Thomas

PS: A general thing about such close to HW userspace tools:
Could there be some cpuid library call in x86info propagated
which makes checking for CPU features much more easy in C-/C++ code
than parsing /proc/cpuinfo and /dev/cpu/X/{cpuid,msr}?
I started with read_msr() and write_msr() library calls. Every little 
tool implementing the access to /dev/cpu/*/msr and parsing 
/proc/cpuinfo for CPU capabilities looks wrong.

Then the mysterious CPU flags could be replaced (longterm) at some 
time with a userspace tool, explaining what exactly they are for.
Hmm, I better open an own thread for that, maybe Dave is even
reading this...

    Thomas

> Thanks,
> Venki
> 
> On Fri, 2009-04-17 at 07:22 -0700, Thomas Renninger wrote:
> > This makes the code available for cpufreq_stats to monitor the 
average
> > frequency easily in userspace.
> > exports:
> > EXPORT_SYMBOL_GPL(get_average_perf)
> > unsigned int get_average_perf(struct cpufreq_policy *policy, 
unsigned int cpu,
> > 			      u64 *saved_aperf, u64 *saved_mperf)
> > 
> > Additional modification:
> > Use smp_call_function_single instead of work_on_cpu.
> > The latter was broken anyway and 0 was always returned as the 
called function
> > read_measured_perf_ctrs always returns zero which work_on_cpu's 
return value
> > was checked for:
> > if (!work_on_cpu(cpu, read_measured_perf_ctrs, &readin))
> > 		return 0;
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > Cc: <linux-acpi@vger.kernel.org>
> > Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
> > Cc: <cpufreq@vger.kernel.org>
> > ---
> >  arch/x86/kernel/cpu/cpufreq/Kconfig             |   15 +++
> >  arch/x86/kernel/cpu/cpufreq/Makefile            |    1 +
> >  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c      |   96 
+--------------
> >  arch/x86/kernel/cpu/cpufreq/average_frequency.c |  146 
+++++++++++++++++++++++
> >  include/linux/cpufreq.h                         |   13 ++
> >  5 files changed, 178 insertions(+), 93 deletions(-)
> >  create mode 100644 
arch/x86/kernel/cpu/cpufreq/average_frequency.c
> > 
> > diff --git a/arch/x86/kernel/cpu/cpufreq/Kconfig 
b/arch/x86/kernel/cpu/cpufreq/Kconfig
> > index 52c8398..3ca1602 100644
> > --- a/arch/x86/kernel/cpu/cpufreq/Kconfig
> > +++ b/arch/x86/kernel/cpu/cpufreq/Kconfig
> > @@ -26,6 +26,21 @@ config X86_ACPI_CPUFREQ
> >  
> >  	  If in doubt, say N.
> >  
> > +config X86_AVERAGE_FREQUENCY
> > +	bool "Calculate and consider average frequency over a time 
period"
> > +	depends on CPU_FREQ_TABLE
> > +	help
> > +	  Latest X86 Intel processors can overclock a single core
> > +	  behind the kernel's back (ida cpuinfo flag) if specific 
requirements
> > +	  are met.
> > +	  With this option, the kernel can evaluate the real frequency a 
core
> > +	  was running on over a time period and kernel parts, for 
example
> > +	  the cpufreq core and governor or later the scheduler can 
consider and
> > +	  optimize for the "boost" frequency on such processors.
> > +	  Currently the only driver which serves such processors is 
acpi-cpufreq.
> > +	  This option should be enabled for this driver at least
> > +	  on processors which show the "ida" flag in /proc/cpuinfo
> > +
> >  config ELAN_CPUFREQ
> >  	tristate "AMD Elan SC400 and SC410"
> >  	select CPU_FREQ_TABLE
> > diff --git a/arch/x86/kernel/cpu/cpufreq/Makefile 
b/arch/x86/kernel/cpu/cpufreq/Makefile
> > index 509296d..3eb5a64 100644
> > --- a/arch/x86/kernel/cpu/cpufreq/Makefile
> > +++ b/arch/x86/kernel/cpu/cpufreq/Makefile
> > @@ -2,6 +2,7 @@
> >  # K8 systems. ACPI is preferred to all other hardware-specific 
drivers.
> >  # speedstep-* is preferred over p4-clockmod.
> >  
> > +obj-$(CONFIG_X86_AVERAGE_FREQUENCY)     += average_frequency.o
> >  obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
> >  obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
> >  obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> > diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c 
b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > index 7a9a161..148857a 100644
> > --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > @@ -246,102 +246,12 @@ static u32 get_cur_val(const struct cpumask 
*mask)
> >  	return cmd.val;
> >  }
> >  
> > -struct perf_pair {
> > -	union {
> > -		struct {
> > -			u32 lo;
> > -			u32 hi;
> > -		} split;
> > -		u64 whole;
> > -	} aperf, mperf;
> > -};
> > -
> > -
> > -static long read_measured_perf_ctrs(void *_cur)
> > -{
> > -	struct perf_pair *cur = _cur;
> > -
> > -	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
> > -	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
> > -
> > -	return 0;
> > -}
> > -
> > -/*
> > - * Return the measured active (C0) frequency on this CPU since 
last call
> > - * to this function.
> > - * Input: cpu number
> > - * Return: Average CPU frequency in terms of max frequency (zero 
on error)
> > - *
> > - * We use IA32_MPERF and IA32_APERF MSRs to get the measured 
performance
> > - * over a period of time, while CPU is in C0 state.
> > - * IA32_MPERF counts at the rate of max advertised frequency
> > - * IA32_APERF counts at the rate of actual CPU frequency
> > - * Only IA32_APERF/IA32_MPERF ratio is architecturally defined 
and
> > - * no meaning should be associated with absolute values of these 
MSRs.
> > - */
> >  static unsigned int get_measured_perf(struct cpufreq_policy 
*policy,
> >  				      unsigned int cpu)
> >  {
> > -	struct perf_pair readin, cur;
> > -	unsigned int perf_percent;
> > -	unsigned int retval;
> > -
> > -	if (!work_on_cpu(cpu, read_measured_perf_ctrs, &readin))
> > -		return 0;
> > -
> > -	cur.aperf.whole = readin.aperf.whole -
> > -				per_cpu(msr_data, cpu).saved_aperf;
> > -	cur.mperf.whole = readin.mperf.whole -
> > -				per_cpu(msr_data, cpu).saved_mperf;
> > -	per_cpu(msr_data, cpu).saved_aperf = readin.aperf.whole;
> > -	per_cpu(msr_data, cpu).saved_mperf = readin.mperf.whole;
> > -
> > -#ifdef __i386__
> > -	/*
> > -	 * We dont want to do 64 bit divide with 32 bit kernel
> > -	 * Get an approximate value. Return failure in case we cannot 
get
> > -	 * an approximate value.
> > -	 */
> > -	if (unlikely(cur.aperf.split.hi || cur.mperf.split.hi)) {
> > -		int shift_count;
> > -		u32 h;
> > -
> > -		h = max_t(u32, cur.aperf.split.hi, cur.mperf.split.hi);
> > -		shift_count = fls(h);
> > -
> > -		cur.aperf.whole >>= shift_count;
> > -		cur.mperf.whole >>= shift_count;
> > -	}
> > -
> > -	if (((unsigned long)(-1) / 100) < cur.aperf.split.lo) {
> > -		int shift_count = 7;
> > -		cur.aperf.split.lo >>= shift_count;
> > -		cur.mperf.split.lo >>= shift_count;
> > -	}
> > -
> > -	if (cur.aperf.split.lo && cur.mperf.split.lo)
> > -		perf_percent = (cur.aperf.split.lo * 100) / cur.mperf.split.lo;
> > -	else
> > -		perf_percent = 0;
> > -
> > -#else
> > -	if (unlikely(((unsigned long)(-1) / 100) < cur.aperf.whole)) {
> > -		int shift_count = 7;
> > -		cur.aperf.whole >>= shift_count;
> > -		cur.mperf.whole >>= shift_count;
> > -	}
> > -
> > -	if (cur.aperf.whole && cur.mperf.whole)
> > -		perf_percent = (cur.aperf.whole * 100) / cur.mperf.whole;
> > -	else
> > -		perf_percent = 0;
> > -
> > -#endif
> > -
> > -	retval = (policy->cpuinfo.max_freq * perf_percent) / 100;
> > -
> > -	return retval;
> > +	return get_average_perf(policy, cpu,
> > +				&per_cpu(msr_data, cpu).saved_aperf,
> > +				&per_cpu(msr_data, cpu).saved_mperf);
> >  }
> >  
> >  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> > diff --git a/arch/x86/kernel/cpu/cpufreq/average_frequency.c 
b/arch/x86/kernel/cpu/cpufreq/average_frequency.c
> > new file mode 100644
> > index 0000000..2b18a75
> > --- /dev/null
> > +++ b/arch/x86/kernel/cpu/cpufreq/average_frequency.c
> > @@ -0,0 +1,146 @@
> > +/*
> > + *  average_frequency.c
> > + *
> > + *  Copyright (C) 2009       Thomas Renninger <trenn@suse.de> 
(Novell)
> > + *
> > + * 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + *  This program is free software; you can redistribute it and/or 
modify
> > + *  it under the terms of the GNU General Public License as 
published by
> > + *  the Free Software Foundation; either version 2 of the 
License, or (at
> > + *  your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be 
useful, but
> > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU
> > + *  General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public 
License along
> > + *  with this program; if not, write to the Free Software 
Foundation, Inc.,
> > + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> > + *
> > + * 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + * Code taken from acpi-cpufreq which initially came from
> > + * Mike Travis <travis@sgi.com> and
> > + * Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <asm/msr.h>
> > +
> > +struct perf_pair {
> > +	union {
> > +		struct {
> > +			u32 lo;
> > +			u32 hi;
> > +		} split;
> > +		s64 whole;
> > +	} aperf, mperf;
> > +};
> > +
> > +static void read_measured_perf_ctrs(void *_cur)
> > +{
> > +	struct perf_pair *cur = _cur;
> > +
> > +	rdmsr(MSR_IA32_APERF, cur->aperf.split.lo, cur->aperf.split.hi);
> > +	rdmsr(MSR_IA32_MPERF, cur->mperf.split.lo, cur->mperf.split.hi);
> > +}
> > +
> > +/*
> > + * Return the measured active (C0) frequency on this CPU since 
last call
> > + * to this function.
> > + * Input: cpu number
> > + *        cpufreq policy -> must at least have cpuinfo.max_freq 
be set
> > + *        saved_mperf    -> register value of last call, will get 
updated
> > + *        saved_aperf    -> register value of last call, will get 
updated
> > + *
> > + * Return: Average CPU frequency in terms of max frequency (zero 
on error)
> > + *         since the function has been called the last time with 
saved
> > + *         aperf/mperf values.
> > + *
> > + * We use IA32_MPERF and IA32_APERF MSRs to get the measured 
performance
> > + * over a period of time, while CPU is in C0 state.
> > + * IA32_MPERF counts at the rate of max advertised frequency
> > + * IA32_APERF counts at the rate of actual CPU frequency
> > + * Only IA32_APERF/IA32_MPERF ratio is architecturally defined 
and
> > + * no meaning should be associated with absolute values of these 
MSRs.
> > + *
> > + * Callers must make sure that the X86_FEATURE_IDA bit is set.
> > + */
> > +unsigned int get_average_perf(struct cpufreq_policy *policy, 
unsigned int cpu,
> > +			      u64 *saved_aperf, u64 *saved_mperf)
> > +{
> > +	struct perf_pair readin, cur;
> > +	unsigned int perf_percent;
> > +	unsigned int retval;
> > +
> > +	smp_call_function_single(cpu, read_measured_perf_ctrs, &readin, 
1);
> > +
> > +	/* Called the first time */
> > +	if ((*saved_aperf == 0) && (*saved_mperf == 0)) {
> > +		*saved_aperf = readin.aperf.whole;
> > +		*saved_mperf = readin.mperf.whole;
> > +		return 0;
> > +	}
> > +
> > +	cur.aperf.whole = readin.aperf.whole - *saved_aperf;
> > +	cur.mperf.whole = readin.mperf.whole - *saved_mperf;
> > +
> > +	/* Handle overflow gracefully */
> > +	if (unlikely(*saved_aperf > readin.aperf.whole))
> > +		cur.aperf.whole = 0ULL - readin.aperf.whole;
> > +	if (unlikely(*saved_mperf > readin.mperf.whole))
> > +		cur.mperf.whole = 0ULL - readin.mperf.whole;
> > +
> > +	*saved_aperf = readin.aperf.whole;
> > +	*saved_mperf = readin.mperf.whole;
> > +
> > +#ifdef __i386__
> > +	/*
> > +	 * We dont want to do 64 bit divide with 32 bit kernel
> > +	 * Get an approximate value. Return failure in case we cannot 
get
> > +	 * an approximate value.
> > +	 */
> > +	if (unlikely(cur.aperf.split.hi || cur.mperf.split.hi)) {
> > +		int shift_count;
> > +		u32 h;
> > +
> > +		h = max_t(u32, cur.aperf.split.hi, cur.mperf.split.hi);
> > +		shift_count = fls(h);
> > +
> > +		cur.aperf.whole >>= shift_count;
> > +		cur.mperf.whole >>= shift_count;
> > +	}
> > +
> > +	if (((unsigned long)(-1) / 100) < cur.aperf.split.lo) {
> > +		int shift_count = 7;
> > +		cur.aperf.split.lo >>= shift_count;
> > +		cur.mperf.split.lo >>= shift_count;
> > +	}
> > +
> > +	if (cur.aperf.split.lo && cur.mperf.split.lo)
> > +		perf_percent = (cur.aperf.split.lo * 100) / cur.mperf.split.lo;
> > +	else
> > +		perf_percent = 0;
> > +
> > +#else
> > +	if (unlikely(((unsigned long)(-1) / 100) < cur.aperf.whole)) {
> > +		int shift_count = 7;
> > +		cur.aperf.whole >>= shift_count;
> > +		cur.mperf.whole >>= shift_count;
> > +	}
> > +
> > +	if (cur.aperf.whole && cur.mperf.whole)
> > +		perf_percent = (cur.aperf.whole * 100) / cur.mperf.whole;
> > +	else
> > +		perf_percent = 0;
> > +
> > +#endif
> > +	retval = (policy->cpuinfo.max_freq * perf_percent) / 100;
> > +	return retval;
> > +}
> > +EXPORT_SYMBOL_GPL(get_average_perf);
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 1610427..0ab8bf7 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -362,6 +362,19 @@ void cpufreq_frequency_table_get_attr(struct 
cpufreq_frequency_table *table,
> >  
> >  void cpufreq_frequency_table_put_attr(unsigned int cpu);
> >  
> > +/*
> > + * Get the average frequency since the last call of this function 
if the
> > + * needed MSRs are supported by the CPU
> > +*/
> > +#ifdef CONFIG_X86_AVERAGE_FREQUENCY
> > +unsigned int get_average_perf(struct cpufreq_policy *policy, 
unsigned int cpu,
> > +			      u64 *saved_aperf, u64 *saved_mperf);
> > +#else
> > +unsigned int get_average_perf(struct cpufreq_policy *policy, 
unsigned int cpu,
> > +			      u64 *saved_aperf, u64 *saved_mperf)
> > +{ return 0; }
> > +#endif
> > +
> >  
> >  
/*********************************************************************
> >   *                     UNIFIED DEBUG HELPERS                         
*
> 
> 


