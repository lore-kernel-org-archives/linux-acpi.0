From: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Subject: After S3 Resume, doing rmmod cause kernel to OOPS
Date: Fri, 25 Oct 2002 17:25:56 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1DD88DDBBB83D6119C8C00096BB0408F010B8671@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: allowed
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 In latest testing with S3, on resume, virtual memory seems to be corrupted
in some way.  If I try to
unload a module the routine unmap_vm_area() causes an OOPS.  The code is
trying to free the module
structure.  

 I used the fat.o driver as the test subject.  I can normally insmod/rmmod
the driver without
problems.  Once I go into S3 mode and resume (note that I have patched
system such that the system
timer is restarted and IDE disk is reset [working on set of better patches
to submit:]) the system is
generally running (prompt is back, can type command - ls, find, ps, etc.),
once I run rmmod the
OOPS occurs.  The OOPS also occurs when I reboot as module is unloaded by
kernel.  Below is the
OOPS and ksymoops output.  It is probably a problem with low level
suspend/resume code not saving
or restoring something properly.  I am going to look into the low level
code.

 Does anyone have any ideas?

 Thanks,

  Mike Faraoni




  System - Intel Cayman3 motherboard (i810e2 chipset), Celeron processor
           2.5.41 with ACPI patch acpi-20021022



larry> lsmod
Module                  Size  Used by    Not tainted
fat                    34136   0  (unused)
larry> rmmod fat
Unable to handle kernel paging request at virtual address 7f7625f6
 printing eip:
c012fdf0
*pde = 00000000
Oops: 0002

CPU:    0
EIP:    0060:[<c012fdf0>]    Not tainted
EFLAGS: 00010282
eax: c8830000   ebx: c7a946e0   ecx: c8830000   edx: c7dd76d8
esi: c8830000   edi: 00000001   ebp: c757b000   esp: c7591f84
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 171, threadinfo=c7590000 task=c76366e0)
Stack: c01302e7 c7a946e0 c8830000 00000000 00000000 c0130364 c8830000
00000001
       c0118bdf c8830000 00000000 c7590000 bffffe31 00000001 bfffec98
c01071df
       bffffe31 08060008 00000100 bffffe31 00000001 bfffec98 00000081
0000002b
Call Trace: [<c01302e7>]  [<c0130364>]  [<c0118bdf>]  [<c01071df>]
Code: 18 85 f6 75 1e b8 00 e0 ff ff ba fc ff ff ff 21 e0 8b 00 8b
 Segmentation fault
larry>


ksymoops 2.4.4 on i686 2.5.41.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/default/fat.o -o /lib/modules/default/1394npli.o
(specified
)
     -m /boot/System.map-2.5.41 (default)

Unable to handle kernel paging request at virtual address 7f7625f6
c012fdf0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c012fdf0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c8830000   ebx: c7a946e0   ecx: c8830000   edx: c7dd76d8
esi: c8830000   edi: 00000001   ebp: c757b000   esp: c7591f84
ds: 0068   es: 0068   ss: 0068
Stack: c01302e7 c7a946e0 c8830000 00000000 00000000 c0130364 c8830000
00000001
       c0118bdf c8830000 00000000 c7590000 bffffe31 00000001 bfffec98
c01071df
       bffffe31 08060008 00000100 bffffe31 00000001 bfffec98 00000081
0000002b
Call Trace: [<c01302e7>]  [<c0130364>]  [<c0118bdf>]  [<c01071df>]
Code: 18 85 f6 75 1e b8 00 e0 ff ff ba fc ff ff ff 21 e0 8b 00 8b

>>EIP; c012fdf0 <unmap_vm_area+0/190>   <=====
Trace; c01302e7 <__vunmap+57/b0>
Trace; c0130364 <vfree+24/30>
Trace; c0118bdf <sys_delete_module+12f/290>
Trace; c01071df <syscall_call+7/b>
Code;  c012fdf0 <unmap_vm_area+0/190>
00000000 <_EIP>:
Code;  c012fdf0 <unmap_vm_area+0/190>   <=====
   0:   18 85 f6 75 1e b8         sbb    %al,0xb81e75f6(%ebp)   <=====
Code;  c012fdf6 <unmap_vm_area+6/190>
   6:   00 e0                     add    %ah,%al
Code;  c012fdf8 <unmap_vm_area+8/190>
   8:   ff                        (bad)
Code;  c012fdf9 <unmap_vm_area+9/190>
   9:   ff                        (bad)
Code;  c012fdfa <unmap_vm_area+a/190>
   a:   ba fc ff ff ff            mov    $0xfffffffc,%edx
Code;  c012fdff <unmap_vm_area+f/190>
   f:   21 e0                     and    %esp,%eax
Code;  c012fe01 <unmap_vm_area+11/190>
  11:   8b 00                     mov    (%eax),%eax
Code;  c012fe03 <unmap_vm_area+13/190>
  13:   8b 00                     mov    (%eax),%eax


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
