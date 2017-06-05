From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 41/53] ACPICA: Fix for Device/Thermal objects with ObjectType and DerefOf
Date: Mon,  5 Jun 2017 16:41:18 +0800
Message-ID: <2a0e1a9935083963ca8502fb451a4751a6364e40.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20066 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIlV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:21 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 89565151aa4db7b546d4935b187bf2c4a86885ee

These types must be special cased because the namespace node
does not contain a subobject as do all other types.

Link: https://github.com/acpica/acpica/commit/89565151
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exoparg1.c | 25 +++++++++++++++++++------
 drivers/acpi/acpica/exresolv.c | 23 ++++++++++++++++++-----
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index e327349..f787651 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -921,13 +921,26 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 			 * This is a deref_of (object_reference)
 			 * Get the actual object from the Node (This is the dereference).
 			 * This case may only happen when a local_x or arg_x is
-			 * dereferenced above.
+			 * dereferenced above, or for references to device and
+			 * thermal objects.
 			 */
-			return_desc = acpi_ns_get_attached_object((struct
-								   acpi_namespace_node
-								   *)
-								  operand[0]);
-			acpi_ut_add_reference(return_desc);
+			switch (((struct acpi_namespace_node *)operand[0])->
+				type) {
+			case ACPI_TYPE_DEVICE:
+			case ACPI_TYPE_THERMAL:
+
+				/* These types have no node subobject, return the NS node */
+
+				return_desc = operand[0];
+				break;
+
+			default:
+				/* For most types, get the object attached to the node */
+
+				return_desc = acpi_ns_get_attached_object((struct acpi_namespace_node *)operand[0]);
+				acpi_ut_add_reference(return_desc);
+				break;
+			}
 		} else {
 			/*
 			 * This must be a reference object produced by either the
diff --git a/drivers/acpi/acpica/exresolv.c b/drivers/acpi/acpica/exresolv.c
index aa8c6fd..5e1854ea 100644
--- a/drivers/acpi/acpica/exresolv.c
+++ b/drivers/acpi/acpica/exresolv.c
@@ -368,11 +368,24 @@ acpi_ex_resolve_multiple(struct acpi_walk_state *walk_state,
 								*)obj_desc);
 		}
 
-		if (!obj_desc) {
-			ACPI_ERROR((AE_INFO,
-				    "[%4.4s] Node is unresolved or uninitialized",
-				    acpi_ut_get_node_name(node)));
-			return_ACPI_STATUS(AE_AML_UNINITIALIZED_NODE);
+		switch (type) {
+		case ACPI_TYPE_DEVICE:
+		case ACPI_TYPE_THERMAL:
+
+			/* These types have no attached subobject */
+			break;
+
+		default:
+
+			/* All other types require a subobject */
+
+			if (!obj_desc) {
+				ACPI_ERROR((AE_INFO,
+					    "[%4.4s] Node is unresolved or uninitialized",
+					    acpi_ut_get_node_name(node)));
+				return_ACPI_STATUS(AE_AML_UNINITIALIZED_NODE);
+			}
+			break;
 		}
 		break;
 
-- 
2.7.4

