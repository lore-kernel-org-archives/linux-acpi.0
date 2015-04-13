From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 28/31] ACPICA: iASL: Add support for MSDM ACPI table.
Date: Mon, 13 Apr 2015 11:51:08 +0800
Message-ID: <08c2b64c45ec7f3770b044b012bf24c3a605cee7.1428893939.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a2c590ce9bff850e3abf4fd430cede860a3cb1fa

This is the Microsoft Data Management table.

MSDM table is not used in the Linux kernel.

Link: https://github.com/acpica/acpica/commit/a2c590ce
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index df729bf..e3ab1ff 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -73,6 +73,7 @@
 #define ACPI_SIG_LPIT           "LPIT"	/* Low Power Idle Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
+#define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_MTMR           "MTMR"	/* MID Timer table */
 #define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
@@ -935,6 +936,21 @@ struct acpi_table_mchi {
 
 /*******************************************************************************
  *
+ * MSDM - Microsoft Data Management table
+ *
+ * Conforms to "Microsoft Software Licensing Tables (SLIC and MSDM)",
+ * November 29, 2011. Copyright 2011 Microsoft
+ *
+ ******************************************************************************/
+
+/* Basic MSDM table is only the common ACPI header */
+
+struct acpi_table_msdm {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/*******************************************************************************
+ *
  * MTMR - MID Timer Table
  *        Version 1
  *
@@ -961,8 +977,7 @@ struct acpi_mtmr_entry {
  * SLIC - Software Licensing Description Table
  *
  * Conforms to "Microsoft Software Licensing Tables (SLIC and MSDM)",
- * November 29, 2011
- * Copyright 2011 Microsoft
+ * November 29, 2011. Copyright 2011 Microsoft
  *
  ******************************************************************************/
 
-- 
1.7.10
