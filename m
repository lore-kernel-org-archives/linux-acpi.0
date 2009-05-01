From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.29.y] ACPI: Revert conflicting workaround for BIOS w/
 mangled PRT entries
Date: Fri, 01 May 2009 11:12:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905011106130.6437@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:56990 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbZEAPM6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2009 11:12:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIZ0017W0X6Y5JK@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 01 May 2009 10:12:48 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, tmb@mandriva.org

From: Zhang Rui <rui.zhang@intel.com>

upstream 82babbb3887e234c995626e4121d411ea9070ca5
backported to 2.6.29.2

2f894ef9c8b36a35d80709bedca276d2fc691941
in Linux-2.6.21 worked around BIOS with mangled _PRT entries:
http://bugzilla.kernel.org/show_bug.cgi?id=6859

d0e184abc5983281ef189db2c759d65d56eb1b80
worked around the same issue via ACPICA, and shipped in 2.6.27.

Unfortunately the two workarounds conflict:
http://bugzilla.kernel.org/show_bug.cgi?id=12270

So revert the Linux specific one.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/rscreate.c |   27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

Index: linux-2.6.29.y/drivers/acpi/acpica/rscreate.c
===================================================================
--- linux-2.6.29.y.orig/drivers/acpi/acpica/rscreate.c
+++ linux-2.6.29.y/drivers/acpi/acpica/rscreate.c
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
