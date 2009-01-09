From: Len Brown <lenb@kernel.org>
Subject: [PATCH 66/94] ACPICA: New: acpi_get_gpe_device interface
Date: Fri, 09 Jan 2009 04:27:08 -0500
Message-ID: <e97d6bf1a01b7403d98aea95731863aab2e84064.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbZAIJ2x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:53 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70075K6BB2AEB@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:24 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This function maps an input GPE index to a GPE block device. Also
Added acpi_current_gpe_count to track the current number of GPEs
that are being managed by the ACPICA core (both FADT-based GPEs
and the GPEs contained in GPE block devices.)

Modify drivers/acpi/system.c to use these 2 new interfaces

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpeblk.c    |   25 ++++++++--
 drivers/acpi/events/evmisc.c      |    4 +-
 drivers/acpi/events/evxfevnt.c    |   93 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/hardware/hwgpe.c     |   26 ++++++-----
 drivers/acpi/hardware/hwregs.c    |    2 +-
 drivers/acpi/system.c             |   63 +------------------------
 drivers/acpi/utilities/utglobal.c |    6 ++-
 include/acpi/acevents.h           |    6 ++-
 include/acpi/acglobal.h           |    1 +
 include/acpi/achware.h            |    7 ++-
 include/acpi/aclocal.h            |   13 ++++--
 include/acpi/acpixf.h             |    2 +
 12 files changed, 156 insertions(+), 92 deletions(-)

diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 7537cda..2872be2 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -124,6 +124,7 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
  * FUNCTION:    acpi_ev_walk_gpe_list
  *
  * PARAMETERS:  gpe_walk_callback   - Routine called for each GPE block
+ *              Context             - Value passed to callback
  *
  * RETURN:      Status
  *
@@ -131,7 +132,8 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
  *
  ******************************************************************************/
 
-acpi_status acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback)
+acpi_status
+acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback, void *context)
 {
 	struct acpi_gpe_block_info *gpe_block;
 	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
@@ -154,8 +156,13 @@ acpi_status acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback)
 
 			/* One callback per GPE block */
 
-			status = gpe_walk_callback(gpe_xrupt_info, gpe_block);
+			status =
+			    gpe_walk_callback(gpe_xrupt_info, gpe_block,
+					      context);
 			if (ACPI_FAILURE(status)) {
+				if (status == AE_CTRL_END) {	/* Callback abort */
+					status = AE_OK;
+				}
 				goto unlock_and_exit;
 			}
 
@@ -186,7 +193,8 @@ acpi_status acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback)
 
 acpi_status
 acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-			    struct acpi_gpe_block_info *gpe_block)
+			    struct acpi_gpe_block_info *gpe_block,
+			    void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
 	u32 i;
@@ -690,7 +698,8 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 
 	/* Disable all GPEs in this block */
 
-	status = acpi_hw_disable_gpe_block(gpe_block->xrupt_block, gpe_block);
+	status =
+	    acpi_hw_disable_gpe_block(gpe_block->xrupt_block, gpe_block, NULL);
 
 	if (!gpe_block->previous && !gpe_block->next) {
 
@@ -717,6 +726,9 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 		acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	}
 
+	acpi_current_gpe_count -=
+	    gpe_block->register_count * ACPI_GPE_REGISTER_WIDTH;
+
 	/* Free the gpe_block */
 
 	ACPI_FREE(gpe_block->register_info);
@@ -958,6 +970,9 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 			  gpe_device->name.ascii, gpe_block->register_count,
 			  interrupt_number));
 
+	/* Update global count of currently available GPEs */
+
+	acpi_current_gpe_count += register_count * ACPI_GPE_REGISTER_WIDTH;
 	return_ACPI_STATUS(AE_OK);
 }
 
@@ -1057,7 +1072,7 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	/* Enable all valid runtime GPEs found above */
 
-	status = acpi_hw_enable_runtime_gpe_block(NULL, gpe_block);
+	status = acpi_hw_enable_runtime_gpe_block(NULL, gpe_block, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Could not enable GPEs in GpeBlock %p",
 			    gpe_block));
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index dbac5b3..d807158 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -588,7 +588,7 @@ void acpi_ev_terminate(void)
 
 		/* Disable all GPEs in all GPE blocks */
 
-		status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block);
+		status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
 
 		/* Remove SCI handler */
 
@@ -606,7 +606,7 @@ void acpi_ev_terminate(void)
 
 	/* Deallocate all handler objects installed within GPE info structs */
 
-	status = acpi_ev_walk_gpe_list(acpi_ev_delete_gpe_handlers);
+	status = acpi_ev_walk_gpe_list(acpi_ev_delete_gpe_handlers, NULL);
 
 	/* Return to original mode if necessary */
 
diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index 669b8ca..aa4dec8 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -49,6 +49,11 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxfevnt")
 
+/* Local prototypes */
+acpi_status
+acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+		       struct acpi_gpe_block_info *gpe_block, void *context);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enable
@@ -60,6 +65,7 @@ ACPI_MODULE_NAME("evxfevnt")
  * DESCRIPTION: Transfers the system into ACPI mode.
  *
  ******************************************************************************/
+
 acpi_status acpi_enable(void)
 {
 	acpi_status status = AE_OK;
@@ -717,3 +723,90 @@ acpi_status acpi_remove_gpe_block(acpi_handle gpe_device)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_remove_gpe_block)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_get_gpe_device
+ *
+ * PARAMETERS:  Index               - System GPE index (0-current_gpe_count)
+ *              gpe_device          - Where the parent GPE Device is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Obtain the GPE device associated with the input index. A NULL
+ *              gpe device indicates that the gpe number is contained in one of
+ *              the FADT-defined gpe blocks. Otherwise, the GPE block device.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_get_gpe_device(u32 index, acpi_handle *gpe_device)
+{
+	struct acpi_gpe_device_info info;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_get_gpe_device);
+
+	if (!gpe_device) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	if (index >= acpi_current_gpe_count) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	/* Setup and walk the GPE list */
+
+	info.index = index;
+	info.status = AE_NOT_EXIST;
+	info.gpe_device = NULL;
+	info.next_block_base_index = 0;
+
+	status = acpi_ev_walk_gpe_list(acpi_ev_get_gpe_device, &info);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	*gpe_device = info.gpe_device;
+	return_ACPI_STATUS(info.status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_get_gpe_device)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_get_gpe_device
+ *
+ * PARAMETERS:  GPE_WALK_CALLBACK
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Matches the input GPE index (0-current_gpe_count) with a GPE
+ *              block device. NULL if the GPE is one of the FADT-defined GPEs.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+		       struct acpi_gpe_block_info *gpe_block, void *context)
+{
+	struct acpi_gpe_device_info *info = context;
+
+	/* Increment Index by the number of GPEs in this block */
+
+	info->next_block_base_index +=
+	    (gpe_block->register_count * ACPI_GPE_REGISTER_WIDTH);
+
+	if (info->index < info->next_block_base_index) {
+		/*
+		 * The GPE index is within this block, get the node. Leave the node
+		 * NULL for the FADT-defined GPEs
+		 */
+		if ((gpe_block->node)->type == ACPI_TYPE_DEVICE) {
+			info->gpe_device = gpe_block->node;
+		}
+
+		info->status = AE_OK;
+		return (AE_CTRL_END);
+	}
+
+	return (AE_OK);
+}
diff --git a/drivers/acpi/hardware/hwgpe.c b/drivers/acpi/hardware/hwgpe.c
index 0b80db9..5ab7cac 100644
--- a/drivers/acpi/hardware/hwgpe.c
+++ b/drivers/acpi/hardware/hwgpe.c
@@ -51,7 +51,8 @@ ACPI_MODULE_NAME("hwgpe")
 /* Local prototypes */
 static acpi_status
 acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-				struct acpi_gpe_block_info *gpe_block);
+				struct acpi_gpe_block_info *gpe_block,
+				void *context);
 
 /******************************************************************************
  *
@@ -260,8 +261,8 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-			  struct acpi_gpe_block_info * gpe_block)
+acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			  struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -297,8 +298,8 @@ acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-			struct acpi_gpe_block_info * gpe_block)
+acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -335,8 +336,8 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
-				 struct acpi_gpe_block_info * gpe_block)
+acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+				 struct acpi_gpe_block_info *gpe_block, void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -382,7 +383,8 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info * gpe_xrupt_info,
 
 static acpi_status
 acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-				struct acpi_gpe_block_info *gpe_block)
+				struct acpi_gpe_block_info *gpe_block,
+				void *context)
 {
 	u32 i;
 	acpi_status status;
@@ -427,8 +429,8 @@ acpi_status acpi_hw_disable_all_gpes(void)
 
 	ACPI_FUNCTION_TRACE(hw_disable_all_gpes);
 
-	status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block);
-	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block);
+	status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
+	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
 	return_ACPI_STATUS(status);
 }
 
@@ -450,7 +452,7 @@ acpi_status acpi_hw_enable_all_runtime_gpes(void)
 
 	ACPI_FUNCTION_TRACE(hw_enable_all_runtime_gpes);
 
-	status = acpi_ev_walk_gpe_list(acpi_hw_enable_runtime_gpe_block);
+	status = acpi_ev_walk_gpe_list(acpi_hw_enable_runtime_gpe_block, NULL);
 	return_ACPI_STATUS(status);
 }
 
@@ -472,6 +474,6 @@ acpi_status acpi_hw_enable_all_wakeup_gpes(void)
 
 	ACPI_FUNCTION_TRACE(hw_enable_all_wakeup_gpes);
 
-	status = acpi_ev_walk_gpe_list(acpi_hw_enable_wakeup_gpe_block);
+	status = acpi_ev_walk_gpe_list(acpi_hw_enable_wakeup_gpe_block, NULL);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index ddf792a..69dc8b4 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -94,7 +94,7 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	/* Clear the GPE Bits in all GPE registers in all GPE blocks */
 
-	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block);
+	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
 
       unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 6e4107f..391d035 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -192,65 +192,6 @@ static struct attribute_group interrupt_stats_attr_group = {
 };
 static struct kobj_attribute *counter_attrs;
 
-static int count_num_gpes(void)
-{
-	int count = 0;
-	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
-	struct acpi_gpe_block_info *gpe_block;
-	acpi_cpu_flags flags;
-
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
-	while (gpe_xrupt_info) {
-		gpe_block = gpe_xrupt_info->gpe_block_list_head;
-		while (gpe_block) {
-			count += gpe_block->register_count *
-			    ACPI_GPE_REGISTER_WIDTH;
-			gpe_block = gpe_block->next;
-		}
-		gpe_xrupt_info = gpe_xrupt_info->next;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	return count;
-}
-
-static int get_gpe_device(int index, acpi_handle *handle)
-{
-	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
-	struct acpi_gpe_block_info *gpe_block;
-	acpi_cpu_flags flags;
-	struct acpi_namespace_node *node;
-
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
-	while (gpe_xrupt_info) {
-		gpe_block = gpe_xrupt_info->gpe_block_list_head;
-		node = gpe_block->node;
-		while (gpe_block) {
-			index -= gpe_block->register_count *
-			    ACPI_GPE_REGISTER_WIDTH;
-			if (index < 0) {
-				acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-				/* return NULL if it's FADT GPE */
-				if (node->type != ACPI_TYPE_DEVICE)
-					*handle = NULL;
-				else
-					*handle = node;
-				return 0;
-			}
-			node = gpe_block->node;
-			gpe_block = gpe_block->next;
-		}
-		gpe_xrupt_info = gpe_xrupt_info->next;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	return -ENODEV;
-}
-
 static void delete_gpe_attr_array(void)
 {
 	struct event_counter *tmp = all_counters;
@@ -309,7 +250,7 @@ static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
 		goto end;
 
 	if (index < num_gpes) {
-		result = get_gpe_device(index, handle);
+		result = acpi_get_gpe_device(index, handle);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 				"Invalid GPE 0x%x\n", index));
@@ -436,7 +377,7 @@ void acpi_irq_stats_init(void)
 	if (all_counters)
 		return;
 
-	num_gpes = count_num_gpes();
+	num_gpes = acpi_current_gpe_count;
 	num_counters = num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTRA;
 
 	all_attrs = kzalloc(sizeof(struct attribute *) * (num_counters + 1),
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 211d621..06112bf 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -46,9 +46,8 @@
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
-ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 #define _COMPONENT          ACPI_UTILITIES
-    ACPI_MODULE_NAME("utglobal")
+ACPI_MODULE_NAME("utglobal")
 
 /*******************************************************************************
  *
@@ -756,6 +755,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_gpe_xrupt_list_head = NULL;
 	acpi_gbl_gpe_fadt_blocks[0] = NULL;
 	acpi_gbl_gpe_fadt_blocks[1] = NULL;
+	acpi_current_gpe_count = 0;
 
 	/* Global handlers */
 
@@ -816,5 +816,7 @@ acpi_status acpi_ut_init_globals(void)
 	return_ACPI_STATUS(AE_OK);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
+ACPI_EXPORT_SYMBOL(acpi_current_gpe_count)
diff --git a/include/acpi/acevents.h b/include/acpi/acevents.h
index d5d099b..07e2013 100644
--- a/include/acpi/acevents.h
+++ b/include/acpi/acevents.h
@@ -93,11 +93,13 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
  */
 u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback);
+acpi_status
+acpi_ev_walk_gpe_list(acpi_gpe_callback gpe_walk_callback, void *context);
 
 acpi_status
 acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-			    struct acpi_gpe_block_info *gpe_block);
+			    struct acpi_gpe_block_info *gpe_block,
+			    void *context);
 
 acpi_status
 acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 90cc820..78f3c14 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -326,6 +326,7 @@ ACPI_EXTERN struct acpi_fixed_event_handler
 ACPI_EXTERN struct acpi_gpe_xrupt_info *acpi_gbl_gpe_xrupt_list_head;
 ACPI_EXTERN struct acpi_gpe_block_info
 *acpi_gbl_gpe_fadt_blocks[ACPI_MAX_GPE_BLOCKS];
+ACPI_EXTERN u32 acpi_current_gpe_count;
 
 /*****************************************************************************
  *
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index 97a72b1..960f816 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -94,13 +94,13 @@ acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
 acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-			  struct acpi_gpe_block_info *gpe_block);
+			  struct acpi_gpe_block_info *gpe_block, void *context);
 
 acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
 acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-			struct acpi_gpe_block_info *gpe_block);
+			struct acpi_gpe_block_info *gpe_block, void *context);
 
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
@@ -114,7 +114,8 @@ acpi_status acpi_hw_enable_all_wakeup_gpes(void);
 
 acpi_status
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-				 struct acpi_gpe_block_info *gpe_block);
+				 struct acpi_gpe_block_info *gpe_block,
+				 void *context);
 
 #ifdef	ACPI_FUTURE_USAGE
 /*
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index 0323fa9..b434960 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -487,10 +487,15 @@ struct acpi_gpe_walk_info {
 	struct acpi_gpe_block_info *gpe_block;
 };
 
-typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
-					 gpe_xrupt_info,
-					 struct acpi_gpe_block_info *
-					 gpe_block);
+struct acpi_gpe_device_info {
+	u32 index;
+	u32 next_block_base_index;
+	acpi_status status;
+	struct acpi_namespace_node *gpe_device;
+};
+
+typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+		struct acpi_gpe_block_info *gpe_block, void *context);
 
 /* Information about each particular fixed event */
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index be0aa5e..e09c237 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -265,6 +265,8 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
 
+acpi_status acpi_get_gpe_device(u32 gpe_index, acpi_handle *gpe_device);
+
 acpi_status
 acpi_install_gpe_block(acpi_handle gpe_device,
 		       struct acpi_generic_address *gpe_block_address,
-- 
1.5.6.6

