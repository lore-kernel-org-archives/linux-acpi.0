From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: assumptions in acpi drivers
Date: Thu, 15 Oct 2009 21:36:10 -0700
Message-ID: <20091016043609.GA11582@core.coreip.homeip.net>
References: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com> <1255185595.30901.7.camel@dc7800.home> <9b2b86520910110639g57b2c56ao19f9f1f687729f7d@mail.gmail.com> <1255320452.12547.6.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:48770 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZJPEgv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2009 00:36:51 -0400
Received: by pxi1 with SMTP id 1so1038294pxi.33
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2009 21:36:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255320452.12547.6.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org

On Sun, Oct 11, 2009 at 10:07:32PM -0600, Bjorn Helgaas wrote:
> On Sun, 2009-10-11 at 14:39 +0100, Alan Jenkins wrote:
> > On 10/10/09, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > On Sat, 2009-10-10 at 14:16 +0100, Alan Jenkins wrote:
> > >
> > >> > The current upstream version of this function also has the kfree
> > >> > issue.  You're patching a different version, so it might be fixed
> > >> > there already.  But it seems like all these hotkey drivers (and the
> > >> > accelerometer driver) use the same pattern of assuming they'll only
> > >> > see a single device, and then they make assumptions like "hotk ==
> > >> > acpi_driver_data(device)".  That's just a bad example for people
> > >> > to follow, and might not even be true for things like accelerometers
> > >> > where you could imagine having more than one.
> > >>
> > >> I've been thinking about this.  Frankly, I can't imagine a machine
> > >> having multiple ACPI accelerometer devices with the same interface.
> > >> It doesn't make sense to have multiple instances of any of the drivers
> > >> under /platform/.  And many of them create platform devices with fixed
> > >> names, so we can't pretend it would work.
> > >>
> > >> Perhaps the best approach is to remove the references to
> > >> device->driverdata, and consistently use "hotk" or equivalent.  The
> > >> _core_ acpi devices would always provide correct examples of how to
> > >> use driverdata.
> > >
> > > I think the best pattern is something like this:
> > >
> > >     struct acpi_device *singleton;
> > >
> > >     xxx_add(struct acpi_device *device, ...)
> > >     {
> > > 	if (singleton)
> > > 		return -EINVAL;
> > >
> > > 	xxx_data = kzalloc(...);
> > > 	xxx_data->foo = 0;
> > >
> > > 	device->driver_data = xxx_data;
> > > 	singleton = xxx_data;
> > > 	return 0;
> > >     }
> > >
> > >     xxx_remove(struct acpi_device *device)
> > >     {
> > > 	kfree(acpi_driver_data(device));
> > >     }
> > >
> > > That way the assumption that there's only a single device is confined to
> > > the add() method.  That makes the rest of the driver easier to read and
> > > verify because it looks like every other ACPI driver.
> > >
> > > Bjorn
> > 
> > Ok, you've prodded me enough to try converting eeepc-laptop.
> > 
> > Doesn't the singleton pattern need to be thread-safe though?  I don't
> > see any global lock (or a driver-specific one) in device_bind_driver()
> > or acpi_bind_device().  That's why I suggested atomics earlier.
> 
> Ooh, you're right, using atomic_inc_return() is much better.  I don't
> know whether it needs to be thread-safe or not, but it doesn't hurt, and
> it's nicer in the sense that it doesn't leave the singleton pointer
> lying around where people would be tempted to use it instead of using
> acpi_driver_data(device).

A small note: while it might not be an issue for ACPI in general drivers
can be detached from devices via sysfs bind/unbind attributes and so if
using this singleton model xxx_remove() should take care of decrementing
the counter and xxx_add() should do the same in error path.

-- 
Dmitry
