From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH 1/4] ACPI/PPTT: Add function to return ACPI 6.3 Identical
 tokens
Date: Thu, 28 Mar 2019 10:20:49 -0500
Message-ID: <7b1a15e4-3d16-4c39-542b-f86a4451a592@arm.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-2-jeremy.linton@arm.com>
 <CAJZ5v0g7DOTiP=UiyqW6wf7AWyK8bi93CGsAsg_T=6HJDWrQww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g7DOTiP=UiyqW6wf7AWyK8bi93CGsAsg_T=6HJDWrQww@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

First, thanks for taking a look at this.

On 3/28/19 5:04 AM, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 11:40 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
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
>> index 065c4fc245d1..472c95ec816b 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>>          return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>                                            ACPI_PPTT_PHYSICAL_PACKAGE);
>>   }
>> +
>> +/**
>> + * find_acpi_cpu_topology_hetero_id() - Determine a unique implementation
> 
> Maybe "Get a core architecture tag"?

Sure.

> 
>> + * @cpu: Kernel logical cpu number
> 
> s/logical cpu/logical CPU/ please.

Sure.

> 
>> + *
>> + * Determine a unique heterogeneous ID for the given CPU. CPUs with the same
>> + * implementation should have matching IDs. Since this is a tree we can only
>> + * detect implementations where the heterogeneous flag is the parent to all
>> + * matching cores. AKA if a two socket machine has two different core types
>> + * in each socket this will end up being represented as four unique core types
>> + * rather than two.
> 
> I find it quite difficult to parse that comment, honestly.
> 
> AFAICS, the function returns a tag that will be the same for all cores
> with the same architecture in one package.  That is, if the package is
> heterogeneous and there are two types of cores in it, there will be
> two different tags.  Is this correct?

Yes, two ID/tags per package, but since there are two packages (in this 
example) its four different tags total. This is forced by the need to 
have a node with the PACKAGE flag set splitting up IDENTICAL cores 
within the tree. A simpler topology would hopefully be able to group all 
the identical cores in the machine together. But in the above case using 
only the PPTT tree, it may not be possible to authoritatively tell how 
many different core types are in the machine if there are more than two 
tag groupings. By itself those four tags in the above example may be 
four different core types, or only two. That is likely not a huge 
problem as a processor container, or MIDR, can be used to merge 
different tag groups together depending on the callers needs.

> 
>> + *
>> + * The returned ID can be used to group peers with identical implementation.
>> + *
>> + * The search terminates when a level is found with the identical implementation
>> + * flag set or we reach a root node.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
>> + * Otherwise returns a value which represents a group of identical cores
>> + * similar to this cpu.
>> + */
>> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +       return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>> +                                         ACPI_PPTT_ACPI_IDENTICAL);
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
>>          return -EINVAL;
>>   }
>> +static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +       return -EINVAL;
>> +}
>>   static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>>   {
>>          return -EINVAL;
>> --
>> 2.20.1
>>
