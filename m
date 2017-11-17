From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 09/11] ACPICA: iASL/Tools: Add support for PDTT,SDEV,TPM2 ACPI tables
Date: Fri, 17 Nov 2017 15:40:22 -0800
Message-ID: <20171117234024.833-10-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759270AbdKQXpc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:32 -0500
In-Reply-To: <20171117234024.833-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 028d331522f239fa615148273f6d10e9deadb1b3

Full support for PDTT and SDEV
Partial support for TPM2 due to odd layout of the optional
fields of the table.

Link: https://github.com/acpica/acpica/commit/028d3315
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 77 ++++++++++++++++++++++++++++++++++++++++++++++-----
 include/acpi/actbl2.h | 14 +++++++++-
 2 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7a89e6de94da..ea0c71ece407 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -69,9 +69,10 @@
 #define ACPI_SIG_HEST           "HEST"	/* Hardware Error Source Table */
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MSCT           "MSCT"	/* Maximum System Characteristics Table */
-#define ACPI_SIG_PDTT           "PDTT"	/* Processor Debug Trigger Table */
+#define ACPI_SIG_PDTT           "PDTT"	/* Platform Debug Trigger Table */
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
+#define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_SLIT           "SLIT"	/* System Locality Distance Information Table */
 #define ACPI_SIG_SRAT           "SRAT"	/* System Resource Affinity Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
@@ -1283,7 +1284,7 @@ struct acpi_nfit_flush_address {
 
 /*******************************************************************************
  *
- * PDTT - Processor Debug Trigger Table (ACPI 6.2)
+ * PDTT - Platform Debug Trigger Table (ACPI 6.2)
  *        Version 0
  *
  ******************************************************************************/
@@ -1301,14 +1302,14 @@ struct acpi_table_pdtt {
  * starting at array_offset.
  */
 struct acpi_pdtt_channel {
-	u16 sub_channel_id;
+	u8 subchannel_id;
+	u8 flags;
 };
 
-/* Mask and Flags for above */
+/* Flags for above */
 
-#define ACPI_PDTT_SUBCHANNEL_ID_MASK        0x00FF
-#define ACPI_PDTT_RUNTIME_TRIGGER           (1<<8)
-#define ACPI_PPTT_WAIT_COMPLETION           (1<<9)
+#define ACPI_PDTT_RUNTIME_TRIGGER           (1)
+#define ACPI_PPTT_WAIT_COMPLETION           (1<<1)
 
 /*******************************************************************************
  *
@@ -1405,6 +1406,68 @@ struct acpi_table_sbst {
 
 /*******************************************************************************
  *
+ * SDEV - Secure Devices Table (ACPI 6.2)
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_sdev {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+struct acpi_sdev_header {
+	u8 type;
+	u8 flags;
+	u16 length;
+};
+
+/* Values for subtable type above */
+
+enum acpi_sdev_type {
+	ACPI_SDEV_TYPE_NAMESPACE_DEVICE = 0,
+	ACPI_SDEV_TYPE_PCIE_ENDPOINT_DEVICE = 1,
+	ACPI_SDEV_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/* Values for flags above */
+
+#define ACPI_SDEV_HANDOFF_TO_UNSECURE_OS    (1)
+
+/*
+ * SDEV subtables
+ */
+
+/* 0: Namespace Device Based Secure Device Structure */
+
+struct acpi_sdev_namespace {
+	struct acpi_sdev_header header;
+	u16 device_id_offset;
+	u16 device_id_length;
+	u16 vendor_data_offset;
+	u16 vendor_data_length;
+};
+
+/* 1: PCIe Endpoint Device Based Device Structure */
+
+struct acpi_sdev_pcie {
+	struct acpi_sdev_header header;
+	u16 segment;
+	u16 start_bus;
+	u16 path_offset;
+	u16 path_length;
+	u16 vendor_data_offset;
+	u16 vendor_data_length;
+};
+
+/* 1a: PCIe Endpoint path entry */
+
+struct acpi_sdev_pcie_path {
+	u8 device;
+	u8 function;
+};
+
+/*******************************************************************************
+ *
  * SLIT - System Locality Distance Information Table
  *        Version 1
  *
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 686b6f8c09dc..2623f9d72e46 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1246,6 +1246,8 @@ enum acpi_spmi_interface_types {
  * TCPA - Trusted Computing Platform Alliance table
  *        Version 2
  *
+ * TCG Hardware Interface Table for TPM 1.2 Clients and Servers
+ *
  * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
  * Version 1.2, Revision 8
  * February 27, 2017
@@ -1310,6 +1312,8 @@ struct acpi_table_tcpa_server {
  * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
  *        Version 4
  *
+ * TCG Hardware Interface Table for TPM 2.0 Clients and Servers
+ *
  * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
  * Version 1.2, Revision 8
  * February 27, 2017
@@ -1329,15 +1333,23 @@ struct acpi_table_tpm2 {
 /* Values for start_method above */
 
 #define ACPI_TPM2_NOT_ALLOWED                       0
+#define ACPI_TPM2_RESERVED1                         1
 #define ACPI_TPM2_START_METHOD                      2
+#define ACPI_TPM2_RESERVED3                         3
+#define ACPI_TPM2_RESERVED4                         4
+#define ACPI_TPM2_RESERVED5                         5
 #define ACPI_TPM2_MEMORY_MAPPED                     6
 #define ACPI_TPM2_COMMAND_BUFFER                    7
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD  8
+#define ACPI_TPM2_RESERVED9                         9
+#define ACPI_TPM2_RESERVED10                        10
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC       11	/* V1.2 Rev 8 */
+#define ACPI_TPM2_RESERVED                          12
 
-/* Trailer appears after any start_method subtables */
+/* Optional trailer appears after any start_method subtables */
 
 struct acpi_tpm2_trailer {
+	u8 method_parameters[12];
 	u32 minimum_log_length;	/* Minimum length for the event log area */
 	u64 log_address;	/* Address of the event log area */
 };
-- 
2.13.6

