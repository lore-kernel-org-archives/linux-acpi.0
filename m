Return-Path: <SRS0=qBNj=TH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BAC004C9
	for <linux-acpi@archiver.kernel.org>; Tue,  7 May 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088D205C9
	for <linux-acpi@archiver.kernel.org>; Tue,  7 May 2019 18:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEGS0h (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 7 May 2019 14:26:37 -0400
Received: from foss.arm.com ([217.140.101.70]:33598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfEGS0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 May 2019 14:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E214915AB;
        Tue,  7 May 2019 11:26:36 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5A013F5AF;
        Tue,  7 May 2019 11:26:35 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] ACPI/PPTT: Add function to return ACPI 6.3
 Identical tokens
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        will.deacon@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, lenb@kernel.org
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-3-jeremy.linton@arm.com>
 <b52d15ab-de9c-8aa4-d2a4-dacdcb9d137e@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <bab9b259-1074-5424-2cea-786e211ad608@arm.com>
Date:   Tue, 7 May 2019 13:26:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b52d15ab-de9c-8aa4-d2a4-dacdcb9d137e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190507182628.xTIK-jGj4VA-CWC5qwgafJ_mVicdLdpG3mmZIZm62cc@z>

Hi,

On 5/5/19 2:09 AM, Kefeng Wang wrote:
> 
> On 2019/5/4 7:24, Jeremy Linton wrote:
>> ACPI 6.3 adds a flag to indicate that child nodes are all
>> identical cores. This is useful to authoritatively determine
>> if a set of (possibly offline) cores are identical or not.
>>
>> Since the flag doesn't give us a unique id we can generate
>> one and use it to create bitmaps of sibling nodes, or simply
>> in a loop to determine if a subset of cores are identical.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
>>   include/linux/acpi.h |  5 +++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 83a026765faa..1865515297ca 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>>   	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>   					  ACPI_PPTT_PHYSICAL_PACKAGE);
>>   }
>> +
>> +/**
>> + * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
>> + * @cpu: Kernel logical CPU number
>> + *
>> + * Determine a unique heterogeneous tag for the given CPU. CPUs with the same
>> + * implementation should have matching tags.
>> + *
>> + * The returned tag can be used to group peers with identical implementation.
>> + *
>> + * The search terminates when a level is found with the identical implementation
>> + * flag set or we reach a root node.
>> + *
>> + * Due to limitations in the PPTT data structure, there may be rare situations
>> + * where two cores in a heterogeneous machine may be identical, but won't have
>> + * the same tag.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
>> + * Otherwise returns a value which represents a group of identical cores
>> + * similar to this CPU.
>> + */
>> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>> +					  ACPI_PPTT_ACPI_IDENTICAL);
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index d5dcebd7aad3..1444fb042898 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1309,6 +1309,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
>>   #ifdef CONFIG_ACPI_PPTT
>>   int find_acpi_cpu_topology(unsigned int cpu, int level);
>>   int find_acpi_cpu_topology_package(unsigned int cpu);
>> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>>   int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>>   #else
>>   static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
>> @@ -1319,6 +1320,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
>>   {
>>   	return -EINVAL;
>>   }
> static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)

Yes, good catch, I just saw that warning.


>> +static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +	return -EINVAL;
>> +}
>>   static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>>   {
>>   	return -EINVAL;
> 

