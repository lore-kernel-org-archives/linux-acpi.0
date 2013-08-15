From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 13:49:52 -0600
Message-ID: <1376596192.10300.449.camel@misato.fc.hp.com>
References: <20130812164650.GN15892@htj.dyndns.org>
	 <5209CEC1.8070908@cn.fujitsu.com> <520A02DE.1010908@cn.fujitsu.com>
	 <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
	 <520C947B.40407@cn.fujitsu.com> <20130815121900.GA14606@htj.dyndns.org>
	 <520CCD41.5000508@cn.fujitsu.com>
	 <CAE9FiQVArNd-voKZ1tYbwzJiN=ztXCgr-0sHwej3er02kHQvRQ@mail.gmail.com>
	 <20130815144538.GC14606@htj.dyndns.org>
	 <CAE9FiQUZO-j3UyhED6AOgkS8JzqUWcwsen62OdUucuNCS51ScQ@mail.gmail.com>
	 <20130815151024.GD14606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130815151024.GD14606@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Tang Chen <tangchen@cn.fujitsu.com>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.
 Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2013-08-15 at 11:10 -0400, Tejun Heo wrote:
> On Thu, Aug 15, 2013 at 08:05:38AM -0700, Yinghai Lu wrote:
> > > It's suboptimal behavior which is chosen as trade-off to enable
> > > hotplug support and shouldn't be the default behavior just like node
> > > data and page table should be allocated on the same node by default.
> > > Why would we allocate kernel page table in low memory be default?
> > 
> > That is what my patchset want to do.
> > put page tables on the same node like node data.
> > with that, hotplug and normal case will be the same code path.
> 
> Yeah, sure, when that works, that can be the default and only
> behavior.  Right now, we do want a switch to control that, right?  I'm
> not sure we have a good choice which we can choose as the only
> behavior for kernel page table.  Maybe we can implement some
> heuristics to decide whether there's enough lowmem but given how niche
> memory hotplug is, at least for now, that feels like an overkill.

I think the key point here is that putting page tables in local nodes
also requires reading ACPI SRAT table earlier.  There seems to be not
much point of avoiding this change.

Thanks,
-Toshi

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
