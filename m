From: Chris Rankin <rankincj-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: [OOPS] Crash on "power off" with 2.4.22-SMP
Date: Sun, 31 Aug 2003 21:26:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F5259FC.1070402@yahoo.com>
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

Hi,

I am running 2.4.22-SMP with devfs and 1 GB RAM. I enable ACPI with acpi=force. 
As of 2.4.22, my kernel has started oopsing when I try to power off on shutdown. 
This appears to be due to a deadlock which the NMI watchdog breaks. The full 
oops is attached,

Cheers,
Chris

ksymoops 2.4.9 on i686 2.4.22.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.22/ (default)
      -m /boot/System.map-2.4.22 (specified)

NMI Watchdog detected LOCKUP on CPU0, eip c019a63f, registers:
CPU:    0
EIP:    0010:[<c019a63f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000001   ebx: 00000400   ecx: f77cde24   edx: 00000400
esi: 00000010   edi: 00000400   ebp: bffffd58   esp: f77cdde0
ds: 0018   es: 0018   ss: 0018
Process poweroff (pid: 397, stackpage=f77cd000)
Stack: 00000001 f77cde24 c01a5d7e 00000400 f77cde24 00000010 00002001 00002001
        00002001 c0299c38 00000000 c01a5ab7 00000010 f77cde24 c1d730f4 00299c60
        00000000 00000000 00002001 c01a58d6 00000000 00000001 f77cde3c 00000000
Call Trace:    [<c01a5d7e>] [<c01a5ab7>] [<c01a58d6>] [<c01a609c>] [<c01b4461>]
   [<c01b44bc>] [<c01b433b>] [<c01073f2>] [<c012bfaa>] [<c011ca96>] [<c0129fce>]
   [<c012a366>] [<c012ac94>] [<c011b592>] [<c011b510>] [<c0129073>] [<c010942f>]
Code: 66 89 01 eb dc 8b 4c 24 0c 8b 54 24 04 8b 44 24 08 83 f9 10


 >>EIP; c019a63f <acpi_os_read_port+49/4e>   <=====

 >>ecx; f77cde24 <_end+374700f4/384ed330>
 >>esp; f77cdde0 <_end+374700b0/384ed330>

Trace; c01a5d7e <acpi_hw_low_level_read+9a/9f>
Trace; c01a5ab7 <acpi_hw_register_read+51/15d>
Trace; c01a58d6 <acpi_get_register+46/7b>
Trace; c01a609c <acpi_enter_sleep_state+195/1ae>
Trace; c01b4461 <acpi_system_suspend+2d/40>
Trace; c01b44bc <acpi_suspend+48/9f>
Trace; c01b433b <acpi_power_off+7/9>
Trace; c01073f2 <machine_power_off+12/20>
Trace; c012bfaa <sys_reboot+27a/2a0>
Trace; c011ca96 <wake_up_process+16/20>
Trace; c0129fce <deliver_signal+9e/a0>
Trace; c012a366 <kill_something_info+d6/1c0>
Trace; c012ac94 <sys_kill+54/60>
Trace; c011b592 <schedule_timeout+62/b0>
Trace; c011b510 <process_timeout+0/20>
Trace; c0129073 <sys_nanosleep+d3/170>
Trace; c010942f <system_call+33/38>

Code;  c019a63f <acpi_os_read_port+49/4e>
00000000 <_EIP>:
Code;  c019a63f <acpi_os_read_port+49/4e>   <=====
    0:   66 89 01                  mov    %ax,(%ecx)   <=====
Code;  c019a642 <acpi_os_read_port+4c/4e>
    3:   eb dc                     jmp    ffffffe1 <_EIP+0xffffffe1>
Code;  c019a644 <acpi_os_write_port+0/41>
    5:   8b 4c 24 0c               mov    0xc(%esp,1),%ecx
Code;  c019a648 <acpi_os_write_port+4/41>
    9:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c019a64c <acpi_os_write_port+8/41>
    d:   8b 44 24 08               mov    0x8(%esp,1),%eax
Code;  c019a650 <acpi_os_write_port+c/41>
   11:   83 f9 10                  cmp    $0x10,%ecx




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
