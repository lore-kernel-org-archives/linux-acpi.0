From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent asus boards
Date: Wed, 12 Mar 2008 00:10:41 -0400
Message-ID: <200803120010.41373.lenb@kernel.org>
References: <1205280392.8194.46.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60054 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYCLEK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 00:10:57 -0400
In-Reply-To: <1205280392.8194.46.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Applied.

thanks,
-Len

On Tuesday 11 March 2008, Thomas Renninger wrote:
> Warn user about a BIOS bug in recent asus boards
> 
> Do copy passive devices only if they are valid.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> ---
>  drivers/acpi/thermal.c |   20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> Index: linux-2.6.24/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.24.orig/drivers/acpi/thermal.c
> +++ linux-2.6.24/drivers/acpi/thermal.c
> @@ -440,16 +440,18 @@ static int acpi_thermal_trips_update(str
>  		memset(&devices, 0, sizeof(struct acpi_handle_list));
>  		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
>  							NULL, &devices);
> -		if (ACPI_FAILURE(status))
> -			tz->trips.passive.flags.valid = 0;
> -		else
> +		if (ACPI_SUCCESS(status)) {
>  			tz->trips.passive.flags.valid = 1;
> -
> -		if (memcmp(&tz->trips.passive.devices, &devices,
> -				sizeof(struct acpi_handle_list))) {
> -			memcpy(&tz->trips.passive.devices, &devices,
> -				sizeof(struct acpi_handle_list));
> -			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			if (memcmp(&tz->trips.passive.devices, &devices,
> +				   sizeof(struct acpi_handle_list))) {
> +				memcpy(&tz->trips.passive.devices, &devices,
> +				       sizeof(struct acpi_handle_list));
> +				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
> +			}
> +		} else {
> +			tz->trips.passive.flags.valid = 0;
> +			ACPI_EXCEPTION((AE_INFO, status, "Invalid passiv trip"
> +					" point\n"));
>  		}
>  	}
>  	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


