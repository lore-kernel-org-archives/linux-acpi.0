From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/6] ACPI: button: minor cleanups
Date: Fri, 8 May 2009 14:53:01 -0600
Message-ID: <200905081453.02556.bjorn.helgaas@hp.com>
References: <20090408153427.12354.62167.stgit@bob.kio> <200905061713.08057.trenn@suse.de> <200905061120.52793.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:26456 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760380AbZEHUxF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 16:53:05 -0400
In-Reply-To: <200905061120.52793.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wednesday 06 May 2009 11:20:52 am Bjorn Helgaas wrote:
> On Wednesday 06 May 2009 09:13:07 am Thomas Renninger wrote:
> > Below is the outcome of the patch which fixes a fixed feature button
> > s2ram issue.
> > 
> > This does not work anymore since Bjoern's patches.
> > Comparing the with the HID of the acpi device looks ugly.
> > 
> > Shall I revive the fixed feature vs GPE button types?
> > ACPI_BUTTON_TYPE_POWERF and ACPI_BUTTON_TYPE_SLEEPF?
> 
> I don't understand exactly how I broke this.

What tree are you testing?  In Linus's upstream tree, 373cfc360e
adds the .notify method, and at the same time, it removes
acpi_button_notify_fixed().

Your patch below, which fixes the problem, shows that you already
have the .notify method, and yet you apparently *also* have the
acpi_button_notify_fixed() function.  That makes me suspect that
you're using a tree with a merge error.

Bjorn

> > @@ -85,6 +86,7 @@ static struct acpi_driver acpi_button_driver = {
> >  	.ops = {
> >  		.add = acpi_button_add,
> >  		.resume = acpi_button_resume,
> > +		.suspend = acpi_button_suspend,
> >  		.remove = acpi_button_remove,
> >  		.notify = acpi_button_notify,
> >  	},
> > @@ -281,8 +283,41 @@ static int acpi_button_resume(struct acpi_device *device)
> >  {
> >  	struct acpi_button *button = acpi_driver_data(device);
> >  
> > -	if (button->type == ACPI_BUTTON_TYPE_LID)
> > +	if (!button)
> > +		return -EINVAL;
> > +	switch (button->type) {
> > +	case ACPI_BUTTON_TYPE_LID:
> >  		return acpi_lid_send_state(device);
> > +	case ACPI_BUTTON_TYPE_SLEEPF:
> > +		return acpi_install_fixed_event_handler(
> > +					ACPI_EVENT_SLEEP_BUTTON,
> > +					acpi_button_notify_fixed, button);
> > +
> > +	case ACPI_BUTTON_TYPE_POWERF:
> > +		return acpi_install_fixed_event_handler(
> > +					ACPI_EVENT_POWER_BUTTON,
> > +					acpi_button_notify_fixed, button);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int acpi_button_suspend(struct acpi_device *device, pm_message_t state)
> > +{
> > +	struct acpi_button *button;
> > +	if (!device)
> > +		return -EINVAL;
> > +	button = acpi_driver_data(device);
> > +	if (!button)
> > +		return -EINVAL;
> > +	switch (button->type) {
> > +	case ACPI_BUTTON_TYPE_SLEEPF:
> > +		return acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> > +					       acpi_button_notify_fixed);
> > +
> > +	case ACPI_BUTTON_TYPE_POWERF:
> > +		return acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> > +					       acpi_button_notify_fixed);
> > +	}
> >  	return 0;
> >  }
> >  
> > 
> 
> 
> 


