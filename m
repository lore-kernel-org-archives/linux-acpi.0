From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH 5/6] x86, acpi, crash, kdump: Do reserve_crashkernel()
 after SRAT is parsed.
Date: Tue, 24 Sep 2013 21:24:01 +0800
Message-ID: <52419271.1090809@gmail.com>
References: <524162DA.30004@cn.fujitsu.com> <524164ED.3060201@cn.fujitsu.com> <20130924123428.GF2366@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130924123428.GF2366@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org"linux-kernel@vger.kernel.org" <l>
List-Id: linux-acpi@vger.kernel.org

On 09/24/2013 08:34 PM, Tejun Heo wrote:
> On Tue, Sep 24, 2013 at 06:09:49PM +0800, Zhang Yanfei wrote:
>> From: Tang Chen <tangchen@cn.fujitsu.com>
>>
>> Memory reserved for crashkernel could be large. So we should not allocate
>> this memory bottom up from the end of kernel image.
>>
>> When SRAT is parsed, we will be able to know whihc memory is hotpluggable,
>> and we can avoid allocating this memory for the kernel. So reorder
>> reserve_crashkernel() after SRAT is parsed.
>>
>> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>> Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Assuming this was tested to work.
> 
>  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

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
