From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/27] ACPICA: Add header file support for the ACPI 5 TPM2 ACPI table.
Date: Mon, 31 Dec 2012 08:05:52 +0800
Message-ID: <52b84e867e5cd7e342a1ec5d2c55fd6d967ba146.1356668533.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40104 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:02 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Reserved in ACPI 5.0 specification, but defined in a November
2011 Microsoft document.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 6585141..a067d7d 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -68,6 +68,7 @@
 #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
@@ -550,6 +551,36 @@ enum acpi_rasf_status {
 #define ACPI_RASF_ERROR                 (1<<2)
 #define ACPI_RASF_STATUS                (0x1F<<3)
 
+/*******************************************************************************
+ *
+ * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
+ *        Version 3
+ *
+ * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
+ *
+ ******************************************************************************/
+
+struct acpi_table_tpm2 {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 flags;
+	u64 control_address;
+	u32 start_method;
+};
+
+/* Control area structure (not part of table, pointed to by control_address) */
+
+struct acpi_tpm2_control {
+	u32 reserved;
+	u32 error;
+	u32 cancel;
+	u32 start;
+	u64 interrupt_control;
+	u32 command_size;
+	u64 command_address;
+	u32 response_size;
+	u64 response_address;
+};
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
1.7.10

