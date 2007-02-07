From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/140] ACPICA: Split acpi_format_exception into two parts
Date: Wed,  7 Feb 2007 13:51:17 -0500
Message-ID: <11708744642267-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:33960 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422790AbXBGSyb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:31 -0500
In-Reply-To: <117087446376-git-send-email-lenb@kernel.org>
Message-Id: <84fb2c97731c1631c5548c15f3698ad82c274245.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split acpi_format_exception into two parts. New
function is acpi_ut_verify_exception and will be used to
verify exception codes returned by user.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utglobal.c |  118 +++++++++++-------------------------
 drivers/acpi/utilities/utmisc.c   |   73 +++++++++++++++++++++++
 include/acpi/acglobal.h           |    8 +++
 include/acpi/acutils.h            |    2 +
 4 files changed, 119 insertions(+), 82 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 5b83f86..509a85d 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -52,87 +52,6 @@ ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_format_exception
- *
- * PARAMETERS:  Status       - The acpi_status code to be formatted
- *
- * RETURN:      A string containing the exception text. A valid pointer is
- *              always returned.
- *
- * DESCRIPTION: This function translates an ACPI exception into an ASCII string.
- *
- ******************************************************************************/
-const char *acpi_format_exception(acpi_status status)
-{
-	acpi_status sub_status;
-	const char *exception = NULL;
-
-	ACPI_FUNCTION_ENTRY();
-
-	/*
-	 * Status is composed of two parts, a "type" and an actual code
-	 */
-	sub_status = (status & ~AE_CODE_MASK);
-
-	switch (status & AE_CODE_MASK) {
-	case AE_CODE_ENVIRONMENTAL:
-
-		if (sub_status <= AE_CODE_ENV_MAX) {
-			exception = acpi_gbl_exception_names_env[sub_status];
-		}
-		break;
-
-	case AE_CODE_PROGRAMMER:
-
-		if (sub_status <= AE_CODE_PGM_MAX) {
-			exception =
-			    acpi_gbl_exception_names_pgm[sub_status - 1];
-		}
-		break;
-
-	case AE_CODE_ACPI_TABLES:
-
-		if (sub_status <= AE_CODE_TBL_MAX) {
-			exception =
-			    acpi_gbl_exception_names_tbl[sub_status - 1];
-		}
-		break;
-
-	case AE_CODE_AML:
-
-		if (sub_status <= AE_CODE_AML_MAX) {
-			exception =
-			    acpi_gbl_exception_names_aml[sub_status - 1];
-		}
-		break;
-
-	case AE_CODE_CONTROL:
-
-		if (sub_status <= AE_CODE_CTRL_MAX) {
-			exception =
-			    acpi_gbl_exception_names_ctrl[sub_status - 1];
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	if (!exception) {
-
-		/* Exception code was not recognized */
-
-		ACPI_ERROR((AE_INFO,
-			    "Unknown exception code: 0x%8.8X", status));
-
-		exception = "UNKNOWN_STATUS_CODE";
-	}
-
-	return (ACPI_CAST_PTR(const char, exception));
-}
-
-/*******************************************************************************
- *
  * Static global variable initialization.
  *
  ******************************************************************************/
@@ -182,10 +101,45 @@ const char *acpi_gbl_highest_dstate_names[4] = {
 
 /*******************************************************************************
  *
- * Namespace globals
+ * FUNCTION:    acpi_format_exception
+ *
+ * PARAMETERS:  Status       - The acpi_status code to be formatted
+ *
+ * RETURN:      A string containing the exception text. A valid pointer is
+ *              always returned.
+ *
+ * DESCRIPTION: This function translates an ACPI exception into an ASCII string
+ *              It is here instead of utxface.c so it is always present.
  *
  ******************************************************************************/
 
+const char *acpi_format_exception(acpi_status status)
+{
+	const char *exception = NULL;
+
+	ACPI_FUNCTION_ENTRY();
+
+	exception = acpi_ut_validate_exception(status);
+	if (!exception) {
+
+		/* Exception code was not recognized */
+
+		ACPI_ERROR((AE_INFO,
+			    "Unknown exception code: 0x%8.8X", status));
+
+		exception = "UNKNOWN_STATUS_CODE";
+	}
+
+	return (ACPI_CAST_PTR(const char, exception));
+}
+
+ACPI_EXPORT_SYMBOL(acpi_format_exception)
+
+/*******************************************************************************
+ *
+ * Namespace globals
+ *
+ ******************************************************************************/
 /*
  * Predefined ACPI Names (Built-in to the Interpreter)
  *
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 36d8815..e437bc7 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -51,6 +51,78 @@ ACPI_MODULE_NAME("utmisc")
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_validate_exception
+ *
+ * PARAMETERS:  Status       - The acpi_status code to be formatted
+ *
+ * RETURN:      A string containing the exception text. NULL if exception is
+ *              not valid.
+ *
+ * DESCRIPTION: This function validates and translates an ACPI exception into
+ *              an ASCII string.
+ *
+ ******************************************************************************/
+const char *acpi_ut_validate_exception(acpi_status status)
+{
+	acpi_status sub_status;
+	const char *exception = NULL;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/*
+	 * Status is composed of two parts, a "type" and an actual code
+	 */
+	sub_status = (status & ~AE_CODE_MASK);
+
+	switch (status & AE_CODE_MASK) {
+	case AE_CODE_ENVIRONMENTAL:
+
+		if (sub_status <= AE_CODE_ENV_MAX) {
+			exception = acpi_gbl_exception_names_env[sub_status];
+		}
+		break;
+
+	case AE_CODE_PROGRAMMER:
+
+		if (sub_status <= AE_CODE_PGM_MAX) {
+			exception =
+			    acpi_gbl_exception_names_pgm[sub_status - 1];
+		}
+		break;
+
+	case AE_CODE_ACPI_TABLES:
+
+		if (sub_status <= AE_CODE_TBL_MAX) {
+			exception =
+			    acpi_gbl_exception_names_tbl[sub_status - 1];
+		}
+		break;
+
+	case AE_CODE_AML:
+
+		if (sub_status <= AE_CODE_AML_MAX) {
+			exception =
+			    acpi_gbl_exception_names_aml[sub_status - 1];
+		}
+		break;
+
+	case AE_CODE_CONTROL:
+
+		if (sub_status <= AE_CODE_CTRL_MAX) {
+			exception =
+			    acpi_gbl_exception_names_ctrl[sub_status - 1];
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return (ACPI_CAST_PTR(const char, exception));
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_is_aml_table
  *
  * PARAMETERS:  Table               - An ACPI table
@@ -62,6 +134,7 @@ ACPI_MODULE_NAME("utmisc")
  *              data tables that do not contain AML code.
  *
  ******************************************************************************/
+
 u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
 {
 
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 0c2e1ae..8dab29a 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -245,6 +245,14 @@ extern const char *acpi_gbl_highest_dstate_names[4];
 extern const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES];
 extern const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS];
 
+/* Exception codes */
+
+extern char const *acpi_gbl_exception_names_env[];
+extern char const *acpi_gbl_exception_names_pgm[];
+extern char const *acpi_gbl_exception_names_tbl[];
+extern char const *acpi_gbl_exception_names_aml[];
+extern char const *acpi_gbl_exception_names_ctrl[];
+
 /*****************************************************************************
  *
  * Namespace globals
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index beb07ac..3c66f54 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -453,6 +453,8 @@ acpi_ut_short_divide(acpi_integer in_dividend,
 /*
  * utmisc
  */
+const char *acpi_ut_validate_exception(acpi_status status);
+
 u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
 
 acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id);
-- 
1.5.0.rc3.39.gec804
