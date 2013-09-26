From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH v5 2/6] memblock: Introduce bottom-up allocation mode
Date: Thu, 26 Sep 2013 23:37:34 +0800
Message-ID: <524454BE.4030602@gmail.com>
References: <5241D897.1090905@gmail.com> <5241D9A4.4080305@gmail.com> <20130926144516.GD3482@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130926144516.GD3482@htj.dyndns.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kva>
List-Id: linux-acpi@vger.kernel.org

Hello tejun,

Thanks for your quick comments first:)

On 09/26/2013 10:45 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 25, 2013 at 02:27:48AM +0800, Zhang Yanfei wrote:
>> +#ifdef CONFIG_MOVABLE_NODE
>> +static inline void memblock_set_bottom_up(bool enable)
>> +{
>> +	memblock.bottom_up = enable;
>> +}
>> +
>> +static inline bool memblock_bottom_up(void)
>> +{
>> +	return memblock.bottom_up;
>> +}
> 
> Can you please explain what this is for here?

OK, will do.

> 
>> +		/*
>> +		 * we always limit bottom-up allocation above the kernel,
>> +		 * but top-down allocation doesn't have the limit, so
>> +		 * retrying top-down allocation may succeed when bottom-up
>> +		 * allocation failed.
>> +		 *
>> +		 * bottom-up allocation is expected to be fail very rarely,
>> +		 * so we use WARN_ONCE() here to see the stack trace if
>> +		 * fail happens.
>> +		 */
>> +		WARN_ONCE(1, "memblock: Failed to allocate memory in bottom up "
>> +			"direction. Now try top down direction.\n");
>> +	}
> 
> You and I would know what was going on and what the consequence of the
> failure may be but the above warning message is kinda useless to a
> user / admin, right?  It doesn't really say anything meaningful.
> 

Hmmmm.. May be something like this:

WARN_ONCE(1, "Failed to allocated memory above the kernel in bottom-up,"
          "so try to allocate memory below the kernel.");

Thanks

-- 
Thanks.
Zhang Yanfei
