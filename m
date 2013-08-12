From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Mon, 12 Aug 2013 14:06:07 -0700
Message-ID: <CAE9FiQVb2Z+9kJ_gK22KJZ_hm7yVfM910mxaj+njcWTMf4f+yw@mail.gmail.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com>
	<20130812145016.GI15892@htj.dyndns.org>
	<5208FBBC.2080304@zytor.com>
	<20130812152343.GK15892@htj.dyndns.org>
	<52090D7F.6060600@gmail.com>
	<20130812164650.GN15892@htj.dyndns.org>
	<52092811.3020105@gmail.com>
	<20130812202029.GB8288@mtj.dyndns.org>
	<3908561D78D1C84285E8C5FCA982C28F31CB74A1@ORSMSX106.amr.corp.intel.com>
	<20130812205456.GC8288@mtj.dyndns.org>
	<52094C30.7070204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <52094C30.7070204@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tejun Heo <tj@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tang Chen <imtangchen@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "trenn@suse.de" <trenn@suse.de>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "mgorman@suse.de" <mgorman@suse.de>, "minchan@kernel.org" <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.int>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2013 at 1:57 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 08/12/2013 01:54 PM, Tejun Heo wrote:
>> Hello, Tony.
>>
>> On Mon, Aug 12, 2013 at 08:49:42PM +0000, Luck, Tony wrote:
>>> The only fly I see in the ointment here is the crazy fragmentation of physical
>>> memory below 4G on X86 systems.  Typically it will all be on the same node.
>>> But I don't know if there is any specification that requires it be that way. If some
>>> "helpful" OEM decided to make some "lowmem" (below 4G) be available on
>>> every node, they might in theory do something truly awesomely strange.  But
>>> even here - the granularity of such mappings tends to be large enough that
>>> the "allocate near where the kernel was loaded" should still work to make those
>>> allocations be on the same node for the "few megabytes" level of allocations.
>>
>> Yeah, "near kernel" allocations are needed only till SRAT information
>> is parsed and fed into memblock.  From then on, it'll be the usual
>> node-affine top-down allocations, so the memory amount of interest
>> here is inherently tiny; otherwise, we're doing something silly in our
>> boot sequence.

"near kernel" is not very clear. when we have 64bit boot loader,
kernel could be anywhere. If the kernel is near the end of first
kernel, we could have chance to
have near kernel on second node.

should use BRK for safe if the buffer is not too big. need bootloader
will have kernel run-time size range in same node ram.

>>
>
> Again, how much memory are we talking about here?

page tables, buffer for slit table, buffer for double
memblock.reserved, override acpi tables.

looks like it is needing several mega bytes, esp someone using 4k page
mapping for debug purpose.

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
