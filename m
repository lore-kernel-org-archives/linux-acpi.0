From: Len Brown <lenb@kernel.org>
Subject: [PATCH 40/98] ACPICA: Formatting update - no functional changes
Date: Sat, 28 Mar 2009 00:31:15 -0400
Message-ID: <d4913dc6d0c680aa106d1d80b5ad2a9325367afd.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZC1Ecz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:55 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700JX08MLAV2O@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:46 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Split long lines, update comments.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpe.c    |    7 ++--
 drivers/acpi/acpica/evgpeblk.c |   64 +++++++++++++++++++--------------------
 drivers/acpi/acpica/evmisc.c   |   11 ++++---
 drivers/acpi/acpica/evregion.c |    3 +-
 drivers/acpi/acpica/evrgnini.c |   22 ++++++-------
 drivers/acpi/acpica/evxface.c  |    3 +-
 drivers/acpi/acpica/evxfregn.c |    3 +-
 drivers/acpi/acpica/hwacpi.c   |    3 +-
 drivers/acpi/acpica/hwgpe.c    |   21 +++++-------
 drivers/acpi/acpica/hwsleep.c  |   14 ++++-----
 drivers/acpi/acpica/hwxface.c  |    3 +-
 drivers/acpi/acpica/nsaccess.c |   51 +++++++++++++++-----------------
 drivers/acpi/acpica/nsalloc.c  |   24 +++++---------
 drivers/acpi/acpica/nsdump.c   |   16 ++++-----
 drivers/acpi/acpica/nsinit.c   |   19 ++++++-----
 drivers/acpi/acpica/nsload.c   |    4 +-
 drivers/acpi/acpica/nsparse.c  |   10 ++----
 drivers/acpi/acpica/nspredef.c |    6 ++-
 drivers/acpi/acpica/nssearch.c |   14 ++++----
 drivers/acpi/acpica/nsutils.c  |   25 +++++++--------
 drivers/acpi/acpica/nswalk.c   |   12 ++++----
 21 files changed, 161 insertions(+), 174 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index f345ced..b9d8ee6 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -88,10 +88,10 @@ acpi_ev_set_gpe_type(struct acpi_gpe_event_info *gpe_event_info, u8 type)
 
 	status = acpi_ev_disable_gpe(gpe_event_info);
 
-	/* Type was validated above */
+	/* Clear the type bits and insert the new Type */
 
-	gpe_event_info->flags &= ~ACPI_GPE_TYPE_MASK;	/* Clear type bits */
-	gpe_event_info->flags |= type;	/* Insert type */
+	gpe_event_info->flags &= ~ACPI_GPE_TYPE_MASK;
+	gpe_event_info->flags |= type;
 	return_ACPI_STATUS(status);
 }
 
@@ -122,6 +122,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info,
 	if (!gpe_register_info) {
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
+
 	register_bit = (u8)
 	    (1 <<
 	     (gpe_event_info->gpe_number - gpe_register_info->base_gpe_number));
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index f7b3d2a..7b34636 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -104,9 +104,9 @@ u8 acpi_ev_valid_gpe_event(struct acpi_gpe_event_info *gpe_event_info)
 
 		while (gpe_block) {
 			if ((&gpe_block->event_info[0] <= gpe_event_info) &&
-			    (&gpe_block->
-			     event_info[((acpi_size) gpe_block->
-					 register_count) * 8] >
+			    (&gpe_block->event_info[((acpi_size)
+						     gpe_block->
+						     register_count) * 8] >
 			     gpe_event_info)) {
 				return (TRUE);
 			}
@@ -210,10 +210,9 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		/* Now look at the individual GPEs in this byte register */
 
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
-			gpe_event_info =
-			    &gpe_block->
-			    event_info[((acpi_size) i *
-					ACPI_GPE_REGISTER_WIDTH) + j];
+			gpe_event_info = &gpe_block->event_info[((acpi_size) i *
+								 ACPI_GPE_REGISTER_WIDTH)
+								+ j];
 
 			if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 			    ACPI_GPE_DISPATCH_HANDLER) {
@@ -293,8 +292,8 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 		/* Unknown method type, just ignore it! */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
-				  "Ignoring unknown GPE method type: %s (name not of form _Lxx or _Exx)",
-				  name));
+				  "Ignoring unknown GPE method type: %s "
+				  "(name not of form _Lxx or _Exx)", name));
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -306,17 +305,16 @@ acpi_ev_save_method_info(acpi_handle obj_handle,
 		/* Conversion failed; invalid method, just ignore it */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD,
-				  "Could not extract GPE number from name: %s (name is not of form _Lxx or _Exx)",
-				  name));
+				  "Could not extract GPE number from name: %s "
+				  "(name is not of form _Lxx or _Exx)", name));
 		return_ACPI_STATUS(AE_OK);
 	}
 
 	/* Ensure that we have a valid GPE number for this GPE block */
 
 	if ((gpe_number < gpe_block->block_base_number) ||
-	    (gpe_number >=
-	     (gpe_block->block_base_number +
-	      (gpe_block->register_count * 8)))) {
+	    (gpe_number >= (gpe_block->block_base_number +
+			    (gpe_block->register_count * 8)))) {
 		/*
 		 * Not valid for this GPE block, just ignore it. However, it may be
 		 * valid for a different GPE block, since GPE0 and GPE1 methods both
@@ -423,9 +421,9 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 
 		if ((obj_desc->package.count < 2) ||
 		    ((obj_desc->package.elements[0])->common.type !=
-		     ACPI_TYPE_LOCAL_REFERENCE)
-		    || ((obj_desc->package.elements[1])->common.type !=
-			ACPI_TYPE_INTEGER)) {
+		     ACPI_TYPE_LOCAL_REFERENCE) ||
+		    ((obj_desc->package.elements[1])->common.type !=
+		     ACPI_TYPE_INTEGER)) {
 			goto cleanup;
 		}
 
@@ -450,11 +448,11 @@ acpi_ev_match_prw_and_gpe(acpi_handle obj_handle,
 	 */
 	if ((gpe_device == target_gpe_device) &&
 	    (gpe_number >= gpe_block->block_base_number) &&
-	    (gpe_number <
-	     gpe_block->block_base_number + (gpe_block->register_count * 8))) {
-		gpe_event_info =
-		    &gpe_block->event_info[gpe_number -
-					   gpe_block->block_base_number];
+	    (gpe_number < gpe_block->block_base_number +
+	     (gpe_block->register_count * 8))) {
+		gpe_event_info = &gpe_block->event_info[gpe_number -
+							gpe_block->
+							block_base_number];
 
 		/* Mark GPE for WAKE-ONLY but WAKE_DISABLED */
 
@@ -1033,8 +1031,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 	 * 1) are "runtime" or "run/wake" GPEs, and
 	 * 2) have a corresponding _Lxx or _Exx method
 	 *
-	 * Any other GPEs within this block must be enabled via the acpi_enable_gpe()
-	 * external interface.
+	 * Any other GPEs within this block must be enabled via the
+	 * acpi_enable_gpe() external interface.
 	 */
 	wake_gpe_count = 0;
 	gpe_enabled_count = 0;
@@ -1044,14 +1042,13 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 
 			/* Get the info block for this particular GPE */
 
-			gpe_event_info =
-			    &gpe_block->
-			    event_info[((acpi_size) i *
-					ACPI_GPE_REGISTER_WIDTH) + j];
+			gpe_event_info = &gpe_block->event_info[((acpi_size) i *
+								 ACPI_GPE_REGISTER_WIDTH)
+								+ j];
 
 			if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
-			     ACPI_GPE_DISPATCH_METHOD)
-			    && (gpe_event_info->flags & ACPI_GPE_TYPE_RUNTIME)) {
+			     ACPI_GPE_DISPATCH_METHOD) &&
+			    (gpe_event_info->flags & ACPI_GPE_TYPE_RUNTIME)) {
 				gpe_enabled_count++;
 			}
 
@@ -1105,8 +1102,8 @@ acpi_status acpi_ev_gpe_initialize(void)
 	/*
 	 * Initialize the GPE Block(s) defined in the FADT
 	 *
-	 * Why the GPE register block lengths are divided by 2:  From the ACPI Spec,
-	 * section "General-Purpose Event Registers", we have:
+	 * Why the GPE register block lengths are divided by 2:  From the ACPI
+	 * Spec, section "General-Purpose Event Registers", we have:
 	 *
 	 * "Each register block contains two registers of equal length
 	 *  GPEx_STS and GPEx_EN (where x is 0 or 1). The length of the
@@ -1163,7 +1160,8 @@ acpi_status acpi_ev_gpe_initialize(void)
 		if ((register_count0) &&
 		    (gpe_number_max >= acpi_gbl_FADT.gpe1_base)) {
 			ACPI_ERROR((AE_INFO,
-				    "GPE0 block (GPE 0 to %d) overlaps the GPE1 block (GPE %d to %d) - Ignoring GPE1",
+				    "GPE0 block (GPE 0 to %d) overlaps the GPE1 block "
+				    "(GPE %d to %d) - Ignoring GPE1",
 				    gpe_number_max, acpi_gbl_FADT.gpe1_base,
 				    acpi_gbl_FADT.gpe1_base +
 				    ((register_count1 *
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 417a9b9..ce224e1 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -163,10 +163,10 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 	 * 2) Global device notify handler
 	 * 3) Per-device notify handler
 	 */
-	if ((acpi_gbl_system_notify.handler
-	     && (notify_value <= ACPI_MAX_SYS_NOTIFY))
-	    || (acpi_gbl_device_notify.handler
-		&& (notify_value > ACPI_MAX_SYS_NOTIFY)) || handler_obj) {
+	if ((acpi_gbl_system_notify.handler &&
+	     (notify_value <= ACPI_MAX_SYS_NOTIFY)) ||
+	    (acpi_gbl_device_notify.handler &&
+	     (notify_value > ACPI_MAX_SYS_NOTIFY)) || handler_obj) {
 		notify_info = acpi_ut_create_generic_state();
 		if (!notify_info) {
 			return (AE_NO_MEMORY);
@@ -174,7 +174,8 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 
 		if (!handler_obj) {
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Executing system notify handler for Notify (%4.4s, %X) node %p\n",
+					  "Executing system notify handler for Notify (%4.4s, %X) "
+					  "node %p\n",
 					  acpi_ut_get_node_name(node),
 					  notify_value, node));
 		}
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 86cbbdb..538d632 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -703,7 +703,8 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 			if (next_handler_obj->address_space.space_id ==
 			    handler_obj->address_space.space_id) {
 				ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-						  "Found handler for region [%s] in device %p(%p) handler %p\n",
+						  "Found handler for region [%s] in device %p(%p) "
+						  "handler %p\n",
 						  acpi_ut_get_region_name
 						  (handler_obj->address_space.
 						   space_id), obj_desc,
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index f3f1fb4..284a7be 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -241,7 +241,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 						status = AE_OK;
 					} else {
 						ACPI_EXCEPTION((AE_INFO, status,
-								"Could not install PciConfig handler for Root Bridge %4.4s",
+								"Could not install PciConfig handler "
+								"for Root Bridge %4.4s",
 								acpi_ut_get_node_name
 								(pci_root_node)));
 					}
@@ -293,9 +294,8 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 	 * Get the PCI device and function numbers from the _ADR object contained
 	 * in the parent's scope.
 	 */
-	status =
-	    acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, pci_device_node,
-					    &pci_value);
+	status = acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR,
+						 pci_device_node, &pci_value);
 
 	/*
 	 * The default is zero, and since the allocation above zeroed the data,
@@ -308,18 +308,16 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 
 	/* The PCI segment number comes from the _SEG method */
 
-	status =
-	    acpi_ut_evaluate_numeric_object(METHOD_NAME__SEG, pci_root_node,
-					    &pci_value);
+	status = acpi_ut_evaluate_numeric_object(METHOD_NAME__SEG,
+						 pci_root_node, &pci_value);
 	if (ACPI_SUCCESS(status)) {
 		pci_id->segment = ACPI_LOWORD(pci_value);
 	}
 
 	/* The PCI bus number comes from the _BBN method */
 
-	status =
-	    acpi_ut_evaluate_numeric_object(METHOD_NAME__BBN, pci_root_node,
-					    &pci_value);
+	status = acpi_ut_evaluate_numeric_object(METHOD_NAME__BBN,
+						 pci_root_node, &pci_value);
 	if (ACPI_SUCCESS(status)) {
 		pci_id->bus = ACPI_LOWORD(pci_value);
 	}
@@ -632,8 +630,8 @@ acpi_ev_initialize_region(union acpi_operand_object *region_obj,
 								  acpi_ns_locked);
 
 					/*
-					 * Tell all users that this region is usable by running the _REG
-					 * method
+					 * Tell all users that this region is usable by
+					 * running the _REG method
 					 */
 					if (acpi_ns_locked) {
 						status =
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 3aca901..10b8543 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -631,7 +631,8 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Setup up dispatch flags to indicate handler (vs. method) */
 
-	gpe_event_info->flags &= ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);	/* Clear bits */
+	gpe_event_info->flags &=
+	    ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
 	gpe_event_info->flags |= (u8) (type | ACPI_GPE_DISPATCH_HANDLER);
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 479e7a3..7c3d2d3 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -193,7 +193,8 @@ acpi_remove_address_space_handler(acpi_handle device,
 			/* Matched space_id, first dereference this in the Regions */
 
 			ACPI_DEBUG_PRINT((ACPI_DB_OPREGION,
-					  "Removing address handler %p(%p) for region %s on Device %p(%p)\n",
+					  "Removing address handler %p(%p) for region %s "
+					  "on Device %p(%p)\n",
 					  handler_obj, handler,
 					  acpi_ut_get_region_name(space_id),
 					  node, obj_desc));
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 8902db8..e7949b1 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -86,7 +86,8 @@ acpi_status acpi_hw_set_mode(u32 mode)
 	 */
 	if (!acpi_gbl_FADT.acpi_enable && !acpi_gbl_FADT.acpi_disable) {
 		ACPI_ERROR((AE_INFO,
-			    "No ACPI mode transition supported in this system (enable/disable both zero)"));
+			    "No ACPI mode transition supported in this system "
+			    "(enable/disable both zero)"));
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 2013b66..d3b7e37 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -89,10 +89,9 @@ acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 	/* Clear just the bit that corresponds to this GPE */
 
-	ACPI_CLEAR_BIT(enable_mask,
-		       ((u32) 1 <<
-			(gpe_event_info->gpe_number -
-			 gpe_register_info->base_gpe_number)));
+	ACPI_CLEAR_BIT(enable_mask, ((u32)1 <<
+				     (gpe_event_info->gpe_number -
+				      gpe_register_info->base_gpe_number)));
 
 	/* Write the updated enable mask */
 
@@ -156,10 +155,9 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 
 	ACPI_FUNCTION_ENTRY();
 
-	register_bit = (u8)
-	    (1 <<
-	     (gpe_event_info->gpe_number -
-	      gpe_event_info->register_info->base_gpe_number));
+	register_bit = (u8)(1 <<
+			    (gpe_event_info->gpe_number -
+			     gpe_event_info->register_info->base_gpe_number));
 
 	/*
 	 * Write a one to the appropriate bit in the status register to
@@ -206,10 +204,9 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	/* Get the register bitmask for this GPE */
 
-	register_bit = (u8)
-	    (1 <<
-	     (gpe_event_info->gpe_number -
-	      gpe_event_info->register_info->base_gpe_number));
+	register_bit = (u8)(1 <<
+			    (gpe_event_info->gpe_number -
+			     gpe_event_info->register_info->base_gpe_number));
 
 	/* GPE currently enabled? (enabled for runtime?) */
 
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 4d14b49..2ea4c59 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -349,8 +349,8 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		 * Wait ten seconds, then try again. This is to get S4/S5 to work on
 		 * all machines.
 		 *
-		 * We wait so long to allow chipsets that poll this reg very slowly to
-		 * still read the right value. Ideally, this block would go
+		 * We wait so long to allow chipsets that poll this reg very slowly
+		 * to still read the right value. Ideally, this block would go
 		 * away entirely.
 		 */
 		acpi_os_stall(10000000);
@@ -501,12 +501,10 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 
 			/* Insert the SLP_TYP bits */
 
-			pm1a_control |=
-			    (acpi_gbl_sleep_type_a << sleep_type_reg_info->
-			     bit_position);
-			pm1b_control |=
-			    (acpi_gbl_sleep_type_b << sleep_type_reg_info->
-			     bit_position);
+			pm1a_control |= (acpi_gbl_sleep_type_a <<
+					 sleep_type_reg_info->bit_position);
+			pm1b_control |= (acpi_gbl_sleep_type_b <<
+					 sleep_type_reg_info->bit_position);
 
 			/* Write the control registers and ignore any errors */
 
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index caad516..26e6642 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -494,7 +494,8 @@ acpi_get_sleep_type_data(u8 sleep_state, u8 *sleep_type_a, u8 *sleep_type_b)
 		 ((info->return_object->package.elements[1])->common.type
 		  != ACPI_TYPE_INTEGER)) {
 		ACPI_ERROR((AE_INFO,
-			    "Sleep State return package elements are not both Integers (%s, %s)",
+			    "Sleep State return package elements are not both Integers "
+			    "(%s, %s)",
 			    acpi_ut_get_object_type_name(info->return_object->
 							 package.elements[0]),
 			    acpi_ut_get_object_type_name(info->return_object->
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index b6968a6..9c3cdbe 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -118,9 +118,8 @@ acpi_status acpi_ns_root_initialize(void)
 		}
 
 		/*
-		 * Name entered successfully.
-		 * If entry in pre_defined_names[] specifies an
-		 * initial value, create the initial value.
+		 * Name entered successfully. If entry in pre_defined_names[] specifies
+		 * an initial value, create the initial value.
 		 */
 		if (init_val->val) {
 			status = acpi_os_predefined_override(init_val, &val);
@@ -178,9 +177,8 @@ acpi_status acpi_ns_root_initialize(void)
 
 			case ACPI_TYPE_STRING:
 
-				/*
-				 * Build an object around the static string
-				 */
+				/* Build an object around the static string */
+
 				obj_desc->string.length =
 				    (u32) ACPI_STRLEN(val);
 				obj_desc->string.pointer = val;
@@ -314,10 +312,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		return_ACPI_STATUS(AE_NO_NAMESPACE);
 	}
 
-	/*
-	 * Get the prefix scope.
-	 * A null scope means use the root scope
-	 */
+	/* Get the prefix scope. A null scope means use the root scope */
+
 	if ((!scope_info) || (!scope_info->scope.node)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 				  "Null scope prefix, using root node (%p)\n",
@@ -337,8 +333,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		if (!(flags & ACPI_NS_PREFIX_IS_SCOPE)) {
 			/*
 			 * This node might not be a actual "scope" node (such as a
-			 * Device/Method, etc.)  It could be a Package or other object node.
-			 * Backup up the tree to find the containing scope node.
+			 * Device/Method, etc.)  It could be a Package or other object
+			 * node. Backup up the tree to find the containing scope node.
 			 */
 			while (!acpi_ns_opens_scope(prefix_node->type) &&
 			       prefix_node->type != ACPI_TYPE_ANY) {
@@ -348,7 +344,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		}
 	}
 
-	/* Save type   TBD: may be no longer necessary */
+	/* Save type. TBD: may be no longer necessary */
 
 	type_to_check_for = type;
 
@@ -413,6 +409,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				/* Name is fully qualified, no search rules apply */
 
 				search_parent_flag = ACPI_NS_NO_UPSEARCH;
+
 				/*
 				 * Point past this prefix to the name segment
 				 * part or the next Parent Prefix
@@ -428,7 +425,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 					/* Current scope has no parent scope */
 
 					ACPI_ERROR((AE_INFO,
-						    "ACPI path has too many parent prefixes (^) - reached beyond root node"));
+						    "ACPI path has too many parent prefixes (^) "
+						    "- reached beyond root node"));
 					return_ACPI_STATUS(AE_NOT_FOUND);
 				}
 			}
@@ -530,9 +528,9 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 	while (num_segments && current_node) {
 		num_segments--;
 		if (!num_segments) {
-			/*
-			 * This is the last segment, enable typechecking
-			 */
+
+			/* This is the last segment, enable typechecking */
+
 			this_search_type = type;
 
 			/*
@@ -583,9 +581,9 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		if (num_segments > 0) {
 			/*
 			 * If we have an alias to an object that opens a scope (such as a
-			 * device or processor), we need to dereference the alias here so that
-			 * we can access any children of the original node (via the remaining
-			 * segments).
+			 * device or processor), we need to dereference the alias here so
+			 * that we can access any children of the original node (via the
+			 * remaining segments).
 			 */
 			if (this_node->type == ACPI_TYPE_LOCAL_ALIAS) {
 				if (!this_node->object) {
@@ -593,8 +591,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				}
 
 				if (acpi_ns_opens_scope
-				    (((struct acpi_namespace_node *)this_node->
-				      object)->type)) {
+				    (((struct acpi_namespace_node *)
+				      this_node->object)->type)) {
 					this_node =
 					    (struct acpi_namespace_node *)
 					    this_node->object;
@@ -638,8 +636,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 
 			/*
 			 * If this is the last name segment and we are not looking for a
-			 * specific type, but the type of found object is known, use that type
-			 * to (later) see if it opens a scope.
+			 * specific type, but the type of found object is known, use that
+			 * type to (later) see if it opens a scope.
 			 */
 			if (type == ACPI_TYPE_ANY) {
 				type = this_node->type;
@@ -652,9 +650,8 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		current_node = this_node;
 	}
 
-	/*
-	 * Always check if we need to open a new scope
-	 */
+	/* Always check if we need to open a new scope */
+
 	if (!(flags & ACPI_NS_DONT_OPEN_SCOPE) && (walk_state)) {
 		/*
 		 * If entry is a type which opens a scope, push the new scope on the
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index f976d84..aceb931 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -76,8 +76,7 @@ struct acpi_namespace_node *acpi_ns_create_node(u32 name)
 	ACPI_MEM_TRACKING(acpi_gbl_ns_node_list->total_allocated++);
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
-	temp =
-	    acpi_gbl_ns_node_list->total_allocated -
+	temp = acpi_gbl_ns_node_list->total_allocated -
 	    acpi_gbl_ns_node_list->total_freed;
 	if (temp > acpi_gbl_ns_node_list->max_occupied) {
 		acpi_gbl_ns_node_list->max_occupied = temp;
@@ -145,9 +144,8 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 
 	ACPI_MEM_TRACKING(acpi_gbl_ns_node_list->total_freed++);
 
-	/*
-	 * Detach an object if there is one, then delete the node
-	 */
+	/* Detach an object if there is one, then delete the node */
+
 	acpi_ns_detach_object(node);
 	(void)acpi_os_release_object(acpi_gbl_namespace_cache, node);
 	return_VOID;
@@ -183,9 +181,8 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 	ACPI_FUNCTION_TRACE(ns_install_node);
 
 	/*
-	 * Get the owner ID from the Walk state
-	 * The owner ID is used to track table deletion and
-	 * deletion of objects created by methods
+	 * Get the owner ID from the Walk state. The owner ID is used to track
+	 * table deletion and deletion of objects created by methods.
 	 */
 	if (walk_state) {
 		owner_id = walk_state->owner_id;
@@ -260,9 +257,8 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 		return_VOID;
 	}
 
-	/*
-	 * Deallocate all children at this level
-	 */
+	/* Deallocate all children at this level */
+
 	do {
 
 		/* Get the things we need */
@@ -285,9 +281,8 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 				  "Object %p, Remaining %X\n", child_node,
 				  acpi_gbl_current_node_count));
 
-		/*
-		 * Detach an object if there is one, then free the child node
-		 */
+		/* Detach an object if there is one, then free the child node */
+
 		acpi_ns_detach_object(child_node);
 
 		/* Now we can delete the node */
@@ -304,7 +299,6 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 	/* Clear the parent's child pointer */
 
 	parent_node->child = NULL;
-
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 7bfa6c1..2bad613 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -220,9 +220,8 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		acpi_os_printf("%4.4s", acpi_ut_get_node_name(this_node));
 	}
 
-	/*
-	 * Now we can print out the pertinent information
-	 */
+	/* Now we can print out the pertinent information */
+
 	acpi_os_printf(" %-12s %p %2.2X ",
 		       acpi_ut_get_type_name(type), this_node,
 		       this_node->owner_id);
@@ -545,9 +544,8 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 			goto cleanup;
 		}
 
-		/*
-		 * Valid object, get the pointer to next level, if any
-		 */
+		/* Valid object, get the pointer to next level, if any */
+
 		switch (obj_type) {
 		case ACPI_TYPE_BUFFER:
 		case ACPI_TYPE_STRING:
@@ -608,14 +606,14 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
  *              display_type        - 0 or ACPI_DISPLAY_SUMMARY
  *              max_depth           - Maximum depth of dump. Use ACPI_UINT32_MAX
  *                                    for an effectively unlimited depth.
- *              owner_id            - Dump only objects owned by this ID.  Use
+ *              owner_id            - Dump only objects owned by this ID. Use
  *                                    ACPI_UINT32_MAX to match all owners.
  *              start_handle        - Where in namespace to start/end search
  *
  * RETURN:      None
  *
- * DESCRIPTION: Dump typed objects within the loaded namespace.
- *              Uses acpi_ns_walk_namespace in conjunction with acpi_ns_dump_one_object.
+ * DESCRIPTION: Dump typed objects within the loaded namespace. Uses
+ *              acpi_ns_walk_namespace in conjunction with acpi_ns_dump_one_object.
  *
  ******************************************************************************/
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 13501cb..2adfcf3 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -103,7 +103,8 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nInitialized %hd/%hd Regions %hd/%hd Fields %hd/%hd Buffers %hd/%hd Packages (%hd nodes)\n",
+			      "\nInitialized %hd/%hd Regions %hd/%hd Fields %hd/%hd "
+			      "Buffers %hd/%hd Packages (%hd nodes)\n",
 			      info.op_region_init, info.op_region_count,
 			      info.field_init, info.field_count,
 			      info.buffer_init, info.buffer_count,
@@ -148,7 +149,8 @@ acpi_status acpi_ns_initialize_devices(void)
 	info.num_INI = 0;
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Initializing Device/Processor/Thermal objects by executing _INI methods:"));
+			      "Initializing Device/Processor/Thermal objects "
+			      "by executing _INI methods:"));
 
 	/* Tree analysis: find all subtrees that contain _INI methods */
 
@@ -180,7 +182,8 @@ acpi_status acpi_ns_initialize_devices(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "\nExecuted %hd _INI methods requiring %hd _STA executions (examined %hd objects)\n",
+			      "\nExecuted %hd _INI methods requiring %hd _STA executions "
+			      "(examined %hd objects)\n",
 			      info.num_INI, info.num_STA, info.device_count));
 
 	return_ACPI_STATUS(status);
@@ -263,16 +266,14 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 		return (AE_OK);
 	}
 
-	/*
-	 * If the object is already initialized, nothing else to do
-	 */
+	/* If the object is already initialized, nothing else to do */
+
 	if (obj_desc->common.flags & AOPOBJ_DATA_VALID) {
 		return (AE_OK);
 	}
 
-	/*
-	 * Must lock the interpreter before executing AML code
-	 */
+	/* Must lock the interpreter before executing AML code */
+
 	acpi_ex_enter_interpreter();
 
 	/*
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index a0ba9e1..dcd7a6a 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -128,12 +128,12 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	 * parse trees.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "**** Begin Table Method Parsing and Object Initialization ****\n"));
+			  "**** Begin Table Method Parsing and Object Initialization\n"));
 
 	status = acpi_ds_initialize_objects(table_index, node);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "**** Completed Table Method Parsing and Object Initialization ****\n"));
+			  "**** Completed Table Method Parsing and Object Initialization\n"));
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
index b9e8d00..662a4bd 100644
--- a/drivers/acpi/acpica/nsparse.c
+++ b/drivers/acpi/acpica/nsparse.c
@@ -176,9 +176,8 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	 * performs another complete parse of the AML.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 1\n"));
-	status =
-	    acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1, table_index,
-				       start_node);
+	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS1,
+					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -193,9 +192,8 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 	 * parse objects are all cached.
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_PARSE, "**** Start pass 2\n"));
-	status =
-	    acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2, table_index,
-				       start_node);
+	status = acpi_ns_one_complete_parse(ACPI_IMODE_LOAD_PASS2,
+					    table_index, start_node);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 72dd7b1..0d0b4ee 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -302,7 +302,8 @@ acpi_ns_check_parameter_count(char *pathname,
 		if ((user_param_count != required_params_current) &&
 		    (user_param_count != required_params_old)) {
 			ACPI_WARNING((AE_INFO,
-				      "%s: Parameter count mismatch - caller passed %d, ACPI requires %d",
+				      "%s: Parameter count mismatch - "
+				      "caller passed %d, ACPI requires %d",
 				      pathname, user_param_count,
 				      required_params_current));
 		}
@@ -974,7 +975,8 @@ acpi_ns_check_reference(char *pathname,
 	}
 
 	ACPI_WARNING((AE_INFO,
-		      "%s: Return type mismatch - unexpected reference object type [%s] %2.2X",
+		      "%s: Return type mismatch - "
+		      "unexpected reference object type [%s] %2.2X",
 		      pathname, acpi_ut_get_reference_name(return_object),
 		      return_object->reference.class));
 
diff --git a/drivers/acpi/acpica/nssearch.c b/drivers/acpi/acpica/nssearch.c
index 6fea13f..f9b4f51 100644
--- a/drivers/acpi/acpica/nssearch.c
+++ b/drivers/acpi/acpica/nssearch.c
@@ -167,7 +167,8 @@ acpi_ns_search_one_scope(u32 target_name,
 	/* Searched entire namespace level, not found */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-			  "Name [%4.4s] (%s) not found in search in scope [%4.4s] %p first child %p\n",
+			  "Name [%4.4s] (%s) not found in search in scope [%4.4s] "
+			  "%p first child %p\n",
 			  ACPI_CAST_PTR(char, &target_name),
 			  acpi_ut_get_type_name(type),
 			  acpi_ut_get_node_name(parent_node), parent_node,
@@ -239,9 +240,8 @@ acpi_ns_search_parent_tree(u32 target_name,
 			  acpi_ut_get_node_name(parent_node),
 			  ACPI_CAST_PTR(char, &target_name)));
 
-	/*
-	 * Search parents until target is found or we have backed up to the root
-	 */
+	/* Search parents until target is found or we have backed up to the root */
+
 	while (parent_node) {
 		/*
 		 * Search parent scope. Use TYPE_ANY because we don't care about the
@@ -395,9 +395,9 @@ acpi_ns_search_and_enter(u32 target_name,
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
 #ifdef ACPI_ASL_COMPILER
-	/*
-	 * Node is an object defined by an External() statement
-	 */
+
+	/* Node is an object defined by an External() statement */
+
 	if (flags & ACPI_NS_EXTERNAL) {
 		new_node->flags |= ANOBJ_IS_EXTERNAL;
 	}
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index d30b0e6..78277ed 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -325,9 +325,8 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 			next_external_char++;
 		}
 	} else {
-		/*
-		 * Handle Carat prefixes
-		 */
+		/* Handle Carat prefixes */
+
 		while (*next_external_char == '^') {
 			info->num_carats++;
 			next_external_char++;
@@ -552,9 +551,8 @@ acpi_ns_externalize_name(u32 internal_name_length,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/*
-	 * Check for a prefix (one '\' | one or more '^').
-	 */
+	/* Check for a prefix (one '\' | one or more '^') */
+
 	switch (internal_name[0]) {
 	case '\\':
 		prefix_length = 1;
@@ -580,7 +578,7 @@ acpi_ns_externalize_name(u32 internal_name_length,
 	}
 
 	/*
-	 * Check for object names.  Note that there could be 0-255 of these
+	 * Check for object names. Note that there could be 0-255 of these
 	 * 4-byte elements.
 	 */
 	if (prefix_length < internal_name_length) {
@@ -637,9 +635,8 @@ acpi_ns_externalize_name(u32 internal_name_length,
 		return_ACPI_STATUS(AE_BAD_PATHNAME);
 	}
 
-	/*
-	 * Build converted_name
-	 */
+	/* Build the converted_name */
+
 	*converted_name = ACPI_ALLOCATE_ZEROED(required_length);
 	if (!(*converted_name)) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
@@ -685,6 +682,9 @@ acpi_ns_externalize_name(u32 internal_name_length,
  *       and keep all pointers within this subsystem - however this introduces
  *       more (and perhaps unnecessary) overhead.
  *
+ * The current implemenation is basically a placeholder until such time comes
+ * that it is needed.
+ *
  ******************************************************************************/
 
 struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle)
@@ -692,9 +692,8 @@ struct acpi_namespace_node *acpi_ns_map_handle_to_node(acpi_handle handle)
 
 	ACPI_FUNCTION_ENTRY();
 
-	/*
-	 * Simple implementation
-	 */
+	/* Parameter validation */
+
 	if ((!handle) || (handle == ACPI_ROOT_OBJECT)) {
 		return (acpi_gbl_root_node);
 	}
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 200895f..83e3aa6 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -135,8 +135,8 @@ struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct
  *              starting (and ending) at the node specified by start_handle.
  *              The user_function is called whenever a node that matches
  *              the type parameter is found.  If the user function returns
- *              a non-zero value, the search is terminated immediately and this
- *              value is returned to the caller.
+ *              a non-zero value, the search is terminated immediately and
+ *              this value is returned to the caller.
  *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
@@ -200,10 +200,10 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			/*
 			 * Ignore all temporary namespace nodes (created during control
 			 * method execution) unless told otherwise. These temporary nodes
-			 * can cause a race condition because they can be deleted during the
-			 * execution of the user function (if the namespace is unlocked before
-			 * invocation of the user function.) Only the debugger namespace dump
-			 * will examine the temporary nodes.
+			 * can cause a race condition because they can be deleted during
+			 * the execution of the user function (if the namespace is
+			 * unlocked before invocation of the user function.) Only the
+			 * debugger namespace dump will examine the temporary nodes.
 			 */
 			if ((child_node->flags & ANOBJ_TEMPORARY) &&
 			    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
-- 
1.6.0.6

