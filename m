From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 0/5] Make cpuid <-> nodeid mapping persistent
Date: Thu, 19 May 2016 16:46:57 +0200
Message-ID: <20160519144657.GK3206@twins.programming.kicks-ass.net>
References: <cover.1463652944.git.zhugh.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <cover.1463652944.git.zhugh.fnst@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 19, 2016 at 06:39:41PM +0800, Zhu Guihua wrote:
> [Problem]
> 
> cpuid <-> nodeid mapping is firstly established at boot time. And workqueue caches
> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot time.
> 
> When doing node online/offline, cpuid <-> nodeid mapping is established/destroyed,
> which means, cpuid <-> nodeid mapping will change if node hotplug happens. But
> workqueue does not update wq_numa_possible_cpumask.

So why are you not fixing up wq_numa_possible_cpumask instead? That
seems the far easier solution.

Do all the other archs that support NUMA and HOTPLUG have the mapping
stable, or will you now go fix each and every one of them?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
