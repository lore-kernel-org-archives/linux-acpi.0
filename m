From: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 2.6.0-test2: Lost USB mouse after resuming from S3
Date: Thu, 7 Aug 2003 11:56:12 +0100 (WAT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.21.0308071124530.7454-100000@vista.rtm.home>
References: <E19kbYw-0001pW-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E19kbYw-0001pW-00-ek0oC1U1TqqnvZpeIfgr/KQD96bmaF075NbjCUgZEJk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Date: Wed, 6 Aug 2003 14:39:41 -0700
> From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
> To: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
> Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
>    
> Subject: [ACPI] Re: 2.6.0-test2: Lost USB mouse after resuming from S3
> 
> On Thu, Aug 07, 2003 at 12:37:31AM +0800, Michael Frank wrote:
> > Causes are that usb-host controller does no handle S3 yet _plus_
> > possibly (depending on your hardware) loss of PCI interrupt links as
> > current ACPI does not resume those.
> 
> Known issue, please unload the usb modules before suspending them.
> 
> The upcoming suspend patches will allow us to fix this "properly",
> please give us a few weeks :)

I hope you have a chance to look at a uhci/usbnet problem I have found.  
If I connect and disconnect my Zaurus 5500 ...

kernel: usb0: register usbnet usb-00:1d.0-1, Sharp Zaurus SL-5x00
... [ping a few packets] ...
vista kernel: usb0: unregister usbnet usb-00:1d.0-1, Sharp Zaurus SL-5x00

I can unload uhci (kind of):

vista kernel: usb.c: USB disconnect on device 00:1d.2-0 address 1
vista kernel: usb.c: USB bus 3 deregistered
vista kernel: kmem_cache_destroy: Can't free all objects c158acd0
vista kernel: uhci: not all urb_priv's were freed
vista kernel: usb.c: deregistering driver usbdevfs
vista kernel: usb.c: deregistering driver hub
vista kernel: Swsusp 1.1-rc1: Initiating a software_suspend cycle.

and then on the resume uhci crashes on the load attempt:

vista kernel: usb.c: registered new driver usbdevfs
vista kernel: usb.c: registered new driver hub
vista kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
vista kernel: kernel BUG at slab.c:815!
vista kernel: invalid operand: 0000
vista kernel: CPU:    0
vista kernel: EIP:    0010:[kmem_cache_create+761/836] Tainted: G Z
vista kernel: EFLAGS: 00010246
vista kernel: eax: 00000000   ebx: c158ad40 ecx: c158ada8   edx: c158ad38 
vista kernel: esi: c158ad32   edi: e0d7a99a ebp: 0000003c   esp: dc26def0
vista kernel: ds: 0018   es: 0018   ss: 0018
vista kernel: Process modprobe.moduti (pid: 3354, stackpage=dc26d000)
vista kernel: Stack: fffffff4 00000001 00000001 ffffffea dc26df0c c158ad60 00000004 00000034 
vista kernel:        e0d796a0 e0d7a98c 0000003c 00000080 00020000 00000000 00000000 e0d75000 
vista kernel:        c0117b0d dc26c000 0000057a 08075f30 bfffc168 000059c8 dc280000 00000060 
vista kernel: Call
Trace:    [hid:__insmod_hid_O/lib/modules/2.4.22-rc1/kernel/drivers/usb/hi+-690528/96]
[hid:__insmod_hid_O/lib/modules/2.4.22-rc1/kernel/drivers/usb/hi+-685684/96]
[sys_init_module+1365/1536]
[hid:__insmod_hid_O/lib/modules/2.4.22-rc1/kernel/drivers/usb/hi+-708512/96]
[system_call+51/56]
vista kernel: 
vista kernel: Code: 0f 0b 2f 03 c0 bf 24 c0 8b 12 8b 02 0f 18 00 81 fa e8 c3 28 

This does -not- happen using usb-uhci as enabled by the (0619) acpi patch:

vista kernel: usb.c: USB bus 3 deregistered
vista kernel: usb.c: deregistering driver usbdevfs
vista kernel: usb.c: deregistering driver hub
vista kernel: Swsusp 1.1-rc1: Initiating a software_suspend cycle.

...

vista kernel: usb.c: registered new driver usbdevfs
vista kernel: usb.c: registered new driver hub
vista kernel: usb-uhci.c: $Revision: 1.275 $ time 23:16:36 Aug  6 2003
vista kernel: usb-uhci.c: High bandwidth mode enabled
vista kernel: PCI: Setting latency timer of device 00:1d.0 to 64
vista kernel: usb-uhci.c: USB UHCI at I/O 0xefe0, IRQ 11
vista kernel: usb-uhci.c: Detected 2 ports

the above syslog excerpts are from 2.4.22rc1 (no acpi patch) and 2.4.21
(acpi 20030619).  Any suggestions, or hope for a fix?

thanks,

rob.







-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
