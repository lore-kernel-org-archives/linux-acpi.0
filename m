From: Hrvoje Habjanic <hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
Subject: Re: Oopses enterning S5 state
Date: Fri, 20 Jun 2003 12:16:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306201216.52064.hrvoje.habjanic@zg.hinet.hr>
References: <200306200920.27877.hrvoje.habjanic@zg.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200306200920.27877.hrvoje.habjanic-wUpq2f5uKgb0NTdHYsHBKg@public.gmane.org>
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


I forgot to ksysoops this ... so here it is ...

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c011409b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011409b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000005   ecx: 00000000   edx: 00000000
esi: 00000005   edi: 00000005   ebp: c12cc780   esp: ce659f1c
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 627, stackpage=ce659000)
Stack: c01b9e29 00000005 00000001 c01b9f6c 00000005 00000005 00000005 00000005
       00000002 ce659f50 ce659f60 c01ba800 00000005 02000000 c0283b3e c0283a35
       cebedf40 00000a35 00000000 00000000 cebedf40 00000000 cf954a60 ffffffea
Call Trace:    [<c01b9e29>] [<c01b9f6c>] [<c01ba800>] [<c015c520>] [<c013b403>]
  [<c010740f>]
Code: 89 02 0f 20 d8 0f 22 d8 31 d2 a1 24 77 31 c0 e9 f1 0e 02 00


>>EIP; c011409b <acpi_restore_pmd+b/20>   <=====

>>ebp; c12cc780 <_end+f6a9c8/104b62a8>
>>esp; ce659f1c <_end+e2f8164/104b62a8>

Trace; c01b9e29 <acpi_system_restore_state+3f/60>
Trace; c01b9f6c <acpi_suspend+56/a0>
Trace; c01ba800 <acpi_system_write_sleep+d4/fc>
Trace; c015c520 <proc_file_write+40/50>
Trace; c013b403 <sys_write+a3/140>
Trace; c010740f <system_call+33/38>

Code;  c011409b <acpi_restore_pmd+b/20>
00000000 <_EIP>:
Code;  c011409b <acpi_restore_pmd+b/20>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c011409d <acpi_restore_pmd+d/20>
   2:   0f 20 d8                  mov    %cr3,%eax
Code;  c01140a0 <acpi_restore_pmd+10/20>
   5:   0f 22 d8                  mov    %eax,%cr3
Code;  c01140a3 <acpi_restore_pmd+13/20>
   8:   31 d2                     xor    %edx,%edx
Code;  c01140a5 <acpi_restore_pmd+15/20>
   a:   a1 24 77 31 c0            mov    0xc0317724,%eax
Code;  c01140aa <acpi_restore_pmd+1a/20>
   f:   e9 f1 0e 02 00            jmp    20f05 <_EIP+0x20f05>


On Friday 20 June 2003 09:20, you wrote:
> Hi!
>
> Compaq Armada M700, 2.4.21 kernel with acpi-20030523-2.4.21-rc3.
> (for additional info - http://free-zg.htnet.hr/HrvojeHabjanic/acpi ).
>
> echo "5" > /proc/acpi/sleep
>
> and then:
>
> [ACPI Debug] String: _PTS:  Enter
> [ACPI Debug] Integer: 0000000000000005
> [ACPI Debug] String: Going into SOFTOFF State
> [ACPI Debug] String: _PTS:  Exit
> [ACPI Debug] String: _WAK:  Enter
> [ACPI Debug] Integer: 0000000000000005
> [ACPI Debug] String: _WAK:  Exit
> Unable to handle kernel NULL pointer dereference at virtual address



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
