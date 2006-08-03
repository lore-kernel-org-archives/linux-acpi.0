From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Autoload acpi modules via uevent and pnpacpi
Date: Thu, 3 Aug 2006 10:32:26 -0600
Message-ID: <200608031032.27149.bjorn.helgaas@hp.com>
References: <1154618720.4302.542.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:29135 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S964844AbWHCQc2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 12:32:28 -0400
In-Reply-To: <1154618720.4302.542.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, thermal@o2.pl, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Thursday 03 August 2006 09:25, Thomas Renninger wrote:
> I tried out the patch Bjorn sent some days ago to autoload ACPI modules
> via udev. The attached patch is based on latest test tree and includes
> Bjorn's code. This works, but is not nice.
> 
> I had to tweak pnp to:
>   - also register ACPI devices which have no _CRS func
>   - allow (one byte longer) ACPIXXXX _HIDs to be used as PNP ids.

Right.

> Now I got the following modules autoloaded (without the need of any
> userspace adjustments):
>   battery, asus_acpi, button, ac (tested)
>   
>   fan, ibm_acpi, acpi_memhotplug, container, sbs,..
>   (should also work, but untested)

Cool.  That seems like a nice result, though as you point out, there
are still plenty of issues to be resolved.

> I also wanted to use the suspend/resume stuff from there to point to the
> acpi_driver->suspend/resume funcs, but this does not work as
> pnp_driver->suspend/resume is used there, no idea whether this could be
> mapped somehow, I didn't see an easy way.
> 
> Another problem is that e.g. thermal_zones do not have a PNP id.
> We could add a dummy _HID like ACPI9999 for that one?

I don't know anything about thermal zones.  But it looks like
acpi_device_set_id() and drivers/acpi/thermal.c conspire to
use "ACPI_THM" already.

> Is it intended to pass all ACPI devices to pnpacpi in future?
> Not sure whether this is such a good idea.

I don't know either.  I don't like the current situation, where some
devices are claimed by pnp_register_driver() and others are claimed
with acpi_bus_register_driver().  There's (mostly) a single namespace,
so it seem like there should be a single driver registration mechanism.

Both struct acpi_device and struct pnp_dev contain a struct device.
So for PNPACPI devices, we have two struct devices for the same thing,
which feels wrong.  And I thought someone said once upon a time that
PNP and ACPI devices should really be connected to a platform_device,
and I don't see that happening anywhere.

And PNPACPI doesn't integrate at all with ACPI hot-plug, so hot-added
ACPI devices won't show up via PNPACPI, even if they would be eligible.

Obviously we have to retain the additional ACPI functionality.  But I
wonder whether we could make PNP the primary way of exposing things,
with ACPI stuff as an optional capability.

> IMO it's better to let the stuff stay or be added to drivers/acpi.
> There already is suspend/resume for acpi devices there now, the uevent
> stuff should also go there?

ACPI was obviously intended to replace and extend PNPBIOS.  As such,
I think we should try to use the same kernel and user-level interfaces,
with some extensions as required to support the new functionality.

Sorry I have so many questions and so little code.  Sigh.  I actually
do have some half-baked patches to:

  - initialize PNP before ACPI
  - have acpi_device_register() call pnpacpi_add_device(), so almost
    all ACPI devices appear as PNP
  - remove most of the PNPACPI exclusions
  - add a pnp_acpi_device() to get struct acpi_device * back from
    a struct pnp_dev
  - convert drivers/acpi/fan.c to use pnp_register_driver() and
    pnp_acpi_device() (just as a proof-of-concept)

But I haven't had time to do anything more with them.  Thanks for
playing with this stuff.

Bjorn


> +	/* Presence of _DIS indicates 'suprise_removal_ok' */
> +	status = acpi_get_handle(device->handle, "_DIS", &temp);
> +	if (ACPI_SUCCESS(status))
> +		device->flags.suprise_removal_ok = 1;

Are these changes related to the rest of your patch?  And since
you're touching this anyway, maybe you can fix this typo ("suprise"
should be "surprise")?  Also below "resourses" should be
"resources".

> +	/* Presence of _DIS indicates 'suprise_removal_ok' */
> +	status = acpi_get_handle(device->handle, "_SRS", &temp);
> +	if (ACPI_SUCCESS(status))
> +		device->flags.set_resourses = 1;
> +	/* Presence of _DIS indicates 'suprise_removal_ok' */
> +	status = acpi_get_handle(device->handle, "_CRS", &temp);
> +	if (ACPI_SUCCESS(status))
> +		device->flags.current_resourses = 1;

