From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v2 3/7] x86, gfp: Cache best near node for memory allocation.
Date: Mon, 28 Sep 2015 09:50:18 +0800
Message-ID: <56089CDA.3020309@cn.fujitsu.com>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com> <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com> <20150910192935.GI8114@mtj.duckdns.org> <560665DB.7020301@cn.fujitsu.com> <20150926175337.GB3572@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150926175337.GB3572@htj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

Hi, tj,

On 09/27/2015 01:53 AM, Tejun Heo wrote:
> Hello, Tang.
>
> On Sat, Sep 26, 2015 at 05:31:07PM +0800, Tang Chen wrote:
>>>> @@ -307,13 +307,19 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>>>>   	if (nid < 0)
>>>>   		nid = numa_node_id();
>>>> +	if (!node_online(nid))
>>>> +		nid = get_near_online_node(nid);
>>>> +
>>>>   	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
>>>>   }
>>> Why not just update node_data[]->node_zonelist in the first place?
>> zonelist will be rebuilt in __offline_pages() when the zone is not populated
>> any more.
>>
>> Here, getting the best near online node is for those cpus on memory-less
>> nodes.
>>
>> In the original code, if nid is NUMA_NO_NODE, the node the current cpu
>> resides in
>> will be chosen. And if the node is memory-less node, the cpu will be mapped
>> to its
>> best near online node.
>>
>> But this patch-set will map the cpu to its original node, so numa_node_id()
>> may return
>> a memory-less node to allocator. And then memory allocation may fail.
> Correct me if I'm wrong but the zonelist dictates which memory areas
> the page allocator is gonna try to from, right?  What I'm wondering is
> why we aren't handling memory-less nodes by simply updating their
> zonelists.  I mean, if, say, node 2 is memory-less, its zonelist can
> simply point to zones from other nodes, right?  What am I missing
> here?

Oh, yes, you are right. But I remember some time ago, Liu, Jiang has or was
going to handle memory less node like this in his patch:

https://lkml.org/lkml/2015/8/16/130

BTW, to Liu Jiang, how is your patches going on ?

Thanks.

>
> Thanks.
>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
