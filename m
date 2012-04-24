From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Tue, 24 Apr 2012 10:29:36 +0800
Message-ID: <1335234576.15942.19.camel@minggr>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	 <201204231343.03382.rjw@sisk.pl> <20120423151327.GA4019@fedora>
	 <201204232150.57812.rjw@sisk.pl> <20120424020708.GA10397@localhost.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9500 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab2DXC3j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2012 22:29:39 -0400
In-Reply-To: <20120424020708.GA10397@localhost.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Tue, 2012-04-24 at 10:07 +0800, Aaron Lu wrote:
> On Mon, Apr 23, 2012 at 09:50:57PM +0200, Rafael J. Wysocki wrote:
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 3263b68..187433f 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
> > >  		}
> > >  	} else {
> > >  		if (device->power.states[state].flags.explicit_set) {
> > > +			/* evaluate _PS3 instead of _PS4 when entering D3Cold */
> > > +			if (state == ACPI_STATE_D3)
> > > +				object_name[3] -= 1;
> > 
> > Can you just put '3' here directly?  That'll be much cleaner than the
> > subtraction (that could have been -- as well).
> > 
> > >  			status = acpi_evaluate_object(device->handle,
> > >  						      object_name, NULL, NULL);
> > >  			if (ACPI_FAILURE(status)) {
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 7417267..de2ae10 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -887,8 +887,12 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
> > >  		/* Evaluate "_PSx" to see if we can do explicit sets */
> > >  		object_name[2] = 'S';
> > >  		status = acpi_get_handle(device->handle, object_name, &handle);
> > > -		if (ACPI_SUCCESS(status))
> > > +		if (ACPI_SUCCESS(status)) {
> > >  			ps->flags.explicit_set = 1;
> > > +			/* Also set D3Cold's explicit flag when _PS3 exists */
> > > +			if (i == ACPI_STATE_D3_HOT)
> > > +				(ps+1)->flags.explicit_set = 1;
> > 
> > Please don't use pointer arithmetics here.  I know it _happens_ to work,
> > but I don't think it's appropriate in this situation at all.
> > 
> 
> Thanks for the suggestions.
> 
> What about this?
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 3263b68..3a7860f 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
>  		}
>  	} else {
>  		if (device->power.states[state].flags.explicit_set) {
> +			/* Evaluate _PS3 when entering D3cold */
> +			if (state == ACPI_STATE_D3)
> +				object_name[3] = '3';
>  			status = acpi_evaluate_object(device->handle,
>  						      object_name, NULL, NULL);
>  			if (ACPI_FAILURE(status)) {
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7417267..734d946 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
>  	device->power.states[ACPI_STATE_D3].flags.valid = 1;
>  	device->power.states[ACPI_STATE_D3].power = 0;
>  
> +	/* Also set D3cold's explicit flag when _PS3 exists */
> +	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)
> +		device->power.states[ACPI_STATE_D3].flags.explicit_set = 1;

We should use ACPI_STATE_D3_COLD instead of ACPI_STATE_D3 to make thing
clear.

> +
>  	acpi_bus_init_power(device);
>  
>  	return 0;
> 
> Thanks,
> Aaron
> 


