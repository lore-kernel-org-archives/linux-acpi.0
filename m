From: Len Brown <lenb@kernel.org>
Subject: [PATCH 110/122] ACPICA: Fix fault after mem allocation failure in AML
 parser
Date: Thu, 23 Oct 2008 02:39:24 -0400
Message-ID: <c35def2118d3d7cceb0f69d6707f613a7473df15.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875AbYJWGoN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:10 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fixes a crash if a memory allocation fails during the Op completion
routine acpi_ps_complete_this_op().

http://www.acpica.org/bugzilla/show_bug.cgi?id=492

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psparse.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/parser/psparse.c b/drivers/acpi/parser/psparse.c
index 15e1702..52caaf6 100644
--- a/drivers/acpi/parser/psparse.c
+++ b/drivers/acpi/parser/psparse.c
@@ -137,6 +137,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 	union acpi_parse_object *next;
 	const struct acpi_opcode_info *parent_info;
 	union acpi_parse_object *replacement_op = NULL;
+	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_this_op, op);
 
@@ -186,7 +187,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 			replacement_op =
 			    acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
 			if (!replacement_op) {
-				goto allocate_error;
+				status = AE_NO_MEMORY;
 			}
 			break;
 
@@ -211,7 +212,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 				replacement_op =
 				    acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
 				if (!replacement_op) {
-					goto allocate_error;
+					status = AE_NO_MEMORY;
 				}
 			} else
 			    if ((op->common.parent->common.aml_opcode ==
@@ -226,13 +227,13 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 					    acpi_ps_alloc_op(op->common.
 							     aml_opcode);
 					if (!replacement_op) {
-						goto allocate_error;
+						status = AE_NO_MEMORY;
+					} else {
+						replacement_op->named.data =
+						    op->named.data;
+						replacement_op->named.length =
+						    op->named.length;
 					}
-
-					replacement_op->named.data =
-					    op->named.data;
-					replacement_op->named.length =
-					    op->named.length;
 				}
 			}
 			break;
@@ -242,7 +243,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 			replacement_op =
 			    acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
 			if (!replacement_op) {
-				goto allocate_error;
+				status = AE_NO_MEMORY;
 			}
 		}
 
@@ -302,14 +303,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state * walk_state,
 	/* Now we can actually delete the subtree rooted at Op */
 
 	acpi_ps_delete_parse_tree(op);
-	return_ACPI_STATUS(AE_OK);
-
-      allocate_error:
-
-	/* Always delete the subtree, even on error */
-
-	acpi_ps_delete_parse_tree(op);
-	return_ACPI_STATUS(AE_NO_MEMORY);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
-- 
1.5.5.1

