From: Lv Zheng <lv.zheng@intel.com>
Subject: [RESEND PATCH v2 04/19] ACPICA: Cleanup source to reduce differences between Linux and ACPICA.
Date: Thu, 20 Dec 2012 09:07:26 +0800
Message-ID: <cdf844c30485051eca60eae5d76486f4c377e5ed.1355810293.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:23540 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab2LTBHi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 20:07:38 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 389 lines of 20121018 divergence.diff.

This patch reduces source code diff caused by the simple code maintenance
work:
1. Deletion of the unused include files.
2. Deletion of the deprecated codes blocks.
3. Repositioning of the code blocks.
4. Replacing the values with the well defined macros.
5. Replacing the types with the equivalent types.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -    c109:	6a 6d                	push   $0x6d
  +    c109:	6a 6c                	push   $0x6c
  hwregs.c(108-1): acpi_hw_validate_register
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    c13c:	6a 78                	push   $0x78
  +    c13c:	6a 77                	push   $0x77
  hwregs.c(119-2): acpi_hw_validate_register
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    c15d:	68 81 00 00 00       	push   $0x81
  +    c15d:	68 80 00 00 00       	push   $0x80
  hwregs.c(128-2): acpi_hw_validate_register
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    c28f:	68 37 01 00 00       	push   $0x137
  +    c28f:	68 36 01 00 00       	push   $0x136
  hwregs.c(310-1): acpi_hw_get_bit_register_info
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    c35b:	68 a8 01 00 00       	push   $0x1a8
  +    c35b:	68 a7 01 00 00       	push   $0x1a7
  hwregs.c(423): acpi_hw_register_read
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    c440:	68 30 02 00 00       	push   $0x230
  +    c440:	68 2f 02 00 00       	push   $0x22f
  hwregs.c(559): acpi_hw_register_write
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    d962:	68 5d 01 00 00       	push   $0x15d
  +    d962:	68 5c 01 00 00       	push   $0x15c
  nsinit.c(348-3): acpi_ns_init_one_object
  ACPI_EXCEPTION -> AE_INFO -> __LINE__
  -    da02:	6a 66                	push   $0x66
  +    da02:	6a 65                	push   $0x65
  nsinit.c(101): acpi_ns_initialize_objects
  ACPI_EXCEPTION -> AE_INFO -> __LINE__
  -    db03:	68 da 00 00 00       	push   $0xda
  +    db03:	68 d9 00 00 00       	push   $0xd9
  nsinit.c(217): acpi_ns_initialize_devices
  ACPI_EXCEPTION -> AE_INFO -> __LINE__
  -    f151:	68 99 00 00 00       	push   $0x99
  +    f151:	68 98 00 00 00       	push   $0x98
  nsutils.c(152): acpi_ns_get_type
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    f17d:	68 b5 00 00 00       	push   $0xb5
  +    f17d:	68 b4 00 00 00       	push   $0xb4
  nsutils.c(180): acpi_ns_local
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    f3f8:	68 19 02 00 00       	push   $0x219
  +    f3f8:	68 18 02 00 00       	push   $0x218
  nsutils.c(536): acpi_ns_externalize_name
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    f532:	68 a1 02 00 00       	push   $0x2a1
  +    f532:	68 a0 02 00 00       	push   $0x2a0
  nsutils.c(672): acpi_ns_opens_scope
  ACPI_WARNING -> AE_INFO -> __LINE__
  -   178f6:	6a 4c                	push   $0x4c
  +   178f6:	6a 48                	push   $0x48
  utxface.c(72): acpi_terminate
  ACPI_ERROR -> AE_INFO -> __LINE__
---
Divergences fixing result:
  Before applying: 2950 Lines, 103.0 Kbytes
  After applying: 2561 Lines, 90.4 Kbytes
---
 drivers/acpi/acpica/accommon.h  |    1 +
 drivers/acpi/acpica/acglobal.h  |   33 +++++++++++++++---------------
 drivers/acpi/acpica/aclocal.h   |    5 -----
 drivers/acpi/acpica/amlresrc.h  |    6 ++++++
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/exregion.c  |    2 +-
 drivers/acpi/acpica/hwregs.c    |    1 -
 drivers/acpi/acpica/hwsleep.c   |    4 ++--
 drivers/acpi/acpica/hwxfsleep.c |    2 +-
 drivers/acpi/acpica/nsdumpdv.c  |    1 -
 drivers/acpi/acpica/nsinit.c    |    1 -
 drivers/acpi/acpica/nsutils.c   |    1 -
 drivers/acpi/acpica/nsxfeval.c  |    8 +++++---
 drivers/acpi/acpica/tbxface.c   |    1 -
 drivers/acpi/acpica/utxface.c   |    4 ----
 include/acpi/acconfig.h         |   22 --------------------
 include/acpi/acpiosxf.h         |    7 +++++--
 include/acpi/acpixf.h           |   43 ++++++++++++++++++---------------------
 include/acpi/actbl.h            |    6 ++++--
 include/acpi/actypes.h          |    5 +++++
 include/acpi/platform/acenv.h   |    2 --
 21 files changed, 68 insertions(+), 89 deletions(-)

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
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 50f8b97..421b048 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -410,11 +410,6 @@ struct acpi_gpe_notify_info {
 	struct acpi_gpe_notify_info *next;
 };
 
-struct acpi_gpe_notify_object {
-	struct acpi_namespace_node *node;
-	struct acpi_gpe_notify_object *next;
-};
-
 /*
  * GPE dispatch info. At any time, the GPE can have at most one type
  * of dispatch - Method, Handler, or Implicit Notify.
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
 
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 0a01e19..044d441 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -163,7 +163,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		page_boundary_map_length =
 		    ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address;
 
-		if (!page_boundary_map_length) {
+		if (page_boundary_map_length == 0) {
 			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
 		}
 
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 165395f..e782b5a 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -44,7 +44,6 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "acnamesp.h"
 #include "acevents.h"
 
 #define _COMPONENT          ACPI_HARDWARE
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 3fddde0..691a5fb 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -45,7 +45,6 @@
 #include <acpi/acpi.h>
 #include <linux/acpi.h>
 #include "accommon.h"
-#include <linux/module.h>
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
@@ -323,7 +322,8 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 	 * and use it to determine whether the system is rebooting or
 	 * resuming. Clear WAK_STS for compatibility.
 	 */
-	acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
+	(void)acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS,
+				      ACPI_CLEAR_STATUS);
 	acpi_gbl_system_awake_and_running = TRUE;
 
 	/* Enable power button */
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 2898011..6fcee00 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -41,9 +41,9 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include <linux/module.h>
 
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwxfsleep")
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 944d4c8..4ae9360 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -42,7 +42,6 @@
  */
 
 #include <acpi/acpi.h>
-#include "accommon.h"
 
 /* TBD: This entire module is apparently obsolete and should be removed */
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index bb6888f..94c1500 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -46,7 +46,6 @@
 #include "acnamesp.h"
 #include "acdispat.h"
 #include "acinterp.h"
-#include <linux/nmi.h>
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsinit")
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index b5b4cb7..479aad0 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -46,7 +46,6 @@
 #include "accommon.h"
 #include "acnamesp.h"
 #include "amlcode.h"
-#include "actables.h"
 
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsutils")
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 70bbc1f..5c05ba3 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -602,18 +602,20 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
 			/* Walk the CID list */
 
-			found = 0;
+			found = FALSE;
 			for (i = 0; i < cid->count; i++) {
 				if (ACPI_STRCMP(cid->ids[i].string, info->hid)
 				    == 0) {
 					/* Found a matching CID */
-					found = 1;
+					found = TRUE;
 					break;
 				}
 			}
+
 			ACPI_FREE(cid);
-			if (!found)
+			if (!found) {
 				return (AE_OK);
+			}
 		}
 	}
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index f563278..d102fe7 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -44,7 +44,6 @@
 #include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "acnamesp.h"
 #include "actables.h"
 
 #define _COMPONENT          ACPI_TABLES
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
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 358258a..12a5996 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -150,11 +150,6 @@
  *
  *****************************************************************************/
 
-/* Number of distinct GPE register blocks and register width */
-
-#define ACPI_MAX_GPE_BLOCKS             2
-#define ACPI_GPE_REGISTER_WIDTH         8
-
 /* Method info (in WALK_STATE), containing local variables and argumetns */
 
 #define ACPI_METHOD_NUM_LOCALS          8
@@ -163,12 +158,6 @@
 #define ACPI_METHOD_NUM_ARGS            7
 #define ACPI_METHOD_MAX_ARG             6
 
-/* Length of _HID, _UID, _CID, and UUID values */
-
-#define ACPI_DEVICE_ID_LENGTH           0x09
-#define ACPI_MAX_CID_LENGTH             48
-#define ACPI_UUID_LENGTH                16
-
 /*
  * Operand Stack (in WALK_STATE), Must be large enough to contain METHOD_MAX_ARG
  */
@@ -186,17 +175,6 @@
  */
 #define ACPI_RESULTS_OBJ_NUM_MAX        255
 
-/* Names within the namespace are 4 bytes long */
-
-#define ACPI_NAME_SIZE                  4
-#define ACPI_PATH_SEGMENT_LENGTH        5	/* 4 chars for name + 1 char for separator */
-#define ACPI_PATH_SEPARATOR             '.'
-
-/* Sizes for ACPI table headers */
-
-#define ACPI_OEM_ID_SIZE                6
-#define ACPI_OEM_TABLE_ID_SIZE          8
-
 /* Constants used in searching for the RSDP in low memory */
 
 #define ACPI_EBDA_PTR_LOCATION          0x0000040E	/* Physical Address */
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 4315274..33a3e17 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -148,6 +148,8 @@ void acpi_os_release_mutex(acpi_mutex handle);
  */
 void *acpi_os_allocate(acpi_size size);
 
+void acpi_os_free(void *memory);
+
 void __iomem *acpi_os_map_memory(acpi_physical_address where,
 				acpi_size length);
 
@@ -180,12 +182,13 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object);
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
index defbcaa..b409406 100644
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
 extern u32 acpi_dbg_level;
 extern u32 acpi_dbg_layer;
@@ -100,11 +104,6 @@ extern u8 acpi_gbl_disable_auto_repair;
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
-extern u32 acpi_current_gpe_count;
-extern struct acpi_table_fadt acpi_gbl_FADT;
-extern u8 acpi_gbl_system_awake_and_running;
-extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
-
 extern u32 acpi_rsdt_forced;
 /*
  * Initialization
@@ -121,15 +120,14 @@ acpi_status acpi_initialize_objects(u32 flags);
 
 acpi_status acpi_terminate(void);
 
-#ifdef ACPI_FUTURE_USAGE
-acpi_status acpi_subsystem_status(void);
-#endif
-
 /*
  * Miscellaneous global interfaces
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
+#ifdef ACPI_FUTURE_USAGE
+acpi_status acpi_subsystem_status(void);
+#endif
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
@@ -466,6 +464,10 @@ acpi_buffer_to_resource(u8 *aml_buffer,
  */
 acpi_status acpi_reset(void);
 
+acpi_status acpi_read(u64 *value, struct acpi_generic_address *reg);
+
+acpi_status acpi_write(u64 value, struct acpi_generic_address *reg);
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_read_bit_register(u32 register_id,
 						       u32 *return_value))
@@ -474,20 +476,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
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
@@ -504,6 +492,15 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
 
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
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 4f94b1d..c0e6c32 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -326,8 +326,6 @@ enum acpi_preferred_pm_profiles {
 
 #pragma pack()
 
-#define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
-
 /*
  * Internal table-related structures
  */
@@ -364,6 +362,10 @@ struct acpi_table_desc {
 #include <acpi/actbl2.h>
 #include <acpi/actbl3.h>
 
+/* Macros used to generate offsets to specific table fields */
+
+#define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
+
 /*
  * Sizes of the various flavors of FADT. We need to look closely
  * at the FADT length because the version number essentially tells
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 35d4dea0..6882227 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -474,6 +474,7 @@ typedef u64 acpi_integer;
  */
 #define ACPI_FULL_INITIALIZATION        0x00
 #define ACPI_NO_ADDRESS_SPACE_INIT      0x01
+#define ACPI_NO_HARDWARE_INIT           0x02
 #define ACPI_NO_EVENT_INIT              0x04
 #define ACPI_NO_HANDLER_INIT            0x08
 #define ACPI_NO_ACPI_ENABLE             0x10
@@ -970,6 +971,10 @@ acpi_status(*acpi_exception_handler) (acpi_status aml_status,
 typedef
 acpi_status(*acpi_tbl_handler) (u32 event, void *table, void *context);
 
+#define ACPI_TABLE_LOAD             0x0
+#define ACPI_TABLE_UNLOAD           0x1
+#define ACPI_NUM_TABLE_EVENTS       2
+
 /* Address Spaces (For Operation Regions) */
 
 typedef
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 13ac538..cec6cd3 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -277,8 +277,6 @@
  *
  *****************************************************************************/
 
-#define ACPI_IS_ASCII(c)  ((c) < 0x80)
-
 /*
  * ACPI_USE_SYSTEM_CLIBRARY - Define this if linking to an actual C library.
  *      Otherwise, local versions of string/memory functions will be used.
-- 
1.7.10

