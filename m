From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: 8259A initialization oops after resume
Date: Sun, 15 Jun 2003 14:00:00 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2ptlf3vlb.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

People are getting a particular kind of oops after resuming from S4
(implemented by swsusp). I'm posting this here, because the problem
seems not to be specific to swsusp.

Hopefully some people on this list will know how and why the 8259A needs
to be initialized upon resuming from S4 and why it fails.

The oops is reproducible -- one may do a number of suspend/resume cycles
without it, but once it appears, it will reappear on every subsequent
resume.

Any ideas?

--J.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c02c19d0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02c19d0>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: c11acb20   ebx: 00000000   ecx: 000045f1   edx: c110a5ec
esi: 00000004   edi: 00000004   ebp: 00000001   esp: c30e3f2c
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 5263, stackpage=c30e3000)
Stack: c01cb10b 00000000 00000000 00000004 c01cb2de 00000004 00000004 c30e3f7c 
       c30e3f70 00000001 c12ceb40 c01cbb86 00000004 00000000 c705a120 ffffffea 
       00000001 02000000 c026cc86 c026cb60 00000034 00000000 00000000 c01533f6 
Call Trace:    [<c01cb10b>] [<c01cb2de>] [<c01cbb86>] [<c01533f6>] [<c0139aa6>]
  [<c01086df>]
Code: a4 00 75 2c 8b 4b 04 83 c1 fe 89 4d a4 8d 04 8d 00 00 00 00 


>>EIP; c02c19d0 <init_8259A+0/8c>   <=====

>>eax; c11acb20 <_end+eaf368/1050c8a8>
>>ecx; 000045f1 Before first symbol
>>edx; c110a5ec <_end+e0ce34/1050c8a8>
>>esp; c30e3f2c <_end+2de6774/1050c8a8>

Trace; c01cb10b <acpi_system_restore_state+17/68>
Trace; c01cb2de <acpi_suspend+aa/c0>
Trace; c01cbb86 <acpi_system_write_sleep+da/118>
Trace; c01533f6 <proc_file_write+2a/3c>
Trace; c0139aa6 <sys_write+96/f0>
Trace; c01086df <system_call+33/38>

Code;  c02c19d0 <init_8259A+0/8c>
00000000 <_EIP>:
Code;  c02c19d0 <init_8259A+0/8c>   <=====
   0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
Code;  c02c19d1 <init_8259A+1/8c>
   1:   00 75 2c                  add    %dh,0x2c(%ebp)
Code;  c02c19d4 <init_8259A+4/8c>
   4:   8b 4b 04                  mov    0x4(%ebx),%ecx
Code;  c02c19d7 <init_8259A+7/8c>
   7:   83 c1 fe                  add    $0xfffffffe,%ecx
Code;  c02c19da <init_8259A+a/8c>
   a:   89 4d a4                  mov    %ecx,0xffffffa4(%ebp)
Code;  c02c19dd <init_8259A+d/8c>
   d:   8d 04 8d 00 00 00 00      lea    0x0(,%ecx,4),%eax



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
