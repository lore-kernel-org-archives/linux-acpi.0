From: Sander Smeenk <ssmeenk-ntXksADE/7Pk1uMJSBkQmQ@public.gmane.org>
Subject: 2.4.21-pre4 acpi 20030122 on Toshiba laptop
Date: Thu, 27 Feb 2003 22:05:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030227210540.GP21631@freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I want to let you know what my experiences are with ACPI on my Toshiba
Satellite Pro 6000 laptop. I always had trouble with rebooting, and shutting
down, it just didn't happen.

With this kernel the machine does shut down properly and reboots
properly, so that is fixed now. Better not touch it :p

I tried fixing my DSDT by disassembling it, fixing the warnings that
turned up with iasl, and putting it back in the kernel with the
appropriate patches, but it didn't change a thing, so it seems.
Ofcourse I don't know if I fixed it The Right Way(TM). 

Okay, next I tried 'sleep modes'. Because I want to be able to suspend
my laptop. cat /proc/acpi/sleep displays:
| S0 S3 S4 S4Bios S5

S0     = Default operation, so that works :p
S3     = echo: write error: no such device
S4     = Laptop suspends, wakes up, but after waking up, it hangs
S4Bios = See S4, exactly the same behaviour
S5     = Kernel Oops:

| kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
| kernel:  printing eip:
| kernel: c01130cb
| kernel: *pde = 00000000
| kernel: Oops: 0002
| kernel: CPU:    0
| kernel: EIP:    0010:[acpi_restore_pmd+11/32]    Not tainted
| kernel: EFLAGS: 00013002
| kernel: eax: 00000000   ebx: 00000001   ecx: 00000005   edx: 00000000
| kernel: esi: 00000005   edi: 00000005   ebp: c129c7e4   esp: c8dd3f28
| kernel: ds: 0018   es: 0018   ss: 0018
| kernel: Process zsh (pid: 511, stackpage=c8dd3000)
| kernel: Stack: c01ddab7 00000001 c01ddc07 00000005 00000005 00000002 c8dd3f50 c8dd3f60
| kernel:        c01de49c 00000005 02000000 c02e3acd c02e39bc c9149104 00000a35 00000000
| kernel:        00000000 c9149104 00000000 c8d52964 ffffffea 00000002 c0156a70 c8d52964
| kernel: Call Trace:    [__constant_c_and_count_memset+106/115] [acpi_suspend+32/155] [acpi_system_write_sleep+168/251] [proc_file_write+64/80] [sys_write+163/320]
| kernel:   [system_call+51/56]
| kernel:
| kernel: Code: 89 02 0f 20 d8 0f 22 d8 a1 84 d9 36 c0 31 d2 e9 a1 f1 01 00

I hope this information helps!

Regards,
Sander

-- 
| I can roleplay, I can frag. I can PK while you lag!
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
