From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: assumptions in acpi drivers
Date: Sun, 11 Oct 2009 14:39:10 +0100
Message-ID: <9b2b86520910110639g57b2c56ao19f9f1f687729f7d@mail.gmail.com>
References: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com>
	 <1255185595.30901.7.camel@dc7800.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:41812 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbZJKNjr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Oct 2009 09:39:47 -0400
Received: by fxm27 with SMTP id 27so8103015fxm.17
        for <linux-acpi@vger.kernel.org>; Sun, 11 Oct 2009 06:39:10 -0700 (PDT)
In-Reply-To: <1255185595.30901.7.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On 10/10/09, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Sat, 2009-10-10 at 14:16 +0100, Alan Jenkins wrote:
>
>> > The current upstream version of this function also has the kfree
>> > issue.  You're patching a different version, so it might be fixed
>> > there already.  But it seems like all these hotkey drivers (and the
>> > accelerometer driver) use the same pattern of assuming they'll only
>> > see a single device, and then they make assumptions like "hotk ==
>> > acpi_driver_data(device)".  That's just a bad example for people
>> > to follow, and might not even be true for things like accelerometers
>> > where you could imagine having more than one.
>>
>> I've been thinking about this.  Frankly, I can't imagine a machine
>> having multiple ACPI accelerometer devices with the same interface.
>> It doesn't make sense to have multiple instances of any of the drivers
>> under /platform/.  And many of them create platform devices with fixed
>> names, so we can't pretend it would work.
>>
>> Perhaps the best approach is to remove the references to
>> device->driverdata, and consistently use "hotk" or equivalent.  The
>> _core_ acpi devices would always provide correct examples of how to
>> use driverdata.
>
> I think the best pattern is something like this:
>
>     struct acpi_device *singleton;
>
>     xxx_add(struct acpi_device *device, ...)
>     {
> 	if (singleton)
> 		return -EINVAL;
>
> 	xxx_data = kzalloc(...);
> 	xxx_data->foo = 0;
>
> 	device->driver_data = xxx_data;
> 	singleton = xxx_data;
> 	return 0;
>     }
>
>     xxx_remove(struct acpi_device *device)
>     {
> 	kfree(acpi_driver_data(device));
>     }
>
> That way the assumption that there's only a single device is confined to
> the add() method.  That makes the rest of the driver easier to read and
> verify because it looks like every other ACPI driver.
>
> Bjorn

Ok, you've prodded me enough to try converting eeepc-laptop.

Doesn't the singleton pattern need to be thread-safe though?  I don't
see any global lock (or a driver-specific one) in device_bind_driver()
or acpi_bind_device().  That's why I suggested atomics earlier.

Regards
Alan
