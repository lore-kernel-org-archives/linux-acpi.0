From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH v2 3/3] ACPICA: Dispatcher: Tune interpreter lock around acpi_ev_initialize_region()
Date: Wed, 26 Oct 2016 15:42:01 +0800
Message-ID: <ec6b92a8e6881ce1fc16f8b5c969bfc269c5412f.1477465173.git.lv.zheng@intel.com>
References: <cover.1477372449.git.lv.zheng@intel.com> <cover.1477465173.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1477465173.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

In code path of acpi_ev_initialize_region(), there are namespace modification
code unlocked. This patch tunes the code to make sure such modification are
locked. Lv Zheng.

Fixes: 74f51b80a0c4 ("ACPICA: Namespace: Fix dynamic table loading issues")
Tested-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsinit.c   | 11 +++--------
 drivers/acpi/acpica/dsmethod.c | 12 +++---------
 drivers/acpi/acpica/dswload2.c |  2 --
 drivers/acpi/acpica/evrgnini.c |  3 +++
 drivers/acpi/acpica/nsload.c   |  2 ++
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index f1e6dcc..54d48b9 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -46,6 +46,7 @@
 #include "acdispat.h"
 #include "acnamesp.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dsinit")
@@ -214,23 +215,17 @@ acpi_ds_initialize_objects(u32 table_index,
 
 	/* Walk entire namespace from the supplied root */
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/*
 	 * We don't use acpi_walk_namespace since we do not want to acquire
 	 * the namespace reader lock.
 	 */
 	status =
 	    acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
-				   ACPI_NS_WALK_UNLOCK, acpi_ds_init_one_object,
-				   NULL, &info, NULL);
+				   0, acpi_ds_init_one_object, NULL, &info,
+				   NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
 	status = acpi_get_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 5997e59..2b3210f 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -99,14 +99,11 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 			  "Method auto-serialization parse [%4.4s] %p\n",
 			  acpi_ut_get_node_name(node), node));
 
-	acpi_ex_enter_interpreter();
-
 	/* Create/Init a root op for the method parse tree */
 
 	op = acpi_ps_alloc_op(AML_METHOD_OP, obj_desc->method.aml_start);
 	if (!op) {
-		status = AE_NO_MEMORY;
-		goto unlock;
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	acpi_ps_set_name(op, node->name.integer);
@@ -118,8 +115,7 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	    acpi_ds_create_walk_state(node->owner_id, NULL, NULL, NULL);
 	if (!walk_state) {
 		acpi_ps_free_op(op);
-		status = AE_NO_MEMORY;
-		goto unlock;
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	status = acpi_ds_init_aml_walk(walk_state, op, node,
@@ -128,7 +124,7 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	if (ACPI_FAILURE(status)) {
 		acpi_ds_delete_walk_state(walk_state);
 		acpi_ps_free_op(op);
-		goto unlock;
+		return_ACPI_STATUS(status);
 	}
 
 	walk_state->descending_callback = acpi_ds_detect_named_opcodes;
@@ -138,8 +134,6 @@ acpi_ds_auto_serialize_method(struct acpi_namespace_node *node,
 	status = acpi_ps_parse_aml(walk_state);
 
 	acpi_ps_delete_parse_tree(op);
-unlock:
-	acpi_ex_exit_interpreter();
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index 028b22a..e362182 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -607,11 +607,9 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 				}
 			}
 
-			acpi_ex_exit_interpreter();
 			status =
 			    acpi_ev_initialize_region
 			    (acpi_ns_get_attached_object(node), FALSE);
-			acpi_ex_enter_interpreter();
 
 			if (ACPI_FAILURE(status)) {
 				/*
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 3843f1f..75ddd16 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -45,6 +45,7 @@
 #include "accommon.h"
 #include "acevents.h"
 #include "acnamesp.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evrgnini")
@@ -597,9 +598,11 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 					}
 				}
 
+				acpi_ex_exit_interpreter();
 				status =
 				    acpi_ev_execute_reg_method(region_obj,
 							       ACPI_REG_CONNECT);
+				acpi_ex_enter_interpreter();
 
 				if (acpi_ns_locked) {
 					status =
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 334d3c5..d1f2014 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -137,7 +137,9 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "**** Begin Table Object Initialization\n"));
 
+	acpi_ex_enter_interpreter();
 	status = acpi_ds_initialize_objects(table_index, node);
+	acpi_ex_exit_interpreter();
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "**** Completed Table Object Initialization\n"));
-- 
2.7.4
