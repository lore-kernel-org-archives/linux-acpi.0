From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Tue, 14 Apr 2015 13:50:11 +0200
Message-ID: <4530573.vsU6fqTbSL@vostro.rjw.lan>
References: <3444888.xxxTREorHY@vostro.rjw.lan> <20150414020414.GA27710@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62811 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754722AbbDNLZk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2015 07:25:40 -0400
In-Reply-To: <20150414020414.GA27710@fury.dvhart.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday, April 13, 2015 07:04:14 PM Darren Hart wrote:
> On Sat, Apr 11, 2015 at 01:28:45AM +0200, Rafael Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the special PRP0001 device ID is present in the given device's list
> > of ACPI/PNP IDs and the device has a valid "compatible" property in
> > the _DSD, it should be enumerated using the default mechanism,
> > unless some scan handlers match the IDs preceding PRP0001 in the
> > device's list of ACPI/PNP IDs.  In particular, no scan handlers
> > matching the IDs following PRP0001 in that list should be attached
> > to the device.
> > 
> > To make that happen, define a scan handler that will match PRP0001
> > and trigger the default enumeration for the matching devices if the
> > "compatible" property is present for them.
> > 
> > Since that requires the check for platform_id and device->handler
> > to be removed from acpi_default_enumeration(), move the fallback
> > invocation of acpi_default_enumeration() to acpi_bus_attach()
> > (after it's checked if there's a matching ACPI driver for the
> > device), which is a better place to call it, and do the platform_id
> > check in there too (device->handler is guaranteed to be unset at
> > the point where the function is looking for a matching ACPI driver).
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/scan.c |   34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> > 
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -2390,9 +2390,6 @@ static void acpi_default_enumeration(str
> >  	struct list_head resource_list;
> >  	bool is_spi_i2c_slave = false;
> >  
> > -	if (!device->pnp.type.platform_id || device->handler)
> > -		return;
> > -
> >  	/*
> >  	 * Do not enemerate SPI/I2C slaves as they will be enuerated by their
> >  	 * respective parents.
> > @@ -2405,6 +2402,30 @@ static void acpi_default_enumeration(str
> >  		acpi_create_platform_device(device);
> >  }
> >  
> > +static const struct acpi_device_id generic_device_ids[] = {
> > +	{"PRP0001", },
> > +	{"", },
> > +};
> > +
> > +static int acpi_generic_device_attach(struct acpi_device *adev,
> > +				      const struct acpi_device_id *not_used)
> > +{
> > +	/*
> > +	 * Since PRP0001 is the only ID handled here, the test below can be
> > +	 * unconditional.
> > +	 */
> > +	if (adev->data.of_compatible) {
> > +		acpi_default_enumeration(adev);
> > +		return 1;
> > +	}
> 
> Would a warning be appropriate here? PRP0001 should only appear when paired with
> a DSD of GUID Device Properties with a "compatible" entry. If not, it's an
> error, correct? I believe we warn on similarly malformed AML?

We don't do that as a rule as there would be too many warnings that are not
really useful.  Users can't do much about those things at this stage (buggy
firmware has shipped already) and for the firmware people it is better to
cover things like that in firmware test suites (which in theory may help to
avoid shipping buggy firmware in the first place).

That said we print a warning in acpi_init_of_compatible() if things are not
consistent (which doesn't cover the case when _DSD is missing entirely, though),
so IMO it'd be better to refine that one instead of adding a new one which
wouldn't cover all cases too (eg. if PRP0001 is not the first ID in the list
and a previous one is matched to a different scan handler).

Rafael

