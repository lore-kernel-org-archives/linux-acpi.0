From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/16] ACPICA: Split internal error msg routines to a separate file
Date: Sat,  8 Jun 2013 08:58:00 +0800
Message-ID: <8cde0c9be70a6ce0f03d4bfeda73213db7a9a167.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35355 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab3FHA61 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 20:58:27 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Improves configurability of ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile    |    1 +
 drivers/acpi/acpica/acutils.h   |   42 ++++++
 drivers/acpi/acpica/uterror.c   |  289 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utxferror.c |  277 -------------------------------------
 5 files changed, 333 insertions(+), 278 deletions(-)
 create mode 100644 drivers/acpi/acpica/uterror.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 474901e..987bf41 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -152,6 +152,7 @@ acpi-y +=		\
 	utdebug.o	\
 	utdecode.o	\
 	utdelete.o	\
+	uterror.o	\
 	uteval.o	\
 	utglobal.o	\
 	utids.o		\
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 19e5cf7..d552036 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -87,6 +87,48 @@ extern const char *acpi_gbl_fc_decode[];
 extern const char *acpi_gbl_pt_decode[];
 #endif
 
+/*
+ * For the iASL compiler case, the output is redirected to stderr so that
+ * any of the various ACPI errors and warnings do not appear in the output
+ * files, for either the compiler or disassembler portions of the tool.
+ */
+#ifdef ACPI_ASL_COMPILER
+
+#include <stdio.h>
+extern FILE *acpi_gbl_output_file;
+
+#define ACPI_MSG_REDIRECT_BEGIN \
+	FILE                            *output_file = acpi_gbl_output_file; \
+	acpi_os_redirect_output (stderr);
+
+#define ACPI_MSG_REDIRECT_END \
+	acpi_os_redirect_output (output_file);
+
+#else
+/*
+ * non-iASL case - no redirection, nothing to do
+ */
+#define ACPI_MSG_REDIRECT_BEGIN
+#define ACPI_MSG_REDIRECT_END
+#endif
+
+/*
+ * Common error message prefixes
+ */
+#define ACPI_MSG_ERROR          "ACPI Error: "
+#define ACPI_MSG_EXCEPTION      "ACPI Exception: "
+#define ACPI_MSG_WARNING        "ACPI Warning: "
+#define ACPI_MSG_INFO           "ACPI: "
+
+#define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Error (bug): "
+#define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Warning (bug): "
+
+/*
+ * Common message suffix
+ */
+#define ACPI_MSG_SUFFIX \
+	acpi_os_printf (" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
+
 /* Types for Resource descriptor entries */
 
 #define ACPI_INVALID_RESOURCE           0
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
new file mode 100644
index 0000000..154fdca
--- /dev/null
+++ b/drivers/acpi/acpica/uterror.c
@@ -0,0 +1,289 @@
+/*******************************************************************************
+ *
+ * Module Name: uterror - Various internal error/warning output functions
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("uterror")
+
+/*
+ * This module contains internal error functions that may
+ * be configured out.
+ */
+#if !defined (ACPI_NO_ERROR_MESSAGES)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_warning
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Warnings for the predefined validation module. Messages are
+ *              only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of error
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_warning(const char *module_name,
+			   u32 line_number,
+			   char *pathname,
+			   u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_WARNING "%s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_info
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Info messages for the predefined validation module. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_INFO "%s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_bios_error
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: BIOS error message for predefined names. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_bios_error(const char *module_name,
+			      u32 line_number,
+			      char *pathname,
+			      u8 node_flags, const char *format, ...)
+{
+	va_list arg_list;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf(ACPI_MSG_BIOS_ERROR "%s: ", pathname);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_namespace_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              internal_name       - Name or path of the namespace node
+ *              lookup_status       - Exception code from NS lookup
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print error message with the full pathname for the NS node.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_namespace_error(const char *module_name,
+			u32 line_number,
+			const char *internal_name, acpi_status lookup_status)
+{
+	acpi_status status;
+	u32 bad_name;
+	char *name = NULL;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	if (lookup_status == AE_BAD_CHARACTER) {
+
+		/* There is a non-ascii character in the name */
+
+		ACPI_MOVE_32_TO_32(&bad_name,
+				   ACPI_CAST_PTR(u32, internal_name));
+		acpi_os_printf("[0x%.8X] (NON-ASCII)", bad_name);
+	} else {
+		/* Convert path to external format */
+
+		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
+						  internal_name, NULL, &name);
+
+		/* Print target name */
+
+		if (ACPI_SUCCESS(status)) {
+			acpi_os_printf("[%s]", name);
+		} else {
+			acpi_os_printf("[COULD NOT EXTERNALIZE NAME]");
+		}
+
+		if (name) {
+			ACPI_FREE(name);
+		}
+	}
+
+	acpi_os_printf(" Namespace lookup failure, %s",
+		       acpi_format_exception(lookup_status));
+
+	ACPI_MSG_SUFFIX;
+	ACPI_MSG_REDIRECT_END;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_method_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              message             - Error message to use on failure
+ *              prefix_node         - Prefix relative to the path
+ *              path                - Path to the node (optional)
+ *              method_status       - Execution status
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print error message with the full pathname for the method.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_method_error(const char *module_name,
+		     u32 line_number,
+		     const char *message,
+		     struct acpi_namespace_node *prefix_node,
+		     const char *path, acpi_status method_status)
+{
+	acpi_status status;
+	struct acpi_namespace_node *node = prefix_node;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	if (path) {
+		status =
+		    acpi_ns_get_node(prefix_node, path, ACPI_NS_NO_UPSEARCH,
+				     &node);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("[Could not get node by pathname]");
+		}
+	}
+
+	acpi_ns_print_node_pathname(node, message);
+	acpi_os_printf(", %s", acpi_format_exception(method_status));
+
+	ACPI_MSG_SUFFIX;
+	ACPI_MSG_REDIRECT_END;
+}
+
+#endif				/* ACPI_NO_ERROR_MESSAGES */
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 1673ddd..9d68029 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -68,7 +68,7 @@ ACPI_MODULE_NAME("uteval")
  ******************************************************************************/
 
 acpi_status
-acpi_ut_evaluate_object(struct acpi_namespace_node * prefix_node,
+acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 			char *path,
 			u32 expected_return_btypes,
 			union acpi_operand_object **return_desc)
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
index 61a2c17..e966a2e 100644
--- a/drivers/acpi/acpica/utxferror.c
+++ b/drivers/acpi/acpica/utxferror.c
@@ -44,7 +44,6 @@
 #include <linux/export.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
-#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxferror")
@@ -52,43 +51,7 @@ ACPI_MODULE_NAME("utxferror")
 /*
  * This module is used for the in-kernel ACPICA as well as the ACPICA
  * tools/applications.
- *
- * For the iASL compiler case, the output is redirected to stderr so that
- * any of the various ACPI errors and warnings do not appear in the output
- * files, for either the compiler or disassembler portions of the tool.
- */
-#ifdef ACPI_ASL_COMPILER
-#include <stdio.h>
-extern FILE *acpi_gbl_output_file;
-
-#define ACPI_MSG_REDIRECT_BEGIN \
-	FILE                            *output_file = acpi_gbl_output_file; \
-	acpi_os_redirect_output (stderr);
-
-#define ACPI_MSG_REDIRECT_END \
-	acpi_os_redirect_output (output_file);
-
-#else
-/*
- * non-iASL case - no redirection, nothing to do
- */
-#define ACPI_MSG_REDIRECT_BEGIN
-#define ACPI_MSG_REDIRECT_END
-#endif
-/*
- * Common message prefixes
  */
-#define ACPI_MSG_ERROR          "ACPI Error: "
-#define ACPI_MSG_EXCEPTION      "ACPI Exception: "
-#define ACPI_MSG_WARNING        "ACPI Warning: "
-#define ACPI_MSG_INFO           "ACPI: "
-#define ACPI_MSG_BIOS_ERROR     "ACPI BIOS Error (bug): "
-#define ACPI_MSG_BIOS_WARNING   "ACPI BIOS Warning (bug): "
-/*
- * Common message suffix
- */
-#define ACPI_MSG_SUFFIX \
-	acpi_os_printf (" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_error
@@ -285,243 +248,3 @@ acpi_bios_warning(const char *module_name,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_bios_warning)
-
-/*
- * The remainder of this module contains internal error functions that may
- * be configured out.
- */
-#if !defined (ACPI_NO_ERROR_MESSAGES) && !defined (ACPI_BIN_APP)
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_warning
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Warnings for the predefined validation module. Messages are
- *              only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of error
- *              messages for methods that are repeatedly evaluated.
- *
- ******************************************************************************/
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_warning(const char *module_name,
-			   u32 line_number,
-			   char *pathname,
-			   u8 node_flags, const char *format, ...)
-{
-	va_list arg_list;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf(ACPI_MSG_WARNING "%s: ", pathname);
-
-	va_start(arg_list, format);
-	acpi_os_vprintf(format, arg_list);
-	ACPI_MSG_SUFFIX;
-	va_end(arg_list);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_info
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Info messages for the predefined validation module. Messages
- *              are only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of
- *              messages for methods that are repeatedly evaluated.
- *
- ******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_info(const char *module_name,
-			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...)
-{
-	va_list arg_list;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf(ACPI_MSG_INFO "%s: ", pathname);
-
-	va_start(arg_list, format);
-	acpi_os_vprintf(format, arg_list);
-	ACPI_MSG_SUFFIX;
-	va_end(arg_list);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_bios_error
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: BIOS error message for predefined names. Messages
- *              are only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of
- *              messages for methods that are repeatedly evaluated.
- *
- ******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_bios_error(const char *module_name,
-			      u32 line_number,
-			      char *pathname,
-			      u8 node_flags, const char *format, ...)
-{
-	va_list arg_list;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf(ACPI_MSG_BIOS_ERROR "%s: ", pathname);
-
-	va_start(arg_list, format);
-	acpi_os_vprintf(format, arg_list);
-	ACPI_MSG_SUFFIX;
-	va_end(arg_list);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_namespace_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              internal_name       - Name or path of the namespace node
- *              lookup_status       - Exception code from NS lookup
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print error message with the full pathname for the NS node.
- *
- ******************************************************************************/
-
-void
-acpi_ut_namespace_error(const char *module_name,
-			u32 line_number,
-			const char *internal_name, acpi_status lookup_status)
-{
-	acpi_status status;
-	u32 bad_name;
-	char *name = NULL;
-
-	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
-
-	if (lookup_status == AE_BAD_CHARACTER) {
-
-		/* There is a non-ascii character in the name */
-
-		ACPI_MOVE_32_TO_32(&bad_name,
-				   ACPI_CAST_PTR(u32, internal_name));
-		acpi_os_printf("[0x%.8X] (NON-ASCII)", bad_name);
-	} else {
-		/* Convert path to external format */
-
-		status = acpi_ns_externalize_name(ACPI_UINT32_MAX,
-						  internal_name, NULL, &name);
-
-		/* Print target name */
-
-		if (ACPI_SUCCESS(status)) {
-			acpi_os_printf("[%s]", name);
-		} else {
-			acpi_os_printf("[COULD NOT EXTERNALIZE NAME]");
-		}
-
-		if (name) {
-			ACPI_FREE(name);
-		}
-	}
-
-	acpi_os_printf(" Namespace lookup failure, %s",
-		       acpi_format_exception(lookup_status));
-
-	ACPI_MSG_SUFFIX;
-	ACPI_MSG_REDIRECT_END;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_method_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              message             - Error message to use on failure
- *              prefix_node         - Prefix relative to the path
- *              path                - Path to the node (optional)
- *              method_status       - Execution status
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print error message with the full pathname for the method.
- *
- ******************************************************************************/
-
-void
-acpi_ut_method_error(const char *module_name,
-		     u32 line_number,
-		     const char *message,
-		     struct acpi_namespace_node *prefix_node,
-		     const char *path, acpi_status method_status)
-{
-	acpi_status status;
-	struct acpi_namespace_node *node = prefix_node;
-
-	ACPI_MSG_REDIRECT_BEGIN;
-	acpi_os_printf(ACPI_MSG_ERROR);
-
-	if (path) {
-		status =
-		    acpi_ns_get_node(prefix_node, path, ACPI_NS_NO_UPSEARCH,
-				     &node);
-		if (ACPI_FAILURE(status)) {
-			acpi_os_printf("[Could not get node by pathname]");
-		}
-	}
-
-	acpi_ns_print_node_pathname(node, message);
-	acpi_os_printf(", %s", acpi_format_exception(method_status));
-
-	ACPI_MSG_SUFFIX;
-	ACPI_MSG_REDIRECT_END;
-}
-
-#endif				/* ACPI_NO_ERROR_MESSAGES */
-- 
1.7.10

