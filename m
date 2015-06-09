From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH] acpi: update ACPI tables to match TCG ACPI specification.
Date: Tue,  9 Jun 2015 14:31:15 +0300
Message-ID: <1433849475-20670-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16517 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbbFILba (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 07:31:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: peterhuewe@gmx.de, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

Updated struct acpi_table_tpm2 and struct acpi_table_tcpa to match the
TCG ACPI specification. Removed struct acpi_tpm2_control as this data
structure is not part of the ACPI interface but is device interface
used with TPM 2.0 chips possibly even without ACPI in some cases.

That structure probably dived in by mistake because it was bundled with
the TPM2 ACPI table in the Microsoft specification before there were
official TPM2 interface specifications available from TCG.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/acpi/actbl2.h |  5 ++---
 include/acpi/actbl3.h | 31 +++++++++++++------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index cafdeb5..2f2b8a6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1071,14 +1071,13 @@ enum acpi_spmi_interface_types {
  * TCPA - Trusted Computing Platform Alliance table
  *        Version 1
  *
- * Conforms to "TCG PC Specific Implementation Specification",
- * Version 1.1, August 18, 2003
+ * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19 December 2014
  *
  ******************************************************************************/
 
 struct acpi_table_tcpa {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u16 reserved;
+	u16 platform_class;	/* 0 for client and 1 for server platforms. */
 	u32 max_log_length;	/* Maximum length for the event log area */
 	u64 log_address;	/* Address of the event log area */
 };
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 440ca81..a8c2e94 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -688,29 +688,24 @@ enum acpi_rasf_status {
  * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
  *        Version 3
  *
- * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
+ * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19 December 2014
  *
  ******************************************************************************/
 
-struct acpi_table_tpm2 {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 flags;
-	u64 control_address;
-	u32 start_method;
-};
+/* How to notify that there is a command available for processing. */
 
-/* Control area structure (not part of table, pointed to by control_address) */
+enum acpi_tpm2_start_method {
+	ACPI_TPM2_SM_ACPI = 2,
+	ACPI_TPM2_SM_CRB = 7,
+	ACPI_TPM2_SM_CRB_AND_ACPI = 8,
+};
 
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
+struct acpi_table_tpm2 {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 platform_class;	/* 0 for client and 1 for server platforms */
+	u16 reserved;
+	u64 control_address;	/* Physical address of the control area */
+	u32 start_method;	/* Method to notify to start processing */
 };
 
 /* Reset to default packing */
-- 
2.1.4

