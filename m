From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 12:34:31 -0700
Message-ID: <CAE9FiQVAsHLRCcrtFLqgifAJ6jfbDK7y_OFGUDArSWPKk+2qnQ@mail.gmail.com>
References: <20130812152343.GK15892@htj.dyndns.org>
	<52090D7F.6060600@gmail.com>
	<20130812164650.GN15892@htj.dyndns.org>
	<5209CEC1.8070908@cn.fujitsu.com>
	<520A02DE.1010908@cn.fujitsu.com>
	<CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
	<520C947B.40407@cn.fujitsu.com>
	<20130815121900.GA14606@htj.dyndns.org>
	<520CCD41.5000508@cn.fujitsu.com>
	<CAE9FiQVArNd-voKZ1tYbwzJiN=ztXCgr-0sHwej3er02kHQvRQ@mail.gmail.com>
	<20130815144538.GC14606@htj.dyndns.org>
	<CAE9FiQUZO-j3UyhED6AOgkS8JzqUWcwsen62OdUucuNCS51ScQ@mail.gmail.com>
	<3908561D78D1C84285E8C5FCA982C28F31CBD145@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CBD145@ORSMSX106.amr.corp.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Tejun Heo <tj@kernel.org>, Tang Chen <tangchen@cn.fujitsu.com>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@red>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2013 at 12:08 PM, Luck, Tony <tony.luck@intel.com> wrote:
>> That is what my patchset want to do.
>> put page tables on the same node like node data.
>> with that, hotplug and normal case will be the same code path.
>
> Page tables are a big issue if we have 4K mappings (8 byte entry per
> 4K page means 2MB of page tables per GB of memory) ... but only
> used for DEBUG cases, right?

yes.

>
> If we use 2M mappings, then allocations are 512x smaller - so only
> 4K per GB - hard to justify spreading that across nodes.
>
> If we can use 1GB mappings - then another 512x reduction to 8 bytes per GB (or 8KB per TB)

Yes. 4k for 512G.

Just make all cases use same code path even for DEBUG_PAGEALLOC with 4k page
mapping.

>
> Aren't page structures a bigger issue?  ~64 bytes per 4K page.  Do we
> make sure these get allocated from the NUMA node that they describe?
> This should not hurt the ZONE_MOVEABLE-ness of this - although they are
> kernel structures they can be freed when the node is removed (at that point
> they describe memory that is no longer present). From a scalability perspective
> we don't want to run node0 low on memory by using it for every other node.
> From a NUMA perspective we want the page_t that describes a page to be
> in the same locality as the page itself.

yes, that is vmemmap, and it is already numa aware.

Thanks

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
