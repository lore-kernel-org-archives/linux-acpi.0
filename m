From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 16:42:35 +0800
Message-ID: <520C947B.40407@cn.fujitsu.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com> <20130812145016.GI15892@htj.dyndns.org> <5208FBBC.2080304@zytor.com> <20130812152343.GK15892@htj.dyndns.org> <52090D7F.6060600@gmail.com> <20130812164650.GN15892@htj.dyndns.org> <5209CEC1.8070908@cn.fujitsu.com> <520A02DE.1010908@cn.fujitsu.com> <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
List-Id: linux-acpi@vger.kernel.org

On 08/14/2013 06:33 AM, Yinghai Lu wrote:
......
>
>>     init_mem_mapping()
>
> Now we top and down, so initial page tables in in BRK, other page tables
> is near the top!

Hi yinghai, tj,

About the page table, the current logic is to use BRK to map the highest 
range
of memory. And then, use the mapped range to map the rest ranges, downwards.

In alloc_low_pages():
   57                 ret = memblock_find_in_range(min_pfn_mapped << 
PAGE_SHIFT,
   58                                         max_pfn_mapped << PAGE_SHIFT,
   59                                         PAGE_SIZE * num , PAGE_SIZE);
			......
   63                 pfn = ret >> PAGE_SHIFT;
			......
   78         return __va(pfn << PAGE_SHIFT);

So if we want to allocate page tables near the kernelimage, we have to do
the following:

1. Use BRK to map a range near kernel image, let's call it range X.
2. Calculate how much memory needed to map all the memory, let's say Y 
Bytes.
    Use range X to map at least Y Bytes memory near kernel image.
3. Use the mapped memory to map all the rest memory.

Does this sound OK to you guys ?

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
