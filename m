From: Carl Spalletta <cspalletta-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
Date: Tue, 20 Jul 2004 16:04:31 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040720230431.72586.qmail@web53805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: en.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch removes 55 prototypes of nonexistent functions.

N.B.
 Due to my inability to cut and paste the tab chars embedded in file to be patched (they are
 picked up as sequences of spaces), you must either a) 'unexpand --first-only' the enclosed patch
 to recover the tab chars from the original file, or b) apply with 'patch --ignore-whitespace'.
 The latter option can't hurt since we are only removing lines from the file, not adding.

Signed-off-by: Carl Spalletta <cspalletta-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>

diff -ru /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h
/usr/src/linux-2.6.7-new/include/acpi/acdisasm.h
--- /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h   2004-06-15 22:19:26.000000000 -0700
+++ /usr/src/linux-2.6.7-new/include/acpi/acdisasm.h    2004-07-18 20:10:42.000000000 -0700
@@ -86,317 +86,14 @@
        u32                                 level,
        void                                *context);

-
-/*
- * dmwalk
- */
-
-void
-acpi_dm_walk_parse_tree (
-       union acpi_parse_object         *op,
-       asl_walk_callback               descending_callback,
-       asl_walk_callback               ascending_callback,
-       void                            *context);
-
-acpi_status
-acpi_dm_descending_op (
-       union acpi_parse_object         *op,
-       u32                             level,
-       void                            *context);
-
-acpi_status
-acpi_dm_ascending_op (
-       union acpi_parse_object         *op,
-       u32                             level,
-       void                            *context);
-
-
-/*
- * dmopcode
- */
-
-void
-acpi_dm_validate_name (
-       char                            *name,
-       union acpi_parse_object         *op);
-
-u32
-acpi_dm_dump_name (
-       char                            *name);
-
-void
-acpi_dm_unicode (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_disassemble (
-       struct acpi_walk_state          *walk_state,
-       union acpi_parse_object         *origin,
-       u32                             num_opcodes);
-
-void
-acpi_dm_namestring (
-       char                            *name);
-
-void
-acpi_dm_display_path (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_disassemble_one_op (
-       struct acpi_walk_state          *walk_state,
-       struct acpi_op_walk_info        *info,
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_decode_internal_object (
-       union acpi_operand_object       *obj_desc);
-
-u32
-acpi_dm_block_type (
-       union acpi_parse_object         *op);
-
-u32
-acpi_dm_list_type (
-       union acpi_parse_object         *op);
-
-acpi_status
-acpi_ps_display_object_pathname (
-       struct acpi_walk_state          *walk_state,
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_method_flags (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_field_flags (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_address_space (
-       u8                              space_id);
-
-void
-acpi_dm_region_flags (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_match_op (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_match_keyword (
-       union acpi_parse_object         *op);
-
-u8
-acpi_dm_comma_if_list_member (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_comma_if_field_member (
-       union acpi_parse_object         *op);
-
-
 /*
  * dmobject
  */

 void
-acpi_dm_decode_node (
-       struct acpi_namespace_node      *node);
-
-void
-acpi_dm_display_internal_object (
-       union acpi_operand_object       *obj_desc,
-       struct acpi_walk_state          *walk_state);
-
-void
-acpi_dm_display_arguments (
-       struct acpi_walk_state          *walk_state);
-
-void
-acpi_dm_display_locals (
-       struct acpi_walk_state          *walk_state);
-
-void
 acpi_dm_dump_method_info (
        acpi_status                     status,
        struct acpi_walk_state          *walk_state,
        union acpi_parse_object         *op);

-
-/*
- * dmbuffer
- */
-
-void
-acpi_is_eisa_id (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_eisa_id (
-       u32                             encoded_id);
-
-u8
-acpi_dm_is_unicode_buffer (
-       union acpi_parse_object         *op);
-
-u8
-acpi_dm_is_string_buffer (
-       union acpi_parse_object         *op);
-
-
-/*
- * dmresrc
- */
-
-void
-acpi_dm_disasm_byte_list (
-       u32                             level,
-       u8                              *byte_data,
-       u32                             byte_count);
-
-void
-acpi_dm_byte_list (
-       struct acpi_op_walk_info        *info,
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_resource_descriptor (
-       struct acpi_op_walk_info        *info,
-       u8                              *byte_data,
-       u32                             byte_count);
-
-u8
-acpi_dm_is_resource_descriptor (
-       union acpi_parse_object         *op);
-
-void
-acpi_dm_indent (
-       u32                             level);
-
-void
-acpi_dm_bit_list (
-       u16                             mask);
-
-void
-acpi_dm_decode_attribute (
-       u8                              attribute);
-
-/*
- * dmresrcl
- */
-
-void
-acpi_dm_io_flags (
-               u8                          flags);
-
-void
-acpi_dm_memory_flags (
-       u8                              flags,
-       u8                              specific_flags);
-
-void
-acpi_dm_word_descriptor (
-       struct asl_word_address_desc    *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_dword_descriptor (
-       struct asl_dword_address_desc   *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_qword_descriptor (
-       struct asl_qword_address_desc   *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_memory24_descriptor (
-       struct asl_memory_24_desc       *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_memory32_descriptor (
-       struct asl_memory_32_desc       *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_fixed_mem32_descriptor (
-       struct asl_fixed_memory_32_desc *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_generic_register_descriptor (
-       struct asl_general_register_desc *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_interrupt_descriptor (
-       struct asl_extended_xrupt_desc *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_vendor_large_descriptor (
-       struct asl_large_vendor_desc    *resource,
-       u32                             length,
-       u32                             level);
-
-
-/*
- * dmresrcs
- */
-
-void
-acpi_dm_irq_descriptor (
-       struct asl_irq_format_desc      *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_dma_descriptor (
-       struct asl_dma_format_desc      *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_io_descriptor (
-       struct asl_io_port_desc         *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_fixed_io_descriptor (
-       struct asl_fixed_io_port_desc   *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_start_dependent_descriptor (
-       struct asl_start_dependent_desc *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_end_dependent_descriptor (
-       struct asl_start_dependent_desc *resource,
-       u32                             length,
-       u32                             level);
-
-void
-acpi_dm_vendor_small_descriptor (
-       struct asl_small_vendor_desc    *resource,
-       u32                             length,
-       u32                             level);
-
-
 #endif  /* __ACDISASM_H__ */



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
