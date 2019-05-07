From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v3 2/5] ACPI/PPTT: Add function to return ACPI 6.3
 Identical tokens
Date: Tue, 7 May 2019 13:26:28 -0500
Message-ID: <bab9b259-1074-5424-2cea-786e211ad608@arm.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-3-jeremy.linton@arm.com>
 <b52d15ab-de9c-8aa4-d2a4-dacdcb9d137e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b52d15ab-de9c-8aa4-d2a4-dacdcb9d137e@huawei.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, linuxarm@huawei.com, linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

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
