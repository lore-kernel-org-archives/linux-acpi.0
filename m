From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: acpi_battery_read_info kernel Oops
Date: Sat, 28 Dec 2002 02:14:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212280214.46167.earny@net4u.de>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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


Moin,

Gericom M6-T,

lidl:~ # uname -a ; cat /proc/acpi/info
Linux lidl 2.4.20 #4 Sat Dec 28 00:28:55 CET 2002 i686 unknown
version:                 20021212
states:                  S0 S1 S4 S5

I have installed http://www.elektronikschule.de/~genannt/kacpi/
and the kernel will reliable panic. (thx Parrenin ;-)

Hope that will help to find the mystic batt-oopses
<Earny>

******************************************************************************

This patch will fix that, and kacpi runs without a problem, but that 
is *NOT* a correct fix, only where you can smell a bug :

--- linux-2.4.20.org/drivers/acpi/executer/exstorob.c   2002-12-28 00:26:49.000000000 +0100
+++ linux-2.4.20/drivers/acpi/executer/exstorob.c       2002-12-28 01:52:47.000000000 +0100
@@ -161,7 +161,7 @@
                        /*
                         * Only free if not a pointer into the DSDT
                         */
-                       ACPI_MEM_FREE (target_desc->string.pointer);
+//                     ACPI_MEM_FREE (target_desc->string.pointer);
                }

                target_desc->string.pointer = ACPI_MEM_CALLOCATE ((ACPI_SIZE) length + 1);

******************************************************************************

With kernel- and acpi-debug:

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol acpi_dbg_layer_R__ver_acpi_dbg_layer not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_dbg_level_R__ver_acpi_dbg_level not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_debug_print_R__ver_acpi_ut_debug_print not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_debug_print_raw_R__ver_acpi_ut_debug_print_raw not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_exit_R__ver_acpi_ut_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_status_exit_R__ver_acpi_ut_status_exit not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_trace_R__ver_acpi_ut_trace not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_ut_value_exit_R__ver_acpi_ut_value_exit not found in System.map.  Ignoring ksyms_base entry
Dec 28 01:13:44 lidl kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000400
Dec 28 01:13:44 lidl kernel: c01b79af
Dec 28 01:13:44 lidl kernel: *pde = 00000000
Dec 28 01:13:44 lidl kernel: Oops: 0002
Dec 28 01:13:44 lidl kernel: CPU:    0
Dec 28 01:13:44 lidl kernel: EIP:    0010:[acpi_ut_remove_allocation+207/400]    Not tainted
Dec 28 01:13:44 lidl kernel: EIP:    0010:[<c01b79af>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 28 01:13:44 lidl kernel: EFLAGS: 00210206
Dec 28 01:13:44 lidl kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000400
Dec 28 01:13:44 lidl kernel: esi: dff7a194   edi: 00000000   ebp: d5d71a48   esp: d5d71a18
Dec 28 01:13:44 lidl kernel: ds: 0018   es: 0018   ss: 0018
Dec 28 01:13:44 lidl kernel: Process kacpi (pid: 1499, stackpage=d5d71000)
Dec 28 01:13:44 lidl kernel: Stack: 0000000a d5d71a2c 00000000 dff7a1bc d5d71a48 00000001 c029fe55 c029fdb3 
Dec 28 01:13:44 lidl kernel:        d5d71a64 dff7a194 dff7a1bc d5d71a64 d5d71a80 c01b764e 00000000 dff7a194 
Dec 28 01:13:44 lidl kernel:        00000080 c029db4c 000000a4 00000001 c029fdfd c029fdb3 d5d71a98 00000000 
Dec 28 01:13:44 lidl kernel: Call Trace:    [acpi_ut_free_and_track+126/304] [acpi_ex_store_string_to_string+325/336] [acpi_ex_store_object_to_object+363/464] [acpi_ex_store_object_to_index+345/448] [acpi_ex_store+931/1024]
Dec 28 01:13:44 lidl kernel: Call Trace:    [<c01b764e>] [<c01a2fd5>] [<c01a2cab>] [<c01a2789>] [<c01a25d3>]
Dec 28 01:13:44 lidl kernel:   [<c019e80a>] [<c01a1c29>] [<c019aed5>] [<c01920c9>] [<c01ad3e8>] [<c01bb7bc>]
Dec 28 01:13:44 lidl kernel:   [<c01b8c31>] [<c019440c>] [<c01ade68>] [<c01aeca9>] [<c01a7c96>] [<c01a7b35>]
Dec 28 01:13:44 lidl kernel:   [<c01a7807>] [<c01b8b0c>] [<c01ab139>] [<c01c02f5>] [<c027b68f>] [<c01c0b05>]
Dec 28 01:13:44 lidl kernel:   [<c015e798>] [<c013dfac>] [<c01092ef>]
Dec 28 01:13:44 lidl kernel: Code: 89 02 8b 5e 08 ba ea ea ea ea 8d 7e 28 89 d0 89 d9 c1 e9 02 


>>EIP; c01b79af <acpi_ut_remove_allocation+cf/190>   <=====

>>esi; dff7a194 <_end+1fc16350/224b621c>
>>ebp; d5d71a48 <_end+15a0dc04/224b621c>
>>esp; d5d71a18 <_end+15a0dbd4/224b621c>

Trace; c01b764e <acpi_ut_free_and_track+7e/130>
Trace; c01a2fd5 <acpi_ex_store_string_to_string+145/150>
Trace; c01a2cab <acpi_ex_store_object_to_object+16b/1d0>
Trace; c01a2789 <acpi_ex_store_object_to_index+159/1c0>
Trace; c01a25d3 <acpi_ex_store+3a3/400>
Trace; c019e80a <acpi_ex_opcode_1A_1T_1R+12a/6e0>
Trace; c01a1c29 <acpi_ex_resolve_operands+189/790>
Trace; c019aed5 <acpi_ex_dump_operands+c5/d0>
Trace; c01920c9 <acpi_ds_exec_end_op+4d9/570>
Trace; c01ad3e8 <acpi_ps_parse_loop+7b8/f20>
Trace; c01bb7bc <acpi_ut_release_mutex+14c/1e0>
Trace; c01b8c31 <acpi_ut_exit+31/40>
Trace; c019440c <acpi_ds_delete_walk_state+bc/150>
Trace; c01ade68 <acpi_ps_parse_aml+318/350>
Trace; c01aeca9 <acpi_psx_execute+289/3c0>
Trace; c01a7c96 <acpi_ns_execute_control_method+f6/160>
Trace; c01a7b35 <acpi_ns_evaluate_by_handle+f5/160>
Trace; c01a7807 <acpi_ns_evaluate_relative+1b7/230>
Trace; c01b8b0c <acpi_ut_trace+3c/40>
Trace; c01ab139 <acpi_evaluate_object+a9/310>
Trace; c01c02f5 <acpi_battery_get_info+95/230>
Trace; c027b68f <sprintf+1f/30>
Trace; c01c0b05 <acpi_battery_read_info+f5/350>
Trace; c015e798 <proc_file_read+b8/1a0>
Trace; c013dfac <sys_read+9c/130>
Trace; c01092ef <system_call+33/38>

Code;  c01b79af <acpi_ut_remove_allocation+cf/190>
00000000 <_EIP>:
Code;  c01b79af <acpi_ut_remove_allocation+cf/190>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c01b79b1 <acpi_ut_remove_allocation+d1/190>
   2:   8b 5e 08                  mov    0x8(%esi),%ebx
Code;  c01b79b4 <acpi_ut_remove_allocation+d4/190>
   5:   ba ea ea ea ea            mov    $0xeaeaeaea,%edx
Code;  c01b79b9 <acpi_ut_remove_allocation+d9/190>
   a:   8d 7e 28                  lea    0x28(%esi),%edi
Code;  c01b79bc <acpi_ut_remove_allocation+dc/190>
   d:   89 d0                     mov    %edx,%eax
Code;  c01b79be <acpi_ut_remove_allocation+de/190>
   f:   89 d9                     mov    %ebx,%ecx
Code;  c01b79c0 <acpi_ut_remove_allocation+e0/190>
  11:   c1 e9 02                  shr    $0x2,%ecx


8 warnings issued.  Results may not be reliable.

NoNo, the result are reliable :-) Dont ask me, where the warnigs cames
from...

*****************************************************************************

Syslog:

[.... kacpi timer expires ....]
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: THRM_TMP
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: ACAD_PSR
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: ACAD_PSR Return
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] Integer: 0000000000000001
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: 
Dec 28 01:13:44 lidl kernel: [ACPI Debug] Package: Elements Ptr - d7bdd67c
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] Package: Elements Ptr - d7bdd89c
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: 
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] Package: Elements Ptr - d7bdd67c
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String:
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: BAT0_BIF
Dec 28 01:13:44 lidl kernel: [ACPI Debug] String: __________________________________
Dec 28 01:13:44 lidl kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000400
Dec 28 01:13:44 lidl kernel:  printing eip:
Dec 28 01:13:44 lidl kernel: c01b79af
Dec 28 01:13:44 lidl kernel: *pde = 00000000
Dec 28 01:13:44 lidl kernel: Oops: 0002
Dec 28 01:13:44 lidl kernel: CPU:    0
Dec 28 01:13:44 lidl kernel: EIP:    0010:[acpi_ut_remove_allocation+207/400]    Not tainted
Dec 28 01:13:44 lidl kernel: EIP:    0010:[<c01b79af>]    Not tainted
Dec 28 01:13:44 lidl kernel: EFLAGS: 00210206
Dec 28 01:13:44 lidl kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000400
Dec 28 01:13:44 lidl kernel: esi: dff7a194   edi: 00000000   ebp: d5d71a48   esp: d5d71a18
Dec 28 01:13:44 lidl kernel: ds: 0018   es: 0018   ss: 0018
Dec 28 01:13:44 lidl kernel: Process kacpi (pid: 1499, stackpage=d5d71000)
Dec 28 01:13:44 lidl kernel: Stack: 0000000a d5d71a2c 00000000 dff7a1bc d5d71a48 00000001 c029fe55 c029fdb3
Dec 28 01:13:44 lidl kernel:        d5d71a64 dff7a194 dff7a1bc d5d71a64 d5d71a80 c01b764e 00000000 dff7a194
Dec 28 01:13:44 lidl kernel:        00000080 c029db4c 000000a4 00000001 c029fdfd c029fdb3 d5d71a98 00000000
Dec 28 01:13:44 lidl kernel: Call Trace:    [acpi_ut_free_and_track+126/304] [acpi_ex_store_string_to_string+325/336] [acpi_ex_store_object_to_object+363/464] [acpi_ex_store_object_to_index+345/448] [acpi_ex_store+931/1024]

[..... see above ... ]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
