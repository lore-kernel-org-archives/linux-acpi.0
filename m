From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/15] ACPICA: Add new statistics interface.
Date: Thu, 31 Oct 2013 09:30:28 +0800
Message-ID: <00715cb8976e0340583e61a20f7c831ea0fbf480.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:04 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch decreases 133 lines of divergences.

This patch ports new counters and statistics interface to Linux as such
enhancement has already been implemented in ACPICA.  This patch can also
reduce the source code differences between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 ++
 drivers/acpi/acpica/dsmethod.c |    1 +
 drivers/acpi/acpica/evsci.c    |    1 +
 drivers/acpi/acpica/utglobal.c |   12 ++++++++++++
 drivers/acpi/acpica/utxface.c  |   38 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |    2 ++
 include/acpi/actypes.h         |   10 ++++++++++
 7 files changed, 66 insertions(+)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 0fba431..e9f1fc7 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -406,7 +406,9 @@ extern u32 acpi_gbl_nesting_level;
 
 /* Event counters */
 
+ACPI_EXTERN u32 acpi_method_count;
 ACPI_EXTERN u32 acpi_gpe_count;
+ACPI_EXTERN u32 acpi_sci_count;
 ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
 
 /* Support for dynamic control method tracing mechanism */
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index df3ea12..81a78ba 100644
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
index 94d9ebd..9e9e345 100644
--- a/drivers/acpi/acpica/evsci.c
+++ b/drivers/acpi/acpica/evsci.c
@@ -137,6 +137,7 @@ static u32 ACPI_SYSTEM_XFACE acpi_ev_sci_xrupt_handler(void *context)
 
 	interrupt_handled |= acpi_ev_sci_dispatch();
 
+	acpi_sci_count++;
 	return_UINT32(interrupt_handled);
 }
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 77caa4f..81f9a95 100644
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
 
 	/* GPE/SCI support */
@@ -383,4 +393,6 @@ ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
 
+ACPI_EXPORT_SYMBOL(acpi_gpe_count)
+
 ACPI_EXPORT_SYMBOL(acpi_current_gpe_count)
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 891a37b..3986902 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -208,6 +208,44 @@ acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
 
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
index b2dcab0..7def8ca 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -140,6 +140,8 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
 #endif
 
+acpi_status acpi_get_statistics(struct acpi_statistics *stats);
+
 const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 8614bc1..0e32b6c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -973,6 +973,16 @@ struct acpi_system_info {
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

