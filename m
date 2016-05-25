From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7 0/5] Make cpuid <-> nodeid mapping persistent
Date: Wed, 25 May 2016 16:37:31 -0400
Message-ID: <20160525203731.GJ3354@mtj.duckdns.org>
References: <cover.1463652944.git.zhugh.fnst@cn.fujitsu.com>
 <20160519144657.GK3206@twins.programming.kicks-ass.net>
 <5742AAF6.3060901@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <5742AAF6.3060901@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 23, 2016 at 03:02:14PM +0800, Zhu Guihua wrote:
> We tried to do that. You can see our patch at
> http://www.gossamer-threads.com/lists/linux/kernel/2116748
> 
> But maintainer thought, we should establish persistent cpuid<->nodeid
> relationship,
> there is no need to change the map.
> 
> Cc TJ,
> Could we return to workqueue to fix this?

Workqueue is just one of symptoms.  We have the same problem for
memory allocation paths.  It's either keeping cpu <-> node mapping
persistent or hunting down every case which may be affected and build
likely costly synchronization construct around it.  It's not like we
have a lot of archs which support CPU hotplug and NUMA.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
