From: Anders Hermansen <anders-QdrXXtlUBfI@public.gmane.org>
Subject: Suspend on IBM ThinkPad T40p, almost there.
Date: Wed, 21 Apr 2004 18:31:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040421163107.GA24699@online.no>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

I'm trying to get my IBM laptop to suspend (S3). I have tried 2.6.x
kernels before with no luck (hanging on resume).

Today I tried 2.6.6-rc2-mm1 and it works :) It works from X too.
I'm running Debian GNU/Linux with mixed testing/unstable setup. The
method I use to put the machine to sleep is: echo 3 > /proc/acpi/sleep

I have not tried USB after resuming, but I suspect it does not work
because of an kernel oops i get:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01b9a9b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[get_kobj_path_length+26/49]    Not tainted VLI
EFLAGS: 00010246   (2.6.6-rc2-mm1) 
EIP is at get_kobj_path_length+0x1a/0x31
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c5f35738
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c5f81dfc
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 493, threadinfo=c5f80000 task=def871b0)
Stack: 0000010c c5ad4019 c5ad4000 c3eb9200 c01b9c55 c03444c0 c5f35738 0000010c
       e1982460 c015af17 c5f81e3c c5ad4000 00000000 c030ba20 e197f143 00000000
       c0162b2a c5f35738 c5f35730 e1982400 e1982460 c01b9de3 c02daa76 c03444c0
Call Trace:
 [kset_hotplug+340/653] kset_hotplug+0x154/0x28d
 [lookup_hash+31/35] lookup_hash+0x1f/0x23
 [dput+34/616] dput+0x22/0x268
 [kobject_hotplug+85/87] kobject_hotplug+0x55/0x57
 [kobject_del+27/51] kobject_del+0x1b/0x33
 [class_device_del+136/174] class_device_del+0x88/0xae
 [pg0+559628779/1069776896] hci_unregister_dev+0x10/0xa1 [bluetooth]
 [pg0+559312323/1069776896] hci_usb_disconnect+0x35/0x7e [hci_usb]
 [pg0+558698720/1069776896] usb_unbind_interface+0x7a/0x7c [usbcore]
 [device_release_driver+100/102] device_release_driver+0x64/0x66
 [bus_remove_device+85/150] bus_remove_device+0x55/0x96
 [device_del+93/155] device_del+0x5d/0x9b
 [device_unregister+19/35] device_unregister+0x13/0x23
 [pg0+558723051/1069776896] usb_disable_device+0x71/0xac [usbcore]
 [pg0+558701501/1069776896] usb_disconnect+0x9b/0xe8 [usbcore]
 [pg0+558710243/1069776896] hub_port_connect_change+0x26f/0x274 [usbcore]
 [pg0+558708532/1069776896] hub_port_status+0x45/0xb0 [usbcore]
 [pg0+558711053/1069776896] hub_events+0x325/0x398 [usbcore]
 [pg0+558711213/1069776896] hub_thread+0x2d/0xe4 [usbcore]
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [default_wake_function+0/18] default_wake_function+0x0/0x12
 [pg0+558711168/1069776896] hub_thread+0x0/0xe4 [usbcore]
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Code: ff 85 c0 89 c3 74 e4 89 34 24 e8 19 72 fc ff eb da 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 31 db 8b 54 24 18 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 5f

Is this ACPI relevant or should I ask the usb people?
Is there any more information I should provide?


Thanks for your help,
Anders

--
Anders Hermansen
YoYo Mobile as


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
