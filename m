From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: revert 2f894ef9
Date: Sat, 11 Apr 2009 00:10:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904110009440.11866@localhost.localdomain>
References: <1239155069.7661.108.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:55524 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZDKEKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 00:10:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHX00E954XLCZLB@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Apr 2009 23:10:34 -0500 (CDT)
In-reply-to: <1239155069.7661.108.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

>From 8afe68ed4a7efd65761791447fc215dc577659e0 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 8 Apr 2009 09:44:29 +0800
Subject: [PATCH] ACPI: Revert conflicting workaround for BIOS w/ mangled PRT entries
X-Patchwork-Hint: ignore

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

As applied to 2.6.30-rc1

thanks,
-Len


 drivers/acpi/acpica/rscreate.c |   27 ++-------------------------
 1 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 663f692..848237d 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -191,8 +191,6 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 	user_prt = ACPI_CAST_PTR(struct acpi_pci_routing_table, buffer);
 
 	for (index = 0; index < number_of_elements; index++) {
-		int source_name_index = 2;
-		int source_index_index = 3;
 
 		/*
 		 * Point user_prt past this current structure
@@ -261,27 +259,6 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 			return_ACPI_STATUS(AE_BAD_DATA);
 		}
 
-		/*
-		 * If BIOS erroneously reversed the _PRT source_name and source_index,
-		 * then reverse them back.
-		 */
-		if ((sub_object_list[3])->common.type !=
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
@@ -304,7 +281,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		 * 3) Third subobject: Dereference the PRT.source_name
 		 * The name may be unresolved (slack mode), so allow a null object
 		 */
-		obj_desc = sub_object_list[source_name_index];
+		obj_desc = sub_object_list[2];
 		if (obj_desc) {
 			switch (obj_desc->common.type) {
 			case ACPI_TYPE_LOCAL_REFERENCE:
@@ -378,7 +355,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
-		obj_desc = sub_object_list[source_index_index];
+		obj_desc = sub_object_list[4];
 		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%X].SourceIndex) Need Integer, found %s",
-- 
1.6.2.2.485.ge3734


