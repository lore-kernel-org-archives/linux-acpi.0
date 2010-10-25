From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/60] ACPICA: iASL/Disassembler: Write ACPI errors to stderr
 instead of output file
Date: Mon, 25 Oct 2010 02:20:19 -0400
Message-ID: <cc84e262b71bab53c3b2be2e71209c85b88b4b4d.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38313 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0JYJLG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:06 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:06 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This keeps the output files clean of random error messages that
may originate from within the namespace/interpreter code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile    |    2 +-
 drivers/acpi/acpica/acmacros.h  |    4 +-
 drivers/acpi/acpica/acnamesp.h  |   12 --
 drivers/acpi/acpica/acutils.h   |   39 +++--
 drivers/acpi/acpica/nsutils.c   |   98 ---------
 drivers/acpi/acpica/utmisc.c    |  162 ---------------
 drivers/acpi/acpica/utxferror.c |  415 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 445 insertions(+), 287 deletions(-)
 create mode 100644 drivers/acpi/acpica/utxferror.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 4fdcfdb..a7e1d1a 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -45,4 +45,4 @@ acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
 		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o \
-		utosi.o
+		utosi.o utxferror.o
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 9894929..8d5c9e0 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -338,8 +338,8 @@
  * the plist contains a set of parens to allow variable-length lists.
  * These macros are used for both the debug and non-debug versions of the code.
  */
-#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ns_report_error (AE_INFO, s, e);
-#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ns_report_method_error (AE_INFO, s, n, p, e);
+#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ut_namespace_error (AE_INFO, s, e);
+#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ut_method_error (AE_INFO, s, n, p, e);
 #define ACPI_WARN_PREDEFINED(plist)     acpi_ut_predefined_warning plist
 #define ACPI_INFO_PREDEFINED(plist)     acpi_ut_predefined_info plist
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 9f60ff0..d44d3bc 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -339,18 +339,6 @@ acpi_object_type acpi_ns_get_type(struct acpi_namespace_node *node);
 u32 acpi_ns_local(acpi_object_type type);
 
 void
-acpi_ns_report_error(const char *module_name,
-		     u32 line_number,
-		     const char *internal_name, acpi_status lookup_status);
-
-void
-acpi_ns_report_method_error(const char *module_name,
-			    u32 line_number,
-			    const char *message,
-			    struct acpi_namespace_node *node,
-			    const char *path, acpi_status lookup_status);
-
-void
 acpi_ns_print_node_pathname(struct acpi_namespace_node *node, const char *msg);
 
 acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info);
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 78e0121..72e4183 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -486,17 +486,6 @@ u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
 acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer);
 
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_warning(const char *module_name,
-			   u32 line_number,
-			   char *pathname,
-			   u8 node_flags, const char *format, ...);
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_info(const char *module_name,
-			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...);
-
 /* Values for Base above (16=Hex, 10=Decimal) */
 
 #define ACPI_ANY_BASE        0
@@ -587,6 +576,32 @@ acpi_status
 acpi_ut_create_list(char *list_name,
 		    u16 object_size, struct acpi_memory_list **return_cache);
 
-#endif
+#endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
+
+/*
+ * utxferror - various error/warning output functions
+ */
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_warning(const char *module_name,
+			   u32 line_number,
+			   char *pathname,
+			   u8 node_flags, const char *format, ...);
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...);
+
+void
+acpi_ut_namespace_error(const char *module_name,
+			u32 line_number,
+			const char *internal_name, acpi_status lookup_status);
+
+void
+acpi_ut_method_error(const char *module_name,
+		     u32 line_number,
+		     const char *message,
+		     struct acpi_namespace_node *node,
+		     const char *path, acpi_status lookup_status);
 
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index e1add34..a7d6ad9 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -60,104 +60,6 @@ acpi_name acpi_ns_find_parent_name(struct acpi_namespace_node *node_to_search);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_report_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              internal_name       - Name or path of the namespace node
- *              lookup_status       - Exception code from NS lookup
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print warning message with full pathname
- *
- ******************************************************************************/
-
-void
-acpi_ns_report_error(const char *module_name,
-		     u32 line_number,
-		     const char *internal_name, acpi_status lookup_status)
-{
-	acpi_status status;
-	u32 bad_name;
-	char *name = NULL;
-
-	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
-
-	if (lookup_status == AE_BAD_CHARACTER) {
-
-		/* There is a non-ascii character in the name */
-
-		ACPI_MOVE_32_TO_32(&bad_name,
-				   ACPI_CAST_PTR(u32, internal_name));
-		acpi_os_printf("[0x%4.4X] (NON-ASCII)", bad_name);
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
-	acpi_os_printf(" Namespace lookup failure, %s\n",
-		       acpi_format_exception(lookup_status));
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_report_method_error
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              Message             - Error message to use on failure
- *              prefix_node         - Prefix relative to the path
- *              Path                - Path to the node (optional)
- *              method_status       - Execution status
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print warning message with full pathname
- *
- ******************************************************************************/
-
-void
-acpi_ns_report_method_error(const char *module_name,
-			    u32 line_number,
-			    const char *message,
-			    struct acpi_namespace_node *prefix_node,
-			    const char *path, acpi_status method_status)
-{
-	acpi_status status;
-	struct acpi_namespace_node *node = prefix_node;
-
-	acpi_os_printf("ACPI Error (%s-%04d): ", module_name, line_number);
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
-	acpi_os_printf(", %s\n", acpi_format_exception(method_status));
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_print_node_pathname
  *
  * PARAMETERS:  Node            - Object
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index e8d0724..c7d0e05 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -50,11 +50,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utmisc")
 
-/*
- * Common suffix for messages
- */
-#define ACPI_COMMON_MSG_SUFFIX \
-	acpi_os_printf(" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_validate_exception
@@ -1044,160 +1039,3 @@ acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
 
 	return_ACPI_STATUS(AE_AML_INTERNAL);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_error, acpi_exception, acpi_warning, acpi_info
- *
- * PARAMETERS:  module_name         - Caller's module name (for error output)
- *              line_number         - Caller's line number (for error output)
- *              Format              - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Print message with module/line/version info
- *
- ******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_error(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Error: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_exception(const char *module_name,
-	       u32 line_number, acpi_status status, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Exception: %s, ", acpi_format_exception(status));
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_warning(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI Warning: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_info(const char *module_name, u32 line_number, const char *format, ...)
-{
-	va_list args;
-
-	acpi_os_printf("ACPI: ");
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	acpi_os_printf("\n");
-	va_end(args);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_error)
-ACPI_EXPORT_SYMBOL(acpi_exception)
-ACPI_EXPORT_SYMBOL(acpi_warning)
-ACPI_EXPORT_SYMBOL(acpi_info)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_warning
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              Pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              Format          - Printf format string + additional args
- *
- * RETURN:      None
- *
- * DESCRIPTION: Warnings for the predefined validation module. Messages are
- *              only emitted the first time a problem with a particular
- *              method/object is detected. This prevents a flood of error
- *              messages for methods that are repeatedly evaluated.
- *
-******************************************************************************/
-
-void ACPI_INTERNAL_VAR_XFACE
-acpi_ut_predefined_warning(const char *module_name,
-			   u32 line_number,
-			   char *pathname,
-			   u8 node_flags, const char *format, ...)
-{
-	va_list args;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf("ACPI Warning for %s: ", pathname);
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_predefined_info
- *
- * PARAMETERS:  module_name     - Caller's module name (for error output)
- *              line_number     - Caller's line number (for error output)
- *              Pathname        - Full pathname to the node
- *              node_flags      - From Namespace node for the method/object
- *              Format          - Printf format string + additional args
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
-	va_list args;
-
-	/*
-	 * Warning messages for this method/object will be disabled after the
-	 * first time a validation fails or an object is successfully repaired.
-	 */
-	if (node_flags & ANOBJ_EVALUATED) {
-		return;
-	}
-
-	acpi_os_printf("ACPI Info for %s: ", pathname);
-
-	va_start(args, format);
-	acpi_os_vprintf(format, args);
-	ACPI_COMMON_MSG_SUFFIX;
-	va_end(args);
-}
diff --git a/drivers/acpi/acpica/utxferror.c b/drivers/acpi/acpica/utxferror.c
new file mode 100644
index 0000000..bf679c4
--- /dev/null
+++ b/drivers/acpi/acpica/utxferror.c
@@ -0,0 +1,415 @@
+/*******************************************************************************
+ *
+ * Module Name: utxferror - Various error/warning output functions
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
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
+ACPI_MODULE_NAME("utxferror")
+
+/*
+ * This module is used for the in-kernel ACPICA as well as the ACPICA
+ * tools/applications.
+ *
+ * For the i_aSL compiler case, the output is redirected to stderr so that
+ * any of the various ACPI errors and warnings do not appear in the output
+ * files, for either the compiler or disassembler portions of the tool.
+ */
+#ifdef ACPI_ASL_COMPILER
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
+ * non-i_aSL case - no redirection, nothing to do
+ */
+#define ACPI_MSG_REDIRECT_BEGIN
+#define ACPI_MSG_REDIRECT_END
+#endif
+/*
+ * Common message prefixes
+ */
+#define ACPI_MSG_ERROR          "ACPI Error: "
+#define ACPI_MSG_EXCEPTION      "ACPI Exception: "
+#define ACPI_MSG_WARNING        "ACPI Warning: "
+#define ACPI_MSG_INFO           "ACPI: "
+/*
+ * Common message suffix
+ */
+#define ACPI_MSG_SUFFIX \
+	acpi_os_printf (" (%8.8X/%s-%u)\n", ACPI_CA_VERSION, module_name, line_number)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_error
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Error" message with module/line/version info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_error(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_ERROR);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_error)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_exception
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Status              - Status to be formatted
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Exception" message with module/line/version info
+ *              and decoded acpi_status.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_exception(const char *module_name,
+	       u32 line_number, acpi_status status, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_EXCEPTION "%s, ",
+		       acpi_format_exception(status));
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_exception)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_warning
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print "ACPI Warning" message with module/line/version info
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_warning(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_WARNING);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	ACPI_MSG_SUFFIX;
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_warning)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_info
+ *
+ * PARAMETERS:  module_name         - Caller's module name (for error output)
+ *              line_number         - Caller's line number (for error output)
+ *              Format              - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print generic "ACPI:" information message. There is no
+ *              module/line/version info in order to keep the message simple.
+ *
+ * TBD: module_name and line_number args are not needed, should be removed.
+ *
+ ******************************************************************************/
+void ACPI_INTERNAL_VAR_XFACE
+acpi_info(const char *module_name, u32 line_number, const char *format, ...)
+{
+	va_list arg_list;
+
+	ACPI_MSG_REDIRECT_BEGIN;
+	acpi_os_printf(ACPI_MSG_INFO);
+
+	va_start(arg_list, format);
+	acpi_os_vprintf(format, arg_list);
+	acpi_os_printf("\n");
+	va_end(arg_list);
+
+	ACPI_MSG_REDIRECT_END;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_info)
+
+/*
+ * The remainder of this module contains internal error functions that may
+ * be configured out.
+ */
+#ifndef ACPI_NO_ERROR_MESSAGES
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_warning
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
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
+	acpi_os_printf(ACPI_MSG_WARNING "For %s: ", pathname);
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
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
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
+	acpi_os_printf(ACPI_MSG_INFO "For %s: ", pathname);
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
+		acpi_os_printf("[0x%4.4X] (NON-ASCII)", bad_name);
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
+ *              Message             - Error message to use on failure
+ *              prefix_node         - Prefix relative to the path
+ *              Path                - Path to the node (optional)
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
-- 
1.7.3.2.90.gd4c43

