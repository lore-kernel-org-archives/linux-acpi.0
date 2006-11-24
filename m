From: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/65] ACPICA: Split acpi_format_exception into two parts
Date: Fri, 24 Nov 2006 02:18:32 -0500
Message-ID: <11643527843465-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62619 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934466AbWKXHPq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:46 -0500
In-Reply-To: <11643527832869-git-send-email-len.brown@intel.com>
Message-Id: <03a5f10642d95d738db56368dff73566bb313a54.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

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
@@ -182,10 +101,45 @@ const char *acpi_gbl_highest_dstate_name
 
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
index 3ebf42d..d1a5363 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -244,6 +244,14 @@ extern const char *acpi_gbl_highest_dsta
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
@@ -453,6 +453,8 @@ acpi_ut_short_divide(acpi_integer in_div
 /*
  * utmisc
  */
+const char *acpi_ut_validate_exception(acpi_status status);
+
 u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
 
 acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id);
-- 
1.4.4.1
