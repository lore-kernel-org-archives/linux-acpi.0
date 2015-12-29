From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/42] ACPICA: Debug Object: Cleanup output
Date: Tue, 29 Dec 2015 13:57:01 +0800
Message-ID: <fe085827f51b133f1afb8c3308a1da36d44ad920.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48994 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbbL2F5F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:57:05 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 05492c4a7d1e106eb871a5e1357ed564d25740e5

1) Make the timer value output optional
2) Allow empty lines via null string or simple newline
3) No need for the object type name for strings and integers
4) Miscellaneous cleanup of output

Link: https://github.com/acpica/acpica/commit/05492c4a
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdebug.c |   67 +++++++++++++++++++++++++++++------------
 include/acpi/acpixf.h         |    4 +++
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index 815442b..a203335 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -88,20 +88,39 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 		return_VOID;
 	}
 
-	/*
-	 * We will emit the current timer value (in microseconds) with each
-	 * debug output. Only need the lower 26 bits. This allows for 67
-	 * million microseconds or 67 seconds before rollover.
-	 */
-	timer = ((u32)acpi_os_get_timer() / 10);	/* (100 nanoseconds to microseconds) */
-	timer &= 0x03FFFFFF;
+	/* Null string or newline -- don't emit the line header */
+
+	if ((ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) &&
+	    (source_desc->common.type == ACPI_TYPE_STRING)) {
+		if ((source_desc->string.length == 0) ||
+		    ((source_desc->string.length == 1) &&
+		     (*source_desc->string.pointer == '\n'))) {
+			acpi_os_printf("\n");
+			return_VOID;
+		}
+	}
 
 	/*
 	 * Print line header as long as we are not in the middle of an
 	 * object display
 	 */
 	if (!((level > 0) && index == 0)) {
-		acpi_os_printf("[ACPI Debug %.8u] %*s", timer, level, " ");
+		if (acpi_gbl_display_debug_timer) {
+			/*
+			 * We will emit the current timer value (in microseconds) with each
+			 * debug output. Only need the lower 26 bits. This allows for 67
+			 * million microseconds or 67 seconds before rollover.
+			 *
+			 * Convert 100 nanosecond units to microseconds
+			 */
+			timer = ((u32)acpi_os_get_timer() / 10);
+			timer &= 0x03FFFFFF;
+
+			acpi_os_printf("[ACPI Debug T=0x%8.8X] %*s", timer,
+				       level, " ");
+		} else {
+			acpi_os_printf("[ACPI Debug] %*s", level, " ");
+		}
 	}
 
 	/* Display the index for package output only */
@@ -116,8 +135,15 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 	}
 
 	if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) {
-		acpi_os_printf("%s ",
-			       acpi_ut_get_object_type_name(source_desc));
+
+		/* No object type prefix needed for integers and strings */
+
+		if ((source_desc->common.type != ACPI_TYPE_INTEGER) &&
+		    (source_desc->common.type != ACPI_TYPE_STRING)) {
+			acpi_os_printf("%s ",
+				       acpi_ut_get_object_type_name
+				       (source_desc));
+		}
 
 		if (!acpi_ut_valid_internal_object(source_desc)) {
 			acpi_os_printf("%p, Invalid Internal Object!\n",
@@ -126,7 +152,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 		}
 	} else if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) ==
 		   ACPI_DESC_TYPE_NAMED) {
-		acpi_os_printf("%s: %p\n",
+		acpi_os_printf("%s (Node %p)\n",
 			       acpi_ut_get_type_name(((struct
 						       acpi_namespace_node *)
 						      source_desc)->type),
@@ -164,14 +190,12 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	case ACPI_TYPE_STRING:
 
-		acpi_os_printf("[0x%.2X] \"%s\"\n",
-			       source_desc->string.length,
-			       source_desc->string.pointer);
+		acpi_os_printf("\"%s\"\n", source_desc->string.pointer);
 		break;
 
 	case ACPI_TYPE_PACKAGE:
 
-		acpi_os_printf("[Contains 0x%.2X Elements]\n",
+		acpi_os_printf("(Contains 0x%.2X Elements):\n",
 			       source_desc->package.count);
 
 		/* Output the entire contents of the package */
@@ -250,11 +274,14 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 			if (ACPI_GET_DESCRIPTOR_TYPE
 			    (source_desc->reference.object) ==
 			    ACPI_DESC_TYPE_NAMED) {
-				acpi_ex_do_debug_object(((struct
-							  acpi_namespace_node *)
+
+				/* Reference object is a namespace node */
+
+				acpi_ex_do_debug_object(ACPI_CAST_PTR
+							(union
+							 acpi_operand_object,
 							 source_desc->reference.
-							 object)->object,
-							level + 4, 0);
+							 object), level + 4, 0);
 			} else {
 				object_desc = source_desc->reference.object;
 				value = source_desc->reference.value;
@@ -300,7 +327,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	default:
 
-		acpi_os_printf("%p\n", source_desc);
+		acpi_os_printf("(Descriptor %p)\n", source_desc);
 		break;
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5dfab9c..d60507b7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -263,6 +263,10 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_trace_dbg_layer, ACPI_TRACE_LAYER_DEFAULT);
 ACPI_INIT_GLOBAL(u32, acpi_dbg_level, ACPI_DEBUG_DEFAULT);
 ACPI_INIT_GLOBAL(u32, acpi_dbg_layer, 0);
 
+/* Optionally enable timer output with Debug Object output */
+
+ACPI_INIT_GLOBAL(u8, acpi_gbl_display_debug_timer, FALSE);
+
 /*
  * Debugger command handshake globals. Host OSes need to access these
  * variables to implement their own command handshake mechanism.
-- 
1.7.10

