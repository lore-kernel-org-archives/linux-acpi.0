From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Mon, 19 Aug 2013 11:07:18 +0800
Message-ID: <52118BE6.8060903@cn.fujitsu.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com> <20130812145016.GI15892@htj.dyndns.org> <5208FBBC.2080304@zytor.com> <20130812152343.GK15892@htj.dyndns.org> <52090D7F.6060600@gmail.com> <20130812164650.GN15892@htj.dyndns.org> <5209CEC1.8070908@cn.fujitsu.com> <520A02DE.1010908@cn.fujitsu.com> <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com> <520ADBBA.10501@cn.fujitsu.com> <1376593564.10300.446.camel@misato.fc.hp.com> <CAE9FiQVeMHAqZETP3d1PsPMk9-ZOXD=BD5HaTGFFO3dZenR0CA@mail.gmail.com> <520D89A7.7060802@cn.fujitsu.com> <CAE9FiQX0cxa4+2vtFpuCbH+Tb2YsMZTRRUwynbf_ogF8LN6Smg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAE9FiQX0cxa4+2vtFpuCbH+Tb2YsMZTRRUwynbf_ogF8LN6Smg@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Toshi Kani <toshi.kani@hp.com>, Tejun Heo <tj@kernel.org>, Tang Chen <imtangchen@gmail.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, gong.chen@linux.intel.com
List-Id: linux-acpi@vger.kernel.org

On 08/16/2013 12:21 PM, Yinghai Lu wrote:
......
>> By "put acpi_initrd_override in BRK", do you mean increase the BRK by
>> default ?
>
> Peter,
>
> Do you agree on extending BRK 256k to put copied override acpi tables?
>
> then we can find and copy them early in
> arch/x86/kernel/head64.c::x86_64_start_kernel() or
> arch/x86/kernel/head_32.S.

Hi Yinghai,

If we use BRK to store acpi tables, we don't need to setup page tables.
If we do acpi_initrd_override() in setup_arch(), after early_ioremap is
available, we don't need to split it into find & copy. It would be much
easier.

Can you agree on doing acpi_initrd_override() in setup_arch() ?  Is it
too late for xen ?

Thanks.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
