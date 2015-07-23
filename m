From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/5] Make cpuid <-> nodeid mapping persistent.
Date: Thu, 23 Jul 2015 14:32:28 -0400
Message-ID: <20150723183228.GR15934@mtj.duckdns.org>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com>
 <20150715221345.GO15934@mtj.duckdns.org>
 <55B07145.5010404@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <55B07145.5010404@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

Hello, Tang.

On Thu, Jul 23, 2015 at 12:44:53PM +0800, Tang Chen wrote:
> Allocating cpuid when a new cpu comes up and reusing the cpuid when it
> comes up again is possible. But I'm not quite sure if it will be less
> modification
> because we still need an array or bit map or something to keep the mapping,
> and select backup nodes for cpus on memory-less nodes when allocating
> memory.
> 
> I can post a set of patches for this idea. And then we can see which one is
> better.

I suspect the difference could be that in the current code the users
(workqueue) can remain the same while if we do it lazily there
probably needs to be a way to poke it.  As long as the IDs are
allocated to the online CPUs first, I think pre-allocating everything
should be fine too.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
