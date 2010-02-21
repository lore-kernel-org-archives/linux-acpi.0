From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI thermal: Don't invalidate thermal zone if
 critical trip point is bad
Date: Sun, 21 Feb 2010 10:51:22 +0800
Message-ID: <1266720682.2608.38.camel@rzhang1-desktop>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
	 <1266662667-3013-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53293 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab0BUCvq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2010 21:51:46 -0500
In-Reply-To: <1266662667-3013-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "clarkt@cnsp.com" <clarkt@cnsp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-02-20 at 18:44 +0800, Thomas Renninger wrote:
> V2: Corrected integer/long conversion.
> 
> Some BIOSes return a negative value for the critical trip point.
> Especially since Windows 2006...
> We currently invalidate the whole thermal zone in this case.
> But it may still be needed for cooling, also without critical
> trip point.
> 
> This patch invalidates the critical trip point if no _CRT
> function is found or if it returns negative values, but does
> not invalidate the whole thermal zone in this case.
> 
> Reference: http://bugzilla.novell.com/show_bug.cgi?id=531547
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Tested-by: clarkt@cnsp.com
> CC: clarkt@cnsp.com
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/thermal.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 9073ada..77b8e1e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -368,7 +368,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  	int valid = 0;
>  	int i;
>  
> -	/* Critical Shutdown (required) */
> +	/* Critical Shutdown */
>  	if (flag & ACPI_TRIPS_CRITICAL) {
>  		status = acpi_evaluate_integer(tz->device->handle,
>  				"_CRT", NULL, &tmp);
> @@ -379,17 +379,19 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  		 * Below zero (Celsius) values clearly aren't right for sure..
>  		 * ... so lets discard those as invalid.
>  		 */
> -		if (ACPI_FAILURE(status) ||
> -				tz->trips.critical.temperature <= 2732) {
> +		if (ACPI_FAILURE(status)) {
> +			tz->trips.critical.flags.valid = 0;
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					  "No critical threshold\n"));

No critical threshold is also a violation of ACPI spec.
what about using FW_BUG here as well?

thanks,
rui

> +		} else if (tmp <= 2732) {
> +			printk(KERN_WARNING FW_BUG "Invalid critical threshold "
> +			       "(%llu)\n", tmp);
>  			tz->trips.critical.flags.valid = 0;
> -			ACPI_EXCEPTION((AE_INFO, status,
> -					"No or invalid critical threshold"));
> -			return -ENODEV;
>  		} else {
>  			tz->trips.critical.flags.valid = 1;
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -					"Found critical threshold [%lu]\n",
> -					tz->trips.critical.temperature));
> +					  "Found critical threshold [%lu]\n",
> +					  tz->trips.critical.temperature));
>  		}
>  		if (tz->trips.critical.flags.valid == 1) {
>  			if (crt == -1) {


