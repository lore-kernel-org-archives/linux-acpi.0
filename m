From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/21] ACPICA: iASL/Disassembler: Add support for MTMR table
Date: Fri,  8 Mar 2013 17:20:45 +0800
Message-ID: <fffd7c659ccbdd3f332c6dcef07f848ba650b58a.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25291 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJV3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:21:29 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

MTMR table is used in the recent ACPI BIOS enabled Intel MID
platforms.  The format of this table has been defined in the
"Simple Firmware Interface Specification" except it uses GAS
instead of 64-bit values for address fields.  This patch introduces
MTMR table support into ACPICA.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actbl2.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3f1b0a4..ffaac0e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -72,6 +72,7 @@
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
+#define ACPI_SIG_MTMR           "MTMR"	/* MID Timer table */
 #define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
@@ -853,6 +854,29 @@ struct acpi_table_mchi {
 
 /*******************************************************************************
  *
+ * MTMR - MID Timer Table
+ *        Version 1
+ *
+ * Conforms to "Simple Firmware Interface Specification",
+ * Draft 0.8.2, Oct 19, 2010
+ * NOTE: The ACPI MTMR is equivalent to the SFI MTMR table.
+ *
+ ******************************************************************************/
+
+struct acpi_table_mtmr {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/* MTMR entry */
+
+struct acpi_mtmr_entry {
+	struct acpi_generic_address physical_address;
+	u32 frequency;
+	u32 irq;
+};
+
+/*******************************************************************************
+ *
  * SLIC - Software Licensing Description Table
  *        Version 1
  *
-- 
1.7.10

