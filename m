From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi: Disable explicit power state retrieval on fans
Date: Mon, 28 Dec 2009 21:47:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912282147360.12663@localhost.localdomain>
References: <1257883752-2163-1-git-send-email-mjg@redhat.com>
 <1260503569.27069.326.camel@rzhang1-desktop>
 <1261036928.27291.21.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:54974 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZL2Crn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2009 21:47:43 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVE001P87RIFCZ7@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 28 Dec 2009 20:47:43 -0600 (CST)
In-reply-to: <1261036928.27291.21.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 17 Dec 2009, Zhang Rui wrote:

> On Fri, 2009-12-11 at 11:52 +0800, Zhang Rui wrote:
> > On Wed, 2009-11-11 at 04:09 +0800, Matthew Garrett wrote:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=531916 describes a system
> > > with a _PSC method for the fan that always returns "on". There's no
> > > benefit in us always requesting the state of the fan when performing
> > > transitions - we want to do everything we can to ensure that the fan turns
> > > on when it should do, not risk hardware damage by believing the hardware
> > > when it tells us the fan is already on. Given that the Leading Other OS(tm)
> > > works fine on this machine, it seems likely that it behaves in much this
> > > way.
> > > 
> > sounds reasonable.
> > But how can we get the power state if power resources is not available?
> > 
> > In acpi_bus_get_power, why not make acpi_power_get_inferred_state as the
> > first choice, instead of evaluating _PSC? like the patch attached.
> > 
> Matthew,
> 
> how about this one?
> 
> 
> If the ACPI power state can be got both directly and indirectly,
> we prefer to get it indirectly.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=531916 describes a
> system with a _PSC method for the fan that always returns "on".
> There's no benefit in us always requesting the state of the fan
> when performing transitions - we want to do everything we can
> to ensure that the fan turns on when it should do, not risk
> hardware damage by believing the hardware when it tells us the
> fan is already on. Given that the Leading Other OS(tm) works fine
> on this machine, it seems likely that it behaves in much this way.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/bus.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/bus.c
> +++ linux-2.6/drivers/acpi/bus.c
> @@ -190,16 +190,16 @@ int acpi_bus_get_power(acpi_handle handl
>  		 * Get the device's power state either directly (via _PSC) or
>  		 * indirectly (via power resources).
>  		 */
> -		if (device->power.flags.explicit_get) {
> +		if (device->power.flags.power_resources) {
> +			result = acpi_power_get_inferred_state(device);
> +			if (result)
> +				return result;
> +		} else if (device->power.flags.explicit_get) {
>  			status = acpi_evaluate_integer(device->handle, "_PSC",
>  						       NULL, &psc);
>  			if (ACPI_FAILURE(status))
>  				return -ENODEV;
>  			device->power.state = (int)psc;
> -		} else if (device->power.flags.power_resources) {
> -			result = acpi_power_get_inferred_state(device);
> -			if (result)
> -				return result;
>  		}
>  
>  		*state = device->power.state;
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
