From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 05/19] ACPICA: Cleanup indentation to reduce differences between Linux and ACPICA.
Date: Wed, 19 Dec 2012 13:37:15 +0800
Message-ID: <a40c79fc1df3934b83fe2ed90cbefa76db13f18f.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8395 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2LSFhX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:37:23 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 210 lines of 20121018 divergence.diff.

The ACPICA source codes uses a totally different indentation style from the
Linux to be compatible with other users (operating systems or BIOS).

Indentation differences are critical to the release automation. There are
two causes related to the "indentation" that are affecting the release
automation:
1. The ACPICA -> Linux release process is:
     ACPICA source -- acpisrc - hierarchy - indent ->
     linuxized ACPICA source -- diff ->
     linuxized ACPICA patch (x) -- human intervention ->
     linuxized ACPICA patch (o)
     Where
       'x' means "cannot be directly applied to the Linux"
       'o' means "can be directly applied to the Linux"
   Different "indent" version or "indent" options used in the "indent"
   step will lead to different divergences.
   The version of "indent" used for the current release process is:
     GNU indent 2.2.11
   The options of "indent" used for the current release process is:
     -npro -kr -i8 -ts8 -sob -l80 -ss -ncs
2. Manual indentation prettifying work in the Linux side will also harm the
   automatically generated linuxized ACPICA patches, making them impossible
   to apply directly.

This patch fixes source code differences caused by the two causes so that
the "human intervention" can be reduced in the future.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -    5c1c:	68 e6 01 00 00       	push   $0x1e6
  +    5c1c:	68 e7 01 00 00       	push   $0x1e7
  evxface.c(487-1): acpi_install_fixed_event_handler
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    5ca0:	68 23 02 00 00       	push   $0x223
  +    5ca0:	68 24 02 00 00       	push   $0x224
  evxface.c(548-2): acpi_remove_fixed_event_handler
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    5f47:	6a 5b                	push   $0x5b
  +    5f47:	6a 5a                	push   $0x5a
  evxfevnt.c(90-1): acpi_enable
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    5f6a:	6a 65                	push   $0x65
  +    5f6a:	6a 64                	push   $0x64
  evxfevnt.c(100-1): acpi_enable
  ACPI_WARNING -> AE_INFO -> __LINE__
  -    5f98:	6a 6b                	push   $0x6b
  +    5f98:	6a 6a                	push   $0x6a
  evxfevnt.c(106): acpi_enable
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    5fce:	68 8c 00 00 00       	push   $0x8c
  +    5fce:	68 8b 00 00 00       	push   $0x8b
  evxfevnt.c(139): acpi_disable
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    6038:	68 c8 00 00 00       	push   $0xc8
  +    6038:	68 c7 00 00 00       	push   $0xc7
  evxfevnt.c(199-2): acpi_enable_event
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    60a1:	68 ff 00 00 00       	push   $0xff
  +    60a1:	68 fe 00 00 00       	push   $0xfe
  evxfevnt.c(254-2): acpi_disable_event
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    6352:	68 7a 01 00 00       	push   $0x17a
  +    6352:	68 7b 01 00 00       	push   $0x17b
  evxfgpe.c(379): acpi_set_gpe_wake_mask
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    64e0:	ba 59 02 00 00       	mov    $0x259,%edx
  +    64e0:	ba 5a 02 00 00       	mov    $0x25a,%edx
  evxfgpe.c(602): acpi_install_gpe_block
  acpi_ut_create_internal_object -> acpi_ut_create_internal_object_dbg ->
  __LINE__
  -    6a74:	68 1a 02 00 00       	push   $0x21a
  +    6a74:	68 19 02 00 00       	push   $0x219
  exconfig.c(537): acpi_ex_load_op
  ACPI_INFO -> AE_INFO -> __LINE__
  -    6c1e:	68 07 01 00 00       	push   $0x107
  +    6c1e:	68 06 01 00 00       	push   $0x106
  exconfig.c(262): acpi_ex_load_table_op
  ACPI_INFO -> AE_INFO -> __LINE__
  -    853f:	68 80 01 00 00       	push   $0x180
  +    853f:	68 81 01 00 00       	push   $0x181
  exmutex.c(385-2):  acpi_ex_release_mutex
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    858b:	68 8e 01 00 00       	push   $0x18e
  +    858b:	68 8f 01 00 00       	push   $0x18f
  exmutex.c(399-4):  acpi_ex_release_mutex
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    85c8:	68 9e 01 00 00       	push   $0x19e
  +    85c8:	68 9f 01 00 00       	push   $0x19f
  exmutex.c(415-4):  acpi_ex_release_mutex
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    934d:	68 d7 03 00 00       	push   $0x3d7
  +    934d:	68 d1 03 00 00       	push   $0x3d1
  exoparg1.c(977-3): acpi_ex_opcode_1A_0T_1R
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    9391:	68 f3 03 00 00       	push   $0x3f3
  +    9391:	68 ed 03 00 00       	push   $0x3ed
  exoparg1.c(1005-3): acpi_ex_opcode_1A_0T_1R
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    93b0:	68 fe 03 00 00       	push   $0x3fe
  +    93b0:	68 f8 03 00 00       	push   $0x3f8
  exoparg1.c(1016-1): acpi_ex_opcode_1A_0T_1R
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    a704:	68 b5 00 00 00       	push   $0xb5
  +    a704:	68 b4 00 00 00       	push   $0xb4
  exregion.c(180-3): acpi_ex_system_memory_space_handler
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    bb64:	6a 7b                	push   $0x7b
  +    bb64:	6a 7a                	push   $0x7a
  hwacpi.c(122-1): acpi_hw_set_mode
  ACPI_EXCEPTION -> AE_INFO -> __LINE__
  -    c35b:	68 a7 01 00 00       	push   $0x1a7
  +    c35b:	68 a6 01 00 00       	push   $0x1a6
  hwregs.c(422): acpi_hw_register_read
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    c440:	68 2f 02 00 00       	push   $0x22f
  +    c440:	68 2e 02 00 00       	push   $0x22e
  hwregs.c(558): acpi_hw_register_write
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    eb96:	68 23 01 00 00       	push   $0x123
  +    eb96:	68 24 01 00 00       	push   $0x124
  nsrepair2.c(292-4): acpi_ns_repair_FDE
  ACPI_WARN_PREDEFINED -> AE_INFO -> __LINE__
  -    edba:	68 b6 01 00 00       	push   $0x1b6
  +    edba:	68 b7 01 00 00       	push   $0x1b7
  nsrepair2.c(439-1): acpi_ns_repair_HID
  ACPI_WARN_PREDEFINED -> AE_INFO -> __LINE__
  -    ef19:	68 4d 02 00 00       	push   $0x24d
  +    ef19:	68 4e 02 00 00       	push   $0x24e
  nsrepair2.c(590-3): acpi_ns_repair_PSS
  ACPI_WARN_PREDEFINED -> AE_INFO -> __LINE__
  -   12ebf:	68 f1 02 00 00       	push   $0x2f1
  +   12ebf:	68 f2 02 00 00       	push   $0x2f2
  rsmisc.c(754-1): acpi_rs_convert_resource_to_aml
  ACPI_ERROR -> AE_INFO -> __LINE__
  -   12ed9:	68 03 03 00 00       	push   $0x303
  +   12ed9:	68 04 03 00 00       	push   $0x304
  rsmisc.c(772): acpi_rs_convert_resource_to_aml
  ACPI_ERROR -> AE_INFO -> __LINE__
  -   131eb:	ba f2 02 00 00       	mov    $0x2f2,%edx
  +   131eb:	ba f4 02 00 00       	mov    $0x2f4,%edx
  rsutils.c(756): acpi_rs_set_srs_method_data
  acpi_ut_create_internal_object -> acpi_ut_create_internal_object_dbg ->
  __LINE__
---
Divergences fixing result:
  Before applying: 2561 Lines, 90.4 Kbytes
  After applying: 2351 Lines, 82.4 Kbytes
---
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/evxface.c   |   13 +++++++------
 drivers/acpi/acpica/evxfevnt.c  |    1 -
 drivers/acpi/acpica/evxfgpe.c   |    1 +
 drivers/acpi/acpica/exconfig.c  |    1 -
 drivers/acpi/acpica/exmutex.c   |    1 +
 drivers/acpi/acpica/exoparg1.c  |    8 +-------
 drivers/acpi/acpica/exregion.c  |    9 ++++-----
 drivers/acpi/acpica/hwacpi.c    |    3 +--
 drivers/acpi/acpica/hwregs.c    |    3 +--
 drivers/acpi/acpica/nsrepair2.c |    3 ++-
 drivers/acpi/acpica/nsutils.c   |    6 +++---
 drivers/acpi/acpica/nsxfeval.c  |    2 ++
 drivers/acpi/acpica/psutils.c   |    2 +-
 drivers/acpi/acpica/rscreate.c  |    3 +--
 drivers/acpi/acpica/rsdump.c    |    3 ++-
 drivers/acpi/acpica/rsirq.c     |    6 ++----
 drivers/acpi/acpica/rsmemory.c  |    6 ++----
 drivers/acpi/acpica/rsmisc.c    |   11 ++++++-----
 drivers/acpi/acpica/rsutils.c   |    6 ++++--
 drivers/acpi/acpica/uteval.c    |    2 +-
 drivers/acpi/acpica/utglobal.c  |    1 +
 drivers/acpi/acpica/utresrc.c   |    7 +++----
 include/acpi/acpiosxf.h         |    4 +---
 include/acpi/acpixf.h           |    4 ++++
 include/acpi/actbl.h            |    1 -
 include/acpi/platform/acenv.h   |   13 ++++++++++++-
 include/acpi/platform/aclinux.h |    1 -
 28 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 421b048..5ce0693 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -678,6 +678,7 @@ struct acpi_opcode_info {
 };
 
 /* Value associated with the parse object */
+
 union acpi_parse_value {
 	u64 integer;		/* Integer constant (Up to 64 bits) */
 	u32 size;		/* bytelist or field size */
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 76cfe71..db82060 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -249,6 +249,7 @@ acpi_remove_notify_handler(acpi_handle device,
 	    (handler_type > ACPI_MAX_NOTIFY_HANDLER_TYPE)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
+
 	/* Make sure all deferred notify tasks are completed */
 
 	acpi_os_wait_events_complete();
@@ -622,12 +623,12 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 		goto free_and_exit;
 	}
 
-
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
-	handler->original_flags = gpe_event_info->flags &
-			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+	handler->original_flags = (u8)(gpe_event_info->flags &
+				       (ACPI_GPE_XRUPT_TYPE_MASK |
+				        ACPI_GPE_DISPATCH_MASK));
 
 	/*
 	 * If the GPE is associated with a method, it may have been enabled
@@ -746,10 +747,10 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	 * enabled, it should be enabled at this point to restore the
 	 * post-initialization configuration.
 	 */
-
-	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD)
-	    && handler->originally_enabled)
+	if ((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) &&
+	    handler->originally_enabled) {
 		(void)acpi_ev_add_gpe_reference(gpe_event_info);
+	}
 
 	/* Now we can free the handler object */
 
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index ee6e96c..be57f49 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -61,7 +61,6 @@ ACPI_MODULE_NAME("evxfevnt")
  * DESCRIPTION: Transfers the system into ACPI mode.
  *
  ******************************************************************************/
-
 acpi_status acpi_enable(void)
 {
 	acpi_status status;
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index d8095c1..36f8ad8 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -172,6 +172,7 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
+
 ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 9ad6420..b4f42f5 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -125,7 +125,6 @@ acpi_ex_add_table(u32 table_index,
 	 * responsible for discovering any new wake GPEs by running _PRW methods
 	 * that may have been loaded by this table.
 	 */
-
 	status = acpi_tb_get_owner_id(table_index, &owner_id);
 	if (ACPI_SUCCESS(status)) {
 		acpi_ev_update_gpes(owner_id);
diff --git a/drivers/acpi/acpica/exmutex.c b/drivers/acpi/acpica/exmutex.c
index 900a251..02157ef 100644
--- a/drivers/acpi/acpica/exmutex.c
+++ b/drivers/acpi/acpica/exmutex.c
@@ -378,6 +378,7 @@ acpi_ex_release_mutex(union acpi_operand_object *obj_desc,
 	}
 
 	/* Must have a valid thread ID */
+
 	if (!walk_state->thread) {
 		ACPI_ERROR((AE_INFO,
 			    "Cannot release Mutex [%4.4s], null thread info",
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index bbf01e9..cf50c6c 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -948,13 +948,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					 */
 					return_desc =
 					    acpi_ut_create_integer_object((u64)
-									  temp_desc->
-									  buffer.
-									  pointer
-									  [operand
-									   [0]->
-									   reference.
-									   value]);
+									  temp_desc->buffer.pointer[operand[0]->reference.value]);
 					if (!return_desc) {
 						status = AE_NO_MEMORY;
 						goto cleanup;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 044d441..06a4924 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -162,7 +162,6 @@ acpi_ex_system_memory_space_handler(u32 function,
 		 */
 		page_boundary_map_length =
 		    ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - address;
-
 		if (page_boundary_map_length == 0) {
 			page_boundary_map_length = ACPI_DEFAULT_PAGE_SIZE;
 		}
@@ -240,19 +239,19 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 		switch (bit_width) {
 		case 8:
-			ACPI_SET8(logical_addr_ptr) = (u8) * value;
+			ACPI_SET8(logical_addr_ptr) = (u8)*value;
 			break;
 
 		case 16:
-			ACPI_SET16(logical_addr_ptr) = (u16) * value;
+			ACPI_SET16(logical_addr_ptr) = (u16)*value;
 			break;
 
 		case 32:
-			ACPI_SET32(logical_addr_ptr) = (u32) * value;
+			ACPI_SET32(logical_addr_ptr) = (u32)*value;
 			break;
 
 		case 64:
-			ACPI_SET64(logical_addr_ptr) = (u64) * value;
+			ACPI_SET64(logical_addr_ptr) = (u64)*value;
 			break;
 
 		default:
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index 90a9aea..effa2b0 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -108,8 +108,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		 * enable bits to default
 		 */
 		status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
-					    (u32) acpi_gbl_FADT.acpi_disable,
-					    8);
+					    (u32)acpi_gbl_FADT.acpi_disable, 8);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Attempting to enable Legacy (non-ACPI) mode\n"));
 		break;
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index e782b5a..fd4e2dc 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -363,8 +363,7 @@ acpi_status acpi_hw_write_pm1_control(u32 pm1a_control, u32 pm1b_control)
  * DESCRIPTION: Read from the specified ACPI register
  *
  ******************************************************************************/
-acpi_status
-acpi_hw_register_read(u32 register_id, u32 * return_value)
+acpi_status acpi_hw_register_read(u32 register_id, u32 *return_value)
 {
 	u32 value = 0;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 9018925..fdb818d 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -55,7 +55,8 @@ ACPI_MODULE_NAME("nsrepair2")
  */
 typedef
 acpi_status(*acpi_repair_function) (struct acpi_predefined_data *data,
-				    union acpi_operand_object **return_object_ptr);
+				    union acpi_operand_object
+				    **return_object_ptr);
 
 typedef struct acpi_repair_info {
 	char name[ACPI_NAME_SIZE];
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 479aad0..7e8bd2a 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -111,7 +111,7 @@ acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
 u8 acpi_ns_valid_root_prefix(char prefix)
 {
 
-	return ((u8) (prefix == '\\'));
+	return ((u8)(prefix == '\\'));
 }
 
 /*******************************************************************************
@@ -129,7 +129,7 @@ u8 acpi_ns_valid_root_prefix(char prefix)
 static u8 acpi_ns_valid_path_separator(char sep)
 {
 
-	return ((u8) (sep == '.'));
+	return ((u8)(sep == '.'));
 }
 
 /*******************************************************************************
@@ -673,7 +673,7 @@ u32 acpi_ns_opens_scope(acpi_object_type type)
 		return_UINT32(ACPI_NS_NORMAL);
 	}
 
-	return_UINT32(((u32) acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
+	return_UINT32(((u32)acpi_gbl_ns_properties[type]) & ACPI_NS_NEWSCOPE);
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 5c05ba3..a5d8ccc 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -606,7 +606,9 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 			for (i = 0; i < cid->count; i++) {
 				if (ACPI_STRCMP(cid->ids[i].string, info->hid)
 				    == 0) {
+
 					/* Found a matching CID */
+
 					found = TRUE;
 					break;
 				}
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 4137dcb..afefb3a1 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -206,7 +206,7 @@ u8 acpi_ps_is_leading_char(u32 c)
  */
 u8 acpi_ps_is_prefix_char(u32 c)
 {
-	return ((u8) (c == '\\' || c == '^'));
+	return ((u8)(c == '\\' || c == '^'));
 }
 
 /*
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 311cbc4..8133326 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -480,8 +480,7 @@ acpi_rs_create_aml_resources(struct acpi_resource *linked_list_buffer,
 	status = acpi_rs_get_aml_length(linked_list_buffer, &aml_size_needed);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "AmlSizeNeeded=%X, %s\n",
-			  (u32) aml_size_needed,
-			  acpi_format_exception(status)));
+			  (u32)aml_size_needed, acpi_format_exception(status)));
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 4d11b072..276e52f 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -654,7 +654,8 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 			/*
 			 * Optional resource_source for Address resources
 			 */
-			acpi_rs_dump_resource_source(ACPI_CAST_PTR(struct
+			acpi_rs_dump_resource_source(ACPI_CAST_PTR
+						     (struct
 								   acpi_resource_source,
 								   target));
 			break;
diff --git a/drivers/acpi/acpica/rsirq.c b/drivers/acpi/acpica/rsirq.c
index e23a9ec..a718eca 100644
--- a/drivers/acpi/acpica/rsirq.c
+++ b/drivers/acpi/acpica/rsirq.c
@@ -212,15 +212,13 @@ struct acpi_rsconvert_info acpi_rs_convert_ext_irq[9] = {
 
 	{ACPI_RSC_COUNT, ACPI_RS_OFFSET(data.extended_irq.interrupt_count),
 	 AML_OFFSET(extended_irq.interrupt_count),
-	 sizeof(u32)}
-	,
+	 sizeof(u32)},
 
 	/* Copy every IRQ in the table, each is 32 bits */
 
 	{ACPI_RSC_MOVE32, ACPI_RS_OFFSET(data.extended_irq.interrupts[0]),
 	 AML_OFFSET(extended_irq.interrupts[0]),
-	 0}
-	,
+	 0},
 
 	/* Optional resource_source (Index and String) */
 
diff --git a/drivers/acpi/acpica/rsmemory.c b/drivers/acpi/acpica/rsmemory.c
index 4fd611a..d446103 100644
--- a/drivers/acpi/acpica/rsmemory.c
+++ b/drivers/acpi/acpica/rsmemory.c
@@ -156,8 +156,7 @@ struct acpi_rsconvert_info acpi_rs_get_vendor_small[3] = {
 
 	{ACPI_RSC_COUNT16, ACPI_RS_OFFSET(data.vendor.byte_length),
 	 0,
-	 sizeof(u8)}
-	,
+	 sizeof(u8)},
 
 	/* Vendor data */
 
@@ -181,8 +180,7 @@ struct acpi_rsconvert_info acpi_rs_get_vendor_large[3] = {
 
 	{ACPI_RSC_COUNT16, ACPI_RS_OFFSET(data.vendor.byte_length),
 	 0,
-	 sizeof(u8)}
-	,
+	 sizeof(u8)},
 
 	/* Vendor data */
 
diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index c6f291c..3d0e15c 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -159,7 +159,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8) item_count;
+			ACPI_SET8(destination) = (u8)item_count;
 
 			resource->length = resource->length +
 			    (info->value * (item_count - 1));
@@ -385,7 +385,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8) item_count;
+			ACPI_SET8(target) = (u8)item_count;
 			break;
 
 		case ACPI_RSC_BITMASK16:
@@ -401,7 +401,7 @@ acpi_rs_convert_aml_to_resource(struct acpi_resource *resource,
 			}
 
 			target = ACPI_ADD_PTR(char, resource, info->value);
-			ACPI_SET8(target) = (u8) item_count;
+			ACPI_SET8(target) = (u8)item_count;
 			break;
 
 		case ACPI_RSC_EXIT_NE:
@@ -544,7 +544,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 		case ACPI_RSC_COUNT:
 
 			item_count = ACPI_GET8(source);
-			ACPI_SET8(destination) = (u8) item_count;
+			ACPI_SET8(destination) = (u8)item_count;
 
 			aml_length =
 			    (u16) (aml_length +
@@ -686,7 +686,8 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 			 * Optional resource_source (Index and String)
 			 */
 			aml_length =
-			    acpi_rs_set_resource_source(aml, (acpi_rs_length)
+			    acpi_rs_set_resource_source(aml,
+							(acpi_rs_length)
 							aml_length, source);
 			acpi_rs_set_resource_length(aml_length, aml);
 			break;
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 37d5241..441447f 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -358,8 +358,10 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 		 *
 		 * Zero the entire area of the buffer.
 		 */
-		total_length = (u32)
-		ACPI_STRLEN(ACPI_CAST_PTR(char, &aml_resource_source[1])) + 1;
+		total_length =
+		    (u32)
+		    ACPI_STRLEN(ACPI_CAST_PTR(char, &aml_resource_source[1])) +
+		    1;
 		total_length = (u32) ACPI_ROUND_UP_TO_NATIVE_WORD(total_length);
 
 		ACPI_MEMSET(resource_source->string_ptr, 0, total_length);
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index a9c65fb..45cddb8 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -68,7 +68,7 @@ ACPI_MODULE_NAME("uteval")
  ******************************************************************************/
 
 acpi_status
-acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
+acpi_ut_evaluate_object(struct acpi_namespace_node * prefix_node,
 			char *path,
 			u32 expected_return_btypes,
 			union acpi_operand_object **return_desc)
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 4080088..c083611 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -373,6 +373,7 @@ acpi_status acpi_ut_init_globals(void)
 }
 
 /* Public globals */
+
 ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index e38bef4..7d0a1b5 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -412,7 +412,7 @@ static const u8 acpi_gbl_resource_types[] = {
  ******************************************************************************/
 
 acpi_status
-acpi_ut_walk_aml_resources(u8 * aml,
+acpi_ut_walk_aml_resources(u8 *aml,
 			   acpi_size aml_length,
 			   acpi_walk_aml_callback user_function, void **context)
 {
@@ -525,7 +525,7 @@ acpi_ut_walk_aml_resources(u8 * aml,
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_validate_resource(void *aml, u8 * return_index)
+acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index)
 {
 	union aml_resource *aml_resource;
 	u8 resource_type;
@@ -800,8 +800,7 @@ u32 acpi_ut_get_descriptor_length(void *aml)
  ******************************************************************************/
 
 acpi_status
-acpi_ut_get_resource_end_tag(union acpi_operand_object * obj_desc,
-			     u8 ** end_tag)
+acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc, u8 **end_tag)
 {
 	acpi_status status;
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 33a3e17..dfcedc6 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -102,10 +102,8 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 /*
  * Spinlock primitives
  */
-
 #ifndef acpi_os_create_lock
-acpi_status
-acpi_os_create_lock(acpi_spinlock *out_handle);
+acpi_status acpi_os_create_lock(acpi_spinlock * out_handle);
 #endif
 
 void acpi_os_delete_lock(acpi_spinlock handle);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b409406..b77ee00 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -62,10 +62,14 @@ extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;
 extern u8 acpi_gbl_system_awake_and_running;
 extern u8 acpi_gbl_reduced_hardware;	/* ACPI 5.0 */
+
 /* Runtime configuration of debug print levels */
+
 extern u32 acpi_dbg_level;
 extern u32 acpi_dbg_layer;
+
 /* ACPICA runtime options */
+
 extern u8 acpi_gbl_enable_interpreter_slack;
 extern u8 acpi_gbl_all_methods_serialized;
 extern u8 acpi_gbl_create_osi_method;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index c0e6c32..ee050e8 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -357,7 +357,6 @@ struct acpi_table_desc {
 /*
  * Get the remaining ACPI tables
  */
-
 #include <acpi/actbl1.h>
 #include <acpi/actbl2.h>
 #include <acpi/actbl3.h>
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index cec6cd3..a74afaf 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -49,6 +49,7 @@
  * to the local environment. This includes compiler-specific, OS-specific,
  * and machine-specific configuration.
  */
+
 /* Types for ACPI_MUTEX_TYPE */
 
 #define ACPI_BINARY_SEMAPHORE       0
@@ -66,6 +67,7 @@
  *****************************************************************************/
 
 /* iASL configuration */
+
 #ifdef ACPI_ASL_COMPILER
 #define ACPI_APPLICATION
 #define ACPI_DISASSEMBLER
@@ -77,6 +79,7 @@
 #endif
 
 /* acpi_exec configuration. Multithreaded with full AML debugger */
+
 #ifdef ACPI_EXEC_APP
 #define ACPI_APPLICATION
 #define ACPI_FULL_DEBUG
@@ -117,12 +120,14 @@
 #endif
 
 /* Common for all ACPICA applications */
+
 #ifdef ACPI_APPLICATION
 #define ACPI_USE_SYSTEM_CLIBRARY
 #define ACPI_USE_LOCAL_CACHE
 #endif
 
 /* Common debug support */
+
 #ifdef ACPI_FULL_DEBUG
 #define ACPI_DEBUGGER
 #define ACPI_DEBUG_OUTPUT
@@ -138,6 +143,7 @@
  * by the host files.
  *
  *****************************************************************************/
+
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
@@ -294,7 +300,9 @@
 /* Use the standard C library headers. We want to keep these to a minimum. */
 
 #ifdef ACPI_USE_STANDARD_HEADERS
+
 /* Use the standard headers from the standard locations */
+
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
@@ -303,6 +311,7 @@
 #endif				/* ACPI_USE_STANDARD_HEADERS */
 
 /* We will be linking to the standard Clib functions */
+
 #define ACPI_STRSTR(s1,s2)      strstr((s1), (s2))
 #define ACPI_STRCHR(s1,c)       strchr((s1), (c))
 #define ACPI_STRLEN(s)          (acpi_size) strlen((s))
@@ -340,7 +349,6 @@
  * implementation provided by a native C library, but they are functionally
  * equivalent.
  */
-
 #ifndef va_arg
 
 #ifndef _VALIST
@@ -349,10 +357,12 @@ typedef char *va_list;
 #endif				/* _VALIST */
 
 /* Storage alignment properties */
+
 #define  _AUPBND                (sizeof (acpi_native_int) - 1)
 #define  _ADNBND                (sizeof (acpi_native_int) - 1)
 
 /* Variable argument list macro definitions */
+
 #define _bnd(X, bnd)            (((sizeof (X)) + (bnd)) & (~(bnd)))
 #define va_arg(ap, T)           (*(T *)(((ap) += (_bnd (T, _AUPBND))) - (_bnd (T,_ADNBND))))
 #define va_end(ap)              (ap = (va_list) NULL)
@@ -361,6 +371,7 @@ typedef char *va_list;
 #endif				/* va_arg */
 
 /* Use the local (ACPICA) definitions of the clib functions */
+
 #define ACPI_STRSTR(s1,s2)      acpi_ut_strstr ((s1), (s2))
 #define ACPI_STRCHR(s1,c)       acpi_ut_strchr ((s1), (c))
 #define ACPI_STRLEN(s)          (acpi_size) acpi_ut_strlen ((s))
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 85d5d8f..33d05b0 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -108,7 +108,6 @@
 
 #include <acpi/platform/acgcc.h>
 
-
 #ifdef __KERNEL__
 #include <acpi/actypes.h>
 /*
-- 
1.7.10

