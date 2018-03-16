From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH v2] ACPI / processor: Fix possible CPUs map
Date: Fri, 16 Mar 2018 10:51:43 +0800
Message-ID: <cb79c370-8c6f-2ef7-9a0a-ed33bd485113@cn.fujitsu.com>
References: <20180315030756.5548-1-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1803151436200.1525@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1803151436200.1525@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, rafael@kernel.org, dedekind1@gmail.com, Ming Lei <ming.lei@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Thomas,

At 03/15/2018 09:45 PM, Thomas Gleixner wrote:
[...]

> I tested this on a machine which claims to have gazillion of hotplugable
> CPUs:

I really appreciate your test.

> 
> 	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
> 	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
> 	smp: Brought up 2 nodes, 32 CPUs
> 
> Now with your patch applied it's still saying:
> 
> 	smpboot: Allowing 152 CPUs, 120 hotplug CPUs
> 	setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:152 nr_node_ids:2
> 	smp: Brought up 2 nodes, 32 CPUs
> 
> and the above code runs later on and the result is:
> 
> 	nr_unique_ids 1 nr_cpu_ids 152
> 	Allowing 1 possible CPU
> 
> which subsequently causes the machine to die as we have already 32 CPUs
> online.
> 

That is so interesting, it proofs that this strategy is risky.

I've been wondering how to determine the number of possible CPUs. Due to
the diversity of ACPI in different systems, that seems impossible. Why 
don't I change my mind? Here is a new strategy and I think it is more
reasonable and minimally invasive.

   As we all know, we reset possible CPUs in the prefill_possible_map(),
   If CONFIG_HOTPLUG_CPU = y :
       nr_possible_CPUs = num_processors + disabled_cpus.

   Before the prefill_possible_map(), *Fix the inaccurate disabled_cpus*:

     1) For each disabled CPUs, get it's processor id from ACPI MADT

     2) Check whether this processor id is existed in ACPI namespace or not.
        If false, disabled_cpus--;

I will show you the code and test it later. And IMO, the code logic in
prefill_possible_map() is a little mess, will try to sort it out first.

> So nr_unique_ids is not what it should be and even if it would be the code
> runs way too late. It needs to run _before_ setup_percpu() is invoked to
> scale everything correctly.
> 

Yes, Got it.

Thanks,
	dou

> Thanks,
> 
> 	tglx
> 
> 
> 
> 
> 
> 
