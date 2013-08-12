From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Mon, 12 Aug 2013 14:12:25 -0700
Message-ID: <52094FB9.1030508@zytor.com>
References: <5208FBBC.2080304@zytor.com> <20130812152343.GK15892@htj.dyndns.org> <52090D7F.6060600@gmail.com> <20130812164650.GN15892@htj.dyndns.org> <52092811.3020105@gmail.com> <20130812202029.GB8288@mtj.dyndns.org> <3908561D78D1C84285E8C5FCA982C28F31CB74A1@ORSMSX106.amr.corp.intel.com> <20130812205456.GC8288@mtj.dyndns.org> <52094C30.7070204@zytor.com> <CAE9FiQVb2Z+9kJ_gK22KJZ_hm7yVfM910mxaj+njcWTMf4f+yw@mail.gmail.com> <20130812210852.GD8288@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130812210852.GD8288@mtj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tang Chen <imtangchen@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "trenn@suse.de" <trenn@suse.de>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "mgorman@suse.de" <mgorman@suse.de>, "minchan@kernel.org" <minc>
List-Id: linux-acpi@vger.kernel.org

On 08/12/2013 02:08 PM, Tejun Heo wrote:
> On Mon, Aug 12, 2013 at 02:06:07PM -0700, Yinghai Lu wrote:
>> "near kernel" is not very clear. when we have 64bit boot loader,
>> kernel could be anywhere. If the kernel is near the end of first
>> kernel, we could have chance to
>> have near kernel on second node.
>>
>> should use BRK for safe if the buffer is not too big. need bootloader
>> will have kernel run-time size range in same node ram.
> 
> How would that make any difference?  You're just expanding the size of
> kernel image instead of reserving it around the image.  It's exactly
> the same thing.  You're just less flexible if you do that with BRK.
> What am I missing here?
> 

The BRK is what we know is free.  Beyond that point you need
understanding of the memory map.

	-hpa

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
