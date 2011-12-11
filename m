From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/18] ACPI 5.0: Implement hardware-reduced option
Date: Sun, 11 Dec 2011 12:45:38 -0500
Message-ID: <5fd42d7bba7b2e13e918247195b434a0d4bf3141.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36856 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1LKS0m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 13:26:42 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW10020XXWDDIBB@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 12:26:40 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

If HW-reduced flag is set in the FADT, do not attempt to access
or initialize any ACPI hardware, including SCI and global lock.
No FACS will be present.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |   13 ++++++++++++-
 drivers/acpi/acpica/evevent.c  |   12 ++++++++++++
 drivers/acpi/acpica/evglock.c  |    6 ++++++
 drivers/acpi/acpica/tbfadt.c   |   22 ++++++++++++++++++++--
 drivers/acpi/acpica/tbutils.c  |    7 +++++++
 include/acpi/acpixf.h          |    1 +
 6 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 76dc02f..25912a9 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -140,8 +140,19 @@ u32 acpi_gbl_trace_flags;
 acpi_name acpi_gbl_trace_method_name;
 u8 acpi_gbl_system_awake_and_running;
 
+/*
+ * ACPI 5.0 introduces the concept of a "reduced hardware platform", meaning
+ * that the ACPI hardware is no longer required. A flag in the FADT indicates
+ * a reduced HW machine, and that flag is duplicated here for convenience.
+ */
+u8 acpi_gbl_reduced_hardware;
+
 #endif
 
+/* Do not disassemble buffers to resource descriptors */
+
+ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl_no_resource_disassembly, FALSE);
+
 /*****************************************************************************
  *
  * Debug support
@@ -207,7 +218,7 @@ ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
 
 /*****************************************************************************
  *
- * Mutual exlusion within ACPICA subsystem
+ * Mutual exclusion within ACPICA subsystem
  *
  ****************************************************************************/
 
diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index d458b04..1f43be4 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -71,6 +71,12 @@ acpi_status acpi_ev_initialize_events(void)
 
 	ACPI_FUNCTION_TRACE(ev_initialize_events);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/*
 	 * Initialize the Fixed and General Purpose Events. This is done prior to
 	 * enabling SCIs to prevent interrupts from occurring before the handlers
@@ -111,6 +117,12 @@ acpi_status acpi_ev_install_xrupt_handlers(void)
 
 	ACPI_FUNCTION_TRACE(ev_install_xrupt_handlers);
 
+	/* If Hardware Reduced flag is set, there is no ACPI h/w */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Install the SCI handler */
 
 	status = acpi_ev_install_sci_handler();
diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index 56a562a..af1e71a 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -70,6 +70,12 @@ acpi_status acpi_ev_init_global_lock_handler(void)
 
 	ACPI_FUNCTION_TRACE(ev_init_global_lock_handler);
 
+	/* If Hardware Reduced flag is set, there is no global lock */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Attempt installation of the global lock handler */
 
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_GLOBAL,
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 536fd2b..1e1a7de 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -253,8 +253,13 @@ void acpi_tb_parse_fadt(u32 table_index)
 	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xdsdt,
 			      ACPI_SIG_DSDT, ACPI_TABLE_INDEX_DSDT);
 
-	acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.Xfacs,
-			      ACPI_SIG_FACS, ACPI_TABLE_INDEX_FACS);
+	/* If Hardware Reduced flag is set, there is no FACS */
+
+	if (!acpi_gbl_reduced_hardware) {
+		acpi_tb_install_table((acpi_physical_address) acpi_gbl_FADT.
+				      Xfacs, ACPI_SIG_FACS,
+				      ACPI_TABLE_INDEX_FACS);
+	}
 }
 
 /*******************************************************************************
@@ -297,6 +302,13 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	ACPI_MEMCPY(&acpi_gbl_FADT, table,
 		    ACPI_MIN(length, sizeof(struct acpi_table_fadt)));
 
+	/* Take a copy of the Hardware Reduced flag */
+
+	acpi_gbl_reduced_hardware = FALSE;
+	if (acpi_gbl_FADT.flags & ACPI_FADT_HW_REDUCED) {
+		acpi_gbl_reduced_hardware = TRUE;
+	}
+
 	/* Convert the local copy of the FADT to the common internal format */
 
 	acpi_tb_convert_fadt();
@@ -502,6 +514,12 @@ static void acpi_tb_validate_fadt(void)
 		acpi_gbl_FADT.Xdsdt = (u64) acpi_gbl_FADT.dsdt;
 	}
 
+	/* If Hardware Reduced flag is set, we are all done */
+
+	if (acpi_gbl_reduced_hardware) {
+		return;
+	}
+
 	/* Examine all of the 64-bit extended address fields (X fields) */
 
 	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 0f2d395..da56a19 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -135,6 +135,13 @@ acpi_status acpi_tb_initialize_facs(void)
 {
 	acpi_status status;
 
+	/* If Hardware Reduced flag is set, there is no FACS */
+
+	if (acpi_gbl_reduced_hardware) {
+		acpi_gbl_FACS = NULL;
+		return (AE_OK);
+	}
+
 	status = acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
 					 ACPI_CAST_INDIRECT_PTR(struct
 								acpi_table_header,
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f554a93..9ba2e3a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -74,6 +74,7 @@ extern u8 acpi_gbl_disable_auto_repair;
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
 extern u8 acpi_gbl_system_awake_and_running;
+extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
 
 extern u32 acpi_rsdt_forced;
 /*
-- 
1.7.7.rc0.72.g4b5ea

