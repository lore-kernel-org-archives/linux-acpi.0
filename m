From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RESEND RFC PATCH 1/2] x86/cpu hotplug: make apicid <--> cpuid
 mapping persistent
Date: Sat, 25 Apr 2015 18:14:52 +0800
Message-ID: <553B691C.2030808@huawei.com>
References: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com> <9864973.ZP6z8adBRm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:45883 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbbDYKPL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Apr 2015 06:15:11 -0400
In-Reply-To: <9864973.ZP6z8adBRm@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, mingo@redhat.com, x86@kernel.org, akpm@linux-foundation.org, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

On 2015/4/24 22:45, Rafael J. Wysocki wrote:
> On Friday, April 24, 2015 05:58:32 PM Gu Zheng wrote:
>> Yasuaki Ishimatsu found that with node online/offline, cpu<->node relationship
>> is  established. Because workqueue uses a info which  was established at boot
>> time, but it may be changed by node hotpluging.
>>
>> Once pool->node points to a stale node, following allocation failure
>> happens.
>>   ==
>>      SLUB: Unable to allocate memory on node 2 (gfp=0x80d0)
>>       cache: kmalloc-192, object size: 192, buffer size: 192, default
>> order:
>>     1, min order: 0
>>       node 0: slabs: 6172, objs: 259224, free: 245741
>>       node 1: slabs: 3261, objs: 136962, free: 127656
>>   ==
>>
>> As the apicid <---> pxm and pxm <--> node relationship are persistent, then
>> the apicid <--> node mapping is persistent, so the root cause is the
>> cpu-id <-> lapicid mapping is not persistent (because the currently implementation
>> always choose the first free cpu id for the new added cpu). If we can build
>> persistent cpu-id <-> lapicid relationship, this problem will be fixed.
>>
>> This patch tries to build the whole world mapping cpuid <-> apicid <-> pxm <-> node
>> for all possible processor at the boot, the detail implementation are 2 steps:
>> Step1: generate a logic cpu id for all the local apic (both enabled and dsiabled)
>>        when register local apic
>> Step2: map the cpu to the phyical node via an additional acpi ns walk for processor.
>>
>> Please refer to:
>> https://lkml.org/lkml/2015/2/27/145
>> https://lkml.org/lkml/2015/3/25/989
>> for the previous discussion.
>>
>> Reported-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> This one will conflict with the ARM64 ACPI material when that goes in, so it'll
> need to be rebased on top of that.

Yes, please. Then I will take a look too.

Thanks
Hanjun

