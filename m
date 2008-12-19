From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/8] ACPI: make inactive table management configurable
Date: Fri, 19 Dec 2008 15:57:52 +0800
Message-ID: <1229673472.562.139.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26809 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbYLSH7U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Introduce a new option ACPI_INACTIVE_TABLE_MANAGEMENT,
which can be used to enable/disable the inactive table
management.
this is because Linux wants to enable it all the time,
but as a piece of ACPICA code, it's not needed by other OSes.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/tables/tbxface.c |    5 ++++-
 include/acpi/acconfig.h       |    4 ++++
 include/acpi/acglobal.h       |    2 ++
 include/acpi/acpixf.h         |   14 ++++++++++++++
 include/acpi/actables.h       |    4 ++++
 5 files changed, 28 insertions(+), 1 deletion(-)

Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -55,8 +55,13 @@ acpi_status
 acpi_initialize_tables(struct acpi_table_desc *initial_storage,
 		       u32 initial_table_count, u8 allow_resize);
 
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 acpi_status
 acpi_initialize_inactive_tables(void);
+#else
+static inline acpi_status
+acpi_initialize_inactive_tables(void) { return AE_NOT_FOUND; }
+#endif
 
 acpi_status __init acpi_initialize_subsystem(void);
 
@@ -122,9 +127,18 @@ acpi_status
 acpi_get_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
 
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 acpi_status
 acpi_get_inactive_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
+#else
+static inline acpi_status
+acpi_get_inactive_table_by_index(u32 table_index,
+			struct acpi_table_header **out_table)
+{
+	return AE_NOT_FOUND;
+}
+#endif
 
 acpi_status
 acpi_install_table_handler(acpi_tbl_handler handler, void *context);
Index: linux-2.6/drivers/acpi/tables/tbxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables/tbxface.c
+++ linux-2.6/drivers/acpi/tables/tbxface.c
@@ -154,7 +154,7 @@ acpi_initialize_tables(struct acpi_table
 	return_ACPI_STATUS(status);
 }
 
-
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 /*******************************************************************************
  *
  * FUNCTION:    acpi_initialize_inactive_tables
@@ -174,6 +174,7 @@ acpi_initialize_inactive_tables(void)
 		acpi_tb_parse_root_table(0, ACPI_TABLE_ORIGIN_INACTIVE));
 }
 ACPI_EXPORT_SYMBOL(acpi_initialize_inactive_tables)
+#endif
 
 /*******************************************************************************
  *
@@ -461,6 +462,7 @@ acpi_get_table_by_index(u32 table_index,
 }
 ACPI_EXPORT_SYMBOL(acpi_get_table_by_index)
 
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 /*******************************************************************************
  *
  * FUNCTION:	acpi_get_inactive_table_by_index
@@ -480,6 +482,7 @@ acpi_get_inactive_table_by_index(u32 tab
 	return acpi_tb_get_table_by_index(table_index, table, 0);
 }
 ACPI_EXPORT_SYMBOL(acpi_get_inactive_table_by_index)
+#endif
 
 /*******************************************************************************
  *
Index: linux-2.6/include/acpi/acconfig.h
===================================================================
--- linux-2.6.orig/include/acpi/acconfig.h
+++ linux-2.6/include/acpi/acconfig.h
@@ -123,6 +123,10 @@
 
 #define ACPI_MAX_LOOP_ITERATIONS        0xFFFF
 
+/* ACPI inactive table management */
+
+#define ACPI_INACTIVE_TABLE_MANAGEMENT
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
Index: linux-2.6/include/acpi/acglobal.h
===================================================================
--- linux-2.6.orig/include/acpi/acglobal.h
+++ linux-2.6/include/acpi/acglobal.h
@@ -139,7 +139,9 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  * acpi_gbl_FADT is a local copy of the FADT, converted to a common format.
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_inactive_root_table_list;
+#endif
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 extern u8 acpi_gbl_permanent_mmap;
Index: linux-2.6/include/acpi/actables.h
===================================================================
--- linux-2.6.orig/include/acpi/actables.h
+++ linux-2.6/include/acpi/actables.h
@@ -48,9 +48,13 @@ acpi_status acpi_allocate_root_table(u32
 
 #define TABLE_IS_ACTIVE(flag)   \
 	(!((flag & ACPI_TABLE_ORIGIN_MASK) == ACPI_TABLE_ORIGIN_INACTIVE))
+#ifdef ACPI_INACTIVE_TABLE_MANAGEMENT
 #define get_root_table_list(flag)       \
 	(TABLE_IS_ACTIVE(flag) ?        \
 	&acpi_gbl_root_table_list : &acpi_gbl_inactive_root_table_list)
+#else
+#define get_root_table_list(flag) (&acpi_gbl_root_table_list)
+#endif /* ACPI_INACTIVE_TABLE_MANAGEMENT */
 
 /*
  * tbfadt - FADT parse/convert/validate


