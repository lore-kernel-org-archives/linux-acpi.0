From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 4/6] x86/mem-hotplug: Support initialize page tables
 in bottom-up
Date: Thu, 26 Sep 2013 12:08:42 -0400
Message-ID: <20130926160842.GC32391@mtj.dyndns.org>
References: <5241D897.1090905@gmail.com>
 <5241DA5B.8000909@gmail.com>
 <20130926144851.GF3482@htj.dyndns.org>
 <52445606.7030108@gmail.com>
 <20130926154813.GA32391@mtj.dyndns.org>
 <52445AB5.8030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52445AB5.8030306@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kva>
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 27, 2013 at 12:03:01AM +0800, Zhang Yanfei wrote:
> Ah, I see. You are saying another issue. He is worrying that if we use
> kexec to load the kernel high, say we have 16GB, we put the kernel in
> 15.99GB (just an example), so we only have less than 100MB above the kernel.
> 
> But as I've explained to him, in almost all the cases, if we want our
> memory hotplug work, we don't do that. And yeah, assume we have this
> problem, it'd fall back to top down and that return backs to patch 2,
> we will trigger the WARN_ONCE, and the admin will know what has happened.

Alright,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
