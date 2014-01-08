From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/21] ACPICA: Improve exception handling for GPE block installation.
Date: Wed,  8 Jan 2014 13:44:10 +0800
Message-ID: <43facb9729c49dbf1d6823c3c0f7a3784a1cc992.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39909 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFoS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:18 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

1) Return an actual status value from acpi_ev_get_gpe_xrupt_block.
2) Don't clobber the status when exiting acpi_ev_install_gpe_block.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1019
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    4 +++-
 drivers/acpi/acpica/evgpeblk.c  |    8 ++++----
 drivers/acpi/acpica/evgpeutil.c |   24 +++++++++++++++---------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 41abe55..0738305 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -149,7 +149,9 @@ acpi_status
 acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		       struct acpi_gpe_block_info *gpe_block, void *context);
 
-struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number);
+acpi_status
+acpi_ev_get_gpe_xrupt_block(u32 interrupt_number,
+			    struct acpi_gpe_xrupt_info **gpe_xrupt_block);
 
 acpi_status acpi_ev_delete_gpe_xrupt(struct acpi_gpe_xrupt_info *gpe_xrupt);
 
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index a9e76bc..a31e549 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -87,9 +87,9 @@ acpi_ev_install_gpe_block(struct acpi_gpe_block_info *gpe_block,
 		return_ACPI_STATUS(status);
 	}
 
-	gpe_xrupt_block = acpi_ev_get_gpe_xrupt_block(interrupt_number);
-	if (!gpe_xrupt_block) {
-		status = AE_NO_MEMORY;
+	status =
+	    acpi_ev_get_gpe_xrupt_block(interrupt_number, &gpe_xrupt_block);
+	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
 	}
 
@@ -112,7 +112,7 @@ acpi_ev_install_gpe_block(struct acpi_gpe_block_info *gpe_block,
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
 unlock_and_exit:
-	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index d3f5e1e..4d764e8 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -197,8 +197,9 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  * FUNCTION:    acpi_ev_get_gpe_xrupt_block
  *
  * PARAMETERS:  interrupt_number            - Interrupt for a GPE block
+ *              gpe_xrupt_block             - Where the block is returned
  *
- * RETURN:      A GPE interrupt block
+ * RETURN:      Status
  *
  * DESCRIPTION: Get or Create a GPE interrupt block. There is one interrupt
  *              block per unique interrupt level used for GPEs. Should be
@@ -207,7 +208,9 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  *
  ******************************************************************************/
 
-struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number)
+acpi_status
+acpi_ev_get_gpe_xrupt_block(u32 interrupt_number,
+			    struct acpi_gpe_xrupt_info ** gpe_xrupt_block)
 {
 	struct acpi_gpe_xrupt_info *next_gpe_xrupt;
 	struct acpi_gpe_xrupt_info *gpe_xrupt;
@@ -221,7 +224,8 @@ struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number)
 	next_gpe_xrupt = acpi_gbl_gpe_xrupt_list_head;
 	while (next_gpe_xrupt) {
 		if (next_gpe_xrupt->interrupt_number == interrupt_number) {
-			return_PTR(next_gpe_xrupt);
+			*gpe_xrupt_block = next_gpe_xrupt;
+			return_ACPI_STATUS(AE_OK);
 		}
 
 		next_gpe_xrupt = next_gpe_xrupt->next;
@@ -231,7 +235,7 @@ struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number)
 
 	gpe_xrupt = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_xrupt_info));
 	if (!gpe_xrupt) {
-		return_PTR(NULL);
+		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 
 	gpe_xrupt->interrupt_number = interrupt_number;
@@ -250,6 +254,7 @@ struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number)
 	} else {
 		acpi_gbl_gpe_xrupt_list_head = gpe_xrupt;
 	}
+
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
 	/* Install new interrupt handler if not SCI_INT */
@@ -259,14 +264,15 @@ struct acpi_gpe_xrupt_info *acpi_ev_get_gpe_xrupt_block(u32 interrupt_number)
 							   acpi_ev_gpe_xrupt_handler,
 							   gpe_xrupt);
 		if (ACPI_FAILURE(status)) {
-			ACPI_ERROR((AE_INFO,
-				    "Could not install GPE interrupt handler at level 0x%X",
-				    interrupt_number));
-			return_PTR(NULL);
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Could not install GPE interrupt handler at level 0x%X",
+					interrupt_number));
+			return_ACPI_STATUS(status);
 		}
 	}
 
-	return_PTR(gpe_xrupt);
+	*gpe_xrupt_block = gpe_xrupt;
+	return_ACPI_STATUS(AE_OK);
 }
 
 /*******************************************************************************
-- 
1.7.10

