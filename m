From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: PCI power state mapping
Date: Mon, 26 Jul 2004 17:53:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410528F5.1060104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi!

I've been trying to get suspend-to-ram to work on my laptop and found 
some weird behavior with the handling of PCI power states. I know this 
mailing list is for ACPI, not PCI, but I figure that you are the 
resident experts on all power related matters. :)

As far as I know the kernel has three different power modes. The ACPI 
ones (S0-S5), the linux ones (PM_SUSPEND_*) and the PCI ones (D0-D3). 
Mapping between the first two is done by the ACPI routines. But mapping 
between kernel power states and PCI is not done at all. The 
PM-enumerations are propagated all the way down to 
pci_set_power_state(). I.e. the function expects PCI states but gets 
kernel states. Both happen to be four levels with less power with 
increasing value so one might not notice it.

Now for the problem. Most PCI devices do not support state D1 and D2 
(which would be called when entering PM_SUSPEND_STANDBY or 
PM_SUSPEND_MEM). This causes the pci_set_power_state() to fail and the 
suspend to be aborted. I haven't found any good documentation about the 
PCI power states but from what I can gather D0 is full power, D1-D2 are 
used during normal operation to conserve some power (when the device is 
idle I guess) and D3 when it enters some form of suspend. So 
PM_SUSPEND_MEM should probably put the devices in D3, not D2. Microsoft 
seem to increase the state until it finds on the device supports:

"For example, if system power state S1 can be mapped into D1, D2, or D3 
power state for the device, the operating system selected the highest 
supported and valid device power state for mapping. In this example, S1 
would map to D1. If the device supports only D0 and D3 power states, the 
system power state S1 would be mapped to D3 for the device."
 From http://www.microsoft.com/whdc/system/bus/PCI/pciids.mspx.

Windows has something called system-to-device (SxD) mapping which seems 
to handle most of this. I can't find the equivalent in linux ACPI 
implementation. To me, this looks like a rather crucial part of the system.

I did a dirty hack in the pci_set_power_state() which does a simple 
escalation of the power state based on device capabilities. That, at 
least, got the suspend to go through without an abort. Still hangs the 
machine instead of suspending it though, which brings me to another 
question:

Shouldn't all devices (or at least those with PM functions) on the PCI 
bus be shut down? As it is now it is up to the driver to power down the 
devices. Devices without drivers, or with drivers that forget to power 
down the unit, are left turned on. Couldn't this be a source of problem 
when getting the machine to suspend? PCI suspend doesn't require 
explicit driver support so it should be handled by the PCI subsystem.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
