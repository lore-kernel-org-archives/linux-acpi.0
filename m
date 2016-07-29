From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 2/7] x86, acpi, cpu-hotplug: Enable acpi to register
 all possible cpus at boot time.
Date: Fri, 29 Jul 2016 15:36:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1607291526210.19896@nanos>
References: <1469513429-25464-1-git-send-email-douly.fnst@cn.fujitsu.com> <1469513429-25464-3-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51614 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcG2Nkh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2016 09:40:37 -0400
In-Reply-To: <1469513429-25464-3-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>, Tang Chen <tangchen@cn.fujitsu.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>

On Tue, 26 Jul 2016, Dou Liyang wrote: 

> 1. Enable apic registeration flow to handle both enabled and disabled cpus.
>    This is done by introducing an extra parameter to generic_processor_info to
>    let the caller control if disabled cpus are ignored.

If I'm reading the patch correctly then the 'enabled' argument controls more
than the disabled cpus accounting. It also controls the modification of
num_processors and the present mask.
 
> -int generic_processor_info(int apicid, int version)
> +static int __generic_processor_info(int apicid, int version, bool enabled)
>  {
>  	int cpu, max = nr_cpu_ids;
>  	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
> @@ -2032,7 +2032,8 @@ int generic_processor_info(int apicid, int version)
>  			   " Processor %d/0x%x ignored.\n",
>  			   thiscpu, apicid);
>  
> -		disabled_cpus++;
> +		if (enabled)
> +			disabled_cpus++;
>  		return -ENODEV;
>  	}
>  
> @@ -2049,7 +2050,8 @@ int generic_processor_info(int apicid, int version)
>  			" reached. Keeping one slot for boot cpu."
>  			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
>  
> -		disabled_cpus++;
> +		if (enabled)
> +			disabled_cpus++;

This is utterly confusing. That code path cannot be reached when enabled is
false, because num_processors is 0 as we never increment it when enabled is
false.

That said, I really do not like this 'slap some argument on it and make it
work somehow' approach.

The proper solution for this is to seperate out the functionality which you
need for the preparation run (enabled = false) and make sure that the
information you need for the real run (enabled = true) is properly cached
somewhere so we don't have to evaluate the same thing over and over.

Thanks,

	tglx
