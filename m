From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/16] Thermal: Introduce .get_trend() callback.
Date: Thu, 19 Jul 2012 23:13:58 +0200
Message-ID: <201207192313.58318.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <1342679480-5336-8-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48671 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab2GSVIT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 17:08:19 -0400
In-Reply-To: <1342679480-5336-8-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Thursday, July 19, 2012, Zhang Rui wrote:
> tc1 and tc2 are used by OSPM to anticipate the temperature trends.
> But they are ACPI platform specific concepts.
> 
> Introduce .get_trend() as a more general solution.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c        |   30 ++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_sys.c |   19 +++++++++++++++++--
>  include/linux/thermal.h       |    9 +++++++++
>  3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index a7c97f5..b345646 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -704,6 +704,35 @@ static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
>  		return -EINVAL;
>  }
>  
> +static int thermal_get_trend(struct thermal_zone_device *thermal,
> +				int trip, enum thermal_trend *trend)
> +{
> +	struct acpi_thermal *tz = thermal->devdata;
> +	enum thermal_trip_type type;
> +	unsigned long trip_temp;
> +	int i;
> +
> +	if (thermal_get_trip_type(thermal, trip, &type))
> +		return -EINVAL;
> +
> +	/* Only PASSIVE trip points need TREND */
> +	if (type != THERMAL_TRIP_PASSIVE)
> +		return -EINVAL;
> +
> +	/*
> +	 * tz->temperature has already been updated by generic thermal layer,
> +	 * before this callback being invoked
> +	 */
> +	i = (tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature))
> +		+ (tz->trips.passive.tc2
> +		* (tz->temperature - tz->trips.passive.temperature));
> +
> +	*trend = i > 0 ? THERMAL_TREND_RAISING :
> +		(i < 0 ? THERMAL_TREND_DROPPING : THERMAL_TREND_STABLE);

I'd use if (...) / else if (...) / else here.  It would be _way_ more readable.

> +	return 0;
> +}
> +
> +
>  static int thermal_notify(struct thermal_zone_device *thermal, int trip,
>  			   enum thermal_trip_type trip_type)
>  {
> @@ -832,6 +861,7 @@ static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>  	.get_trip_type = thermal_get_trip_type,
>  	.get_trip_temp = thermal_get_trip_temp,
>  	.get_crit_temp = thermal_get_crit_temp,
> +	.get_trend = thermal_get_trend,
>  	.notify = thermal_notify,
>  };
>  
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index db35300..29b6dba 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -698,6 +698,18 @@ thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  }
>  #endif
>  
> +static void thermal_get_trend(struct thermal_zone_device *tz,
> +		int trip, enum thermal_trend *trend)

The fact that this function has the same name as the ACPI one above is kind of
disturbing.  Any chance to call it differently?

> +{
> +	if (tz->ops->get_trend)
> +		if (!tz->ops->get_trend(tz, trip, trend))
> +			return;

What about:

+	if (tz->ops->get_trend && !tz->ops->get_trend(tz, trip, trend))
+		return;

And since the error code returned by .get_trend() apparently doesn't matter,
shouldn't it return a bool?

> +
> +	*trend = tz->temperature >= tz->last_temperature ?
> +		 THERMAL_TREND_RAISING : THERMAL_TREND_DROPPING;
> +	return;
> +}
> +
>  static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  					    int delay)
>  {
> @@ -732,6 +744,8 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  	if (temp >= trip_temp) {
>  		tz->passive = true;
>  
> +		thermal_get_trend(tz, trip, (enum thermal_trend *)&trend);

What's wrong with the data type of 'trend' here?

> +
>  		trend = (tz->tc1 * (temp - tz->last_temperature)) +
>  			(tz->tc2 * (temp - trip_temp));
>  
> @@ -1090,6 +1104,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  		goto leave;
>  	}
>  
> +	tz->last_temperature = tz->temperature;
> +	tz->temperature = temp;
> +
>  	for (count = 0; count < tz->trips; count++) {
>  		tz->ops->get_trip_type(tz, count, &trip_type);
>  		tz->ops->get_trip_temp(tz, count, &trip_temp);
> @@ -1149,8 +1166,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
>  					    THERMAL_TRIPS_NONE);
>  
> -	tz->last_temperature = temp;
> -

I'm not sure if this is correct.  It seems to change the behavior of
thermal_zone_device_passive() in a subtle way, but I'm not sure that really
matters.  Does it?

>  leave:
>  	if (tz->passive)
>  		thermal_zone_device_set_polling(tz, tz->passive_delay);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b355c62..ab656d6 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -44,6 +44,12 @@ enum thermal_trip_type {
>  	THERMAL_TRIP_CRITICAL,
>  };
>  
> +enum thermal_trend {
> +	THERMAL_TREND_STABLE, /* temperature is stable */
> +	THERMAL_TREND_RAISING, /* temperature is raising */
> +	THERMAL_TREND_DROPPING, /* temperature is dropping */
> +};
> +
>  struct thermal_zone_device_ops {
>  	int (*bind) (struct thermal_zone_device *,
>  		     struct thermal_cooling_device *);
> @@ -65,6 +71,8 @@ struct thermal_zone_device_ops {
>  	int (*set_trip_hyst) (struct thermal_zone_device *, int,
>  			      unsigned long);
>  	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*get_trend) (struct thermal_zone_device *, int,
> +			  enum thermal_trend *);
>  	int (*notify) (struct thermal_zone_device *, int,
>  		       enum thermal_trip_type);
>  };
> @@ -109,6 +117,7 @@ struct thermal_zone_device {
>  	int tc2;
>  	int passive_delay;
>  	int polling_delay;
> +	int temperature;
>  	int last_temperature;
>  	bool passive;
>  	unsigned int forced_passive;
> 

Thanks,
Rafael
