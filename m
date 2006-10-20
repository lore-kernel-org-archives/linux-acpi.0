From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Fri, 20 Oct 2006 10:55:33 -0600
Message-ID: <200610201055.33931.bjorn.helgaas@hp.com>
References: <20061020092547.519734000@neutrino.suse.de> <1161338381.32262.114.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:191 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932253AbWJTQzm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 12:55:42 -0400
In-Reply-To: <1161338381.32262.114.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: fseidel@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Friday 20 October 2006 03:59, Thomas Renninger wrote:
> On Fri, 2006-10-20 at 11:25 +0200, fseidel@suse.de wrote:
> > Currently acpi_bus_register_driver only reports an error
> > (-ENODEV) if acpi_disabled is true,
> > but many acpi drivers also depend on a negative error
> > value if no driver could be attached to a device
> > (as e.g. driver/acpi/asus_acpi.c).
> > This patch adds this again (without changing return type
> > of acpi_driver_attach for this).

I object to this.

> acpi_bus_register_driver must return -ENODEV when no device with
> matching HID was found. E.g. battery also should currently get always
> loaded even a system never has one.

If the driver wants to unload if it doesn't find any devices,
it can easily do so by counting calls to its add() method, as
asus_acpi.c currently does.  I don't think that's a good long-
term solution, though.  I think it would be better to have a
hotplug scheme that loads the driver when the hardware is
found, like we do for PCI.

> driver_attach returned the amount of found devices in past, this was
> changed recently (can't find the patch/mail) right now. This change
> broke things and should get corrected by these patches.

Here's my patch that results in the current behavior:
  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9d9f749b316ac21cb59ad3e595cbce469b409e1a

What did it break?  I haven't seen any reports of problems.

I think it's a mistake to have acpi_bus_register_driver() return
any indication of how many devices were claimed.  If the driver
needs to know how many devices it claimed, it can easily count
them in its add() method.  Returning the count from register_driver()
is racey if devices can be hot-plugged.

Bjorn
