From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI / OSL: Fix rcu synchronization logic
Date: Wed, 11 Jan 2017 17:54:33 +0800
Message-ID: <f9f4f5b204e866a346ee335c9d1dfb39ef3a1405.1484127670.git.lv.zheng@intel.com>
References: <9dc727dc367a34ae23965e0cb0fe7668d1fc64d4>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:10418 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935082AbdAKJyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Jan 2017 04:54:40 -0500
In-Reply-To: <9dc727dc367a34ae23965e0cb0fe7668d1fc64d4>
References: <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>

The rcu synchronization logic is originally provided to protect
apei_read()/apei_write() as in the APEI drivers, there is NMI event source
requiring non spinlock based synchronization mechanism. After that, ACPI
developers think FADT registers may also require same facility, so they
moved the RCU stuffs to generic ACPI layer. So now interrupt (irq, nmi)
context ACPI map lookup is only protected by RCU.

This triggers a kernel hang when ACPICA API starts to unmap unused tables
(see Link #1 for details). The cause of the hang is
drivers/iommu/amd_iommu_init.c calling acpi_put_table() too early and then
land in RCU which is uninitialized yet:
  early_amd_iommu_init()
    acpi_put_table(ivrs_base)
      acpi_os_unmap_memory()
        synchronize_rcu_expedited()
Now that function goes and sends IPIs, i.e., schedule_work() but this is
too early - workqueue_init() hasn't been invoked. Actually, from looking
at the callstack, we do kernel_init_freeable()->native_smp_prepare_cpus()
and workqueue_init() comes next.

Actually this facility is only used to protect interrupt context ACPI map
lookup, and such mappings are only introduced by
acpi_os_map_generic_address(). So before it is invoked, there is no need to
use RCU, mutex should be used instead of.

Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Link: https://lkml.kernel.org/r/4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com [#1]
Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/acpi/osl.c     | 47 ++++++++++++++++++++++++++++++++++++++++-------
 include/acpi/acpi_io.h |  1 +
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 82285c0..f9adefc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,6 +77,7 @@ static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
 unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
 bool acpi_permanent_mmap = false;
+bool acpi_lockless_mmap;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -378,7 +379,10 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
 	if (!map->refcount) {
-		synchronize_rcu_expedited();
+		/* sync lockless after unregistering interrupt handlers */
+		smp_rmb();
+		if (acpi_lockless_mmap)
+			synchronize_rcu_expedited();
 		acpi_unmap(map->phys, map->virt);
 		kfree(map);
 	}
@@ -444,6 +448,10 @@ int acpi_os_map_generic_address(struct acpi_generic_address *gas)
 	if (!virt)
 		return -EIO;
 
+	acpi_lockless_mmap = true;
+	/* sync lockless before registering interrupt handlers */
+	smp_wmb();
+
 	return 0;
 }
 EXPORT_SYMBOL(acpi_os_map_generic_address);
@@ -663,18 +671,42 @@ acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 
 EXPORT_SYMBOL(acpi_os_write_port);
 
+static bool acpi_lock_ioremap(void)
+{
+	bool lockless;
+
+	/* sync lockless after invoking interrupt handlers */
+	smp_rmb();
+	lockless = acpi_lockless_mmap;
+	if (lockless)
+		rcu_read_lock();
+	else
+		/* WARN_ON_ONCE(in_interrupt()); */
+		mutex_lock(&acpi_ioremap_lock);
+	return lockless;
+}
+
+static void acpi_unlock_ioremap(bool lockless)
+{
+	if (lockless)
+		rcu_read_unlock();
+	else
+		mutex_unlock(&acpi_ioremap_lock);
+}
+
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 {
 	void __iomem *virt_addr;
 	unsigned int size = width / 8;
 	bool unmap = false;
+	bool lockless;
 	u64 dummy;
 
-	rcu_read_lock();
+	lockless = acpi_lock_ioremap();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
 	if (!virt_addr) {
-		rcu_read_unlock();
+		acpi_unlock_ioremap(lockless);
 		virt_addr = acpi_os_ioremap(phys_addr, size);
 		if (!virt_addr)
 			return AE_BAD_ADDRESS;
@@ -704,7 +736,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 	if (unmap)
 		iounmap(virt_addr);
 	else
-		rcu_read_unlock();
+		acpi_unlock_ioremap(lockless);
 
 	return AE_OK;
 }
@@ -715,11 +747,12 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 	void __iomem *virt_addr;
 	unsigned int size = width / 8;
 	bool unmap = false;
+	bool lockless;
 
-	rcu_read_lock();
+	lockless = acpi_lock_ioremap();
 	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
 	if (!virt_addr) {
-		rcu_read_unlock();
+		acpi_unlock_ioremap(lockless);
 		virt_addr = acpi_os_ioremap(phys_addr, size);
 		if (!virt_addr)
 			return AE_BAD_ADDRESS;
@@ -746,7 +779,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 	if (unmap)
 		iounmap(virt_addr);
 	else
-		rcu_read_unlock();
+		acpi_unlock_ioremap(lockless);
 
 	return AE_OK;
 }
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 303315b..f11be8b 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -14,6 +14,7 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 #endif
 
 extern bool acpi_permanent_mmap;
+extern bool acpi_lockless_mmap;
 
 void __iomem *__ref
 acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
-- 
2.7.4

