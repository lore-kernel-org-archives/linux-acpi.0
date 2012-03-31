From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v3 1/3] ACPI: Introduce ACPI D3_COLD state support
Date: Sat, 31 Mar 2012 23:31:55 +0800
Message-ID: <20120331153155.GA8169@localhost.amd.com>
References: <1333001380-6050-1-git-send-email-ming.m.lin@intel.com>
 <1333001380-6050-2-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:49733 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751274Ab2CaHcR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2012 03:32:17 -0400
Content-Disposition: inline
In-Reply-To: <1333001380-6050-2-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2012 at 02:09:38PM +0800, Lin Ming wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> If a device has _PR3, it means the device supports D3_COLD.
> Add the ability to validate and enter D3_COLD state in ACPI.

Since we are going to support two D3 states, I think maybe we should
clear their meanings in Linux. So D3 means D3 hot, right?

If so, I think the following code has problems:

static int acpi_bus_get_power_flags(struct acpi_device *device)
{
	... ...

	/* Set defaults for D0 and D3 states (always valid) */
	device->power.states[ACPI_STATE_D0].flags.valid = 1;
	device->power.states[ACPI_STATE_D0].power = 100;
	device->power.states[ACPI_STATE_D3].flags.valid = 1;
	device->power.states[ACPI_STATE_D3].power = 0;
}

The problem is, D3's valid flag shouldn't be set and its power shouldn't
be 0 since it's D3 hot. It feels like D3_COLD should be used instead.

What do you think? Thanks.

-Aaron

> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  drivers/acpi/power.c |    4 ++--
>  drivers/acpi/scan.c  |    7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 9ac2a9f..0d681fb 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -500,14 +500,14 @@ int acpi_power_transition(struct acpi_device *device, int state)
>  {
>  	int result;
>  
> -	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3))
> +	if (!device || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
>  		return -EINVAL;
>  
>  	if (device->power.state == state)
>  		return 0;
>  
>  	if ((device->power.state < ACPI_STATE_D0)
> -	    || (device->power.state > ACPI_STATE_D3))
> +	    || (device->power.state > ACPI_STATE_D3_COLD))
>  		return -ENODEV;
>  
>  	/* TBD: Resources must be ordered. */
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8ab80ba..571396c 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -885,6 +885,13 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
>  				acpi_bus_add_power_resource(ps->resources.handles[j]);
>  		}
>  
> +		/* The exist of _PR3 indicates D3Cold support */
> +		if (i == ACPI_STATE_D3) {
> +			status = acpi_get_handle(device->handle, object_name, &handle);
> +			if (ACPI_SUCCESS(status))
> +				device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
> +		}
> +
>  		/* Evaluate "_PSx" to see if we can do explicit sets */
>  		object_name[2] = 'S';
>  		status = acpi_get_handle(device->handle, object_name, &handle);
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

