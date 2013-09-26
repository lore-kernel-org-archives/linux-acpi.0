From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH v5 3/6] x86/mm: Factor out of top-down direct mapping
 setup
Date: Fri, 27 Sep 2013 00:56:40 +0800
Message-ID: <52446748.7090001@gmail.com>
References: <5241D897.1090905@gmail.com> <5241D9F2.80908@gmail.com> <20130926144642.GE3482@htj.dyndns.org> <5244553A.2050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5244553A.2050700@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>Linux MM <linu>
List-Id: linux-acpi@vger.kernel.org

Hello tejun,

On 09/26/2013 11:39 PM, Zhang Yanfei wrote:
> On 09/26/2013 10:46 PM, Tejun Heo wrote:
>> On Wed, Sep 25, 2013 at 02:29:06AM +0800, Zhang Yanfei wrote:
>>> +/**
>>> + * memory_map_top_down - Map [map_start, map_end) top down
>>> + * @map_start: start address of the target memory range
>>> + * @map_end: end address of the target memory range
>>> + *
>>> + * This function will setup direct mapping for memory range
>>> + * [map_start, map_end) in top-down.
>>
>> Can you please put a bit more effort into the function description?
> 
> Sorry.... I will try to make a more detailed description.

Trying below:

/**
 * memory_map_top_down - Map [map_start, map_end) top down
 * @map_start: start address of the target memory range
 * @map_end: end address of the target memory range
 *
 * This function will setup direct mapping for memory range
 * [map_start, map_end) in top-down. That said, the page tables
 * will be allocated at the end of the memory, and we map the
 * memory top-down.
 */
static void __init memory_map_top_down(unsigned long map_start,
                                       unsigned long map_end)
{

Thanks.

> 
>>
>> Other than that,
>>
>>  Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 


-- 
Thanks.
Zhang Yanfei

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
