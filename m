From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: 2.5.51: sleep broken
Date: Fri, 13 Dec 2002 16:04:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212131604.23595.p_christ@hol.gr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A591@orsmsx119.jf.intel.com> <200212130111.32710.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BR92QMYLISO431BK4C5T"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212130111.32710.p_christ-U04EIuiosng@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_BR92QMYLISO431BK4C5T
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit

>
> Sorry, I was quite lazy debugging that. Seems though that 20021205 doesn't
> have that. I'll let you know if it should be pushed into 2.5.52..
>
That line should go on, it works.
However, it seems that something is still broken w. sleep.  
Yesterday, 1 out of 2 attempts to sleep,wake failed. The machine froze, with 
an apparent race (the cpu heated up).
Today, I could get an OOPS in 1 of 3 attempts to sleep. I give (early) the 
decoded info (I have no ksyms!? ). Perhaps you could make out sth of the 
trace..

--------------Boundary-00=_BR92QMYLISO431BK4C5T
Content-Type: text/plain;
  charset="iso-8859-7";
  name="oops.dec"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops.dec"

ksymoops 2.4.5 on i686 2.5.51.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.51/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI: IOCK error (debug interrupt?)
CPU:    0
EIP:    0060:[acpi_hw_register_read+207/528]    Not tainted
EIP:    0060:[<c01c555f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000000   ebx: 00000000   ecx: cff54100   edx: 00000000
esi: 00000001   edi: 00000001   ebp: c4fb5eb8   esp: c4fb5e94
ds: 0068   es: 0068   ss: 0068
Stack: 00000010 c4fb5ea8 cff54100 00000000 00feebc0 00000000 00000000 c4fb5ef4
       c032f078 c4fb5edc c01c5271 00000000 00000001 c4fb5ecc 00000000 c4fb5ef4
       c032f0a0 c032f0a8 c4fb5f08 c01c5d9b 00000006 c4fb5ef4 00000001 00003001
Call Trace: [acpi_get_register+97/160]  [acpi_enter_sleep_state+507/608]  [acpi_system_suspend+76/80]  [acpi_suspend+135/192]  [acpi_system_write_sleep+171/224]  [vfs_write+175/288]  [sys_write+60/96]  [syscall_call+7/11]
Call Trace: [<c01c5271>]  [<c01c5d9b>]  [<c01dca9c>]  [<c01dcb27>]  [<c01dcccb>]  [<c014c71f>]  [<c014c82c>]  [<c010a203>]
Code: eb 9f a1 50 5b 39 c0 0f b6 50 58 05 94 00 00 00 c7 04 24 10


>>EIP; c01c555f <acpi_hw_register_read+cf/210>   <=====

>>ecx; cff54100 <END_OF_CODE+fba9e8c/????>
>>ebp; c4fb5eb8 <END_OF_CODE+4c0bc44/????>
>>esp; c4fb5e94 <END_OF_CODE+4c0bc20/????>

Trace; c01c5271 <acpi_get_register+61/a0>
Trace; c01c5d9b <acpi_enter_sleep_state+1fb/260>
Trace; c01dca9c <acpi_system_suspend+4c/50>
Trace; c01dcb27 <acpi_suspend+87/c0>
Trace; c01dcccb <acpi_system_write_sleep+ab/e0>
Trace; c014c71f <vfs_write+af/120>
Trace; c014c82c <sys_write+3c/60>
Trace; c010a203 <syscall_call+7/b>

Code;  c01c555f <acpi_hw_register_read+cf/210>
00000000 <_EIP>:
Code;  c01c555f <acpi_hw_register_read+cf/210>   <=====
   0:   eb 9f                     jmp    ffffffa1 <_EIP+0xffffffa1> c01c5500 <acpi_hw_register_read+70/210>   <=====
Code;  c01c5561 <acpi_hw_register_read+d1/210>
   2:   a1 50 5b 39 c0            mov    0xc0395b50,%eax
Code;  c01c5566 <acpi_hw_register_read+d6/210>
   7:   0f b6 50 58               movzbl 0x58(%eax),%edx
Code;  c01c556a <acpi_hw_register_read+da/210>
   b:   05 94 00 00 00            add    $0x94,%eax
Code;  c01c556f <acpi_hw_register_read+df/210>
  10:   c7 04 24 10 00 00 00      movl   $0x10,(%esp,1)


--------------Boundary-00=_BR92QMYLISO431BK4C5T--



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
