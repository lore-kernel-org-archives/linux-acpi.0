From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 19/53] ACPICA: Add header support for TPM2 table changes
Date: Mon,  5 Jun 2017 16:39:00 +0800
Message-ID: <cb1d387f8ecd68c31bde5d7ff256854b3facfc2d.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44507 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdFEIjD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:03 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b922ecaf9053dae3b8933664e951ed1ee8f86f07

Update to new version of the TCG/ACPI spec.
Does not include table compiler or disassembler support.

Link: https://github.com/acpica/acpica/commit/b922ecaf
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/char/tpm/tpm_crb.c |  4 ++--
 include/acpi/actbl2.h      | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index b917b9d..5736778 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -564,12 +564,12 @@ static int crb_acpi_add(struct acpi_device *device)
 	    sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		priv->flags |= CRB_FL_ACPI_START;
 
-	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_SMC) {
+	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
 		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
 			dev_err(dev,
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
 				buf->header.length,
-				ACPI_TPM2_COMMAND_BUFFER_WITH_SMC);
+				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
 			return -EINVAL;
 		}
 		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 724d9fc..707dda74 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1221,7 +1221,8 @@ enum acpi_spmi_interface_types {
  *        Version 2
  *
  * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
- * December 19, 2014
+ * Version 1.2, Revision 8
+ * February 27, 2017
  *
  * NOTE: There are two versions of the table with the same signature --
  * the client version and the server version. The common platform_class
@@ -1284,7 +1285,8 @@ struct acpi_table_tcpa_server {
  *        Version 4
  *
  * Conforms to "TCG ACPI Specification, Family 1.2 and 2.0",
- * December 19, 2014
+ * Version 1.2, Revision 8
+ * February 27, 2017
  *
  ******************************************************************************/
 
@@ -1305,7 +1307,36 @@ struct acpi_table_tpm2 {
 #define ACPI_TPM2_MEMORY_MAPPED                     6
 #define ACPI_TPM2_COMMAND_BUFFER                    7
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD  8
-#define ACPI_TPM2_COMMAND_BUFFER_WITH_SMC          11
+#define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC       11	/* V1.2 Rev 8 */
+
+/* Trailer appears after any start_method subtables */
+
+struct acpi_tpm2_trailer {
+	u32 minimum_log_length;	/* Minimum length for the event log area */
+	u64 log_address;	/* Address of the event log area */
+};
+
+/*
+ * Subtables (start_method-specific)
+ */
+
+/* 11: Start Method for ARM SMC (V1.2 Rev 8) */
+
+struct acpi_tpm2_arm_smc {
+	u32 global_interrupt;
+	u8 interrupt_flags;
+	u8 operation_flags;
+	u16 reserved;
+	u32 function_id;
+};
+
+/* Values for interrupt_flags above */
+
+#define ACPI_TPM2_INTERRUPT_SUPPORT     (1)
+
+/* Values for operation_flags above */
+
+#define ACPI_TPM2_IDLE_SUPPORT          (1)
 
 /*******************************************************************************
  *
-- 
2.7.4

