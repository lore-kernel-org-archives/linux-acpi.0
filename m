From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Oops: Battery and KDE 3.1
Date: Tue, 11 Feb 2003 14:34:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAAB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'earny-euM3SP4ZHrg@public.gmane.org'" <earny-euM3SP4ZHrg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please send your binary DSDT, I will take a look at the problem.
Bob


-----Original Message-----
From: Ernst Herzberg [mailto:earny-euM3SP4ZHrg@public.gmane.org] 
Sent: Monday, February 10, 2003 7:24 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Oops: Battery and KDE 3.1


Moin.

Just installed a gentoo with KDE 3.1. 
Kernel used: clean 2.4.20 with acpi-20021212  and clean 2.4.21-pre4 with
acpi-20030125

Kernel will oops in kdeinit (only with Battery enabled)
(Gericom M6-T, dump created with  2.4.21-pre4-20030125)
It is reliable reproduceable;-)

<Earny>

Syslog:

Feb 11 03:54:44 lidl kde(pam_unix)[5435]: session opened for user earny by
(uid=0)
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String: ACAD_PSR
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String: ACAD_PSR Return
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
Feb 11 03:54:51 lidl kernel: [ACPI Debug] Integer: 0000000000000001
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String: BAT0_BIF
Feb 11 03:54:51 lidl kernel: [ACPI Debug] String:
__________________________________
Feb 11 03:54:51 lidl kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000c
Feb 11 03:54:51 lidl kernel:  printing eip:
Feb 11 03:54:51 lidl kernel: c01f1db3
Feb 11 03:54:51 lidl kernel: *pde = 00000000
Feb 11 03:54:51 lidl kernel: Oops: 0002
Feb 11 03:54:51 lidl kernel: CPU:    0
Feb 11 03:54:51 lidl kernel: EIP:
0010:[acpi_ut_remove_allocation+195/416]    Not tainted
Feb 11 03:54:51 lidl kernel: EIP:    0010:[<c01f1db3>]    Not tainted
Feb 11 03:54:51 lidl kernel: EFLAGS: 00010202
Feb 11 03:54:51 lidl kernel: eax: 00000400   ebx: 00000000   ecx: 00000000
edx: 00000008
Feb 11 03:54:51 lidl kernel: esi: c1589ee0   edi: 00000000   ebp: d8527a48
esp: d8527a18
Feb 11 03:54:51 lidl kernel: ds: 0018   es: 0018   ss: 0018
Feb 11 03:54:51 lidl kernel: Process kdeinit (pid: 5646, stackpage=d8527000)
Feb 11 03:54:51 lidl kernel: Stack: 0000000a d8527a2c 00000000 c1589f08
d8527a48 00000001 c03193ed c031934b
Feb 11 03:54:51 lidl kernel:        d8527a64 c1589ee0 c1589f08 d8527a64
d8527a80 c01f1a5e 00000000 c1589ee0
Feb 11 03:54:51 lidl kernel:        00000080 c03170f7 000000a3 00000001
c0319395 c031934b d8527a98 00000000
Feb 11 03:54:51 lidl kernel: Call Trace:    [acpi_ut_free_and_track+126/304]
[acpi_ex_store_string_to_string+325/336]
[acpi_ex_store_object_to_object+367/480
] [acpi_ex_store_object_to_index+357/480] [acpi_ex_store+915/1008]
Feb 11 03:54:51 lidl kernel: Call Trace:    [<c01f1a5e>] [<c01dcd95>]
[<c01dca5f>] [<c01dc505>] [<c01dc343>]
Feb 11 03:54:51 lidl kernel:   [acpi_ex_opcode_1A_1T_1R+298/1760]
[acpi_ex_dump_operands+197/208] [acpi_ds_exec_end_op+1242/1408]
[acpi_ps_parse_loop+1917/38
24] [acpi_ut_release_mutex+336/480] [acpi_ut_exit+49/64]
Feb 11 03:54:51 lidl kernel:   [<c01d841a>] [<c01d4a35>] [<c01cb8fa>]
[<c01e756d>] [<c01f5c70>] [<c01f3071>]
Feb 11 03:54:51 lidl kernel:   [acpi_ds_delete_walk_state+188/336]
[acpi_ps_parse_aml+778/832] [acpi_psx_execute+654/1024]
[acpi_ns_execute_control_method+24
9/352] [acpi_ns_evaluate_by_handle+253/368]
[acpi_ns_evaluate_relative+451/560]
Feb 11 03:54:51 lidl kernel:   [<c01cdccc>] [<c01e7fea>] [<c01e8e7e>]
[<c01e1c89>] [<c01e1b1d>] [<c01e17e3>]
Feb 11 03:54:51 lidl kernel:   [acpi_ut_trace+60/64]
[acpi_evaluate_object+169/800] [acpi_battery_get_info+149/560]
[sprintf+31/48] [acpi_battery_read_info+2
45/848] [proc_file_read+184/416]
Feb 11 03:54:51 lidl kernel:   [<c01f2f4c>] [<c01e5249>] [<c01fa8f5>]
[<c02ea7cf>] [<c01fb155>] [<c015a248>]
Feb 11 03:54:51 lidl kernel:   [sys_read+156/304] [system_call+51/56]
Feb 11 03:54:51 lidl kernel:   [<c013986c>] [<c010931f>]
Feb 11 03:54:51 lidl kernel:
Feb 11 03:54:51 lidl kernel: Code: 89 42 04 8b 56 04 85 d2 74 04 8b 06 89 02
8b 5e 08 ba ea ea

****************************************************************************
**

ksymoops:
lidl ~/kernel # dmesg | ksymoops -m /boot/System.map
ksymoops 2.4.8 on i686 2.4.21-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre4/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01f1db3
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01f1db3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000400   ebx: 00000000   ecx: 00000000   edx: 00000008
esi: c1589ee0   edi: 00000000   ebp: d8527a48   esp: d8527a18
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 5646, stackpage=d8527000)
Stack: 0000000a d8527a2c 00000000 c1589f08 d8527a48 00000001 c03193ed
c031934b
       d8527a64 c1589ee0 c1589f08 d8527a64 d8527a80 c01f1a5e 00000000
c1589ee0
       00000080 c03170f7 000000a3 00000001 c0319395 c031934b d8527a98
00000000
Call Trace:    [<c01f1a5e>] [<c01dcd95>] [<c01dca5f>] [<c01dc505>]
[<c01dc343>]
  [<c01d841a>] [<c01d4a35>] [<c01cb8fa>] [<c01e756d>] [<c01f5c70>]
[<c01f3071>]
  [<c01cdccc>] [<c01e7fea>] [<c01e8e7e>] [<c01e1c89>] [<c01e1b1d>]
[<c01e17e3>]
  [<c01f2f4c>] [<c01e5249>] [<c01fa8f5>] [<c02ea7cf>] [<c01fb155>]
[<c015a248>]
  [<c013986c>] [<c010931f>]
Code: 89 42 04 8b 56 04 85 d2 74 04 8b 06 89 02 8b 5e 08 ba ea ea


>>EIP; c01f1db3 <acpi_ut_remove_allocation+c3/1a0>   <=====

>>esi; c1589ee0 <_end+11a6a9c/2256dc1c>
>>ebp; d8527a48 <_end+18144604/2256dc1c>
>>esp; d8527a18 <_end+181445d4/2256dc1c>

Trace; c01f1a5e <acpi_ut_free_and_track+7e/130>
Trace; c01dcd95 <acpi_ex_store_string_to_string+145/150>
Trace; c01dca5f <acpi_ex_store_object_to_object+16f/1e0>
Trace; c01dc505 <acpi_ex_store_object_to_index+165/1e0>
Trace; c01dc343 <acpi_ex_store+393/3f0>
Trace; c01d841a <acpi_ex_opcode_1A_1T_1R+12a/6e0>
Trace; c01d4a35 <acpi_ex_dump_operands+c5/d0>
Trace; c01cb8fa <acpi_ds_exec_end_op+4da/580>
Trace; c01e756d <acpi_ps_parse_loop+77d/ef0>
Trace; c01f5c70 <acpi_ut_release_mutex+150/1e0>
Trace; c01f3071 <acpi_ut_exit+31/40>
Trace; c01cdccc <acpi_ds_delete_walk_state+bc/150>
Trace; c01e7fea <acpi_ps_parse_aml+30a/340>
Trace; c01e8e7e <acpi_psx_execute+28e/400>
Trace; c01e1c89 <acpi_ns_execute_control_method+f9/160>
Trace; c01e1b1d <acpi_ns_evaluate_by_handle+fd/170>
Trace; c01e17e3 <acpi_ns_evaluate_relative+1c3/230>
Trace; c01f2f4c <acpi_ut_trace+3c/40>
Trace; c01e5249 <acpi_evaluate_object+a9/320>
Trace; c01fa8f5 <acpi_battery_get_info+95/230>
Trace; c02ea7cf <sprintf+1f/30>
Trace; c01fb155 <acpi_battery_read_info+f5/350>
Trace; c015a248 <proc_file_read+b8/1a0>
Trace; c013986c <sys_read+9c/130>
Trace; c010931f <system_call+33/38>

Code;  c01f1db3 <acpi_ut_remove_allocation+c3/1a0>
00000000 <_EIP>:
Code;  c01f1db3 <acpi_ut_remove_allocation+c3/1a0>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01f1db6 <acpi_ut_remove_allocation+c6/1a0>
   3:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c01f1db9 <acpi_ut_remove_allocation+c9/1a0>
   6:   85 d2                     test   %edx,%edx
Code;  c01f1dbb <acpi_ut_remove_allocation+cb/1a0>
   8:   74 04                     je     e <_EIP+0xe>
Code;  c01f1dbd <acpi_ut_remove_allocation+cd/1a0>
   a:   8b 06                     mov    (%esi),%eax
Code;  c01f1dbf <acpi_ut_remove_allocation+cf/1a0>
   c:   89 02                     mov    %eax,(%edx)
Code;  c01f1dc1 <acpi_ut_remove_allocation+d1/1a0>
   e:   8b 5e 08                  mov    0x8(%esi),%ebx
Code;  c01f1dc4 <acpi_ut_remove_allocation+d4/1a0>
  11:   ba ea ea 00 00            mov    $0xeaea,%edx





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
