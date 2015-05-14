From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [RFC PATCH V2 1/2] x86/cpu hotplug: make apicid <--> cpuid mapping persistent
Date: Thu, 14 May 2015 19:33:33 +0800
Message-ID: <1431603214-12521-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:27044 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932328AbbENLxJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 07:53:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org, mingo@redhat.com, x86@kernel.org, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, guz.fnst@cn.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com

Yasuaki Ishimatsu found that with node online/offline, cpu<->node
relationship is established. Because workqueue uses a info which
was established at boot time, but it may be changed by node hotpluging.

Once pool->node points to a stale node, following allocation failure
happens.
  ==
     SLUB: Unable to allocate memory on node 2 (gfp=0x80d0)
      cache: kmalloc-192, object size: 192, buffer size: 192, default
order:
    1, min order: 0
      node 0: slabs: 6172, objs: 259224, free: 245741
      node 1: slabs: 3261, objs: 136962, free: 127656
  ==

As the apicid <---> pxm and pxm <--> node relationship are persistent, then
the apicid <--> node mapping is persistent, so the root cause is the
cpu-id <-> lapicid mapping is not persistent (because the currently
implementation always choose the first free cpu id for the new added cpu).
If we can build persistent cpu-id <-> lapicid relationship, this problem
will be fixed.

This patch tries to build the whole world mapping cpuid <-> apicid <-> pxm <-> node
for all possible processor at the boot, the detail implementation are 2 steps:

Step1: generate a logic cpu id for all the local apic (both enabled and dsiabled)
       when register local apic
Step2: map the cpu to the phyical node via an additional acpi ns walk for processor.

Please refer to:
https://lkml.org/lkml/2015/2/27/145
https://lkml.org/lkml/2015/3/25/989
for the previous discussion.
---
 V2: rebase on latest upstream.
---

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 arch/ia64/kernel/acpi.c       |   2 +-
 arch/x86/include/asm/mpspec.h |   1 +
 arch/x86/kernel/acpi/boot.c   |   8 ++-
 arch/x86/kernel/apic/apic.c   |  73 ++++++++++++++++++++-----
 arch/x86/mm/numa.c            |  20 -------
 drivers/acpi/acpi_processor.c |   2 +-
 drivers/acpi/bus.c            |   3 ++
 drivers/acpi/processor_core.c | 121 ++++++++++++++++++++++++++++++++++--------
 include/linux/acpi.h          |   2 +
 9 files changed, 172 insertions(+), 60 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index b1698bc..7db5563 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -796,7 +796,7 @@ int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
  *  ACPI based hotplug CPU support
  */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
-static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	/*
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index b07233b..db902d8 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -86,6 +86,7 @@ static inline void early_reserve_e820_mpc_new(void) { }
 #endif
 
 int generic_processor_info(int apicid, int version);
+int __generic_processor_info(int apicid, int version, bool enabled);
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dbe76a1..c79115b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -174,15 +174,13 @@ static int acpi_register_lapic(int id, u8 enabled)
 		return -EINVAL;
 	}
 
-	if (!enabled) {
+	if (!enabled)
 		++disabled_cpus;
-		return -EINVAL;
-	}
 
 	if (boot_cpu_physical_apicid != -1U)
 		ver = apic_version[boot_cpu_physical_apicid];
 
-	return generic_processor_info(id, ver);
+	return __generic_processor_info(id, ver, enabled);
 }
 
 static int __init
@@ -726,7 +724,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 #include <acpi/processor.h>
 
-static void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	int nid;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index dcb5285..7fbf2cb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1977,7 +1977,38 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 	apic_write(APIC_LVT1, value);
 }
 
-int generic_processor_info(int apicid, int version)
+/*
+ * Logic cpu number(cpuid) to local APIC id persistent mappings.
+ * Do not clear the mapping even if cpu hot removed.
+ * */
+static int apicid_to_cpuid[] = {
+	[0 ... NR_CPUS - 1] = -1,
+};
+
+/*
+ * Internal cpu id bits, set the bit once cpu present, and never clear it.
+ * */
+static cpumask_t cpuid_mask = CPU_MASK_NONE;
+
+static int get_cpuid(int apicid)
+{
+	int free_id, i;
+
+	free_id = cpumask_next_zero(-1, &cpuid_mask);
+	if (free_id >= nr_cpu_ids)
+		return -1;
+
+	for (i = 0; i < free_id; i++)
+		if (apicid_to_cpuid[i] == apicid)
+			return i;
+
+	apicid_to_cpuid[free_id] = apicid;
+	cpumask_set_cpu(free_id, &cpuid_mask);
+
+	return free_id;
+}
+
+int __generic_processor_info(int apicid, int version, bool enabled)
 {
 	int cpu, max = nr_cpu_ids;
 	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
@@ -2010,8 +2041,8 @@ int generic_processor_info(int apicid, int version)
 		pr_warning("APIC: Disabling requested cpu."
 			   " Processor %d/0x%x ignored.\n",
 			   thiscpu, apicid);
-
-		disabled_cpus++;
+		if (enabled)
+			disabled_cpus++;
 		return -ENODEV;
 	}
 
@@ -2027,8 +2058,8 @@ int generic_processor_info(int apicid, int version)
 			"ACPI: NR_CPUS/possible_cpus limit of %i almost"
 			" reached. Keeping one slot for boot cpu."
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
+		if (enabled)
+			disabled_cpus++;
 		return -ENODEV;
 	}
 
@@ -2039,11 +2070,11 @@ int generic_processor_info(int apicid, int version)
 			"ACPI: NR_CPUS/possible_cpus limit of %i reached."
 			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
 
-		disabled_cpus++;
+		if (enabled)
+			disabled_cpus++;
 		return -EINVAL;
 	}
 
-	num_processors++;
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
 		 * x86_bios_cpu_apicid is required to have processors listed
@@ -2053,9 +2084,20 @@ int generic_processor_info(int apicid, int version)
 		 * for BSP.
 		 */
 		cpu = 0;
-	} else
-		cpu = cpumask_next_zero(-1, cpu_present_mask);
-
+	} else {
+		cpu = get_cpuid(apicid);
+		if (cpu < 0) {
+			int thiscpu = max + disabled_cpus;
+
+			pr_warning("  Processor %d/0x%x ignored.\n",
+				thiscpu, apicid);
+			if (enabled)
+				disabled_cpus++;
+			return -EINVAL;
+		}
+	}
+	if (enabled)
+		num_processors++;
 	/*
 	 * Validate version
 	 */
@@ -2071,7 +2113,8 @@ int generic_processor_info(int apicid, int version)
 			apic_version[boot_cpu_physical_apicid], cpu, version);
 	}
 
-	physid_set(apicid, phys_cpu_present_map);
+	if (enabled)
+		physid_set(apicid, phys_cpu_present_map);
 	if (apicid > max_physical_apicid)
 		max_physical_apicid = apicid;
 
@@ -2084,11 +2127,17 @@ int generic_processor_info(int apicid, int version)
 		apic->x86_32_early_logical_apicid(cpu);
 #endif
 	set_cpu_possible(cpu, true);
-	set_cpu_present(cpu, true);
+	if (enabled)
+		set_cpu_present(cpu, true);
 
 	return cpu;
 }
 
+int generic_processor_info(int apicid, int version)
+{
+	return __generic_processor_info(apicid, version, true);
+}
+
 int hard_smp_processor_id(void)
 {
 	return read_apic_id();
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 4053bb5..a733cf9 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -702,24 +702,6 @@ void __init x86_numa_init(void)
 	numa_init(dummy_numa_init);
 }
 
-static __init int find_near_online_node(int node)
-{
-	int n, val;
-	int min_val = INT_MAX;
-	int best_node = -1;
-
-	for_each_online_node(n) {
-		val = node_distance(node, n);
-
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-
-	return best_node;
-}
-
 /*
  * Setup early cpu_to_node.
  *
@@ -746,8 +728,6 @@ void __init init_cpu_to_node(void)
 
 		if (node == NUMA_NO_NODE)
 			continue;
-		if (!node_online(node))
-			node = find_near_online_node(node);
 		numa_set_node(cpu, node);
 	}
 }
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 58f335c..83bc464 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -285,7 +285,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  less than the max # of CPUs. They should be ignored _iff
 	 *  they are physically not present.
 	 */
-	if (pr->id == -1) {
+	if (pr->id == -1 || !cpu_present(pr->id)) {
 		int ret = acpi_processor_hotadd_init(pr);
 		if (ret)
 			return ret;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index c412fdb..98cdce9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -674,6 +674,9 @@ static int __init acpi_init(void)
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+	acpi_set_processor_mapping();
+#endif
 	return 0;
 }
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b1ec78b..74798fe 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -32,12 +32,12 @@ static struct acpi_table_madt *get_madt_table(void)
 }
 
 static int map_lapic_id(struct acpi_subtable_header *entry,
-		 u32 acpi_id, phys_cpuid_t *apic_id)
+		 u32 acpi_id, phys_cpuid_t *apic_id, bool ignore_disabled)
 {
 	struct acpi_madt_local_apic *lapic =
 		container_of(entry, struct acpi_madt_local_apic, header);
 
-	if (!(lapic->lapic_flags & ACPI_MADT_ENABLED))
+	if (ignore_disabled && !(lapic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (lapic->processor_id != acpi_id)
@@ -48,12 +48,13 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id,
+		bool ignore_disabled)
 {
 	struct acpi_madt_local_x2apic *apic =
 		container_of(entry, struct acpi_madt_local_x2apic, header);
 
-	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
+	if (ignore_disabled && !(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (device_declaration && (apic->uid == acpi_id)) {
@@ -65,12 +66,13 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_lsapic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id,
+		bool ignore_disabled)
 {
 	struct acpi_madt_local_sapic *lsapic =
 		container_of(entry, struct acpi_madt_local_sapic, header);
 
-	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
+	if (ignore_disabled && !(lsapic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (device_declaration) {
@@ -87,12 +89,13 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
  * Retrieve the ARM CPU physical identifier (MPIDR)
  */
 static int map_gicc_mpidr(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *mpidr)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *mpidr,
+		bool ignore_disabled)
 {
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
 
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (ignore_disabled && !(gicc->flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	/* device_declaration means Device object in DSDT, in the
@@ -108,7 +111,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	return -EINVAL;
 }
 
-static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
+static phys_cpuid_t map_madt_entry(int type, u32 acpi_id, bool ignore_disabled)
 {
 	unsigned long madt_end, entry;
 	phys_cpuid_t phys_id = PHYS_CPUID_INVALID;	/* CPU hardware ID */
@@ -128,16 +131,20 @@ static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
 		struct acpi_subtable_header *header =
 			(struct acpi_subtable_header *)entry;
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
-			if (!map_lapic_id(header, acpi_id, &phys_id))
+			if (!map_lapic_id(header, acpi_id,
+					  &phys_id, ignore_disabled))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
-			if (!map_x2apic_id(header, type, acpi_id, &phys_id))
+			if (!map_x2apic_id(header, type, acpi_id,
+					   &phys_id, ignore_disabled))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
-			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
+			if (!map_lsapic_id(header, type, acpi_id,
+					   &phys_id, ignore_disabled))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
-			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
+			if (!map_gicc_mpidr(header, type, acpi_id,
+					    &phys_id, ignore_disabled))
 				break;
 		}
 		entry += header->length;
@@ -145,7 +152,8 @@ static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
 	return phys_id;
 }
 
-static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
+static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id,
+				  bool ignore_disabled)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
@@ -166,30 +174,39 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
 	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC)
-		map_lapic_id(header, acpi_id, &phys_id);
+		map_lapic_id(header, acpi_id, &phys_id, ignore_disabled);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
-		map_lsapic_id(header, type, acpi_id, &phys_id);
+		map_lsapic_id(header, type, acpi_id,
+			      &phys_id, ignore_disabled);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
-		map_x2apic_id(header, type, acpi_id, &phys_id);
+		map_x2apic_id(header, type, acpi_id,
+			      &phys_id, ignore_disabled);
 	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
-		map_gicc_mpidr(header, type, acpi_id, &phys_id);
+		map_gicc_mpidr(header, type, acpi_id,
+			       &phys_id, ignore_disabled);
 
 exit:
 	kfree(buffer.pointer);
 	return phys_id;
 }
 
-phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
+static phys_cpuid_t __acpi_get_phys_id(acpi_handle handle, int type,
+				       u32 acpi_id, bool ignore_disabled)
 {
 	phys_cpuid_t phys_id;
 
-	phys_id = map_mat_entry(handle, type, acpi_id);
+	phys_id = map_mat_entry(handle, type, acpi_id, ignore_disabled);
 	if (phys_id == PHYS_CPUID_INVALID)
-		phys_id = map_madt_entry(type, acpi_id);
+		phys_id = map_madt_entry(type, acpi_id, ignore_disabled);
 
 	return phys_id;
 }
 
+phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
+{
+	return  __acpi_get_phys_id(handle, type, acpi_id, true);
+}
+
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
 {
 #ifdef CONFIG_SMP
@@ -246,6 +263,68 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+static bool map_processor(acpi_handle handle, int *phys_id, int *cpuid)
+{
+	int type;
+	u32 acpi_id;
+	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long tmp;
+	union acpi_object object = { 0 };
+	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
+
+	status = acpi_get_type(handle, &acpi_type);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = object.processor.proc_id;
+		break;
+	case ACPI_TYPE_DEVICE:
+		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = tmp;
+		break;
+	default:
+		return false;
+	}
+
+	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
+
+	*phys_id = __acpi_get_phys_id(handle, type, acpi_id, false);
+	*cpuid = acpi_map_cpuid(*phys_id, acpi_id);
+	if (*cpuid == -1)
+		return false;
+	return true;
+}
+
+static acpi_status __init
+set_processor_node_mapping(acpi_handle handle, u32 lvl, void *context,
+			   void **rv)
+{
+	u32 apic_id;
+	int cpu_id;
+
+	if (!map_processor(handle, &apic_id, &cpu_id))
+		return AE_ERROR;
+	acpi_map_cpu2node(handle, cpu_id, apic_id);
+	return AE_OK;
+}
+
+void __init acpi_set_processor_mapping(void)
+{
+	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX,
+			set_processor_node_mapping, NULL, NULL, NULL);
+}
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index e4da5e3..70166df 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -162,6 +162,8 @@ typedef u32 phys_cpuid_t;
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
 int acpi_unmap_cpu(int cpu);
+void acpi_map_cpu2node(acpi_handle handle, int cpu, int physid);
+void __init acpi_set_processor_mapping(void);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
1.8.3.1

