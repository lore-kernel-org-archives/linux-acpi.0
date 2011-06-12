From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: execute _PSx control method in acpi_bus_init_power
Date: Sun, 12 Jun 2011 13:05:09 +0200
Message-ID: <201106121305.09760.rjw@sisk.pl>
References: <1306920079.15903.6.camel@srdclcs1.amd.com> <201106011513.15093.rjw@sisk.pl> <20110609012536.GA16797@srdclcs1.amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49266 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab1FLLEa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Jun 2011 07:04:30 -0400
In-Reply-To: <20110609012536.GA16797@srdclcs1.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Thursday, June 09, 2011, Aaron Lu wrote:
> On Wed, Jun 01, 2011 at 03:13:14PM +0200, Rafael J. Wysocki wrote:
> > I will when I get back home from LinuxCon Japan, that should happen by the
> > end of this week.
> 
> Hi Rafael,

Hi,

> Just a reminder, in case you forget :-)

No, I didn't forget, I was busy.

> Here is the patch I've sent to linux-acpi mailinglist:
> 
> V2:
> Added a check to the power state, make sure it's valid before executing
> the _PSx control method.
> 
> V1:
> Per the acpi spec, for OSPM to put the device in the Dx device state,
> the following must occur:
> 1. All Power Resources referenced by elements 1 through N must be in the
> ON state.
> 2. All Power Resources no longer referenced by any device in the system
> must be in the OFF state.
> 3. If present, the _PSx control method is executed to set the device
> into the Dx device state.
> 
> This patch adds support for the execution of _PSx control method during
> device power init phase.
> 
> This could also solves the problem I encountered, please see:
> http://marc.info/?l=linux-acpi&m=130579961021505&w=2
> ---
>  drivers/acpi/bus.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9749980..ea4eb64 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -337,8 +337,22 @@ int acpi_bus_init_power(struct acpi_device *device)
>  	if (result)
>  		return result;
>  
> -	if (device->power.flags.power_resources)
> +	if (device->power.flags.power_resources) {
>  		result = acpi_power_on_resources(device, state);
> +		if (result)
> +			return result;
> +	}

You should use "else if" here, I think.

> +
> +	/* if state is valid and _PSx exists, execute it */

That comment should explain why it is necessary to do that.  It's not quite
obvious, because __acpi_bus_get_power(), called before the new code,
executes _PSC and that should return the state the device is really in.
So, in principle, the code below shouldn't be necessary.  However, if it
is known to fix an initialization issue on at least one system, it won't
hurt to add it.  So please add something like "this code is needed to
fix an initialization problem on <hardware name>".

> +	if (state >= ACPI_STATE_D0 && state <= ACPI_STATE_D3 &&
> +		device->power.states[state].flags.explicit_set) {
> +		acpi_status status;
> +		char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
> +		status = acpi_evaluate_object(device->handle, object_name,
> +				NULL, NULL);
> +		if (ACPI_FAILURE(status))
> +			result = -ENODEV;
> +	}
>  
>  	if (!result)
>  		device->power.state = state;
> 

Thanks,
Rafael
