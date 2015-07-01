From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 23/26] ACPICA: Update definitions for the TCPA and TPM2 ACPI tables.
Date: Wed,  1 Jul 2015 14:45:25 +0800
Message-ID: <7669b04226824fc8c3a9ebaa38fcbbbacbd59e6d.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51782 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbbGAGpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:45:32 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 33140b4498666337dd33a00cf3c4797a53981a7b

Changes for a new version of the 3rd party spec for these tables,
the "TCG ACPI Specification", December 14, 2014. Also, moved the
definition of TPM2 to actbl2.h, next to TCPA, since both should
be together.

Update the table compiler/disassembler code for the tables.
However, the "Server" TCPA table is not supported at this time.

Link: https://github.com/acpica/acpica/commit/33140b44
Reported-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |   86 +++++++++++++++++++++++++++++++++++++++++++++----
 include/acpi/actbl3.h |   34 ++-----------------
 2 files changed, 81 insertions(+), 39 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 370d69d..2a9dcc1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -51,8 +51,8 @@
  * These tables are not consumed directly by the ACPICA subsystem, but are
  * included here to support device drivers and the AML disassembler.
  *
- * The tables in this file are defined by third-party specifications, and are
- * not defined directly by the ACPI specification itself.
+ * Generally, the tables in this file are defined by third-party specifications,
+ * and are not defined directly by the ACPI specification itself.
  *
  ******************************************************************************/
 
@@ -80,6 +80,7 @@
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
 #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
+#define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
 #define ACPI_SIG_VRTC           "VRTC"	/* Virtual Real Time Clock Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
@@ -1179,18 +1180,89 @@ enum acpi_spmi_interface_types {
 /*******************************************************************************
  *
  * TCPA - Trusted Computing Platform Alliance table
- *        Version 1
+ *        Version 2
+ *
+ * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
+ * December 19, 2014
  *
- * Conforms to "TCG PC Specific Implementation Specification",
- * Version 1.1, August 18, 2003
+ * NOTE: There are two versions of the table with the same signature --
+ * the client version and the server version.
  *
  ******************************************************************************/
 
-struct acpi_table_tcpa {
+struct acpi_table_tcpa_client {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 platform_class;
+	u32 minimum_log_length;	/* Minimum length for the event log area */
+	u64 log_address;	/* Address of the event log area */
+};
+
+struct acpi_table_tcpa_server {
 	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 platform_class;
 	u16 reserved;
-	u32 max_log_length;	/* Maximum length for the event log area */
+	u64 minimum_log_length;	/* Minimum length for the event log area */
 	u64 log_address;	/* Address of the event log area */
+	u16 spec_revision;
+	u8 device_flags;
+	u8 interrupt_flags;
+	u8 gpe_number;
+	u8 reserved2[3];
+	u32 global_interrupt;
+	struct acpi_generic_address address;
+	u32 reserved3;
+	struct acpi_generic_address config_address;
+	u8 group;
+	u8 bus;			/* PCI Bus/Segment/Function numbers */
+	u8 device;
+	u8 function;
+};
+
+/* Values for device_flags above */
+
+#define ACPI_TCPA_PCI_DEVICE            (1)
+#define ACPI_TCPA_BUS_PNP               (1<<1)
+#define ACPI_TCPA_ADDRESS_VALID         (1<<2)
+
+/* Values for interrupt_flags above */
+
+#define ACPI_TCPA_INTERRUPT_MODE        (1)
+#define ACPI_TCPA_INTERRUPT_POLARITY    (1<<1)
+#define ACPI_TCPA_SCI_VIA_GPE           (1<<2)
+#define ACPI_TCPA_GLOBAL_INTERRUPT      (1<<3)
+
+/*******************************************************************************
+ *
+ * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
+ *        Version 4
+ *
+ * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
+ * December 19, 2014
+ *
+ ******************************************************************************/
+
+struct acpi_table_tpm2 {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 platform_class;
+	u16 reserved;
+	u64 control_address;
+	u32 start_method;
+
+	/* Platform-specific data follows */
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
 };
 
 /*******************************************************************************
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 4018986..1df8916 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -51,7 +51,8 @@
  * These tables are not consumed directly by the ACPICA subsystem, but are
  * included here to support device drivers and the AML disassembler.
  *
- * The tables in this file are fully defined within the ACPI specification.
+ * In general, the tables in this file are fully defined within the ACPI
+ * specification.
  *
  ******************************************************************************/
 
@@ -69,7 +70,6 @@
 #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
 #define ACPI_SIG_STAO           "STAO"	/* Status Override table */
-#define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
 #define ACPI_SIG_WPBT           "WPBT"	/* Windows Platform Binary Table */
 #define ACPI_SIG_XENV           "XENV"	/* Xen Environment table */
 
@@ -722,36 +722,6 @@ struct acpi_table_stao {
 
 /*******************************************************************************
  *
- * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
- *        Version 3
- *
- * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
- *
- ******************************************************************************/
-
-struct acpi_table_tpm2 {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 flags;
-	u64 control_address;
-	u32 start_method;
-};
-
-/* Control area structure (not part of table, pointed to by control_address) */
-
-struct acpi_tpm2_control {
-	u32 reserved;
-	u32 error;
-	u32 cancel;
-	u32 start;
-	u64 interrupt_control;
-	u32 command_size;
-	u64 command_address;
-	u32 response_size;
-	u64 response_address;
-};
-
-/*******************************************************************************
- *
  * WPBT - Windows Platform Environment Table (ACPI 6.0)
  *        Version 1
  *
-- 
1.7.10

