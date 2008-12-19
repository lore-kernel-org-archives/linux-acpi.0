From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/8] ACPI: introduce a new global root table list and some
	helper functions for inactive table management
Date: Fri, 19 Dec 2008 15:57:42 +0800
Message-ID: <1229673462.562.134.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56582 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbYLSH7K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Introduce acpi_gbl_inactive_root_table_list
and some helper functions.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/acpi/acglobal.h |    1 +
 include/acpi/aclocal.h  |    1 +
 include/acpi/actables.h |    6 ++++++
 3 files changed, 8 insertions(+)

Index: linux-2.6/include/acpi/acglobal.h
===================================================================
--- linux-2.6.orig/include/acpi/acglobal.h
+++ linux-2.6/include/acpi/acglobal.h
@@ -139,6 +139,7 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  * acpi_gbl_FADT is a local copy of the FADT, converted to a common format.
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
+ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_inactive_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 ACPI_EXTERN struct acpi_table_facs *acpi_gbl_FACS;
 extern u8 acpi_gbl_permanent_mmap;
Index: linux-2.6/include/acpi/aclocal.h
===================================================================
--- linux-2.6.orig/include/acpi/aclocal.h
+++ linux-2.6/include/acpi/aclocal.h
@@ -235,6 +235,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_ALLOCATED     (2)
 #define ACPI_TABLE_ORIGIN_MASK          (3)
 #define ACPI_TABLE_IS_LOADED            (4)
+#define ACPI_TABLE_ORIGIN_INACTIVE	ACPI_TABLE_ORIGIN_UNKNOWN
 
 /* One internal RSDT for table management */
 
Index: linux-2.6/include/acpi/actables.h
===================================================================
--- linux-2.6.orig/include/acpi/actables.h
+++ linux-2.6/include/acpi/actables.h
@@ -46,6 +46,12 @@
 
 acpi_status acpi_allocate_root_table(u32 initial_table_count);
 
+#define TABLE_IS_ACTIVE(flag)   \
+	(!((flag & ACPI_TABLE_ORIGIN_MASK) == ACPI_TABLE_ORIGIN_INACTIVE))
+#define get_root_table_list(flag)       \
+	(TABLE_IS_ACTIVE(flag) ?        \
+	&acpi_gbl_root_table_list : &acpi_gbl_inactive_root_table_list)
+
 /*
  * tbfadt - FADT parse/convert/validate
  */


