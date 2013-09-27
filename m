From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 6/6] mem-hotplug: Introduce movablenode boot option
Date: Fri, 27 Sep 2013 13:05:49 +0200
Message-ID: <20130927110549.GA10214@gmail.com>
References: <5241D897.1090905@gmail.com>
 <5241DB62.2090300@gmail.com>
 <20130926145326.GH3482@htj.dyndns.org>
 <52446413.50504@gmail.com>
 <20130927062633.GB6726@gmail.com>
 <CANBD6kGStR-4dJRjoveNv7CtUu04gpsZZhBd=B6_=gMqrDZX6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CANBD6kGStR-4dJRjoveNv7CtUu04gpsZZhBd=B6_=gMqrDZX6w@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Yanfei Zhang <zhangyanfei.yes@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, "vasilis.liaskovitis@profitbricks.com" <vasilis.liaskovitis@profitbricks.com>, lwoodman@redhat.c
List-Id: linux-acpi@vger.kernel.org


* Yanfei Zhang <zhangyanfei.yes@gmail.com> wrote:

> > Also, more importantly, please explain why this needs to be a boot 
> > option. In terms of user friendliness boot options are at the bottom 
> > of the list, and boot options also don't really help feature tests.
> >
> > Presumably the feature is safe and has no costs, and hence could be 
> > added as a regular .config option, with a boot option only as an 
> > additional configurability option?
> 
> 
> Yeah, the kernel already has config MOVABLE_NODE, which is the config 
> enabing this feature, and we introduce this boot option to expand the 
> configurability.

So if this is purely a boot option to disable CONFIG_MOVABLE_NODE=y then 
this:

> +     movablenode             [KNL,X86] This parameter enables/disables the
> +                     kernel to arrange hotpluggable memory ranges recorded
> +                     in ACPI SRAT(System Resource Affinity Table) as
> +                     ZONE_MOVABLE. And these memory can be hot-removed when
> +                     the system is up.
> +                     By specifying this option, all the hotpluggable memory
> +                     will be in ZONE_MOVABLE, which the kernel cannot use.
> +                     This will cause NUMA performance down. For users who
> +                     care about NUMA performance, just don't use it.
> +                     If all the memory ranges in the system are hotpluggable,
> +                     then the ones used by the kernel at early time, such as
> +                     kernel code and data segments, initrd file and so on,
> +                     won't be set as ZONE_MOVABLE, and won't be hotpluggable.
> +                     Otherwise the kernel won't have enough memory to boot.
> +
>       MTD_Partition=  [MTD]

should be something like:

> +     movablenode     [KNL,X86] Boot-time switch to disable the effects of
> +                     CONFIG_MOVABLE_NODE=y. See mm/Kconfig for details.

And make sure that the description in mm/Kconfig is uptodate.

Having the same feature described twice in two different places will only 
create documentation bitrot and confusion. Also, the boot flag is only 
about disabling the feature, right?

Also, because the feature is named MOVABLE_NODE, the boot option should 
match that and be called movable_node - not movablenode.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
