From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 15/21] x86, acpi, numa: Don't reserve memory on nodes
 the kernel resides in.
Date: Thu, 25 Jul 2013 10:34:56 +0800
Message-ID: <51F08ED0.9080407@cn.fujitsu.com>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com> <1374220774-29974-16-git-send-email-tangchen@cn.fujitsu.com> <20130723205919.GT21100@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130723205919.GT21100@mtj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/24/2013 04:59 AM, Tejun Heo wrote:
......
>> +static bool __init kernel_resides_in_range(phys_addr_t base, u64 length)
>> +{
>> +	int i;
>> +	struct memblock_type *reserved =&memblock.reserved;
>> +	struct memblock_region *region;
>> +	phys_addr_t start, end;
>> +
>> +	for (i = 0; i<  reserved->cnt; i++) {
>> +		region =&reserved->regions[i];
>> +
>> +		if (region->flags != MEMBLK_FLAGS_DEFAULT)
>> +			continue;
>> +
>> +		start = region->base;
>> +		end = region->base + region->size;
>> +		if (end<= base || start>= base + length)
>> +			continue;
>> +
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>
> This being in acpi/osl.c is rather weird.  Overall, the acpi and
> memblock parts don't seem very well split.  It'd best if acpi just
> indicates which regions are hotpluggable and the rest is handled by
> x86 boot or memblock code as appropriate.

OK. Will move this function out from acpi side.

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
