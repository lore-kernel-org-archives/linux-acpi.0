From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 6/6] mem-hotplug: Introduce movablenode boot option
Date: Fri, 27 Sep 2013 08:26:33 +0200
Message-ID: <20130927062633.GB6726@gmail.com>
References: <5241D897.1090905@gmail.com>
 <5241DB62.2090300@gmail.com>
 <20130926145326.GH3482@htj.dyndns.org>
 <52446413.50504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <52446413.50504@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Zhang Yanfei <zhangyanfei.yes@gmail.com> wrote:

> OK. Trying below:
> 
> movablenode	[KNL,X86] This option enables the kernel to arrange
> 		hotpluggable memory into ZONE_MOVABLE zone. If memory
> 		in a node is all hotpluggable, the option may make
> 		the whole node has only one ZONE_MOVABLE zone, so that
> 		the whole node can be hot-removed after system is up.
> 		Note that this option may cause NUMA performance down.

That paragraph doesn't really parse in several places ...

Also, more importantly, please explain why this needs to be a boot option. 
In terms of user friendliness boot options are at the bottom of the list, 
and boot options also don't really help feature tests.

Presumably the feature is safe and has no costs, and hence could be added 
as a regular .config option, with a boot option only as an additional 
configurability option?

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
