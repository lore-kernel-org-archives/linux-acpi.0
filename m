From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: does cpu_idle() halt CPU?
Date: Wed, 2 Apr 2003 14:20:41 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A245@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] 
> USB preventing the machine from going into C3 is a serious 
> problem. I still don't understand if that's a hardware thing 
> or can we have a more reasonable HCI implementation that 
> doesn't use DMA that much. How does Windows deal with it?

Busmaster PCI devices keep us from using C3, because the CPU needs to be
in C2 or higher to handle bus snoops, needed for cache coherency.

USB is a particular problem, because unlike other devices (like IDE)
which only do busmaster when active, USB does them to its task list *all
the time*. This is inherent in the hardware's design.

Software can mitigate this in several ways. First, if there are no
devices attached, then we can put the host controller into Global
Suspend until a device is inserted. UHCI does not scan its task list
when suspended. Windows does this (and so does the Linux "uhci" driver,
but not "uhci-usb"). Another way is selective suspend. In this case, if
*all* the attached devices suspend themselves, we can suspend the HC.
Linux doesn't do this, but Win XP does. The worst scenario is any active
device on the USB. This rules out any technique to minimize busmaster
activity.

This is one reason why laptops have not switched to using internal USB
connections for mouse and keyboard.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
