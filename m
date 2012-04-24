From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Tue, 24 Apr 2012 11:10:11 +0800
Message-ID: <20120424031011.GA27099@ladygaga>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
 <201204231343.03382.rjw@sisk.pl>
 <20120423151327.GA4019@fedora>
 <201204232150.57812.rjw@sisk.pl>
 <20120424020708.GA10397@localhost.amd.com>
 <1335234576.15942.19.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:52445
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756361Ab2DXDKa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2012 23:10:30 -0400
Content-Disposition: inline
In-Reply-To: <1335234576.15942.19.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Tue, Apr 24, 2012 at 10:29:36AM +0800, Lin Ming wrote:
> On Tue, 2012-04-24 at 10:07 +0800, Aaron Lu wrote:
> > On Mon, Apr 23, 2012 at 09:50:57PM +0200, Rafael J. Wysocki wrote:
> > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > > index 3263b68..187433f 100644
> > > > --- a/drivers/acpi/bus.c
> > > > +++ b/drivers/acpi/bus.c
> > > > @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
> > > >  		}
> > > >  	} else {
> > > >  		if (device->power.states[state].flags.explicit_set) {
> > > > +			/* evaluate _PS3 instead of _PS4 when entering D3Cold */
> > > > +			if (state == ACPI_STATE_D3)
> > > > +				object_name[3] -= 1;
> > > 
> > > Can you just put '3' here directly?  That'll be much cleaner than the
> > > subtraction (that could have been -- as well).
> > > 
> > > >  			status = acpi_evaluate_object(device->handle,
> > > >  						      object_name, NULL, NULL);
> > > >  			if (ACPI_FAILURE(status)) {
> > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > index 7417267..de2ae10 100644
> > > > --- a/drivers/acpi/scan.c
> > > > +++ b/drivers/acpi/scan.c
> > > > @@ -887,8 +887,12 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
> > > >  		/* Evaluate "_PSx" to see if we can do explicit sets */
> > > >  		object_name[2] = 'S';
> > > >  		status = acpi_get_handle(device->handle, object_name, &handle);
> > > > -		if (ACPI_SUCCESS(status))
> > > > +		if (ACPI_SUCCESS(status)) {
> > > >  			ps->flags.explicit_set = 1;
> > > > +			/* Also set D3Cold's explicit flag when _PS3 exists */
> > > > +			if (i == ACPI_STATE_D3_HOT)
> > > > +				(ps+1)->flags.explicit_set = 1;
> > > 
> > > Please don't use pointer arithmetics here.  I know it _happens_ to work,
> > > but I don't think it's appropriate in this situation at all.
> > > 
> > 
> > Thanks for the suggestions.
> > 
> > What about this?
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 3263b68..3a7860f 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
> >  		}
> >  	} else {
> >  		if (device->power.states[state].flags.explicit_set) {
> > +			/* Evaluate _PS3 when entering D3cold */
> > +			if (state == ACPI_STATE_D3)
> > +				object_name[3] = '3';
> >  			status = acpi_evaluate_object(device->handle,
> >  						      object_name, NULL, NULL);
> >  			if (ACPI_FAILURE(status)) {
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 7417267..734d946 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
> >  	device->power.states[ACPI_STATE_D3].flags.valid = 1;
> >  	device->power.states[ACPI_STATE_D3].power = 0;
> >  
> > +	/* Also set D3cold's explicit flag when _PS3 exists */
> > +	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)
> > +		device->power.states[ACPI_STATE_D3].flags.explicit_set = 1;
> 
> We should use ACPI_STATE_D3_COLD instead of ACPI_STATE_D3 to make thing
> clear.
>
Thanks for your suggestion.

Well, considering all those ACPI_STATE_D3 used in tree, I don't think I
should use ACPI_STATE_D3_COLD here, especially the two lines above are
still using ACPI_STATE_D3.

But if that is desired, we should probably change all the existing
ACPI_STATE_D3 macros to ACPI_STATE_D3_COLD to make things clear.

Or we all use ACPI_STATE_D3, since it is defined as 4 and means D3 cold,
and people will learn this, won't they?

What do you think?
 
Thanks,
Aaron

