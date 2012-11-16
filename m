From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / PM: Add check preventing transitioning to non-D0 state from D3.
Date: Fri, 16 Nov 2012 02:49:54 +0100
Message-ID: <2072306.j28QTtV7ui@vostro.rjw.lan>
References: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47545 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2KPBpb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2012 20:45:31 -0500
In-Reply-To: <e4ec829902580af84cddbba6e98ef54b33052b85.1352953283.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thursday, November 15, 2012 12:25:01 PM Lv Zheng wrote:
> No power transitioning from D3 state to a non-D0 state is allowed.
> This patch also cleans up device power updating code in the
> acpi_device_set_power() as it should already been updated in the
> acpi_power_transition().
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/bus.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07a20ee..12c1b51 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -293,6 +293,12 @@ int acpi_device_set_power(struct acpi_device *device, int state)
>  			      " state than parent\n");
>  		return -ENODEV;
>  	}
> +	if (device->parent->power.state >= ACPI_STATE_D3_HOT &&

Why parent?  The device's own power state shouldn't be D3, right?

> +	    state != ACPI_STATE_D0) {
> +		printk(KERN_WARNING PREFIX
> +			      "Cannot transition to non-D0 state from D3\n");
> +		return -ENODEV;
> +	}

I fixed up the check and moved it into the (state < device->power.state)
block, because otherwise it would prevent transitions from D3_HOT to
D3_COLD from being carried out, but they are allowed.

>  	/* For D3cold we should execute _PS3, not _PS4. */
>  	if (state == ACPI_STATE_D3_COLD)
> @@ -341,7 +347,6 @@ int acpi_device_set_power(struct acpi_device *device, int state)
>  			      "Device [%s] failed to transition to %s\n",
>  			      device->pnp.bus_id, state_string(state));
>  	else {
> -		device->power.state = state;
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Device [%s] transitioned to %s\n",
>  				  device->pnp.bus_id, state_string(state)));
> 

Please check the linux-next branch of linux-pm.git and see if that's what you
wanted. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
