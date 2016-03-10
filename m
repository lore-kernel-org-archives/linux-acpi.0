From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 08/12] arm64, numa: rework numa_add_memblk()
Date: Thu, 10 Mar 2016 18:10:10 +0800
Message-ID: <56E14802.8040500@linaro.org>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com> <1453541967-3744-9-git-send-email-guohanjun@huawei.com> <20160309122744.GD1535@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34736 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965628AbcCJKK0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 05:10:26 -0500
Received: by mail-pf0-f176.google.com with SMTP id 129so65417999pfw.1
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2016 02:10:25 -0800 (PST)
In-Reply-To: <20160309122744.GD1535@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Hi Robert,

On 03/09/2016 08:27 PM, Robert Richter wrote:
> On 23.01.16 17:39:23, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> Rework numa_add_memblk() to update the parameter "u64 size"
>> to "u64 end", this will make it consistent with x86 and
>> can simplify the code later.
>>
>> Updates for arch/arm64/mm/numa.c should squash to core NUMA
>> patches from Ganapat.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/arm64/kernel/acpi_numa.c |  2 +-
>>   arch/arm64/kernel/of_numa.c   |  2 +-
>>   arch/arm64/mm/numa.c          | 12 ++++++------
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>
>> diff --git a/arch/arm64/kernel/of_numa.c b/arch/arm64/kernel/of_numa.c
>> index 2f9e34b..aa6f3a3 100644
>> --- a/arch/arm64/kernel/of_numa.c
>> +++ b/arch/arm64/kernel/of_numa.c
>> @@ -168,7 +168,7 @@ static int __init early_init_parse_memory_node(unsigned long node)
>>   		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
>>   				base, nid);
>>
>> -		if (numa_add_memblk(nid, base, size) < 0)
>> +		if (numa_add_memblk(nid, base, base + size) < 0)
>>   			return -EINVAL;
>>   	}
>>
>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>> index e974995..2b04b8a 100644
>> --- a/arch/arm64/mm/numa.c
>> +++ b/arch/arm64/mm/numa.c
>> @@ -137,25 +137,25 @@ void numa_store_cpu_info(unsigned int cpu)
>>    * numa_add_memblk - Set node id to memblk
>>    * @nid: NUMA node ID of the new memblk
>>    * @start: Start address of the new memblk
>> - * @size:  Size of the new memblk
>> + * @end:  End address of the new memblk
>
> Apart from my earlier comment, this is not exactly correct and may
> cause confussion. The implementation here defines:
>
>   size == end - start
>
> which is different to struct resource, where:
>
>   resource_size(res) == res->end - res->start + 1
>
> Thus, @end here is the first address outside of memblk.
>
> This is one more argument for keeping @size here.

I agree :)

I'm working on the new version and met the problem of no
definition for numa_add_memblk() and numa_set_distance()
on IA64, numa_set_distance() seems to easy to add one for
IA64, but numa_add_memblk() is not, this will the blocker
for moving functions to common place, what's your opinion
here?

Also I'm thinking to move all the code in arch/arm64/kernel/acpi_numa.c
to the arch/arm64/kernel/acpi.c to make the ACPI code in ARM64
self-contained, what do you think?

Thanks
Hanjun
