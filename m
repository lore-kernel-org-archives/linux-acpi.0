From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPICA: Add new statistics interface.
Date: Mon, 31 Dec 2012 08:26:28 +0800
Message-ID: <a174def786ed15d04233ef41706b2f09737569fd.1356871667.git.lv.zheng@intel.com>
References: <cover.1356871667.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43204 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab2LaA0v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:26:51 -0500
In-Reply-To: <cover.1356871667.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, Lv Zheng <lv.zheng@intel.com>

This patch decreases 123 lines of 20121114 divergence.diff.

This patch ports new counters and statistics interface to Linux as such
enhancement has already been implemented in ACPICA. This patch can also
reduce the source code differences between Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Divergences fixing result:
  Before applying: 1919 Lines, 68.3 Kbytes
  After applying: 1796 Lines, 64.3 Kbytes
---
 drivers/acpi/acpica/acglobal.h |    2 ++
 drivers/acpi/acpica/dsmethod.c |    1 +
 drivers/acpi/acpica/evsci.c    |    1 +
 drivers/acpi/acpica/utglobal.c |   11 +++++++++++
 drivers/acpi/acpica/utxface.c  |   38 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    2 ++
 include/acpi/actypes.h         |   10 ++++++++++
 7 files changed, 65 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 585d364..e7ebb0b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -393,7 +393,9 @@ extern u32 acpi_gbl_nesting_level;
 
 /* Event counters */
 
+ACPI_EXTERN u32 acpi_method_count;
 ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_sci_count;
 ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
 
 /* Support for dynamic control method tracing mechanism */
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 4e5873a..7fed60c 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -292,6 +292,7 @@ acpi_ds_begin_method_execution(struct acpi_namespace_node *method_node,
 	 * reentered one more time (even if it is the same thread)
 	 */
 	obj_desc->method.thread_count++;
+	acpi_method_count++;
 	return_ACPI_STATUS(status);
 
       cleanup:
diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
index 6c90f15..2f93ac5 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -89,6 +89,7 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context)
 	 */
 	interrupt_handled |= acpi_ev_gpe_detect(gpe_xrupt_list);
 
+	acpi_sci_count++;
 	return_VALUE(interrupt_handled);
 }
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 7b4dd21..82caa42 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -289,6 +289,16 @@ acpi_status acpi_ut_init_globals(void)
 
 	acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS - 1] = 0x80000000;
 
+	/* Event counters */
+
+	acpi_method_count = 0;
+	acpi_sci_count = 0;
+	acpi_gpe_count = 0;
+
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+		acpi_fixed_event_count[i] = 0;
+	}
+
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* GPE support */
@@ -378,4 +388,5 @@ acpi_status acpi_ut_init_globals(void)
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+    ACPI_EXPORT_SYMBOL(acpi_gpe_count)
 ACPI_EXPORT_SYMBOL(acpi_current_gpe_count)
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index cb85a7b..f1f0bb5 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -207,6 +207,44 @@ acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
 
 ACPI_EXPORT_SYMBOL(acpi_get_system_info)
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_get_statistics
+ *
+ * PARAMETERS:  stats           - Where the statistics are returned
+ *
+ * RETURN:      status          - the status of the call
+ *
+ * DESCRIPTION: Get the contents of the various system counters
+ *
+ ******************************************************************************/
+acpi_status acpi_get_statistics(struct acpi_statistics *stats)
+{
+	ACPI_FUNCTION_TRACE(acpi_get_statistics);
+
+	/* Parameter validation */
+
+	if (!stats) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	/* Various interrupt-based event counters */
+
+	stats->sci_count = acpi_sci_count;
+	stats->gpe_count = acpi_gpe_count;
+
+	ACPI_MEMCPY(stats->fixed_event_count, acpi_fixed_event_count,
+		    sizeof(acpi_fixed_event_count));
+
+	/* Other counters */
+
+	stats->method_count = acpi_method_count;
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_get_statistics)
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_install_initialization_handler
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d8b2ea6..110bc23 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -137,6 +137,8 @@ acpi_status acpi_subsystem_status(void);
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
 #endif
 
+acpi_status acpi_get_statistics(struct acpi_statistics *stats);
+
 const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3d4e09c..46e6624 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -933,6 +933,16 @@ struct acpi_system_info {
 	u32 debug_layer;
 };
 
+/*
+ * System statistics returned by acpi_get_statistics()
+ */
+struct acpi_statistics {
+	u32 sci_count;
+	u32 gpe_count;
+	u32 fixed_event_count[ACPI_NUM_FIXED_EVENTS];
+	u32 method_count;
+};
+
 /* Table Event Types */
 
 #define ACPI_TABLE_EVENT_LOAD           0x0
-- 
1.7.10

