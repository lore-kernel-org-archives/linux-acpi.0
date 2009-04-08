From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: revert 2f894ef9
Date: Wed, 08 Apr 2009 09:44:29 +0800
Message-ID: <1239155069.7661.108.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33844 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZDHBo3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Apr 2009 21:44:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>


commit 2f894ef9 and commit d0e184ab are fixes for the same issue.
revert 2f894ef9 to be consistent with ACPICA.

http://bugzilla.kernel.org/show_bug.cgi?id=12270

CC: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpica/rscreate.c |   27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/rscreate.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/rscreate.c
+++ linux-2.6/drivers/acpi/acpica/rscreate.c
@@ -191,8 +191,6 @@ acpi_rs_create_pci_routing_table(union a
 	user_prt = ACPI_CAST_PTR(struct acpi_pci_routing_table, buffer);
 
 	for (index = 0; index < number_of_elements; index++) {
-		int source_name_index = 2;
-		int source_index_index = 3;
 
 		/*
 		 * Point user_prt past this current structure
@@ -261,27 +259,6 @@ acpi_rs_create_pci_routing_table(union a
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
-		/*
-		 * If BIOS erroneously reversed the _PRT source_name and source_index,
-		 * then reverse them back.
-		 */
-		if (ACPI_GET_OBJECT_TYPE(sub_object_list[3]) !=
-		    ACPI_TYPE_INTEGER) {
-			if (acpi_gbl_enable_interpreter_slack) {
-				source_name_index = 3;
-				source_index_index = 2;
-				printk(KERN_WARNING
-				       "ACPI: Handling Garbled _PRT entry\n");
-			} else {
-				ACPI_ERROR((AE_INFO,
-					    "(PRT[%X].source_index) Need Integer, found %s",
-					    index,
-					    acpi_ut_get_object_type_name
-					    (sub_object_list[3])));
-				return_ACPI_STATUS(AE_BAD_DATA);
-			}
-		}
-
 		user_prt->pin = (u32) obj_desc->integer.value;
 
 		/*
@@ -305,7 +282,7 @@ acpi_rs_create_pci_routing_table(union a
 		 * 3) Third subobject: Dereference the PRT.source_name
 		 * The name may be unresolved (slack mode), so allow a null object
 		 */
-		obj_desc = sub_object_list[source_name_index];
+		obj_desc = sub_object_list[2];
 		if (obj_desc) {
 			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
@@ -379,7 +356,7 @@ acpi_rs_create_pci_routing_table(union a
 
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
-		obj_desc = sub_object_list[source_index_index];
+		obj_desc = sub_object_list[3];
 		if (ACPI_GET_OBJECT_TYPE(obj_desc) != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].SourceIndex) Need Integer, found %s",


