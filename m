From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Console freeze on undocking - "Failed to acquire semaphore"
Date: Fri, 10 Oct 2003 17:55:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031010165511.GA23633@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm using a Dell Latitude X300 with 2.4.23-pre6. I had to make a couple 
of adjustments to the DSDT in order to get battery status working, but 
that seems happy now. My only issue now is that undocking the laptop 
from the CD base results in the console hanging - I'm still able to ssh 
in, and the keyboard generates interrups, but keypresses result in 
nothing happening. I get a "Failed to acquire semaphore" message from 
ACPI at the same time, and it works fine if I boot without ACPI, so.
I've attached fairly verbose debugging output - the USB disconnect 
happens as it's undocked, and the ACPI stuff is complete from that point 
until the hang.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=new

Oct 10 17:25:38 lewis kernel: usb.c: USB disconnect on device 00:1d.7-3 address 2
Oct 10 17:25:42 lewis kernel: ns_lookup             : Simple Pathname (1 segment, Flags=3)
Oct 10 17:25:42 lewis kernel:   nsdump-0081 [52] ns_print_pathname     : [TRP0]
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \_GPE._L14 (c13fc928) For [TRP0] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0148 [54] ns_search_node        : Name [TRP0] (Untyped) not found in search in scope [_L14] c13fc928 first child 00000000
Oct 10 17:25:42 lewis kernel: nssearch-0214 [54] ns_search_parent_tree : Searching parent for TRP0
Oct 10 17:25:42 lewis kernel: nssearch-0100 [55] ns_search_node        : Searching \_GPE (c12bd5a8) For [TRP0] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0148 [55] ns_search_node        : Name [TRP0] (Untyped) not found in search in scope [_GPE] c12bd5a8 first child c13fc728
Oct 10 17:25:42 lewis kernel: nssearch-0100 [55] ns_search_node        : Searching \ (c0311e9c) For [TRP0] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [55] ns_search_node        : Name [TRP0] (region_field) c12ba9a8 found in scope [\___] c0311e9c
Oct 10 17:25:42 lewis kernel: dswstate-0509 [51] ds_obj_stack_push     : Obj=c12ba9a8 [region_field] State=c12bb428 #Ops=2
Oct 10 17:25:42 lewis kernel:  dsutils-0598 [50] ds_create_operands    : Arg #1 (c13ffea8) done, Arg1=c13ffe28
Oct 10 17:25:42 lewis kernel: dswstate-0428 [49] ds_result_stack_pop   : Result=c12baea8 remaining_results=0 State=c12bb428
Oct 10 17:25:42 lewis kernel:  exresop-0164 [50] ex_resolve_operands   : Opcode 70 [Store] operand_types=2F 
Oct 10 17:25:42 lewis kernel: exresolv-0113 [51] ex_resolve_to_value   : Resolved object c13a8828
Oct 10 17:25:42 lewis kernel:   exdump-0430 [49] ex_dump_operands      : ************* Operand Stack Contents (Opcode [Store], 2 Operands)
Oct 10 17:25:42 lewis kernel:   exdump-0101 [49] ex_dump_operand       : c12ba9a8 NS Node:  0  TRP0 region_field c12ba9a8 Rgn [IO_T]Off 00 Len 08 Acc 01
Oct 10 17:25:42 lewis kernel:       Attached Object c13e2428: (Ptr to ACPI Object type region_field, 11)
Oct 10 17:25:42 lewis kernel: 
Oct 10 17:25:42 lewis kernel: Offset Value
Oct 10 17:25:42 lewis kernel: 00000  88 11 01 00 00 00 00 00 20 01 00 01 08 00 00 00 ........ .......
Oct 10 17:25:42 lewis kernel: 00010  00 00 00 00 00 08 00 00 00 00 00 00 A8 A9 2B C1 ..............+.
Oct 10 17:25:42 lewis kernel: 00020  A8 A8 2B C1 00 00 00 00 
Oct 10 17:25:42 lewis kernel:       Attached Object c12ba8a8: (Ptr to ACPI Object type Region, A)
Oct 10 17:25:42 lewis kernel: 
Oct 10 17:25:42 lewis kernel: Offset Value
Oct 10 17:25:42 lewis kernel: 00000  88 0A 02 00 28 A9 2B C1 0C 01 00 00 A8 54 3D C1 ....(.+......T=.
Oct 10 17:25:42 lewis kernel: 00010  28 A8 2B C1 28 A5 2B C1 10 00 00 00 00 08 00 00 (.+.(.+.........
Oct 10 17:25:42 lewis kernel: 00020  00 00 00 00 00 00 00 00 
Oct 10 17:25:42 lewis kernel: 
Oct 10 17:25:42 lewis kernel:   exdump-0114 [49] ex_dump_operand       : c13a8828 Integer 0000000000000000
Oct 10 17:25:42 lewis kernel:   exdump-0445 [49] ex_dump_operands      : ************* Stack dump from dswexec(409), after ex_resolve_operands
Oct 10 17:25:42 lewis kernel:  exstore-0433 [52] ex_store_object_to_nod: Storing c13a8828(Integer) into node c12ba9a8(region_field)
Oct 10 17:25:42 lewis kernel:  exfield-0339 [53] ex_write_data_to_field: Obj=c13e2428 Type=11 Buf=c13a8834 Len=8
Oct 10 17:25:42 lewis kernel:  exfield-0344 [53] ex_write_data_to_field: field_read: bit_len=8 bit_off=0 byte_off=0
Oct 10 17:25:42 lewis kernel:  exfldio-0959 [54] ex_insert_into_field  : byte_len=1, datum_len=1, byte_gran=1
Oct 10 17:25:42 lewis kernel:  exfldio-0241 [57] ex_access_region      : [WRITE] Region[SystemIO-1] Access 1 Base:Off 0:0 at 0000000000000800
Oct 10 17:25:42 lewis kernel: evregion-0325 [58] ev_address_space_dispa: Handler c13d54a8 (@c01817c8) Address 0000000000000800 [SystemIO]
Oct 10 17:25:42 lewis kernel: exregion-0294 [59] ex_system_io_space_han: system_iO 1 (8 width) Address=0000000000000800
Oct 10 17:25:42 lewis kernel:  exfldio-0498 [56] ex_field_datum_io     : Value Written=0000000000000000
Oct 10 17:25:42 lewis kernel:  exfldio-0593 [55] ex_write_with_update_r: Mask FFFFFFFFFFFFFFFF datum_offset 0 Value 0000000000000000, merged_value 0000000000000000
Oct 10 17:25:42 lewis kernel: dswstate-0353 [49] ds_result_push        : Obj=c13a8828 [Integer] State=c12bb428 Num=1 Cur=0
Oct 10 17:25:42 lewis kernel:  dsutils-0197 [51] ds_is_result_used     : Result of [Store] not used by Parent [If] Op=c12ba4a8
Oct 10 17:25:42 lewis kernel: dswstate-0228 [50] ds_result_pop         : Obj=c13a8828 [Integer] Index=0 State=c12bb428 Num=0
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [53] ut_acquire_from_cache : Object c12baea8 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12baea8 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12bb028 from Tree Walk Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c13f8928 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [51] ds_result_stack_push  : Results=c13f8928 State=c12bb028
Oct 10 17:25:42 lewis kernel:  psscope-0254 [49] ps_pop_scope          : Popped Op c13f8d28 Args FFFFFFFD
Oct 10 17:25:42 lewis kernel:  psparse-0967 [48] ps_parse_loop         : Popped scope, Op=c13f8d28
Oct 10 17:25:42 lewis kernel: dsopcode-0962 [49] ds_exec_end_control_op: [IF_OP] Op=c13f8d28
Oct 10 17:25:42 lewis kernel: dswstate-0428 [49] ds_result_stack_pop   : Result=c13d5b28 remaining_results=0 State=c12bb428
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c13d5b28 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12bb028 from Tree Walk Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12b86a8 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [51] ds_result_stack_push  : Results=c12b86a8 State=c12bb028
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [48] ut_acquire_from_cache : Object c13f8d28 from Parse Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c12b86a8 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [49] ds_result_stack_push  : Results=c12b86a8 State=c12bb428
Oct 10 17:25:42 lewis kernel:  psparse-0672 [48] ps_parse_loop         : Opcode 0070 [Store] Op c13f8d28 Aml c12b07d7 aml_offset 0007D
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c13d5b28 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [48] ut_acquire_from_cache : Object c13f6628 from Parse Node Cache
Oct 10 17:25:42 lewis kernel:  psparse-0672 [48] ps_parse_loop         : Opcode 0001 [One] Op c13f6628 Aml c12b07d8 aml_offset 0007E
Oct 10 17:25:42 lewis kernel:  psscope-0254 [49] ps_pop_scope          : Popped Op c13f8d28 Args 0
Oct 10 17:25:42 lewis kernel:  psparse-0967 [48] ps_parse_loop         : Popped scope, Op=c13f8d28
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c12ba4a8 from Parse Node Cache
Oct 10 17:25:42 lewis kernel: nsaccess-0375 [51] ns_lookup             : Path is absolute from root [c0311e9c]
Oct 10 17:25:42 lewis kernel: nsaccess-0475 [51] ns_lookup             : Multi Pathname (3 Segments, Flags=3) 
Oct 10 17:25:42 lewis kernel:   nsdump-0081 [51] ns_print_pathname     : [_SB_.MEDB.ICNF]
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \ (c0311e9c) For [_SB_] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [_SB_] (Device) c12bd6a8 found in scope [\___] c0311e9c
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \_SB_ (c12bd6a8) For [MEDB] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [MEDB] (Device) c13faca8 found in scope [_SB_] c12bd6a8
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \_SB_.MEDB (c13faca8) For [ICNF] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [ICNF] (Integer) c13f9228 found in scope [MEDB] c13faca8
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [53] ut_acquire_from_cache : Object c13a8828 from Operand Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0509 [51] ds_obj_stack_push     : Obj=c13a8828 [Integer] State=c12bb428 #Ops=1
Oct 10 17:25:42 lewis kernel:  dsutils-0598 [50] ds_create_operands    : Arg #0 (c13f6628) done, Arg1=c13f6628
Oct 10 17:25:42 lewis kernel:  dsutils-0375 [51] ds_create_operand     : Getting a name: Arg=c12ba4a8
Oct 10 17:25:42 lewis kernel:  exnames-0289 [52] ex_get_name_string    : root_prefix(\) at c12b07d8
Oct 10 17:25:42 lewis kernel:  exnames-0352 [52] ex_get_name_string    : multi_name_prefix at c12b07d9
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : _
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : S
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : B
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : _
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_ 
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : M
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : E
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : D
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : B
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_MEDB 
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : I
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : C
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : N
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : F
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_MEDBICNF 
Oct 10 17:25:42 lewis kernel: nsaccess-0375 [52] ns_lookup             : Path is absolute from root [c0311e9c]
Oct 10 17:25:42 lewis kernel: nsaccess-0475 [52] ns_lookup             : Multi Pathname (3 Segments, Flags=3) 
Oct 10 17:25:42 lewis kernel:   nsdump-0081 [52] ns_print_pathname     : [_SB_.MEDB.ICNF]
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \ (c0311e9c) For [_SB_] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [_SB_] (Device) c12bd6a8 found in scope [\___] c0311e9c
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \_SB_ (c12bd6a8) For [MEDB] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [MEDB] (Device) c13faca8 found in scope [_SB_] c12bd6a8
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \_SB_.MEDB (c13faca8) For [ICNF] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [ICNF] (Integer) c13f9228 found in scope [MEDB] c13faca8
Oct 10 17:25:42 lewis kernel: dswstate-0509 [51] ds_obj_stack_push     : Obj=c13f9228 [Integer] State=c12bb428 #Ops=2
Oct 10 17:25:42 lewis kernel:  dsutils-0598 [50] ds_create_operands    : Arg #1 (c12ba4a8) done, Arg1=c13f6628
Oct 10 17:25:42 lewis kernel: dswstate-0428 [49] ds_result_stack_pop   : Result=c12b86a8 remaining_results=0 State=c12bb428
Oct 10 17:25:42 lewis kernel:  exresop-0164 [50] ex_resolve_operands   : Opcode 70 [Store] operand_types=2F 
Oct 10 17:25:42 lewis kernel: exresolv-0113 [51] ex_resolve_to_value   : Resolved object c13a8828
Oct 10 17:25:42 lewis kernel:   exdump-0430 [49] ex_dump_operands      : ************* Operand Stack Contents (Opcode [Store], 2 Operands)
Oct 10 17:25:42 lewis kernel:   exdump-0101 [49] ex_dump_operand       : c13f9228 NS Node:  0  ICNF Integer      c13f9228 = 0000000000000000
Oct 10 17:25:42 lewis kernel:       Attached Object c13deba8: (Ptr to ACPI Object type Integer, 1)
Oct 10 17:25:42 lewis kernel: 
Oct 10 17:25:42 lewis kernel: Offset Value
Oct 10 17:25:42 lewis kernel: 00000  88 01 01 00 00 00 00 00 01 00 00 00 00 00 00 00 ................
Oct 10 17:25:42 lewis kernel: 00010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
Oct 10 17:25:42 lewis kernel: 00020  00 00 00 00 00 00 00 00 
Oct 10 17:25:42 lewis kernel: 
Oct 10 17:25:42 lewis kernel:   exdump-0114 [49] ex_dump_operand       : c13a8828 Integer 0000000000000001
Oct 10 17:25:42 lewis kernel:   exdump-0445 [49] ex_dump_operands      : ************* Stack dump from dswexec(409), after ex_resolve_operands
Oct 10 17:25:42 lewis kernel:  exstore-0433 [52] ex_store_object_to_nod: Storing c13a8828(Integer) into node c13f9228(Integer)
Oct 10 17:25:42 lewis kernel: dswstate-0353 [49] ds_result_push        : Obj=c13a8828 [Integer] State=c12bb428 Num=1 Cur=0
Oct 10 17:25:42 lewis kernel:  dsutils-0197 [51] ds_is_result_used     : Result of [Store] not used by Parent [If] Op=c13f8d28
Oct 10 17:25:42 lewis kernel: dswstate-0228 [50] ds_result_pop         : Obj=c13a8828 [Integer] Index=0 State=c12bb428 Num=0
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [53] ut_acquire_from_cache : Object c12b86a8 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12b86a8 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12bb028 from Tree Walk Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c13d5b28 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [51] ds_result_stack_push  : Results=c13d5b28 State=c12bb028
Oct 10 17:25:42 lewis kernel:  psscope-0254 [49] ps_pop_scope          : Popped Op c12bae28 Args FFFFFFFD
Oct 10 17:25:42 lewis kernel:  psparse-0967 [48] ps_parse_loop         : Popped scope, Op=c12bae28
Oct 10 17:25:42 lewis kernel: dsopcode-0962 [49] ds_exec_end_control_op: [IF_OP] Op=c12bae28
Oct 10 17:25:42 lewis kernel: dswstate-0428 [49] ds_result_stack_pop   : Result=c12b8428 remaining_results=0 State=c12bb428
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12b8428 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c12bb028 from Tree Walk Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [51] ut_acquire_from_cache : Object c13fdba8 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [51] ds_result_stack_push  : Results=c13fdba8 State=c12bb028
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [48] ut_acquire_from_cache : Object c12bae28 from Parse Node Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c13fdba8 from State Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0389 [49] ds_result_stack_push  : Results=c13fdba8 State=c12bb428
Oct 10 17:25:42 lewis kernel:  psparse-0672 [48] ps_parse_loop         : Opcode 5B25 [Wait] Op c12bae28 Aml c12b07e9 aml_offset 0008E
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c13f8d28 from Parse Node Cache
Oct 10 17:25:42 lewis kernel: nsaccess-0375 [51] ns_lookup             : Path is absolute from root [c0311e9c]
Oct 10 17:25:42 lewis kernel: nsaccess-0475 [51] ns_lookup             : Multi Pathname (3 Segments, Flags=3) 
Oct 10 17:25:42 lewis kernel:   nsdump-0081 [51] ns_print_pathname     : [_SB_.MEDB.DSYN]
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \ (c0311e9c) For [_SB_] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [_SB_] (Device) c12bd6a8 found in scope [\___] c0311e9c
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \_SB_ (c12bd6a8) For [MEDB] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [MEDB] (Device) c13faca8 found in scope [_SB_] c12bd6a8
Oct 10 17:25:42 lewis kernel: nssearch-0100 [53] ns_search_node        : Searching \_SB_.MEDB (c13faca8) For [DSYN] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [53] ns_search_node        : Name [DSYN] (Event) c13f9328 found in scope [MEDB] c13faca8
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [49] ut_acquire_from_cache : Object c12b8428 from State Object Cache
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [48] ut_acquire_from_cache : Object c12ba4a8 from Parse Node Cache
Oct 10 17:25:42 lewis kernel:  psparse-0672 [48] ps_parse_loop         : Opcode 000B [WordConst] Op c12ba4a8 Aml c12b07f9 aml_offset 0009F
Oct 10 17:25:42 lewis kernel:  psscope-0254 [49] ps_pop_scope          : Popped Op c12bae28 Args 0
Oct 10 17:25:42 lewis kernel:  psparse-0967 [48] ps_parse_loop         : Popped scope, Op=c12bae28
Oct 10 17:25:42 lewis kernel:  dsutils-0375 [51] ds_create_operand     : Getting a name: Arg=c13f8d28
Oct 10 17:25:42 lewis kernel:  exnames-0289 [52] ex_get_name_string    : root_prefix(\) at c12b07e9
Oct 10 17:25:42 lewis kernel:  exnames-0352 [52] ex_get_name_string    : multi_name_prefix at c12b07ea
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : _
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : S
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : B
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : _
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_ 
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : M
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : E
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : D
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : B
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_MEDB 
Oct 10 17:25:42 lewis kernel:  exnames-0188 [53] ex_name_segment       : Bytes from stream:
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : D
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : S
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : Y
Oct 10 17:25:42 lewis kernel:  exnames-0194 [53] ex_name_segment       : N
Oct 10 17:25:42 lewis kernel:  exnames-0208 [53] ex_name_segment       : Appended to - \/^C_SB_MEDBDSYN 
Oct 10 17:25:42 lewis kernel: nsaccess-0375 [52] ns_lookup             : Path is absolute from root [c0311e9c]
Oct 10 17:25:42 lewis kernel: nsaccess-0475 [52] ns_lookup             : Multi Pathname (3 Segments, Flags=3) 
Oct 10 17:25:42 lewis kernel:   nsdump-0081 [52] ns_print_pathname     : [_SB_.MEDB.DSYN]
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \ (c0311e9c) For [_SB_] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [_SB_] (Device) c12bd6a8 found in scope [\___] c0311e9c
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \_SB_ (c12bd6a8) For [MEDB] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [MEDB] (Device) c13faca8 found in scope [_SB_] c12bd6a8
Oct 10 17:25:42 lewis kernel: nssearch-0100 [54] ns_search_node        : Searching \_SB_.MEDB (c13faca8) For [DSYN] (Untyped)
Oct 10 17:25:42 lewis kernel: nssearch-0122 [54] ns_search_node        : Name [DSYN] (Event) c13f9328 found in scope [MEDB] c13faca8
Oct 10 17:25:42 lewis kernel: dswstate-0509 [51] ds_obj_stack_push     : Obj=c13f9328 [Event] State=c12bb428 #Ops=1
Oct 10 17:25:42 lewis kernel:  dsutils-0598 [50] ds_create_operands    : Arg #0 (c13f8d28) done, Arg1=c13f8d28
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [53] ut_acquire_from_cache : Object c13a8828 from Operand Object Cache
Oct 10 17:25:42 lewis kernel: dswstate-0509 [51] ds_obj_stack_push     : Obj=c13a8828 [Integer] State=c12bb428 #Ops=2
Oct 10 17:25:42 lewis kernel:  dsutils-0598 [50] ds_create_operands    : Arg #1 (c12ba4a8) done, Arg1=c13f8d28
Oct 10 17:25:42 lewis kernel: dswstate-0428 [49] ds_result_stack_pop   : Result=c13fdba8 remaining_results=0 State=c12bb428
Oct 10 17:25:42 lewis kernel:  exresop-0164 [50] ex_resolve_operands   : Opcode 5B25 [Wait] operand_types=66 
Oct 10 17:25:42 lewis kernel: exresolv-0113 [51] ex_resolve_to_value   : Resolved object c13a8828
Oct 10 17:25:42 lewis kernel: exresnte-0107 [52] ex_resolve_node_to_val: Entry=c13f9328 source_desc=c13deca8 [Event]
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [55] ut_acquire_from_cache : Object c13fdba8 from State Object Cache
Oct 10 17:25:42 lewis kernel: exresolv-0113 [51] ex_resolve_to_value   : Resolved object c13deca8
Oct 10 17:25:42 lewis kernel:   exdump-0430 [49] ex_dump_operands      : ************* Operand Stack Contents (Opcode [Wait], 2 Operands)
Oct 10 17:25:42 lewis kernel:   exdump-0114 [49] ex_dump_operand       : c13a8828 Integer 000000000000FFFF
Oct 10 17:25:42 lewis kernel:   exdump-0114 [49] ex_dump_operand       : c13deca8 Event
Oct 10 17:25:42 lewis kernel:   exdump-0445 [49] ex_dump_operands      : ************* Stack dump from dswexec(409), after ex_resolve_operands
Oct 10 17:25:42 lewis kernel:  utalloc-0152 [52] ut_acquire_from_cache : Object c13a67a8 from Operand Object Cache
Oct 10 17:25:42 lewis kernel:      osl-0903 [53] os_wait_semaphore     : Failed to acquire semaphore[c12ae7c0|1|0], AE_TIME










--W/nzBZO5zC0uMSeA--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
