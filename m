From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND RFC PATCH 1/2] x86/cpu hotplug: make apicid <--> cpuid mapping persistent
Date: Fri, 24 Apr 2015 16:45:01 +0200
Message-ID: <9864973.ZP6z8adBRm@vostro.rjw.lan>
References: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58700 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755128AbbDXOUR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 10:20:17 -0400
In-Reply-To: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, mingo@redhat.com, x86@kernel.org, akpm@linux-foundation.org, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

On Friday, April 24, 2015 05:58:32 PM Gu Zheng wrote:
> Yasuaki Ishimatsu found that with node online/offline, cpu<->node relationship
> is  established. Because workqueue uses a info which  was established at boot
> time, but it may be changed by node hotpluging.
> 
> Once pool->node points to a stale node, following allocation failure
> happens.
>   ==
>      SLUB: Unable to allocate memory on node 2 (gfp=0x80d0)
>       cache: kmalloc-192, object size: 192, buffer size: 192, default
> order:
>     1, min order: 0
>       node 0: slabs: 6172, objs: 259224, free: 245741
>       node 1: slabs: 3261, objs: 136962, free: 127656
>   ==
> 
> As the apicid <---> pxm and pxm <--> node relationship are persistent, then
> the apicid <--> node mapping is persistent, so the root cause is the
> cpu-id <-> lapicid mapping is not persistent (because the currently implementation
> always choose the first free cpu id for the new added cpu). If we can build
> persistent cpu-id <-> lapicid relationship, this problem will be fixed.
> 
> This patch tries to build the whole world mapping cpuid <-> apicid <-> pxm <-> node
> for all possible processor at the boot, the detail implementation are 2 steps:
> Step1: generate a logic cpu id for all the local apic (both enabled and dsiabled)
>        when register local apic
> Step2: map the cpu to the phyical node via an additional acpi ns walk for processor.
> 
> Please refer to:
> https://lkml.org/lkml/2015/2/27/145
> https://lkml.org/lkml/2015/3/25/989
> for the previous discussion.
> 
> Reported-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

This one will conflict with the ARM64 ACPI material when that goes in, so it'll
need to be rebased on top of that.

> ---
>  arch/ia64/kernel/acpi.c       |    2 +-
>  arch/x86/include/asm/mpspec.h |    1 +
>  arch/x86/kernel/acpi/boot.c   |    8 +--
>  arch/x86/kernel/apic/apic.c   |   71 +++++++++++++++++++++++----
>  arch/x86/mm/numa.c            |   20 --------
>  drivers/acpi/acpi_processor.c |    2 +-
>  drivers/acpi/bus.c            |    3 +
>  drivers/acpi/processor_core.c |  108 ++++++++++++++++++++++++++++++++++------
>  include/linux/acpi.h          |    2 +
>  9 files changed, 162 insertions(+), 55 deletions(-)
> 
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 2c44989..e7958f8 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -796,7 +796,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
>   *  ACPI based hotplug CPU support
>   */
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
> +int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>  {
>  #ifdef CONFIG_ACPI_NUMA
>  	/*
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
> index b07233b..db902d8 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -86,6 +86,7 @@ static inline void early_reserve_e820_mpc_new(void) { }
>  #endif
>  
>  int generic_processor_info(int apicid, int version);
> +int __generic_processor_info(int apicid, int version, bool enabled);
>  
>  #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
>  
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 803b684..b084cc0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -174,15 +174,13 @@ static int acpi_register_lapic(int id, u8 enabled)
>  		return -EINVAL;
>  	}
>  
> -	if (!enabled) {
> +	if (!enabled)
>  		++disabled_cpus;
> -		return -EINVAL;
> -	}
>  
>  	if (boot_cpu_physical_apicid != -1U)
>  		ver = apic_version[boot_cpu_physical_apicid];
>  
> -	return generic_processor_info(id, ver);
> +	return __generic_processor_info(id, ver, enabled);
>  }
>  
>  static int __init
> @@ -726,7 +724,7 @@ static void __init acpi_set_irq_model_ioapic(void)
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  #include <acpi/processor.h>
>  
> -static void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
> +void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
>  {
>  #ifdef CONFIG_ACPI_NUMA
>  	int nid;
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index dcb5285..7fbf2cb 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1977,7 +1977,38 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>  	apic_write(APIC_LVT1, value);
>  }
>  
> -int generic_processor_info(int apicid, int version)
> +/*
> + * Logic cpu number(cpuid) to local APIC id persistent mappings.
> + * Do not clear the mapping even if cpu hot removed.
> + * */
> +static int apicid_to_cpuid[] = {
> +	[0 ... NR_CPUS - 1] = -1,
> +};
> +
> +/*
> + * Internal cpu id bits, set the bit once cpu present, and never clear it.
> + * */
> +static cpumask_t cpuid_mask = CPU_MASK_NONE;
> +
> +static int get_cpuid(int apicid)
> +{
> +	int free_id, i;
> +
> +	free_id = cpumask_next_zero(-1, &cpuid_mask);
> +	if (free_id >= nr_cpu_ids)
> +		return -1;
> +
> +	for (i = 0; i < free_id; i++)
> +		if (apicid_to_cpuid[i] == apicid)
> +			return i;
> +
> +	apicid_to_cpuid[free_id] = apicid;
> +	cpumask_set_cpu(free_id, &cpuid_mask);
> +
> +	return free_id;
> +}
> +
> +int __generic_processor_info(int apicid, int version, bool enabled)
>  {
>  	int cpu, max = nr_cpu_ids;
>  	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
> @@ -2010,8 +2041,8 @@ int generic_processor_info(int apicid, int version)
>  		pr_warning("APIC: Disabling requested cpu."
>  			   " Processor %d/0x%x ignored.\n",
>  			   thiscpu, apicid);
> -
> -		disabled_cpus++;
> +		if (enabled)
> +			disabled_cpus++;
>  		return -ENODEV;
>  	}
>  
> @@ -2027,8 +2058,8 @@ int generic_processor_info(int apicid, int version)
>  			"ACPI: NR_CPUS/possible_cpus limit of %i almost"
>  			" reached. Keeping one slot for boot cpu."
>  			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
> -
> -		disabled_cpus++;
> +		if (enabled)
> +			disabled_cpus++;
>  		return -ENODEV;
>  	}
>  
> @@ -2039,11 +2070,11 @@ int generic_processor_info(int apicid, int version)
>  			"ACPI: NR_CPUS/possible_cpus limit of %i reached."
>  			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
>  
> -		disabled_cpus++;
> +		if (enabled)
> +			disabled_cpus++;
>  		return -EINVAL;
>  	}
>  
> -	num_processors++;
>  	if (apicid == boot_cpu_physical_apicid) {
>  		/*
>  		 * x86_bios_cpu_apicid is required to have processors listed
> @@ -2053,9 +2084,20 @@ int generic_processor_info(int apicid, int version)
>  		 * for BSP.
>  		 */
>  		cpu = 0;
> -	} else
> -		cpu = cpumask_next_zero(-1, cpu_present_mask);
> +	} else {
> +		cpu = get_cpuid(apicid);
> +		if (cpu < 0) {
> +			int thiscpu = max + disabled_cpus;
>  
> +			pr_warning("  Processor %d/0x%x ignored.\n",
> +				thiscpu, apicid);
> +			if (enabled)
> +				disabled_cpus++;
> +			return -EINVAL;
> +		}
> +	}
> +	if (enabled)
> +		num_processors++;
>  	/*
>  	 * Validate version
>  	 */
> @@ -2071,7 +2113,8 @@ int generic_processor_info(int apicid, int version)
>  			apic_version[boot_cpu_physical_apicid], cpu, version);
>  	}
>  
> -	physid_set(apicid, phys_cpu_present_map);
> +	if (enabled)
> +		physid_set(apicid, phys_cpu_present_map);
>  	if (apicid > max_physical_apicid)
>  		max_physical_apicid = apicid;
>  
> @@ -2084,11 +2127,17 @@ int generic_processor_info(int apicid, int version)
>  		apic->x86_32_early_logical_apicid(cpu);
>  #endif
>  	set_cpu_possible(cpu, true);
> -	set_cpu_present(cpu, true);
> +	if (enabled)
> +		set_cpu_present(cpu, true);
>  
>  	return cpu;
>  }
>  
> +int generic_processor_info(int apicid, int version)
> +{
> +	return __generic_processor_info(apicid, version, true);
> +}
> +
>  int hard_smp_processor_id(void)
>  {
>  	return read_apic_id();
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 4053bb5..a733cf9 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -702,24 +702,6 @@ void __init x86_numa_init(void)
>  	numa_init(dummy_numa_init);
>  }
>  
> -static __init int find_near_online_node(int node)
> -{
> -	int n, val;
> -	int min_val = INT_MAX;
> -	int best_node = -1;
> -
> -	for_each_online_node(n) {
> -		val = node_distance(node, n);
> -
> -		if (val < min_val) {
> -			min_val = val;
> -			best_node = n;
> -		}
> -	}
> -
> -	return best_node;
> -}
> -
>  /*
>   * Setup early cpu_to_node.
>   *
> @@ -746,8 +728,6 @@ void __init init_cpu_to_node(void)
>  
>  		if (node == NUMA_NO_NODE)
>  			continue;
> -		if (!node_online(node))
> -			node = find_near_online_node(node);
>  		numa_set_node(cpu, node);
>  	}
>  }
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 1020b1b..9c7f842 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -284,7 +284,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 *  less than the max # of CPUs. They should be ignored _iff
>  	 *  they are physically not present.
>  	 */
> -	if (pr->id == -1) {
> +	if (pr->id == -1 || !cpu_present(pr->id)) {
>  		int ret = acpi_processor_hotadd_init(pr);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 8b67bd0..36413b1 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -671,6 +671,9 @@ static int __init acpi_init(void)
>  	acpi_debugfs_init();
>  	acpi_sleep_proc_init();
>  	acpi_wakeup_device_init();
> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> +	acpi_set_processor_mapping();
> +#endif
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 7962651..b2b44a0 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -32,12 +32,12 @@ static struct acpi_table_madt *get_madt_table(void)
>  }
>  
>  static int map_lapic_id(struct acpi_subtable_header *entry,
> -		 u32 acpi_id, int *apic_id)
> +		 u32 acpi_id, int *apic_id, bool ignore_disabled)
>  {
>  	struct acpi_madt_local_apic *lapic =
>  		container_of(entry, struct acpi_madt_local_apic, header);
>  
> -	if (!(lapic->lapic_flags & ACPI_MADT_ENABLED))
> +	if (ignore_disabled && !(lapic->lapic_flags & ACPI_MADT_ENABLED))
>  		return -ENODEV;
>  
>  	if (lapic->processor_id != acpi_id)
> @@ -48,12 +48,13 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
>  }
>  
>  static int map_x2apic_id(struct acpi_subtable_header *entry,
> -			 int device_declaration, u32 acpi_id, int *apic_id)
> +			 int device_declaration, u32 acpi_id,
> +			 int *apic_id, bool ignore_disabled)
>  {
>  	struct acpi_madt_local_x2apic *apic =
>  		container_of(entry, struct acpi_madt_local_x2apic, header);
>  
> -	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
> +	if (ignore_disabled && !(apic->lapic_flags & ACPI_MADT_ENABLED))
>  		return -ENODEV;
>  
>  	if (device_declaration && (apic->uid == acpi_id)) {
> @@ -65,12 +66,13 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
>  }
>  
>  static int map_lsapic_id(struct acpi_subtable_header *entry,
> -		int device_declaration, u32 acpi_id, int *apic_id)
> +			 int device_declaration, u32 acpi_id,
> +			 int *apic_id, bool ignore_disabled)
>  {
>  	struct acpi_madt_local_sapic *lsapic =
>  		container_of(entry, struct acpi_madt_local_sapic, header);
>  
> -	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
> +	if (ignore_disabled && !(lsapic->lapic_flags & ACPI_MADT_ENABLED))
>  		return -ENODEV;
>  
>  	if (device_declaration) {
> @@ -83,7 +85,7 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>  	return 0;
>  }
>  
> -static int map_madt_entry(int type, u32 acpi_id)
> +static int map_madt_entry(int type, u32 acpi_id, bool ignore_disabled)
>  {
>  	unsigned long madt_end, entry;
>  	int phys_id = -1;	/* CPU hardware ID */
> @@ -103,13 +105,16 @@ static int map_madt_entry(int type, u32 acpi_id)
>  		struct acpi_subtable_header *header =
>  			(struct acpi_subtable_header *)entry;
>  		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
> -			if (!map_lapic_id(header, acpi_id, &phys_id))
> +			if (!map_lapic_id(header, acpi_id, &phys_id,
> +					  ignore_disabled))
>  				break;
>  		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
> -			if (!map_x2apic_id(header, type, acpi_id, &phys_id))
> +			if (!map_x2apic_id(header, type, acpi_id, &phys_id,
> +					   ignore_disabled))
>  				break;
>  		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
> -			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
> +			if (!map_lsapic_id(header, type, acpi_id, &phys_id,
> +					   ignore_disabled))
>  				break;
>  		}
>  		entry += header->length;
> @@ -117,7 +122,8 @@ static int map_madt_entry(int type, u32 acpi_id)
>  	return phys_id;
>  }
>  
> -static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
> +static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id,
> +			 bool ignore_disabled)
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
> @@ -138,28 +144,34 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  
>  	header = (struct acpi_subtable_header *)obj->buffer.pointer;
>  	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC)
> -		map_lapic_id(header, acpi_id, &phys_id);
> +		map_lapic_id(header, acpi_id, &phys_id, ignore_disabled);
>  	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
> -		map_lsapic_id(header, type, acpi_id, &phys_id);
> +		map_lsapic_id(header, type, acpi_id, &phys_id, ignore_disabled);
>  	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
> -		map_x2apic_id(header, type, acpi_id, &phys_id);
> +		map_x2apic_id(header, type, acpi_id, &phys_id, ignore_disabled);
>  
>  exit:
>  	kfree(buffer.pointer);
>  	return phys_id;
>  }
>  
> -int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
> +static int __acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id,
> +			      bool ignore_disabled)
>  {
>  	int phys_id;
>  
> -	phys_id = map_mat_entry(handle, type, acpi_id);
> +	phys_id = map_mat_entry(handle, type, acpi_id, ignore_disabled);
>  	if (phys_id == -1)
> -		phys_id = map_madt_entry(type, acpi_id);
> +		phys_id = map_madt_entry(type, acpi_id, ignore_disabled);
>  
>  	return phys_id;
>  }
>  
> +int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
> +{
> +	return  __acpi_get_phys_id(handle, type, acpi_id, true);
> +}
> +
>  int acpi_map_cpuid(int phys_id, u32 acpi_id)
>  {
>  #ifdef CONFIG_SMP
> @@ -216,6 +228,68 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
>  }
>  EXPORT_SYMBOL_GPL(acpi_get_cpuid);
>  
> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> +static bool map_processor(acpi_handle handle, int *phys_id, int *cpuid)
> +{
> +	int type;
> +	u32 acpi_id;
> +	acpi_status status;
> +	acpi_object_type acpi_type;
> +	unsigned long long tmp;
> +	union acpi_object object = { 0 };
> +	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
> +
> +	status = acpi_get_type(handle, &acpi_type);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +
> +	switch (acpi_type) {
> +	case ACPI_TYPE_PROCESSOR:
> +		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
> +		if (ACPI_FAILURE(status))
> +			return false;
> +		acpi_id = object.processor.proc_id;
> +		break;
> +	case ACPI_TYPE_DEVICE:
> +		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
> +		if (ACPI_FAILURE(status))
> +			return false;
> +		acpi_id = tmp;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
> +
> +	*phys_id = __acpi_get_phys_id(handle, type, acpi_id, false);
> +	*cpuid = acpi_map_cpuid(*phys_id, acpi_id);
> +	if (*cpuid == -1)
> +		return false;
> +	return true;
> +}
> +
> +static acpi_status __init
> +set_processor_node_mapping(acpi_handle handle, u32 lvl, void *context,
> +			   void **rv)
> +{
> +	u32 apic_id;
> +	int cpu_id;
> +
> +	if (!map_processor(handle, &apic_id, &cpu_id))
> +		return AE_ERROR;
> +	acpi_map_cpu2node(handle, cpu_id, apic_id);
> +	return AE_OK;
> +}
> +
> +void __init acpi_set_processor_mapping(void)
> +{
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> +			ACPI_UINT32_MAX,
> +			set_processor_node_mapping, NULL, NULL, NULL);
> +}
> +#endif
> +
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>  static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
>  			 u64 *phys_addr, int *ioapic_id)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index dd12127..a7bf53c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -156,6 +156,8 @@ void acpi_numa_arch_fixup(void);
>  /* Arch dependent functions for cpu hotplug support */
>  int acpi_map_cpu(acpi_handle handle, int physid, int *pcpu);
>  int acpi_unmap_cpu(int cpu);
> +void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid);
> +void __init acpi_set_processor_mapping(void);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
