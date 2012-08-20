From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 11/13] Thermal: Introduce simple arbitrator for
 setting device cooling state
Date: Mon, 20 Aug 2012 18:46:25 +0300
Message-ID: <20120820154625.GD9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-12-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46368 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751641Ab2HTPqd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:46:33 -0400
Received: by weyu54 with SMTP id u54so4613341wey.31
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:46:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-12-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:21PM +0800, Zhang Rui wrote:
> This fixes the problem that a cooling device may be referenced by
> by multiple trip points in multiple thermal zones.
> 
> With this patch, we have two stages for updating a thermal zone,
> 1. check if a thermal_instance needs to be updated or not
> 2. update the cooling device, based on the target cooling state
>    of all its instances.
> 
> Note that, currently, the cooling device is set to the deepest
> cooling state required.
> 
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/thermal_sys.c |   44 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/thermal.h       |    1 +
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 9906717..027b8e2 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -41,6 +41,7 @@ MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>  
> +#define THERMAL_NO_TARGET -1UL
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> @@ -54,6 +55,7 @@ struct thermal_instance {
>  	int trip;
>  	unsigned long upper;	/* Highest cooling state for this trip point */
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
> +	unsigned long target;	/* expected cooling state */
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
>  	struct list_head tz_node; /* node in tz->thermal_instances */
> @@ -853,6 +855,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	dev->trip = trip;
>  	dev->upper = upper;
>  	dev->lower = lower;
> +	dev->target = THERMAL_NO_TARGET;
>  
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> @@ -990,6 +993,7 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	strcpy(cdev->type, type);
>  	INIT_LIST_HEAD(&cdev->thermal_instances);
>  	cdev->ops = ops;
> +	cdev->updated = true;
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> @@ -1081,6 +1085,34 @@ void thermal_cooling_device_unregister(struct
>  }
>  EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  
> +static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_instance *instance;
> +	unsigned long target = 0;
> +
> +	/* cooling device is updated*/
> +	if (cdev->updated)
> +		return;
> +
> +	/* Make sure cdev enters the deepest cooling state */
> +	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> +		if (instance->target == THERMAL_NO_TARGET)
> +			continue;
> +		if (instance->target > target)
> +			target = instance->target;
> +	}
> +	cdev->ops->set_cur_state(cdev, target);
> +	cdev->updated = true;
> +}
> +
> +static void thermal_zone_do_update(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *instance;
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> +		thermal_cdev_do_update(instance->cdev);
> +}
> +
>  /*
>   * Cooling algorithm for active trip points
>   *
> @@ -1138,19 +1170,24 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  				cur_state = cur_state > instance->lower ?
>  				    (cur_state - 1) : instance->lower;
>  			}
> -			cdev->ops->set_cur_state(cdev, cur_state);
> +			instance->target = cur_state;
> +			cdev->updated = false; /* cooling device needs update */
>  		}
>  	} else {	/* below trip */
>  		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> +			/* Do not use the inactive thermal instance */
> +			if (instance->target == THERMAL_NO_TARGET)
> +				continue;
>  			cdev = instance->cdev;
>  			cdev->ops->get_cur_state(cdev, &cur_state);
>  
>  			cur_state = cur_state > instance->lower ?
> -				    (cur_state - 1) : instance->lower;
> -			cdev->ops->set_cur_state(cdev, cur_state);
> +				    (cur_state - 1) : THERMAL_NO_TARGET;
> +			instance->target = cur_state;
> +			cdev->updated = false; /* cooling device needs update */
>  		}
>  	}
>  
> @@ -1211,6 +1248,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  		}
>  	}
>  
> +	thermal_zone_do_update(tz);
>  	if (tz->forced_passive)
>  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
>  					    THERMAL_TRIPS_NONE);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index bcf3384..3e66214 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -94,6 +94,7 @@ struct thermal_cooling_device {
>  	struct device device;
>  	void *devdata;
>  	const struct thermal_cooling_device_ops *ops;
> +	bool updated; /* true if the cooling device does not need update */
>  	struct list_head thermal_instances;
>  	struct list_head node;
>  };
> -- 
> 1.7.9.5
> 
