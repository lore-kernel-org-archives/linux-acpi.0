From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][RFC][PATCH 3/3] ACPI / ACPICA: Reduce code duplication related to GPE lookup
Date: Sat, 13 Mar 2010 00:14:39 +0100
Message-ID: <201003130014.39568.rjw@sisk.pl>
References: <201003080034.11053.rjw@sisk.pl> <201003080037.13241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57903 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933445Ab0CLXMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Mar 2010 18:12:09 -0500
In-Reply-To: <201003080037.13241.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

There is some code duplication related to the looking up a GPE in a
GPE block.  Namely, the same code construct, which is quite difficult
to read and inefficient, is used in three different places (two times
in acpi_ev_get_gpe_event_info() and once in
acpi_ev_match_prw_and_gpe()).  To reduce the code duplication move it
to a separate function and clean it up.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
As you noticed, the same piece of code is actually used in one more place,
so it's possible to reduce the code duplication even more.

Appended is updated patch doing that.

Thanks,
Rafael
---
 drivers/acpi/acpica/acevents.h |    4 ++
 drivers/acpi/acpica/evgpe.c    |   58 ++++++++++++++++++++++++-----------------
 drivers/acpi/acpica/evgpeblk.c |   14 +++------
 3 files changed, 44 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -168,6 +168,33 @@ acpi_status acpi_ev_disable_gpe(struct a
 	return_ACPI_STATUS(status);
 }
 
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_gpeblk_event_info
+ *
+ * PARAMETERS:  gpe_block           - GPE block to search
+ *              gpe_number          - Raw GPE number
+ *
+ * RETURN:      A GPE event_info struct if found. NULL if not found
+ *
+ ******************************************************************************/
+
+struct acpi_gpe_event_info *acpi_ev_gpeblk_event_info(
+					struct acpi_gpe_block_info *gpe_block,
+					u32 gpe_number)
+{
+	u32 gpe_index, gpe_count;
+
+	if (!gpe_block || gpe_number < gpe_block->block_base_number)
+		return (NULL);
+
+	gpe_index = gpe_number - gpe_block->block_base_number;
+	gpe_count = gpe_block->register_count * ACPI_GPE_REGISTER_WIDTH;
+	return gpe_index < gpe_count ?
+		(&gpe_block->event_info[gpe_index]) : (NULL);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_get_gpe_event_info
@@ -189,7 +216,7 @@ struct acpi_gpe_event_info *acpi_ev_get_
 						       u32 gpe_number)
 {
 	union acpi_operand_object *obj_desc;
-	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_event_info *gpe_info;
 	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
@@ -201,18 +228,11 @@ struct acpi_gpe_event_info *acpi_ev_get_
 		/* Examine GPE Block 0 and 1 (These blocks are permanent) */
 
 		for (i = 0; i < ACPI_MAX_GPE_BLOCKS; i++) {
-			gpe_block = acpi_gbl_gpe_fadt_blocks[i];
-			if (gpe_block) {
-				if ((gpe_number >= gpe_block->block_base_number)
-				    && (gpe_number <
-					gpe_block->block_base_number +
-					(gpe_block->register_count * 8))) {
-					return (&gpe_block->
-						event_info[gpe_number -
-							   gpe_block->
-							   block_base_number]);
-				}
-			}
+			gpe_info = acpi_ev_gpeblk_event_info(
+						acpi_gbl_gpe_fadt_blocks[i],
+						gpe_number);
+			if (gpe_info)
+				return (gpe_info);
 		}
 
 		/* The gpe_number was not in the range of either FADT GPE block */
@@ -228,16 +248,8 @@ struct acpi_gpe_event_info *acpi_ev_get_
 		return (NULL);
 	}
 
-	gpe_block = obj_desc->device.gpe_block;
-
-	if ((gpe_number >= gpe_block->block_base_number) &&
-	    (gpe_number <
-	     gpe_block->block_base_number + (gpe_block->register_count * 8))) {
-		return (&gpe_block->
-			event_info[gpe_number - gpe_block->block_base_number]);
-	}
-
-	return (NULL);
+	return acpi_ev_gpeblk_event_info(obj_desc->device.gpe_block,
+					  gpe_number);
 }
 
 /*******************************************************************************
Index: linux-2.6/drivers/acpi/acpica/acevents.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/acevents.h
+++ linux-2.6/drivers/acpi/acpica/acevents.h
@@ -82,6 +82,10 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
+struct acpi_gpe_event_info *acpi_ev_gpeblk_event_info(
+					struct acpi_gpe_block_info *gpe_block,
+					u32 gpe_number);
+
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
Index: linux-2.6/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-2.6/drivers/acpi/acpica/evgpeblk.c
@@ -439,15 +439,11 @@ acpi_ev_match_prw_and_gpe(acpi_handle ob
 	 *     2) The GPE index(number) is within the range of the Gpe Block
 	 *          associated with the GPE device.
 	 */
-	if ((gpe_device == target_gpe_device) &&
-	    (gpe_number >= gpe_block->block_base_number) &&
-	    (gpe_number < gpe_block->block_base_number +
-	     (gpe_block->register_count * 8))) {
-		gpe_event_info = &gpe_block->event_info[gpe_number -
-							gpe_block->
-							block_base_number];
-
-		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+	if (gpe_device == target_gpe_device) {
+		gpe_event_info = acpi_ev_gpeblk_event_info(gpe_block,
+							   gpe_number);
+		if (gpe_event_info)
+			gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
 	}
 
       cleanup:
