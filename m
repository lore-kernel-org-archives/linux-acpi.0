From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] ACPI/Thermal: Add check of "_TZD" availability and evaluating result
Date: Mon, 26 Aug 2013 13:41:07 +0200
Message-ID: <2773863.ZenhaZXiiA@vostro.rjw.lan>
References: <1377483270-16841-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34742 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab3HZLa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Aug 2013 07:30:28 -0400
In-Reply-To: <1377483270-16841-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Monday, August 26, 2013 10:14:30 AM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> Some machines don't provide _TZD. So add check of "_TZD" availability
> before doing futher operations. This patch also adds the check of
> evaluating result.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  Change sicne v1:
> 	Arrange the whitespace, using "tz->devices = devices"
> instead of memcpy() and sizeof(devices) instead of sizeof(struct ...)
> 
>  drivers/acpi/thermal.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 09f9340..177ecca 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -492,14 +492,14 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  			break;
>  	}
>  
> -	if (flag & ACPI_TRIPS_DEVICES) {
> -		memset(&devices, 0, sizeof(struct acpi_handle_list));
> +	if ((flag & ACPI_TRIPS_DEVICES)
> +	    && acpi_has_method(tz->device->handle, "_TZD")) {
> +		memset(&devices, 0, sizeof(devices));
>  		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
>  						NULL, &devices);
> -		if (memcmp(&tz->devices, &devices,
> -				sizeof(struct acpi_handle_list))) {
> -			memcpy(&tz->devices, &devices,
> -				sizeof(struct acpi_handle_list));
> +		if (ACPI_SUCCESS(status) && memcmp(&tz->devices, &devices,
> +		    sizeof(devices))) {

No line break here, please.  Do this:

		if (ACPI_SUCCESS(status)
		    && memcmp(&tz->devices, &devices, sizeof(devices))) {

> +			tz->devices = devices;
>  			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
>  		}
>  	}

Thanks,
Rafael

