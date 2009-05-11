From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/6] ACPI: button: minor cleanups
Date: Mon, 11 May 2009 08:56:37 +0200
Message-ID: <200905110856.37626.trenn@suse.de>
References: <20090408153427.12354.62167.stgit@bob.kio> <200905061120.52793.bjorn.helgaas@hp.com> <200905081453.02556.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60187 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbZEKFzl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 May 2009 01:55:41 -0400
In-Reply-To: <200905081453.02556.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Friday 08 May 2009 10:53:01 pm Bjorn Helgaas wrote:
> On Wednesday 06 May 2009 11:20:52 am Bjorn Helgaas wrote:
> > On Wednesday 06 May 2009 09:13:07 am Thomas Renninger wrote:
> > > Below is the outcome of the patch which fixes a fixed feature button
> > > s2ram issue.
> > >
> > > This does not work anymore since Bjoern's patches.
> > > Comparing the with the HID of the acpi device looks ugly.
> > >
> > > Shall I revive the fixed feature vs GPE button types?
> > > ACPI_BUTTON_TYPE_POWERF and ACPI_BUTTON_TYPE_SLEEPF?
> >
> > I don't understand exactly how I broke this.
Ahh, sorry.
You did not break anything.

The patch is a fix (not for a regression), but is now (with your change)
somewhat harder/uncleaner to integrate.

The fix removes fixed featured button's fixed event handler on
suspend and installs it again on resume.

With your change, the button driver does not know anymore about
fixed feature buttons. And notify handlers shouldn't be touched with
your change in the button driver, but I think this is cleaner.

So this is nothing urgent. I'll send a patch which works with your
version, but I am not sure what the cleanest way is now to add this.

Sorry for not being clear,

      Thomas

> What tree are you testing?  In Linus's upstream tree, 373cfc360e
> adds the .notify method, and at the same time, it removes
> acpi_button_notify_fixed().
>
> Your patch below, which fixes the problem, shows that you already
> have the .notify method, and yet you apparently *also* have the
> acpi_button_notify_fixed() function.  That makes me suspect that
> you're using a tree with a merge error.
>
> Bjorn
>
> > > @@ -85,6 +86,7 @@ static struct acpi_driver acpi_button_driver = {
> > >  	.ops = {
> > >  		.add = acpi_button_add,
> > >  		.resume = acpi_button_resume,
> > > +		.suspend = acpi_button_suspend,
> > >  		.remove = acpi_button_remove,
> > >  		.notify = acpi_button_notify,
> > >  	},
> > > @@ -281,8 +283,41 @@ static int acpi_button_resume(struct acpi_device
> > > *device) {
> > >  	struct acpi_button *button = acpi_driver_data(device);
> > >
> > > -	if (button->type == ACPI_BUTTON_TYPE_LID)
> > > +	if (!button)
> > > +		return -EINVAL;
> > > +	switch (button->type) {
> > > +	case ACPI_BUTTON_TYPE_LID:
> > >  		return acpi_lid_send_state(device);
> > > +	case ACPI_BUTTON_TYPE_SLEEPF:
> > > +		return acpi_install_fixed_event_handler(
> > > +					ACPI_EVENT_SLEEP_BUTTON,
> > > +					acpi_button_notify_fixed, button);
> > > +
> > > +	case ACPI_BUTTON_TYPE_POWERF:
> > > +		return acpi_install_fixed_event_handler(
> > > +					ACPI_EVENT_POWER_BUTTON,
> > > +					acpi_button_notify_fixed, button);
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int acpi_button_suspend(struct acpi_device *device,
> > > pm_message_t state) +{
> > > +	struct acpi_button *button;
> > > +	if (!device)
> > > +		return -EINVAL;
> > > +	button = acpi_driver_data(device);
> > > +	if (!button)
> > > +		return -EINVAL;
> > > +	switch (button->type) {
> > > +	case ACPI_BUTTON_TYPE_SLEEPF:
> > > +		return acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> > > +					       acpi_button_notify_fixed);
> > > +
> > > +	case ACPI_BUTTON_TYPE_POWERF:
> > > +		return acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> > > +					       acpi_button_notify_fixed);
> > > +	}
> > >  	return 0;
> > >  }


