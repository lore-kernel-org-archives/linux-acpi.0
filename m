From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/21] ACPICA: Add exception descriptions to exception info table
Date: Fri,  8 Mar 2013 17:22:39 +0800
Message-ID: <49a22c585ecc38509ebd56161007637060457c01.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43124 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJWw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:22:52 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Descriptions to be compiled/used by the acpihelp utility only. Not
compiled for the kernel ACPICA code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acutils.h |    3 +-
 drivers/acpi/acpica/utexcep.c |   26 ++--
 include/acpi/acexcep.h        |  269 +++++++++++++++++++++++++----------------
 3 files changed, 183 insertions(+), 115 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 0082fa0..c01f1a1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -483,7 +483,8 @@ acpi_ut_short_divide(u64 in_dividend,
 /*
  * utmisc
  */
-const char *acpi_ut_validate_exception(acpi_status status);
+const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status
+							     status);
 
 u8 acpi_ut_is_pci_root_bridge(char *id);
 
diff --git a/drivers/acpi/acpica/utexcep.c b/drivers/acpi/acpica/utexcep.c
index a0ab7c0..b543a14 100644
--- a/drivers/acpi/acpica/utexcep.c
+++ b/drivers/acpi/acpica/utexcep.c
@@ -64,7 +64,7 @@ ACPI_MODULE_NAME("utexcep")
  ******************************************************************************/
 const char *acpi_format_exception(acpi_status status)
 {
-	const char *exception = NULL;
+	const struct acpi_exception_info *exception;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -76,10 +76,10 @@ const char *acpi_format_exception(acpi_status status)
 		ACPI_ERROR((AE_INFO,
 			    "Unknown exception code: 0x%8.8X", status));
 
-		exception = "UNKNOWN_STATUS_CODE";
+		return ("UNKNOWN_STATUS_CODE");
 	}
 
-	return (ACPI_CAST_PTR(const char, exception));
+	return (exception->name);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_format_exception)
@@ -97,10 +97,10 @@ ACPI_EXPORT_SYMBOL(acpi_format_exception)
  *              an ASCII string.
  *
  ******************************************************************************/
-const char *acpi_ut_validate_exception(acpi_status status)
+const struct acpi_exception_info *acpi_ut_validate_exception(acpi_status status)
 {
 	u32 sub_status;
-	const char *exception = NULL;
+	const struct acpi_exception_info *exception = NULL;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -113,35 +113,35 @@ const char *acpi_ut_validate_exception(acpi_status status)
 	case AE_CODE_ENVIRONMENTAL:
 
 		if (sub_status <= AE_CODE_ENV_MAX) {
-			exception = acpi_gbl_exception_names_env[sub_status];
+			exception = &acpi_gbl_exception_names_env[sub_status];
 		}
 		break;
 
 	case AE_CODE_PROGRAMMER:
 
 		if (sub_status <= AE_CODE_PGM_MAX) {
-			exception = acpi_gbl_exception_names_pgm[sub_status];
+			exception = &acpi_gbl_exception_names_pgm[sub_status];
 		}
 		break;
 
 	case AE_CODE_ACPI_TABLES:
 
 		if (sub_status <= AE_CODE_TBL_MAX) {
-			exception = acpi_gbl_exception_names_tbl[sub_status];
+			exception = &acpi_gbl_exception_names_tbl[sub_status];
 		}
 		break;
 
 	case AE_CODE_AML:
 
 		if (sub_status <= AE_CODE_AML_MAX) {
-			exception = acpi_gbl_exception_names_aml[sub_status];
+			exception = &acpi_gbl_exception_names_aml[sub_status];
 		}
 		break;
 
 	case AE_CODE_CONTROL:
 
 		if (sub_status <= AE_CODE_CTRL_MAX) {
-			exception = acpi_gbl_exception_names_ctrl[sub_status];
+			exception = &acpi_gbl_exception_names_ctrl[sub_status];
 		}
 		break;
 
@@ -149,5 +149,9 @@ const char *acpi_ut_validate_exception(acpi_status status)
 		break;
 	}
 
-	return (ACPI_CAST_PTR(const char, exception));
+	if (!exception || !exception->name) {
+		return (NULL);
+	}
+
+	return (exception);
 }
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index 3e6b163..cf051e0 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -49,11 +49,12 @@
 /*
  * Exception code classes
  */
-#define AE_CODE_ENVIRONMENTAL           0x0000
-#define AE_CODE_PROGRAMMER              0x1000
-#define AE_CODE_ACPI_TABLES             0x2000
-#define AE_CODE_AML                     0x3000
-#define AE_CODE_CONTROL                 0x4000
+#define AE_CODE_ENVIRONMENTAL           0x0000	/* General ACPICA environment */
+#define AE_CODE_PROGRAMMER              0x1000	/* External ACPICA interface caller */
+#define AE_CODE_ACPI_TABLES             0x2000	/* ACPI tables */
+#define AE_CODE_AML                     0x3000	/* From executing AML code */
+#define AE_CODE_CONTROL                 0x4000	/* Internal control codes */
+
 #define AE_CODE_MAX                     0x4000
 #define AE_CODE_MASK                    0xF000
 
@@ -67,6 +68,24 @@
 #define EXCEP_CTL(code)                 ((acpi_status) (code | AE_CODE_CONTROL))
 
 /*
+ * Exception info table. The "Description" field is used only by the
+ * ACPICA help application (acpihelp).
+ */
+struct acpi_exception_info {
+	char *name;
+
+#ifdef ACPI_HELP_APP
+	char *description;
+#endif
+};
+
+#ifdef ACPI_HELP_APP
+#define EXCEP_TXT(name,description)     {name, description}
+#else
+#define EXCEP_TXT(name,description)     {name}
+#endif
+
+/*
  * Success is always zero, failure is non-zero
  */
 #define ACPI_SUCCESS(a)                 (!(a))
@@ -202,112 +221,156 @@
  * String versions of the exception codes above
  * These strings must match the corresponding defines exactly
  */
-char const *acpi_gbl_exception_names_env[] = {
-	"AE_OK",
-	"AE_ERROR",
-	"AE_NO_ACPI_TABLES",
-	"AE_NO_NAMESPACE",
-	"AE_NO_MEMORY",
-	"AE_NOT_FOUND",
-	"AE_NOT_EXIST",
-	"AE_ALREADY_EXISTS",
-	"AE_TYPE",
-	"AE_NULL_OBJECT",
-	"AE_NULL_ENTRY",
-	"AE_BUFFER_OVERFLOW",
-	"AE_STACK_OVERFLOW",
-	"AE_STACK_UNDERFLOW",
-	"AE_NOT_IMPLEMENTED",
-	"AE_SUPPORT",
-	"AE_LIMIT",
-	"AE_TIME",
-	"AE_ACQUIRE_DEADLOCK",
-	"AE_RELEASE_DEADLOCK",
-	"AE_NOT_ACQUIRED",
-	"AE_ALREADY_ACQUIRED",
-	"AE_NO_HARDWARE_RESPONSE",
-	"AE_NO_GLOBAL_LOCK",
-	"AE_ABORT_METHOD",
-	"AE_SAME_HANDLER",
-	"AE_NO_HANDLER",
-	"AE_OWNER_ID_LIMIT",
-	"AE_NOT_CONFIGURED"
+static const struct acpi_exception_info acpi_gbl_exception_names_env[] = {
+	EXCEP_TXT("AE_OK", "No error"),
+	EXCEP_TXT("AE_ERROR", "Unspecified error"),
+	EXCEP_TXT("AE_NO_ACPI_TABLES", "ACPI tables could not be found"),
+	EXCEP_TXT("AE_NO_NAMESPACE", "A namespace has not been loaded"),
+	EXCEP_TXT("AE_NO_MEMORY", "Insufficient dynamic memory"),
+	EXCEP_TXT("AE_NOT_FOUND", "The name was not found in the namespace"),
+	EXCEP_TXT("AE_NOT_EXIST", "A required entity does not exist"),
+	EXCEP_TXT("AE_ALREADY_EXISTS", "An entity already exists"),
+	EXCEP_TXT("AE_TYPE", "The object type is incorrect"),
+	EXCEP_TXT("AE_NULL_OBJECT", "A required object was missing"),
+	EXCEP_TXT("AE_NULL_ENTRY", "The requested object does not exist"),
+	EXCEP_TXT("AE_BUFFER_OVERFLOW", "The buffer provided is too small"),
+	EXCEP_TXT("AE_STACK_OVERFLOW", "An internal stack overflowed"),
+	EXCEP_TXT("AE_STACK_UNDERFLOW", "An internal stack underflowed"),
+	EXCEP_TXT("AE_NOT_IMPLEMENTED", "The feature is not implemented"),
+	EXCEP_TXT("AE_SUPPORT", "The feature is not supported"),
+	EXCEP_TXT("AE_LIMIT", "A predefined limit was exceeded"),
+	EXCEP_TXT("AE_TIME", "A time limit or timeout expired"),
+	EXCEP_TXT("AE_ACQUIRE_DEADLOCK",
+		  "Internal error, attempt was made to acquire a mutex in improper order"),
+	EXCEP_TXT("AE_RELEASE_DEADLOCK",
+		  "Internal error, attempt was made to release a mutex in improper order"),
+	EXCEP_TXT("AE_NOT_ACQUIRED",
+		  "An attempt to release a mutex or Global Lock without a previous acquire"),
+	EXCEP_TXT("AE_ALREADY_ACQUIRED",
+		  "Internal error, attempt was made to acquire a mutex twice"),
+	EXCEP_TXT("AE_NO_HARDWARE_RESPONSE",
+		  "Hardware did not respond after an I/O operation"),
+	EXCEP_TXT("AE_NO_GLOBAL_LOCK", "There is no FACS Global Lock"),
+	EXCEP_TXT("AE_ABORT_METHOD", "A control method was aborted"),
+	EXCEP_TXT("AE_SAME_HANDLER",
+		  "Attempt was made to install the same handler that is already installed"),
+	EXCEP_TXT("AE_NO_HANDLER",
+		  "A handler for the operation is not installed"),
+	EXCEP_TXT("AE_OWNER_ID_LIMIT",
+		  "There are no more Owner IDs available for ACPI tables or control methods"),
+	EXCEP_TXT("AE_NOT_CONFIGURED",
+		  "The interface is not part of the current subsystem configuration")
 };
 
-char const *acpi_gbl_exception_names_pgm[] = {
-	NULL,
-	"AE_BAD_PARAMETER",
-	"AE_BAD_CHARACTER",
-	"AE_BAD_PATHNAME",
-	"AE_BAD_DATA",
-	"AE_BAD_HEX_CONSTANT",
-	"AE_BAD_OCTAL_CONSTANT",
-	"AE_BAD_DECIMAL_CONSTANT",
-	"AE_MISSING_ARGUMENTS",
-	"AE_BAD_ADDRESS"
+static const struct acpi_exception_info acpi_gbl_exception_names_pgm[] = {
+	EXCEP_TXT(NULL, NULL),
+	EXCEP_TXT("AE_BAD_PARAMETER", "A parameter is out of range or invalid"),
+	EXCEP_TXT("AE_BAD_CHARACTER",
+		  "An invalid character was found in a name"),
+	EXCEP_TXT("AE_BAD_PATHNAME",
+		  "An invalid character was found in a pathname"),
+	EXCEP_TXT("AE_BAD_DATA",
+		  "A package or buffer contained incorrect data"),
+	EXCEP_TXT("AE_BAD_HEX_CONSTANT", "Invalid character in a Hex constant"),
+	EXCEP_TXT("AE_BAD_OCTAL_CONSTANT",
+		  "Invalid character in an Octal constant"),
+	EXCEP_TXT("AE_BAD_DECIMAL_CONSTANT",
+		  "Invalid character in a Decimal constant"),
+	EXCEP_TXT("AE_MISSING_ARGUMENTS",
+		  "Too few arguments were passed to a control method"),
+	EXCEP_TXT("AE_BAD_ADDRESS", "An illegal null I/O address")
 };
 
-char const *acpi_gbl_exception_names_tbl[] = {
-	NULL,
-	"AE_BAD_SIGNATURE",
-	"AE_BAD_HEADER",
-	"AE_BAD_CHECKSUM",
-	"AE_BAD_VALUE",
-	"AE_INVALID_TABLE_LENGTH"
+static const struct acpi_exception_info acpi_gbl_exception_names_tbl[] = {
+	EXCEP_TXT(NULL, NULL),
+	EXCEP_TXT("AE_BAD_SIGNATURE", "An ACPI table has an invalid signature"),
+	EXCEP_TXT("AE_BAD_HEADER", "Invalid field in an ACPI table header"),
+	EXCEP_TXT("AE_BAD_CHECKSUM", "An ACPI table checksum is not correct"),
+	EXCEP_TXT("AE_BAD_VALUE", "An invalid value was found in a table"),
+	EXCEP_TXT("AE_INVALID_TABLE_LENGTH",
+		  "The FADT or FACS has improper length")
 };
 
-char const *acpi_gbl_exception_names_aml[] = {
-	NULL,
-	"AE_AML_BAD_OPCODE",
-	"AE_AML_NO_OPERAND",
-	"AE_AML_OPERAND_TYPE",
-	"AE_AML_OPERAND_VALUE",
-	"AE_AML_UNINITIALIZED_LOCAL",
-	"AE_AML_UNINITIALIZED_ARG",
-	"AE_AML_UNINITIALIZED_ELEMENT",
-	"AE_AML_NUMERIC_OVERFLOW",
-	"AE_AML_REGION_LIMIT",
-	"AE_AML_BUFFER_LIMIT",
-	"AE_AML_PACKAGE_LIMIT",
-	"AE_AML_DIVIDE_BY_ZERO",
-	"AE_AML_BAD_NAME",
-	"AE_AML_NAME_NOT_FOUND",
-	"AE_AML_INTERNAL",
-	"AE_AML_INVALID_SPACE_ID",
-	"AE_AML_STRING_LIMIT",
-	"AE_AML_NO_RETURN_VALUE",
-	"AE_AML_METHOD_LIMIT",
-	"AE_AML_NOT_OWNER",
-	"AE_AML_MUTEX_ORDER",
-	"AE_AML_MUTEX_NOT_ACQUIRED",
-	"AE_AML_INVALID_RESOURCE_TYPE",
-	"AE_AML_INVALID_INDEX",
-	"AE_AML_REGISTER_LIMIT",
-	"AE_AML_NO_WHILE",
-	"AE_AML_ALIGNMENT",
-	"AE_AML_NO_RESOURCE_END_TAG",
-	"AE_AML_BAD_RESOURCE_VALUE",
-	"AE_AML_CIRCULAR_REFERENCE",
-	"AE_AML_BAD_RESOURCE_LENGTH",
-	"AE_AML_ILLEGAL_ADDRESS",
-	"AE_AML_INFINITE_LOOP"
+static const struct acpi_exception_info acpi_gbl_exception_names_aml[] = {
+	EXCEP_TXT(NULL, NULL),
+	EXCEP_TXT("AE_AML_BAD_OPCODE", "Invalid AML opcode encountered"),
+	EXCEP_TXT("AE_AML_NO_OPERAND", "A required operand is missing"),
+	EXCEP_TXT("AE_AML_OPERAND_TYPE",
+		  "An operand of an incorrect type was encountered"),
+	EXCEP_TXT("AE_AML_OPERAND_VALUE",
+		  "The operand had an inappropriate or invalid value"),
+	EXCEP_TXT("AE_AML_UNINITIALIZED_LOCAL",
+		  "Method tried to use an uninitialized local variable"),
+	EXCEP_TXT("AE_AML_UNINITIALIZED_ARG",
+		  "Method tried to use an uninitialized argument"),
+	EXCEP_TXT("AE_AML_UNINITIALIZED_ELEMENT",
+		  "Method tried to use an empty package element"),
+	EXCEP_TXT("AE_AML_NUMERIC_OVERFLOW",
+		  "Overflow during BCD conversion or other"),
+	EXCEP_TXT("AE_AML_REGION_LIMIT",
+		  "Tried to access beyond the end of an Operation Region"),
+	EXCEP_TXT("AE_AML_BUFFER_LIMIT",
+		  "Tried to access beyond the end of a buffer"),
+	EXCEP_TXT("AE_AML_PACKAGE_LIMIT",
+		  "Tried to access beyond the end of a package"),
+	EXCEP_TXT("AE_AML_DIVIDE_BY_ZERO",
+		  "During execution of AML Divide operator"),
+	EXCEP_TXT("AE_AML_BAD_NAME",
+		  "An ACPI name contains invalid character(s)"),
+	EXCEP_TXT("AE_AML_NAME_NOT_FOUND",
+		  "Could not resolve a named reference"),
+	EXCEP_TXT("AE_AML_INTERNAL", "An internal error within the interprete"),
+	EXCEP_TXT("AE_AML_INVALID_SPACE_ID",
+		  "An Operation Region SpaceID is invalid"),
+	EXCEP_TXT("AE_AML_STRING_LIMIT",
+		  "String is longer than 200 characters"),
+	EXCEP_TXT("AE_AML_NO_RETURN_VALUE",
+		  "A method did not return a required value"),
+	EXCEP_TXT("AE_AML_METHOD_LIMIT",
+		  "A control method reached the maximum reentrancy limit of 255"),
+	EXCEP_TXT("AE_AML_NOT_OWNER",
+		  "A thread tried to release a mutex that it does not own"),
+	EXCEP_TXT("AE_AML_MUTEX_ORDER", "Mutex SyncLevel release mismatch"),
+	EXCEP_TXT("AE_AML_MUTEX_NOT_ACQUIRED",
+		  "Attempt to release a mutex that was not previously acquired"),
+	EXCEP_TXT("AE_AML_INVALID_RESOURCE_TYPE",
+		  "Invalid resource type in resource list"),
+	EXCEP_TXT("AE_AML_INVALID_INDEX",
+		  "Invalid Argx or Localx (x too large)"),
+	EXCEP_TXT("AE_AML_REGISTER_LIMIT",
+		  "Bank value or Index value beyond range of register"),
+	EXCEP_TXT("AE_AML_NO_WHILE", "Break or Continue without a While"),
+	EXCEP_TXT("AE_AML_ALIGNMENT",
+		  "Non-aligned memory transfer on platform that does not support this"),
+	EXCEP_TXT("AE_AML_NO_RESOURCE_END_TAG",
+		  "No End Tag in a resource list"),
+	EXCEP_TXT("AE_AML_BAD_RESOURCE_VALUE",
+		  "Invalid value of a resource element"),
+	EXCEP_TXT("AE_AML_CIRCULAR_REFERENCE",
+		  "Two references refer to each other"),
+	EXCEP_TXT("AE_AML_BAD_RESOURCE_LENGTH",
+		  "The length of a Resource Descriptor in the AML is incorrect"),
+	EXCEP_TXT("AE_AML_ILLEGAL_ADDRESS",
+		  "A memory, I/O, or PCI configuration address is invalid"),
+	EXCEP_TXT("AE_AML_INFINITE_LOOP",
+		  "An apparent infinite AML While loop, method was aborted")
 };
 
-char const *acpi_gbl_exception_names_ctrl[] = {
-	NULL,
-	"AE_CTRL_RETURN_VALUE",
-	"AE_CTRL_PENDING",
-	"AE_CTRL_TERMINATE",
-	"AE_CTRL_TRUE",
-	"AE_CTRL_FALSE",
-	"AE_CTRL_DEPTH",
-	"AE_CTRL_END",
-	"AE_CTRL_TRANSFER",
-	"AE_CTRL_BREAK",
-	"AE_CTRL_CONTINUE",
-	"AE_CTRL_SKIP",
-	"AE_CTRL_PARSE_CONTINUE",
-	"AE_CTRL_PARSE_PENDING"
+static const struct acpi_exception_info acpi_gbl_exception_names_ctrl[] = {
+	EXCEP_TXT(NULL, NULL),
+	EXCEP_TXT("AE_CTRL_RETURN_VALUE", "A Method returned a value"),
+	EXCEP_TXT("AE_CTRL_PENDING", "Method is calling another method"),
+	EXCEP_TXT("AE_CTRL_TERMINATE", "Terminate the executing method"),
+	EXCEP_TXT("AE_CTRL_TRUE", "An If or While predicate result"),
+	EXCEP_TXT("AE_CTRL_FALSE", "An If or While predicate result"),
+	EXCEP_TXT("AE_CTRL_DEPTH", "Maximum search depth has been reached"),
+	EXCEP_TXT("AE_CTRL_END", "An If or While predicate is false"),
+	EXCEP_TXT("AE_CTRL_TRANSFER", "Transfer control to called method"),
+	EXCEP_TXT("AE_CTRL_BREAK", "A Break has been executed"),
+	EXCEP_TXT("AE_CTRL_CONTINUE", "A Continue has been executed"),
+	EXCEP_TXT("AE_CTRL_SKIP", "Not currently used"),
+	EXCEP_TXT("AE_CTRL_PARSE_CONTINUE", "Used to skip over bad opcodes"),
+	EXCEP_TXT("AE_CTRL_PARSE_PENDING", "Used to implement AML While loops")
 };
 
 #endif				/* EXCEPTION_TABLE */
-- 
1.7.10

