From: James Courtier-Dutton <James-l7zRWeYnyd2TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: keyboard failure. stack trace mentions "acpi_ns_map_handle_to_node"
Date: Mon, 25 Aug 2003 14:50:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F4A1441.9040503@superbug.demon.co.uk>
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

See below for the stack trace.
Description of symptom: -
At a random time after power on, the keyboard stops functioning.

Details: -
I have a normal keyboard plugged into the keyboard socket(ps/2 bus 
socket i think) of the computer.
I have a USB mouse.
At a random time after power on, the keyboard stops functioning.
The mouse still works, I can ssh in from another computer and type 
commands, so the computer is not in a "hung" state. It is just that the 
keyboard device has failed for some reason. If I try to kill -9 all the 
processes running under X, not all of them are killed.
The problem seems to be linked to enabling power save features in the 
BIOS. e.g. Getting the fan to slow down. Getting the CPU to slow down. 
etc., but the fan should speed up if the CPU gets too hot.

Some extract from dmesg: -
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (58 C)

My motherboard is an ABIT IC-G. If has 4 FAN connectors( NorthBridge, 
CPU, System and one other FAN connector.), but dmesg seems to only find 
one FAN.

Possible Cause: -
Maybe the BIOS is telling us that it needs to speed up a FAN, and as 
ACPI has not detected that particular fan, acpi crashes.

Kernel version: -
uname -a
Linux new 2.6.0-test4 #1 SMP Sun Aug 24 18:27:51 BST 2003 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux



Unable to handle kernel paging request at virtual address 5a5a5a5a
  printing eip:
c0240ff0
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0240ff0>]    Not tainted
EFLAGS: 00010246
EIP is at acpi_ns_map_handle_to_node+0x13/0x22
eax: 00000000   ebx: f7ee7e6c   ecx: f7ffef70   edx: 5a5a5a5a
esi: 5a5a5a5a   edi: f7ee7e6c   ebp: f7ee7e2c   esp: f7ee7e2c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 6, threadinfo=f7ee6000 task=c1a91000)
Stack: f7ee7e44 c02403a3 5a5a5a5a f7ee7e6c f78c60a4 f78c986c f7ee7e5c 
c024a6a2
        5a5a5a5a c0251aa6 f7ee7e6c f7ee7e88 f7ee7e74 c024e180 5a5a5a5a 
f7ee7e6c
        00000000 00000000 f7ee7e8c c024e30c 5a5a5a5a f7ee7e88 00000000 
00000000
Call Trace:
  [<c02403a3>] acpi_get_data+0x34/0x61
  [<c024a6a2>] acpi_bus_get_device+0x1e/0x38
  [<c0251aa6>] acpi_bus_data_handler+0x0/0x5
  [<c024e180>] acpi_power_get_context+0x24/0x3c
  [<c024e30c>] acpi_power_off_device+0x1f/0xa7
  [<c024e495>] acpi_power_transition+0x8f/0xb4
  [<c024a8a6>] acpi_bus_set_power+0xe1/0x137
  [<c02503ef>] acpi_thermal_active+0x89/0xcd
  [<c02506d7>] acpi_thermal_check+0x290/0x2c0
  [<c02511d5>] acpi_thermal_notify+0x4a/0x9d
  [<c0237f7b>] acpi_ev_notify_dispatch+0x4e/0x73
  [<c0233d58>] acpi_os_execute_deferred+0x10/0x1b
  [<c0138170>] worker_thread+0x1e6/0x346
  [<c0233d48>] acpi_os_execute_deferred+0x0/0x1b
  [<c012171f>] default_wake_function+0x0/0x2e
  [<c010a542>] ret_from_fork+0x6/0x14
  [<c012171f>] default_wake_function+0x0/0x2e
  [<c0137f8a>] worker_thread+0x0/0x346
  [<c0108245>] kernel_thread_helper+0x5/0xb

Code: 80 3a aa 0f 44 c2 5d c3 a1 4c 12 45 c0 eb f7 55 89 e5 8b 45



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
