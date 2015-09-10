From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 5/7] x86, acpi, cpu-hotplug: Introduce
 apicid_to_cpuid[] array to store persistent cpuid <-> apicid mapping.
Date: Thu, 10 Sep 2015 15:55:32 -0400
Message-ID: <20150910195532.GK8114@mtj.duckdns.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
 <1441859269-25831-6-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1441859269-25831-6-git-send-email-tangchen@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hello,

So, overall, I think this is the right way to go although I have no
idea whether the acpi part is okay.

> +/*
> + * Current allocated max logical CPU ID plus 1.
> + * All allocated CPU ID should be in [0, max_logical_cpuid),
> + * so the maximum of max_logical_cpuid is nr_cpu_ids.
> + *
> + * NOTE: Reserve 0 for BSP.
> + */
> +static int max_logical_cpuid = 1;

Rename it to nr_logical_cpuids and just mention that it's allocated
contiguously?

> +static int cpuid_to_apicid[] = {
> +	[0 ... NR_CPUS - 1] = -1,
> +};

And maybe mention how the two variables are synchronized?

> +static int allocate_logical_cpuid(int apicid)
> +{
> +	int i;
> +
> +	/*
> +	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
> +	 * check if the kernel has allocated a cpuid for it.
> +	 */
> +	for (i = 0; i < max_logical_cpuid; i++) {
> +		if (cpuid_to_apicid[i] == apicid)
> +			return i;
> +	}
> +
> +	/* Allocate a new cpuid. */
> +	if (max_logical_cpuid >= nr_cpu_ids) {
> +		WARN_ONCE(1, "Only %d processors supported."
> +			     "Processor %d/0x%x and the rest are ignored.\n",
> +			     nr_cpu_ids - 1, max_logical_cpuid, apicid);
> +		return -1;
> +	}

So, the original code didn't have this failure mode, why is this
different for the new code?

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
