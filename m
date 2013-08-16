From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 21:21:54 -0700
Message-ID: <CAE9FiQX0cxa4+2vtFpuCbH+Tb2YsMZTRRUwynbf_ogF8LN6Smg@mail.gmail.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com>
	<20130812145016.GI15892@htj.dyndns.org>
	<5208FBBC.2080304@zytor.com>
	<20130812152343.GK15892@htj.dyndns.org>
	<52090D7F.6060600@gmail.com>
	<20130812164650.GN15892@htj.dyndns.org>
	<5209CEC1.8070908@cn.fujitsu.com>
	<520A02DE.1010908@cn.fujitsu.com>
	<CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
	<520ADBBA.10501@cn.fujitsu.com>
	<1376593564.10300.446.camel@misato.fc.hp.com>
	<CAE9FiQVeMHAqZETP3d1PsPMk9-ZOXD=BD5HaTGFFO3dZenR0CA@mail.gmail.com>
	<520D89A7.7060802@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <520D89A7.7060802@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Toshi Kani <toshi.kani@hp.com>, Tejun Heo <tj@kernel.org>, Tang Chen <imtangchen@gmail.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.com>, jwein
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 15, 2013 at 7:08 PM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> On 08/16/2013 04:28 AM, Yinghai Lu wrote:
> ......
>>>
>>>
>>> So, we still need reordering, and put a new requirement that all earlier
>>> allocations must be small...
>>>
>>> I think the root of this issue is that ACPI init point is not early
>>> enough in the boot sequence.  If it were much earlier already, the whole
>>> thing would have been very simple.  We are now trying to workaround this
>>> issue in the mblock code (which itself is a fine idea), but this ACPI
>>> issue still remains and similar issues may come up again in future.
>>>
>>> For instance, ACPI SCPR/DBGP/DBG2 tables allow the OS to initialize
>>> serial console/debug ports at early boot time.  The earlier it can be
>>> initialized, the better this feature will be.  These tables are not
>>> currently used by Linux due to a licensing issue, but it could be
>>> addressed some time soon.  As platforms becoming more complex&  legacy
>>>
>>> free, the needs of ACPI tables will increase.
>>>
>>> I think moving up the ACPI init point earlier is a good direction.
>>
>>
>> Good point.
>>
>> If we put acpi_initrd_override in BRK, and can more acpi_boot_table_init()
>> much early.
...
>
> Parsing SRAT earlier is what I want to do in the very beginning indeed. And
> now, seems that moving the whole acpi table installation and overriding
> earlier
> will bring us much more benefits. I have tried this without moving up
> acpi_initrd_override in my part1 patch-set. But not in the way Yinghai
> mentioned
> above.
...
>
> By "put acpi_initrd_override in BRK", do you mean increase the BRK by
> default ?

Peter,

Do you agree on extending BRK 256k to put copied override acpi tables?

then we can find and copy them early in
arch/x86/kernel/head64.c::x86_64_start_kernel() or
arch/x86/kernel/head_32.S.

with that we can move acpi_table init as early as possible in setup_arch().

Thanks

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
