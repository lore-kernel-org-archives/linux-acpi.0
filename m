From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Thu, 21 May 2009 17:28:22 -0600
Message-ID: <200905211728.23423.bjorn.helgaas@hp.com>
References: <1242106060.3773.216.camel@localhost.localdomain> <200905141249.35822.bjorn.helgaas@hp.com> <1242612503.3685.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:43681 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbZEUX2z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2009 19:28:55 -0400
In-Reply-To: <1242612503.3685.15.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Witold Szczeponik <Witold.Szczeponik@gmx.net>

On Sunday 17 May 2009 8:08:23 pm yakui_zhao wrote:
> On Fri, 2009-05-15 at 02:49 +0800, Bjorn Helgaas wrote:

> > I'd *like* to remove this whole chunk, which would allow us to remove
> > acpi_power_nocheck, the DMI table, and the kernel parameter completely:
> > 
> >         /*
> >          * Get device's current power state
> >          */
> >         if (!acpi_power_nocheck) {
> >                 /*
> >                  * Maybe the incorrect power state is returned on the bogus
> >                  * bios, which is different with the real power state.
> >                  * For example: the bios returns D0 state and the real power
> >                  * state is D3. OS expects to set the device to D0 state. In
> >                  * such case if OS uses the power state returned by the BIOS,
> >                  * the device can't be transisted to the correct power state.
> >                  * So if the acpi_power_nocheck is set, it is unnecessary to
> >                  * get the power state by calling acpi_bus_get_power.
> >                  */
> >                 acpi_bus_get_power(device->handle, &device->power.state);
> >         }
> >         if ((state == device->power.state) && !device->flags.force_power_state) {
> >                 ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
> >                                   state));
> >                 return 0;
> >         }
> > 
> > Then we could also remove the "force_power_state" ugliness.  But I'm
> > afraid of breaking something because I don't understand the subtleties
> > of power transitions.
> The flag of "force_power_state" can't be removed. For example: The ACPI
> fan is in Off state. But the bogus bios reports that it is in D0 state.
> If there is no flag of "force_power_state", we can't turn on the FAN
> device.

OK, we need more investigation before removing this code from
acpi_bus_set_power(), so let's defer that.

> > ACPI: never check power state after _ON/_OFF
> > 
> > From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > We used to evaluate _STA to check the power state of a device after
> > running _ON or _OFF.  But as far as I can tell, there's no benefit
> > to evaluating _STA, and sometimes we trip over bugs when BIOSes don't
> > implement _STA correctly.
> > 
> > Yakui says Windows XP doesn't evaluate _STA during power transition.
> > So let's skip it in Linux, too.
> It is also OK that the power state is never checked during power
> transition. I verify this on Windows XP. In such case we can delete the
> DMI check, kernel parameter, the code related with power state check.
> 
> But we don't know whether the power state check is still skipped during
> power transition on windows 7.
> 
> So IMO the better solution is still to keep the kernel parameter. It
> will break nothing. And the default value is to skip the power state
> check in power transition.

I can't quite tell whether you think we still need the checks in
acpi_power_on() and acpi_power_off_device().  You proposed setting
"acpi_power_nocheck = 1" by default, which would cause us to bypass
the checks.

Removing the checks completely from those paths only means we wouldn't
be able to use "acpi.power_nocheck=0" to force checking the state after
a transition.  I really don't think users are going to do that, so I
don't think it's worth cluttering the code with those checks.

I'll post that patch again in a separate thread.

Bjorn

> > References:
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13243
> >     http://marc.info/?l=linux-acpi&m=124166053803753&w=2
> >     http://marc.info/?l=linux-acpi&m=124175761408256&w=2
> >     http://marc.info/?l=linux-acpi&m=124210593114061&w=2
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > CC: Yakui Zhao <yakui.zhao@intel.com>
> > CC: Matthew Garrett <mjg59@srcf.ucam.org>
> > CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> > CC: Witold Szczeponik <Witold.Szczeponik@gmx.net>
> > CC: Len Brown <lenb@kernel.org>
> > ---
> >  drivers/acpi/power.c |   28 ++--------------------------
> >  1 files changed, 2 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> > index 56665a6..d74365d 100644
> > --- a/drivers/acpi/power.c
> > +++ b/drivers/acpi/power.c
> > @@ -194,7 +194,7 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
> >  
> >  static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
> >  {
> > -	int result = 0, state;
> > +	int result = 0;
> >  	int found = 0;
> >  	acpi_status status = AE_OK;
> >  	struct acpi_power_resource *resource = NULL;
> > @@ -236,18 +236,6 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> >  
> > -	if (!acpi_power_nocheck) {
> > -		/*
> > -		 * If acpi_power_nocheck is set, it is unnecessary to check
> > -		 * the power state after power transition.
> > -		 */
> > -		result = acpi_power_get_state(resource->device->handle,
> > -				&state);
> > -		if (result)
> > -			return result;
> > -		if (state != ACPI_POWER_RESOURCE_STATE_ON)
> > -			return -ENOEXEC;
> > -	}
> >  	/* Update the power resource's _device_ power state */
> >  	resource->device->power.state = ACPI_STATE_D0;
> >  
> > @@ -258,7 +246,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
> >  
> >  static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
> >  {
> > -	int result = 0, state;
> > +	int result = 0;
> >  	acpi_status status = AE_OK;
> >  	struct acpi_power_resource *resource = NULL;
> >  	struct list_head *node, *next;
> > @@ -293,18 +281,6 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
> >  	if (ACPI_FAILURE(status))
> >  		return -ENODEV;
> >  
> > -	if (!acpi_power_nocheck) {
> > -		/*
> > -		 * If acpi_power_nocheck is set, it is unnecessary to check
> > -		 * the power state after power transition.
> > -		 */
> > -		result = acpi_power_get_state(handle, &state);
> > -		if (result)
> > -			return result;
> > -		if (state != ACPI_POWER_RESOURCE_STATE_OFF)
> > -			return -ENOEXEC;
> > -	}
> > -
> >  	/* Update the power resource's _device_ power state */
> >  	resource->device->power.state = ACPI_STATE_D3;
> >  
> 
> 

