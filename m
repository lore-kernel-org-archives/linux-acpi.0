From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: assumptions in acpi drivers
Date: Sat, 10 Oct 2009 08:39:55 -0600
Message-ID: <1255185595.30901.7.camel@dc7800.home>
References: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:11914 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbZJJOnk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Oct 2009 10:43:40 -0400
In-Reply-To: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2009-10-10 at 14:16 +0100, Alan Jenkins wrote:

> > The current upstream version of this function also has the kfree
> > issue.  You're patching a different version, so it might be fixed
> > there already.  But it seems like all these hotkey drivers (and the
> > accelerometer driver) use the same pattern of assuming they'll only
> > see a single device, and then they make assumptions like "hotk ==
> > acpi_driver_data(device)".  That's just a bad example for people
> > to follow, and might not even be true for things like accelerometers
> > where you could imagine having more than one.
> 
> I've been thinking about this.  Frankly, I can't imagine a machine
> having multiple ACPI accelerometer devices with the same interface.
> It doesn't make sense to have multiple instances of any of the drivers
> under /platform/.  And many of them create platform devices with fixed
> names, so we can't pretend it would work.
> 
> Perhaps the best approach is to remove the references to
> device->driverdata, and consistently use "hotk" or equivalent.  The
> _core_ acpi devices would always provide correct examples of how to
> use driverdata.

I think the best pattern is something like this:

    struct acpi_device *singleton;

    xxx_add(struct acpi_device *device, ...)
    {
	if (singleton)
		return -EINVAL;

	xxx_data = kzalloc(...);
	xxx_data->foo = 0;

	device->driver_data = xxx_data;
	singleton = xxx_data;
	return 0;
    }

    xxx_remove(struct acpi_device *device)
    {
	kfree(acpi_driver_data(device));
    }

That way the assumption that there's only a single device is confined to
the add() method.  That makes the rest of the driver easier to read and
verify because it looks like every other ACPI driver.

Bjorn


