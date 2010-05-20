From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/22] ACPICA: Enhance configuration for output of AML Debug
 Object
Date: Thu, 20 May 2010 01:18:29 -0400
Message-ID: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:30617 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0ETFTA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:00 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007EEDFGNWA0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:57 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This change will enable debug object output via a global variable,
acpi_gbl_enable_aml_debug_object. This will help with remote machine
debugging. Also, moved all debug object support code to a new
file, exdebug.c. Entire debug object module can now be
configured out of the ACPICA build if desired.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/acglobal.h |    5 +
 drivers/acpi/acpica/acinterp.h |    7 +
 drivers/acpi/acpica/exdebug.c  |  261 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/exstore.c  |  216 +---------------------------------
 include/acpi/acoutput.h        |    2 +
 include/acpi/acpixf.h          |    1 +
 7 files changed, 278 insertions(+), 216 deletions(-)
 create mode 100644 drivers/acpi/acpica/exdebug.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 7423052..c110209 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -19,7 +19,7 @@ acpi-y += evevent.o  evregion.o  evsci.o    evxfevnt.o \
 acpi-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
 	 exconvrt.o  exfldio.o  exoparg1.o  exprep.o    exresop.o   exsystem.o\
 	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
-	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
+	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o  exdebug.o
 
 acpi-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f8dd8f2..2b2e61e 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -112,6 +112,11 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_leave_wake_gpes_disabled, TRUE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_use_default_register_widths, TRUE);
 
+/*
+ * Optionally enable output from the AML Debug Object.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_enable_aml_debug_object, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 6df3f84..9a9b893 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -121,6 +121,13 @@ acpi_ex_convert_to_target_type(acpi_object_type destination_type,
 			       struct acpi_walk_state *walk_state);
 
 /*
+ * exdebug - AML debug object
+ */
+void
+acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
+			u32 level, u32 index);
+
+/*
  * exfield - ACPI AML (p-code) execution - field manipulation
  */
 acpi_status
diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
new file mode 100644
index 0000000..be8c98b
--- /dev/null
+++ b/drivers/acpi/acpica/exdebug.c
@@ -0,0 +1,261 @@
+/******************************************************************************
+ *
+ * Module Name: exdebug - Support for stores to the AML Debug Object
+ *
+ *****************************************************************************/
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
+#include "acinterp.h"
+
+#define _COMPONENT          ACPI_EXECUTER
+ACPI_MODULE_NAME("exdebug")
+
+#ifndef ACPI_NO_ERROR_MESSAGES
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ex_do_debug_object
+ *
+ * PARAMETERS:  source_desc         - Object to be output to "Debug Object"
+ *              Level               - Indentation level (used for packages)
+ *              Index               - Current package element, zero if not pkg
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Handles stores to the AML Debug Object. For example:
+ *              Store(INT1, Debug)
+ *
+ * This function is not compiled if ACPI_NO_ERROR_MESSAGES is set.
+ *
+ * This function is only enabled if acpi_gbl_enable_aml_debug_object is set, or
+ * if ACPI_LV_DEBUG_OBJECT is set in the acpi_dbg_level. Thus, in the normal
+ * operational case, stores to the debug object are ignored but can be easily
+ * enabled if necessary.
+ *
+ ******************************************************************************/
+void
+acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
+			u32 level, u32 index)
+{
+	u32 i;
+
+	ACPI_FUNCTION_TRACE_PTR(ex_do_debug_object, source_desc);
+
+	/* Output must be enabled via the debug_object global or the dbg_level */
+
+	if (!acpi_gbl_enable_aml_debug_object &&
+	    !(acpi_dbg_level & ACPI_LV_DEBUG_OBJECT)) {
+		return_VOID;
+	}
+
+	/*
+	 * Print line header as long as we are not in the middle of an
+	 * object display
+	 */
+	if (!((level > 0) && index == 0)) {
+		acpi_os_printf("[ACPI Debug] %*s", level, " ");
+	}
+
+	/* Display the index for package output only */
+
+	if (index > 0) {
+		acpi_os_printf("(%.2u) ", index - 1);
+	}
+
+	if (!source_desc) {
+		acpi_os_printf("[Null Object]\n");
+		return_VOID;
+	}
+
+	if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) {
+		acpi_os_printf("%s ",
+			       acpi_ut_get_object_type_name(source_desc));
+
+		if (!acpi_ut_valid_internal_object(source_desc)) {
+			acpi_os_printf("%p, Invalid Internal Object!\n",
+				       source_desc);
+			return_VOID;
+		}
+	} else if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) ==
+		   ACPI_DESC_TYPE_NAMED) {
+		acpi_os_printf("%s: %p\n",
+			       acpi_ut_get_type_name(((struct
+						       acpi_namespace_node *)
+						      source_desc)->type),
+			       source_desc);
+		return_VOID;
+	} else {
+		return_VOID;
+	}
+
+	/* source_desc is of type ACPI_DESC_TYPE_OPERAND */
+
+	switch (source_desc->common.type) {
+	case ACPI_TYPE_INTEGER:
+
+		/* Output correct integer width */
+
+		if (acpi_gbl_integer_byte_width == 4) {
+			acpi_os_printf("0x%8.8X\n",
+				       (u32)source_desc->integer.value);
+		} else {
+			acpi_os_printf("0x%8.8X%8.8X\n",
+				       ACPI_FORMAT_UINT64(source_desc->integer.
+							  value));
+		}
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		acpi_os_printf("[0x%.2X]\n", (u32)source_desc->buffer.length);
+		acpi_ut_dump_buffer2(source_desc->buffer.pointer,
+				     (source_desc->buffer.length < 256) ?
+				     source_desc->buffer.length : 256,
+				     DB_BYTE_DISPLAY);
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		acpi_os_printf("[0x%.2X] \"%s\"\n",
+			       source_desc->string.length,
+			       source_desc->string.pointer);
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+
+		acpi_os_printf("[Contains 0x%.2X Elements]\n",
+			       source_desc->package.count);
+
+		/* Output the entire contents of the package */
+
+		for (i = 0; i < source_desc->package.count; i++) {
+			acpi_ex_do_debug_object(source_desc->package.
+						elements[i], level + 4, i + 1);
+		}
+		break;
+
+	case ACPI_TYPE_LOCAL_REFERENCE:
+
+		acpi_os_printf("[%s] ",
+			       acpi_ut_get_reference_name(source_desc));
+
+		/* Decode the reference */
+
+		switch (source_desc->reference.class) {
+		case ACPI_REFCLASS_INDEX:
+
+			acpi_os_printf("0x%X\n", source_desc->reference.value);
+			break;
+
+		case ACPI_REFCLASS_TABLE:
+
+			/* Case for ddb_handle */
+
+			acpi_os_printf("Table Index 0x%X\n",
+				       source_desc->reference.value);
+			return;
+
+		default:
+			break;
+		}
+
+		acpi_os_printf(" ");
+
+		/* Check for valid node first, then valid object */
+
+		if (source_desc->reference.node) {
+			if (ACPI_GET_DESCRIPTOR_TYPE
+			    (source_desc->reference.node) !=
+			    ACPI_DESC_TYPE_NAMED) {
+				acpi_os_printf
+				    (" %p - Not a valid namespace node\n",
+				     source_desc->reference.node);
+			} else {
+				acpi_os_printf("Node %p [%4.4s] ",
+					       source_desc->reference.node,
+					       (source_desc->reference.node)->
+					       name.ascii);
+
+				switch ((source_desc->reference.node)->type) {
+
+					/* These types have no attached object */
+
+				case ACPI_TYPE_DEVICE:
+					acpi_os_printf("Device\n");
+					break;
+
+				case ACPI_TYPE_THERMAL:
+					acpi_os_printf("Thermal Zone\n");
+					break;
+
+				default:
+					acpi_ex_do_debug_object((source_desc->
+								 reference.
+								 node)->object,
+								level + 4, 0);
+					break;
+				}
+			}
+		} else if (source_desc->reference.object) {
+			if (ACPI_GET_DESCRIPTOR_TYPE
+			    (source_desc->reference.object) ==
+			    ACPI_DESC_TYPE_NAMED) {
+				acpi_ex_do_debug_object(((struct
+							  acpi_namespace_node *)
+							 source_desc->reference.
+							 object)->object,
+							level + 4, 0);
+			} else {
+				acpi_ex_do_debug_object(source_desc->reference.
+							object, level + 4, 0);
+			}
+		}
+		break;
+
+	default:
+
+		acpi_os_printf("%p\n", source_desc);
+		break;
+	}
+
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_EXEC, "\n"));
+	return_VOID;
+}
+#endif
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 702b9ec..f65d7e4 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -1,4 +1,3 @@
-
 /******************************************************************************
  *
  * Module Name: exstore - AML Interpreter object store support
@@ -53,10 +52,6 @@
 ACPI_MODULE_NAME("exstore")
 
 /* Local prototypes */
-static void
-acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
-			u32 level, u32 index);
-
 static acpi_status
 acpi_ex_store_object_to_index(union acpi_operand_object *val_desc,
 			      union acpi_operand_object *dest_desc,
@@ -64,215 +59,6 @@ acpi_ex_store_object_to_index(union acpi_operand_object *val_desc,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ex_do_debug_object
- *
- * PARAMETERS:  source_desc         - Value to be stored
- *              Level               - Indentation level (used for packages)
- *              Index               - Current package element, zero if not pkg
- *
- * RETURN:      None
- *
- * DESCRIPTION: Handles stores to the Debug Object.
- *
- ******************************************************************************/
-
-static void
-acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
-			u32 level, u32 index)
-{
-	u32 i;
-
-	ACPI_FUNCTION_TRACE_PTR(ex_do_debug_object, source_desc);
-
-	/* Print line header as long as we are not in the middle of an object display */
-
-	if (!((level > 0) && index == 0)) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[ACPI Debug] %*s",
-				      level, " "));
-	}
-
-	/* Display index for package output only */
-
-	if (index > 0) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-				      "(%.2u) ", index - 1));
-	}
-
-	if (!source_desc) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[Null Object]\n"));
-		return_VOID;
-	}
-
-	if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%s ",
-				      acpi_ut_get_object_type_name
-				      (source_desc)));
-
-		if (!acpi_ut_valid_internal_object(source_desc)) {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      "%p, Invalid Internal Object!\n",
-					      source_desc));
-			return_VOID;
-		}
-	} else if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) ==
-		   ACPI_DESC_TYPE_NAMED) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%s: %p\n",
-				      acpi_ut_get_type_name(((struct
-							      acpi_namespace_node
-							      *)source_desc)->
-							    type),
-				      source_desc));
-		return_VOID;
-	} else {
-		return_VOID;
-	}
-
-	/* source_desc is of type ACPI_DESC_TYPE_OPERAND */
-
-	switch (source_desc->common.type) {
-	case ACPI_TYPE_INTEGER:
-
-		/* Output correct integer width */
-
-		if (acpi_gbl_integer_byte_width == 4) {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "0x%8.8X\n",
-					      (u32) source_desc->integer.
-					      value));
-		} else {
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      "0x%8.8X%8.8X\n",
-					      ACPI_FORMAT_UINT64(source_desc->
-								 integer.
-								 value)));
-		}
-		break;
-
-	case ACPI_TYPE_BUFFER:
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[0x%.2X]\n",
-				      (u32) source_desc->buffer.length));
-		ACPI_DUMP_BUFFER(source_desc->buffer.pointer,
-				 (source_desc->buffer.length <
-				  256) ? source_desc->buffer.length : 256);
-		break;
-
-	case ACPI_TYPE_STRING:
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[0x%.2X] \"%s\"\n",
-				      source_desc->string.length,
-				      source_desc->string.pointer));
-		break;
-
-	case ACPI_TYPE_PACKAGE:
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-				      "[Contains 0x%.2X Elements]\n",
-				      source_desc->package.count));
-
-		/* Output the entire contents of the package */
-
-		for (i = 0; i < source_desc->package.count; i++) {
-			acpi_ex_do_debug_object(source_desc->package.
-						elements[i], level + 4, i + 1);
-		}
-		break;
-
-	case ACPI_TYPE_LOCAL_REFERENCE:
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[%s] ",
-				      acpi_ut_get_reference_name(source_desc)));
-
-		/* Decode the reference */
-
-		switch (source_desc->reference.class) {
-		case ACPI_REFCLASS_INDEX:
-
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "0x%X\n",
-					      source_desc->reference.value));
-			break;
-
-		case ACPI_REFCLASS_TABLE:
-
-			/* Case for ddb_handle */
-
-			ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-					      "Table Index 0x%X\n",
-					      source_desc->reference.value));
-			return;
-
-		default:
-			break;
-		}
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "  "));
-
-		/* Check for valid node first, then valid object */
-
-		if (source_desc->reference.node) {
-			if (ACPI_GET_DESCRIPTOR_TYPE
-			    (source_desc->reference.node) !=
-			    ACPI_DESC_TYPE_NAMED) {
-				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-						      " %p - Not a valid namespace node\n",
-						      source_desc->reference.
-						      node));
-			} else {
-				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-						      "Node %p [%4.4s] ",
-						      source_desc->reference.
-						      node,
-						      (source_desc->reference.
-						       node)->name.ascii));
-
-				switch ((source_desc->reference.node)->type) {
-
-					/* These types have no attached object */
-
-				case ACPI_TYPE_DEVICE:
-					acpi_os_printf("Device\n");
-					break;
-
-				case ACPI_TYPE_THERMAL:
-					acpi_os_printf("Thermal Zone\n");
-					break;
-
-				default:
-					acpi_ex_do_debug_object((source_desc->
-								 reference.
-								 node)->object,
-								level + 4, 0);
-					break;
-				}
-			}
-		} else if (source_desc->reference.object) {
-			if (ACPI_GET_DESCRIPTOR_TYPE
-			    (source_desc->reference.object) ==
-			    ACPI_DESC_TYPE_NAMED) {
-				acpi_ex_do_debug_object(((struct
-							  acpi_namespace_node *)
-							 source_desc->reference.
-							 object)->object,
-							level + 4, 0);
-			} else {
-				acpi_ex_do_debug_object(source_desc->reference.
-							object, level + 4, 0);
-			}
-		}
-		break;
-
-	default:
-
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%p\n",
-				      source_desc));
-		break;
-	}
-
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_EXEC, "\n"));
-	return_VOID;
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ex_store
  *
  * PARAMETERS:  *source_desc        - Value to be stored
@@ -402,7 +188,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 				  source_desc,
 				  acpi_ut_get_object_type_name(source_desc)));
 
-		acpi_ex_do_debug_object(source_desc, 0, 0);
+		ACPI_DEBUG_OBJECT(source_desc, 0, 0);
 		break;
 
 	default:
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index d772668..5e95226 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -206,6 +206,7 @@
 #define ACPI_WARNING(plist)             acpi_warning plist
 #define ACPI_EXCEPTION(plist)           acpi_exception plist
 #define ACPI_ERROR(plist)               acpi_error plist
+#define ACPI_DEBUG_OBJECT(obj,l,i)      acpi_ex_do_debug_object(obj,l,i)
 
 #else
 
@@ -215,6 +216,7 @@
 #define ACPI_WARNING(plist)
 #define ACPI_EXCEPTION(plist)
 #define ACPI_ERROR(plist)
+#define ACPI_DEBUG_OBJECT(obj,l,i)
 
 #endif				/* ACPI_NO_ERROR_MESSAGES */
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 4447a04..4969862 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -67,6 +67,7 @@ extern u8 acpi_gbl_leave_wake_gpes_disabled;
 extern u8 acpi_gbl_use_default_register_widths;
 extern acpi_name acpi_gbl_trace_method_name;
 extern u32 acpi_gbl_trace_flags;
+extern u8 acpi_gbl_enable_aml_debug_object;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
-- 
1.6.0.6

