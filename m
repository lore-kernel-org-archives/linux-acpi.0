From: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v7 0/5] Make cpuid <-> nodeid mapping persistent
Date: Mon, 23 May 2016 15:02:14 +0800
Message-ID: <5742AAF6.3060901@cn.fujitsu.com>
References: <cover.1463652944.git.zhugh.fnst@cn.fujitsu.com> <20160519144657.GK3206@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160519144657.GK3206@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 05/19/2016 10:46 PM, Peter Zijlstra wrote:
> On Thu, May 19, 2016 at 06:39:41PM +0800, Zhu Guihua wrote:
>> [Problem]
>>
>> cpuid <-> nodeid mapping is firstly established at boot time. And workqueue caches
>> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot time.
>>
>> When doing node online/offline, cpuid <-> nodeid mapping is established/destroyed,
>> which means, cpuid <-> nodeid mapping will change if node hotplug happens. But
>> workqueue does not update wq_numa_possible_cpumask.
> So why are you not fixing up wq_numa_possible_cpumask instead? That
> seems the far easier solution.

We tried to do that. You can see our patch at
http://www.gossamer-threads.com/lists/linux/kernel/2116748

But maintainer thought, we should establish persistent cpuid<->nodeid 
relationship,
there is no need to change the map.

Cc TJ,
Could we return to workqueue to fix this?

Thanks,
Zhu

> Do all the other archs that support NUMA and HOTPLUG have the mapping
> stable, or will you now go fix each and every one of them?
>
>
> .
>



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
