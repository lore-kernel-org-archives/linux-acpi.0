From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 08:19:00 -0400
Message-ID: <20130815121900.GA14606@htj.dyndns.org>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130812145016.GI15892@htj.dyndns.org>
 <5208FBBC.2080304@zytor.com>
 <20130812152343.GK15892@htj.dyndns.org>
 <52090D7F.6060600@gmail.com>
 <20130812164650.GN15892@htj.dyndns.org>
 <5209CEC1.8070908@cn.fujitsu.com>
 <520A02DE.1010908@cn.fujitsu.com>
 <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
 <520C947B.40407@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <520C947B.40407@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.com>jw
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2013 at 04:42:35PM +0800, Tang Chen wrote:
> 1. Use BRK to map a range near kernel image, let's call it range X.
> 2. Calculate how much memory needed to map all the memory, let's say
> Y Bytes.
>    Use range X to map at least Y Bytes memory near kernel image.
> 3. Use the mapped memory to map all the rest memory.
> 
> Does this sound OK to you guys ?

Either than where we put the page table, the rest is the same, right?
Please note that we do want the pagetable in high address by default,
so this should be an optional behavior dependent on the hotplug boot
param.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
