From: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Re: Battery Oops - more information
Date: Mon, 09 Dec 2002 22:15:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF55C5F.1070507@sympatico.ca>
References: <3DF4E748.3080300@casero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DF4E748.3080300-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>
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

Further to this email, who would be the best person to discuss this with 
to come to a resolution which is already affecting a number of people on 
this list?

Andrew?  (Although you seem to busy trying to get the latest ACPI into 
2.4.21)

Regards,

Matthew


Matthew Tippett wrote:
> A little bit more research yeilds, that it is only when the battery is 
> in when the oops occurs.
> 
> System is
> 
>     Dell i8200/BIOS A7/two batteries/Debian/2.4.20 - from debian
> 
> Modprobe works.
> 
>     # modprobe battery
>     ACPI: Battery Slot [BAT0] (battery absent)
>     ACPI: Battery Slot [BAT1] (battery absent)
> 
> So that worked.
> 
> Lots more below, so I will finish the body of the email here.  I have 
> attached my dsdt (since that seems to be the norm).  If there is 
> anything else that I can do, give me an email.
> 
> Matt
> 
> 
> Insert battery...  Kernel Oops
> 
>     ACPI-0189: *** Warning: Buffer created with zero length in AML
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000010
>  printing eip:
> c016d13a
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c016d13a>]    Tainted: P
> EFLAGS: 00210246
> eax: 00000000   ebx: 00000000   ecx: cff38400   edx: c033b478
> esi: cf1dbc00   edi: cff346c0   ebp: c87acd40   esp: c78c3d40
> ds: 0018   es: 0018   ss: 0018
> Process kacpidpc (pid: 19941, stackpage=c78c3000)
> Stack: c27dde00 c87acd40 00000000 c5ab55b4 c016d227 c87acd40 c87acd40 
> 00000000
>        00000000 c01755c4 c27dde00 c5ab55b4 c5ab5400 c5ab5400 00000010 
> 00000000
>        c0175661 c5ab55b4 c5ab5400 c5ab55b4 00000000 c016da06 c5ab55b4 
> c5ab5400
> Call Trace:    [<c016d227>] [<c01755c4>] [<c0175661>] [<c016da06>] 
> [<c016df70>]
>   [<c017ad75>] [<c01804f4>] [<c018169b>] [<c017f759>] [<c016ef99>] 
> [<c017b13a>]
>   [<c017ba56>] [<c017813b>] [<c01780be>] [<c0177f85>] [<c01804f4>] 
> [<c0180577>]
>   [<c017966c>] [<d1a29d76>] [<d1a290d3>] [<d1a29d76>] [<d1a29d68>] 
> [<d1a293bc>]
>   [<d1a29b71>] [<c016fb9d>] [<c016b626>] [<c0105578>] [<c016fb38>]
> 
> Code: 89 68 10 57 e8 1d e7 00 00 6a 37 e8 b2 e4 00 00 89 c7 83 c4
> 
> 
> Running this through ksymoops.
> 
> EFLAGS: 00210246
> eax: 00000000   ebx: 00000000   ecx: cff38400   edx: c033b478
> esi: cf1dbc00   edi: cff346c0   ebp: c87acd40   esp: c78c3d40
> ds: 0018   es: 0018   ss: 0018
> Process kacpidpc (pid: 19941, stackpage=c78c3000)
> Stack: c27dde00 c87acd40 00000000 c5ab55b4 c016d227 c87acd40 c87acd40 
> 00000000
>        00000000 c01755c4 c27dde00 c5ab55b4 c5ab5400 c5ab5400 00000010 
> 00000000
>        c0175661 c5ab55b4 c5ab5400 c5ab55b4 00000000 c016da06 c5ab55b4 
> c5ab5400
> Call Trace:    [<c016d227>] [<c01755c4>] [<c0175661>] [<c016da06>] 
> [<c016df70>]
>   [<c017ad75>] [<c01804f4>] [<c018169b>] [<c017f759>] [<c016ef99>] 
> [<c017b13a>]
>   [<c017ba56>] [<c017813b>] [<c01780be>] [<c0177f85>] [<c01804f4>] 
> [<c0180577>]
>   [<c017966c>] [<d1a29d76>] [<d1a290d3>] [<d1a29d76>] [<d1a29d68>] 
> [<d1a293bc>]
>   [<d1a29b71>] [<c016fb9d>] [<c016b626>] [<c0105578>] [<c016fb38>]
> Code: 89 68 10 57 e8 1d e7 00 00 6a 37 e8 b2 e4 00 00 89 c7 83 c4
> 
> 
>  >>EIP; c016d13a <acpi_ds_execute_arguments+8a/118>   <=====
> 
>  >>ecx; cff38400 <_end+fbdae78/104bead8>
>  >>edx; c033b478 <acpi_gbl_acpi_mutex_info+98/a0>
>  >>esi; cf1dbc00 <_end+ee7e678/104bead8>
>  >>edi; cff346c0 <_end+fbd7138/104bead8>
>  >>ebp; c87acd40 <_end+844f7b8/104bead8>
>  >>esp; c78c3d40 <_end+75667b8/104bead8>
> 
> Trace; c016d227 <acpi_ds_get_buffer_arguments+23/34>
> Trace; c01755c4 <acpi_ex_resolve_node_to_value+94/f0>
> Trace; c0175661 <acpi_ex_resolve_to_value+41/50>
> Trace; c016da06 <acpi_ds_resolve_operands+26/38>
> Trace; c016df70 <acpi_ds_exec_end_op+100/260>
> Trace; c017ad75 <acpi_ps_parse_loop+5ed/958>
> Trace; c01804f4 <acpi_ut_update_object_reference+214/254>
> Trace; c018169b <acpi_ut_release_mutex+7f/88>
> Trace; c017f759 <acpi_ut_release_to_cache+89/94>
> Trace; c016ef99 <acpi_ds_delete_walk_state+99/a0>
> Trace; c017b13a <acpi_ps_parse_aml+5a/1b0>
> Trace; c017ba56 <acpi_psx_execute+166/1c0>
> Trace; c017813b <acpi_ns_execute_control_method+53/70>
> Trace; c01780be <acpi_ns_evaluate_by_handle+86/b0>
> Trace; c0177f85 <acpi_ns_evaluate_relative+b5/d0>
> Trace; c01804f4 <acpi_ut_update_object_reference+214/254>
> Trace; c0180577 <acpi_ut_remove_reference+23/2c>
> Trace; c017966c <acpi_evaluate_object+114/1e0>
> Trace; d1a29d76 <[battery]__module_author+0/2a>
> Trace; d1a290d3 <[battery]acpi_battery_get_info+73/138>
> Trace; d1a29d76 <[battery]__module_author+0/2a>
> Trace; d1a29d68 <[battery]__module_kernel_version+8/16>
> Trace; d1a293bc <[battery]acpi_battery_check+80/fc>
> Trace; d1a29b71 <[battery]acpi_battery_notify+45/68>
> Trace; c016fb9d <acpi_ev_notify_dispatch+65/74>
> Trace; c016b626 <acpi_os_queue_exec+3e/50>
> Trace; c0105578 <kernel_thread+28/38>
> Trace; c016fb38 <acpi_ev_notify_dispatch+0/74>
> 
> Code;  c016d13a <acpi_ds_execute_arguments+8a/118>
> 00000000 <_EIP>:
> Code;  c016d13a <acpi_ds_execute_arguments+8a/118>   <=====
>    0:   89 68 10                  mov    %ebp,0x10(%eax)   <=====
> Code;  c016d13d <acpi_ds_execute_arguments+8d/118>
>    3:   57                        push   %edi
> Code;  c016d13e <acpi_ds_execute_arguments+8e/118>
>    4:   e8 1d e7 00 00            call   e726 <_EIP+0xe726>
> Code;  c016d143 <acpi_ds_execute_arguments+93/118>
>    9:   6a 37                     push   $0x37
> Code;  c016d145 <acpi_ds_execute_arguments+95/118>
>    b:   e8 b2 e4 00 00            call   e4c2 <_EIP+0xe4c2>
> Code;  c016d14a <acpi_ds_execute_arguments+9a/118>
>   10:   89 c7                     mov    %eax,%edi
> Code;  c016d14c <acpi_ds_execute_arguments+9c/118>
>   12:   83 c4 00                  add    $0x0,%esp
> 
> 
> So hopefully that helps people a little bit more.
> 
> 
> -----
> 
> The information contained in this message is proprietary of Casero Inc.,
> protected from disclosure, and may be privileged. The information is
> intended to be conveyed only to the designated recipient(s) of the
> message. If the reader of this message is not the intended recipient,
> you are hereby notified that any dissemination, use, distribution or
> copying of this communication is strictly prohibited and may be
> unlawful. If you have received this communication in error, please
> notify us immediately by replying to the message and deleting it from
> your computer. Thank you.

-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
Technology Forum - http://www.technology-forum.org/
Commercial Open Source - http://www.commercialos.org/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
