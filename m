From: Jean Delvare <khali@linux-fr.org>
Subject: Re: ACPI reads wrong temperature
Date: Thu, 13 Nov 2008 11:24:11 +0100
Message-ID: <20081113112411.009fc89c@hyperion.delvare>
References: <20081031210913.3180@gmx.net>
	<1225951972.3989.99.camel@yakui_zhao.sh.intel.com>
	<20081106091126.GA25849@srcf.ucam.org>
	<200811121620.44520.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:39344 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbYKMKY0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 05:24:26 -0500
In-Reply-To: <200811121620.44520.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Zhao Yakui <yakui.zhao@intel.com>, Len Brown <lenb@kernel.org>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Thomas,

On Wed, 12 Nov 2008 16:20:43 -0600, Thomas Renninger wrote:
> On Thursday 06 November 2008 03:11:26 am Matthew Garrett wrote:
> > On Thu, Nov 06, 2008 at 02:12:52PM +0800, Zhao Yakui wrote:
> > > On your box after the i2c-i801 driver is loaded, the smbus controller
> > > will be used by the AML code and i2c-i801 driver. Unfortunately there is
> > > no synchronization between them. IMO this is the BIOS fault. The SMbus
> > > will be accessed by the two different modules. But it is exported by
> > > BIOS.
> >
> > No, loading i2c-i801 is harmless. The breakage occurs when you attempt
> > to drive the smbus.
> >
> > >     So the better solution is that:
> > >     a. SMBus is hidden in BIOS. In such case the Linux OS can't detect
> > > the SMbus controller . Of course it won't try to load the device driver
> > > for it.
> > >     b. Linux OS won't load the device driver for it.
> >
> > The solution is for users not to load smbus drivers unless they know for
> > certain that it's safe to do so, or alternatively for us to refuse to

Except that all these drivers auto-load, so the user doesn't actually
get to verify anything beforehand. Nor do I believe they should have
to. If there's a way for the user to verify that loading the driver is
safe then the same check can be added to the driver itself. Which, as
Thomas explained, is partly implemented, just not yet enforced.

> > load i2c drivers if they overlap with ACPI resource allocations.
> 
> We already have that:
> >  or alternatively for us to refuse to load i2c drivers
> in drivers/acpi/osl.c:
> 
> #define ENFORCE_RESOURCES_STRICT 2
> #define ENFORCE_RESOURCES_LAX    1
> #define ENFORCE_RESOURCES_NO     0
> 
> static unsigned int acpi_enforce_resources = ENFORCE_RESOURCES_LAX;
> 
> lax means print out warning which i2c driver conflicts with which ACPI 
> Operation Region.
> Did you get such a message:
> printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
>                                " conflicts with ACPI region %s"
>                                " [0x%llx-0x%llx]\n",
>                                acpi_enforce_resources == ENFORCE_RESOURCES_LAX
>                                ? KERN_WARNING : KERN_ERR,
>                                ioport ? "I/O" : "Memory", res->name,
>                                (long long) res->start, (long long) res->end,
>                                res_list_elem->name,
>                                (long long) res_list_elem->start,
>                                (long long) res_list_elem->end);
> 
> If not, probably this specific i2c driver has to be added to check it's 
> resources against ACPI used Operation Regions.
> 
> Jean: Could you add that if necessary, pls.
> This is the whole thread:
> http://marc.info/?t=122546192400002&r=1&w=2

The i2c-i801 driver already has this check.

The exact same issue (reported by the same person) was already
discussed on the lm-sensors list:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-October/024608.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-November/024610.html

With the same conclusion, i.e. i2c-i801 should be blacklisted on that
specific model, or acpi_enforce_resources=strict should be used. Or the
BIOS should hide the SMBus, that would be even better.

-- 
Jean Delvare
