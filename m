From: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/20] ACPI: fix boot hang w/o "noapic" on MSI MS-6390-L
Date: Fri,  9 Mar 2007 22:49:30 -0500
Message-ID: <11734985882949-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com> <11734985862291-git-send-email-len.brown@intel.com> <11734985863491-git-send-email-len.brown@intel.com> <1173498587849-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965833AbXCJDtt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:49 -0500
In-Reply-To: <1173498587849-git-send-email-len.brown@intel.com>
Message-Id: <2f894ef9c8b36a35d80709bedca276d2fc691941.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

This is a workaround to handle a BIOS bug where the
programmer exchanged the name and index fields of
a _PRT entry.  Apparently this BIOS error does not
confuse Windows and thus it lurks in the field
on various machines.

boot with "acpi=strict" to disable this workaround

http://bugzilla.kernel.org/show_bug.cgi?id=6859

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/resources/rscreate.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resources/rscreate.c b/drivers/acpi/resources/rscreate.c
index 1358c06..cc48ab0 100644
--- a/drivers/acpi/resources/rscreate.c
+++ b/drivers/acpi/resources/rscreate.c
@@ -191,6 +191,9 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 	user_prt = ACPI_CAST_PTR(struct acpi_pci_routing_table, buffer);
 
 	for (index = 0; index < number_of_elements; index++) {
+		int source_name_index = 2;
+		int source_index_index = 3;
+
 		/*
 		 * Point user_prt past this current structure
 		 *
@@ -261,10 +264,28 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		}
 
 		/*
+		 * If BIOS erroneously reversed the _PRT source_name and source_index,
+		 * then reverse them back.
+		 */
+		if (ACPI_GET_OBJECT_TYPE (sub_object_list[3]) != ACPI_TYPE_INTEGER) {
+			if (acpi_gbl_enable_interpreter_slack) {
+				source_name_index = 3;
+				source_index_index = 2;
+				printk(KERN_WARNING "ACPI: Handling Garbled _PRT entry\n");
+			} else {
+				ACPI_ERROR((AE_INFO,
+					"(PRT[%X].source_index) Need Integer, found %s",
+					index,
+					acpi_ut_get_object_type_name(sub_object_list[3])));
+				return_ACPI_STATUS(AE_BAD_DATA);
+			}
+		}
+
+		/*
 		 * 3) Third subobject: Dereference the PRT.source_name
 		 * The name may be unresolved (slack mode), so allow a null object
 		 */
-		obj_desc = sub_object_list[2];
+		obj_desc = sub_object_list[source_name_index];
 		if (obj_desc) {
 			switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
@@ -339,7 +360,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
-		obj_desc = sub_object_list[3];
+		obj_desc = sub_object_list[source_index_index];
 		if (ACPI_GET_OBJECT_TYPE(obj_desc) == ACPI_TYPE_INTEGER) {
 			user_prt->source_index = (u32) obj_desc->integer.value;
 		} else {
-- 
1.5.0.3.310.g05ef5
