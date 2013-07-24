From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 11/21] x86: get pg_data_t's memory from other node
Date: Wed, 24 Jul 2013 11:52:53 +0800
Message-ID: <51EF4F95.1050308@cn.fujitsu.com>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com> <1374220774-29974-12-git-send-email-tangchen@cn.fujitsu.com> <20130723200924.GP21100@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:63617 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab3GXDuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jul 2013 23:50:11 -0400
In-Reply-To: <20130723200924.GP21100@mtj.dyndns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org

On 07/24/2013 04:09 AM, Tejun Heo wrote:
> On Fri, Jul 19, 2013 at 03:59:24PM +0800, Tang Chen wrote:
>> From: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
>>
>> If system can create movable node which all memory of the
>> node is allocated as ZONE_MOVABLE, setup_node_data() cannot
>> allocate memory for the node's pg_data_t.
>> So, use memblock_alloc_try_nid() instead of memblock_alloc_nid()
>> to retry when the first allocation fails. Otherwise, the system
>> could failed to boot.
......
>> -	nd_pa = memblock_alloc_nid(nd_size, SMP_CACHE_BYTES, nid);
>> +	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
>>   	if (!nd_pa) {
>> -		pr_err("Cannot find %zu bytes in node %d\n",
>> -		       nd_size, nid);
>> +		pr_err("Cannot find %zu bytes in any node\n", nd_size);
>
> Hmm... we want the node data to be colocated on the same node and I
> don't think being hotpluggable necessarily requires the node data to
> be allocated on a different node.  Does node data of a hotpluggable
> node need to stay around after hotunplug?
>
> I don't think it's a huge issue but it'd be great if we can clarify
> where the restriction is coming from.
>

You are right, the node data could be on hotpluggable node. And Yinghai
also said pagetable and vmemmap could be on hotpluggable node.

But for now, doing so will break memory hot-remove path. I should have
mentioned so in the log, which I didn't do.

A node could have several memory devices. And the device who holds node
data should be hot-removed in the last place. But in NUAM level, we don't
know which memory_block (/sys/devices/system/node/nodeX/memoryXXX) belongs
to which memory device. We only have node. So we can only do node hotplug.

Also as Yinghai's previous patch-set did, he put pagetable on local node.
And we met the same problem. when hot-removing memory, we have to ensure
the memory device containing pagetable being hot-removed in the last place.

But in virtualization, developers are now developing memory hotplug in qemu,
which support a single memory device hotplug. So a whole node hotplug will
not satisfy virtualization users.

At last, we concluded that we'd better do memory hotplug and local node
things (local node node data, pagetable, vmemmap, ...) in two steps.
Please refer to https://lkml.org/lkml/2013/6/19/73

The node data should be on local, I agree with that. I'm not saying I
won't do it. Just for now, it will be complicated to fix memory hot-remove
path. So I think pushing this patch for now, and do the local node things
in the next step.

Thanks.



