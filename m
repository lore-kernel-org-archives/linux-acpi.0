From: Irene Zubarev <zubarev-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: _INI fails
Date: Mon, 18 Nov 2002 11:41:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF8F018F6E.55528984-ON87256C75.005AB056@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello, I'm using IBM x-Series 352.  The hot-plug controller is a PCI
device, but the _INI method for it fails.  This is the error message I get
when the debug messages are on.  Please help on how I can debug/proceed
further.

Thank you,

Irene Zubarev


Nov 14 08:09:18 linux kernel: Method pathname:  \_SB_.PCI0.HPC_._INI (Node c46528c4)
Nov 14 08:09:18 linux kernel:  utalloc-0557 [0359] [11] Ut_free               : ----Entry f6e6161c
Nov 14 08:09:18 linux kernel:  utalloc-0745 [0359] [12] Ut_remove_allocation  : ----Entry
Nov 14 08:09:18 linux kernel:      osl-0703 [0359] [13] os_wait_semaphore     : ----Entry
Nov 14 08:09:18 linux kernel:      osl-0770 [0359] [13] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:18 linux kernel:  utalloc-0784 [0359] [12] Ut_remove_allocation  : Freeing size 15
Nov 14 08:09:18 linux kernel:      osl-0784 [0359] [13] os_signal_semaphore   : ----Entry
Nov 14 08:09:18 linux kernel:      osl-0796 [0359] [13] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:18 linux kernel:  utalloc-0787 [0359] [12] Ut_remove_allocation  : ----Exit- AE_OK
Nov 14 08:09:18 linux kernel:  utalloc-0582 [0359] [11] Ut_free               : f6e6161c freed
Nov 14 08:09:18 linux kernel:  utalloc-0584 [0359] [11] Ut_free               : ----Exit-
Nov 14 08:09:18 linux kernel:   nsdump-0123 [0359] [10] Ns_dump_pathname      : ----Exit- AE_OK
Nov 14 08:09:18 linux kernel: dswstate-0983 [0359] [10] Ds_delete_walk_state  : ----Entry c465e428
Nov 14 08:09:18 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:18 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:18 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:18 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:19 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:19 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:19 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:19 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:19 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel: dswstate-1027 [0359] [10] Ds_delete_walk_state  : ----Exit-
Nov 14 08:09:19 linux kernel:  psparse-1081 [0359] [09] Ps_parse_aml          : Completed one call to walk loop, State=c465ec28
Nov 14 08:09:19 linux kernel: dswstate-0778 [0359] [10] Ds_pop_walk_state     : ----Entry
Nov 14 08:09:19 linux kernel: dswstate-0795 [0359] [10] Ds_pop_walk_state     : ----Exit- c465ec28
Nov 14 08:09:19 linux kernel: dswscope-0065 [0359] [09] Ds_scope_stack_clear  : Popped object type (Method)
Nov 14 08:09:19 linux kernel:   utmisc-1159 [0359] [10] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:19 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:19 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:19 linux kernel:   utmisc-1163 [0359] [10] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:19 linux kernel: dsmethod-0442 [0359] [10] Ds_terminate_control_m: ----Entry c465ec28
Nov 14 08:09:19 linux kernel: dsmthdat-0115 [0359] [11] Ds_method_data_delete_: ----Entry
Nov 14 08:09:19 linux kernel: dsmthdat-0123 [0359] [11] Ds_method_data_delete_: Deleting Local0=f634f154
Nov 14 08:09:20 linux kernel: nsobject-0193 [0359] [12] Ns_detach_object      : ----Entry
Nov 14 08:09:20 linux kernel: nsobject-0219 [0359] [12] Ns_detach_object      : Node c465ed08 [__L0] Object f634f154
Nov 14 08:09:20 linux kernel: utdelete-0592 [0359] [13] Ut_remove_reference   : ----Entry f634f154
Nov 14 08:09:20 linux kernel: utdelete-0612 [0359] [13] Ut_remove_reference   : Obj f634f154 Refs=1
Nov 14 08:09:20 linux kernel: utdelete-0378 [0359] [14] Ut_update_object_refer: ----Entry f634f154
Nov 14 08:09:20 linux kernel:   utmisc-1037 [0359] [15] Ut_create_update_state: ----Entry f634f154
Nov 14 08:09:20 linux kernel:      osl-0703 [0359] [16] os_wait_semaphore     : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0770 [0359] [16] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel:  utalloc-0134 [0359] [15] Ut_acquire_from_cache : Object c4655e34 from State Object Cache
Nov 14 08:09:20 linux kernel:      osl-0784 [0359] [16] os_signal_semaphore   : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0796 [0359] [16] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel:   utmisc-1053 [0359] [15] Ut_create_update_state: ----Exit- c4655e34
Nov 14 08:09:20 linux kernel:   utmisc-1159 [0359] [15] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:20 linux kernel:      osl-0703 [0359] [16] os_wait_semaphore     : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0770 [0359] [16] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel:      osl-0784 [0359] [16] os_signal_semaphore   : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0796 [0359] [16] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel:   utmisc-1163 [0359] [15] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:20 linux kernel: utdelete-0295 [0359] [14] Ut_update_ref_count   : Obj f634f154 Refs=0, [Decremented]
Nov 14 08:09:20 linux kernel: utdelete-0057 [0359] [15] Ut_delete_internal_obj: ----Entry f634f154
Nov 14 08:09:20 linux kernel: utdelete-0193 [0359] [15] Ut_delete_internal_obj: Deleting Object f634f154 [Integer]
Nov 14 08:09:20 linux kernel: utobject-0237 [0359] [16] Ut_delete_object_desc : ----Entry f634f154
Nov 14 08:09:20 linux kernel:      osl-0703 [0359] [17] os_wait_semaphore     : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0770 [0359] [17] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel:      osl-0784 [0359] [17] os_signal_semaphore   : ----Entry
Nov 14 08:09:20 linux kernel:      osl-0796 [0359] [17] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:20 linux kernel: utobject-0250 [0359] [16] Ut_delete_object_desc : ----Exit-
Nov 14 08:09:21 linux kernel: utdelete-0196 [0359] [15] Ut_delete_internal_obj: ----Exit-
Nov 14 08:09:21 linux kernel:   utmisc-0924 [0359] [15] Ut_pop_generic_state  : ----Entry
Nov 14 08:09:21 linux kernel:   utmisc-0936 [0359] [15] Ut_pop_generic_state  : ----Exit- 00000000
Nov 14 08:09:21 linux kernel: utdelete-0527 [0359] [14] Ut_update_object_refer: ----Exit- AE_OK
Nov 14 08:09:21 linux kernel: utdelete-0620 [0359] [13] Ut_remove_reference   : ----Exit-
Nov 14 08:09:21 linux kernel: nsobject-0224 [0359] [12] Ns_detach_object      : ----Exit-
Nov 14 08:09:21 linux kernel: dsmthdat-0144 [0359] [11] Ds_method_data_delete_: ----Exit-
Nov 14 08:09:21 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:21 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:21 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:21 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:21 linux kernel:  nsalloc-0560 [0359] [11] Ns_delete_namespace_by: ----Entry 0000022A
Nov 14 08:09:21 linux kernel:  nsalloc-0628 [0359] [11] Ns_delete_namespace_by: ----Exit-
Nov 14 08:09:21 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:21 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:21 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:21 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:21 linux kernel: dsmethod-0520 [0359] [10] Ds_terminate_control_m: ----Exit- AE_OK
Nov 14 08:09:21 linux kernel:  psscope-0260 [0359] [10] Ps_cleanup_scope      : ----Entry c465ee0c
Nov 14 08:09:21 linux kernel:   utmisc-0924 [0359] [11] Ut_pop_generic_state  : ----Entry
Nov 14 08:09:21 linux kernel:   utmisc-0936 [0359] [11] Ut_pop_generic_state  : ----Exit- c46ef63c
Nov 14 08:09:22 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:22 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:22 linux kernel:  psscope-0275 [0359] [10] Ps_cleanup_scope      : ----Exit-
Nov 14 08:09:22 linux kernel:  psparse-1131 [0359] [09] Ps_parse_aml          : Return_value=00000000, State=c465ec28
Nov 14 08:09:22 linux kernel: dswstate-0723 [0359] [09] Ds_get_current_walk_st: Ds_get_current_walk_state, =00000000
Nov 14 08:09:22 linux kernel: dswstate-0983 [0359] [10] Ds_delete_walk_state  : ----Entry c465ec28
Nov 14 08:09:22 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:22 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:22 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel: dswstate-1027 [0359] [10] Ds_delete_walk_state  : ----Exit-
Nov 14 08:09:22 linux kernel:   utmisc-1159 [0359] [10] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:22 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:22 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:22 linux kernel:   utmisc-1163 [0359] [10] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:22 linux kernel:  psparse-1183 [0359] [09] Ps_parse_aml          : ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:23 linux kernel:   pswalk-0241 [0359] [09] Ps_delete_parse_tree  : ----Entry c4655ebc
Nov 14 08:09:23 linux kernel:   utmisc-0994 [0359] [10] Ut_create_thread_state: ----Entry
Nov 14 08:09:23 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel:  utalloc-0134 [0359] [10] Ut_acquire_from_cache : Object c46efa7c from State Object Cache
Nov 14 08:09:23 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel:   utmisc-1009 [0359] [10] Ut_create_thread_state: ----Exit- c46efa7c
Nov 14 08:09:23 linux kernel: dswstate-0824 [0359] [10] Ds_create_walk_state  : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel:  utalloc-0134 [0359] [10] Ut_acquire_from_cache : Object c465ec28 from Tree Walk Node Cache
Nov 14 08:09:23 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel: dsmthdat-0065 [0359] [11] Ds_method_data_init   : ----Entry
Nov 14 08:09:23 linux kernel: dsmthdat-0091 [0359] [11] Ds_method_data_init   : ----Exit-
Nov 14 08:09:23 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel:  utalloc-0134 [0359] [10] Ut_acquire_from_cache : Object c4655d24 from State Object Cache
Nov 14 08:09:23 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:23 linux kernel:   utmisc-0893 [0359] [11] Ut_push_generic_state : ----Entry
Nov 14 08:09:23 linux kernel:   utmisc-0901 [0359] [11] Ut_push_generic_state : ----Exit-
Nov 14 08:09:23 linux kernel: dswstate-0370 [0359] [10] Ds_result_stack_push  : Results=c4655d24 State=c465ec28
Nov 14 08:09:23 linux kernel: dswstate-0747 [0359] [11] Ds_push_walk_state    : ----Entry
Nov 14 08:09:23 linux kernel: dswstate-0753 [0359] [11] Ds_push_walk_state    : ----Exit-
Nov 14 08:09:23 linux kernel: dswstate-0859 [0359] [10] Ds_create_walk_state  : ----Exit- c465ec28
Nov 14 08:09:23 linux kernel:   pswalk-0061 [0359] [10] Ps_get_next_walk_op   : ----Entry c4655ebc
Nov 14 08:09:23 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:23 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:   pswalk-0102 [0359] [10] Ps_get_next_walk_op   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:   utmisc-1159 [0359] [10] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:24 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:   utmisc-1163 [0359] [10] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:24 linux kernel: dswstate-0983 [0359] [10] Ds_delete_walk_state  : ----Entry c465ec28
Nov 14 08:09:24 linux kernel:   utmisc-1159 [0359] [11] Ut_delete_generic_stat: ----Entry
Nov 14 08:09:24 linux kernel:      osl-0703 [0359] [12] os_wait_semaphore     : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0770 [0359] [12] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:      osl-0784 [0359] [12] os_signal_semaphore   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0796 [0359] [12] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:   utmisc-1163 [0359] [11] Ut_delete_generic_stat: ----Exit-
Nov 14 08:09:24 linux kernel:      osl-0703 [0359] [11] os_wait_semaphore     : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0770 [0359] [11] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:      osl-0784 [0359] [11] os_signal_semaphore   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0796 [0359] [11] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel: dswstate-1027 [0359] [10] Ds_delete_walk_state  : ----Exit-
Nov 14 08:09:24 linux kernel:   pswalk-0286 [0359] [09] Ps_delete_parse_tree  : ----Exit-
Nov 14 08:09:24 linux kernel:  psxface-0203 [0359] [08] Psx_execute           : ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:24 linux kernel:  exutils-0109 [0359] [08] Ex_exit_interpreter   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0784 [0359] [09] os_signal_semaphore   : ----Entry
Nov 14 08:09:24 linux kernel:      osl-0796 [0359] [09] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:24 linux kernel:  exutils-0117 [0359] [08] Ex_exit_interpreter   : ----Exit-
Nov 14 08:09:24 linux kernel:   nseval-0416 [0359] [07] Ns_execute_control_met: ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:24 linux kernel:   nseval-0340 [0359] [06] Ns_evaluate_by_handle : ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:24 linux kernel:   nseval-0130 [0359] [05] Ns_evaluate_relative  : *** Completed eval of object _INI ***
Nov 14 08:09:24 linux kernel:  utalloc-0557 [0359] [06] Ut_free               : ----Entry f7287abc
Nov 14 08:09:25 linux kernel:  utalloc-0745 [0359] [07] Ut_remove_allocation  : ----Entry
Nov 14 08:09:25 linux kernel:      osl-0703 [0359] [08] os_wait_semaphore     : ----Entry
Nov 14 08:09:25 linux kernel:      osl-0770 [0359] [08] os_wait_semaphore     : ----Exit- AE_OK
Nov 14 08:09:25 linux kernel:  utalloc-0784 [0359] [07] Ut_remove_allocation  : Freeing size 8
Nov 14 08:09:25 linux kernel:      osl-0784 [0359] [08] os_signal_semaphore   : ----Entry
Nov 14 08:09:25 linux kernel:      osl-0796 [0359] [08] os_signal_semaphore   : ----Exit- AE_OK
Nov 14 08:09:25 linux kernel:  utalloc-0787 [0359] [07] Ut_remove_allocation  : ----Exit- AE_OK
Nov 14 08:09:25 linux kernel:  utalloc-0582 [0359] [06] Ut_free               : f7287abc freed
Nov 14 08:09:25 linux kernel:  utalloc-0584 [0359] [06] Ut_free               : ----Exit-
Nov 14 08:09:25 linux kernel:   nseval-0135 [0359] [05] Ns_evaluate_relative  : ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:25 linux kernel: nsxfeval-0325 [0359] [04] Acpi_evaluate_object  : ----Exit- ****Exception****: AE_BAD_PARAMETER
Nov 14 08:09:25 linux kernel: _INI failed:



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
