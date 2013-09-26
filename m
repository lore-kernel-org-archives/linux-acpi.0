From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH v5 4/6] x86/mem-hotplug: Support initialize page tables
 in bottom-up
Date: Fri, 27 Sep 2013 00:03:01 +0800
Message-ID: <52445AB5.8030306@gmail.com>
References: <5241D897.1090905@gmail.com> <5241DA5B.8000909@gmail.com> <20130926144851.GF3482@htj.dyndns.org> <52445606.7030108@gmail.com> <20130926154813.GA32391@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130926154813.GA32391@mtj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>Linux MM <linu>
List-Id: linux-acpi@vger.kernel.org

On 09/26/2013 11:48 PM, Tejun Heo wrote:
> On Thu, Sep 26, 2013 at 11:43:02PM +0800, Zhang Yanfei wrote:
>>> As Yinghai pointed out in another thread, do we need to worry about
>>> falling back to top-down?
>>
>> I've explained to him. Nop, we don't need to worry about that. Because even
>> the min_pfn_mapped becomes ISA_END_ADDRESS in the second call below, we won't
>> allocate memory below the kernel because we have limited the allocation above
>> the kernel.
> 
> Maybe I misunderstood but wasn't he worrying about there not being
> enough space above kernel?  In that case, it'd automatically fall back
> to top-down allocation anyway, right?

Ah, I see. You are saying another issue. He is worrying that if we use
kexec to load the kernel high, say we have 16GB, we put the kernel in
15.99GB (just an example), so we only have less than 100MB above the kernel.

But as I've explained to him, in almost all the cases, if we want our
memory hotplug work, we don't do that. And yeah, assume we have this
problem, it'd fall back to top down and that return backs to patch 2,
we will trigger the WARN_ONCE, and the admin will know what has happened.

Thanks.
-- 
Thanks.
Zhang Yanfei

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
