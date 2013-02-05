From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI / scan: Follow priorities of IDs when matching
 scan handlers
Date: Tue, 05 Feb 2013 16:44:12 -0700
Message-ID: <1360107852.23410.258.camel@misato.fc.hp.com>
References: <1873429.MS5RQDxTye@vostro.rjw.lan>
	 <1359502048.15120.75.camel@misato.fc.hp.com>
	 <25678789.biaFkG0HMW@vostro.rjw.lan> <2566718.DLPxb38Yi2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:35188 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3BEXyW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2013 18:54:22 -0500
In-Reply-To: <2566718.DLPxb38Yi2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, LKML <linux-kernel@vger.kernel.org>

On Sun, 2013-02-03 at 01:52 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The IDs of ACPI device nodes stored in their pnp.ids member arrays
> are sorted by decreasing priority (i.e. the highest-priority ID is
> the first entry).  This means that when matching scan handlers to
> device nodes, the namespace scanning code should walk the list of
> scan handlers for each device node ID instead of walking the list
> of device node IDs for each handler (the latter causes the first
> handler matching any of the device node IDs to be chosen, although
> there may be another handler matching an ID of a higher priority
> which should be preferred).  Make the code follow this observation.
> 
> This change has been suggested and justified by Toshi Kani.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good!  Thanks for making this change. :-)

Acked-by: Toshi Kani <toshi.kani@hp.com>

-Toshi


> ---
>  drivers/acpi/scan.c |   42 +++++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> Index: test/drivers/acpi/scan.c
> ===================================================================
> --- test.orig/drivers/acpi/scan.c
> +++ test/drivers/acpi/scan.c
> @@ -1556,26 +1556,42 @@ static acpi_status acpi_bus_check_add(ac
>  	return AE_OK;
>  }
>  
> -static int acpi_scan_attach_handler(struct acpi_device *device)
> +static int acpi_scan_do_attach_handler(struct acpi_device *device, char *id)
>  {
>  	struct acpi_scan_handler *handler;
> -	int ret = 0;
>  
>  	list_for_each_entry(handler, &acpi_scan_handlers_list, list_node) {
> -		const struct acpi_device_id *id;
> +		const struct acpi_device_id *devid;
>  
> -		id = __acpi_match_device(device, handler->ids);
> -		if (!id)
> -			continue;
> -
> -		ret = handler->attach(device, id);
> -		if (ret > 0) {
> -			device->handler = handler;
> -			break;
> -		} else if (ret < 0) {
> -			break;
> +		for (devid = handler->ids; devid->id[0]; devid++) {
> +			int ret;
> +
> +			if (strcmp((char *)devid->id, id))
> +				continue;
> +
> +			ret = handler->attach(device, devid);
> +			if (ret > 0) {
> +				device->handler = handler;
> +				return ret;
> +			} else if (ret < 0) {
> +				return ret;
> +			}
>  		}
>  	}
> +	return 0;
> +}
> +
> +static int acpi_scan_attach_handler(struct acpi_device *device)
> +{
> +	struct acpi_hardware_id *hwid;
> +	int ret = 0;
> +
> +	list_for_each_entry(hwid, &device->pnp.ids, list) {
> +		ret = acpi_scan_do_attach_handler(device, hwid->id);
> +		if (ret)
> +			break;
> +
> +	}
>  	return ret;
>  }
>  
> 


