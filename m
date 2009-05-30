From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/65] ACPICA: Region deletion: Ensure region object is removed
 from handler list
Date: Fri, 29 May 2009 21:42:10 -0400
Message-ID: <3362a6badb4fe75e198885b125b21ccf846861b4.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbZE3Bmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:54 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00B2MORIFTT3@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:55 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Prevents a possible fault when a dynamic operation region is
deleted. ACPICA BZ 507.

http://acpica.org/bugzilla/show_bug.cgi?id=507

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utdelete.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index a5ee23b..bc17103 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -75,6 +75,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 	union acpi_operand_object *handler_desc;
 	union acpi_operand_object *second_desc;
 	union acpi_operand_object *next_desc;
+	union acpi_operand_object **last_obj_ptr;
 
 	ACPI_FUNCTION_TRACE_PTR(ut_delete_internal_obj, object);
 
@@ -223,6 +224,26 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			 */
 			handler_desc = object->region.handler;
 			if (handler_desc) {
+				next_desc =
+				    handler_desc->address_space.region_list;
+				last_obj_ptr =
+				    &handler_desc->address_space.region_list;
+
+				/* Remove the region object from the handler's list */
+
+				while (next_desc) {
+					if (next_desc == object) {
+						*last_obj_ptr =
+						    next_desc->region.next;
+						break;
+					}
+
+					/* Walk the linked list of handler */
+
+					last_obj_ptr = &next_desc->region.next;
+					next_desc = next_desc->region.next;
+				}
+
 				if (handler_desc->address_space.handler_flags &
 				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
 
-- 
1.6.0.6

