From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/17] ACPICA: Cleanup of _PRT parsing code
Date: Thu, 12 Jun 2008 00:35:14 -0400
Message-ID: <3a58b49b8750ec0d719f9c83429e16c206c35307.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36493 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYFLEfY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:24 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C00KWY22Z2YZ1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:35:24 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed extraneous else clauses, other general cleanup.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/resources/rscreate.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/resources/rscreate.c b/drivers/acpi/resources/rscreate.c
index 70c84ec..7804a8c 100644
--- a/drivers/acpi/resources/rscreate.c
+++ b/drivers/acpi/resources/rscreate.c
@@ -181,9 +181,9 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 	}
 
 	/*
-	 * Loop through the ACPI_INTERNAL_OBJECTS - Each object
-	 * should be a package that in turn contains an
-	 * acpi_integer Address, a u8 Pin, a Name and a u8 source_index.
+	 * Loop through the ACPI_INTERNAL_OBJECTS - Each object should be a
+	 * package that in turn contains an acpi_integer Address, a u8 Pin,
+	 * a Name, and a u8 source_index.
 	 */
 	top_object_list = package_object->package.elements;
 	number_of_elements = package_object->package.count;
@@ -240,9 +240,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 1) First subobject: Dereference the PRT.Address */
 
 		obj_desc = sub_object_list[0];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
-			user_prt->address = obj_desc->integer.value;
-		} else {
+		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].Address) Need Integer, found %s",
 				    index,
@@ -250,12 +248,12 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
+		user_prt->address = obj_desc->integer.value;
+
 		/* 2) Second subobject: Dereference the PRT.Pin */
 
 		obj_desc = sub_object_list[1];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
-			user_prt->pin = (u32) obj_desc->integer.value;
-		} else {
+		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].Pin) Need Integer, found %s",
 				    index,
@@ -284,6 +282,8 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			}
 		}
 
+		user_prt->pin = (u32) obj_desc->integer.value;
+
 		/*
 		 * If the BIOS has erroneously reversed the _PRT source_name (index 2)
 		 * and the source_index (index 3), fix it. _PRT is important enough to
@@ -381,9 +381,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
 		obj_desc = sub_object_list[source_index_index];
-		if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
-			user_prt->source_index = (u32) obj_desc->integer.value;
-		} else {
+		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].SourceIndex) Need Integer, found %s",
 				    index,
@@ -391,6 +389,8 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
+		user_prt->source_index = (u32) obj_desc->integer.value;
+
 		/* Point to the next union acpi_operand_object in the top level package */
 
 		top_object_list++;
-- 
1.5.6.rc2.26.g8c37

