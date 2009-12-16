From: Len Brown <lenb@kernel.org>
Subject: [PATCH 073/103] ACPICA: Module-level code: enable _REG execution in
 same scope
Date: Wed, 16 Dec 2009 03:36:24 -0500
Message-ID: <e31c32cfe52e98344dad28853c3331879f72c4b0.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762018AbZLPLGP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:15 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:06:01 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

This change enables the execution of _REG methods that appear
in the same scope as the module-level code, in resonse to an
operation region declaration within the module-level code.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acobject.h |    6 +++++-
 drivers/acpi/acpica/dsmethod.c |    2 +-
 drivers/acpi/acpica/evrgnini.c |   15 +++++++++++++++
 drivers/acpi/acpica/nsaccess.c |    2 +-
 drivers/acpi/acpica/nseval.c   |   12 ++++++++++++
 drivers/acpi/acpica/psxface.c  |    3 ++-
 6 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index b39d682..64062b1 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -180,7 +180,11 @@ struct acpi_object_method {
 	u8 sync_level;
 	union acpi_operand_object *mutex;
 	u8 *aml_start;
-	ACPI_INTERNAL_METHOD implementation;
+	union {
+		ACPI_INTERNAL_METHOD implementation;
+		union acpi_operand_object *handler;
+	} extra;
+
 	u32 aml_length;
 	u8 thread_count;
 	acpi_owner_id owner_id;
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 567a489..e786f9f 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -414,7 +414,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 	/* Invoke an internal method if necessary */
 
 	if (obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
-		status = obj_desc->method.implementation(next_walk_state);
+		status = obj_desc->method.extra.implementation(next_walk_state);
 		if (status == AE_OK) {
 			status = AE_CTRL_TERMINATE;
 		}
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index cf29c49..ff16805 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -575,6 +575,21 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 				handler_obj = obj_desc->thermal_zone.handler;
 				break;
 
+			case ACPI_TYPE_METHOD:
+				/*
+				 * If we are executing module level code, the original
+				 * Node's object was replaced by this Method object and we
+				 * saved the handler in the method object.
+				 *
+				 * See acpi_ns_exec_module_code
+				 */
+				if (obj_desc->method.
+				    flags & AOPOBJ_MODULE_LEVEL) {
+					handler_obj =
+					    obj_desc->method.extra.handler;
+				}
+				break;
+
 			default:
 				/* Ignore other objects */
 				break;
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 9c3cdbe..d622ba7 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -165,7 +165,7 @@ acpi_status acpi_ns_root_initialize(void)
 
 				obj_desc->method.method_flags =
 				    AML_METHOD_INTERNAL_ONLY;
-				obj_desc->method.implementation =
+				obj_desc->method.extra.implementation =
 				    acpi_ut_osi_implementation;
 #endif
 				break;
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 65e0d1a..af9fe91 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -381,6 +381,18 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 				    method_obj->method.next_object);
 	type = acpi_ns_get_type(parent_node);
 
+	/*
+	 * Get the region handler and save it in the method object. We may need
+	 * this if an operation region declaration causes a _REG method to be run.
+	 *
+	 * We can't do this in acpi_ps_link_module_code because
+	 * acpi_gbl_root_node->Object is NULL at PASS1.
+	 */
+	if ((type == ACPI_TYPE_DEVICE) && parent_node->object) {
+		method_obj->method.extra.handler =
+		    parent_node->object->device.handler;
+	}
+
 	/* Must clear next_object (acpi_ns_attach_object needs the field) */
 
 	method_obj->method.next_object = NULL;
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index 12934ad..d0c1b91 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -287,7 +287,8 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 	/* Invoke an internal method if necessary */
 
 	if (info->obj_desc->method.method_flags & AML_METHOD_INTERNAL_ONLY) {
-		status = info->obj_desc->method.implementation(walk_state);
+		status =
+		    info->obj_desc->method.extra.implementation(walk_state);
 		info->return_object = walk_state->return_desc;
 
 		/* Cleanup states */
-- 
1.6.0.6

