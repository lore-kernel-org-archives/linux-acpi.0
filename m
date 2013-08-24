From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/Thermal: Add check of "_TZD" availability and evaluating result
Date: Sat, 24 Aug 2013 16:44:02 +0200
Message-ID: <3673570.IB0e6CCT7B@vostro.rjw.lan>
References: <1377334888-6384-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59318 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690Ab3HXOd0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Aug 2013 10:33:26 -0400
In-Reply-To: <1377334888-6384-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Saturday, August 24, 2013 05:01:28 PM tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> Some machines don't provide _TZD. So add check of "_TZD" availability
> before doing futher operations. This patch also adds the check of
> evaluating result.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 09f9340..6809fbd 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -492,11 +492,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  			break;
>  	}
>  
> -	if (flag & ACPI_TRIPS_DEVICES) {
> +	if ((flag & ACPI_TRIPS_DEVICES)
> +			&& acpi_has_method(tz->device->handle, "_TZD")) {

Please arrange the whitespace here like this:

	if ((flag & ACPI_TRIPS_DEVICES)
	    && acpi_has_method(tz->device->handle, "_TZD")) {


>  		memset(&devices, 0, sizeof(struct acpi_handle_list));
>  		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
>  						NULL, &devices);
> -		if (memcmp(&tz->devices, &devices,
> +		if (ACPI_SUCCESS(status) && memcmp(&tz->devices, &devices,
>  				sizeof(struct acpi_handle_list))) {

I wonder why you can't use "tz->device == devices" here instead of the memcmp?

And also "tz->devices = devices" below for that matter.

>  			memcpy(&tz->devices, &devices,
>  				sizeof(struct acpi_handle_list));

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
