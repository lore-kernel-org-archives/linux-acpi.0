From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch for 2.6.30 2/2]
 arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid cross-CPU interrupts
Date: Tue, 14 Apr 2009 10:18:17 -0700
Message-ID: <20090414101817.0c935261.akpm@linux-foundation.org>
References: <200904110617.n3B6HJ7W026502@imap1.linux-foundation.org>
	<20090412000605.GA23869@redhat.com>
	<20090411174644.ea6f63c6.akpm@linux-foundation.org>
	<200904141821.37413.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41264 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757488AbZDNR1W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 13:27:22 -0400
In-Reply-To: <200904141821.37413.rusty@rustcorp.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Jones <davej@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, efault@gmx.de, len.brown@intel.com, mingo@elte.hu, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

On Tue, 14 Apr 2009 18:21:36 +0930 Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Sun, 12 Apr 2009 10:16:44 am Andrew Morton wrote:
> > I suspect that changing cpumask_any() to preferentially return this-cpu
> > will always give us the behaviour that we prefer, but I haven't looked
> > into it.
> 
> How's this?
> 
> Subject: cpumask: cpumask_closest()
> 
> Impact: new function
> 
> Andrew points out that acpi-cpufreq uses cpumask_any, when it really
> would prefer to use the same CPU if possible (to avoid an IPI).  In 
> general, this seems a good idea to offer.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> CC: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -931,6 +931,8 @@ static inline void cpumask_copy(struct c
>   */
>  #define cpumask_of(cpu) (get_cpu_mask(cpu))
>  
> +unsigned int cpumask_closest(const struct cpumask *mask);
> +
>  /**
>   * cpumask_scnprintf - print a cpumask into a string as comma-separated hex
>   * @buf: the buffer to sprintf into
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -170,3 +170,26 @@ void __init free_bootmem_cpumask_var(cpu
>  	free_bootmem((unsigned long)mask, cpumask_size());
>  }
>  #endif
> +
> +/**
> + * cpumask_closest - return the closest cpu in mask.
> + * @mask: the cpus to choose from.
> + *
> + * Returns >= nr_cpu_ids if no bits are set in @mask.
> + */
> +unsigned int cpumask_closest(const struct cpumask *mask)
> +{
> +	unsigned int cpu = raw_smp_processor_id();
> +
> +	/* Try for same CPU. */
> +	if (cpumask_test_cpu(cpu, mask))
> +		return cpu;
> +
> +	/* Try for same node. */
> +	cpu = cpumask_any_and(cpumask_of_node(cpu), mask);
> +	if (cpu <= nr_cpu_ids)
> +		return cpu;
> +
> +	/* Anything will do. */
> +	return cpumask_any(mask);
> +}

Should it be exported?

It looks all racy against hotplug.  What are the caller's
responsibilities here?

<greps a bit>

any_online_cpu() could use cpumask_closest(), against (*mask & cpu_online_map).

I think all cpumask_any() call sites can be migrated to
cpumask_closest() with, at worst, no benefit.

