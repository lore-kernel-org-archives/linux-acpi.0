From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Tue, 13 Aug 2013 15:33:45 -0700
Message-ID: <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com>
	<20130812145016.GI15892@htj.dyndns.org>
	<5208FBBC.2080304@zytor.com>
	<20130812152343.GK15892@htj.dyndns.org>
	<52090D7F.6060600@gmail.com>
	<20130812164650.GN15892@htj.dyndns.org>
	<5209CEC1.8070908@cn.fujitsu.com>
	<520A02DE.1010908@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <520A02DE.1010908@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Tejun Heo <tj@kernel.org>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.com>, jwe
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 13, 2013 at 2:56 AM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
> 2. There are several places calling memblock_find_in_range_node() to
>    allocate memory before SRAT parsed.
>
>    early_reserve_e820_mpc_new()

this one is under 1M.

>    reserve_real_mode()

this one is under 1M

>    init_mem_mapping()

Now we top and down, so initial page tables in in BRK, other page tables
is near the top!

>    setup_log_buf()

user could specify 4M or more.

>    relocate_initrd()

size could be very big, like several hundreds mega bytes.
should be anywhere, but will be freed after booting.

===> so we should not limit it to near kernel range.

>    acpi_initrd_override()

should be 64 * 10 about 1M.

>    reserve_crashkernel()

could be under 4G, or above 4G.
size could be 512M or 8G whatever.

looks like
should move down relocated_initrd and reserve_crashkernel.

Yinghai

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
