From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/3] ACPI: Remove platform devices from a bus on removal
Date: Wed, 19 Apr 2017 14:50:17 +0800
Message-ID: <20170419065017.GA16910@linux-l9pv.suse>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52840 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbdDSGud (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 19 Apr 2017 02:50:33 -0400
Content-Disposition: inline
In-Reply-To: <1490204005-2733-3-git-send-email-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

On Wed, Mar 22, 2017 at 06:33:24PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function acpi_bus_attach() creates platform_devices if
> this is specified by the firmware. But in acpi_bus_trim()
> these devices are not removed, leaving a dangling reference
> to the parent device.
> 
> In the case of a PCI root-bus, this results in the
> host_bridge device not being released on hot-remove.
> 
> Fix it by scanning the list of platform_devices for devices
> to be removed with the bus.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/scan.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1926918..b07518b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -13,6 +13,7 @@
>  #include <linux/dmi.h>
>  #include <linux/nls.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/pgtable.h>
>  
> @@ -1928,6 +1929,25 @@ int acpi_bus_scan(acpi_handle handle)
>  EXPORT_SYMBOL(acpi_bus_scan);
>  
>  /**
> + * acpi_bus_trim_platform_device - Check and remove a platform device
> + *				   from a bus
> + * @dev: Platform device to check
> + * @data: pointer to the acpi_device to check dev against
> + *
> + * Checks whether the platform_device dev belongs to the acpi_device
> + * data and unregisters dev if it matches.
> + */
> +static int acpi_bus_trim_platform_device(struct device *dev, void *data)
> +{
> +	struct acpi_device *adev = data;
> +
> +	if (dev->fwnode == acpi_fwnode_handle(adev))
> +		platform_device_unregister(to_platform_device(dev));
> +
> +	return 0;
> +}
> +
> +/**
>   * acpi_bus_trim - Detach scan handlers and drivers from ACPI device objects.
>   * @adev: Root of the ACPI namespace scope to walk.
>   *
> @@ -1950,6 +1970,12 @@ void acpi_bus_trim(struct acpi_device *adev)
>  	} else {
>  		device_release_driver(&adev->dev);
>  	}
> +
> +	/* Remove platform devices from the bus */
> +	if (adev->pnp.type.platform_id)

This patch cases that dock_notify() is broken in find_dock_station()
because the dock_station platform device was removed.

If anyone wants to apply this patch, then the dock device should be
excluded:

+	if (is_dock_device(adev) && adev->pnp.type.platform_id)

> +		bus_for_each_dev(&platform_bus_type, NULL, adev,
> +				 acpi_bus_trim_platform_device);
> +
>  	/*
>  	 * Most likely, the device is going away, so put it into D3cold before
>  	 * that.

Thanks a lot!
Joey Lee
