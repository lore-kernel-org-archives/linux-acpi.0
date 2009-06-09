From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2.6.30-rc4] thermal: fix off-by-1 error in trip point trigger condition
Date: Tue, 9 Jun 2009 15:10:10 +0200
Message-ID: <200906091510.11285.trenn@suse.de>
References: <200905061934.21821.eightgraph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41192 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588AbZFINKK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Jun 2009 09:10:10 -0400
In-Reply-To: <200905061934.21821.eightgraph@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vladimir Zajac <eightgraph@gmail.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 06 May 2009 19:34:21 Vladimir Zajac wrote:
> This patch fixes a regression caused by commit
> b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
> "ACPI: move thermal trip handling to generic thermal layer"
> which accidentally changed trip point trigger condition to
>   temp > trip_temp
> 
> This patch changes the trigger condition back to
>   temp >= trip_temp
> 
> Signed-off-by: Vladimir Zajac <eightgraph@gmail.com>
This one should have
CC: stable@kernel.org
added.
Vladimir, do you mind submitting this one for stable inclusion
if not done already.

Thanks,

     Thomas

> ---
> 
>  thermal_sys.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-2.6.30-rc4/drivers/thermal/thermal_sys.c	2009-04-30 
23:52:59.000000000 +0200
> +++ linux-2.6.30-rc4-p1/drivers/thermal/thermal_sys.c	2009-05-04 
19:58:30.000000000 +0200
> @@ -961,7 +961,7 @@ void thermal_zone_device_update(struct t
>  
>  		switch (trip_type) {
>  		case THERMAL_TRIP_CRITICAL:
> -			if (temp > trip_temp) {
> +			if (temp >= trip_temp) {
>  				if (tz->ops->notify)
>  					ret = tz->ops->notify(tz, count,
>  							      trip_type);
> @@ -974,7 +974,7 @@ void thermal_zone_device_update(struct t
>  			}
>  			break;
>  		case THERMAL_TRIP_HOT:
> -			if (temp > trip_temp)
> +			if (temp >= trip_temp)
>  				if (tz->ops->notify)
>  					tz->ops->notify(tz, count, trip_type);
>  			break;
> @@ -986,14 +986,14 @@ void thermal_zone_device_update(struct t
>  
>  				cdev = instance->cdev;
>  
> -				if (temp > trip_temp)
> +				if (temp >= trip_temp)
>  					cdev->ops->set_cur_state(cdev, 1);
>  				else
>  					cdev->ops->set_cur_state(cdev, 0);
>  			}
>  			break;
>  		case THERMAL_TRIP_PASSIVE:
> -			if (temp > trip_temp || tz->passive)
> +			if (temp >= trip_temp || tz->passive)
>  				thermal_zone_device_passive(tz, temp,
>  							    trip_temp, count);
>  			break;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


