From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Add check preventing transitioning to non-D0 state from D3.
Date: Wed, 30 Jan 2013 22:55:17 +0100
Message-ID: <12389653.2bKflhlsko@vostro.rjw.lan>
References: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com> <4595012.aPT9n2OZdk@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34389 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755878Ab3A3VtG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2013 16:49:06 -0500
In-Reply-To: <4595012.aPT9n2OZdk@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, January 30, 2013 06:53:46 PM Peter Wu wrote:
> Hi Lv Zheng,
> 
> I encounter a regression with your patch (Linux 3.8-rc5). On my Nvidia Optimus 
> laptop, I use the bbswitch[1] kernel module to trigger a _PS3 ACPI method call 
> to turn the video card off.
> 
> After this patch, I got the following in my kernel log:
> 
>     pci 0000:01:00.0: Refused to change power state, currently in D0
>     ACPI: Cannot transition to non-D0 state from D3
>     bbswitch: Succesfully loaded. Discrete card 0000:01:00.0 is on
> 
> The expected output would be "Discrete card 0000:01:00.0 is  off". Printing the 
> contents of (acpi_device) device->power.state shows FF (ACPI_STATE_UNKNOWN). 
> Should this condition be excluded from your check or is my hacky module 
> outdated?
> 
> I currently workaround this issue by checking for ACPI_STATE_UNKNOWN. If that 
> is the value, I assume on (overwrite device->power.state with ACPI_STATE_D0). 
> Then I call pci_set_power_state(pci_dev, PCI_D3cold).

You shouldn't ever be transitioning from an uknown state to D3cold directly.
Please first transition to D0 and then to D3cold.

Can you please test the linux-next branch of the linux-pm.git tree and check
if you see this problem in there too?

Rafael


>  [1]: https://github.com/Bumblebee-Project/bbswitch
> 
> On Thursday 15 November 2012 12:25:01 Lv Zheng wrote:
> > No power transitioning from D3 state to a non-D0 state is allowed.
> > This patch also cleans up device power updating code in the
> > acpi_device_set_power() as it should already been updated in the
> > acpi_power_transition().
> > 
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > ---
> >  drivers/acpi/bus.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 07a20ee..12c1b51 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -293,6 +293,12 @@ int acpi_device_set_power(struct acpi_device *device,
> > int state) " state than parent\n");
> >  		return -ENODEV;
> >  	}
> > +	if (device->parent->power.state >= ACPI_STATE_D3_HOT &&
> > +	    state != ACPI_STATE_D0) {
> > +		printk(KERN_WARNING PREFIX
> > +			      "Cannot transition to non-D0 state from D3\n");
> > +		return -ENODEV;
> > +	}
> > 
> >  	/* For D3cold we should execute _PS3, not _PS4. */
> >  	if (state == ACPI_STATE_D3_COLD)
> > @@ -341,7 +347,6 @@ int acpi_device_set_power(struct acpi_device *device,
> > int state) "Device [%s] failed to transition to %s\n",
> >  			      device->pnp.bus_id, state_string(state));
> >  	else {
> > -		device->power.state = state;
> >  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >  				  "Device [%s] transitioned to %s\n",
> >  				  device->pnp.bus_id, state_string(state)));
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
