From: Len Brown <lenb@kernel.org>
Subject: stack bloat vs cpumask_t & big NR_CPUS
Date: Sat, 19 Jan 2008 00:44:47 -0500
Message-ID: <200801190044.47394.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60643 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbYASFpB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 00:45:01 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

Venki
acpi_cpufreq_target uses 3144 of stack on a big NR_CPUS box below
cpu_idle_wait uses 2568

looks like cpumask_t on the stack may not be a great idea...

-Len

----------  Forwarded Message  ----------

Subject: Re: [PATCH 4/5] x86: Add config variables for SMP_MAX
Date: Friday 18 January 2008 15:14
From: Mike Travis <travis@sgi.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu, Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Mike,
> 
> On Friday 18 January 2008, travis@sgi.com wrote:
>> +config THREAD_ORDER
>> +	int "Kernel stack size (in page order)"
>> +	range 1 3
>> +	depends on X86_64_SMP
>> +	default "3" if X86_SMP_MAX
>> +	default "1"
>> +	help
>> +	  Increases kernel stack size.
>> +
> 
> Could you please elaborate, why this is needed and put more info about
> this requirement into this patch description?
> 
> People worked hard to push data allocation from stack to heap to make 
> THREAD_ORDER of 0 and 1 possible. So why increase it again and why does this
> help scalability?
> 
> Many thanks and Best Regards
> 
> Ingo Oeser, puzzled a bit :-)


The primary problem arises because of cpumask_t local variables.  Until I
can deal with these, increasing NR_CPUS to a really large value increases
stack size dramatically.

Here are the top stack consumers with NR_CPUS = 4k.

                         16392 isolated_cpu_setup
                         10328 build_sched_domains
                          8248 numa_initmem_init
                          4664 cpu_attach_domain
                          4104 show_shared_cpu_map
                          3656 centrino_target
                          3608 powernowk8_cpu_init
                          3192 sched_domain_node_span
                          3144 acpi_cpufreq_target
                          2584 __svc_create_thread
                          2568 cpu_idle_wait
                          2136 netxen_nic_flash_print
                          2104 powernowk8_target
                          2088 _cpu_down
                          2072 cache_add_dev
                          2056 get_cur_freq
                             0 acpi_processor_ffh_cstate_probe
                          2056 microcode_write
                             0 acpi_processor_get_throttling
                          2048 check_supported_cpu

And I've yet to figure out how to accumulate stack sizes using
call threads.

Thanks,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
