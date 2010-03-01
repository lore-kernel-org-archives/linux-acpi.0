From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/9] ACPICA: Remove obsolete ACPI_INTEGER (acpi_integer) type
Date: Mon, 01 Mar 2010 01:56:14 -0500
Message-ID: <5df7e6cb42da36c7d878239bebc81907b15f3943.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:64815 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0CAG43 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:29 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL000EZCNTX3B3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:57:30 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This type was introduced as the code was migrated from ACPI 1.0
(with 32-bit AML integers) to ACPI 2.0 (with 64-bit integers). It
is now obsolete and this change removes it from the ACPICA code
base, replaced by u64.  The original typedef has been retained
for now for compatibility with existing device driver code.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h |    3 +-
 drivers/acpi/acpica/acinterp.h |   42 +++++++++++++----------------
 drivers/acpi/acpica/aclocal.h  |    2 +-
 drivers/acpi/acpica/acmacros.h |   12 ++++----
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/acutils.h  |   20 +++++--------
 drivers/acpi/acpica/dsfield.c  |   10 +++---
 drivers/acpi/acpica/dsobject.c |    2 +-
 drivers/acpi/acpica/evregion.c |    5 +--
 drivers/acpi/acpica/evrgnini.c |    2 +-
 drivers/acpi/acpica/exconfig.c |    2 +-
 drivers/acpi/acpica/exconvrt.c |   19 +++++-------
 drivers/acpi/acpica/exfield.c  |    7 ++---
 drivers/acpi/acpica/exfldio.c  |   57 ++++++++++++++++++---------------------
 drivers/acpi/acpica/exmisc.c   |   10 +++----
 drivers/acpi/acpica/exoparg1.c |   14 +++++-----
 drivers/acpi/acpica/exoparg2.c |    4 +-
 drivers/acpi/acpica/exoparg3.c |    2 +-
 drivers/acpi/acpica/exoparg6.c |    8 +++---
 drivers/acpi/acpica/exregion.c |   33 ++++++++++------------
 drivers/acpi/acpica/exsystem.c |    2 +-
 drivers/acpi/acpica/exutils.c  |   22 +++++++-------
 drivers/acpi/acpica/hwtimer.c  |    2 +-
 drivers/acpi/acpica/psargs.c   |    2 +-
 drivers/acpi/acpica/rscreate.c |    2 +-
 drivers/acpi/acpica/utdebug.c  |    3 +-
 drivers/acpi/acpica/uteval.c   |    2 +-
 drivers/acpi/acpica/utglobal.c |    2 +-
 drivers/acpi/acpica/utmath.c   |   25 +++++++----------
 drivers/acpi/acpica/utmisc.c   |   14 ++++-----
 include/acpi/acpiosxf.h        |    4 +-
 include/acpi/acrestyp.h        |    2 +-
 include/acpi/actypes.h         |   27 +++++++++++-------
 33 files changed, 169 insertions(+), 196 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 13d2b0b..31056bc 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -139,8 +139,7 @@ acpi_status acpi_ev_initialize_op_regions(void);
 acpi_status
 acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			       u32 function,
-			       u32 region_offset,
-			       u32 bit_width, acpi_integer * value);
+			       u32 region_offset, u32 bit_width, u64 *value);
 
 acpi_status
 acpi_ev_attach_region(union acpi_operand_object *handler_obj,
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index c9d7802..6df3f84 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -129,18 +129,17 @@ acpi_ex_common_buffer_setup(union acpi_operand_object *obj_desc,
 
 acpi_status
 acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
-			       acpi_integer mask,
-			       acpi_integer field_value,
-			       u32 field_datum_byte_offset);
+			       u64 mask,
+			       u64 field_value, u32 field_datum_byte_offset);
 
 void
-acpi_ex_get_buffer_datum(acpi_integer * datum,
+acpi_ex_get_buffer_datum(u64 *datum,
 			 void *buffer,
 			 u32 buffer_length,
 			 u32 byte_granularity, u32 buffer_offset);
 
 void
-acpi_ex_set_buffer_datum(acpi_integer merged_datum,
+acpi_ex_set_buffer_datum(u64 merged_datum,
 			 void *buffer,
 			 u32 buffer_length,
 			 u32 byte_granularity, u32 buffer_offset);
@@ -168,8 +167,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 acpi_status
 acpi_ex_access_region(union acpi_operand_object *obj_desc,
-		      u32 field_datum_byte_offset,
-		      acpi_integer * value, u32 read_write);
+		      u32 field_datum_byte_offset, u64 *value, u32 read_write);
 
 /*
  * exmisc - misc support routines
@@ -193,16 +191,14 @@ acpi_ex_do_concatenate(union acpi_operand_object *obj_desc,
 
 acpi_status
 acpi_ex_do_logical_numeric_op(u16 opcode,
-			      acpi_integer integer0,
-			      acpi_integer integer1, u8 * logical_result);
+			      u64 integer0, u64 integer1, u8 *logical_result);
 
 acpi_status
 acpi_ex_do_logical_op(u16 opcode,
 		      union acpi_operand_object *operand0,
-		      union acpi_operand_object *operand1, u8 * logical_result);
+		      union acpi_operand_object *operand1, u8 *logical_result);
 
-acpi_integer
-acpi_ex_do_math_op(u16 opcode, acpi_integer operand0, acpi_integer operand1);
+u64 acpi_ex_do_math_op(u16 opcode, u64 operand0, u64 operand1);
 
 acpi_status acpi_ex_create_mutex(struct acpi_walk_state *walk_state);
 
@@ -278,7 +274,7 @@ acpi_status
 acpi_ex_system_do_notify_op(union acpi_operand_object *value,
 			    union acpi_operand_object *obj_desc);
 
-acpi_status acpi_ex_system_do_suspend(acpi_integer time);
+acpi_status acpi_ex_system_do_suspend(u64 time);
 
 acpi_status acpi_ex_system_do_stall(u32 time);
 
@@ -461,9 +457,9 @@ void acpi_ex_acquire_global_lock(u32 rule);
 
 void acpi_ex_release_global_lock(u32 rule);
 
-void acpi_ex_eisa_id_to_string(char *dest, acpi_integer compressed_id);
+void acpi_ex_eisa_id_to_string(char *dest, u64 compressed_id);
 
-void acpi_ex_integer_to_string(char *dest, acpi_integer value);
+void acpi_ex_integer_to_string(char *dest, u64 value);
 
 /*
  * exregion - default op_region handlers
@@ -472,7 +468,7 @@ acpi_status
 acpi_ex_system_memory_space_handler(u32 function,
 				    acpi_physical_address address,
 				    u32 bit_width,
-				    acpi_integer * value,
+				    u64 *value,
 				    void *handler_context,
 				    void *region_context);
 
@@ -480,35 +476,35 @@ acpi_status
 acpi_ex_system_io_space_handler(u32 function,
 				acpi_physical_address address,
 				u32 bit_width,
-				acpi_integer * value,
+				u64 *value,
 				void *handler_context, void *region_context);
 
 acpi_status
 acpi_ex_pci_config_space_handler(u32 function,
 				 acpi_physical_address address,
 				 u32 bit_width,
-				 acpi_integer * value,
+				 u64 *value,
 				 void *handler_context, void *region_context);
 
 acpi_status
 acpi_ex_cmos_space_handler(u32 function,
 			   acpi_physical_address address,
 			   u32 bit_width,
-			   acpi_integer * value,
+			   u64 *value,
 			   void *handler_context, void *region_context);
 
 acpi_status
 acpi_ex_pci_bar_space_handler(u32 function,
 			      acpi_physical_address address,
 			      u32 bit_width,
-			      acpi_integer * value,
+			      u64 *value,
 			      void *handler_context, void *region_context);
 
 acpi_status
 acpi_ex_embedded_controller_space_handler(u32 function,
 					  acpi_physical_address address,
 					  u32 bit_width,
-					  acpi_integer * value,
+					  u64 *value,
 					  void *handler_context,
 					  void *region_context);
 
@@ -516,14 +512,14 @@ acpi_status
 acpi_ex_sm_bus_space_handler(u32 function,
 			     acpi_physical_address address,
 			     u32 bit_width,
-			     acpi_integer * value,
+			     u64 *value,
 			     void *handler_context, void *region_context);
 
 acpi_status
 acpi_ex_data_table_space_handler(u32 function,
 				 acpi_physical_address address,
 				 u32 bit_width,
-				 acpi_integer * value,
+				 u64 *value,
 				 void *handler_context, void *region_context);
 
 #endif				/* __INTERP_H__ */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 681205c..4894dec 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -650,7 +650,7 @@ struct acpi_opcode_info {
 };
 
 union acpi_parse_value {
-	acpi_integer integer;	/* Integer constant (Up to 64 bits) */
+	u64 integer;		/* Integer constant (Up to 64 bits) */
 	struct uint64_struct integer64;	/* Structure overlay for 2 32-bit Dwords */
 	u32 size;		/* bytelist or field size */
 	char *string;		/* NULL terminated string */
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index a4a9519..9894929 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -272,8 +272,8 @@
  * MASK_BITS_ABOVE creates a mask starting AT the position and above
  * MASK_BITS_BELOW creates a mask starting one bit BELOW the position
  */
-#define ACPI_MASK_BITS_ABOVE(position)      (~((ACPI_INTEGER_MAX) << ((u32) (position))))
-#define ACPI_MASK_BITS_BELOW(position)      ((ACPI_INTEGER_MAX) << ((u32) (position)))
+#define ACPI_MASK_BITS_ABOVE(position)      (~((ACPI_UINT64_MAX) << ((u32) (position))))
+#define ACPI_MASK_BITS_BELOW(position)      ((ACPI_UINT64_MAX) << ((u32) (position)))
 
 /* Bitfields within ACPI registers */
 
@@ -414,16 +414,16 @@
 											acpi_ut_ptr_exit (ACPI_DEBUG_PARAMETERS, (u8 *) _s); \
 											return (_s); })
 #define return_VALUE(s)                 ACPI_DO_WHILE0 ({ \
-											register acpi_integer _s = (s); \
+											register u64 _s = (s); \
 											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, _s); \
 											return (_s); })
 #define return_UINT8(s)                 ACPI_DO_WHILE0 ({ \
 											register u8 _s = (u8) (s); \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (acpi_integer) _s); \
+											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) _s); \
 											return (_s); })
 #define return_UINT32(s)                ACPI_DO_WHILE0 ({ \
 											register u32 _s = (u32) (s); \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (acpi_integer) _s); \
+											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) _s); \
 											return (_s); })
 #else				/* Use original less-safe macros */
 
@@ -434,7 +434,7 @@
 											acpi_ut_ptr_exit (ACPI_DEBUG_PARAMETERS, (u8 *) (s)); \
 											return((s)); })
 #define return_VALUE(s)                 ACPI_DO_WHILE0 ({ \
-											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (acpi_integer) (s)); \
+											acpi_ut_value_exit (ACPI_DEBUG_PARAMETERS, (u64) (s)); \
 											return((s)); })
 #define return_UINT8(s)                 return_VALUE(s)
 #define return_UINT32(s)                return_VALUE(s)
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 6d0b4de..3b5d8bf 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -111,7 +111,7 @@ ACPI_OBJECT_COMMON_HEADER};
 
 struct acpi_object_integer {
 	ACPI_OBJECT_COMMON_HEADER u8 fill[3];	/* Prevent warning on some compilers */
-	acpi_integer value;
+	u64 value;
 };
 
 /*
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index d3ae626..35df755 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -134,7 +134,7 @@ char *acpi_ut_get_region_name(u8 space_id);
 
 char *acpi_ut_get_event_name(u32 event_id);
 
-char acpi_ut_hex_to_ascii_char(acpi_integer integer, u32 position);
+char acpi_ut_hex_to_ascii_char(u64 integer, u32 position);
 
 u8 acpi_ut_valid_object_type(acpi_object_type type);
 
@@ -279,8 +279,7 @@ acpi_ut_status_exit(u32 line_number,
 void
 acpi_ut_value_exit(u32 line_number,
 		   const char *function_name,
-		   const char *module_name,
-		   u32 component_id, acpi_integer value);
+		   const char *module_name, u32 component_id, u64 value);
 
 void
 acpi_ut_ptr_exit(u32 line_number,
@@ -324,7 +323,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 acpi_status
 acpi_ut_evaluate_numeric_object(char *object_name,
 				struct acpi_namespace_node *device_node,
-				acpi_integer *value);
+				u64 *value);
 
 acpi_status
 acpi_ut_execute_STA(struct acpi_namespace_node *device_node, u32 *status_flags);
@@ -437,14 +436,12 @@ void acpi_ut_delete_generic_state(union acpi_generic_state *state);
  * utmath
  */
 acpi_status
-acpi_ut_divide(acpi_integer in_dividend,
-	       acpi_integer in_divisor,
-	       acpi_integer * out_quotient, acpi_integer * out_remainder);
+acpi_ut_divide(u64 in_dividend,
+	       u64 in_divisor, u64 *out_quotient, u64 *out_remainder);
 
 acpi_status
-acpi_ut_short_divide(acpi_integer in_dividend,
-		     u32 divisor,
-		     acpi_integer * out_quotient, u32 * out_remainder);
+acpi_ut_short_divide(u64 in_dividend,
+		     u32 divisor, u64 *out_quotient, u32 *out_remainder);
 
 /*
  * utmisc
@@ -474,8 +471,7 @@ acpi_name acpi_ut_repair_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
-acpi_status
-acpi_ut_strtoul64(char *string, u32 base, acpi_integer * ret_integer);
+acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_warning(const char *module_name,
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index effbf15..bb13817 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -220,7 +220,7 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 			union acpi_parse_object *arg)
 {
 	acpi_status status;
-	acpi_integer position;
+	u64 position;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_get_field_names, info);
 
@@ -240,8 +240,8 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 		switch (arg->common.aml_opcode) {
 		case AML_INT_RESERVEDFIELD_OP:
 
-			position = (acpi_integer) info->field_bit_position
-			    + (acpi_integer) arg->common.value.size;
+			position = (u64) info->field_bit_position
+			    + (u64) arg->common.value.size;
 
 			if (position > ACPI_UINT32_MAX) {
 				ACPI_ERROR((AE_INFO,
@@ -305,8 +305,8 @@ acpi_ds_get_field_names(struct acpi_create_field_info *info,
 
 			/* Keep track of bit position for the next field */
 
-			position = (acpi_integer) info->field_bit_position
-			    + (acpi_integer) arg->common.value.size;
+			position = (u64) info->field_bit_position
+			    + (u64) arg->common.value.size;
 
 			if (position > ACPI_UINT32_MAX) {
 				ACPI_ERROR((AE_INFO,
diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index edd7aa2..891e08b 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -684,7 +684,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 			case AML_ONES_OP:
 
-				obj_desc->integer.value = ACPI_INTEGER_MAX;
+				obj_desc->integer.value = ACPI_UINT64_MAX;
 
 				/* Truncate value if we are executing from a 32-bit ACPI table */
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 654b283..98fd210 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -329,7 +329,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
  *              region_offset       - Where in the region to read or write
  *              bit_width           - Field width in bits (8, 16, 32, or 64)
  *              Value               - Pointer to in or out value, must be
- *                                    full 64-bit acpi_integer
+ *                                    a full 64-bit integer
  *
  * RETURN:      Status
  *
@@ -341,8 +341,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 acpi_status
 acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			       u32 function,
-			       u32 region_offset,
-			       u32 bit_width, acpi_integer * value)
+			       u32 region_offset, u32 bit_width, u64 *value)
 {
 	acpi_status status;
 	acpi_adr_space_handler handler;
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 86bd5a7..2e3b033 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -168,7 +168,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 				void *handler_context, void **region_context)
 {
 	acpi_status status = AE_OK;
-	acpi_integer pci_value;
+	u64 pci_value;
 	struct acpi_pci_id *pci_id = *region_context;
 	union acpi_operand_object *handler_obj;
 	struct acpi_namespace_node *parent_node;
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index cee2bce..7e8b3be 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -284,7 +284,7 @@ static acpi_status
 acpi_ex_region_read(union acpi_operand_object *obj_desc, u32 length, u8 *buffer)
 {
 	acpi_status status;
-	acpi_integer value;
+	u64 value;
 	u32 region_offset = 0;
 	u32 i;
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index adcaf3b..bda7aed 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -51,8 +51,7 @@ ACPI_MODULE_NAME("exconvrt")
 
 /* Local prototypes */
 static u32
-acpi_ex_convert_to_ascii(acpi_integer integer,
-			 u16 base, u8 * string, u8 max_length);
+acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 max_length);
 
 /*******************************************************************************
  *
@@ -75,7 +74,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 {
 	union acpi_operand_object *return_desc;
 	u8 *pointer;
-	acpi_integer result;
+	u64 result;
 	u32 i;
 	u32 count;
 	acpi_status status;
@@ -155,7 +154,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 			 * Little endian is used, meaning that the first byte of the buffer
 			 * is the LSB of the integer
 			 */
-			result |= (((acpi_integer) pointer[i]) << (i * 8));
+			result |= (((u64) pointer[i]) << (i * 8));
 		}
 		break;
 
@@ -285,10 +284,9 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
  ******************************************************************************/
 
 static u32
-acpi_ex_convert_to_ascii(acpi_integer integer,
-			 u16 base, u8 * string, u8 data_width)
+acpi_ex_convert_to_ascii(u64 integer, u16 base, u8 *string, u8 data_width)
 {
-	acpi_integer digit;
+	u64 digit;
 	u32 i;
 	u32 j;
 	u32 k = 0;
@@ -531,10 +529,9 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		 * (separated by commas or spaces)
 		 */
 		for (i = 0; i < obj_desc->buffer.length; i++) {
-			new_buf += acpi_ex_convert_to_ascii((acpi_integer)
-							    obj_desc->buffer.
-							    pointer[i], base,
-							    new_buf, 1);
+			new_buf += acpi_ex_convert_to_ascii((u64) obj_desc->
+							    buffer.pointer[i],
+							    base, new_buf, 1);
 			*new_buf++ = separator;	/* each separated by a comma or space */
 		}
 
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index c9190c7..6c79fec 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -130,7 +130,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 		/* Call the region handler for the read */
 
 		status = acpi_ex_access_region(obj_desc, 0,
-					       ACPI_CAST_PTR(acpi_integer,
+					       ACPI_CAST_PTR(u64,
 							     buffer_desc->
 							     buffer.pointer),
 					       function);
@@ -141,7 +141,7 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	/*
 	 * Allocate a buffer for the contents of the field.
 	 *
-	 * If the field is larger than the size of an acpi_integer, create
+	 * If the field is larger than the current integer width, create
 	 * a BUFFER to hold it.  Otherwise, use an INTEGER.  This allows
 	 * the use of arithmetic operators on the returned value if the
 	 * field size is equal or smaller than an Integer.
@@ -306,8 +306,7 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		 * same buffer)
 		 */
 		status = acpi_ex_access_region(obj_desc, 0,
-					       (acpi_integer *) buffer,
-					       function);
+					       (u64 *) buffer, function);
 		acpi_ex_release_global_lock(obj_desc->common_field.field_flags);
 
 		*result_desc = buffer_desc;
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index dc2f9e8..f68a216 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -55,11 +55,10 @@ ACPI_MODULE_NAME("exfldio")
 static acpi_status
 acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		       u32 field_datum_byte_offset,
-		       acpi_integer * value, u32 read_write);
+		       u64 *value, u32 read_write);
 
 static u8
-acpi_ex_register_overflow(union acpi_operand_object *obj_desc,
-			  acpi_integer value);
+acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value);
 
 static acpi_status
 acpi_ex_setup_region(union acpi_operand_object *obj_desc,
@@ -212,7 +211,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
  *              field_datum_byte_offset - Byte offset of this datum within the
  *                                        parent field
  *              Value                   - Where to store value (must at least
- *                                        the size of acpi_integer)
+ *                                        64 bits)
  *              Function                - Read or Write flag plus other region-
  *                                        dependent flags
  *
@@ -224,8 +223,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 
 acpi_status
 acpi_ex_access_region(union acpi_operand_object *obj_desc,
-		      u32 field_datum_byte_offset,
-		      acpi_integer * value, u32 function)
+		      u32 field_datum_byte_offset, u64 *value, u32 function)
 {
 	acpi_status status;
 	union acpi_operand_object *rgn_desc;
@@ -317,8 +315,7 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
  ******************************************************************************/
 
 static u8
-acpi_ex_register_overflow(union acpi_operand_object *obj_desc,
-			  acpi_integer value)
+acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
 {
 
 	if (obj_desc->common_field.bit_length >= ACPI_INTEGER_BIT_SIZE) {
@@ -329,7 +326,7 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc,
 		return (FALSE);
 	}
 
-	if (value >= ((acpi_integer) 1 << obj_desc->common_field.bit_length)) {
+	if (value >= ((u64) 1 << obj_desc->common_field.bit_length)) {
 		/*
 		 * The Value is larger than the maximum value that can fit into
 		 * the register.
@@ -362,11 +359,10 @@ acpi_ex_register_overflow(union acpi_operand_object *obj_desc,
 
 static acpi_status
 acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
-		       u32 field_datum_byte_offset,
-		       acpi_integer * value, u32 read_write)
+		       u32 field_datum_byte_offset, u64 *value, u32 read_write)
 {
 	acpi_status status;
-	acpi_integer local_value;
+	u64 local_value;
 
 	ACPI_FUNCTION_TRACE_U32(ex_field_datum_io, field_datum_byte_offset);
 
@@ -439,8 +435,8 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		 * the register
 		 */
 		if (acpi_ex_register_overflow(obj_desc->bank_field.bank_obj,
-					      (acpi_integer) obj_desc->
-					      bank_field.value)) {
+					      (u64) obj_desc->bank_field.
+					      value)) {
 			return_ACPI_STATUS(AE_AML_REGISTER_LIMIT);
 		}
 
@@ -481,8 +477,8 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		 * the register
 		 */
 		if (acpi_ex_register_overflow(obj_desc->index_field.index_obj,
-					      (acpi_integer) obj_desc->
-					      index_field.value)) {
+					      (u64) obj_desc->index_field.
+					      value)) {
 			return_ACPI_STATUS(AE_AML_REGISTER_LIMIT);
 		}
 
@@ -512,7 +508,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 			status =
 			    acpi_ex_extract_from_field(obj_desc->index_field.
 						       data_obj, value,
-						       sizeof(acpi_integer));
+						       sizeof(u64));
 		} else {
 			/* Write the datum to the data_register */
 
@@ -523,7 +519,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 			status =
 			    acpi_ex_insert_into_field(obj_desc->index_field.
 						      data_obj, value,
-						      sizeof(acpi_integer));
+						      sizeof(u64));
 		}
 		break;
 
@@ -571,13 +567,12 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 
 acpi_status
 acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
-			       acpi_integer mask,
-			       acpi_integer field_value,
-			       u32 field_datum_byte_offset)
+			       u64 mask,
+			       u64 field_value, u32 field_datum_byte_offset)
 {
 	acpi_status status = AE_OK;
-	acpi_integer merged_value;
-	acpi_integer current_value;
+	u64 merged_value;
+	u64 current_value;
 
 	ACPI_FUNCTION_TRACE_U32(ex_write_with_update_rule, mask);
 
@@ -587,7 +582,7 @@ acpi_ex_write_with_update_rule(union acpi_operand_object *obj_desc,
 
 	/* If the mask is all ones, we don't need to worry about the update rule */
 
-	if (mask != ACPI_INTEGER_MAX) {
+	if (mask != ACPI_UINT64_MAX) {
 
 		/* Decode the update rule */
 
@@ -678,8 +673,8 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 			   void *buffer, u32 buffer_length)
 {
 	acpi_status status;
-	acpi_integer raw_datum;
-	acpi_integer merged_datum;
+	u64 raw_datum;
+	u64 merged_datum;
 	u32 field_offset = 0;
 	u32 buffer_offset = 0;
 	u32 buffer_tail_bits;
@@ -804,10 +799,10 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 			  void *buffer, u32 buffer_length)
 {
 	acpi_status status;
-	acpi_integer mask;
-	acpi_integer width_mask;
-	acpi_integer merged_datum;
-	acpi_integer raw_datum = 0;
+	u64 mask;
+	u64 width_mask;
+	u64 merged_datum;
+	u64 raw_datum = 0;
 	u32 field_offset = 0;
 	u32 buffer_offset = 0;
 	u32 buffer_tail_bits;
@@ -855,7 +850,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	 * shift operator
 	 */
 	if (obj_desc->common_field.access_bit_width == ACPI_INTEGER_BIT_SIZE) {
-		width_mask = ACPI_INTEGER_MAX;
+		width_mask = ACPI_UINT64_MAX;
 	} else {
 		width_mask =
 		    ACPI_MASK_BITS_ABOVE(obj_desc->common_field.
diff --git a/drivers/acpi/acpica/exmisc.c b/drivers/acpi/acpica/exmisc.c
index d29e542..c5bb1ee 100644
--- a/drivers/acpi/acpica/exmisc.c
+++ b/drivers/acpi/acpica/exmisc.c
@@ -409,8 +409,7 @@ acpi_ex_do_concatenate(union acpi_operand_object *operand0,
  *
  ******************************************************************************/
 
-acpi_integer
-acpi_ex_do_math_op(u16 opcode, acpi_integer integer0, acpi_integer integer1)
+u64 acpi_ex_do_math_op(u16 opcode, u64 integer0, u64 integer1)
 {
 
 	ACPI_FUNCTION_ENTRY();
@@ -498,8 +497,7 @@ acpi_ex_do_math_op(u16 opcode, acpi_integer integer0, acpi_integer integer1)
 
 acpi_status
 acpi_ex_do_logical_numeric_op(u16 opcode,
-			      acpi_integer integer0,
-			      acpi_integer integer1, u8 * logical_result)
+			      u64 integer0, u64 integer1, u8 *logical_result)
 {
 	acpi_status status = AE_OK;
 	u8 local_result = FALSE;
@@ -564,8 +562,8 @@ acpi_ex_do_logical_op(u16 opcode,
 		      union acpi_operand_object *operand1, u8 * logical_result)
 {
 	union acpi_operand_object *local_operand1 = operand1;
-	acpi_integer integer0;
-	acpi_integer integer1;
+	u64 integer0;
+	u64 integer1;
 	u32 length0;
 	u32 length1;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 2b2128e..99adbab 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -261,8 +261,8 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 	union acpi_operand_object *return_desc2 = NULL;
 	u32 temp32;
 	u32 i;
-	acpi_integer power_of_ten;
-	acpi_integer digit;
+	u64 power_of_ten;
+	u64 digit;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_1A_1T_1R,
 				acpi_ps_get_opcode_name(walk_state->opcode));
@@ -362,7 +362,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 				/* Sum the digit into the result with the current power of 10 */
 
 				return_desc->integer.value +=
-				    (((acpi_integer) temp32) * power_of_ten);
+				    (((u64) temp32) * power_of_ten);
 
 				/* Shift to next BCD digit */
 
@@ -392,7 +392,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 				 * remainder from above
 				 */
 				return_desc->integer.value |=
-				    (((acpi_integer) temp32) << ACPI_MUL_4(i));
+				    (((u64) temp32) << ACPI_MUL_4(i));
 			}
 
 			/* Overflow if there is any data left in Digit */
@@ -439,7 +439,7 @@ acpi_status acpi_ex_opcode_1A_1T_1R(struct acpi_walk_state *walk_state)
 
 			/* The object exists in the namespace, return TRUE */
 
-			return_desc->integer.value = ACPI_INTEGER_MAX;
+			return_desc->integer.value = ACPI_UINT64_MAX;
 			goto cleanup;
 
 		default:
@@ -589,7 +589,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 	union acpi_operand_object *return_desc = NULL;
 	acpi_status status = AE_OK;
 	u32 type;
-	acpi_integer value;
+	u64 value;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_1A_0T_1R,
 				acpi_ps_get_opcode_name(walk_state->opcode));
@@ -610,7 +610,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		 * return_desc->Integer.Value is initially == 0 (FALSE) from above.
 		 */
 		if (!operand[0]->integer.value) {
-			return_desc->integer.value = ACPI_INTEGER_MAX;
+			return_desc->integer.value = ACPI_UINT64_MAX;
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/exoparg2.c b/drivers/acpi/acpica/exoparg2.c
index ea11502..22841bb 100644
--- a/drivers/acpi/acpica/exoparg2.c
+++ b/drivers/acpi/acpica/exoparg2.c
@@ -282,7 +282,7 @@ acpi_status acpi_ex_opcode_2A_1T_1R(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object **operand = &walk_state->operands[0];
 	union acpi_operand_object *return_desc = NULL;
-	acpi_integer index;
+	u64 index;
 	acpi_status status = AE_OK;
 	acpi_size length;
 
@@ -584,7 +584,7 @@ acpi_status acpi_ex_opcode_2A_0T_1R(struct acpi_walk_state *walk_state)
 	 * Default is FALSE (zero)
 	 */
 	if (logical_result) {
-		return_desc->integer.value = ACPI_INTEGER_MAX;
+		return_desc->integer.value = ACPI_UINT64_MAX;
 	}
 
       cleanup:
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 25d1cd3..8bb1012 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -148,7 +148,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 	union acpi_operand_object *return_desc = NULL;
 	char *buffer = NULL;
 	acpi_status status = AE_OK;
-	acpi_integer index;
+	u64 index;
 	acpi_size length;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_3A_1T_1R,
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index 580abbd..f256b6a 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -218,7 +218,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 	union acpi_operand_object **operand = &walk_state->operands[0];
 	union acpi_operand_object *return_desc = NULL;
 	acpi_status status = AE_OK;
-	acpi_integer index;
+	u64 index;
 	union acpi_operand_object *this_element;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_6A_0T_1R,
@@ -253,9 +253,9 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		}
 
 		/* Create an integer for the return value */
-		/* Default return value is ACPI_INTEGER_MAX if no match found */
+		/* Default return value is ACPI_UINT64_MAX if no match found */
 
-		return_desc = acpi_ut_create_integer_object(ACPI_INTEGER_MAX);
+		return_desc = acpi_ut_create_integer_object(ACPI_UINT64_MAX);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
@@ -270,7 +270,7 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		 *
 		 * Upon finding a match, the loop will terminate via "break" at
 		 * the bottom.  If it terminates "normally", match_value will be
-		 * ACPI_INTEGER_MAX (Ones) (its initial value) indicating that no
+		 * ACPI_UINT64_MAX (Ones) (its initial value) indicating that no
 		 * match was found.
 		 */
 		for (; index < operand[0]->package.count; index++) {
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 0cd88f6..486b2e5 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -70,7 +70,7 @@ acpi_status
 acpi_ex_system_memory_space_handler(u32 function,
 				    acpi_physical_address address,
 				    u32 bit_width,
-				    acpi_integer * value,
+				    u64 *value,
 				    void *handler_context, void *region_context)
 {
 	acpi_status status = AE_OK;
@@ -115,8 +115,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	 * Hardware does not support non-aligned data transfers, we must verify
 	 * the request.
 	 */
-	(void)acpi_ut_short_divide((acpi_integer) address, length, NULL,
-				   &remainder);
+	(void)acpi_ut_short_divide((u64) address, length, NULL, &remainder);
 	if (remainder != 0) {
 		return_ACPI_STATUS(AE_AML_ALIGNMENT);
 	}
@@ -128,10 +127,9 @@ acpi_ex_system_memory_space_handler(u32 function,
 	 *    2) Address beyond the current mapping?
 	 */
 	if ((address < mem_info->mapped_physical_address) ||
-	    (((acpi_integer) address + length) > ((acpi_integer)
-						  mem_info->
-						  mapped_physical_address +
-						  mem_info->mapped_length))) {
+	    (((u64) address + length) > ((u64)
+					 mem_info->mapped_physical_address +
+					 mem_info->mapped_length))) {
 		/*
 		 * The request cannot be resolved by the current memory mapping;
 		 * Delete the existing mapping and create a new one.
@@ -193,8 +191,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 	 * access
 	 */
 	logical_addr_ptr = mem_info->mapped_logical_address +
-	    ((acpi_integer) address -
-	     (acpi_integer) mem_info->mapped_physical_address);
+	    ((u64) address - (u64) mem_info->mapped_physical_address);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "System-Memory (width %d) R/W %d Address=%8.8X%8.8X\n",
@@ -215,19 +212,19 @@ acpi_ex_system_memory_space_handler(u32 function,
 		*value = 0;
 		switch (bit_width) {
 		case 8:
-			*value = (acpi_integer) ACPI_GET8(logical_addr_ptr);
+			*value = (u64) ACPI_GET8(logical_addr_ptr);
 			break;
 
 		case 16:
-			*value = (acpi_integer) ACPI_GET16(logical_addr_ptr);
+			*value = (u64) ACPI_GET16(logical_addr_ptr);
 			break;
 
 		case 32:
-			*value = (acpi_integer) ACPI_GET32(logical_addr_ptr);
+			*value = (u64) ACPI_GET32(logical_addr_ptr);
 			break;
 
 		case 64:
-			*value = (acpi_integer) ACPI_GET64(logical_addr_ptr);
+			*value = (u64) ACPI_GET64(logical_addr_ptr);
 			break;
 
 		default:
@@ -291,7 +288,7 @@ acpi_status
 acpi_ex_system_io_space_handler(u32 function,
 				acpi_physical_address address,
 				u32 bit_width,
-				acpi_integer * value,
+				u64 *value,
 				void *handler_context, void *region_context)
 {
 	acpi_status status = AE_OK;
@@ -350,7 +347,7 @@ acpi_status
 acpi_ex_pci_config_space_handler(u32 function,
 				 acpi_physical_address address,
 				 u32 bit_width,
-				 acpi_integer * value,
+				 u64 *value,
 				 void *handler_context, void *region_context)
 {
 	acpi_status status = AE_OK;
@@ -425,7 +422,7 @@ acpi_status
 acpi_ex_cmos_space_handler(u32 function,
 			   acpi_physical_address address,
 			   u32 bit_width,
-			   acpi_integer * value,
+			   u64 *value,
 			   void *handler_context, void *region_context)
 {
 	acpi_status status = AE_OK;
@@ -457,7 +454,7 @@ acpi_status
 acpi_ex_pci_bar_space_handler(u32 function,
 			      acpi_physical_address address,
 			      u32 bit_width,
-			      acpi_integer * value,
+			      u64 *value,
 			      void *handler_context, void *region_context)
 {
 	acpi_status status = AE_OK;
@@ -489,7 +486,7 @@ acpi_status
 acpi_ex_data_table_space_handler(u32 function,
 				 acpi_physical_address address,
 				 u32 bit_width,
-				 acpi_integer * value,
+				 u64 *value,
 				 void *handler_context, void *region_context)
 {
 	ACPI_FUNCTION_TRACE(ex_data_table_space_handler);
diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index c6cb604..e11b6cb 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -193,7 +193,7 @@ acpi_status acpi_ex_system_do_stall(u32 how_long)
  *
  ******************************************************************************/
 
-acpi_status acpi_ex_system_do_suspend(acpi_integer how_long)
+acpi_status acpi_ex_system_do_suspend(u64 how_long)
 {
 	ACPI_FUNCTION_ENTRY();
 
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 0f2ce9c..74c24d5 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -67,7 +67,7 @@
 ACPI_MODULE_NAME("exutils")
 
 /* Local prototypes */
-static u32 acpi_ex_digits_needed(acpi_integer value, u32 base);
+static u32 acpi_ex_digits_needed(u64 value, u32 base);
 
 #ifndef ACPI_NO_METHOD_EXECUTION
 /*******************************************************************************
@@ -230,7 +230,7 @@ void acpi_ex_truncate_for32bit_table(union acpi_operand_object *obj_desc)
 		 * We are running a method that exists in a 32-bit ACPI table.
 		 * Truncate the value to 32 bits by zeroing out the upper 32-bit field
 		 */
-		obj_desc->integer.value &= (acpi_integer) ACPI_UINT32_MAX;
+		obj_desc->integer.value &= (u64) ACPI_UINT32_MAX;
 	}
 }
 
@@ -327,14 +327,14 @@ void acpi_ex_release_global_lock(u32 field_flags)
  *
  ******************************************************************************/
 
-static u32 acpi_ex_digits_needed(acpi_integer value, u32 base)
+static u32 acpi_ex_digits_needed(u64 value, u32 base)
 {
 	u32 num_digits;
-	acpi_integer current_value;
+	u64 current_value;
 
 	ACPI_FUNCTION_TRACE(ex_digits_needed);
 
-	/* acpi_integer is unsigned, so we don't worry about a '-' prefix */
+	/* u64 is unsigned, so we don't worry about a '-' prefix */
 
 	if (value == 0) {
 		return_UINT32(1);
@@ -370,7 +370,7 @@ static u32 acpi_ex_digits_needed(acpi_integer value, u32 base)
  *
  ******************************************************************************/
 
-void acpi_ex_eisa_id_to_string(char *out_string, acpi_integer compressed_id)
+void acpi_ex_eisa_id_to_string(char *out_string, u64 compressed_id)
 {
 	u32 swapped_id;
 
@@ -394,10 +394,10 @@ void acpi_ex_eisa_id_to_string(char *out_string, acpi_integer compressed_id)
 	    (char)(0x40 + (((unsigned long)swapped_id >> 26) & 0x1F));
 	out_string[1] = (char)(0x40 + ((swapped_id >> 21) & 0x1F));
 	out_string[2] = (char)(0x40 + ((swapped_id >> 16) & 0x1F));
-	out_string[3] = acpi_ut_hex_to_ascii_char((acpi_integer)swapped_id, 12);
-	out_string[4] = acpi_ut_hex_to_ascii_char((acpi_integer)swapped_id, 8);
-	out_string[5] = acpi_ut_hex_to_ascii_char((acpi_integer)swapped_id, 4);
-	out_string[6] = acpi_ut_hex_to_ascii_char((acpi_integer)swapped_id, 0);
+	out_string[3] = acpi_ut_hex_to_ascii_char((u64) swapped_id, 12);
+	out_string[4] = acpi_ut_hex_to_ascii_char((u64) swapped_id, 8);
+	out_string[5] = acpi_ut_hex_to_ascii_char((u64) swapped_id, 4);
+	out_string[6] = acpi_ut_hex_to_ascii_char((u64) swapped_id, 0);
 	out_string[7] = 0;
 }
 
@@ -418,7 +418,7 @@ void acpi_ex_eisa_id_to_string(char *out_string, acpi_integer compressed_id)
  *
  ******************************************************************************/
 
-void acpi_ex_integer_to_string(char *out_string, acpi_integer value)
+void acpi_ex_integer_to_string(char *out_string, u64 value)
 {
 	u32 count;
 	u32 digits_needed;
diff --git a/drivers/acpi/acpica/hwtimer.c b/drivers/acpi/acpica/hwtimer.c
index ce0cbbc..1ef8e0b 100644
--- a/drivers/acpi/acpica/hwtimer.c
+++ b/drivers/acpi/acpica/hwtimer.c
@@ -140,7 +140,7 @@ acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed)
 {
 	acpi_status status;
 	u32 delta_ticks;
-	acpi_integer quotient;
+	u64 quotient;
 
 	ACPI_FUNCTION_TRACE(acpi_get_timer_duration);
 
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 6aa6a1a..00493e1 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -403,7 +403,7 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 1 byte from the AML stream */
 
 		opcode = AML_BYTE_OP;
-		arg->common.value.integer = (acpi_integer) * aml;
+		arg->common.value.integer = (u64) *aml;
 		length = 1;
 		break;
 
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 61a038d..f2ee3b5 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -182,7 +182,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 
 	/*
 	 * Loop through the ACPI_INTERNAL_OBJECTS - Each object should be a
-	 * package that in turn contains an acpi_integer Address, a u8 Pin,
+	 * package that in turn contains an u64 Address, a u8 Pin,
 	 * a Name, and a u8 source_index.
 	 */
 	top_object_list = package_object->package.elements;
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index e156915..9835106 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -460,8 +460,7 @@ ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
 void
 acpi_ut_value_exit(u32 line_number,
 		   const char *function_name,
-		   const char *module_name,
-		   u32 component_id, acpi_integer value)
+		   const char *module_name, u32 component_id, u64 value)
 {
 
 	acpi_debug_print(ACPI_LV_FUNCTIONS,
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index f4c5ee8..7f5e734 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -348,7 +348,7 @@ acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 acpi_status
 acpi_ut_evaluate_numeric_object(char *object_name,
 				struct acpi_namespace_node *device_node,
-				acpi_integer *value)
+				u64 *value)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 49286a3..eda3e65 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -234,7 +234,7 @@ static const char acpi_gbl_hex_to_ascii[] = {
  *
  ******************************************************************************/
 
-char acpi_ut_hex_to_ascii_char(acpi_integer integer, u32 position)
+char acpi_ut_hex_to_ascii_char(u64 integer, u32 position)
 {
 
 	return (acpi_gbl_hex_to_ascii[(integer >> position) & 0xF]);
diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 7cfa1d8..35059a1 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -70,9 +70,8 @@ ACPI_MODULE_NAME("utmath")
  *
  ******************************************************************************/
 acpi_status
-acpi_ut_short_divide(acpi_integer dividend,
-		     u32 divisor,
-		     acpi_integer * out_quotient, u32 * out_remainder)
+acpi_ut_short_divide(u64 dividend,
+		     u32 divisor, u64 *out_quotient, u32 *out_remainder)
 {
 	union uint64_overlay dividend_ovl;
 	union uint64_overlay quotient;
@@ -126,9 +125,8 @@ acpi_ut_short_divide(acpi_integer dividend,
  ******************************************************************************/
 
 acpi_status
-acpi_ut_divide(acpi_integer in_dividend,
-	       acpi_integer in_divisor,
-	       acpi_integer * out_quotient, acpi_integer * out_remainder)
+acpi_ut_divide(u64 in_dividend,
+	       u64 in_divisor, u64 *out_quotient, u64 *out_remainder)
 {
 	union uint64_overlay dividend;
 	union uint64_overlay divisor;
@@ -199,9 +197,8 @@ acpi_ut_divide(acpi_integer in_dividend,
 		 * The 64-bit remainder must be generated.
 		 */
 		partial1 = quotient.part.lo * divisor.part.hi;
-		partial2.full =
-		    (acpi_integer) quotient.part.lo * divisor.part.lo;
-		partial3.full = (acpi_integer) partial2.part.hi + partial1;
+		partial2.full = (u64) quotient.part.lo * divisor.part.lo;
+		partial3.full = (u64) partial2.part.hi + partial1;
 
 		remainder.part.hi = partial3.part.lo;
 		remainder.part.lo = partial2.part.lo;
@@ -257,9 +254,8 @@ acpi_ut_divide(acpi_integer in_dividend,
  *
  ******************************************************************************/
 acpi_status
-acpi_ut_short_divide(acpi_integer in_dividend,
-		     u32 divisor,
-		     acpi_integer * out_quotient, u32 * out_remainder)
+acpi_ut_short_divide(u64 in_dividend,
+		     u32 divisor, u64 *out_quotient, u32 *out_remainder)
 {
 
 	ACPI_FUNCTION_TRACE(ut_short_divide);
@@ -284,9 +280,8 @@ acpi_ut_short_divide(acpi_integer in_dividend,
 }
 
 acpi_status
-acpi_ut_divide(acpi_integer in_dividend,
-	       acpi_integer in_divisor,
-	       acpi_integer * out_quotient, acpi_integer * out_remainder)
+acpi_ut_divide(u64 in_dividend,
+	       u64 in_divisor, u64 *out_quotient, u64 *out_remainder)
 {
 	ACPI_FUNCTION_TRACE(ut_divide);
 
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index fb55924..32982e2 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -724,13 +724,12 @@ acpi_name acpi_ut_repair_name(char *name)
  *
  ******************************************************************************/
 
-acpi_status
-acpi_ut_strtoul64(char *string, u32 base, acpi_integer * ret_integer)
+acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer)
 {
 	u32 this_digit = 0;
-	acpi_integer return_value = 0;
-	acpi_integer quotient;
-	acpi_integer dividend;
+	u64 return_value = 0;
+	u64 quotient;
+	u64 dividend;
 	u32 to_integer_op = (base == ACPI_ANY_BASE);
 	u32 mode32 = (acpi_gbl_integer_byte_width == 4);
 	u8 valid_digits = 0;
@@ -844,9 +843,8 @@ acpi_ut_strtoul64(char *string, u32 base, acpi_integer * ret_integer)
 
 		/* Divide the digit into the correct position */
 
-		(void)
-		    acpi_ut_short_divide((dividend - (acpi_integer) this_digit),
-					 base, &quotient, NULL);
+		(void)acpi_ut_short_divide((dividend - (u64) this_digit),
+					   base, &quotient, NULL);
 
 		if (return_value > quotient) {
 			if (to_integer_op) {
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index c7e9431..b396854 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -196,7 +196,7 @@ acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
 
 void acpi_os_wait_events_complete(void *context);
 
-void acpi_os_sleep(acpi_integer milliseconds);
+void acpi_os_sleep(u64 milliseconds);
 
 void acpi_os_stall(u32 microseconds);
 
@@ -227,7 +227,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id,
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
-				u32 reg, acpi_integer value, u32 width);
+				u32 reg, u64 value, u32 width);
 
 /*
  * Interim function needed for PCI IRQ routing
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index dc6302e..e552635 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -397,7 +397,7 @@ struct acpi_resource {
 struct acpi_pci_routing_table {
 	u32 length;
 	u32 pin;
-	acpi_integer address;	/* here for 64-bit alignment */
+	u64 address;		/* here for 64-bit alignment */
 	u32 source_index;
 	char source[4];		/* pad to 64 bits so sizeof() works in all cases */
 };
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4e65c20..07f2cdc 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -390,14 +390,6 @@ struct uint32_struct {
 	u32 hi;
 };
 
-/*
- * Acpi integer width. In ACPI version 1, integers are 32 bits. In ACPI
- * version 2, integers are 64 bits. Note that this pertains to the ACPI integer
- * type only, not other integers used in the implementation of the ACPI CA
- * subsystem.
- */
-typedef unsigned long long acpi_integer;
-#define ACPI_INTEGER_MAX                ACPI_UINT64_MAX
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
 
@@ -421,6 +413,19 @@ typedef unsigned long long acpi_integer;
 #define ACPI_WAIT_FOREVER               0xFFFF	/* u16, as per ACPI spec */
 #define ACPI_DO_NOT_WAIT                0
 
+/*
+ * Obsolete: Acpi integer width. In ACPI version 1 (1996), integers are 32 bits.
+ * In ACPI version 2 (2000) and later, integers are 64 bits. Note that this
+ * pertains to the ACPI integer type only, not to other integers used in the
+ * implementation of the ACPICA subsystem.
+ *
+ * 01/2010: This type is obsolete and has been removed from the entire ACPICA
+ * code base. It remains here for compatibility with device drivers that use
+ * the type. However, it will be removed in the future.
+ */
+typedef u64 acpi_integer;
+#define ACPI_INTEGER_MAX                ACPI_UINT64_MAX
+
 /*******************************************************************************
  *
  * Commonly used macros
@@ -801,7 +806,7 @@ union acpi_object {
 	acpi_object_type type;	/* See definition of acpi_ns_type for values */
 	struct {
 		acpi_object_type type;	/* ACPI_TYPE_INTEGER */
-		acpi_integer value;	/* The actual number */
+		u64 value;	/* The actual number */
 	} integer;
 
 	struct {
@@ -945,7 +950,7 @@ typedef
 acpi_status(*acpi_adr_space_handler) (u32 function,
 				      acpi_physical_address address,
 				      u32 bit_width,
-				      acpi_integer * value,
+				      u64 *value,
 				      void *handler_context,
 				      void *region_context);
 
@@ -1005,7 +1010,7 @@ struct acpi_device_info {
 	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
 	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
 	u32 current_status;	/* _STA value */
-	acpi_integer address;	/* _ADR value */
+	u64 address;	/* _ADR value */
 	struct acpica_device_id hardware_id;	/* _HID value */
 	struct acpica_device_id unique_id;	/* _UID value */
 	struct acpica_device_id_list compatible_id_list;	/* _CID list <must be last> */
-- 
1.6.0.6

