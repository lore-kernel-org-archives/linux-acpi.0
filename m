From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/3] ACPI / ACPICA: Reduce code duplication in acpi_ev_get_gpe_event_info()
Date: Mon, 8 Mar 2010 00:37:13 +0100
Message-ID: <201003080037.13241.rjw@sisk.pl>
References: <201003080034.11053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58356 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab0CGXfF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Mar 2010 18:35:05 -0500
In-Reply-To: <201003080034.11053.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Move duplicated code from acpi_ev_get_gpe_event_info(), which is also
quite difficult to read, to a separate static function.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evgpe.c |   56 +++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

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
+ * FUNCTION:    acpi_ev_get_info
+ *
+ * PARAMETERS:  gpe_block           - GPE block to search
+ *              gpe_number          - Raw GPE number
+ *
+ * RETURN:      A GPE event_info struct if found. NULL if not found
+ *
+ ******************************************************************************/
+
+static struct acpi_gpe_event_info *acpi_ev_get_info(
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
@@ -201,18 +228,10 @@ struct acpi_gpe_event_info *acpi_ev_get_
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
+			gpe_info = acpi_ev_get_info(acpi_gbl_gpe_fadt_blocks[i],
+						    gpe_number);
+			if (gpe_info)
+				return (gpe_info);
 		}
 
 		/* The gpe_number was not in the range of either FADT GPE block */
@@ -228,16 +247,7 @@ struct acpi_gpe_event_info *acpi_ev_get_
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
+	return acpi_ev_get_info(obj_desc->device.gpe_block, gpe_number);
 }
 
 /*******************************************************************************

