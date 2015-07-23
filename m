From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 0/5] Make cpuid <-> nodeid mapping persistent.
Date: Thu, 23 Jul 2015 12:44:53 +0800
Message-ID: <55B07145.5010404@cn.fujitsu.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com> <20150715221345.GO15934@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:44441 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbbGWEn4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2015 00:43:56 -0400
In-Reply-To: <20150715221345.GO15934@mtj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org


On 07/16/2015 06:13 AM, Tejun Heo wrote:
> Hello,
>
> On Tue, Jul 07, 2015 at 05:30:20PM +0800, Tang Chen wrote:
>> [Solution]
>>
>> To fix this problem, we establish cpuid <-> nodeid mapping for all the possible
>> cpus at boot time, and make it invariable. And according to init_cpu_to_node(),
>> cpuid <-> nodeid mapping is based on apicid <-> nodeid mapping and cpuid <-> apicid
>> mapping. So the key point is obtaining all cpus' apicid.
>>
>> apicid can be obtained by _MAT (Multiple APIC Table Entry) method or found in
>> MADT (Multiple APIC Description Table). So we finish the job in the following steps:
>>
>> 1. Enable apic registeration flow to handle both enabled and disabled cpus.
>>     This is done by introducing an extra parameter to generic_processor_info to let the
>>     caller control if disabled cpus are ignored.
>>
>> 2. Introduce a new array storing all possible cpuid <-> apicid mapping. And also modify
>>     the way cpuid is calculated. Establish all possible cpuid <-> apicid mapping when
>>     registering local apic. Store the mapping in the array introduced above.
>>
>> 4. Enable _MAT and MADT relative apis to return non-presnet or disabled cpus' apicid.
>>     This is also done by introducing an extra parameter to these apis to let the caller
>>     control if disabled cpus are ignored.
>>
>> 5. Establish all possible cpuid <-> nodeid mapping.
>>     This is done via an additional acpi namespace walk for processors.
> Hmmm... given that we probably want to allocate lower ids to the
> online cpus, as otherwise we can end up failing to bring existing cpus
> online because NR_CPUS is lower than the number of possible cpus, I
> wonder whether doing this lazily could be better / easier.  e.g. just
> remember the mapping as cpus come online.  When a new cpu comes up,
> look up whether it came up before.  If so, use the ids from the last
> time.  If not, allocate new ones.  I think that would be less amount
> of change but does require updating the mapping dynamically.

Hi TJ,

Allocating cpuid when a new cpu comes up and reusing the cpuid when it
comes up again is possible. But I'm not quite sure if it will be less 
modification
because we still need an array or bit map or something to keep the mapping,
and select backup nodes for cpus on memory-less nodes when allocating 
memory.

I can post a set of patches for this idea. And then we can see which one 
is better.

Thanks. :)

