From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 25/27] ACPICA: Interpreter: Fix Store() when implicit conversion is not possible.
Date: Mon, 31 Dec 2012 08:11:45 +0800
Message-ID: <b0c2403adf73c22b760d8673afa5ffff24cab263.1356668535.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5223 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277Ab2LaAMQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:12:16 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

For the cases such as a store of a string to an existing package
object, implement the store as a CopyObject().
This is a small departure from the ACPI specification which states
that the control method should be aborted in this case. However,
ASLTS suite depends on this behavior.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exstore.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 90431f1..4ff37e8 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -487,14 +487,33 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 	default:
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Storing %s (%p) directly into node (%p) with no implicit conversion\n",
+				  "Storing [%s] (%p) directly into node [%s] (%p)"
+				  " with no implicit conversion\n",
 				  acpi_ut_get_object_type_name(source_desc),
-				  source_desc, node));
+				  source_desc,
+				  acpi_ut_get_object_type_name(target_desc),
+				  node));
 
-		/* No conversions for all other types. Just attach the source object */
+		/*
+		 * No conversions for all other types. Directly store a copy of
+		 * the source object. NOTE: This is a departure from the ACPI
+		 * spec, which states "If conversion is impossible, abort the
+		 * running control method".
+		 *
+		 * This code implements "If conversion is impossible, treat the
+		 * Store operation as a CopyObject".
+		 */
+		status =
+		    acpi_ut_copy_iobject_to_iobject(source_desc, &new_desc,
+						    walk_state);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 
-		status = acpi_ns_attach_object(node, source_desc,
-					       source_desc->common.type);
+		status =
+		    acpi_ns_attach_object(node, new_desc,
+					  new_desc->common.type);
+		acpi_ut_remove_reference(new_desc);
 		break;
 	}
 
-- 
1.7.10

