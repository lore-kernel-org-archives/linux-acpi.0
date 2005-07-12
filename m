From: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Subject: Thinkpad A21m oops when go to sleep second time
Date: Tue, 12 Jul 2005 09:00:39 +0200
Message-ID: <42D36A97.2080807@mydatex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000006020401010604090402"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006020401010604090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I have start convert my 2.4.x APM kernel to ACPI and found the OOPS in 
kernel. I have compiled kernel 2.6.12.1 and suspend to RAM and to disk 
  works. But if I go to S3 second time kernel OOPS. OOPS attached. If 
additionail info is needed let me know.


			Thanks
				Dan



--------------000006020401010604090402
Content-Type: text/plain;
 name="A21m.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="A21m.oops"

ksymoops 2.4.9 on i686 2.6.12.1.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12.1/ (default)
     -m /boot/System.map-2.6.12.1 (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
eax: 00000000  ebx:c039e5cc ecx: 00000000 edx: 00000003
esi: c039e9f8  edi:c039e9f8 ebp: c0320620 esp: ca803e4c
ds: 007b es:007b ss:0068
Stack: 00000000 00000000 ca802000 cbf8d028 c020c9be c039e9f8 00000000 c039e9f8
       c03a0b08 cbc2eaa8 00000003 c0210658 c03206c0 c039e9f8 cbc2caa8 00000003
       00000003 c0215323 cbc2eaa8 00000003 00000002 cbc2eaa8 00000000 c0216dbf
Call Trace:
[<c020c9be>] uart_suspend_port+0xde/0xf0
[<c0210658>] serial8250_suspend+0x68/0x70
[<c0215323>] paltform_suspend+0x43/0x80
[<c0216dbf>] suspend_device+0xaf/0x0xc0
[<c01bc22a>] kobject_get+0x1a/0x30
[<c0216c3c>] device_suspend+0x6c/0x0x160
[<c0136f47>] suspend_preparde+0x67/0xb0
[<c0137063>] enter_state+0x33/0x70
[<c01e4dff>] acpi_suspend+0x2a/0x3b
[<c01e4ef6>] acpi_system_write_sleept+0x72/0x84
[<c015998e>] vfs_write+0xae/0x130
[<c0159ae1>] sys_write+0x51/0x80
[<c0103185>] sys_call+0x7/0xb
Code: 2a 39 00 74 18 89 74 24 94 89 1c 24 e8 47 fe ff ff 8b 5c 24 08 8b 74 24 0c
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c039e5cc <irq_lists+c/380>
>>esi; c039e9f8 <serial8250_ports+b8/2280>
>>edi; c039e9f8 <serial8250_ports+b8/2280>
>>ebp; c0320620 <serial8250_pops+0/50>
>>esp; ca803e4c <pg0+a456e4c/3fc51400>

Trace; c020c9be <uart_suspend_port+de/f0>
Trace; c0210658 <serial8250_suspend+68/70>
Trace; c0215323 <platform_suspend+43/80>
Trace; c0216dbf <suspend_device+af/c0>
Trace; c01bc22a <kobject_get+1a/30>
Trace; c0216c3c <device_pm_add+6c/a0>
Trace; c0136f47 <suspend_prepare+67/b0>
Trace; c0137063 <enter_state+33/70>
Trace; c01e4dff <acpi_suspend+2a/3b>
Trace; c01e4ef6 <acpi_system_write_sleep+72/84>
Trace; c015998e <vfs_write+ae/130>
Trace; c0159ae1 <sys_write+51/80>
Trace; c0103185 <syscall_call+7/b>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   2a 39                     sub    (%ecx),%bh
Code;  00000002 Before first symbol
   2:   00 74 18 89               add    %dh,0xffffff89(%eax,%ebx,1)
Code;  00000006 Before first symbol
   6:   74 24                     je     2c <_EIP+0x2c>
Code;  00000008 Before first symbol
   8:   94                        xchg   %eax,%esp
Code;  00000009 Before first symbol
   9:   89 1c 24                  mov    %ebx,(%esp)
Code;  0000000c Before first symbol
   c:   e8 47 fe ff ff            call   fffffe58 <_EIP+0xfffffe58>
Code;  00000011 Before first symbol
  11:   8b 5c 24 08               mov    0x8(%esp),%ebx
Code;  00000015 Before first symbol
  15:   8b 74 24 0c               mov    0xc(%esp),%esi


1 warning issued.  Results may not be reliable.

--------------000006020401010604090402--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
