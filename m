From: Hendrik Brummermann <nhb_web-i47jiTeKxPI@public.gmane.org>
Subject: 2.4.21 RC3 Oops: __request_resource+49/70
Date: Wed, 18 Jun 2003 16:30:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EF0777B.3020805@nexgo.de>
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

Hello,

I have got several reproducable kernel oops while booting if ACPI is
enabled:

| Unable to handle kernel paging request at virtual address ffff0906
| <0>Kernel panic: Attempted to kill init!
| <1>Unable to handle kernel paging request at virtual address ffffe030


This happens if I compile with "ACPI Support" but without anything else
enabled. If I enable "CPU Enumeration Only" the oops does not occure.
pci=noacpi does not hide the problem, acpi=off however does.

I am using Debian with a vanilla Linux 2.4.21 patched with
acpi-20030523-2.4.21-rc3.diff on a notebook with Pentium 4 processor and
a SiS mainbord.


The first oops after booting:
============================

ksymoops 2.4.8 on i686 2.4.21.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.21/ (default)
      -m /System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
Warning (compare_maps): ksyms_base symbol
br_handle_frame_hook_R__ver_br_handle_frame_hook not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
br_ioctl_hook_R__ver_br_ioctl_hook not found in System.map.  Ignoring
ksyms_base entry

[There are about 66 simmilar warnings. What does this mean? I am sure,
that I use the right System.map file]

Unable to handle kernel paging request at virtual address ffff0906
c01206a9
*pde = 00004063
Oops: 0000
CPU:    0
EIP:    0010:[<c01206a9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: ffff0902   ebx: d1ffffff   ecx: d1000000   edx: c040ab7c
esi: c159153c   edi: c0005014   ebp: c15905e0   esp: dfdeff50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dfdef000)
Stack: c159153c 00000008 c1591400 c0120739 c040ab7c c159153c c045f15c
c040ab7c
        c159153c 00000001 dfdee000 c0459fb8 00000000 c1590560 c045f12b
c159056c
        c011b03f 0000000a dfdee000 c0459fb8 c0105000 0008e000 c045f39f
c0421f80
Call Trace:    [<c0120739>] [<c011b03f>] [<c0105000>] [<c0279ce9>]
[<c0105097>]
   [<c0105000>] [<c01058ee>] [<c0105060>]
Code: 39 58 04 77 0a 39 48 08 8d 78 14 72 ed eb d8 89 46 14 31 c0


>>EIP; c01206a9 <__request_resource+49/70>   <=====

>>edx; c040ab7c <iomem_resource+0/1c>

Trace; c0120739 <request_resource+29/50>
Trace; c011b03f <printk+14f/180>
Trace; c0105000 <_stext+0/0>
Trace; c0279ce9 <pci_init+9/60>
Trace; c0105097 <init+37/1b0>
Trace; c0105000 <_stext+0/0>
Trace; c01058ee <arch_kernel_thread+2e/40>
Trace; c0105060 <init+0/1b0>

Code;  c01206a9 <__request_resource+49/70>
00000000 <_EIP>:
Code;  c01206a9 <__request_resource+49/70>   <=====
    0:   39 58 04                  cmp    %ebx,0x4(%eax)   <=====
Code;  c01206ac <__request_resource+4c/70>
    3:   77 0a                     ja     f <_EIP+0xf>
Code;  c01206ae <__request_resource+4e/70>
    5:   39 48 08                  cmp    %ecx,0x8(%eax)
Code;  c01206b1 <__request_resource+51/70>
    8:   8d 78 14                  lea    0x14(%eax),%edi
Code;  c01206b4 <__request_resource+54/70>
    b:   72 ed                     jb     fffffffa <_EIP+0xfffffffa>
Code;  c01206b6 <__request_resource+56/70>
    d:   eb d8                     jmp    ffffffe7 <_EIP+0xffffffe7>
Code;  c01206b8 <__request_resource+58/70>
    f:   89 46 14                  mov    %eax,0x14(%esi)
Code;  c01206bb <__request_resource+5b/70>
   12:   31 c0                     xor    %eax,%eax

  <0>Kernel panic: Attempted to kill init!
  <1>Unable to handle kernel paging request at virtual address ffffe030

66 warnings issued.  Results may not be reliable.




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
