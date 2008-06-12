From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/17] ACPICA: Eliminate acpi_native_uint type
Date: Thu, 12 Jun 2008 00:35:04 -0400
Message-ID: <c5c0d7125e26a14a1f7a086a21f2ee11ec0a944f.1213245200.git.len.brown@intel.com>
References: <1213245316-20835-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36493 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYFLEfW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2008 00:35:22 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2C009CP22WU283@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 23:35:21 -0500 (CDT)
In-reply-to: <1213245316-20835-1-git-send-email-lenb@kernel.org>
In-reply-to: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
References: <e3f06dd844c1cbaa5b7ef6a971c182db73b8d4e9.1213245200.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

No longer needed; replaced mostly with u32, but also acpi_size
where a type that changes 32/64 bit on 32/64-bit platforms is
required.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/srat_32.c          |    2 +-
 drivers/acpi/bus.c                 |    2 +-
 drivers/acpi/dispatcher/dsinit.c   |    2 +-
 drivers/acpi/dispatcher/dsopcode.c |    2 +-
 drivers/acpi/dispatcher/dswstate.c |   10 +++++-----
 drivers/acpi/events/evevent.c      |    6 +++---
 drivers/acpi/events/evgpe.c        |   14 ++++----------
 drivers/acpi/events/evgpeblk.c     |   18 ++++++++++--------
 drivers/acpi/events/evmisc.c       |    4 ++--
 drivers/acpi/events/evregion.c     |    4 ++--
 drivers/acpi/events/evrgnini.c     |    2 +-
 drivers/acpi/executer/exconfig.c   |   14 +++++++-------
 drivers/acpi/executer/exconvrt.c   |   12 ++++++------
 drivers/acpi/executer/exdump.c     |    2 +-
 drivers/acpi/executer/exfldio.c    |    9 +++++----
 drivers/acpi/executer/exmisc.c     |    8 ++++----
 drivers/acpi/executer/exregion.c   |    2 +-
 drivers/acpi/namespace/nsdump.c    |    2 +-
 drivers/acpi/namespace/nsload.c    |    3 +--
 drivers/acpi/namespace/nsparse.c   |   15 +++++++--------
 drivers/acpi/namespace/nsutils.c   |   26 ++++++++++++--------------
 drivers/acpi/namespace/nsxfeval.c  |    2 +-
 drivers/acpi/parser/psargs.c       |    4 ++--
 drivers/acpi/parser/psxface.c      |    2 +-
 drivers/acpi/resources/rscalc.c    |    4 ++--
 drivers/acpi/resources/rsmisc.c    |    2 +-
 drivers/acpi/resources/rsutils.c   |   12 ++++++------
 drivers/acpi/tables/tbfadt.c       |    6 +++---
 drivers/acpi/tables/tbfind.c       |    5 ++---
 drivers/acpi/tables/tbinstal.c     |   30 ++++++++++++++----------------
 drivers/acpi/tables/tbutils.c      |   15 +++++++--------
 drivers/acpi/tables/tbxface.c      |   28 +++++++++++++---------------
 drivers/acpi/tables/tbxfroot.c     |    4 ++--
 drivers/acpi/utilities/utcopy.c    |    4 ++--
 drivers/acpi/utilities/utdebug.c   |   28 +++++++++++++++++-----------
 drivers/acpi/utilities/utdelete.c  |    2 +-
 drivers/acpi/utilities/uteval.c    |    4 ++--
 drivers/acpi/utilities/utmisc.c    |   14 +++++++-------
 drivers/acpi/utilities/utobject.c  |    4 ++--
 include/acpi/acdispat.h            |    2 +-
 include/acpi/acglobal.h            |    2 +-
 include/acpi/acmacros.h            |   24 ++++++++++++------------
 include/acpi/acnamesp.h            |   10 ++++------
 include/acpi/acpiosxf.h            |    2 +-
 include/acpi/acpixf.h              |    8 ++++----
 include/acpi/acstruct.h            |    2 +-
 include/acpi/actables.h            |   27 ++++++++++++---------------
 include/acpi/actypes.h             |   16 ++++++----------
 include/acpi/acutils.h             |    4 ++--
 49 files changed, 205 insertions(+), 221 deletions(-)

diff --git a/arch/x86/kernel/srat_32.c b/arch/x86/kernel/srat_32.c
index 70e4a37..a29192f 100644
--- a/arch/x86/kernel/srat_32.c
+++ b/arch/x86/kernel/srat_32.c
@@ -269,7 +269,7 @@ int __init get_memcfg_from_srat(void)
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_rsdp *rsdp = NULL;
 	struct acpi_table_rsdt *rsdt = NULL;
-	acpi_native_uint rsdp_address = 0;
+	u32 rsdp_address = 0;
 	struct acpi_static_rsdt saved_rsdt;
 	int tables = 0;
 	int i = 0;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a6dbcf4..afb3438 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -612,7 +612,7 @@ static int __init acpi_bus_init_irq(void)
 	return 0;
 }
 
-acpi_native_uint acpi_gbl_permanent_mmap;
+u8 acpi_gbl_permanent_mmap;
 
 
 void __init acpi_early_init(void)
diff --git a/drivers/acpi/dispatcher/dsinit.c b/drivers/acpi/dispatcher/dsinit.c
index 610b1ee..949f7c7 100644
--- a/drivers/acpi/dispatcher/dsinit.c
+++ b/drivers/acpi/dispatcher/dsinit.c
@@ -151,7 +151,7 @@ acpi_ds_init_one_object(acpi_handle obj_handle,
  ******************************************************************************/
 
 acpi_status
-acpi_ds_initialize_objects(acpi_native_uint table_index,
+acpi_ds_initialize_objects(u32 table_index,
 			   struct acpi_namespace_node * start_node)
 {
 	acpi_status status;
diff --git a/drivers/acpi/dispatcher/dsopcode.c b/drivers/acpi/dispatcher/dsopcode.c
index a818e0d..ac0bfb1 100644
--- a/drivers/acpi/dispatcher/dsopcode.c
+++ b/drivers/acpi/dispatcher/dsopcode.c
@@ -848,7 +848,7 @@ acpi_ds_eval_table_region_operands(struct acpi_walk_state *walk_state,
 	union acpi_operand_object **operand;
 	struct acpi_namespace_node *node;
 	union acpi_parse_object *next_op;
-	acpi_native_uint table_index;
+	u32 table_index;
 	struct acpi_table_header *table;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_eval_table_region_operands, op);
diff --git a/drivers/acpi/dispatcher/dswstate.c b/drivers/acpi/dispatcher/dswstate.c
index bda23ed..b00d4af 100644
--- a/drivers/acpi/dispatcher/dswstate.c
+++ b/drivers/acpi/dispatcher/dswstate.c
@@ -70,7 +70,7 @@ acpi_status
 acpi_ds_result_pop(union acpi_operand_object **object,
 		   struct acpi_walk_state *walk_state)
 {
-	acpi_native_uint index;
+	u32 index;
 	union acpi_generic_state *state;
 	acpi_status status;
 
@@ -122,7 +122,7 @@ acpi_ds_result_pop(union acpi_operand_object **object,
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Obj=%p [%s] Index=%X State=%p Num=%X\n", *object,
 			  acpi_ut_get_object_type_name(*object),
-			  (u32) index, walk_state, walk_state->result_count));
+			  index, walk_state, walk_state->result_count));
 
 	return (AE_OK);
 }
@@ -146,7 +146,7 @@ acpi_ds_result_push(union acpi_operand_object * object,
 {
 	union acpi_generic_state *state;
 	acpi_status status;
-	acpi_native_uint index;
+	u32 index;
 
 	ACPI_FUNCTION_NAME(ds_result_push);
 
@@ -400,7 +400,7 @@ void
 acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 				 struct acpi_walk_state *walk_state)
 {
-	acpi_native_int i;
+	s32 i;
 	union acpi_operand_object *obj_desc;
 
 	ACPI_FUNCTION_NAME(ds_obj_stack_pop_and_delete);
@@ -409,7 +409,7 @@ acpi_ds_obj_stack_pop_and_delete(u32 pop_count,
 		return;
 	}
 
-	for (i = (acpi_native_int) (pop_count - 1); i >= 0; i--) {
+	for (i = (s32) pop_count - 1; i >= 0; i--) {
 		if (walk_state->num_operands == 0) {
 			return;
 		}
diff --git a/drivers/acpi/events/evevent.c b/drivers/acpi/events/evevent.c
index 5d30e5b..c56c5c6 100644
--- a/drivers/acpi/events/evevent.c
+++ b/drivers/acpi/events/evevent.c
@@ -188,7 +188,7 @@ acpi_status acpi_ev_install_xrupt_handlers(void)
 
 static acpi_status acpi_ev_fixed_event_initialize(void)
 {
-	acpi_native_uint i;
+	u32 i;
 	acpi_status status;
 
 	/*
@@ -231,7 +231,7 @@ u32 acpi_ev_fixed_event_detect(void)
 	u32 int_status = ACPI_INTERRUPT_NOT_HANDLED;
 	u32 fixed_status;
 	u32 fixed_enable;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_NAME(ev_fixed_event_detect);
 
@@ -260,7 +260,7 @@ u32 acpi_ev_fixed_event_detect(void)
 
 			/* Found an active (signalled) event */
 			acpi_os_fixed_event_count(i);
-			int_status |= acpi_ev_fixed_event_dispatch((u32) i);
+			int_status |= acpi_ev_fixed_event_dispatch(i);
 		}
 	}
 
diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index a68ec0c..2a0014b 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -305,7 +305,7 @@ struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 {
 	union acpi_operand_object *obj_desc;
 	struct acpi_gpe_block_info *gpe_block;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -379,8 +379,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 	u32 status_reg;
 	u32 enable_reg;
 	acpi_cpu_flags flags;
-	acpi_native_uint i;
-	acpi_native_uint j;
+	u32 i;
+	u32 j;
 
 	ACPI_FUNCTION_NAME(ev_gpe_detect);
 
@@ -462,13 +462,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 					 */
 					int_status |=
 					    acpi_ev_gpe_dispatch(&gpe_block->
-								 event_info[(i *
-									     ACPI_GPE_REGISTER_WIDTH)
-									    +
-									    j],
-								 (u32) j +
-								 gpe_register_info->
-								 base_gpe_number);
+						event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
 				}
 			}
 		}
diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index e6c4d4c..73c058e 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -189,8 +189,8 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			    struct acpi_gpe_block_info *gpe_block)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
-	acpi_native_uint i;
-	acpi_native_uint j;
+	u32 i;
+	u32 j;
 
 	ACPI_FUNCTION_TRACE(ev_delete_gpe_handlers);
 
@@ -203,7 +203,8 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 		for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
 			gpe_event_info =
 			    &gpe_block->
-			    event_info[(i * ACPI_GPE_REGISTER_WIDTH) + j];
+			    event_info[((acpi_size) i *
+					ACPI_GPE_REGISTER_WIDTH) + j];
 
 			if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 			    ACPI_GPE_DISPATCH_HANDLER) {
@@ -744,8 +745,8 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 	struct acpi_gpe_event_info *gpe_event_info = NULL;
 	struct acpi_gpe_event_info *this_event;
 	struct acpi_gpe_register_info *this_register;
-	acpi_native_uint i;
-	acpi_native_uint j;
+	u32 i;
+	u32 j;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ev_create_gpe_info_blocks);
@@ -983,8 +984,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 	struct acpi_gpe_walk_info gpe_info;
 	u32 wake_gpe_count;
 	u32 gpe_enabled_count;
-	acpi_native_uint i;
-	acpi_native_uint j;
+	u32 i;
+	u32 j;
 
 	ACPI_FUNCTION_TRACE(ev_initialize_gpe_block);
 
@@ -1033,7 +1034,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 
 			gpe_event_info =
 			    &gpe_block->
-			    event_info[(i * ACPI_GPE_REGISTER_WIDTH) + j];
+			    event_info[((acpi_size) i *
+					ACPI_GPE_REGISTER_WIDTH) + j];
 
 			if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 			     ACPI_GPE_DISPATCH_METHOD)
diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 2113e58..1d5670b 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -575,7 +575,7 @@ acpi_status acpi_ev_release_global_lock(void)
 
 void acpi_ev_terminate(void)
 {
-	acpi_native_uint i;
+	u32 i;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ev_terminate);
@@ -589,7 +589,7 @@ void acpi_ev_terminate(void)
 		/* Disable all fixed events */
 
 		for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
-			status = acpi_disable_event((u32) i, 0);
+			status = acpi_disable_event(i, 0);
 			if (ACPI_FAILURE(status)) {
 				ACPI_ERROR((AE_INFO,
 					    "Could not disable fixed event %d",
diff --git a/drivers/acpi/events/evregion.c b/drivers/acpi/events/evregion.c
index 5ab4c01..236fbd1 100644
--- a/drivers/acpi/events/evregion.c
+++ b/drivers/acpi/events/evregion.c
@@ -81,7 +81,7 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 acpi_status acpi_ev_install_region_handlers(void)
 {
 	acpi_status status;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ev_install_region_handlers);
 
@@ -151,7 +151,7 @@ acpi_status acpi_ev_install_region_handlers(void)
 acpi_status acpi_ev_initialize_op_regions(void)
 {
 	acpi_status status;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ev_initialize_op_regions);
 
diff --git a/drivers/acpi/events/evrgnini.c b/drivers/acpi/events/evrgnini.c
index 2e3d2c5..6b94b38 100644
--- a/drivers/acpi/events/evrgnini.c
+++ b/drivers/acpi/events/evrgnini.c
@@ -380,7 +380,7 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 	acpi_status status;
 	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
-	acpi_native_uint i;
+	u32 i;
 
 	/*
 	 * Get the _HID and check for a PCI Root Bridge
diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index 39d7421..b8ee161 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -53,7 +53,7 @@ ACPI_MODULE_NAME("exconfig")
 
 /* Local prototypes */
 static acpi_status
-acpi_ex_add_table(acpi_native_uint table_index,
+acpi_ex_add_table(u32 table_index,
 		  struct acpi_namespace_node *parent_node,
 		  union acpi_operand_object **ddb_handle);
 
@@ -73,7 +73,7 @@ acpi_ex_add_table(acpi_native_uint table_index,
  ******************************************************************************/
 
 static acpi_status
-acpi_ex_add_table(acpi_native_uint table_index,
+acpi_ex_add_table(u32 table_index,
 		  struct acpi_namespace_node *parent_node,
 		  union acpi_operand_object **ddb_handle)
 {
@@ -128,12 +128,12 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 {
 	acpi_status status;
 	union acpi_operand_object **operand = &walk_state->operands[0];
-	acpi_native_uint table_index;
 	struct acpi_namespace_node *parent_node;
 	struct acpi_namespace_node *start_node;
 	struct acpi_namespace_node *parameter_node = NULL;
 	union acpi_operand_object *ddb_handle;
 	struct acpi_table_header *table;
+	u32 table_index;
 
 	ACPI_FUNCTION_TRACE(ex_load_table_op);
 
@@ -280,7 +280,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 {
 	union acpi_operand_object *ddb_handle;
 	struct acpi_table_desc table_desc;
-	acpi_native_uint table_index;
+	u32 table_index;
 	acpi_status status;
 	u32 length;
 
@@ -437,7 +437,7 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 {
 	acpi_status status = AE_OK;
 	union acpi_operand_object *table_desc = ddb_handle;
-	acpi_native_uint table_index;
+	u32 table_index;
 	struct acpi_table_header *table;
 
 	ACPI_FUNCTION_TRACE(ex_unload_table);
@@ -454,9 +454,9 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the table index from the ddb_handle */
+	/* Get the table index from the ddb_handle (acpi_size for 64-bit case) */
 
-	table_index = (acpi_native_uint) table_desc->reference.object;
+	table_index = (u32) (acpi_size) table_desc->reference.object;
 
 	/* Invoke table handler if present */
 
diff --git a/drivers/acpi/executer/exconvrt.c b/drivers/acpi/executer/exconvrt.c
index fd954b4..261d975 100644
--- a/drivers/acpi/executer/exconvrt.c
+++ b/drivers/acpi/executer/exconvrt.c
@@ -288,11 +288,11 @@ acpi_ex_convert_to_ascii(acpi_integer integer,
 			 u16 base, u8 * string, u8 data_width)
 {
 	acpi_integer digit;
-	acpi_native_uint i;
-	acpi_native_uint j;
-	acpi_native_uint k = 0;
-	acpi_native_uint hex_length;
-	acpi_native_uint decimal_length;
+	u32 i;
+	u32 j;
+	u32 k = 0;
+	u32 hex_length;
+	u32 decimal_length;
 	u32 remainder;
 	u8 supress_zeros;
 
@@ -348,7 +348,7 @@ acpi_ex_convert_to_ascii(acpi_integer integer,
 
 		/* hex_length: 2 ascii hex chars per data byte */
 
-		hex_length = (acpi_native_uint) ACPI_MUL_2(data_width);
+		hex_length = ACPI_MUL_2(data_width);
 		for (i = 0, j = (hex_length - 1); i < hex_length; i++, j--) {
 
 			/* Get one hex digit, most significant digits first */
diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 74f1b22..976016f 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -775,7 +775,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      u32 num_levels,
 		      char *note, char *module_name, u32 line_number)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_NAME(ex_dump_operands);
 
diff --git a/drivers/acpi/executer/exfldio.c b/drivers/acpi/executer/exfldio.c
index e336b5d..9ff9d1f 100644
--- a/drivers/acpi/executer/exfldio.c
+++ b/drivers/acpi/executer/exfldio.c
@@ -153,14 +153,15 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 			/*
 			 * Slack mode only:  We will go ahead and allow access to this
 			 * field if it is within the region length rounded up to the next
-			 * access width boundary.
+			 * access width boundary. acpi_size cast for 64-bit compile.
 			 */
 			if (ACPI_ROUND_UP(rgn_desc->region.length,
 					  obj_desc->common_field.
 					  access_byte_width) >=
-			    (obj_desc->common_field.base_byte_offset +
-			     (acpi_native_uint) obj_desc->common_field.
-			     access_byte_width + field_datum_byte_offset)) {
+			    ((acpi_size) obj_desc->common_field.
+			     base_byte_offset +
+			     obj_desc->common_field.access_byte_width +
+			     field_datum_byte_offset)) {
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
diff --git a/drivers/acpi/executer/exmisc.c b/drivers/acpi/executer/exmisc.c
index cc956a5..731414a 100644
--- a/drivers/acpi/executer/exmisc.c
+++ b/drivers/acpi/executer/exmisc.c
@@ -329,8 +329,8 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 		/* Result of two Strings is a String */
 
-		return_desc = acpi_ut_create_string_object((acpi_size)
-							   (operand0->string.
+		return_desc = acpi_ut_create_string_object(((acpi_size)
+							    operand0->string.
 							    length +
 							    local_operand1->
 							    string.length));
@@ -352,8 +352,8 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
 
 		/* Result of two Buffers is a Buffer */
 
-		return_desc = acpi_ut_create_buffer_object((acpi_size)
-							   (operand0->buffer.
+		return_desc = acpi_ut_create_buffer_object(((acpi_size)
+							    operand0->buffer.
 							    length +
 							    local_operand1->
 							    buffer.length));
diff --git a/drivers/acpi/executer/exregion.c b/drivers/acpi/executer/exregion.c
index 7cd8bb5..7a41c40 100644
--- a/drivers/acpi/executer/exregion.c
+++ b/drivers/acpi/executer/exregion.c
@@ -156,7 +156,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 		/* Create a new mapping starting at the address given */
 
 		mem_info->mapped_logical_address =
-		    acpi_os_map_memory((acpi_native_uint) address, window_size);
+			acpi_os_map_memory((acpi_physical_address) address, window_size);
 		if (!mem_info->mapped_logical_address) {
 			ACPI_ERROR((AE_INFO,
 				    "Could not map memory at %8.8X%8.8X, size %X",
diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index 5445751..904f951 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -73,7 +73,7 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 
 void acpi_ns_print_pathname(u32 num_segments, char *pathname)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_NAME(ns_print_pathname);
 
diff --git a/drivers/acpi/namespace/nsload.c b/drivers/acpi/namespace/nsload.c
index 2c92f6c..a4a412b 100644
--- a/drivers/acpi/namespace/nsload.c
+++ b/drivers/acpi/namespace/nsload.c
@@ -71,8 +71,7 @@ static acpi_status acpi_ns_delete_subtree(acpi_handle start_handle);
  ******************************************************************************/
 
 acpi_status
-acpi_ns_load_table(acpi_native_uint table_index,
-		   struct acpi_namespace_node *node)
+acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/namespace/nsparse.c b/drivers/acpi/namespace/nsparse.c
index 46a79b0..a82271a 100644
--- a/drivers/acpi/namespace/nsparse.c
+++ b/drivers/acpi/namespace/nsparse.c
@@ -63,13 +63,13 @@ ACPI_MODULE_NAME("nsparse")
  *
  ******************************************************************************/
 acpi_status
-acpi_ns_one_complete_parse(acpi_native_uint pass_number,
-			   acpi_native_uint table_index,
-			   struct acpi_namespace_node * start_node)
+acpi_ns_one_complete_parse(u32 pass_number,
+			   u32 table_index,
+			   struct acpi_namespace_node *start_node)
 {
 	union acpi_parse_object *parse_root;
 	acpi_status status;
-	acpi_native_uint aml_length;
+       u32 aml_length;
 	u8 *aml_start;
 	struct acpi_walk_state *walk_state;
 	struct acpi_table_header *table;
@@ -112,8 +112,8 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
 		aml_start = (u8 *) table + sizeof(struct acpi_table_header);
 		aml_length = table->length - sizeof(struct acpi_table_header);
 		status = acpi_ds_init_aml_walk(walk_state, parse_root, NULL,
-					       aml_start, (u32) aml_length,
-					       NULL, (u8) pass_number);
+					       aml_start, aml_length, NULL,
+					       (u8) pass_number);
 	}
 
 	if (ACPI_FAILURE(status)) {
@@ -158,8 +158,7 @@ acpi_ns_one_complete_parse(acpi_native_uint pass_number,
  ******************************************************************************/
 
 acpi_status
-acpi_ns_parse_table(acpi_native_uint table_index,
-		    struct acpi_namespace_node *start_node)
+acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node)
 {
 	acpi_status status;
 
diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/namespace/nsutils.c
index 64c0398..5b5619c 100644
--- a/drivers/acpi/namespace/nsutils.c
+++ b/drivers/acpi/namespace/nsutils.c
@@ -365,7 +365,7 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 	char *internal_name = info->internal_name;
 	char *external_name = info->next_external_char;
 	char *result = NULL;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ns_build_internal_name);
 
@@ -400,12 +400,11 @@ acpi_status acpi_ns_build_internal_name(struct acpi_namestring_info *info)
 			result = &internal_name[i];
 		} else if (num_segments == 2) {
 			internal_name[i] = AML_DUAL_NAME_PREFIX;
-			result = &internal_name[(acpi_native_uint) (i + 1)];
+			result = &internal_name[(acpi_size) i + 1];
 		} else {
 			internal_name[i] = AML_MULTI_NAME_PREFIX_OP;
-			internal_name[(acpi_native_uint) (i + 1)] =
-			    (char)num_segments;
-			result = &internal_name[(acpi_native_uint) (i + 2)];
+			internal_name[(acpi_size) i + 1] = (char)num_segments;
+			result = &internal_name[(acpi_size) i + 2];
 		}
 	}
 
@@ -531,12 +530,12 @@ acpi_ns_externalize_name(u32 internal_name_length,
 			 char *internal_name,
 			 u32 * converted_name_length, char **converted_name)
 {
-	acpi_native_uint names_index = 0;
-	acpi_native_uint num_segments = 0;
-	acpi_native_uint required_length;
-	acpi_native_uint prefix_length = 0;
-	acpi_native_uint i = 0;
-	acpi_native_uint j = 0;
+	u32 names_index = 0;
+	u32 num_segments = 0;
+	u32 required_length;
+	u32 prefix_length = 0;
+	u32 i = 0;
+	u32 j = 0;
 
 	ACPI_FUNCTION_TRACE(ns_externalize_name);
 
@@ -582,9 +581,8 @@ acpi_ns_externalize_name(u32 internal_name_length,
 			/* <count> 4-byte names */
 
 			names_index = prefix_length + 2;
-			num_segments = (acpi_native_uint) (u8)
-			    internal_name[(acpi_native_uint)
-					  (prefix_length + 1)];
+			num_segments = (u8)
+			    internal_name[(acpi_size) prefix_length + 1];
 			break;
 
 		case AML_DUAL_NAME_PREFIX:
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index b4e135e..38be586 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -441,7 +441,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 	u32 flags;
 	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
-	acpi_native_uint i;
+	u32 i;
 	int found;
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
diff --git a/drivers/acpi/parser/psargs.c b/drivers/acpi/parser/psargs.c
index e944637..d830b29 100644
--- a/drivers/acpi/parser/psargs.c
+++ b/drivers/acpi/parser/psargs.c
@@ -76,7 +76,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 {
 	u8 *aml = parser_state->aml;
 	u32 package_length = 0;
-	acpi_native_uint byte_count;
+	u32 byte_count;
 	u8 byte_zero_mask = 0x3F;	/* Default [0:5] */
 
 	ACPI_FUNCTION_TRACE(ps_get_next_package_length);
@@ -86,7 +86,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	 * used to encode the package length, either 0,1,2, or 3
 	 */
 	byte_count = (aml[0] >> 6);
-	parser_state->aml += (byte_count + 1);
+	parser_state->aml += ((acpi_size) byte_count + 1);
 
 	/* Get bytes 3, 2, 1 as needed */
 
diff --git a/drivers/acpi/parser/psxface.c b/drivers/acpi/parser/psxface.c
index 5ee09e1..270469a 100644
--- a/drivers/acpi/parser/psxface.c
+++ b/drivers/acpi/parser/psxface.c
@@ -333,7 +333,7 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 static void
 acpi_ps_update_parameter_list(struct acpi_evaluate_info *info, u16 action)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	if (info->parameters) {
 
diff --git a/drivers/acpi/resources/rscalc.c b/drivers/acpi/resources/rscalc.c
index 8a112d1..f61ebc6 100644
--- a/drivers/acpi/resources/rscalc.c
+++ b/drivers/acpi/resources/rscalc.c
@@ -73,7 +73,7 @@ acpi_rs_stream_option_length(u32 resource_length, u32 minimum_total_length);
 
 static u8 acpi_rs_count_set_bits(u16 bit_field)
 {
-	acpi_native_uint bits_set;
+	u8 bits_set;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -84,7 +84,7 @@ static u8 acpi_rs_count_set_bits(u16 bit_field)
 		bit_field &= (u16) (bit_field - 1);
 	}
 
-	return ((u8) bits_set);
+	return bits_set;
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/resources/rsmisc.c b/drivers/acpi/resources/rsmisc.c
index de1ac38..96a6c03 100644
--- a/drivers/acpi/resources/rsmisc.c
+++ b/drivers/acpi/resources/rsmisc.c
@@ -82,7 +82,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 
 	ACPI_FUNCTION_TRACE(rs_convert_aml_to_resource);
 
-	if (((acpi_native_uint) resource) & 0x3) {
+	if (((acpi_size) resource) & 0x3) {
 
 		/* Each internal resource struct is expected to be 32-bit aligned */
 
diff --git a/drivers/acpi/resources/rsutils.c b/drivers/acpi/resources/rsutils.c
index 90ed83d..f7b3bcd 100644
--- a/drivers/acpi/resources/rsutils.c
+++ b/drivers/acpi/resources/rsutils.c
@@ -62,7 +62,7 @@ ACPI_MODULE_NAME("rsutils")
  ******************************************************************************/
 u8 acpi_rs_decode_bitmask(u16 mask, u8 * list)
 {
-	acpi_native_uint i;
+	u8 i;
 	u8 bit_count;
 
 	ACPI_FUNCTION_ENTRY();
@@ -71,7 +71,7 @@ u8 acpi_rs_decode_bitmask(u16 mask, u8 * list)
 
 	for (i = 0, bit_count = 0; mask; i++) {
 		if (mask & 0x0001) {
-			list[bit_count] = (u8) i;
+			list[bit_count] = i;
 			bit_count++;
 		}
 
@@ -96,8 +96,8 @@ u8 acpi_rs_decode_bitmask(u16 mask, u8 * list)
 
 u16 acpi_rs_encode_bitmask(u8 * list, u8 count)
 {
-	acpi_native_uint i;
-	acpi_native_uint mask;
+	u32 i;
+	u16 mask;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -107,7 +107,7 @@ u16 acpi_rs_encode_bitmask(u8 * list, u8 count)
 		mask |= (0x1 << list[i]);
 	}
 
-	return ((u16) mask);
+	return mask;
 }
 
 /*******************************************************************************
@@ -130,7 +130,7 @@ u16 acpi_rs_encode_bitmask(u8 * list, u8 count)
 void
 acpi_rs_move_data(void *destination, void *source, u16 item_count, u8 move_type)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
 
diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 949d411..a4a41ba 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -155,7 +155,7 @@ acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
  *
  ******************************************************************************/
 
-void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags)
+void acpi_tb_parse_fadt(u32 table_index, u8 flags)
 {
 	u32 length;
 	struct acpi_table_header *table;
@@ -280,7 +280,7 @@ static void acpi_tb_convert_fadt(void)
 {
 	u8 pm1_register_length;
 	struct acpi_generic_address *target;
-	acpi_native_uint i;
+	u32 i;
 
 	/* Update the local FADT table header length */
 
@@ -396,7 +396,7 @@ static void acpi_tb_validate_fadt(void)
 	u32 *address32;
 	struct acpi_generic_address *address64;
 	u8 length;
-	acpi_native_uint i;
+	u32 i;
 
 	/* Examine all of the 64-bit extended address fields (X fields) */
 
diff --git a/drivers/acpi/tables/tbfind.c b/drivers/acpi/tables/tbfind.c
index 9ca3afc..531584d 100644
--- a/drivers/acpi/tables/tbfind.c
+++ b/drivers/acpi/tables/tbfind.c
@@ -65,10 +65,9 @@ ACPI_MODULE_NAME("tbfind")
  ******************************************************************************/
 acpi_status
 acpi_tb_find_table(char *signature,
-		   char *oem_id,
-		   char *oem_table_id, acpi_native_uint * table_index)
+		   char *oem_id, char *oem_table_id, u32 *table_index)
 {
-	acpi_native_uint i;
+	u32 i;
 	acpi_status status;
 	struct acpi_table_header header;
 
diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 5336ce8..b22185f 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -107,11 +107,10 @@ acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc)
  ******************************************************************************/
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_desc *table_desc,
-		  acpi_native_uint * table_index)
+acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 {
-	acpi_native_uint i;
-	acpi_native_uint length;
+	u32 i;
+	u32 length;
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
@@ -207,8 +206,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	/* Increase the Table Array size */
 
-	tables = ACPI_ALLOCATE_ZEROED((acpi_gbl_root_table_list.size +
-				       ACPI_ROOT_TABLE_SIZE_INCREMENT)
+	tables = ACPI_ALLOCATE_ZEROED(((acpi_size) acpi_gbl_root_table_list.
+				       size + ACPI_ROOT_TABLE_SIZE_INCREMENT)
 				      * sizeof(struct acpi_table_desc));
 	if (!tables) {
 		ACPI_ERROR((AE_INFO,
@@ -220,7 +219,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 
 	if (acpi_gbl_root_table_list.tables) {
 		ACPI_MEMCPY(tables, acpi_gbl_root_table_list.tables,
-			    acpi_gbl_root_table_list.size *
+			    (acpi_size) acpi_gbl_root_table_list.size *
 			    sizeof(struct acpi_table_desc));
 
 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
@@ -253,7 +252,7 @@ acpi_status acpi_tb_resize_root_table_list(void)
 acpi_status
 acpi_tb_store_table(acpi_physical_address address,
 		    struct acpi_table_header *table,
-		    u32 length, u8 flags, acpi_native_uint * table_index)
+		    u32 length, u8 flags, u32 *table_index)
 {
 	acpi_status status = AE_OK;
 
@@ -334,7 +333,7 @@ void acpi_tb_delete_table(struct acpi_table_desc *table_desc)
 
 void acpi_tb_terminate(void)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_terminate);
 
@@ -374,7 +373,7 @@ void acpi_tb_terminate(void)
  *
  ******************************************************************************/
 
-void acpi_tb_delete_namespace_by_owner(acpi_native_uint table_index)
+void acpi_tb_delete_namespace_by_owner(u32 table_index)
 {
 	acpi_owner_id owner_id;
 
@@ -403,7 +402,7 @@ void acpi_tb_delete_namespace_by_owner(acpi_native_uint table_index)
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_allocate_owner_id(acpi_native_uint table_index)
+acpi_status acpi_tb_allocate_owner_id(u32 table_index)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 
@@ -431,7 +430,7 @@ acpi_status acpi_tb_allocate_owner_id(acpi_native_uint table_index)
  *
  ******************************************************************************/
 
-acpi_status acpi_tb_release_owner_id(acpi_native_uint table_index)
+acpi_status acpi_tb_release_owner_id(u32 table_index)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 
@@ -462,8 +461,7 @@ acpi_status acpi_tb_release_owner_id(acpi_native_uint table_index)
  *
  ******************************************************************************/
 
-acpi_status
-acpi_tb_get_owner_id(acpi_native_uint table_index, acpi_owner_id * owner_id)
+acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 
@@ -490,7 +488,7 @@ acpi_tb_get_owner_id(acpi_native_uint table_index, acpi_owner_id * owner_id)
  *
  ******************************************************************************/
 
-u8 acpi_tb_is_table_loaded(acpi_native_uint table_index)
+u8 acpi_tb_is_table_loaded(u32 table_index)
 {
 	u8 is_loaded = FALSE;
 
@@ -518,7 +516,7 @@ u8 acpi_tb_is_table_loaded(acpi_native_uint table_index)
  *
  ******************************************************************************/
 
-void acpi_tb_set_table_loaded_flag(acpi_native_uint table_index, u8 is_loaded)
+void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded)
 {
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index bc019b9..0cc92ef 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -49,8 +49,8 @@ ACPI_MODULE_NAME("tbutils")
 
 /* Local prototypes */
 static acpi_physical_address
-acpi_tb_get_root_table_entry(u8 * table_entry,
-			     acpi_native_uint table_entry_size);
+acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_check_xsdt
@@ -238,7 +238,7 @@ acpi_status acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length)
  *
  ******************************************************************************/
 
-u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length)
+u8 acpi_tb_checksum(u8 *buffer, u32 length)
 {
 	u8 sum = 0;
 	u8 *end = buffer + length;
@@ -268,7 +268,7 @@ u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length)
 
 void
 acpi_tb_install_table(acpi_physical_address address,
-		      u8 flags, char *signature, acpi_native_uint table_index)
+		      u8 flags, char *signature, u32 table_index)
 {
 	struct acpi_table_header *table;
 
@@ -336,8 +336,7 @@ acpi_tb_install_table(acpi_physical_address address,
  ******************************************************************************/
 
 static acpi_physical_address
-acpi_tb_get_root_table_entry(u8 * table_entry,
-			     acpi_native_uint table_entry_size)
+acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
 {
 	u64 address64;
 
@@ -395,8 +394,8 @@ acpi_status __init
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 {
 	struct acpi_table_rsdp *rsdp;
-	acpi_native_uint table_entry_size;
-	acpi_native_uint i;
+	u32 table_entry_size;
+	u32 i;
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index 0e31960..fd7770a 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -125,7 +125,7 @@ acpi_initialize_tables(struct acpi_table_desc * initial_table_array,
 		/* Root Table Array has been statically allocated by the host */
 
 		ACPI_MEMSET(initial_table_array, 0,
-			    initial_table_count *
+			    (acpi_size) initial_table_count *
 			    sizeof(struct acpi_table_desc));
 
 		acpi_gbl_root_table_list.tables = initial_table_array;
@@ -183,9 +183,9 @@ acpi_status acpi_reallocate_root_table(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-	new_size =
-	    (acpi_gbl_root_table_list.count +
-	     ACPI_ROOT_TABLE_SIZE_INCREMENT) * sizeof(struct acpi_table_desc);
+	new_size = ((acpi_size) acpi_gbl_root_table_list.count +
+		    ACPI_ROOT_TABLE_SIZE_INCREMENT) *
+	    sizeof(struct acpi_table_desc);
 
 	/* Create new array and copy the old array */
 
@@ -222,7 +222,7 @@ acpi_status acpi_reallocate_root_table(void)
 acpi_status acpi_load_table(struct acpi_table_header *table_ptr)
 {
 	acpi_status status;
-	acpi_native_uint table_index;
+	u32 table_index;
 	struct acpi_table_desc table_desc;
 
 	if (!table_ptr)
@@ -264,11 +264,10 @@ ACPI_EXPORT_SYMBOL(acpi_load_table)
  *****************************************************************************/
 acpi_status
 acpi_get_table_header(char *signature,
-		      acpi_native_uint instance,
-		      struct acpi_table_header * out_table_header)
+		      u32 instance, struct acpi_table_header *out_table_header)
 {
-	acpi_native_uint i;
-	acpi_native_uint j;
+       u32 i;
+       u32 j;
 	struct acpi_table_header *header;
 
 	/* Parameter validation */
@@ -378,10 +377,10 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
  *****************************************************************************/
 acpi_status
 acpi_get_table(char *signature,
-	       acpi_native_uint instance, struct acpi_table_header **out_table)
+	       u32 instance, struct acpi_table_header **out_table)
 {
-	acpi_native_uint i;
-	acpi_native_uint j;
+       u32 i;
+       u32 j;
 	acpi_status status;
 
 	/* Parameter validation */
@@ -435,8 +434,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_table)
  *
  ******************************************************************************/
 acpi_status
-acpi_get_table_by_index(acpi_native_uint table_index,
-			struct acpi_table_header ** table)
+acpi_get_table_by_index(u32 table_index, struct acpi_table_header **table)
 {
 	acpi_status status;
 
@@ -493,7 +491,7 @@ static acpi_status acpi_tb_load_namespace(void)
 {
 	acpi_status status;
 	struct acpi_table_header *table;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(tb_load_namespace);
 
diff --git a/drivers/acpi/tables/tbxfroot.c b/drivers/acpi/tables/tbxfroot.c
index b8c0dfa..2d157e0 100644
--- a/drivers/acpi/tables/tbxfroot.c
+++ b/drivers/acpi/tables/tbxfroot.c
@@ -118,7 +118,7 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
  *
  ******************************************************************************/
 
-acpi_status acpi_find_root_pointer(acpi_native_uint * table_address)
+acpi_status acpi_find_root_pointer(acpi_size *table_address)
 {
 	u8 *table_ptr;
 	u8 *mem_rover;
@@ -153,7 +153,7 @@ acpi_status acpi_find_root_pointer(acpi_native_uint * table_address)
 		 * 1b) Search EBDA paragraphs (EBDA is required to be a
 		 *     minimum of 1_k length)
 		 */
-		table_ptr = acpi_os_map_memory((acpi_native_uint)
+		table_ptr = acpi_os_map_memory((acpi_physical_address)
 					       physical_address,
 					       ACPI_EBDA_WINDOW_SIZE);
 		if (!table_ptr) {
diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index 655c290..53499ac 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -572,7 +572,7 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
 	acpi_status status = AE_OK;
 	union acpi_operand_object *package_object;
 	union acpi_operand_object **package_elements;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ut_copy_epackage_to_ipackage);
 
@@ -599,7 +599,7 @@ acpi_ut_copy_epackage_to_ipackage(union acpi_object *external_object,
 
 			/* Truncate package and delete it */
 
-			package_object->package.count = (u32) i;
+			package_object->package.count = i;
 			package_elements[i] = NULL;
 			acpi_ut_remove_reference(package_object);
 			return_ACPI_STATUS(status);
diff --git a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
index f938f46..3919fe5 100644
--- a/drivers/acpi/utilities/utdebug.c
+++ b/drivers/acpi/utilities/utdebug.c
@@ -519,8 +519,8 @@ acpi_ut_ptr_exit(u32 line_number,
 
 void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 {
-	acpi_native_uint i = 0;
-	acpi_native_uint j;
+	u32 i = 0;
+	u32 j;
 	u32 temp32;
 	u8 buf_char;
 
@@ -539,7 +539,7 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 
 		/* Print current offset */
 
-		acpi_os_printf("%6.4X: ", (u32) i);
+		acpi_os_printf("%6.4X: ", i);
 
 		/* Print 16 hex chars */
 
@@ -549,7 +549,7 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 				/* Dump fill spaces */
 
 				acpi_os_printf("%*s", ((display * 2) + 1), " ");
-				j += (acpi_native_uint) display;
+				j += display;
 				continue;
 			}
 
@@ -557,32 +557,38 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 			case DB_BYTE_DISPLAY:
 			default:	/* Default is BYTE display */
 
-				acpi_os_printf("%02X ", buffer[i + j]);
+				acpi_os_printf("%02X ",
+					       buffer[(acpi_size) i + j]);
 				break;
 
 			case DB_WORD_DISPLAY:
 
-				ACPI_MOVE_16_TO_32(&temp32, &buffer[i + j]);
+				ACPI_MOVE_16_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
 				acpi_os_printf("%04X ", temp32);
 				break;
 
 			case DB_DWORD_DISPLAY:
 
-				ACPI_MOVE_32_TO_32(&temp32, &buffer[i + j]);
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
 				acpi_os_printf("%08X ", temp32);
 				break;
 
 			case DB_QWORD_DISPLAY:
 
-				ACPI_MOVE_32_TO_32(&temp32, &buffer[i + j]);
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j]);
 				acpi_os_printf("%08X", temp32);
 
-				ACPI_MOVE_32_TO_32(&temp32, &buffer[i + j + 4]);
+				ACPI_MOVE_32_TO_32(&temp32,
+						   &buffer[(acpi_size) i + j +
+							   4]);
 				acpi_os_printf("%08X ", temp32);
 				break;
 			}
 
-			j += (acpi_native_uint) display;
+			j += display;
 		}
 
 		/*
@@ -596,7 +602,7 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
 				return;
 			}
 
-			buf_char = buffer[i + j];
+			buf_char = buffer[(acpi_size) i + j];
 			if (ACPI_IS_PRINT(buf_char)) {
 				acpi_os_printf("%c", buf_char);
 			} else {
diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index 1fbc351..c5c791a 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -442,7 +442,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 	union acpi_generic_state *state_list = NULL;
 	union acpi_operand_object *next_object = NULL;
 	union acpi_generic_state *state;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE_PTR(ut_update_object_reference, object);
 
diff --git a/drivers/acpi/utilities/uteval.c b/drivers/acpi/utilities/uteval.c
index 7f1f634..352747e 100644
--- a/drivers/acpi/utilities/uteval.c
+++ b/drivers/acpi/utilities/uteval.c
@@ -97,7 +97,7 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 	acpi_status status;
 	union acpi_operand_object *string_desc;
 	union acpi_operand_object *return_desc;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ut_osi_implementation);
 
@@ -513,7 +513,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node * device_node,
 	u32 count;
 	u32 size;
 	struct acpi_compatible_id_list *cid_list;
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ut_execute_CID);
 
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 47354d9..6175ca5 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -161,9 +161,9 @@ u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
 
 acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 {
-	acpi_native_uint i;
-	acpi_native_uint j;
-	acpi_native_uint k;
+	u32 i;
+	u32 j;
+	u32 k;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ut_allocate_owner_id);
@@ -269,7 +269,7 @@ void acpi_ut_release_owner_id(acpi_owner_id * owner_id_ptr)
 {
 	acpi_owner_id owner_id = *owner_id_ptr;
 	acpi_status status;
-	acpi_native_uint index;
+	u32 index;
 	u32 bit;
 
 	ACPI_FUNCTION_TRACE_U32(ut_release_owner_id, owner_id);
@@ -589,7 +589,7 @@ acpi_ut_display_init_pathname(u8 type,
  *
  ******************************************************************************/
 
-u8 acpi_ut_valid_acpi_char(char character, acpi_native_uint position)
+u8 acpi_ut_valid_acpi_char(char character, u32 position)
 {
 
 	if (!((character >= 'A' && character <= 'Z') ||
@@ -624,7 +624,7 @@ u8 acpi_ut_valid_acpi_char(char character, acpi_native_uint position)
 
 u8 acpi_ut_valid_acpi_name(u32 name)
 {
-	acpi_native_uint i;
+	u32 i;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -653,7 +653,7 @@ u8 acpi_ut_valid_acpi_name(u32 name)
 
 acpi_name acpi_ut_repair_name(char *name)
 {
-	acpi_native_uint i;
+       u32 i;
 	char new_name[ACPI_NAME_SIZE];
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index e68466d..ede6a80 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -175,8 +175,8 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 	 * Create the element array. Count+1 allows the array to be null
 	 * terminated.
 	 */
-	package_elements = ACPI_ALLOCATE_ZEROED((acpi_size)
-						(count + 1) * sizeof(void *));
+	package_elements = ACPI_ALLOCATE_ZEROED(((acpi_size) count +
+						 1) * sizeof(void *));
 	if (!package_elements) {
 		acpi_ut_remove_reference(package_desc);
 		return_PTR(NULL);
diff --git a/include/acpi/acdispat.h b/include/acpi/acdispat.h
index 910f018..21a73a1 100644
--- a/include/acpi/acdispat.h
+++ b/include/acpi/acdispat.h
@@ -221,7 +221,7 @@ acpi_ds_method_error(acpi_status status, struct acpi_walk_state *walk_state);
  * dsinit
  */
 acpi_status
-acpi_ds_initialize_objects(acpi_native_uint table_index,
+acpi_ds_initialize_objects(u32 table_index,
 			   struct acpi_namespace_node *start_node);
 
 /*
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 74ad971..15dda46 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -140,7 +140,7 @@ ACPI_EXTERN u32 acpi_gbl_trace_flags;
  */
 ACPI_EXTERN struct acpi_internal_rsdt acpi_gbl_root_table_list;
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
-extern acpi_native_uint acpi_gbl_permanent_mmap;
+extern u8 acpi_gbl_permanent_mmap;
 
 /* These addresses are calculated from FADT address values */
 
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 4e42f67..9039ea8 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -80,12 +80,12 @@
  */
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
 #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
-#define ACPI_ADD_PTR(t,a,b)             ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8,(a)) + (acpi_native_uint)(b)))
-#define ACPI_PTR_DIFF(a,b)              (acpi_native_uint) (ACPI_CAST_PTR (u8,(a)) - ACPI_CAST_PTR (u8,(b)))
+#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8,(a)) + (acpi_size)(b)))
+#define ACPI_PTR_DIFF(a, b)             (acpi_size) (ACPI_CAST_PTR (u8,(a)) - ACPI_CAST_PTR (u8,(b)))
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void,(void *) NULL,(acpi_native_uint) i)
+#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL, (acpi_size) i)
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p,(void *) NULL)
 #define ACPI_OFFSET(d,f)                (acpi_size) ACPI_PTR_DIFF (&(((d *)0)->f),(void *) NULL)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
@@ -296,22 +296,22 @@ struct acpi_integer_overlay {
 /*
  * Rounding macros (Power of two boundaries only)
  */
-#define ACPI_ROUND_DOWN(value,boundary)     (((acpi_native_uint)(value)) & \
-												(~(((acpi_native_uint) boundary)-1)))
+#define ACPI_ROUND_DOWN(value, boundary)     (((acpi_size)(value)) & \
+						(~(((acpi_size) boundary)-1)))
 
-#define ACPI_ROUND_UP(value,boundary)       ((((acpi_native_uint)(value)) + \
-												(((acpi_native_uint) boundary)-1)) & \
-												(~(((acpi_native_uint) boundary)-1)))
+#define ACPI_ROUND_UP(value, boundary)       ((((acpi_size)(value)) + \
+						(((acpi_size) boundary)-1)) & \
+						(~(((acpi_size) boundary)-1)))
 
-/* Note: sizeof(acpi_native_uint) evaluates to either 2, 4, or 8 */
+/* Note: sizeof(acpi_size) evaluates to either 4 or 8 (32- vs 64-bit mode) */
 
 #define ACPI_ROUND_DOWN_TO_32BIT(a)         ACPI_ROUND_DOWN(a,4)
 #define ACPI_ROUND_DOWN_TO_64BIT(a)         ACPI_ROUND_DOWN(a,8)
-#define ACPI_ROUND_DOWN_TO_NATIVE_WORD(a)   ACPI_ROUND_DOWN(a,sizeof(acpi_native_uint))
+#define ACPI_ROUND_DOWN_TO_NATIVE_WORD(a)   ACPI_ROUND_DOWN(a,sizeof(acpi_size))
 
 #define ACPI_ROUND_UP_TO_32BIT(a)           ACPI_ROUND_UP(a,4)
 #define ACPI_ROUND_UP_TO_64BIT(a)           ACPI_ROUND_UP(a,8)
-#define ACPI_ROUND_UP_TO_NATIVE_WORD(a)     ACPI_ROUND_UP(a,sizeof(acpi_native_uint))
+#define ACPI_ROUND_UP_TO_NATIVE_WORD(a)     ACPI_ROUND_UP(a,sizeof(acpi_size))
 
 #define ACPI_ROUND_BITS_UP_TO_BYTES(a)      ACPI_DIV_8((a) + 7)
 #define ACPI_ROUND_BITS_DOWN_TO_BYTES(a)    ACPI_DIV_8((a))
@@ -322,7 +322,7 @@ struct acpi_integer_overlay {
 
 #define ACPI_ROUND_UP_TO(value,boundary)    (((value) + ((boundary)-1)) / (boundary))
 
-#define ACPI_IS_MISALIGNED(value)           (((acpi_native_uint)value) & (sizeof(acpi_native_uint)-1))
+#define ACPI_IS_MISALIGNED(value)           (((acpi_size)value) & (sizeof(acpi_size)-1))
 
 /*
  * Bitmask creation
diff --git a/include/acpi/acnamesp.h b/include/acpi/acnamesp.h
index 713b309..d622c30 100644
--- a/include/acpi/acnamesp.h
+++ b/include/acpi/acnamesp.h
@@ -86,8 +86,7 @@ acpi_status acpi_ns_initialize_devices(void);
 acpi_status acpi_ns_load_namespace(void);
 
 acpi_status
-acpi_ns_load_table(acpi_native_uint table_index,
-		   struct acpi_namespace_node *node);
+acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node);
 
 /*
  * nswalk - walk the namespace
@@ -108,12 +107,11 @@ struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct
  * nsparse - table parsing
  */
 acpi_status
-acpi_ns_parse_table(acpi_native_uint table_index,
-		    struct acpi_namespace_node *start_node);
+acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node);
 
 acpi_status
-acpi_ns_one_complete_parse(acpi_native_uint pass_number,
-			   acpi_native_uint table_index,
+acpi_ns_one_complete_parse(u32 pass_number,
+			   u32 table_index,
 			   struct acpi_namespace_node *start_node);
 
 /*
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index d4a560d..3f93a6b 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -144,7 +144,7 @@ void acpi_os_release_mutex(acpi_mutex handle);
 void *acpi_os_allocate(acpi_size size);
 
 void __iomem *acpi_os_map_memory(acpi_physical_address where,
-				 acpi_native_uint length);
+				acpi_size length);
 
 void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2c3806e..bd95ecc 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -98,7 +98,7 @@ void acpi_free(void *address);
  */
 acpi_status acpi_reallocate_root_table(void);
 
-acpi_status acpi_find_root_pointer(acpi_native_uint * rsdp_address);
+acpi_status acpi_find_root_pointer(acpi_size *rsdp_address);
 
 acpi_status acpi_load_tables(void);
 
@@ -108,15 +108,15 @@ acpi_status acpi_unload_table_id(acpi_owner_id id);
 
 acpi_status
 acpi_get_table_header(acpi_string signature,
-		      acpi_native_uint instance,
+		      u32 instance,
 		      struct acpi_table_header *out_table_header);
 
 acpi_status
 acpi_get_table(acpi_string signature,
-	       acpi_native_uint instance, struct acpi_table_header **out_table);
+	       u32 instance, struct acpi_table_header **out_table);
 
 acpi_status
-acpi_get_table_by_index(acpi_native_uint table_index,
+acpi_get_table_by_index(u32 table_index,
 			struct acpi_table_header **out_table);
 
 acpi_status
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index 818c24d..7980a26 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -142,7 +142,7 @@ struct acpi_init_walk_info {
 	u16 package_init;
 	u16 object_count;
 	acpi_owner_id owner_id;
-	acpi_native_uint table_index;
+	u32 table_index;
 };
 
 struct acpi_get_devices_info {
diff --git a/include/acpi/actables.h b/include/acpi/actables.h
index 4b36a55..0cbe1b9 100644
--- a/include/acpi/actables.h
+++ b/include/acpi/actables.h
@@ -49,7 +49,7 @@ acpi_status acpi_allocate_root_table(u32 initial_table_count);
 /*
  * tbfadt - FADT parse/convert/validate
  */
-void acpi_tb_parse_fadt(acpi_native_uint table_index, u8 flags);
+void acpi_tb_parse_fadt(u32 table_index, u8 flags);
 
 void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
 
@@ -58,8 +58,7 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length);
  */
 acpi_status
 acpi_tb_find_table(char *signature,
-		   char *oem_id,
-		   char *oem_table_id, acpi_native_uint * table_index);
+		   char *oem_id, char *oem_table_id, u32 *table_index);
 
 /*
  * tbinstal - Table removal and deletion
@@ -69,30 +68,28 @@ acpi_status acpi_tb_resize_root_table_list(void);
 acpi_status acpi_tb_verify_table(struct acpi_table_desc *table_desc);
 
 acpi_status
-acpi_tb_add_table(struct acpi_table_desc *table_desc,
-		  acpi_native_uint * table_index);
+acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index);
 
 acpi_status
 acpi_tb_store_table(acpi_physical_address address,
 		    struct acpi_table_header *table,
-		    u32 length, u8 flags, acpi_native_uint * table_index);
+		    u32 length, u8 flags, u32 *table_index);
 
 void acpi_tb_delete_table(struct acpi_table_desc *table_desc);
 
 void acpi_tb_terminate(void);
 
-void acpi_tb_delete_namespace_by_owner(acpi_native_uint table_index);
+void acpi_tb_delete_namespace_by_owner(u32 table_index);
 
-acpi_status acpi_tb_allocate_owner_id(acpi_native_uint table_index);
+acpi_status acpi_tb_allocate_owner_id(u32 table_index);
 
-acpi_status acpi_tb_release_owner_id(acpi_native_uint table_index);
+acpi_status acpi_tb_release_owner_id(u32 table_index);
 
-acpi_status
-acpi_tb_get_owner_id(acpi_native_uint table_index, acpi_owner_id * owner_id);
+acpi_status acpi_tb_get_owner_id(u32 table_index, acpi_owner_id *owner_id);
 
-u8 acpi_tb_is_table_loaded(acpi_native_uint table_index);
+u8 acpi_tb_is_table_loaded(u32 table_index);
 
-void acpi_tb_set_table_loaded_flag(acpi_native_uint table_index, u8 is_loaded);
+void acpi_tb_set_table_loaded_flag(u32 table_index, u8 is_loaded);
 
 /*
  * tbutils - table manager utilities
@@ -103,14 +100,14 @@ void
 acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header);
 
-u8 acpi_tb_checksum(u8 * buffer, acpi_native_uint length);
+u8 acpi_tb_checksum(u8 *buffer, u32 length);
 
 acpi_status
 acpi_tb_verify_checksum(struct acpi_table_header *table, u32 length);
 
 void
 acpi_tb_install_table(acpi_physical_address address,
-		      u8 flags, char *signature, acpi_native_uint table_index);
+		      u8 flags, char *signature, u32 table_index);
 
 acpi_status
 acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index dfea2d4..5126b83 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -110,10 +110,10 @@
  * usually used for memory allocation, efficient loop counters, and array
  * indexes. The types are similar to the size_t type in the C library and are
  * required because there is no C type that consistently represents the native
- * data width.
+ * data width. ACPI_SIZE is needed because there is no guarantee that a
+ * kernel-level C library is present.
  *
  * ACPI_SIZE        16/32/64-bit unsigned value
- * ACPI_NATIVE_UINT 16/32/64-bit unsigned value
  * ACPI_NATIVE_INT  16/32/64-bit signed value
  *
  */
@@ -147,9 +147,9 @@ typedef int INT32;
 
 /*! [End] no source code translation !*/
 
-typedef u64 acpi_native_uint;
 typedef s64 acpi_native_int;
 
+typedef u64 acpi_size;
 typedef u64 acpi_io_address;
 typedef u64 acpi_physical_address;
 
@@ -186,9 +186,9 @@ typedef int INT32;
 
 /*! [End] no source code translation !*/
 
-typedef u32 acpi_native_uint;
 typedef s32 acpi_native_int;
 
+typedef u32 acpi_size;
 typedef u32 acpi_io_address;
 typedef u32 acpi_physical_address;
 
@@ -202,10 +202,6 @@ typedef u32 acpi_physical_address;
 #error unknown ACPI_MACHINE_WIDTH
 #endif
 
-/* Variable-width type, used instead of clib size_t */
-
-typedef acpi_native_uint acpi_size;
-
 /*******************************************************************************
  *
  * OS-dependent and compiler-dependent types
@@ -219,7 +215,7 @@ typedef acpi_native_uint acpi_size;
 /* Value returned by acpi_os_get_thread_id */
 
 #ifndef acpi_thread_id
-#define acpi_thread_id                  acpi_native_uint
+#define acpi_thread_id                  acpi_size
 #endif
 
 /* Object returned from acpi_os_create_lock */
@@ -231,7 +227,7 @@ typedef acpi_native_uint acpi_size;
 /* Flags for acpi_os_acquire_lock/acpi_os_release_lock */
 
 #ifndef acpi_cpu_flags
-#define acpi_cpu_flags                  acpi_native_uint
+#define acpi_cpu_flags                  acpi_size
 #endif
 
 /* Object returned from acpi_os_create_cache */
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index b42cadf..3f663a0 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -172,7 +172,7 @@ char *acpi_ut_strstr(char *string1, char *string2);
 
 void *acpi_ut_memcpy(void *dest, const void *src, acpi_size count);
 
-void *acpi_ut_memset(void *dest, acpi_native_uint value, acpi_size count);
+void *acpi_ut_memset(void *dest, u8 value, acpi_size count);
 
 int acpi_ut_to_upper(int c);
 
@@ -476,7 +476,7 @@ u8 acpi_ut_valid_acpi_name(u32 name);
 
 acpi_name acpi_ut_repair_name(char *name);
 
-u8 acpi_ut_valid_acpi_char(char character, acpi_native_uint position);
+u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
 acpi_status
 acpi_ut_strtoul64(char *string, u32 base, acpi_integer * ret_integer);
-- 
1.5.6.rc2.26.g8c37

