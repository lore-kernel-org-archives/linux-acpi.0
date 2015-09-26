From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v2 4/7] x86, acpi, cpu-hotplug: Enable acpi to register
 all possible cpus at boot time.
Date: Sat, 26 Sep 2015 17:44:04 +0800
Message-ID: <560668E4.8010903@cn.fujitsu.com>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com> <1441859269-25831-5-git-send-email-tangchen@cn.fujitsu.com> <1840596.ysIY9qmoPP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:19044 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751869AbbIZJpr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Sep 2015 05:45:47 -0400
In-Reply-To: <1840596.ysIY9qmoPP@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: tj@kernel.org, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, tangchen@cn.fujitsu.com

Hi Rafael,

On 09/11/2015 07:10 AM, Rafael J. Wysocki wrote:
> On Thursday, September 10, 2015 12:27:46 PM Tang Chen wrote:
>> ......
> Can you please avoid using the same (or at least very similar changelog)
> for multiple patches in the series?  That doesn't help a lot.

OK, will update the comment and include more useful info.

>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>> ---
>>   arch/x86/kernel/apic/apic.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index dcb5285..a9c9830 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -1977,7 +1977,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>>   	apic_write(APIC_LVT1, value);
>>   }
>>   
>> -int generic_processor_info(int apicid, int version)
>> +static int __generic_processor_info(int apicid, int version, bool enabled)
>>   {
>>   	int cpu, max = nr_cpu_ids;
>>   	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>> @@ -2011,7 +2011,8 @@ int generic_processor_info(int apicid, int version)
>>   			   " Processor %d/0x%x ignored.\n",
>>   			   thiscpu, apicid);
>>   
>> -		disabled_cpus++;
>> +		if (enabled)
>> +			disabled_cpus++;
> This doesn't look particularly clean to me to be honest.
>
>>   		return -ENODEV;
>>   	}
>>   
>> @@ -2028,7 +2029,8 @@ int generic_processor_info(int apicid, int version)
>>   			" reached. Keeping one slot for boot cpu."
>>   			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
>>   
>> -		disabled_cpus++;
>> +		if (enabled)
>> +			disabled_cpus++;
> Likewise and so on.
>
> Maybe call it "enabled_only"?

OK, the name makes no sense here. Will rename it.

Thanks.

>
>>   		return -ENODEV;
>>   	}
>>   
>> @@ -2039,11 +2041,14 @@ int generic_processor_info(int apicid, int version)
>>   			"ACPI: NR_CPUS/possible_cpus limit of %i reached."
>>   			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
>>   
>> -		disabled_cpus++;
>> +		if (enabled)
>> +			disabled_cpus++;
>>   		return -EINVAL;
>>   	}
>>   
>> -	num_processors++;
>> +	if (enabled)
>> +		num_processors++;
>> +
>>   	if (apicid == boot_cpu_physical_apicid) {
>>   		/*
>>   		 * x86_bios_cpu_apicid is required to have processors listed
>> @@ -2071,7 +2076,8 @@ int generic_processor_info(int apicid, int version)
>>   			apic_version[boot_cpu_physical_apicid], cpu, version);
>>   	}
>>   
>> -	physid_set(apicid, phys_cpu_present_map);
>> +	if (enabled)
>> +		physid_set(apicid, phys_cpu_present_map);
>>   	if (apicid > max_physical_apicid)
>>   		max_physical_apicid = apicid;
>>   
>> @@ -2084,11 +2090,17 @@ int generic_processor_info(int apicid, int version)
>>   		apic->x86_32_early_logical_apicid(cpu);
>>   #endif
>>   	set_cpu_possible(cpu, true);
>> -	set_cpu_present(cpu, true);
>> +	if (enabled)
>> +		set_cpu_present(cpu, true);
>>   
>>   	return cpu;
>>   }
>>   
>> +int generic_processor_info(int apicid, int version)
>> +{
>> +	return __generic_processor_info(apicid, version, true);
>> +}
>> +
>>   int hard_smp_processor_id(void)
>>   {
>>   	return read_apic_id();
>>
> Thanks,
> Rafael
>
> .
>

