From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Revert "Headers: Deploy #pragma pack (push) and (pop)."
Date: Wed,  5 Mar 2014 14:12:01 +0800
Message-ID: <4646002a7ef1a008aff96731d8d696304ae5b415.1393999867.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13197 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaCEGMn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Mar 2014 01:12:43 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Robert Moore <Robert.Moore@intel.com>

From: Robert Moore <Robert.Moore@intel.com>

This reverts commit aae576e5faefa8ba70647efa320d4747b6375f1e.
Push and Pop are not portable "enough", and caused problems for
some ACPICA customers.

Conflicts:

	source/include/aclocal.h
	source/include/acutils.h

Signed-off-by: Robert Moore <Robert.Moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |    4 ----
 drivers/acpi/acpica/acdispat.h |    4 ----
 drivers/acpi/acpica/acevents.h |    3 ---
 drivers/acpi/acpica/acglobal.h |    4 ----
 drivers/acpi/acpica/achware.h  |    4 ----
 drivers/acpi/acpica/acinterp.h |    4 ----
 drivers/acpi/acpica/aclocal.h  |    4 ----
 drivers/acpi/acpica/acmacros.h |    4 ----
 drivers/acpi/acpica/acnamesp.h |    4 ----
 drivers/acpi/acpica/acobject.h |    4 +---
 drivers/acpi/acpica/acparser.h |    4 ----
 drivers/acpi/acpica/acpredef.h |    4 ----
 drivers/acpi/acpica/acresrc.h  |    4 ----
 drivers/acpi/acpica/acstruct.h |    4 ----
 drivers/acpi/acpica/actables.h |    4 ----
 drivers/acpi/acpica/acutils.h  |    4 ----
 drivers/acpi/acpica/amlcode.h  |    4 ----
 drivers/acpi/acpica/amlresrc.h |    4 ----
 include/acpi/acbuffer.h        |    4 ----
 include/acpi/acconfig.h        |    4 ----
 include/acpi/acexcep.h         |    4 ----
 include/acpi/acoutput.h        |    4 ----
 include/acpi/acpiosxf.h        |    4 ----
 include/acpi/acpixf.h          |    4 ----
 include/acpi/acrestyp.h        |    4 ----
 include/acpi/actbl.h           |    4 ----
 include/acpi/actbl1.h          |    6 +++---
 include/acpi/actbl2.h          |    6 +++---
 include/acpi/actbl3.h          |    6 +++---
 include/acpi/actypes.h         |    4 ----
 30 files changed, 10 insertions(+), 115 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index e9ab514..68a91eb 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -44,8 +44,6 @@
 #ifndef __ACDEBUG_H__
 #define __ACDEBUG_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 #define ACPI_DEBUG_BUFFER_SIZE  0x4000	/* 16K buffer for return objects */
 
 struct acpi_db_command_info {
@@ -284,6 +282,4 @@ struct acpi_namespace_node *acpi_db_local_ns_lookup(char *name);
 
 void acpi_db_uint32_to_hex_string(u32 value, char *buffer);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACDEBUG_H__ */
diff --git a/drivers/acpi/acpica/acdispat.h b/drivers/acpi/acpica/acdispat.h
index 6cdba27..d3e2cc3 100644
--- a/drivers/acpi/acpica/acdispat.h
+++ b/drivers/acpi/acpica/acdispat.h
@@ -44,8 +44,6 @@
 #ifndef _ACDISPAT_H_
 #define _ACDISPAT_H_
 
-#pragma pack(push)		/* Set default struct packing */
-
 #define NAMEOF_LOCAL_NTE    "__L0"
 #define NAMEOF_ARG_NTE      "__A0"
 
@@ -356,6 +354,4 @@ acpi_status
 acpi_ds_result_push(union acpi_operand_object *object,
 		    struct acpi_walk_state *walk_state);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* _ACDISPAT_H_ */
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 75f25ed..68ec61f 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -44,8 +44,6 @@
 #ifndef __ACEVENTS_H__
 #define __ACEVENTS_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * evevent
  */
@@ -253,5 +251,4 @@ u32 acpi_ev_install_sci_handler(void);
 acpi_status acpi_ev_remove_all_sci_handlers(void);
 
 ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_ev_terminate(void))
-#pragma pack(pop)		/* Restore original struct packing */
 #endif				/* __ACEVENTS_H__  */
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 6b45c44..49bbc71 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -44,8 +44,6 @@
 #ifndef __ACGLOBAL_H__
 #define __ACGLOBAL_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Ensure that the globals are actually defined and initialized only once.
  *
@@ -512,6 +510,4 @@ ACPI_INIT_GLOBAL(ACPI_FILE, acpi_gbl_debug_file, NULL);
 
 extern const struct ah_predefined_name asl_predefined_info[];
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACGLOBAL_H__ */
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 4a0e634..2ad2351 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -44,8 +44,6 @@
 #ifndef __ACHWARE_H__
 #define __ACHWARE_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* Values for the _SST predefined method */
 
 #define ACPI_SST_INDICATOR_OFF  0
@@ -149,6 +147,4 @@ acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACHWARE_H__ */
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index 186844a..b01f71c 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -44,8 +44,6 @@
 #ifndef __ACINTERP_H__
 #define __ACINTERP_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 #define ACPI_WALK_OPERANDS          (&(walk_state->operands [walk_state->num_operands -1]))
 
 /* Macros for tables used for debug output */
@@ -533,6 +531,4 @@ acpi_ex_data_table_space_handler(u32 function,
 				 u64 *value,
 				 void *handler_context, void *region_context);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __INTERP_H__ */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index fee53b5..52a21da 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -44,8 +44,6 @@
 #ifndef __ACLOCAL_H__
 #define __ACLOCAL_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 #define ACPI_SERIALIZED                 0xFF
@@ -1149,6 +1147,4 @@ struct ah_predefined_name {
 #endif
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACLOCAL_H__ */
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 9b0ce22..4bceb11 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -44,8 +44,6 @@
 #ifndef __ACMACROS_H__
 #define __ACMACROS_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Extract data using a pointer. Any more than a byte and we
  * get into potential aligment issues -- see the STORE macros below.
@@ -429,6 +427,4 @@
 
 #define ACPI_IS_OCTAL_DIGIT(d)              (((char)(d) >= '0') && ((char)(d) <= '7'))
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* ACMACROS_H */
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 751083d..ee1c040 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -44,8 +44,6 @@
 #ifndef __ACNAMESP_H__
 #define __ACNAMESP_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* To search the entire name space, pass this as search_base */
 
 #define ACPI_NS_ALL                 ((acpi_handle)0)
@@ -406,6 +404,4 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle);
 
 void acpi_ns_terminate(void);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACNAMESP_H__ */
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 7ce7e9f..1a4d618 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -44,8 +44,6 @@
 #ifndef _ACOBJECT_H
 #define _ACOBJECT_H
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*
@@ -458,6 +456,6 @@ union acpi_descriptor {
 	union acpi_parse_object op;
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
+#pragma pack()
 
 #endif				/* _ACOBJECT_H */
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 3d828be..6168b85 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -44,8 +44,6 @@
 #ifndef __ACPARSER_H__
 #define __ACPARSER_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 #define OP_HAS_RETURN_VALUE             1
 
 /* Variable number of arguments. This field must be 32 bits */
@@ -253,6 +251,4 @@ acpi_ps_sprint_op(char *buffer_start,
 
 void acpi_ps_show(union acpi_parse_object *op);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACPARSER_H__ */
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 08c359f..a48d713 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -44,8 +44,6 @@
 #ifndef __ACPREDEF_H__
 #define __ACPREDEF_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /******************************************************************************
  *
  * Return Package types
@@ -1088,6 +1086,4 @@ static const union acpi_predefined_info acpi_gbl_scope_names[] = {
 extern const union acpi_predefined_info acpi_gbl_resource_names[];
 #endif
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index be16da2..4b008e8 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -48,8 +48,6 @@
 
 #include "amlresrc.h"
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * If possible, pack the following structures to byte alignment, since we
  * don't care about performance for debug output. Two cases where we cannot
@@ -380,6 +378,4 @@ extern struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[];
 extern struct acpi_rsdump_info acpi_rs_dump_general_flags[];
 #endif
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACRESRC_H__ */
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index fbbc1ad..cf73461 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -44,8 +44,6 @@
 #ifndef __ACSTRUCT_H__
 #define __ACSTRUCT_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*****************************************************************************
@@ -246,6 +244,4 @@ struct acpi_walk_info {
 
 #define ACPI_DISPLAY_SHORT          (u8) 2
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif
diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actables.h
index 9b0f984..5fa4b20 100644
--- a/drivers/acpi/acpica/actables.h
+++ b/drivers/acpi/acpica/actables.h
@@ -44,8 +44,6 @@
 #ifndef __ACTABLES_H__
 #define __ACTABLES_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 acpi_status acpi_allocate_root_table(u32 initial_table_count);
 
 /*
@@ -131,6 +129,4 @@ acpi_tb_install_table(acpi_physical_address address,
 
 acpi_status acpi_tb_parse_root_table(acpi_physical_address rsdp_address);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACTABLES_H__ */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index df970ff..ceeec0b 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -44,8 +44,6 @@
 #ifndef _ACUTILS_H
 #define _ACUTILS_H
 
-#pragma pack(push)		/* Set default struct packing */
-
 extern const u8 acpi_gbl_resource_aml_sizes[];
 extern const u8 acpi_gbl_resource_aml_serial_bus_sizes[];
 
@@ -739,6 +737,4 @@ acpi_ut_method_error(const char *module_name,
 		     struct acpi_namespace_node *node,
 		     const char *path, acpi_status lookup_status);
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/amlcode.h b/drivers/acpi/acpica/amlcode.h
index 2db2710..5908cce 100644
--- a/drivers/acpi/acpica/amlcode.h
+++ b/drivers/acpi/acpica/amlcode.h
@@ -46,8 +46,6 @@
 #ifndef __AMLCODE_H__
 #define __AMLCODE_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* primary opcodes */
 
 #define AML_NULL_CHAR               (u16) 0x00
@@ -486,6 +484,4 @@ typedef enum {
 #define AML_METHOD_SERIALIZED       0x08
 #define AML_METHOD_SYNC_LEVEL       0xF0
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __AMLCODE_H__ */
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 334fbee..f3f8344 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -46,8 +46,6 @@
 #ifndef __AMLRESRC_H
 #define __AMLRESRC_H
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Resource descriptor tags, as defined in the ACPI specification.
  * Used to symbolically reference fields within a descriptor.
@@ -451,6 +449,4 @@ union aml_resource {
 	u8 byte_item;
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 960c76f..88cb477 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -44,8 +44,6 @@
 #ifndef __ACBUFFER_H__
 #define __ACBUFFER_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Contains buffer structures for these predefined names:
  * _FDE, _GRT, _GTM, _PLD, _SRT
@@ -234,6 +232,4 @@ struct acpi_pld_info {
 #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
 #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)	/* Offset 128+16=144, Len 16 */
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* ACBUFFER_H */
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index d8a0ba8..932a60d 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -44,8 +44,6 @@
 #ifndef _ACCONFIG_H
 #define _ACCONFIG_H
 
-#pragma pack(push)		/* Set default struct packing */
-
 /******************************************************************************
  *
  * Configuration options
@@ -231,6 +229,4 @@
 #define ACPI_DEBUGGER_COMMAND_PROMPT    '-'
 #define ACPI_DEBUGGER_EXECUTE_PROMPT    '%'
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* _ACCONFIG_H */
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index f0bcb96..8b06e4c 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -44,8 +44,6 @@
 #ifndef __ACEXCEP_H__
 #define __ACEXCEP_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* This module contains all possible exception codes for acpi_status */
 
 /*
@@ -379,6 +377,4 @@ static const struct acpi_exception_info acpi_gbl_exception_names_ctrl[] = {
 
 #endif				/* EXCEPTION_TABLE */
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACEXCEP_H__ */
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 247636f..1baae6e 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -44,8 +44,6 @@
 #ifndef __ACOUTPUT_H__
 #define __ACOUTPUT_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Debug levels and component IDs. These are used to control the
  * granularity of the output of the ACPI_DEBUG_PRINT macro -- on a
@@ -458,6 +456,4 @@
 
 #endif				/* ACPI_DEBUG_OUTPUT */
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACOUTPUT_H__ */
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a4a2cd3..f6f5f8a 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -49,8 +49,6 @@
 #include <acpi/platform/acenv.h>
 #include <acpi/actypes.h>
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* Types for acpi_os_execute */
 
 typedef enum {
@@ -401,6 +399,4 @@ char *acpi_os_get_next_filename(void *dir_handle);
 void acpi_os_close_directory(void *dir_handle);
 #endif
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACPIOSXF_H__ */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9f8b128..44f5e97 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -55,8 +55,6 @@
 
 extern u8 acpi_gbl_permanent_mmap;
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Globals that are publically available
  */
@@ -586,6 +584,4 @@ acpi_debug_print_raw(u32 requested_debug_level,
 		     u32 component_id, const char *format, ...);
 #endif
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACXFACE_H__ */
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 3c83a79..eb760ca 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -44,8 +44,6 @@
 #ifndef __ACRESTYP_H__
 #define __ACRESTYP_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*
  * Definitions for Resource Attributes
  */
@@ -612,6 +610,4 @@ struct acpi_pci_routing_table {
 	char source[4];		/* pad to 64 bits so sizeof() works in all cases */
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACRESTYP_H__ */
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index b32a33f..3b30e36 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -44,8 +44,6 @@
 #ifndef __ACTBL_H__
 #define __ACTBL_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*******************************************************************************
  *
  * Fundamental ACPI tables
@@ -406,6 +404,4 @@ struct acpi_table_desc {
 #define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
 #define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACTBL_H__ */
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b7f0b0c..212c65d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -44,8 +44,6 @@
 #ifndef __ACTBL1_H__
 #define __ACTBL1_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*******************************************************************************
  *
  * Additional ACPI Tables (1)
@@ -974,6 +972,8 @@ struct acpi_srat_x2apic_cpu_affinity {
 
 #define ACPI_SRAT_CPU_ENABLED       (1)	/* 00: Use affinity structure */
 
-#pragma pack(pop)		/* Restore original struct packing */
+/* Reset to default packing */
+
+#pragma pack()
 
 #endif				/* __ACTBL1_H__ */
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 89a2613..f337244 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -44,8 +44,6 @@
 #ifndef __ACTBL2_H__
 #define __ACTBL2_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*******************************************************************************
  *
  * Additional ACPI Tables (2)
@@ -1231,6 +1229,8 @@ struct acpi_table_wdrt {
 	u8 units;
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
+/* Reset to default packing */
+
+#pragma pack()
 
 #endif				/* __ACTBL2_H__ */
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 85ebeea..c2295cc 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -44,8 +44,6 @@
 #ifndef __ACTBL3_H__
 #define __ACTBL3_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /*******************************************************************************
  *
  * Additional ACPI Tables (3)
@@ -624,6 +622,8 @@ struct acpi_tpm2_control {
 	u64 response_address;
 };
 
-#pragma pack(pop)		/* Restore original struct packing */
+/* Reset to default packing */
+
+#pragma pack()
 
 #endif				/* __ACTBL3_H__ */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index c28573d..e763565 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -44,8 +44,6 @@
 #ifndef __ACTYPES_H__
 #define __ACTYPES_H__
 
-#pragma pack(push)		/* Set default struct packing */
-
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*
@@ -1225,6 +1223,4 @@ struct acpi_memory_list {
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
 
-#pragma pack(pop)		/* Restore original struct packing */
-
 #endif				/* __ACTYPES_H__ */
-- 
1.7.10

