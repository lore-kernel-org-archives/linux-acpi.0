From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 1/3] ACPI: osl, add acpi_os_create_lock interface
Date: Wed, 23 Mar 2011 17:26:34 +0800
Message-ID: <1300872396-16522-2-git-send-email-ming.m.lin@intel.com>
References: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5458 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943Ab1CWJSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2011 05:18:50 -0400
In-Reply-To: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/osl.c      |   33 +++++++++++++++++++++++++--------
 include/acpi/acpiosxf.h |    3 +++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 45ad4ff..52ca964 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -902,14 +902,6 @@ void acpi_os_wait_events_complete(void *context)
 
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
-/*
- * Deallocate the memory for a spinlock.
- */
-void acpi_os_delete_lock(acpi_spinlock handle)
-{
-	return;
-}
-
 acpi_status
 acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
@@ -1341,6 +1333,31 @@ int acpi_resources_are_enforced(void)
 EXPORT_SYMBOL(acpi_resources_are_enforced);
 
 /*
+ * Create and initialize a spinlock.
+ */
+acpi_status
+acpi_os_create_lock(acpi_spinlock *out_handle)
+{
+	spinlock_t *lock;
+
+	lock = ACPI_ALLOCATE(sizeof(spinlock_t));
+	if (!lock)
+		return AE_NO_MEMORY;
+	spin_lock_init(lock);
+	*out_handle = lock;
+
+	return AE_OK;
+}
+
+/*
+ * Deallocate the memory for a spinlock.
+ */
+void acpi_os_delete_lock(acpi_spinlock handle)
+{
+	ACPI_FREE(handle);
+}
+
+/*
  * Acquire a spinlock.
  *
  * handle is a pointer to the spinlock_t.
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a3252a5..a756bc8 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -98,6 +98,9 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 /*
  * Spinlock primitives
  */
+acpi_status
+acpi_os_create_lock(acpi_spinlock *out_handle);
+
 void acpi_os_delete_lock(acpi_spinlock handle);
 
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock handle);
-- 
1.7.3

