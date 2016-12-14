From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 4/4] ACPI / osl: Remove deprecated acpi_get_table_with_size()/early_acpi_os_unmap_memory()
Date: Wed, 14 Dec 2016 15:04:46 +0800
Message-ID: <4667783dd12da9ed3bfc9bf19a077c0acdb7b828.1481698041.git.lv.zheng@intel.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <cover.1481698041.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbcLNHEv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Dec 2016 02:04:51 -0500
In-Reply-To: <cover.1481698041.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Since all users are cleaned up, remove the 2 deprecated APIs due to no
users.
As a Linux variable rather than an ACPICA variable, acpi_gbl_permanent_mmap
is renamed to acpi_permanent_mmap to have a consistent coding style across
entire Linux ACPI subsystem.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/arm64/include/asm/acpi.h |    2 +-
 drivers/acpi/bus.c            |    2 +-
 drivers/acpi/osl.c            |   50 +++++------------------------------------
 include/acpi/acpi_io.h        |    2 ++
 include/acpi/acpixf.h         |   13 -----------
 5 files changed, 9 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index d0de0e0..c1976c0 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -29,7 +29,7 @@
 
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
-/* ACPI table mapping after acpi_gbl_permanent_mmap is set */
+/* ACPI table mapping after acpi_permanent_mmap is set */
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5cbefd7..95855cb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -974,7 +974,7 @@ void __init acpi_early_init(void)
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack = TRUE;
 
-	acpi_gbl_permanent_mmap = 1;
+	acpi_permanent_mmap = true;
 
 	/*
 	 * If the machine falls into the DMI check table,
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index d0b273f..a404ff4 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -76,6 +76,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
 static struct workqueue_struct *kacpi_hotplug_wq;
 static bool acpi_os_initialized;
 unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
+bool acpi_permanent_mmap = false;
 
 /*
  * This list of permanent mappings is for memory that may be accessed from
@@ -306,7 +307,7 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
  * virtual address).  If not found, map it, add it to that list and return a
  * pointer to it.
  *
- * During early init (when acpi_gbl_permanent_mmap has not been set yet) this
+ * During early init (when acpi_permanent_mmap has not been set yet) this
  * routine simply calls __acpi_map_table() to get the job done.
  */
 void __iomem *__ref
@@ -322,7 +323,7 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
 		return NULL;
 	}
 
-	if (!acpi_gbl_permanent_mmap)
+	if (!acpi_permanent_mmap)
 		return __acpi_map_table((unsigned long)phys, size);
 
 	mutex_lock(&acpi_ioremap_lock);
@@ -392,7 +393,7 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
  * mappings, drop a reference to it and unmap it if there are no more active
  * references to it.
  *
- * During early init (when acpi_gbl_permanent_mmap has not been set yet) this
+ * During early init (when acpi_permanent_mmap has not been set yet) this
  * routine simply calls __acpi_unmap_table() to get the job done.  Since
  * __acpi_unmap_table() is an __init function, the __ref annotation is needed
  * here.
@@ -401,7 +402,7 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
 {
 	struct acpi_ioremap *map;
 
-	if (!acpi_gbl_permanent_mmap) {
+	if (!acpi_permanent_mmap) {
 		__acpi_unmap_table(virt, size);
 		return;
 	}
@@ -426,47 +427,6 @@ void __ref acpi_os_unmap_memory(void *virt, acpi_size size)
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
-/*******************************************************************************
- *
- * acpi_get_table_with_size()/early_acpi_os_unmap_memory():
- *
- * These 2 functions are traditionally used by Linux to map/unmap physical
- * addressed ACPI tables during the early stage.
- * They are deprectated now. Do not use them in the new code, but use
- * acpi_get_table()/acpi_put_table() instead.
- *
- ******************************************************************************/
-acpi_status
-acpi_get_table_with_size(char *signature,
-	       u32 instance, struct acpi_table_header **out_table,
-	       acpi_size *tbl_size)
-{
-	acpi_status status;
-
-	status = acpi_get_table(signature, instance, out_table);
-	if (ACPI_SUCCESS(status)) {
-		/*
-		 * "tbl_size" is no longer used by
-		 * early_acpi_os_unmap_memory(), but is still used by the
-		 * ACPI table drivers. So sets it to the length of the
-		 * table when the tbl_size is requested.
-		 * "out_table" is not sanity checked as AE_BAD_PARAMETER
-		 * is returned if it is NULL.
-		 */
-		if (tbl_size && *out_table)
-			*tbl_size = (*out_table)->length;
-	}
-
-	return (status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
-
-void __init early_acpi_os_unmap_memory(void __iomem *virt, acpi_size size)
-{
-	acpi_put_table(ACPI_CAST_PTR(struct acpi_table_header, virt));
-}
-
 int acpi_os_map_generic_address(struct acpi_generic_address *gas)
 {
 	u64 addr;
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index d7d0f49..303315b 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -13,6 +13,8 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 }
 #endif
 
+extern bool acpi_permanent_mmap;
+
 void __iomem *__ref
 acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 33828dd..f5e10dd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -967,19 +967,6 @@
 /*
  * Divergences
  */
-ACPI_GLOBAL(u8, acpi_gbl_permanent_mmap);
-
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_get_table_with_size(acpi_string signature,
-						     u32 instance,
-						     struct acpi_table_header
-						     **out_table,
-						     acpi_size *tbl_size))
-
-ACPI_EXTERNAL_RETURN_VOID(void
-			  early_acpi_os_unmap_memory(void __iomem * virt,
-						     acpi_size size))
-
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_data_full(acpi_handle object,
 					       acpi_object_handler handler,
-- 
1.7.10

