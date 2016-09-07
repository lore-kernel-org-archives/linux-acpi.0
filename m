From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/14] ACPICA: Dispatcher: Fix a mutex issue for method auto serialization
Date: Wed,  7 Sep 2016 14:07:16 +0800
Message-ID: <3d8410492e558da541b50ef132f85c73f91d6509.1473226204.git.lv.zheng@intel.com>
References: <cover.1473226203.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1399 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754547AbcIGGHX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Sep 2016 02:07:23 -0400
In-Reply-To: <cover.1473226203.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit fd305eda14f1a1e684edef4fac53f194bf00ed3f

This patch fixes an issue with acpi_ds_auto_serialized_method().
The parser will invoke acpi_ex_release_all_mutexes(), which in return
cause mutexes held in ACPI_ERROR_METHOD() failed. Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1324
Link: https://github.com/acpica/acpica/commit/fd305eda
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Greg White <gwhite@kupulau.com>
Tested-by: Dutch Guy <lucht_piloot@gmx.net>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |   10 ++++++++--
 drivers/acpi/acpica/psparse.c  |    2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 25b387a..32e9ddc 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -99,11 +99,14 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 			  "Method auto-serialization parse [%4.4s] %p\n",
 			  acpi_ut_get_node_name(node), node));
 
+	acpi_ex_enter_interpreter();
+
 	/* Create/Init a root op for the method parse tree */
 
 	op = acpi_ps_alloc_op(AML_METHOD_OP, obj_desc->method.aml_start);
 	if (!op) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto unlock;
 	}
 
 	acpi_ps_set_name(op, node->name.integer);
@@ -115,7 +118,8 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	    acpi_ds_create_walk_state(node->owner_id, NULL, NULL, NULL);
 	if (!walk_state) {
 		acpi_ps_free_op(op);
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto unlock;
 	}
 
 	status = acpi_ds_init_aml_walk(walk_state, op, node,
@@ -134,6 +138,8 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	status = acpi_ps_parse_aml(walk_state);
 
 	acpi_ps_delete_parse_tree(op);
+unlock:
+	acpi_ex_exit_interpreter();
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 3aa9162..1ce26d9 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -537,9 +537,11 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
 			/* Either the method parse or actual execution failed */
 
+			acpi_ex_exit_interpreter();
 			ACPI_ERROR_METHOD("Method parse/execution failed",
 					  walk_state->method_node, NULL,
 					  status);
+			acpi_ex_enter_interpreter();
 
 			/* Check for possible multi-thread reentrancy problem */
 
-- 
1.7.10

