From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Sun, 22 Oct 2006 17:09:53 +0200
Message-ID: <1161529793.12599.36.camel@sublime.site>
References: <20061020092547.519734000@neutrino.suse.de>
	 <1161338381.32262.114.camel@queen.suse.de>
	 <200610201055.33931.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx02.qsc.de ([213.148.130.14]:53207 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751787AbWJVMYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Oct 2006 08:24:31 -0400
In-Reply-To: <200610201055.33931.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: fseidel@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 2006-10-20 at 10:55 -0600, Bjorn Helgaas wrote:
> On Friday 20 October 2006 03:59, Thomas Renninger wrote:
> > On Fri, 2006-10-20 at 11:25 +0200, fseidel@suse.de wrote:
> > > Currently acpi_bus_register_driver only reports an error
> > > (-ENODEV) if acpi_disabled is true,
> > > but many acpi drivers also depend on a negative error
> > > value if no driver could be attached to a device
> > > (as e.g. driver/acpi/asus_acpi.c).
> > > This patch adds this again (without changing return type
> > > of acpi_driver_attach for this).
> 
> I object to this.
> 
> > acpi_bus_register_driver must return -ENODEV when no device with
> > matching HID was found. E.g. battery also should currently get always
> > loaded even a system never has one.
> 
> If the driver wants to unload if it doesn't find any devices,
> it can easily do so by counting calls to its add() method, as
> asus_acpi.c currently does.  I don't think that's a good long-
> term solution, though.  I think it would be better to have a
> hotplug scheme that loads the driver when the hardware is
> found, like we do for PCI.
> 
> > driver_attach returned the amount of found devices in past, this was
> > changed recently (can't find the patch/mail) right now. This change
> > broke things and should get corrected by these patches.
> 
> Here's my patch that results in the current behavior:
>   http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9d9f749b316ac21cb59ad3e595cbce469b409e1a
> 
> What did it break?  I haven't seen any reports of problems.
asus_acpi init func returns the return value of bus_register_driver()
> 
> I think it's a mistake to have acpi_bus_register_driver() return
> any indication of how many devices were claimed.  If the driver
> needs to know how many devices it claimed, it can easily count
> them in its add() method.  Returning the count from register_driver()
> is racey if devices can be hot-plugged.
I think this is wrong.
It needs not to return the number of claimed devices, it needs to return
-ENODEV if no device will ever exist. Not sure about devices that get
added
by dynamically loaded SSDTs later, but this also cannot be handled by
ugly
workarounds in hotpluggable device drivers as it is currently done (e.g.
walk namespace in memory hotplug).

The whole culprit to hotplug design (and you are right, this patch also
does not
work because of this) is this line in acpi_driver_attach:
                if (dev->driver || !dev->status.present)
                        continue;
If a device is not present, but exists in ACPI namespace, .add function
must still be
called.
Can you/someone have a look at my mail a month ago:
http://marc.theaimsgroup.com/?l=linux-acpi&m=115833743117570&w=2

I think this is the right way to cleanup things to better integrate for
hotplug
design.
Not sure about the .start and .stop funcs, I think they should be thrown
out.
Currently they are nearly the same than .add .remove and are useless.
Whether the status of the device changed to (un-)present can be
determined in
the notify handler of the driver anyway.

Again, if you think I haven't overseen anything there, I can come up
with a
patch for latest kernel and adjusting all modules to:
  - always call .add for each device listed in ACPI namespace, present
or not.
  - throws out currently unused .start/.stop callbacks in acpi_driver
struct
  - moves installing notify handler from driver to bus_register_driver
if a acpi_driver
    struct has a .notify callback associated to it. Use the driver_data
that possibly
    got filled up in .add func of the driver of each found device
    and pass it as notifier callback data.

If this is done:
  - batteries that are not present at boot time, but are added at later
time will
    be recognised and just work fine
  - memory hotplug (probably also container.c) can be cleaned up and
also make
    use of the bus_register_driver without bad hacks.

Thanks,

   Thomas

