From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/6] ACPI: button: minor cleanups
Date: Wed, 6 May 2009 11:20:52 -0600
Message-ID: <200905061120.52793.bjorn.helgaas@hp.com>
References: <20090408153427.12354.62167.stgit@bob.kio> <200904171339.15895.bjorn.helgaas@hp.com> <200905061713.08057.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:40672 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbZEFRUz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2009 13:20:55 -0400
In-Reply-To: <200905061713.08057.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wednesday 06 May 2009 09:13:07 am Thomas Renninger wrote:
> Below is the outcome of the patch which fixes a fixed feature button
> s2ram issue.
> 
> This does not work anymore since Bjoern's patches.
> Comparing the with the HID of the acpi device looks ugly.
> 
> Shall I revive the fixed feature vs GPE button types?
> ACPI_BUTTON_TYPE_POWERF and ACPI_BUTTON_TYPE_SLEEPF?

I don't understand exactly how I broke this.

Your patch makes us remove the fixed event handler in .suspend()
and install it again in .resume().  In 2.6.29, we didn't touch the
handler during suspend/resume, and my patches didn't change that
aspect of things.

Whatever the problem is, it feels like something that should be
handled in the Linux/ACPI code, not in the driver.

Did you identify the patch that broke things?  My guess would be
373cfc360ec773b, but I took a look at it (and 46ec8598fde74b, on
which it depends), and I don't see the problem yet.

Bjorn

> Can you think of anything nicer?
> 
> Thanks,
> 
>      Thomas
> 
> 
> ACPI: button: Fix fixed feature buttons for s2disk for HW modifing event registers
> 
> This happened on a recent HP laptop. After s2disk the fixed feature power button
> event handler is not functional because the BIOS has modified the fixed feature
> register(s) when resuming/rebooting after s2disk.
> Setting up some bits there again by unregistering and re-installing the fixed
> feature event handler fixes the problem and the button is functional again after s2disk.
> 
> Comment from Rafael:
> This may be a consequence of the fact that we initialize ACPI before reading
> the hibernation image from disk.  The spec seems to assume that won't be done. 
> Hence, I think we should handle this.
> 
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 9195deb..80ee2bc 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -74,6 +74,7 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
>  static int acpi_button_add(struct acpi_device *device);
>  static int acpi_button_remove(struct acpi_device *device, int type);
>  static int acpi_button_resume(struct acpi_device *device);
> +static int acpi_button_suspend(struct acpi_device *device, pm_message_t state);
>  static void acpi_button_notify(struct acpi_device *device, u32 event);
>  static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
>  static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
> @@ -85,6 +86,7 @@ static struct acpi_driver acpi_button_driver = {
>  	.ops = {
>  		.add = acpi_button_add,
>  		.resume = acpi_button_resume,
> +		.suspend = acpi_button_suspend,
>  		.remove = acpi_button_remove,
>  		.notify = acpi_button_notify,
>  	},
> @@ -281,8 +283,41 @@ static int acpi_button_resume(struct acpi_device *device)
>  {
>  	struct acpi_button *button = acpi_driver_data(device);
>  
> -	if (button->type == ACPI_BUTTON_TYPE_LID)
> +	if (!button)
> +		return -EINVAL;
> +	switch (button->type) {
> +	case ACPI_BUTTON_TYPE_LID:
>  		return acpi_lid_send_state(device);
> +	case ACPI_BUTTON_TYPE_SLEEPF:
> +		return acpi_install_fixed_event_handler(
> +					ACPI_EVENT_SLEEP_BUTTON,
> +					acpi_button_notify_fixed, button);
> +
> +	case ACPI_BUTTON_TYPE_POWERF:
> +		return acpi_install_fixed_event_handler(
> +					ACPI_EVENT_POWER_BUTTON,
> +					acpi_button_notify_fixed, button);
> +	}
> +	return 0;
> +}
> +
> +static int acpi_button_suspend(struct acpi_device *device, pm_message_t state)
> +{
> +	struct acpi_button *button;
> +	if (!device)
> +		return -EINVAL;
> +	button = acpi_driver_data(device);
> +	if (!button)
> +		return -EINVAL;
> +	switch (button->type) {
> +	case ACPI_BUTTON_TYPE_SLEEPF:
> +		return acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +					       acpi_button_notify_fixed);
> +
> +	case ACPI_BUTTON_TYPE_POWERF:
> +		return acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +					       acpi_button_notify_fixed);
> +	}
>  	return 0;
>  }
>  
> 


