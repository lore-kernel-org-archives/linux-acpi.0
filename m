From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: Fixes code maintenance divergences.
Date: Wed, 21 Nov 2012 18:07:25 +0800
Message-ID: <b09f6d938fbc8f6b3b6904d770c17e8f797913b4.1353491653.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59486 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab2KUKHa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 05:07:30 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch fixes divergences caused by the simple code maintenance work:
1. Deletion of the unused include files.
2. Changing of the codes positions.
3. Replacing the values with the well defined macros.

Given the fact that Linux will not enable the following compilation macros:
1. ACPI_DEBUGGER
2. ACPI_REDUCED_HARDWARE
This patch will not affect the generated vmlinux binary.

This will decrease 270 lines of 20121018 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/accommon.h |    1 +
 drivers/acpi/acpica/acglobal.h |   33 +++++++++++++++++----------------
 drivers/acpi/acpica/amlresrc.h |    6 ++++++
 drivers/acpi/acpica/dsobject.c |    2 +-
 drivers/acpi/acpica/evgpe.c    |    2 +-
 drivers/acpi/acpica/hwregs.c   |    1 -
 drivers/acpi/acpica/hwsleep.c  |    3 ++-
 drivers/acpi/acpica/nsdumpdv.c |    1 -
 drivers/acpi/acpica/nsutils.c  |    1 -
 drivers/acpi/acpica/tbutils.c  |    4 ----
 drivers/acpi/acpica/utglobal.c |    3 ++-
 drivers/acpi/acpica/utmisc.c   |    8 ++++----
 drivers/acpi/acpica/utxface.c  |    4 ----
 include/acpi/acpiosxf.h        |    5 +++--
 include/acpi/acpixf.h          |   36 +++++++++++++++++-------------------
 15 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 8a7d51b..8632d71 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -51,6 +51,7 @@
  *
  * Note: The order of these include files is important.
  */
+#include <acpi/acconfig.h>	/* Global configuration constants */
 #include "acmacros.h"		/* C macros */
 #include "aclocal.h"		/* Internal data types */
 #include "acobject.h"		/* ACPI internal object */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 1ef7ca4..864806e 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -192,14 +192,6 @@ ACPI_EXTERN u8 acpi_gbl_integer_bit_width;
 ACPI_EXTERN u8 acpi_gbl_integer_byte_width;
 ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
 
-/* Mutex for _OSI support */
-
-ACPI_EXTERN acpi_mutex acpi_gbl_osi_mutex;
-
-/* Reader/Writer lock is used for namespace walk and dynamic table unload */
-
-ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
-
 /*****************************************************************************
  *
  * Mutual exclusion within ACPICA subsystem
@@ -233,6 +225,14 @@ ACPI_EXTERN u8 acpi_gbl_global_lock_pending;
 ACPI_EXTERN acpi_spinlock acpi_gbl_gpe_lock;	/* For GPE data structs and registers */
 ACPI_EXTERN acpi_spinlock acpi_gbl_hardware_lock;	/* For ACPI H/W except GPE registers */
 
+/* Mutex for _OSI support */
+
+ACPI_EXTERN acpi_mutex acpi_gbl_osi_mutex;
+
+/* Reader/Writer lock is used for namespace walk and dynamic table unload */
+
+ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
+
 /*****************************************************************************
  *
  * Miscellaneous globals
@@ -304,6 +304,7 @@ extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 ACPI_EXTERN struct acpi_memory_list *acpi_gbl_global_list;
 ACPI_EXTERN struct acpi_memory_list *acpi_gbl_ns_node_list;
 ACPI_EXTERN u8 acpi_gbl_display_final_mem_stats;
+ACPI_EXTERN u8 acpi_gbl_disable_mem_tracking;
 #endif
 
 /*****************************************************************************
@@ -365,19 +366,18 @@ ACPI_EXTERN u8 acpi_gbl_sleep_type_b;
  *
  ****************************************************************************/
 
-extern struct acpi_fixed_event_info
-    acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS];
-ACPI_EXTERN struct acpi_fixed_event_handler
-    acpi_gbl_fixed_event_handlers[ACPI_NUM_FIXED_EVENTS];
-ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
-ACPI_EXTERN struct acpi_gpe_block_info
-*acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
-
 #if (!ACPI_REDUCED_HARDWARE)
 
 ACPI_EXTERN u8 acpi_gbl_all_gpes_initialized;
+ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
+ACPI_EXTERN struct acpi_gpe_block_info
+    *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
 ACPI_EXTERN acpi_gbl_event_handler acpi_gbl_global_event_handler;
 ACPI_EXTERN void *acpi_gbl_global_event_handler_context;
+ACPI_EXTERN struct acpi_fixed_event_handler
+    acpi_gbl_fixed_event_handlers[ACPI_NUM_FIXED_EVENTS];
+extern struct acpi_fixed_event_info
+    acpi_gbl_fixed_event_info[ACPI_NUM_FIXED_EVENTS];
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
@@ -428,6 +428,7 @@ extern u8 acpi_gbl_db_terminate_threads;
 ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
 ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
 ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
+ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
 
 ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
 ACPI_EXTERN acpi_object_type acpi_gbl_db_arg_types[ACPI_DEBUGGER_MAX_ARGS];
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 9684496..bdbb7d0 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -199,6 +199,12 @@ struct aml_resource_fixed_dma {
 struct aml_resource_large_header {
 AML_RESOURCE_LARGE_HEADER_COMMON};
 
+/* General Flags for address space resource descriptors */
+
+#define ACPI_RESOURCE_FLAG_DEC      2
+#define ACPI_RESOURCE_FLAG_MIF      4
+#define ACPI_RESOURCE_FLAG_MAF      8
+
 struct aml_resource_memory24 {
 	AML_RESOURCE_LARGE_HEADER_COMMON u8 flags;
 	u16 minimum;
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index c9f15d3..13844a1 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -388,7 +388,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	union acpi_parse_object *parent;
 	union acpi_operand_object *obj_desc = NULL;
 	acpi_status status = AE_OK;
-	unsigned i;
+	u32 i;
 	u16 index;
 	u16 reference_count;
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index a137ce81..4cbb600 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -765,7 +765,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 					 gpe_event_info);
 		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, status,
-					"Unable to queue handler for GPE%2X - event disabled",
+					"Unable to queue handler for GPE%02X - event disabled",
 					gpe_number));
 		}
 		break;
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 83f73cf..fd4e2dc 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -44,7 +44,6 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "acnamesp.h"
 #include "acevents.h"
 
 #define _COMPONENT          ACPI_HARDWARE
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 3fddde0..11a2951 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -323,7 +323,8 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 	 * and use it to determine whether the system is rebooting or
 	 * resuming. Clear WAK_STS for compatibility.
 	 */
-	acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
+	(void)acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS,
+				      ACPI_CLEAR_STATUS);
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 944d4c8..4ae9360 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -42,7 +42,6 @@
  */
 
 #include <acpi/acpi.h>
-#include "accommon.h"
 
 /* TBD: This entire module is apparently obsolete and should be removed */
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 7bfaa6f..7e8bd2a 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -46,7 +46,6 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "amlcode.h"
-#include "actables.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsutils")
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 285e24b..b4469a6 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -384,10 +384,6 @@ void acpi_tb_check_dsdt_header(void)
 		acpi_tb_print_table_header(0, &acpi_gbl_original_dsdt_header);
 		acpi_tb_print_table_header(0, acpi_gbl_DSDT);
 
-		ACPI_ERROR((AE_INFO,
-			    "Please send DMI info to linux-acpi@vger.kernel.org\n"
-			    "If system does not work as expected, please boot with acpi=copy_dsdt"));
-
 		/* Disable further error messages */
 
 		acpi_gbl_original_dsdt_header.length = acpi_gbl_DSDT->length;
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index c083611..7b4dd21 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -293,11 +293,11 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* GPE support */
 
+	acpi_gbl_all_gpes_initialized = FALSE;
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
 	acpi_current_gpe_count = 0;
-	acpi_gbl_all_gpes_initialized = FALSE;
 
 	acpi_gbl_global_event_handler = NULL;
 
@@ -367,6 +367,7 @@ acpi_status acpi_ut_init_globals(void)
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 	acpi_gbl_display_final_mem_stats = FALSE;
+	acpi_gbl_disable_mem_tracking = FALSE;
 #endif
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 9286a69..2881992 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -748,12 +748,12 @@ void acpi_ut_repair_name(char *name)
 
 		if (!acpi_gbl_enable_interpreter_slack) {
 			ACPI_WARNING((AE_INFO,
-				      "Found bad character(s) in name, repaired: [%4.4s]\n",
-				      name));
+				      "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",
+					  original_name, name));
 		} else {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Found bad character(s) in name, repaired: [%4.4s]\n",
-					  name));
+					  "Invalid character(s) in name (0x%.8X), repaired: [%4.4s]",
+					  original_name, name));
 		}
 	}
 }
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 390db0c..cb85a7b 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -44,11 +44,7 @@
 #include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "acevents.h"
-#include "acnamesp.h"
 #include "acdebug.h"
-#include "actables.h"
-#include "acinterp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 7d0895b..6a44a38 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -178,12 +178,13 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object);
  * Interrupt handlers
  */
 acpi_status
-acpi_os_install_interrupt_handler(u32 gsi,
+acpi_os_install_interrupt_handler(u32 interrupt_number,
 				  acpi_osd_handler service_routine,
 				  void *context);
 
 acpi_status
-acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
+acpi_os_remove_interrupt_handler(u32 interrupt_number,
+				 acpi_osd_handler service_routine);
 
 void acpi_os_gpe_count(u32 gpe_number);
 void acpi_os_fixed_event_count(u32 fixed_event_number);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d8ec35b..e0c7303 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -58,6 +58,10 @@ extern u8 acpi_gbl_permanent_mmap;
 /*
  * Globals that are publically available
  */
+extern u32 acpi_current_gpe_count;
+extern struct acpi_table_fadt acpi_gbl_FADT;
+extern u8 acpi_gbl_system_awake_and_running;
+extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
 
 /* Runtime configuration of debug print levels */
 
@@ -104,11 +108,6 @@ extern u8 acpi_gbl_disable_auto_repair;
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
-extern u32 acpi_current_gpe_count;
-extern struct acpi_table_fadt acpi_gbl_FADT;
-extern u8 acpi_gbl_system_awake_and_running;
-extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
-
 extern u32 acpi_rsdt_forced;
 /*
  * Initialization
@@ -469,6 +468,10 @@ acpi_buffer_to_resource(u8 *aml_buffer,
  */
 acpi_status acpi_reset(void);
 
+acpi_status acpi_read(u64 *value, struct acpi_generic_address *reg);
+
+acpi_status acpi_write(u64 value, struct acpi_generic_address *reg);
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_read_bit_register(u32 register_id,
 						       u32 *return_value))
@@ -477,20 +480,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_write_bit_register(u32 register_id,
 							u32 value))
 
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vector(u32
-								physical_address))
-
-#if ACPI_MACHINE_WIDTH == 64
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				acpi_set_firmware_waking_vector64(u64
-								  physical_address))
-#endif
-
-acpi_status acpi_read(u64 *value, struct acpi_generic_address *reg);
-
-acpi_status acpi_write(u64 value, struct acpi_generic_address *reg);
-
 /*
  * Sleep/Wake interfaces
  */
@@ -507,6 +496,15 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_set_firmware_waking_vector(u32
+								physical_address))
+
+#if ACPI_MACHINE_WIDTH == 64
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_set_firmware_waking_vector64(u64
+								  physical_address))
+#endif
 /*
  * ACPI Timer interfaces
  */
-- 
1.7.10

