From: Tamagucci <tamagucci-dbx96nzIXN7OeuqD6ShaSA@public.gmane.org>
Subject: oops while trying to shutdown the system
Date: Tue, 11 Feb 2003 12:51:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030211125128.226b00af.tamagucci@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uti2KpX7p8Fi@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

i just compiled a 2.4.21-pre4 kernel using the latest acpi patch...
I'm using an asus a7v8x motherboard and I wanted to test which states
does it supports...
I tried
echo -n "1" > /proc/acpi/sleep
echo -n "2" > /proc/acpi/sleep
echo -n "3" > /proc/acpi/sleep
and nothing happened, then I tried 
echo -n "5" > /proc/acpi/sleep
and something weird happened...
the console was closed, but the system didn't shutdown...
it did something to the usb mouse (an imps2 compatible) and to the nic
(rtl8139) so i was forced to unload and reload all the related modules
to let all those devices to works...
I get an oops, here is the ksymoops output
(I compiled the kernel using gcc-3.2.2 on a debian sid linux system).

	Edward
ksymoops 2.4.8 on i686 2.4.21-pre4.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre4/ (default)
     -m /boot/System.map-2.4.21-pre4 (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c011342b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011342b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000005   ecx: c02ff608   edx: 00000000
esi: 00000001   edi: 00000005   ebp: 00000001   esp: c1383f2c
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 503, stackpage=c1383000)
Stack: c01e6777 00000003 00000005 00000005 c01e6968 00000005 00000001 00000001 
       cfff9980 c1383f64 c01e6fb3 00000005 00000000 00000000 00000035 00000000 
       00000000 0000000a 00000000 ce5c5bc0 ffffffea c0159560 ce5c5bc0 080dcc08 
Call Trace:    [<c01e6777>] [<c01e6968>] [<c01e6fb3>] [<c0159560>] [<c0139853>]
  [<c010737f>]
Code: 89 02 0f 20 d8 0f 22 d8 a1 84 23 36 c0 31 d2 e9 61 02 02 00 


>>EIP; c011342b <acpi_restore_pmd+b/20>   <=====

>>ecx; c02ff608 <pm_devs_lock+0/10>
>>esp; c1383f2c <_end+ff2e08/104e0f5c>

Trace; c01e6777 <acpi_system_restore_state+17/70>
Trace; c01e6968 <acpi_suspend+68/d0>
Trace; c01e6fb3 <acpi_system_write_sleep+a3/b0>
Trace; c0159560 <proc_file_write+40/50>
Trace; c0139853 <sys_write+a3/130>
Trace; c010737f <system_call+33/38>

Code;  c011342b <acpi_restore_pmd+b/20>
00000000 <_EIP>:
Code;  c011342b <acpi_restore_pmd+b/20>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c011342d <acpi_restore_pmd+d/20>
   2:   0f 20 d8                  mov    %cr3,%eax
Code;  c0113430 <acpi_restore_pmd+10/20>
   5:   0f 22 d8                  mov    %eax,%cr3
Code;  c0113433 <acpi_restore_pmd+13/20>
   8:   a1 84 23 36 c0            mov    0xc0362384,%eax
Code;  c0113438 <acpi_restore_pmd+18/20>
   d:   31 d2                     xor    %edx,%edx
Code;  c011343a <acpi_restore_pmd+1a/20>
   f:   e9 61 02 02 00            jmp    20275 <_EIP+0x20275>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
