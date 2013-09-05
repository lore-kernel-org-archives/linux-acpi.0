From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 05/11] memblock: Introduce allocation order to memblock.
Date: Thu, 05 Sep 2013 17:21:22 +0800
Message-ID: <52284D12.6050604@cn.fujitsu.com>
References: <1377596268-31552-1-git-send-email-tangchen@cn.fujitsu.com> <1377596268-31552-6-git-send-email-tangchen@cn.fujitsu.com> <20130905091615.GB15294@hacker.(null)>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130905091615.GB15294@hacker.(null)>
Sender: owner-linux-mm@kvack.org
To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, tj@kernel.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Wanpeng,

On 09/05/2013 05:16 PM, Wanpeng Li wrote:
......
>>
>> +/* Allocation order. */
>
> How about replace "Allocation order" by "Allocation sequence".
>
> The "Allocation order" is ambiguity.
>

Yes, order is ambiguity. But as tj suggested, I think maybe "direction"
is better.

Thanks. :)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
