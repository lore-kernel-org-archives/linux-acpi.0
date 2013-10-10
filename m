From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH part1 v6 4/6] x86/mem-hotplug: Support initialize page
 tables in bottom-up
Date: Wed, 9 Oct 2013 21:00:29 -0400
Message-ID: <20131010010029.GA10900@mtj.dyndns.org>
References: <524E2032.4020106@gmail.com>
 <524E2127.4090904@gmail.com>
 <5251F9AB.6000203@zytor.com>
 <525442A4.9060709@gmail.com>
 <20131009164449.GG22495@htj.dyndns.org>
 <52558EEF.4050009@gmail.com>
 <20131009192040.GA5592@mtj.dyndns.org>
 <1381352311.5429.115.camel@misato.fc.hp.com>
 <20131009211136.GH5592@mtj.dyndns.org>
 <1381363135.5429.138.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1381363135.5429.138.camel@misato.fc.hp.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: Zhang Yanfei <zhangyanfei.yes@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>Linux MM <lin>
List-Id: linux-acpi@vger.kernel.org

Hello, Toshi.

On Wed, Oct 09, 2013 at 05:58:55PM -0600, Toshi Kani wrote:
> Well, there was a plan before, which considered to enhance it to a
> memory device granularity at step 3.  But we had a major replan at step
> 1 per your suggestion.
> 
> https://lkml.org/lkml/2013/6/19/73

Where?

 "3. Improve memory hotplug to support local device pagetable."

How can the above possibly be considered as a plan for finer
granularity?  Forget about the "how" part.  The stated goal doesn't
even mention finer granularity.  Are firmware writers gonna be
required to split SRAT entries into multiple sub-nodes to support it?
Is segregating zones further for this even a good idea?  Adding more
NUMA nodes has its own overhead and the mm code isn't written
expecting it to be repurposed for segmenting the same NUMA node for
hotplug underneath it.

Maybe zoning is a viable approach.  Maybe it is not.  I don't know,
but you guys don't seem to be too interested in actual long term
planning while pushing for something invasive which may or may not be
viable in the longer term, which can often lead to silly situations.
It isn't even clear whether SRAT is the right interface for this.  If
it's gonna require firwmare writer's cooperation anyway, why not
provide the information as extended part of e820?  It doesn't seem to
have much to do with NUMA or zones.  The only information the kernel
needs to know is whether certain memory areas should only be used for
page cache.

At this point, at least to me, it doesn't seem reasonably clear how
this is gonna develop and the whole thing feels like a kludge, which
can be fine too, but seriously if you guys wanna push for an invasive
approach, it should really be backed by longer term plan, vision,
justification and the ability to make the necessary changes in the
various involved layers.  Maybe I'm being too pessimistic but I feel
that there are a lot missing in most of those areas, which makes it
quite risky to commit to invasive changes.

If the zone based kludgy appraoch is something meaningfully useful,
I'd suggest to sticking to it at least for now.  Some of it would be
useful anyway and if it doesn't fan out the added maintenance overhead
is fairly low.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
