From: Wichert Akkerman <wichert-5HFq4VzZ2RFeoWH0uzbU5w@public.gmane.org>
Subject: [2.6.6] Oops when unloading processor module
Date: Sat, 5 Jun 2004 01:28:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040604232817.GA11305@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Since the IWP2100 driver has some issues with the acpi processor
module entering C3 I tried to unload the processor module which
resulted in the oops below.


Badness in remove_proc_entry at fs/proc/generic.c:685
Call Trace:
 [<c017d66a>] remove_proc_entry+0x10a/0x150
 [<e08e5f0e>] acpi_thermal_remove_fs+0x1d/0x2d [thermal]
 [<e08e61a7>] acpi_thermal_remove+0x77/0x80 [thermal]
 [<c01eab6d>] acpi_driver_detach+0x39/0x7c
 [<c01eac21>] acpi_bus_unregister_driver+0x12/0x51
 [<e08e61ba>] acpi_thermal_exit+0xa/0x1e [thermal]
 [<c012bf10>] sys_delete_module+0x150/0x1a0
 [<c0142faa>] do_munmap+0x14a/0x190
 [<c010411b>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address e08c628c
 printing eip:
e08c628c
*pde = 0146e067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<e08c628c>]    Not tainted
EFLAGS: 00010282   (2.6.6) 
EIP is at 0xe08c628c
eax: 00000000   ebx: 002e8456   ecx: 00000008   edx: 00000000
esi: df52e8f8   edi: 002e7f16   ebp: df52e800   esp: c03fbfbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03fa000 task=c0380a40)
Stack: 00099100 00000000 c03fa000 00099100 c0422c80 0046d007 c01020e4 c03fa000 
       c03fc73f c0380a40 00000000 c0419e50 00000018 c03fc490 c0422a80 00000816 
       c010019f 
Call Trace:
 [<c01020e4>] cpu_idle+0x34/0x40
 [<c03fc73f>] start_kernel+0x15f/0x180
 [<c03fc490>] unknown_bootoption+0x0/0x120

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


-- 
Wichert Akkerman <wichert-5HFq4VzZ2RFeoWH0uzbU5w@public.gmane.org>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
