From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 16/21] x86, memblock, mem-hotplug: Free hotpluggable memory
 reserved by memblock.
Date: Thu, 25 Jul 2013 10:35:41 +0800
Message-ID: <51F08EFD.2080708@cn.fujitsu.com>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com> <1374220774-29974-17-git-send-email-tangchen@cn.fujitsu.com> <20130723210053.GU21100@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130723210053.GU21100@mtj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/24/2013 05:00 AM, Tejun Heo wrote:
> On Fri, Jul 19, 2013 at 03:59:29PM +0800, Tang Chen wrote:
>> We reserved hotpluggable memory in memblock at early time. And when memory
>> initialization is done, we have to free it to buddy system.
>>
>> This patch free memory reserved by memblock with flag MEMBLK_HOTPLUGGABLE.
>
> Sequencing patches this way means machines will run with hotpluggable
> regions reserved inbetween.  Please put the reserving and freeing into
> the same patch.

Sure, followed.

Thanks.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
