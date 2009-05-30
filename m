From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/65] ACPICA: Fix miscellaneous warnings under gcc 4+
Date: Fri, 29 May 2009 21:41:55 -0400
Message-ID: <ba9c3f550e5792fbce2bbd7a429bf6f6d1f45fda.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbZE3BnJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:09 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF008VSORFIHE2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:52 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Some possible warnings with gcc 4+, especially with extended warnings
enabled

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsobject.c |    5 +++--
 drivers/acpi/acpica/dswstate.c |    4 ++--
 drivers/acpi/acpica/rsxface.c  |    8 ++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index dab3f48..02e6caa 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -734,7 +734,8 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 			/* Local ID (0-7) is (AML opcode - base AML_LOCAL_OP) */
 
-			obj_desc->reference.value = opcode - AML_LOCAL_OP;
+			obj_desc->reference.value =
+			    ((u32)opcode) - AML_LOCAL_OP;
 			obj_desc->reference.class = ACPI_REFCLASS_LOCAL;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
@@ -754,7 +755,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 			/* Arg ID (0-6) is (AML opcode - base AML_ARG_OP) */
 
-			obj_desc->reference.value = opcode - AML_ARG_OP;
+			obj_desc->reference.value = ((u32)opcode) - AML_ARG_OP;
 			obj_desc->reference.class = ACPI_REFCLASS_ARG;
 
 #ifndef ACPI_NO_METHOD_EXECUTION
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index 40f92bf..e46c821 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -102,7 +102,7 @@ acpi_ds_result_pop(union acpi_operand_object **object,
 	/* Return object of the top element and clean that top element result stack */
 
 	walk_state->result_count--;
-	index = walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
+	index = (u32)walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
 
 	*object = state->results.obj_desc[index];
 	if (!*object) {
@@ -186,7 +186,7 @@ acpi_ds_result_push(union acpi_operand_object * object,
 
 	/* Assign the address of object to the top free element of result stack */
 
-	index = walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
+	index = (u32)walk_state->result_count % ACPI_RESULTS_FRAME_OBJ_NUM;
 	state->results.obj_desc[index] = object;
 	walk_state->result_count++;
 
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 69a2aa5..395212b 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -338,13 +338,17 @@ acpi_resource_to_address64(struct acpi_resource *resource,
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_ADDRESS16:
 
-		address16 = (struct acpi_resource_address16 *)&resource->data;
+		address16 =
+		    ACPI_CAST_PTR(struct acpi_resource_address16,
+				  &resource->data);
 		ACPI_COPY_ADDRESS(out, address16);
 		break;
 
 	case ACPI_RESOURCE_TYPE_ADDRESS32:
 
-		address32 = (struct acpi_resource_address32 *)&resource->data;
+		address32 =
+		    ACPI_CAST_PTR(struct acpi_resource_address32,
+				  &resource->data);
 		ACPI_COPY_ADDRESS(out, address32);
 		break;
 
-- 
1.6.0.6

