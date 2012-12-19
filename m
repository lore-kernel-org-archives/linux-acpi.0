From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 03/19] ACPICA: Update codes under disabled build options.
Date: Wed, 19 Dec 2012 13:37:03 +0800
Message-ID: <be32ef93b8a899b4b3b0172efd05bdfc4dea2849.1355810293.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20781 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2LSFhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:37:11 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 170 lines of 20121018 divergence.diff.

This patch updates ACPICA codes surrounded by some disabled build options
so that the source code diff between Linux and ACPICA can be reduced.

Some of these build options may never be used in the kernel, so they may
be deleted entirely in future patches.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -    2bbd:	ba be 00 00 00       	mov    $0xbe,%edx
  +    2bbd:	ba bf 00 00 00       	mov    $0xbf,%edx
  dswload.c(191): acpi_ds_load1_begin_op
  ACPI_ERROR_NAMESPACE -> AE_INFO -> __LINE__
  -    2c3d:	68 ff 00 00 00       	push   $0xff
  +    2c3d:	68 00 01 00 00       	push   $0x100
  dswload.c(256-4): acpi_ds_load1_begin_op
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    2d36:	ba 5f 01 00 00       	mov    $0x15f,%edx
  +    2d36:	ba 60 01 00 00       	mov    $0x160,%edx
  dswload.c(352): acpi_ds_load1_begin_op
  ACPI_ERROR_NAMESPACE -> AE_INFO -> __LINE__
---
Divergences fixing result:
  Before applying: 3120 Lines, 107.7 Kbytes
  After applying: 2950 Lines, 103.0 Kbytes
---
 drivers/acpi/acpica/acglobal.h |    2 ++
 drivers/acpi/acpica/aclocal.h  |   25 ++++++++++++++++++++++
 drivers/acpi/acpica/dsmethod.c |    2 +-
 drivers/acpi/acpica/dswload.c  |    5 +++--
 drivers/acpi/acpica/nssearch.c |    5 +++++
 drivers/acpi/acpica/utglobal.c |    4 ++++
 include/acpi/acoutput.h        |    1 +
 include/acpi/platform/acenv.h  |   45 +++++++++++++++++++++++++++++++---------
 8 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 64472e4..1ef7ca4 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -415,6 +415,8 @@ ACPI_EXTERN u8 acpi_gbl_db_output_flags;
 
 ACPI_EXTERN u8 acpi_gbl_db_opt_disasm;
 ACPI_EXTERN u8 acpi_gbl_db_opt_verbose;
+ACPI_EXTERN struct acpi_external_list *acpi_gbl_external_list;
+ACPI_EXTERN struct acpi_external_file *acpi_gbl_external_file_list;
 #endif
 
 #ifdef ACPI_DEBUGGER
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 3453ea6..50f8b97 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1029,6 +1029,31 @@ struct acpi_port_info {
 
 /*****************************************************************************
  *
+ * Disassembler
+ *
+ ****************************************************************************/
+
+struct acpi_external_list {
+	char *path;
+	char *internal_path;
+	struct acpi_external_list *next;
+	u32 value;
+	u16 length;
+	u8 type;
+	u8 flags;
+};
+
+/* Values for Flags field above */
+
+#define ACPI_IPATH_ALLOCATED    0x01
+
+struct acpi_external_file {
+	char *path;
+	struct acpi_external_file *next;
+};
+
+/*****************************************************************************
+ *
  * Debugger
  *
  ****************************************************************************/
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 52eb4e0..735c059 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -47,7 +47,7 @@
 #include "acinterp.h"
 #include "acnamesp.h"
 #ifdef	ACPI_DISASSEMBLER
-#include <acpi/acdisasm.h>
+#include "acdisasm.h"
 #endif
 
 #define _COMPONENT          ACPI_DISPATCHER
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 5575100..d290740 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -50,7 +50,7 @@
 #include "acnamesp.h"
 
 #ifdef ACPI_ASL_COMPILER
-#include <acpi/acdisasm.h>
+#include "acdisasm.h"
 #endif
 
 #define _COMPONENT          ACPI_DISPATCHER
@@ -178,7 +178,8 @@ acpi_ds_load1_begin_op(struct acpi_walk_state * walk_state,
 			 * Target of Scope() not found. Generate an External for it, and
 			 * insert the name into the namespace.
 			 */
-			acpi_dm_add_to_external_list(path, ACPI_TYPE_DEVICE, 0);
+			acpi_dm_add_to_external_list(op, path, ACPI_TYPE_DEVICE,
+						     0);
 			status =
 			    acpi_ns_lookup(walk_state->scope_info, path,
 					   object_type, ACPI_IMODE_LOAD_PASS1,
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 1d2d8ff..b7f4264 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -328,6 +328,11 @@ acpi_ns_search_and_enter(u32 target_name,
 		if ((status == AE_OK) && (flags & ACPI_NS_ERROR_IF_FOUND)) {
 			status = AE_ALREADY_EXISTS;
 		}
+#ifdef ACPI_ASL_COMPILER
+		if (*return_node && (*return_node)->type == ACPI_TYPE_ANY) {
+			(*return_node)->flags |= ANOBJ_IS_EXTERNAL;
+		}
+#endif
 
 		/* Either found it or there was an error: finished either way */
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index d7919a3..4080088 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -357,6 +357,10 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_root_node_struct.peer = NULL;
 	acpi_gbl_root_node_struct.object = NULL;
 
+#ifdef ACPI_DISASSEMBLER
+	acpi_gbl_external_list = NULL;
+#endif
+
 #ifdef ACPI_DEBUG_OUTPUT
 	acpi_gbl_lowest_stack_pointer = ACPI_CAST_PTR(acpi_size, ACPI_SIZE_MAX);
 #endif
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 2457ac8..38e1be0 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -72,6 +72,7 @@
 #define ACPI_EXAMPLE                0x00004000
 #define ACPI_DRIVER                 0x00008000
 #define DT_COMPILER                 0x00010000
+#define ASL_PREPROCESSOR            0x00020000
 
 #define ACPI_ALL_COMPONENTS         0x0001FFFF
 #define ACPI_COMPONENT_DEFAULT      (ACPI_ALL_COMPONENTS)
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 68a58a1..13ac538 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -65,32 +65,57 @@
  *
  *****************************************************************************/
 
-/* Linkable ACPICA library */
-#ifdef ACPI_LIBRARY
-#define ACPI_USE_LOCAL_CACHE
-#endif
-
 /* iASL configuration */
 #ifdef ACPI_ASL_COMPILER
-#define ACPI_DEBUG_OUTPUT
 #define ACPI_APPLICATION
 #define ACPI_DISASSEMBLER
+#define ACPI_DEBUG_OUTPUT
 #define ACPI_CONSTANT_EVAL_ONLY
 #define ACPI_LARGE_NAMESPACE_NODE
 #define ACPI_DATA_TABLE_DISASSEMBLY
+#define ACPI_SINGLE_THREADED
 #endif
 
 /* acpi_exec configuration. Multithreaded with full AML debugger */
 #ifdef ACPI_EXEC_APP
-#undef DEBUGGER_THREADING
-#define DEBUGGER_THREADING      DEBUGGER_SINGLE_THREADED
-#define ACPI_FULL_DEBUG
 #define ACPI_APPLICATION
-#define ACPI_DEBUGGER
+#define ACPI_FULL_DEBUG
 #define ACPI_MUTEX_DEBUG
 #define ACPI_DBG_TRACK_ALLOCATIONS
 #endif
 
+/* acpi_names configuration. Single threaded with debugger output enabled. */
+
+#ifdef ACPI_NAMES_APP
+#define ACPI_DEBUGGER
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#endif
+
+/*
+ * acpi_bin/acpi_help/acpi_src configuration. All single threaded, with
+ * no debug output.
+ */
+#if (defined ACPI_BIN_APP)   || \
+	(defined ACPI_SRC_APP)   || \
+	(defined ACPI_XTRACT_APP)
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#endif
+
+#ifdef ACPI_HELP_APP
+#define ACPI_APPLICATION
+#define ACPI_SINGLE_THREADED
+#define ACPI_NO_ERROR_MESSAGES
+#endif
+
+/* Linkable ACPICA library */
+
+#ifdef ACPI_LIBRARY
+#define ACPI_USE_LOCAL_CACHE
+#define ACPI_FUTURE_USAGE
+#endif
+
 /* Common for all ACPICA applications */
 #ifdef ACPI_APPLICATION
 #define ACPI_USE_SYSTEM_CLIBRARY
-- 
1.7.10

