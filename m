From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/15] ACPICA: iASL: Add support for the SDEI table
Date: Thu,  3 Aug 2017 14:26:25 +0800
Message-ID: <71782dc2d3b648b4f592b7a4681405c1a194d9fe.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdHCG03 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:29 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>

From: James Morse <james.morse@arm.com>

ACPICA commit 5ad4f0b7bf9e7ba175bd320cf7950f3b38799ff3

ACPI 6.2 adds support for the Software Delegated Exception Interface,
which is described by "Software Delegated Exception Interface (SDEI)"
ARM DEN0054A.

Add the necessary types in the ACPICA header files and support for
compiling/decompiling the table.

Link: https://github.com/acpica/acpica/commit/5ad4f0b7
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d568948..686b6f8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -76,6 +76,7 @@
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_MTMR           "MTMR"	/* MID Timer table */
+#define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
@@ -1134,6 +1135,19 @@ struct acpi_mtmr_entry {
 
 /*******************************************************************************
  *
+ * SDEI - Software Delegated Exception Interface Descriptor Table
+ *
+ * Conforms to "Software Delegated Exception Interface (SDEI)" ARM DEN0054A,
+ * May 8th, 2017. Copyright 2017 ARM Ltd.
+ *
+ ******************************************************************************/
+
+struct acpi_table_sdei {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/*******************************************************************************
+ *
  * SLIC - Software Licensing Description Table
  *
  * Conforms to "Microsoft Software Licensing Tables (SLIC and MSDM)",
-- 
2.7.4

