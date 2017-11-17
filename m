From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 3/8] ACPICA: Header support for the PDTT ACPI table
Date: Fri, 17 Nov 2017 10:03:31 -0800
Message-ID: <20171117180336.15558-3-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117180336.15558-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7231 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161240AbdKQSIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 13:08:34 -0500
In-Reply-To: <20171117180336.15558-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9951c78746b52da7d23da4531fcfba6bf8c95b6a

This is an ACPI 6.2 table.

Link: https://github.com/acpica/acpica/commit/9951c787
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 6b8714a428b6..7a89e6de94da 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -69,6 +69,7 @@
 #define ACPI_SIG_HEST           "HEST"	/* Hardware Error Source Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
+#define ACPI_SIG_PDTT           "PDTT"	/* Processor Debug Trigger Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SLIT           "SLIT"	/* System Locality Distance Information Table */
@@ -1282,6 +1283,35 @@ struct acpi_nfit_flush_address {
 
 /*******************************************************************************
  *
+ * PDTT - Processor Debug Trigger Table (ACPI 6.2)
+ *        Version 0
+ *
+ ******************************************************************************/
+
+struct acpi_table_pdtt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 trigger_count;
+	u8 reserved[3];
+	u32 array_offset;
+};
+
+/*
+ * PDTT Communication Channel Identifier Structure.
+ * The number of these structures is defined by trigger_count above,
+ * starting at array_offset.
+ */
+struct acpi_pdtt_channel {
+	u16 sub_channel_id;
+};
+
+/* Mask and Flags for above */
+
+#define ACPI_PDTT_SUBCHANNEL_ID_MASK        0x00FF
+#define ACPI_PDTT_RUNTIME_TRIGGER           (1<<8)
+#define ACPI_PPTT_WAIT_COMPLETION           (1<<9)
+
+/*******************************************************************************
+ *
  * PPTT - Processor Properties Topology Table (ACPI 6.2)
  *        Version 1
  *
-- 
2.13.6

