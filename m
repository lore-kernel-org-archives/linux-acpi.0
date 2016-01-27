From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v3 08/12] arm64, numa: rework numa_add_memblk()
Date: Wed, 27 Jan 2016 14:20:11 +0800
Message-ID: <56A8619B.9010602@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-9-git-send-email-guohanjun@huawei.com>
 <20160125093429.GD24726@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27423 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcA0GYg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2016 01:24:36 -0500
In-Reply-To: <20160125093429.GD24726@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Shannon Zhao <shannon.zhao@linaro.org>, Steve Capper <steve.capper@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>

On 2016/1/25 17:34, Robert Richter wrote:
> On 23.01.16 17:39:23, Hanjun Guo wrote:
>> Rework numa_add_memblk() to update the parameter "u64 size"
>> to "u64 end", this will make it consistent with x86 and
>> can simplify the code later.
>> --- a/arch/arm64/kernel/of_numa.c
>> +++ b/arch/arm64/kernel/of_numa.c
>> @@ -168,7 +168,7 @@ static int __init early_init_parse_memory_node(unsigned long node)
>>  		pr_debug("NUMA-DT:  base = %llx , node = %u\n",
>>  				base, nid);
>>  
>> -		if (numa_add_memblk(nid, base, size) < 0)
>> +		if (numa_add_memblk(nid, base, base + size) < 0)
> The overall function usage looks more like as it should use size
> instead of end. Even in the x86 implementation end is calculated from
> base + size. So better change x86 code to use size instead.
>
> Though this might involve to change the interface for
> numa_add_memblk_to() for unifcation too.
>

This should be a minor one, I'm fine with both directions, I will
stay for a few days to get more review comments, if no objections,
I will update.

Thanks
Hanjun

