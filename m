From: Len Brown <lenb@kernel.org>
Subject: [PATCH 063/103] ACPICA: Fix two additional Scope override error
 messages
Date: Wed, 16 Dec 2009 03:36:14 -0500
Message-ID: <ebdca3edd5ac61e37f2f5e7c11006c1a68d3cc7e.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762006AbZLPLGB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:01 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:57 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

These messages were using the internal path for the message
instead of using the node name.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dswload.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 1bab934..9cc2289 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -700,15 +700,16 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 		case ACPI_TYPE_BUFFER:
 
 			/*
-			 * These types we will allow, but we will change the type. This
-			 * enables some existing code of the form:
+			 * These types we will allow, but we will change the type.
+			 * This enables some existing code of the form:
 			 *
 			 *  Name (DEB, 0)
 			 *  Scope (DEB) { ... }
 			 */
 			ACPI_WARNING((AE_INFO,
-				      "Type override - [%4.4s] had invalid type (%s) for Scope operator, changed to (Scope)",
-				      buffer_ptr,
+				      "Type override - [%4.4s] had invalid type (%s) "
+				      "for Scope operator, changed to type ANY\n",
+				      acpi_ut_get_node_name(node),
 				      acpi_ut_get_type_name(node->type)));
 
 			node->type = ACPI_TYPE_ANY;
@@ -720,9 +721,10 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 			/* All other types are an error */
 
 			ACPI_ERROR((AE_INFO,
-				    "Invalid type (%s) for target of Scope operator [%4.4s]",
+				    "Invalid type (%s) for target of "
+				    "Scope operator [%4.4s] (Cannot override)",
 				    acpi_ut_get_type_name(node->type),
-				    buffer_ptr));
+				    acpi_ut_get_node_name(node)));
 
 			return (AE_AML_OPERAND_TYPE);
 		}
-- 
1.6.0.6

