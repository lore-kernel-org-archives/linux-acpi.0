From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/73] ACPICA: Updates for Debug object output
Date: Sat, 12 Apr 2008 00:25:51 -0400
Message-ID: <408f59a6c9e8a82faa0dc09a0ca04cb1469c9233.1207973801.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757278AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented several improvements for the output of the ASL "Debug"
object to clarify and keep all data for a given object on one
output line.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exstore.c |   76 ++++++++++++++++++++++++++------------
 1 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 36c0fcc..dbc5e18 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -84,8 +84,12 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 
 	ACPI_FUNCTION_TRACE_PTR(ex_do_debug_object, source_desc);
 
-	ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[ACPI Debug] %*s",
-			      level, " "));
+	/* Print line header as long as we are not in the middle of an object display */
+
+	if (!((level > 0) && index == 0)) {
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[ACPI Debug] %*s",
+				      level, " "));
+	}
 
 	/* Display index for package output only */
 
@@ -95,12 +99,12 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 	}
 
 	if (!source_desc) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "<Null Object>\n"));
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "[Null Object]\n"));
 		return_VOID;
 	}
 
 	if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_OPERAND) {
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%s: ",
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%s ",
 				      acpi_ut_get_object_type_name
 				      (source_desc)));
 
@@ -162,7 +166,7 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 	case ACPI_TYPE_PACKAGE:
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-				      "[0x%.2X Elements]\n",
+				      "[Contains 0x%.2X Elements]\n",
 				      source_desc->package.count));
 
 		/* Output the entire contents of the package */
@@ -194,8 +198,47 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 			break;
 		}
 
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "\n"));
-		if (source_desc->reference.object) {
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "  "));
+
+		/* Check for valid node first, then valid object */
+
+		if (source_desc->reference.node) {
+			if (ACPI_GET_DESCRIPTOR_TYPE
+			    (source_desc->reference.node) !=
+			    ACPI_DESC_TYPE_NAMED) {
+				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
+						      " %p - Not a valid namespace node\n",
+						      source_desc->reference.
+						      node));
+			} else {
+				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
+						      "Node %p [%4.4s] ",
+						      source_desc->reference.
+						      node,
+						      (source_desc->reference.
+						       node)->name.ascii));
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
 			if (ACPI_GET_DESCRIPTOR_TYPE
 			    (source_desc->reference.object) ==
 			    ACPI_DESC_TYPE_NAMED) {
@@ -208,28 +251,13 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 				acpi_ex_do_debug_object(source_desc->reference.
 							object, level + 4, 0);
 			}
-		} else if (source_desc->reference.node) {
-			if (ACPI_GET_DESCRIPTOR_TYPE
-			    (source_desc->reference.node) !=
-			    ACPI_DESC_TYPE_NAMED) {
-				ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT,
-						      " %p - Not a valid namespace node\n",
-						      source_desc->reference.
-						      node));
-			} else {
-				acpi_ex_do_debug_object((source_desc->reference.
-							 node)->object,
-							level + 4, 0);
-			}
 		}
 		break;
 
 	default:
 
-		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%p %s\n",
-				      source_desc,
-				      acpi_ut_get_object_type_name
-				      (source_desc)));
+		ACPI_DEBUG_PRINT_RAW((ACPI_DB_DEBUG_OBJECT, "%p\n",
+				      source_desc));
 		break;
 	}
 
-- 
1.5.5.29.g7134

