From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/26] ACPICA: Fix indent caused divergences.
Date: Wed, 31 Oct 2012 10:25:45 +0800
Message-ID: <52cb016fded44a63799f5fa229bf9b9ea357480e.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64553 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaCZv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:51 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>

New version of "indent" program will generate different outputs that
will lead to the divergences between the Linux and the ACPICA.
This patch fixes such divergences caused by the "indent" program.
The version of the "indent" used for this patch is "GNU indent 2.2.11".

This patch will not affect the generated vmlinux binary.
This will decrease 581 lines of 20120913 divergence.diff.

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdispat.h  |   11 +++++++----
 drivers/acpi/acpica/acevents.h  |    6 ++++--
 drivers/acpi/acpica/aclocal.h   |    6 ++++--
 drivers/acpi/acpica/acparser.h  |    3 +--
 drivers/acpi/acpica/acpredef.h  |   11 ++++++-----
 drivers/acpi/acpica/dsopcode.c  |    3 ++-
 drivers/acpi/acpica/dsutils.c   |    3 ++-
 drivers/acpi/acpica/dswstate.c  |   14 +++++++++-----
 drivers/acpi/acpica/evgpe.c     |   20 ++++++++++++--------
 drivers/acpi/acpica/evgpeblk.c  |    3 ++-
 drivers/acpi/acpica/evgpeutil.c |    3 ++-
 drivers/acpi/acpica/evrgnini.c  |    3 +--
 drivers/acpi/acpica/evxfgpe.c   |    9 +++++----
 drivers/acpi/acpica/exconvrt.c  |    4 ++--
 drivers/acpi/acpica/excreate.c  |    3 +--
 drivers/acpi/acpica/exdump.c    |    9 ++++++---
 drivers/acpi/acpica/exfldio.c   |    3 +--
 drivers/acpi/acpica/exnames.c   |    6 +++---
 drivers/acpi/acpica/exresop.c   |    3 ++-
 drivers/acpi/acpica/hwgpe.c     |    3 ++-
 drivers/acpi/acpica/hwtimer.c   |    3 +--
 drivers/acpi/acpica/hwxfsleep.c |   12 ++++--------
 drivers/acpi/acpica/nsaccess.c  |    3 +--
 drivers/acpi/acpica/nsinit.c    |    4 ++--
 drivers/acpi/acpica/psopcode.c  |   23 ++++++++++++++---------
 drivers/acpi/acpica/psparse.c   |    5 +++--
 drivers/acpi/acpica/rscalc.c    |    3 +--
 include/acpi/acpixf.h           |   13 +++++--------
 include/acpi/actypes.h          |    6 ++++--
 29 files changed, 109 insertions(+), 89 deletions(-)

diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 5935ba6..ed33ebc 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -309,10 +309,13 @@ acpi_ds_obj_stack_push(void *object, struct acpi_walk_state *walk_state);
 acpi_status
 acpi_ds_obj_stack_pop(u32 pop_count, struct acpi_walk_state *walk_state);
 
-struct acpi_walk_state *acpi_ds_create_walk_state(acpi_owner_id owner_id, union acpi_parse_object
-						  *origin, union acpi_operand_object
-						  *mth_desc, struct acpi_thread_state
-						  *thread);
+struct acpi_walk_state * acpi_ds_create_walk_state(acpi_owner_id owner_id,
+						   union acpi_parse_object
+						   *origin,
+						   union acpi_operand_object
+						   *mth_desc,
+						   struct acpi_thread_state
+						   *thread);
 
 acpi_status
 acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index c0a43b3..e975c67 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -84,9 +84,11 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
+acpi_status
+acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
-acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
+acpi_status
+acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 564f2ab..5b5be40 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -486,8 +486,10 @@ struct acpi_gpe_device_info {
 	struct acpi_namespace_node *gpe_device;
 };
 
-typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-		struct acpi_gpe_block_info *gpe_block, void *context);
+typedef acpi_status(*acpi_gpe_callback) (struct acpi_gpe_xrupt_info *
+					 gpe_xrupt_info,
+					 struct acpi_gpe_block_info *gpe_block,
+					 void *context);
 
 /* Information about each particular fixed event */
 
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index b725d78..eefcf47 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -150,8 +150,7 @@ u8 acpi_ps_has_completed_scope(struct acpi_parse_state *parser_state);
 
 void
 acpi_ps_pop_scope(struct acpi_parse_state *parser_state,
-		  union acpi_parse_object **op,
-		  u32 * arg_list, u32 * arg_count);
+		  union acpi_parse_object **op, u32 *arg_list, u32 *arg_count);
 
 acpi_status
 acpi_ps_push_scope(struct acpi_parse_state *parser_state,
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 3080c01..9dfa1c8 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -150,8 +150,7 @@ enum acpi_return_package_types {
  * is saved here (rather than in a separate table) in order to minimize the
  * overall size of the stored data.
  */
-static const union acpi_predefined_info predefined_names[] =
-{
+static const union acpi_predefined_info predefined_names[] = {
 	{{"_AC0", 0, ACPI_RTYPE_INTEGER}},
 	{{"_AC1", 0, ACPI_RTYPE_INTEGER}},
 	{{"_AC2", 0, ACPI_RTYPE_INTEGER}},
@@ -538,7 +537,8 @@ static const union acpi_predefined_info predefined_names[] =
 
 	/* Acpi 1.0 defined _WAK with no return value. Later, it was changed to return a package */
 
-	{{"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
+	{{"_WAK", 1,
+          ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
 			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,0}, 0,0}}, /* Fixed-length (2 Int), but is optional */
 
 	/* _WDG/_WED are MS extensions defined by "Windows Instrumentation" */
@@ -551,11 +551,12 @@ static const union acpi_predefined_info predefined_names[] =
 };
 
 #if 0
+
 	/* This is an internally implemented control method, no need to check */
-	{{"_OSI", 1, ACPI_RTYPE_INTEGER}},
+{ {
+"_OSI", 1, ACPI_RTYPE_INTEGER}},
 
 	/* TBD: */
-
 	_PRT - currently ignore reversed entries. attempt to fix here?
 	think about possibly fixing package elements like _BIF, etc.
 #endif
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index aa34d89..0df024e 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -649,7 +649,8 @@ acpi_ds_eval_data_object_operands(struct acpi_walk_state *walk_state,
 		    ((op->common.parent->common.aml_opcode != AML_PACKAGE_OP) &&
 		     (op->common.parent->common.aml_opcode !=
 		      AML_VAR_PACKAGE_OP)
-		     && (op->common.parent->common.aml_opcode != AML_NAME_OP))) {
+		     && (op->common.parent->common.aml_opcode !=
+			 AML_NAME_OP))) {
 			walk_state->result_obj = obj_desc;
 		}
 	}
diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 73a5447..4bbdd6c 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -560,7 +560,8 @@ acpi_ds_create_operand(struct acpi_walk_state *walk_state,
 					 * indicate this to the interpreter, set the
 					 * object to the root
 					 */
-					obj_desc = ACPI_CAST_PTR(union
+					obj_desc =
+					    ACPI_CAST_PTR(union
 								 acpi_operand_object,
 								 acpi_gbl_root_node);
 					status = AE_OK;
diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index d0e6555..9bb7fa4 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -51,8 +51,9 @@
 ACPI_MODULE_NAME("dswstate")
 
   /* Local prototypes */
-static acpi_status acpi_ds_result_stack_push(struct acpi_walk_state *ws);
-static acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *ws);
+static acpi_status
+acpi_ds_result_stack_push(struct acpi_walk_state *walk_state);
+static acpi_status acpi_ds_result_stack_pop(struct acpi_walk_state *walk_state);
 
 /*******************************************************************************
  *
@@ -536,9 +537,12 @@ struct acpi_walk_state *acpi_ds_pop_walk_state(struct acpi_thread_state *thread)
  *
  ******************************************************************************/
 
-struct acpi_walk_state *acpi_ds_create_walk_state(acpi_owner_id owner_id, union acpi_parse_object
-						  *origin, union acpi_operand_object
-						  *method_desc, struct acpi_thread_state
+struct acpi_walk_state *acpi_ds_create_walk_state(acpi_owner_id owner_id,
+						  union acpi_parse_object
+						  *origin,
+						  union acpi_operand_object
+						  *method_desc,
+						  struct acpi_thread_state
 						  *thread)
 {
 	struct acpi_walk_state *walk_state;
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index ef0193d..36d1205 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -89,7 +89,8 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 	/* Set the mask bit only if there are references to this GPE */
 
 	if (gpe_event_info->runtime_count) {
-		ACPI_SET_BIT(gpe_register_info->enable_for_run, (u8)register_bit);
+		ACPI_SET_BIT(gpe_register_info->enable_for_run,
+			     (u8)register_bit);
 	}
 
 	return_ACPI_STATUS(AE_OK);
@@ -106,8 +107,7 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
  * DESCRIPTION: Clear a GPE of stale events and enable it.
  *
  ******************************************************************************/
-acpi_status
-acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status;
 
@@ -131,8 +131,8 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 	}
 
 	/* Enable the requested GPE */
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }
 
@@ -150,7 +150,8 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
  *
  ******************************************************************************/
 
-acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status
+acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status = AE_OK;
 
@@ -191,7 +192,8 @@ acpi_status acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info
  *
  ******************************************************************************/
 
-acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
+acpi_status
+acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_info)
 {
 	acpi_status status = AE_OK;
 
@@ -208,7 +210,8 @@ acpi_status acpi_ev_remove_gpe_reference(struct acpi_gpe_event_info *gpe_event_i
 
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
-			status = acpi_hw_low_set_gpe(gpe_event_info,
+			status =
+			    acpi_hw_low_set_gpe(gpe_event_info,
 						     ACPI_GPE_DISABLE);
 		}
 
@@ -306,7 +309,8 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 
 	/* A Non-NULL gpe_device means this is a GPE Block Device */
 
-	obj_desc = acpi_ns_get_attached_object((struct acpi_namespace_node *)
+	obj_desc =
+	    acpi_ns_get_attached_object((struct acpi_namespace_node *)
 					       gpe_device);
 	if (!obj_desc || !obj_desc->device.gpe_block) {
 		return (NULL);
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 8cf4c10..1571a61 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -486,7 +486,8 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 					"Could not enable GPE 0x%02X",
-					gpe_index + gpe_block->block_base_number));
+					gpe_index +
+					gpe_block->block_base_number));
 				continue;
 			}
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index cb50dd9..228a0c3 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -374,7 +374,8 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				gpe_event_info->dispatch.handler = NULL;
 				gpe_event_info->flags &=
 				    ~ACPI_GPE_DISPATCH_MASK;
-			} else if ((gpe_event_info->
+			} else
+			    if ((gpe_event_info->
 				 flags & ACPI_GPE_DISPATCH_MASK) ==
 				ACPI_GPE_DISPATCH_NOTIFY) {
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 6786f00..1474241 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -227,8 +227,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 
 				/* Install a handler for this PCI root bridge */
 
-				status =
-				    acpi_install_address_space_handler((acpi_handle) pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
+				status = acpi_install_address_space_handler((acpi_handle) pci_root_node, ACPI_ADR_SPACE_PCI_CONFIG, ACPI_DEFAULT_HANDLER, NULL, NULL);
 				if (ACPI_FAILURE(status)) {
 					if (status == AE_SAME_HANDLER) {
 						/*
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 87c5f23..d36f997 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -221,7 +221,8 @@ acpi_setup_gpe_for_wake(acpi_handle wake_device,
 	if (wake_device == ACPI_ROOT_OBJECT) {
 		device_node = acpi_gbl_root_node;
 	} else {
-		device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
+		device_node =
+		    ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
 	}
 
 	/* Validate WakeDevice is of type Device */
@@ -324,7 +325,8 @@ ACPI_EXPORT_SYMBOL(acpi_setup_gpe_for_wake)
  *
  ******************************************************************************/
 
-acpi_status acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action)
+acpi_status
+acpi_set_gpe_wake_mask(acpi_handle gpe_device, u32 gpe_number, u8 action)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -694,8 +696,7 @@ ACPI_EXPORT_SYMBOL(acpi_remove_gpe_block)
  *              the FADT-defined gpe blocks. Otherwise, the GPE block device.
  *
  ******************************************************************************/
-acpi_status
-acpi_get_gpe_device(u32 index, acpi_handle *gpe_device)
+acpi_status acpi_get_gpe_device(u32 index, acpi_handle * gpe_device)
 {
 	struct acpi_gpe_device_info info;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index bfb062e..4492a4e 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -516,8 +516,8 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 			string_length--;
 		}
 
-		return_desc = acpi_ut_create_string_object((acpi_size)
-							   string_length);
+		return_desc =
+		    acpi_ut_create_string_object((acpi_size) string_length);
 		if (!return_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 691d476..9f15270 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -243,8 +243,7 @@ acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state)
 
 	/* Init object and attach to NS node */
 
-	obj_desc->mutex.sync_level =
-	    (u8) walk_state->operands[1]->integer.value;
+	obj_desc->mutex.sync_level = (u8)walk_state->operands[1]->integer.value;
 	obj_desc->mutex.node =
 	    (struct acpi_namespace_node *)walk_state->operands[0];
 
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 213c081..40608b3 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -464,7 +464,8 @@ void acpi_ex_dump_operand(union acpi_operand_object *obj_desc, u32 depth)
 
 	ACPI_FUNCTION_NAME(ex_dump_operand)
 
-	    if (!((ACPI_LV_EXEC & acpi_dbg_level)
+	    if (!
+		((ACPI_LV_EXEC & acpi_dbg_level)
 		  && (_COMPONENT & acpi_dbg_layer))) {
 		return;
 	}
@@ -810,7 +811,8 @@ void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags)
 	ACPI_FUNCTION_ENTRY();
 
 	if (!flags) {
-		if (!((ACPI_LV_OBJECTS & acpi_dbg_level)
+		if (!
+		    ((ACPI_LV_OBJECTS & acpi_dbg_level)
 		      && (_COMPONENT & acpi_dbg_layer))) {
 			return;
 		}
@@ -996,7 +998,8 @@ acpi_ex_dump_object_descriptor(union acpi_operand_object *obj_desc, u32 flags)
 	}
 
 	if (!flags) {
-		if (!((ACPI_LV_OBJECTS & acpi_dbg_level)
+		if (!
+		    ((ACPI_LV_OBJECTS & acpi_dbg_level)
 		      && (_COMPONENT & acpi_dbg_layer))) {
 			return_VOID;
 		}
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index a778415..419148a 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -54,8 +54,7 @@ ACPI_MODULE_NAME("exfldio")
 /* Local prototypes */
 static acpi_status
 acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
-		       u32 field_datum_byte_offset,
-		       u64 *value, u32 read_write);
+		       u32 field_datum_byte_offset, u64 *value, u32 read_write);
 
 static u8
 acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value);
diff --git a/drivers/acpi/acpica/exnames.c b/drivers/acpi/acpica/exnames.c
index fcc75fa..6d19bd4 100644
--- a/drivers/acpi/acpica/exnames.c
+++ b/drivers/acpi/acpica/exnames.c
@@ -53,8 +53,7 @@ ACPI_MODULE_NAME("exnames")
 /* Local prototypes */
 static char *acpi_ex_allocate_name_string(u32 prefix_count, u32 num_name_segs);
 
-static acpi_status
-acpi_ex_name_segment(u8 ** in_aml_address, char *name_string);
+static acpi_status acpi_ex_name_segment(u8 **in_aml_address, char *name_string);
 
 /*******************************************************************************
  *
@@ -178,7 +177,8 @@ static acpi_status acpi_ex_name_segment(u8 ** in_aml_address, char *name_string)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_LOAD, "Bytes from stream:\n"));
 
-	for (index = 0; (index < ACPI_NAME_SIZE)
+	for (index = 0;
+	     (index < ACPI_NAME_SIZE)
 	     && (acpi_ut_valid_acpi_char(*aml_address, 0)); index++) {
 		char_buf[index] = *aml_address++;
 		ACPI_DEBUG_PRINT((ACPI_DB_LOAD, "%c\n", char_buf[index]));
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index f232fba..17dc218 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -337,7 +337,8 @@ acpi_ex_resolve_operands(u16 opcode,
 			if ((opcode == AML_STORE_OP) &&
 			    ((*stack_ptr)->common.type ==
 			     ACPI_TYPE_LOCAL_REFERENCE)
-			    && ((*stack_ptr)->reference.class == ACPI_REFCLASS_INDEX)) {
+			    && ((*stack_ptr)->reference.class ==
+				ACPI_REFCLASS_INDEX)) {
 				goto next_operand;
 			}
 			break;
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index db40765..3b3b5e4 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -339,7 +339,8 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 acpi_status
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
-				 struct acpi_gpe_block_info *gpe_block, void *context)
+				 struct acpi_gpe_block_info * gpe_block,
+				 void *context)
 {
 	u32 i;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index b6411f1..438004a 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -101,8 +101,7 @@ acpi_status acpi_get_timer(u32 * ticks)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	status =
-	    acpi_hw_read(ticks, &acpi_gbl_FADT.xpm_timer_block);
+	status = acpi_hw_read(ticks, &acpi_gbl_FADT.xpm_timer_block);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 0ff1ece..ae443fe2 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -49,8 +49,7 @@
 ACPI_MODULE_NAME("hwxfsleep")
 
 /* Local prototypes */
-static acpi_status
-acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
+static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
 
 /*
  * Dispatch table used to efficiently branch to the various sleep
@@ -234,8 +233,7 @@ ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios)
  *              function.
  *
  ******************************************************************************/
-static acpi_status
-acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id)
+static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id)
 {
 	acpi_status status;
 	struct acpi_sleep_functions *sleep_functions =
@@ -369,8 +367,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	status =
-	    acpi_hw_sleep_dispatch(sleep_state, ACPI_SLEEP_FUNCTION_ID);
+	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_SLEEP_FUNCTION_ID);
 	return_ACPI_STATUS(status);
 }
 
@@ -396,8 +393,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
 
 	status =
-	    acpi_hw_sleep_dispatch(sleep_state,
-				   ACPI_WAKE_PREP_FUNCTION_ID);
+	    acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_PREP_FUNCTION_ID);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 23db53c..fc168e6 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -179,8 +179,7 @@ acpi_status acpi_ns_root_initialize(void)
 
 				/* Build an object around the static string */
 
-				obj_desc->string.length =
-				    (u32) ACPI_STRLEN(val);
+				obj_desc->string.length = (u32)ACPI_STRLEN(val);
 				obj_desc->string.pointer = val;
 				obj_desc->common.flags |= AOPOBJ_STATIC_POINTER;
 				break;
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 95ffe8d..4328e2a 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -96,8 +96,8 @@ acpi_status acpi_ns_initialize_objects(void)
 	/* Walk entire namespace from the supplied root */
 
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX, acpi_ns_init_one_object, NULL,
-				     &info, NULL);
+				     ACPI_UINT32_MAX, acpi_ns_init_one_object,
+				     NULL, &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index ed1d457..e5572a7 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -392,10 +392,12 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 		 AML_FLAGS_EXEC_1A_0T_1R | AML_NO_OPERAND_RESOLVE),
 /* 38 */ ACPI_OP("LAnd", ARGP_LAND_OP, ARGI_LAND_OP, ACPI_TYPE_ANY,
 		 AML_CLASS_EXECUTE, AML_TYPE_EXEC_2A_0T_1R,
-		 AML_FLAGS_EXEC_2A_0T_1R | AML_LOGICAL_NUMERIC | AML_CONSTANT),
+			 AML_FLAGS_EXEC_2A_0T_1R | AML_LOGICAL_NUMERIC |
+			 AML_CONSTANT),
 /* 39 */ ACPI_OP("LOr", ARGP_LOR_OP, ARGI_LOR_OP, ACPI_TYPE_ANY,
 		 AML_CLASS_EXECUTE, AML_TYPE_EXEC_2A_0T_1R,
-		 AML_FLAGS_EXEC_2A_0T_1R | AML_LOGICAL_NUMERIC | AML_CONSTANT),
+		 	 AML_FLAGS_EXEC_2A_0T_1R | AML_LOGICAL_NUMERIC |
+			 AML_CONSTANT),
 /* 3A */ ACPI_OP("LNot", ARGP_LNOT_OP, ARGI_LNOT_OP, ACPI_TYPE_ANY,
 		 AML_CLASS_EXECUTE, AML_TYPE_EXEC_1A_0T_1R,
 		 AML_FLAGS_EXEC_1A_0T_1R | AML_CONSTANT),
@@ -495,7 +497,8 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 		 AML_NSNODE | AML_NAMED | AML_DEFER),
 /* 59 */ ACPI_OP("Field", ARGP_FIELD_OP, ARGI_FIELD_OP, ACPI_TYPE_ANY,
 		 AML_CLASS_NAMED_OBJECT, AML_TYPE_NAMED_FIELD,
-		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD),
+			 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
+			 AML_FIELD),
 /* 5A */ ACPI_OP("Device", ARGP_DEVICE_OP, ARGI_DEVICE_OP,
 		 ACPI_TYPE_DEVICE, AML_CLASS_NAMED_OBJECT,
 		 AML_TYPE_NAMED_NO_OBJ,
@@ -519,12 +522,13 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 /* 5E */ ACPI_OP("IndexField", ARGP_INDEX_FIELD_OP, ARGI_INDEX_FIELD_OP,
 		 ACPI_TYPE_ANY, AML_CLASS_NAMED_OBJECT,
 		 AML_TYPE_NAMED_FIELD,
-		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD),
+		 	 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
+			 AML_FIELD),
 /* 5F */ ACPI_OP("BankField", ARGP_BANK_FIELD_OP, ARGI_BANK_FIELD_OP,
-		 ACPI_TYPE_LOCAL_BANK_FIELD, AML_CLASS_NAMED_OBJECT,
-		 AML_TYPE_NAMED_FIELD,
-		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_FIELD |
-		 AML_DEFER),
+		 	 ACPI_TYPE_LOCAL_BANK_FIELD,
+			 AML_CLASS_NAMED_OBJECT, AML_TYPE_NAMED_FIELD,
+		 	 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
+			 AML_FIELD | AML_DEFER),
 
 /* Internal opcodes that map to invalid AML opcodes */
 
@@ -632,7 +636,8 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 /* 7D */ ACPI_OP("[EvalSubTree]", ARGP_SCOPE_OP, ARGI_SCOPE_OP,
 		 ACPI_TYPE_ANY, AML_CLASS_NAMED_OBJECT,
 		 AML_TYPE_NAMED_NO_OBJ,
-		 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE | AML_NSNODE),
+		 	 AML_HAS_ARGS | AML_NSOBJECT | AML_NSOPCODE |
+			 AML_NSNODE),
 
 /* ACPI 3.0 opcodes */
 
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 0198570..dfdda00 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -459,8 +459,9 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 
 			/* Executing a control method - additional cleanup */
 
-			acpi_ds_terminate_control_method(
-				walk_state->method_desc, walk_state);
+			acpi_ds_terminate_control_method(walk_state->
+							 method_desc,
+							 walk_state);
 		}
 
 		acpi_ds_delete_walk_state(walk_state);
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index de12469..4274567 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -664,8 +664,7 @@ acpi_rs_get_pci_routing_table_length(union acpi_operand_object *package_object,
 						     (*sub_object_list)->string.
 						     length + 1);
 			} else {
-				temp_size_needed +=
-				    acpi_ns_get_pathname_length((*sub_object_list)->reference.node);
+				temp_size_needed += acpi_ns_get_pathname_length((*sub_object_list)->reference.node);
 			}
 		} else {
 			/*
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 352fd1a..fe84aee 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -178,8 +178,7 @@ acpi_status acpi_unload_table_id(acpi_owner_id id);
 
 acpi_status
 acpi_get_table_header(acpi_string signature,
-		      u32 instance,
-		      struct acpi_table_header *out_table_header);
+		      u32 instance, struct acpi_table_header *out_table_header);
 
 acpi_status
 acpi_get_table_with_size(acpi_string signature,
@@ -190,8 +189,7 @@ acpi_get_table(acpi_string signature,
 	       u32 instance, struct acpi_table_header **out_table);
 
 acpi_status
-acpi_get_table_by_index(u32 table_index,
-			struct acpi_table_header **out_table);
+acpi_get_table_by_index(u32 table_index, struct acpi_table_header **out_table);
 
 acpi_status
 acpi_install_table_handler(acpi_tbl_handler handler, void *context);
@@ -300,10 +298,9 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							 u32 gpe_number,
 							 acpi_gpe_handler
 							 address))
-acpi_status
-acpi_install_notify_handler(acpi_handle device,
-			    u32 handler_type,
-			    acpi_notify_handler handler, void *context);
+acpi_status acpi_install_notify_handler(acpi_handle device, u32 handler_type,
+					acpi_notify_handler handler,
+					void *context);
 
 acpi_status
 acpi_remove_notify_handler(acpi_handle device,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ea50a31..1fa6ba1 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -922,7 +922,8 @@ struct acpi_system_info {
 /*
  * Types specific to the OS service interfaces
  */
-typedef u32(ACPI_SYSTEM_XFACE * acpi_osd_handler) (void *context);
+typedef u32
+ (ACPI_SYSTEM_XFACE * acpi_osd_handler) (void *context);
 
 typedef void
  (ACPI_SYSTEM_XFACE * acpi_osd_exec_callback) (void *context);
@@ -938,7 +939,8 @@ void (*acpi_gbl_event_handler) (u32 event_type,
 #define ACPI_EVENT_TYPE_GPE         0
 #define ACPI_EVENT_TYPE_FIXED       1
 
-typedef u32(*acpi_event_handler) (void *context);
+typedef
+u32(*acpi_event_handler) (void *context);
 
 typedef
 u32 (*acpi_gpe_handler) (acpi_handle gpe_device, u32 gpe_number, void *context);
-- 
1.7.10

