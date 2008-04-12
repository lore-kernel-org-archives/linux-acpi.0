From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/73] ACPICA: Fixes a problem with control method references within packages
Date: Sat, 12 Apr 2008 00:25:19 -0400
Message-ID: <41d963a8bb59795ce677587f7c880bca86fab3e1.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753341AbYDLE2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:10 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Completes the package changes started with version 20071019.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dswexec.c |    2 +-
 drivers/acpi/executer/exresnte.c  |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dispatcher/dswexec.c b/drivers/acpi/dispatcher/dswexec.c
index 514b9d2..6af4671 100644
--- a/drivers/acpi/dispatcher/dswexec.c
+++ b/drivers/acpi/dispatcher/dswexec.c
@@ -493,7 +493,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 				op->common.node =
 				    (struct acpi_namespace_node *)op->asl.value.
-				    arg->asl.node->object;
+				    arg->asl.node;
 				acpi_ut_add_reference(op->asl.value.arg->asl.
 						      node->object);
 				return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/executer/exresnte.c b/drivers/acpi/executer/exresnte.c
index 2b3a01c..79a0d28 100644
--- a/drivers/acpi/executer/exresnte.c
+++ b/drivers/acpi/executer/exresnte.c
@@ -116,9 +116,11 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 	 * Several object types require no further processing:
 	 * 1) Device/Thermal objects don't have a "real" subobject, return the Node
 	 * 2) Method locals and arguments have a pseudo-Node
+	 * 3) 10/2007: Added method type to assist with Package construction.
 	 */
 	if ((entry_type == ACPI_TYPE_DEVICE) ||
 	    (entry_type == ACPI_TYPE_THERMAL) ||
+	    (entry_type == ACPI_TYPE_METHOD) ||
 	    (node->flags & (ANOBJ_METHOD_ARG | ANOBJ_METHOD_LOCAL))) {
 		return_ACPI_STATUS(AE_OK);
 	}
@@ -214,7 +216,6 @@ acpi_ex_resolve_node_to_value(struct acpi_namespace_node **object_ptr,
 		/* For these objects, just return the object attached to the Node */
 
 	case ACPI_TYPE_MUTEX:
-	case ACPI_TYPE_METHOD:
 	case ACPI_TYPE_POWER:
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_EVENT:
-- 
1.5.5.29.g7134

