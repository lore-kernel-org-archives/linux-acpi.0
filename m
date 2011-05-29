From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/18] ACPI: osl, add acpi_os_create_lock interface
Date: Sun, 29 May 2011 05:43:57 -0400
Message-ID: <9f63b88bd7a1ac1afbb4358772a39abaeddbdd13.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57404 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1E2JoS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:18 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY003CXB1TC4F0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:18 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c      |   33 +++++++++++++++++++++++++--------
 include/acpi/acpiosxf.h |    3 +++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c90c76a..cf750a7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -883,14 +883,6 @@ void acpi_os_wait_events_complete(void *context)
 
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
@@ -1322,6 +1314,31 @@ int acpi_resources_are_enforced(void)
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
1.7.5.3.367.ga9930.dirty

