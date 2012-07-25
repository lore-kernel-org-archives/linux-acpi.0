From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 05/16] Thermal: Introduce cooling states range support
Date: Wed, 25 Jul 2012 22:08:53 +0200
Message-ID: <201207252208.53633.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-6-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57070 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab2GYUDJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:03:09 -0400
In-Reply-To: <1343182273-32096-6-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> As the active cooling devices can have multiple cooling states,
> we may want only several cooling states for a certain trip point,
> and other cooling states for other active trip points.
> 
> To do this, we should be able to describe the cooling device
> behavior for a certain trip point, rather than for the entire thermal zone.
> And when updating thermal zone, we need to check the upper and lower limit
> to make sure the cooling device is set to the proper cooling state.
> 
> Note that this patch will not bring any different behavior as
> upper limit is set to max_state and lower limit is set to 0
> in this patch, for now.
> 
> Next patch will set these to real values.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |   25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 05f42cd..008e2eb 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -41,12 +41,19 @@ MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>  
> +/*
> + * This structure is used to describe the behavior of
> + * a certain cooling device on a certain trip point
> + * in a certain thermal zone
> + */
>  struct thermal_cooling_device_instance {
>  	int id;
>  	char name[THERMAL_NAME_LENGTH];
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	int trip;
> +	unsigned long upper;	/* Highest cooling state for this trip point */
> +	unsigned long lower;	/* Lowest cooling state for this trip point */
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
>  	struct list_head node;
> @@ -800,6 +807,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_cooling_device_instance *pos;
>  	struct thermal_zone_device *pos1;
>  	struct thermal_cooling_device *pos2;
> +	unsigned long max_state;
>  	int result;
>  
>  	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
> @@ -824,6 +832,11 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	dev->tz = tz;
>  	dev->cdev = cdev;
>  	dev->trip = trip;
> +
> +	cdev->ops->get_max_state(cdev, &max_state);
> +	dev->upper = max_state;
> +	dev->lower = 0;
> +
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
>  		goto free_mem;
> @@ -1103,11 +1116,15 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  				cdev->ops->get_max_state(cdev, &max_state);
>  
>  				if (temp >= trip_temp)
> -					cur_state = cur_state < max_state ?
> -						(cur_state + 1) : max_state;
> +					cur_state =
> +						cur_state < instance->upper ?
> +						(cur_state + 1) :
> +						instance->upper;
>  				else
> -					cur_state = cur_state > 0 ?
> -						(cur_state - 1) : 0;
> +					cur_state =
> +						cur_state > instance->lower ?
> +						(cur_state - 1) :
> +						instance->lower;
>  
>  				cdev->ops->set_cur_state(cdev, cur_state);
>  			}
> 

