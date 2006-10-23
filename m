From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Mon, 23 Oct 2006 09:34:12 -0600
Message-ID: <200610230934.12775.bjorn.helgaas@hp.com>
References: <20061020092547.519734000@neutrino.suse.de> <200610201055.33931.bjorn.helgaas@hp.com> <1161529793.12599.36.camel@sublime.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:26570 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S964955AbWJWPeS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Oct 2006 11:34:18 -0400
In-Reply-To: <1161529793.12599.36.camel@sublime.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: fseidel@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sunday 22 October 2006 09:09, Thomas Renninger wrote:
> On Fri, 2006-10-20 at 10:55 -0600, Bjorn Helgaas wrote:
> > Here's my patch that results in the current behavior:
> >   http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9d9f749b316ac21cb59ad3e595cbce469b409e1a
> > 
> > What did it break?  I haven't seen any reports of problems.
> asus_acpi init func returns the return value of bus_register_driver()

I think the current tree contains a merge error in asus_acpi_init().
It says:

	if (!asus_hotk_found) {
		...
		return result;

But "result" is always zero at this point (it came from
acpi_bus_register_driver(), which returns either zero or a negative
error value).

My original change:
  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=578b333bfe8eb1360207a08a53c321822a8f40f3
contained:

	if (!asus_hotk_found) {
		...
		return -ENODEV;

which is what we want.  I think the -ENODEV got lost when resolving
conflicts with the "propagate correct return value" patches that
happened at about the same time.

> > I think it's a mistake to have acpi_bus_register_driver() return
> > any indication of how many devices were claimed.  If the driver
> > needs to know how many devices it claimed, it can easily count
> > them in its add() method.  Returning the count from register_driver()
> > is racey if devices can be hot-plugged.
> I think this is wrong.
> It needs not to return the number of claimed devices, it needs to return
> -ENODEV if no device will ever exist.

There is no way for acpi_bus_register_driver() to know that no device
will ever exist.

> The whole culprit to hotplug design (and you are right, this patch also
> does not
> work because of this) is this line in acpi_driver_attach:
>                 if (dev->driver || !dev->status.present)
>                         continue;
> If a device is not present, but exists in ACPI namespace, .add function
> must still be
> called.
> Can you/someone have a look at my mail a month ago:
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115833743117570&w=2

Sorry, I missed this and haven't had time to pay any attention
to this for a long time.

I'm not sure I agree with your approach.  I don't think a driver
should have to have a notify handler just to handle hotplug.  It
seems like the ACPI core should handle those notifications and
call the .add/.remove functions.  For example, maybe that could
be done in the acpi_bus_check_device() path, which currently has
some "TBD" comments about handing device insertion and removal.

Bjorn

