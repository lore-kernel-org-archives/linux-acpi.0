From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: [rfc] generic testing ACPI module
Date: Mon, 08 Mar 2004 23:31:52 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078781511.2203.112.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hello to all acpi developers,

I have an idea and I want your comments about it.
I think it would be nice and usefull to have a generic acpi testing
module like other testing modules in kernel (scsi and pci hotplug just
came to my mind, but maybe there are some others too).
The purpose is this:
A lot of vendors have different acpi devices that can be controlable
with acpi, and can send notification, but they are not universal
available on all platforms and usualy differ from vendor to vendor.

For instance, I have an IBM T40 which generate ACPI notification when I
want to hotswap the CDROM with a DVD or some other device in the lateral
bay. It would be nice if I would receive via acpid such notifications to
be able to react acordingly like hdparm -U and tell udev to remove the
/udev/hdc file if is necessary, or just rescan the ide bus (idectl 1
rescan).

Other example is when I want to execute arbitrary methods exported by
ACPI like I have for instance for sound volume/mute, wireless on/off and
other methods.

It is not practical to write a driver for each device outhere just for
testing what works and if works, but we could have instead a generic way
to map some methods to some functions, and install events receivers for
some notify events.
A lot of info about one ACPI system can be gathered by compiling acpi
with debug info and just 
echo 0x10 > /proc/acpi/debug_level 
echo 0x1f > /proc/acpi/debug_layer

This way we can test ourselves what can be done with ACPI, and we can
speed the development process.
Moreover, if this generic interface is made by someone who knows well
the ACPI implementation in kernel, then we have the chance that it will
not introduce more bugs than a driver for a specific vendor/platform
which could be made by people with access to that hardware, but not
necessary experts in kernel coding (like myself).

The proposition is this:
A module that exports some files in let say /proc/acpi/testing/
directory.
One of the files could be a file where we can insert the full path name
of a method we want to run, and after that the driver will make that
full path another file in /proc/acpi/testing/ and when we access that
file, we actualy run the acpi method.

Example: 
echo \_SB_.PCI0.LPC_.EC__._Q13 > /proc/acpi/testing/new_method
and a new file with the name \_SB_.PCI0.LPC_.EC__._Q13 is created in
/proc/acpi/testing/ directory. When we cat this new file, we'll get the
resut of executing that method.

Another file could be a file where we can insert the name/pnpid/node of
a device we want to receive notifies from.

Example:
echo MSTR > /proc/acpi/testing/new_system_notify, and when this device
receives a system notify it will pass this to acpid.

or:

echo dfee6f28 > /proc/acpi/testing/new_system_notify_node and when this
node receives a system notify it will pass this to acpid.

or
echo MSTR > /proc/acpi/testing/new_device_notify, and when this device
receives a "device notify" it will pass this to acpid.


I want to hear some opinions about this idea, if this could be usefull
for other people too, or is just my imagination that says this.
And how feasible is to implement it. I think it should not be too hard
for someone with knowledge of acpi subsystem in kernel.
Should be about the size of AC module.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
