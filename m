From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/26] ACPICA: Fix AcpiSrc caused divergences.
Date: Wed, 31 Oct 2012 10:25:36 +0800
Message-ID: <cd02a09641c29069fe301b12ebe9bc22024afc04.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53963 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755343Ab2JaCgF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:36:05 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

There are definitions that can been converted into new styles by
the recent AcpiSrc while they remain the old styles in the Linux.
This patch fixes those definitions that will be converted by the
AcpiSrc.

This patch will not affect the generated vmlinux binary.
This will decrease 97 lines of 20120913 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/aclocal.h  |    4 ++--
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/dswexec.c  |    2 +-
 drivers/acpi/acpica/evxface.c  |    2 +-
 drivers/acpi/sysfs.c           |    4 ++--
 include/acpi/acpixf.h          |    2 +-
 include/acpi/actypes.h         |    8 ++++----
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index fe20e18..35006d1 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -376,7 +376,7 @@ ACPI_EXTERN struct acpi_gpe_block_info
 #if (!ACPI_REDUCED_HARDWARE)
 
 ACPI_EXTERN u8 acpi_gbl_all_gpes_initialized;
-ACPI_EXTERN ACPI_GBL_EVENT_HANDLER acpi_gbl_global_event_handler;
+ACPI_EXTERN acpi_gbl_event_handler acpi_gbl_global_event_handler;
 ACPI_EXTERN void *acpi_gbl_global_event_handler_context;
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index b5a4651..564f2ab 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -262,7 +262,7 @@ struct acpi_create_field_info {
 };
 
 typedef
-acpi_status(*ACPI_INTERNAL_METHOD) (struct acpi_walk_state * walk_state);
+acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
 
 /*
  * Bitmapped ACPI types.  Used internally only
@@ -645,7 +645,7 @@ union acpi_generic_state {
  *
  ****************************************************************************/
 
-typedef acpi_status(*ACPI_EXECUTE_OP) (struct acpi_walk_state * walk_state);
+typedef acpi_status(*acpi_execute_op) (struct acpi_walk_state * walk_state);
 
 /* Address Range info block */
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 364a130..ac4269f 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -179,7 +179,7 @@ struct acpi_object_method {
 	union acpi_operand_object *mutex;
 	u8 *aml_start;
 	union {
-		ACPI_INTERNAL_METHOD implementation;
+		acpi_internal_method implementation;
 		union acpi_operand_object *handler;
 	} dispatch;
 
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 642f3c0..fa44609 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -57,7 +57,7 @@ ACPI_MODULE_NAME("dswexec")
 /*
  * Dispatch table for opcode classes
  */
-static ACPI_EXECUTE_OP acpi_gbl_op_type_dispatch[] = {
+static acpi_execute_op acpi_gbl_op_type_dispatch[] = {
 	acpi_ex_opcode_0A_0T_1R,
 	acpi_ex_opcode_1A_0T_0R,
 	acpi_ex_opcode_1A_0T_1R,
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 7587eb6..ae668f3 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -398,7 +398,7 @@ ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
  *
  ******************************************************************************/
 acpi_status
-acpi_install_global_event_handler(ACPI_GBL_EVENT_HANDLER handler, void *context)
+acpi_install_global_event_handler(acpi_gbl_event_handler handler, void *context)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 7c3f98b..ea61ca9 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -476,7 +476,7 @@ static void fixed_event_count(u32 event_number)
 	return;
 }
 
-static void acpi_gbl_event_handler(u32 event_type, acpi_handle device,
+static void acpi_global_event_handler(u32 event_type, acpi_handle device,
 	u32 event_number, void *context)
 {
 	if (event_type == ACPI_EVENT_TYPE_GPE)
@@ -638,7 +638,7 @@ void acpi_irq_stats_init(void)
 	if (all_counters == NULL)
 		goto fail;
 
-	status = acpi_install_global_event_handler(acpi_gbl_event_handler, NULL);
+	status = acpi_install_global_event_handler(acpi_global_event_handler, NULL);
 	if (ACPI_FAILURE(status))
 		goto fail;
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8b891db..352fd1a 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -274,7 +274,7 @@ acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_install_global_event_handler
-				(ACPI_GBL_EVENT_HANDLER handler, void *context))
+				(acpi_gbl_event_handler handler, void *context))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_install_fixed_event_handler(u32
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 7520f42..ea50a31 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -796,11 +796,11 @@ typedef u8 acpi_adr_space_type;
 
 /* Sleep function dispatch */
 
-typedef acpi_status(*ACPI_SLEEP_FUNCTION) (u8 sleep_state);
+typedef acpi_status(*acpi_sleep_function) (u8 sleep_state);
 
 struct acpi_sleep_functions {
-	ACPI_SLEEP_FUNCTION legacy_function;
-	ACPI_SLEEP_FUNCTION extended_function;
+	acpi_sleep_function legacy_function;
+	acpi_sleep_function extended_function;
 };
 
 /*
@@ -931,7 +931,7 @@ typedef void
  * Various handlers and callback procedures
  */
 typedef
-void (*ACPI_GBL_EVENT_HANDLER) (u32 event_type,
+void (*acpi_gbl_event_handler) (u32 event_type,
 			       acpi_handle device,
 			       u32 event_number, void *context);
 
-- 
1.7.10

