From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 08:05:38 -0700
Message-ID: <CAE9FiQUZO-j3UyhED6AOgkS8JzqUWcwsen62OdUucuNCS51ScQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130815144538.GC14606@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.co>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2013 at 7:45 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Yinghai.
>
> On Thu, Aug 15, 2013 at 07:37:59AM -0700, Yinghai Lu wrote:
>> On Thu, Aug 15, 2013 at 5:44 AM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
>>
>> > Yes, the new behavior should be controlled by boot option.
>>
>> No, should avoid boot option.
>
> It's suboptimal behavior which is chosen as trade-off to enable
> hotplug support and shouldn't be the default behavior just like node
> data and page table should be allocated on the same node by default.
> Why would we allocate kernel page table in low memory be default?

That is what my patchset want to do.
put page tables on the same node like node data.
with that, hotplug and normal case will be the same code path.

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
