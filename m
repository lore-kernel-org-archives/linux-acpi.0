From: Tang Chen <imtangchen@gmail.com>
Subject: Re: [PATCH part2 1/4] acpi: Print Hot-Pluggable Field in SRAT.
Date: Mon, 12 Aug 2013 22:25:07 +0800
Message-ID: <5208F043.7020409@gmail.com>
References: <1375938239-18769-1-git-send-email-tangchen@cn.fujitsu.com> <1375938239-18769-2-git-send-email-tangchen@cn.fujitsu.com> <20130812141551.GD15892@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130812141551.GD15892@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, robert.moore@intel.com, lv.zheng@intel.com, rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org, imtangchen@gmail.com
List-Id: linux-acpi@vger.kernel.org

On 08/12/2013 10:15 PM, Tejun Heo wrote:
> On Thu, Aug 08, 2013 at 01:03:56PM +0800, Tang Chen wrote:
>> +	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s\n",
>> +		node, pxm,
>> +		(unsigned long long) start, (unsigned long long) end - 1,
>> +		hotpluggable ? " Hot Pluggable" : "");
>
> Wouldn't it be better to just print "hotplug"?

Sure, followed.

Thanks.



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
