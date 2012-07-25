From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 09/16] Thermal: Introduce thermal_zone_trip_update()
Date: Wed, 25 Jul 2012 22:31:38 +0200
Message-ID: <201207252231.38781.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-10-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57137 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2GYUZ4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:25:56 -0400
In-Reply-To: <1343182273-32096-10-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
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
> ---
>  drivers/acpi/thermal.c        |    7 +++-
>  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++++++------------
>  2 files changed, 71 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 5417362..8f8e695 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -714,7 +714,12 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
>  	if (thermal_get_trip_type(thermal, trip, &type))
>  		return -EINVAL;
>  
> -	/* Only PASSIVE trip points need TREND */
> +	if (type == THERMAL_TRIP_ACTIVE) {
> +		/* aggressive active cooling */
> +		*trend = THERMAL_TREND_RAISING;
> +		return 0;
> +	}
> +

Do we still need the check below?

>  	if (type != THERMAL_TRIP_PASSIVE)
>  		return -EINVAL;
>  
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 727aa74..cc1b192 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1080,6 +1080,70 @@ void thermal_cooling_device_unregister(struct
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
> +	if (temp >= trip_temp) {
> +		thermal_get_trend(tz, trip, &trend);

I see that you need thermal_get_trend() here.

BTW, why don't you make it return the trend instead of passing the poiter to it?

> +
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

But wouldn't it be good to check the trend here too?  So that we don't
go to the lower state if the trend is rising, for example?

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
> @@ -1090,9 +1154,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  	int count, ret = 0;
>  	long temp, trip_temp;
>  	enum thermal_trip_type trip_type;
> -	struct thermal_cooling_device_instance *instance;
> -	struct thermal_cooling_device *cdev;
> -	unsigned long cur_state, max_state;
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -1128,29 +1189,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
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
> 

Thanks,
Rafael
