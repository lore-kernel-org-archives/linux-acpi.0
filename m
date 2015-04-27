From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [RESEND RFC PATCH 2/2] gfp: use the best near online node if
 the target node is offline
Date: Mon, 27 Apr 2015 18:26:32 +0800
Message-ID: <553E0ED8.8040209@cn.fujitsu.com>
References: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>	<1429869513-2906-2-git-send-email-guz.fnst@cn.fujitsu.com> <20150424130153.f7b494f1533529651b2696c6@linux-foundation.org> <553E0510.9040001@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:20148 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752622AbbD0LCd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2015 07:02:33 -0400
In-Reply-To: <553E0510.9040001@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, tj@kernel.org, mingo@redhat.com, x86@kernel.org, rjw@rjwysocki.net, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, tangchen@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

Hi Kame-san,

On 04/27/2015 05:44 PM, Kamezawa Hiroyuki wrote:

> On 2015/04/25 5:01, Andrew Morton wrote:
>> On Fri, 24 Apr 2015 17:58:33 +0800 Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>>
>>> Since the change to the cpu <--> mapping (map the cpu to the physical
>>> node for all possible at the boot), the node of cpu may be not present,
>>> so we use the best near online node if the node is not present in the low
>>> level allocation APIs.
>>>
>>> ...
>>>
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -298,9 +298,31 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order,
>>>       return __alloc_pages_nodemask(gfp_mask, order, zonelist, NULL);
>>>   }
>>>
>>> +static int find_near_online_node(int node)
>>> +{
>>> +    int n, val;
>>> +    int min_val = INT_MAX;
>>> +    int best_node = -1;
>>> +
>>> +    for_each_online_node(n) {
>>> +        val = node_distance(node, n);
>>> +
>>> +        if (val < min_val) {
>>> +            min_val = val;
>>> +            best_node = n;
>>> +        }
>>> +    }
>>> +
>>> +    return best_node;
>>> +}
>>
>> This should be `inline' if it's in a header file.
>>
>> But it is far too large to be inlined anyway - please move it to a .c file.
>>
>> And please document it.  A critical thing to describe is how we
>> determine whether a node is "near".  There are presumably multiple ways
>> in which we could decide that a node is "near" (number of hops, minimum
>> latency, ...).  Which one did you choose, and why?
>>
>>>   static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>>>                           unsigned int order)
>>>   {
>>> +    /* Offline node, use the best near online node */
>>> +    if (!node_online(nid))
>>> +        nid = find_near_online_node(nid);
>>> +
>>>       /* Unknown node is current node */
>>>       if (nid < 0)
>>>           nid = numa_node_id();
>>> @@ -311,7 +333,11 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>>>   static inline struct page *alloc_pages_exact_node(int nid, gfp_t gfp_mask,
>>>                           unsigned int order)
>>>   {
>>> -    VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
>>> +    /* Offline node, use the best near online node */
>>> +    if (!node_online(nid))
>>> +        nid = find_near_online_node(nid);
> 
> In above VM_BUG_ON(), !node_online(nid) is the bug.


But it will be possible here with the change in PATCH 1/2.

> 
>>> +
>>> +    VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>>>
>>>       return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
>>>   }
>>
>> Ouch.  These functions are called very frequently, and adding overhead
>> to them is a big deal.  And the patch even adds overhead to non-x86
>> architectures which don't benefit from it!
>>
>> Is there no way this problem can be fixed somewhere else?  Preferably
>> by fixing things up at hotplug time.
> 
> I agree. the results should be cached. If necessary, in per-cpu line.

Sounds great, will try this way.

Regards,
Gu

> 
> 
> Thanks,
> -Kame
> 
> 
> .
> 


