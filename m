From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Processor states and USB
Date: Fri, 22 Nov 2002 09:48:04 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A539@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Jan Rychter' <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] 
>    *C3:                  promotion[--] demotion[C2] 
> latency[100] usage[12803374]
> 
> Now, whenever the usb-uhci module is loaded, C3 never gets
> used. C2 is the only state that my CPU is in. If I unload 
> usb-uhci, the
> machine starts using C3.
> 
> Somebody explained to me that this is because the usb-uhci driver uses
> DMA transfers to talk to the hardware and poll it for new devices. Is
> there a patch available that changes this behavior? Anybody found any
> solutions to this?

This is a big problem with USB in general that has no easy solutions. It is
fundamental to the way USB host controllers work that they do busmaster
activity every 1ms to check their in-memory tasklist. However, since the CPU
cannot snoop these accesses in C3, it can only go into C2.

The answer used to be "just don't use USB" but obviously this is becoming
less and less realistic.

One more thing: if you use the other USB HC driver, it has support for USB
Global Suspend. This means that you will be able to have the driver loaded
and enter C3, but as soon as you insert a device, the same problem will
occur.

Regards -- Andy




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
