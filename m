From: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Oops removing battery module
Date: Sun, 15 Dec 2002 13:13:55 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFCC663.6020107@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Another oops for you :)

The lead up to this is...

	o Insert battery module (both BAT0 and BAT1 dirs are created)
	o Remove battery module
	o Insert battery module (no BAT? dir created,
		info, state are directly in /proc/acpi/battery)
	o Remove battery module (Ooops generated)

Regards

Matt

*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018ebcc>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000008   ebx: 00000048   ecx: 00000000   edx: 00000000
esi: 000181a4   edi: 000181a4   ebp: 00008000   esp: cb371d00
ds: 0018   es: 0018   ss: 0018
Process kacpidpc (pid: 8428, stackpage=cb371000)
Stack: c5947428 c5947428 c2603b80 00000001 c029dbe8 c029dbe0 c0192714 
00000002
        c0171baf c5947428 cb371d54 00000040 c02935a5 c0293260 c0172137 
c5947428
        c5947428 cb371d84 c2603b80 c12ea8a8 cb371d84 00000040 c029378a 
c0293260
Call Trace:    [<c0192714>] [<c0171baf>] [<c0172137>] [<c0187c93>] 
[<c01861c5>]
   [<c0186c6c>] [<c018ec0a>] [<c01901bb>] [<c017203d>] [<c01871de>] 
[<c01871f5>]
   [<c016d54a>] [<c0187237>] [<c0187f86>] [<c0182400>] [<c01822c4>] 
[<c0173094>]
   [<c016b6c2>] [<c0172fcc>] [<c0105578>]
Code: 8b 04 30 89 83 80 d4 35 c0 8b 83 a0 d4 35 c0 ff 83 9c d4 35


 >>EIP; c018ebcc <acpi_ut_acquire_from_cache+58/fc>   <=====

 >>esp; cb371d00 <_end+aff26f8/1049ca58>

Trace; c0192714 <acpi_ut_create_generic_state+c/18>
Trace; c0171baf <acpi_ds_result_stack_push+27/6c>
Trace; c0172137 <acpi_ds_create_walk_state+8f/d0>
Trace; c0187c93 <acpi_ps_delete_parse_tree+67/f4>
Trace; c01861c5 <acpi_ps_complete_this_op+1ed/214>
Trace; c0186c6c <acpi_ps_parse_loop+94c/e08>
Trace; c018ec0a <acpi_ut_acquire_from_cache+96/fc>
Trace; c01901bb <acpi_ut_exit+1f/2c>
Trace; c017203d <acpi_ds_push_walk_state+4d/58>
Trace; c01871de <acpi_ps_parse_aml+b6/288>
Trace; c01871f5 <acpi_ps_parse_aml+cd/288>
Trace; c016d54a <acpi_ds_call_control_method+16e/274>
Trace; c0187237 <acpi_ps_parse_aml+10f/288>
Trace; c0187f86 <acpi_psx_execute+266/2f0>
Trace; c0182400 <acpi_ns_execute_control_method+f0/110>
Trace; c01822c4 <acpi_ns_evaluate_by_handle+f0/13c>
Trace; c0173094 <acpi_ev_asynch_execute_gpe_method+c8/148>
Trace; c016b6c2 <acpi_os_queue_exec+9a/c0>
Trace; c0172fcc <acpi_ev_asynch_execute_gpe_method+0/148>
Trace; c0105578 <kernel_thread+28/38>

Code;  c018ebcc <acpi_ut_acquire_from_cache+58/fc>
00000000 <_EIP>:
Code;  c018ebcc <acpi_ut_acquire_from_cache+58/fc>   <=====
    0:   8b 04 30                  mov    (%eax,%esi,1),%eax   <=====
Code;  c018ebcf <acpi_ut_acquire_from_cache+5b/fc>
    3:   89 83 80 d4 35 c0         mov    %eax,0xc035d480(%ebx)
Code;  c018ebd5 <acpi_ut_acquire_from_cache+61/fc>
    9:   8b 83 a0 d4 35 c0         mov    0xc035d4a0(%ebx),%eax
Code;  c018ebdb <acpi_ut_acquire_from_cache+67/fc>
    f:   ff 83 9c d4 35 00         incl   0x35d49c(%ebx)


4 warnings and 1 error issued.  Results may not be reliable.

-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
Technology Forum - http://www.technology-forum.org/
Commercial Open Source - http://www.commercialos.org/



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
