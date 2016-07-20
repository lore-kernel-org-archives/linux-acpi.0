From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 5/7] x86, acpi, cpu-hotplug: Set persistent cpuid <->
 nodeid mapping when booting.
Date: Wed, 20 Jul 2016 09:25:13 +0800
Message-ID: <703372c8-82fc-7d2e-75ad-e43cb1fb8c5e@cn.fujitsu.com>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-6-git-send-email-douly.fnst@cn.fujitsu.com>
 <1699870.UOpnC170VZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1699870.UOpnC170VZ@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>, Tang Chen <tangchen@cn.fujitsu.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org



=E5=9C=A8 2016=E5=B9=B407=E6=9C=8820=E6=97=A5 04:06, Rafael J. Wysocki =E5=
=86=99=E9=81=93:
> On Tuesday, July 19, 2016 03:28:06 PM Dou Liyang wrote:
>> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
>>
>> The whole patch-set aims at making cpuid <-> nodeid mapping persistent=
. So that,
>> when node online/offline happens, cache based on cpuid <-> nodeid mapp=
ing such as
>> wq_numa_possible_cpumask will not cause any problem.
>> It contains 4 steps:
>> 1. Enable apic registeration flow to handle both enabled and disabled =
cpus.
>> 2. Introduce a new array storing all possible cpuid <-> apicid mapping=
.
>> 3. Enable _MAT and MADT relative apis to return non-presnet or disable=
d cpus' apicid.
>> 4. Establish all possible cpuid <-> nodeid mapping.
>>
>> This patch finishes step 4.
>>
>> This patch set the persistent cpuid <-> nodeid mapping for all enabled=
/disabled
>> processors at boot time via an additional acpi namespace walk for proc=
essors.
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>> Signed-off-by: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>   arch/ia64/kernel/acpi.c       |  3 +-
>>   arch/x86/kernel/acpi/boot.c   |  4 ++-
>>   drivers/acpi/acpi_processor.c |  5 ++++
>>   drivers/acpi/bus.c            |  3 ++
>>   drivers/acpi/processor_core.c | 65 +++++++++++++++++++++++++++++++++=
++++++++++
>>   include/linux/acpi.h          |  2 ++
>>   6 files changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
>> index b1698bc..bb36515 100644
>> --- a/arch/ia64/kernel/acpi.c
>> +++ b/arch/ia64/kernel/acpi.c
>> @@ -796,7 +796,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi=
)
>>    *  ACPI based hotplug CPU support
>>    */
>>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
>> -static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>> +int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>>   {
>>   #ifdef CONFIG_ACPI_NUMA
>>   	/*
>> @@ -811,6 +811,7 @@ static int acpi_map_cpu2node(acpi_handle handle, i=
nt cpu, int physid)
>>   #endif
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(acpi_map_cpu2node);
>>  =20
>>   int additional_cpus __initdata =3D -1;
>>  =20
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 37248c3..0900264f 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -695,7 +695,7 @@ static void __init acpi_set_irq_model_ioapic(void)
>>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
>>   #include <acpi/processor.h>
>>  =20
>> -static void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid=
)
>> +int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>>   {
>>   #ifdef CONFIG_ACPI_NUMA
>>   	int nid;
>> @@ -706,7 +706,9 @@ static void acpi_map_cpu2node(acpi_handle handle, =
int cpu, int physid)
>>   		numa_set_node(cpu, nid);
>>   	}
>>   #endif
>> +	return 0;
>>   }
>> +EXPORT_SYMBOL(acpi_map_cpu2node);
>>  =20
>>   int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu)
>>   {
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_process=
or.c
>> index e85b19a..0c15828 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -182,6 +182,11 @@ int __weak arch_register_cpu(int cpu)
>>  =20
>>   void __weak arch_unregister_cpu(int cpu) {}
>>  =20
>> +int __weak acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>   static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>>   {
>>   	unsigned long long sta;
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 262ca31..d8b7272 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1124,6 +1124,9 @@ static int __init acpi_init(void)
>>   	acpi_sleep_proc_init();
>>   	acpi_wakeup_device_init();
>>   	acpi_debugger_init();
>> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
>> +	acpi_set_processor_mapping();
>> +#endif
> This doesn't look nice.
>
> What about providing an empty definition of acpi_set_processor_mapping(=
)
> for CONFIG_ACPI_HOTPLUG_CPU unset?

Good,  I  will do it.

Thanks,
Dou

>
>>   	return 0;
>>   }
> Thanks,
> Rafael
>
>
>



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
