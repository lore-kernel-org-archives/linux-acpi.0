From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/84] ACPICA: Fix for hang on GPE method invocation
Date: Sat, 28 Jun 2008 01:43:36 -0400
Message-ID: <57491455ced24af77f12d772ef4091da4620b6a8.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62972 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYF1Fp1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:27 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500BFARZ5MBB1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:06 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes problem where the new method argument count validation mechanism
will enter an infinite loop when a GPE method is dispatched.
Problem fixed be removing the obsolete code that passes GPE block
information to the notify handler via the control method parameter pointer.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    1 -
 drivers/acpi/dispatcher/dswstate.c |   10 ++--------
 drivers/acpi/events/evgpe.c        |    4 ----
 drivers/acpi/events/evregion.c     |    1 -
 drivers/acpi/namespace/nsinit.c    |    1 -
 drivers/acpi/namespace/nsxfeval.c  |    1 -
 drivers/acpi/parser/psxface.c      |    2 +-
 drivers/acpi/resources/rsutils.c   |    1 -
 drivers/acpi/utilities/uteval.c    |    1 -
 include/acpi/acstruct.h            |    7 -------
 10 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index 2509809..4613b9c 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -377,7 +377,6 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	}
 
 	info->parameters = &this_walk_state->operands[0];
-	info->parameter_type = ACPI_PARAM_ARGS;
 
 	status = acpi_ds_init_aml_walk(next_walk_state, NULL, method_node,
 				       obj_desc->method.aml_start,
diff --git a/drivers/acpi/dispatcher/dswstate.c b/drivers/acpi/dispatcher/dswstate.c
index 1386ced..bda23ed 100644
--- a/drivers/acpi/dispatcher/dswstate.c
+++ b/drivers/acpi/dispatcher/dswstate.c
@@ -615,14 +615,8 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 	walk_state->pass_number = pass_number;
 
 	if (info) {
-		if (info->parameter_type == ACPI_PARAM_GPE) {
-			walk_state->gpe_event_info =
-			    ACPI_CAST_PTR(struct acpi_gpe_event_info,
-					  info->parameters);
-		} else {
-			walk_state->params = info->parameters;
-			walk_state->caller_return_desc = &info->return_object;
-		}
+		walk_state->params = info->parameters;
+		walk_state->caller_return_desc = &info->return_object;
 	}
 
 	status = acpi_ps_init_scope(&walk_state->parser_state, op);
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 5354be4..a68ec0c 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -555,10 +555,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			 */
 			info->prefix_node =
 			    local_gpe_event_info.dispatch.method_node;
-			info->parameters =
-			    ACPI_CAST_PTR(union acpi_operand_object *,
-					  gpe_event_info);
-			info->parameter_type = ACPI_PARAM_GPE;
 			info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 			status = acpi_ns_evaluate(info);
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 1628f59..5ab4c01 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -219,7 +219,6 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	info->prefix_node = region_obj2->extra.method_REG;
 	info->pathname = NULL;
 	info->parameters = args;
-	info->parameter_type = ACPI_PARAM_ARGS;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 	/*
diff --git a/drivers/acpi/namespace/nsinit.c b/drivers/acpi/namespace/nsinit.c
index 6d6d930..e4c5751 100644
--- a/drivers/acpi/namespace/nsinit.c
+++ b/drivers/acpi/namespace/nsinit.c
@@ -542,7 +542,6 @@ acpi_ns_init_one_device(acpi_handle obj_handle,
 	info->prefix_node = device_node;
 	info->pathname = METHOD_NAME__INI;
 	info->parameters = NULL;
-	info->parameter_type = ACPI_PARAM_ARGS;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 	/*
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index a8d5491..b4e135e 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -182,7 +182,6 @@ acpi_evaluate_object(acpi_handle handle,
 	}
 
 	info->pathname = pathname;
-	info->parameter_type = ACPI_PARAM_ARGS;
 
 	/* Convert and validate the device handle */
 
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 5258145..5ee09e1 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -335,7 +335,7 @@ acpi_ps_update_parameter_list(struct acpi_evaluate_info *info, u16 action)
 {
 	acpi_native_uint i;
 
-	if ((info->parameter_type == ACPI_PARAM_ARGS) && (info->parameters)) {
+	if (info->parameters) {
 
 		/* Update reference count for each parameter */
 
diff --git a/drivers/acpi/resources/rsutils.c b/drivers/acpi/resources/rsutils.c
index befe230..90ed83d 100644
--- a/drivers/acpi/resources/rsutils.c
+++ b/drivers/acpi/resources/rsutils.c
@@ -679,7 +679,6 @@ acpi_rs_set_srs_method_data(struct acpi_namespace_node *node,
 	info->prefix_node = node;
 	info->pathname = METHOD_NAME__SRS;
 	info->parameters = args;
-	info->parameter_type = ACPI_PARAM_ARGS;
 	info->flags = ACPI_IGNORE_RETURN_VALUE;
 
 	/*
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 05e61be..7f1f634 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -217,7 +217,6 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 
 	info->prefix_node = prefix_node;
 	info->pathname = path;
-	info->parameter_type = ACPI_PARAM_ARGS;
 
 	/* Evaluate the object/method */
 
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index 1cc7450..818c24d 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -108,7 +108,6 @@ struct acpi_walk_state {
 	union acpi_operand_object **caller_return_desc;
 	union acpi_generic_state *control_state;	/* List of control states (nested IFs) */
 	struct acpi_namespace_node *deferred_node;	/* Used when executing deferred opcodes */
-	struct acpi_gpe_event_info *gpe_event_info;	/* Info for GPE (_Lxx/_Exx methods only */
 	union acpi_operand_object *implicit_return_obj;
 	struct acpi_namespace_node *method_call_node;	/* Called method Node */
 	union acpi_parse_object *method_call_op;	/* method_call Op if running a method */
@@ -191,16 +190,10 @@ struct acpi_evaluate_info {
 	union acpi_operand_object *return_object;
 	u8 param_count;
 	u8 pass_number;
-	u8 parameter_type;
 	u8 return_object_type;
 	u8 flags;
 };
 
-/* Types for parameter_type above */
-
-#define ACPI_PARAM_ARGS                 0
-#define ACPI_PARAM_GPE                  1
-
 /* Values for Flags above */
 
 #define ACPI_IGNORE_RETURN_VALUE        1
-- 
1.5.6.1.89.gd544

