From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/20] ACPICA: Deploy ACPI_EXPORT_SYMBOL_INIT for main ACPICA initialization interfaces.
Date: Tue, 29 Oct 2013 09:30:10 +0800
Message-ID: <481a43b3fb2f83b2c0a4f64cab90b1b9308afd10.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36920 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2BaT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:19 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This changes can reduce source code differences between Linux and ACPICA
upstream to help improving the release automation.

The side effect of applying this patch in Linux is:
1. Some ACPICA initialization/termination APIs are no longer exported in
   Linux, these include:
    acpi_load_tables
    acpi_initialize_subsystem
    acpi_enable_subsystem
    acpi_initialize_objects
    acpi_terminate
2. This patch does not affect the following APIs as they are currently not
   marked with ACPI_EXPORT_SYMBOL in Linux:
    acpi_reallocate_root_table
    acpi_initialize_tables
Such functions should not be exported as they are internal to ACPI
subsystem in Linux, and will only be invoked inside of ACPI subsystem's
initialization routines marked with __init and termination routines marked
with __exit.  While on other OSPMs, such functions may still need to be
exported.

Thus this patch adds the configurability for ACPICA, so that it leaves
OSPMs to determine if the __init/__exit marked functions should be exported
or not.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbxface.c  |    7 ++++++-
 drivers/acpi/acpica/tbxfload.c |    2 +-
 drivers/acpi/acpica/utxface.c  |    2 +-
 drivers/acpi/acpica/utxfinit.c |    9 ++++++---
 include/acpi/actypes.h         |   13 +++++++++++--
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index bbaad5c..7e63090 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -148,6 +148,8 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_reallocate_root_table
@@ -182,6 +184,8 @@ acpi_status acpi_reallocate_root_table(void)
 	return_ACPI_STATUS(status);
 }
 
+ACPI_EXPORT_SYMBOL_INIT(acpi_reallocate_root_table)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_table_header
@@ -357,6 +361,7 @@ acpi_get_table_with_size(char *signature,
 
 	return (AE_NOT_FOUND);
 }
+
 ACPI_EXPORT_SYMBOL(acpi_get_table_with_size)
 
 acpi_status
@@ -368,6 +373,7 @@ acpi_get_table(char *signature,
 	return acpi_get_table_with_size(signature,
 		       instance, out_table, &tbl_size);
 }
+
 ACPI_EXPORT_SYMBOL(acpi_get_table)
 
 /*******************************************************************************
@@ -425,7 +431,6 @@ acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
 
 ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
 
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_table_handler
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 5a22024..b1e1edd 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -83,7 +83,7 @@ acpi_status acpi_load_tables(void)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_load_tables)
+ACPI_EXPORT_SYMBOL_INIT(acpi_load_tables)
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 2178da8..891a37b 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -105,7 +105,7 @@ acpi_status acpi_terminate(void)
 	return_ACPI_STATUS(status);
 }
 
-ACPI_EXPORT_SYMBOL(acpi_terminate)
+ACPI_EXPORT_SYMBOL_INIT(acpi_terminate)
 
 #ifndef ACPI_ASL_COMPILER
 #ifdef ACPI_FUTURE_USAGE
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index dda18e6..ff6f4d1 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -125,7 +125,8 @@ acpi_status acpi_initialize_subsystem(void)
 	ACPI_DEBUGGER_EXEC(status = acpi_db_initialize());
 	return_ACPI_STATUS(status);
 }
-ACPI_EXPORT_SYMBOL(acpi_initialize_subsystem)
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_subsystem)
 
 /*******************************************************************************
  *
@@ -229,7 +230,8 @@ acpi_status acpi_enable_subsystem(u32 flags)
 
 	return_ACPI_STATUS(status);
 }
-ACPI_EXPORT_SYMBOL(acpi_enable_subsystem)
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_enable_subsystem)
 
 /*******************************************************************************
  *
@@ -315,4 +317,5 @@ acpi_status acpi_initialize_objects(u32 flags)
 	acpi_gbl_startup_flags |= ACPI_INITIALIZED_OK;
 	return_ACPI_STATUS(status);
 }
-ACPI_EXPORT_SYMBOL(acpi_initialize_objects)
+
+ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_objects)
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 0bb23e6..8614bc1 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -299,9 +299,18 @@ typedef u32 acpi_physical_address;
 #endif
 
 /*
- * All ACPICA functions that are available to the rest of the kernel are
- * tagged with this macro which can be defined as appropriate for the host.
+ * All ACPICA external functions that are available to the rest of the kernel
+ * are tagged with thes macros which can be defined as appropriate for the host.
+ *
+ * Notes:
+ * ACPI_EXPORT_SYMBOL_INIT is used for initialization and termination
+ * interfaces that may need special processing.
+ * ACPI_EXPORT_SYMBOL is used for all other public external functions.
  */
+#ifndef ACPI_EXPORT_SYMBOL_INIT
+#define ACPI_EXPORT_SYMBOL_INIT(symbol)
+#endif
+
 #ifndef ACPI_EXPORT_SYMBOL
 #define ACPI_EXPORT_SYMBOL(symbol)
 #endif
-- 
1.7.10

