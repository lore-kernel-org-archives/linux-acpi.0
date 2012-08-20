From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 06/13] Thermal: Introduce thermal_zone_trip_update()
Date: Mon, 20 Aug 2012 18:47:56 +0300
Message-ID: <20120820154756.GI9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-7-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48780 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757230Ab2HTPsD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:48:03 -0400
Received: by weyu3 with SMTP id u3so4894361wey.35
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:48:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-7-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:16PM +0800, Zhang Rui wrote:
> This function is used to update the cooling state of
> all the cooling devices that are bound to an active trip point.
> 
> This will be used for passive cooling as well, in the future patches.
> as both active and passive cooling can share the same algorithm,
> which is
> 
> 1. if the temperature is higher than a trip point,
>    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
>       state for this trip point
>    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>       state for this trip point
> 
> 2. if the temperature is lower than a trip point, use lower
>    cooling state for this trip point.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/acpi/thermal.c        |    8 ++--
>  drivers/thermal/thermal_sys.c |  102 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 81 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 0c755d2..a0b1e88 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -714,9 +714,11 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
>  	if (thermal_get_trip_type(thermal, trip, &type))
>  		return -EINVAL;
>  
> -	/* Only PASSIVE trip points need TREND */
> -	if (type != THERMAL_TRIP_PASSIVE)
> -		return -EINVAL;
> +	if (type == THERMAL_TRIP_ACTIVE) {
> +		/* aggressive active cooling */
> +		*trend = THERMAL_TREND_RAISING;
> +		return 0;
> +	}
>  
>  	/*
>  	 * tz->temperature has already been updated by generic thermal layer,
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index a70ed4c..f3156c1 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1076,6 +1076,81 @@ void thermal_cooling_device_unregister(struct
>  }
>  EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  
> +/*
> + * Cooling algorithm for active trip points
> + *
> + * 1. if the temperature is higher than a trip point,
> + *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> + *       state for this trip point
> + *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> + *       state for this trip point
> + *
> + * 2. if the temperature is lower than a trip point, use lower
> + *    cooling state for this trip point
> + *
> + * Note that this behaves the same as the previous passive cooling
> + * algorithm.
> + */
> +
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> +				     int trip, long temp)
> +{
> +	struct thermal_cooling_device_instance *instance;
> +	struct thermal_cooling_device *cdev = NULL;
> +	unsigned long cur_state, max_state;
> +	long trip_temp;
> +	enum thermal_trend trend;
> +
> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +
> +	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend)) {
> +		/*
> +		 * compare the current temperature and previous temperature
> +		 * to get the thermal trend, if no special requirement
> +		 */
> +		if (tz->temperature > tz->last_temperature)
> +			trend = THERMAL_TREND_RAISING;
> +		else if (tz->temperature < tz->last_temperature)
> +			trend = THERMAL_TREND_DROPPING;
> +		else
> +			trend = THERMAL_TREND_STABLE;
> +	}
> +
> +	if (temp >= trip_temp) {
> +		list_for_each_entry(instance, &tz->cooling_devices, node) {
> +			if (instance->trip != trip)
> +				continue;
> +
> +			cdev = instance->cdev;
> +
> +			cdev->ops->get_cur_state(cdev, &cur_state);
> +			cdev->ops->get_max_state(cdev, &max_state);
> +
> +			if (trend == THERMAL_TREND_RAISING) {
> +				cur_state = cur_state < instance->upper ?
> +					    (cur_state + 1) : instance->upper;
> +			} else if (trend == THERMAL_TREND_DROPPING) {
> +				cur_state = cur_state > instance->lower ?
> +				    (cur_state - 1) : instance->lower;
> +			}
> +			cdev->ops->set_cur_state(cdev, cur_state);
> +		}
> +	} else {	/* below trip */
> +		list_for_each_entry(instance, &tz->cooling_devices, node) {
> +			if (instance->trip != trip)
> +				continue;
> +
> +			cdev = instance->cdev;
> +			cdev->ops->get_cur_state(cdev, &cur_state);
> +
> +			cur_state = cur_state > instance->lower ?
> +				    (cur_state - 1) : instance->lower;
> +			cdev->ops->set_cur_state(cdev, cur_state);
> +		}
> +	}
> +
> +	return;
> +}
>  /**
>   * thermal_zone_device_update - force an update of a thermal zone's state
>   * @ttz:	the thermal zone to update
> @@ -1086,9 +1161,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  	int count, ret = 0;
>  	long temp, trip_temp;
>  	enum thermal_trip_type trip_type;
> -	struct thermal_cooling_device_instance *instance;
> -	struct thermal_cooling_device *cdev;
> -	unsigned long cur_state, max_state;
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -1124,29 +1196,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  					tz->ops->notify(tz, count, trip_type);
>  			break;
>  		case THERMAL_TRIP_ACTIVE:
> -			list_for_each_entry(instance, &tz->cooling_devices,
> -					    node) {
> -				if (instance->trip != count)
> -					continue;
> -
> -				cdev = instance->cdev;
> -
> -				cdev->ops->get_cur_state(cdev, &cur_state);
> -				cdev->ops->get_max_state(cdev, &max_state);
> -
> -				if (temp >= trip_temp)
> -					cur_state =
> -						cur_state < instance->upper ?
> -						(cur_state + 1) :
> -						instance->upper;
> -				else
> -					cur_state =
> -						cur_state > instance->lower ?
> -						(cur_state - 1) :
> -						instance->lower;
> -
> -				cdev->ops->set_cur_state(cdev, cur_state);
> -			}
> +			thermal_zone_trip_update(tz, count, temp);
>  			break;
>  		case THERMAL_TRIP_PASSIVE:
>  			if (temp >= trip_temp || tz->passive)
> -- 
> 1.7.9.5
> 
