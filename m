From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2 1/4] Revert"x86/acpi: Set persistent cpuid <-> nodeid mapping when booting"
Date: Mon, 20 Feb 2017 16:47:48 +0800
Message-ID: <1487580471-17665-2-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Currently, We make the mapping of "cpuid <-> nodeid" fixed at the booting time.
It keeps consistent with the WorkQueue and avoids some bugs which may be caused
by the dynamic assignment.

But, The ACPI table is unreliable and it is very risky that we use the entity
which isn't related to a physical device at booting time.

Now, we revert our patches. Do the last mapping of "cpuid <-> nodeid" at
hot-plug time, not at booting time where we did some useless work.
It also can make the mapping of "cpuid <-> nodeid" fixed and avoid excessive
use of the ACPI table.

The patch revert the commit dc6db24d24:
  "x86/acpi: Set persistent cpuid <-> nodeid mapping when booting".

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/acpi/boot.c   |  2 +-
 drivers/acpi/acpi_processor.c |  5 ---
 drivers/acpi/bus.c            |  1 -
 drivers/acpi/processor_core.c | 73 -------------------------------------------
 include/linux/acpi.h          |  3 --
 5 files changed, 1 insertion(+), 83 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 64422f8..32846a2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -709,7 +709,7 @@ static void __init acpi_set_irq_model_ioapic(void)
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 #include <acpi/processor.h>
 
-int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
+static int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 {
 #ifdef CONFIG_ACPI_NUMA
 	int nid;
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 3de3b6b..f43a586 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,11 +182,6 @@ int __weak arch_register_cpu(int cpu)
 
 void __weak arch_unregister_cpu(int cpu) {}
 
-int __weak acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
-{
-	return -ENODEV;
-}
-
 static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	unsigned long long sta;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb..d4455e4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1207,7 +1207,6 @@ static int __init acpi_init(void)
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
-	acpi_set_processor_mapping();
 	return 0;
 }
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 611a558..a843862 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -278,79 +278,6 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-static bool __init
-map_processor(acpi_handle handle, phys_cpuid_t *phys_id, int *cpuid)
-{
-	int type, id;
-	u32 acpi_id;
-	acpi_status status;
-	acpi_object_type acpi_type;
-	unsigned long long tmp;
-	union acpi_object object = { 0 };
-	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-
-	status = acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_PROCESSOR:
-		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = object.processor.proc_id;
-
-		/* validate the acpi_id */
-		if(acpi_processor_validate_proc_id(acpi_id))
-			return false;
-		break;
-	case ACPI_TYPE_DEVICE:
-		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = tmp;
-		break;
-	default:
-		return false;
-	}
-
-	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
-
-	*phys_id = __acpi_get_phys_id(handle, type, acpi_id, false);
-	id = acpi_map_cpuid(*phys_id, acpi_id);
-
-	if (id < 0)
-		return false;
-	*cpuid = id;
-	return true;
-}
-
-static acpi_status __init
-set_processor_node_mapping(acpi_handle handle, u32 lvl, void *context,
-			   void **rv)
-{
-	phys_cpuid_t phys_id;
-	int cpu_id;
-
-	if (!map_processor(handle, &phys_id, &cpu_id))
-		return AE_ERROR;
-
-	acpi_map_cpu2node(handle, cpu_id, phys_id);
-	return AE_OK;
-}
-
-void __init acpi_set_processor_mapping(void)
-{
-	/* Set persistent cpu <-> node mapping for all processors. */
-	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, set_processor_node_mapping,
-			    NULL, NULL, NULL);
-}
-#else
-void __init acpi_set_processor_mapping(void) {}
-#endif /* CONFIG_ACPI_HOTPLUG_CPU */
-
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5b36974..d180cbd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -293,11 +293,8 @@ bool acpi_processor_validate_proc_id(int proc_id);
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, int *pcpu);
 int acpi_unmap_cpu(int cpu);
-int acpi_map_cpu2node(acpi_handle handle, int cpu, int physid);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
-void acpi_set_processor_mapping(void);
-
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
 #endif
-- 
2.5.5
