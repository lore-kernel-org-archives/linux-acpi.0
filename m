From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2] acpi: update ACPI tables to match TCG ACPI specification.
Date: Tue,  9 Jun 2015 19:25:25 +0300
Message-ID: <1433867125-13016-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62884 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbbFIQop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2015 12:44:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: peterhuewe@gmx.de, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

Updated struct acpi_table_tpm2 and struct acpi_table_tcpa to match the
TCG ACPI specification.

v2:

- Do not remove struct acpi_tpm2_control

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/acpi/actbl2.h |  5 ++---
 include/acpi/actbl3.h | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

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
index 440ca81..8dd625c 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -688,15 +688,24 @@ enum acpi_rasf_status {
  * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
  *        Version 3
  *
- * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
+ * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19 December 2014
  *
  ******************************************************************************/
 
+/* How to notify that there is a command available for processing. */
+
+enum acpi_tpm2_start_method {
+	ACPI_TPM2_SM_ACPI = 2,
+	ACPI_TPM2_SM_CRB = 7,
+	ACPI_TPM2_SM_CRB_AND_ACPI = 8,
+};
+
 struct acpi_table_tpm2 {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 flags;
-	u64 control_address;
-	u32 start_method;
+	u16 platform_class;	/* 0 for client and 1 for server platforms */
+	u16 reserved;
+	u64 control_address;	/* Physical address of the control area */
+	u32 start_method;	/* Method to notify to start processing */
 };
 
 /* Control area structure (not part of table, pointed to by control_address) */
-- 
2.1.4

