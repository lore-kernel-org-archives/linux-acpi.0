From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 03/13] Thermal: set upper and lower limits
Date: Mon, 20 Aug 2012 18:50:34 +0300
Message-ID: <20120820155034.GK9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-4-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:58136 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752506Ab2HTPu7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:50:59 -0400
Received: by bkty5 with SMTP id y5so2431488bkt.35
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:50:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-4-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:13PM +0800, Zhang Rui wrote:
> set upper and lower limits when binding
> a thermal cooling device to a thermal zone device.
> 
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

This patch still generates issues on omap-thermal-common.c, even on your thermal branch

A part from that, the patch is fine for me.

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>


> ---
>  Documentation/thermal/sysfs-api.txt |    9 +++++-
>  drivers/acpi/thermal.c              |   53 +++++++++++++++++++++++------------
>  drivers/platform/x86/acerhdf.c      |    3 +-
>  drivers/thermal/thermal_sys.c       |   23 ++++++++++-----
>  include/linux/thermal.h             |    5 +++-
>  5 files changed, 65 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index c087dbc..ca1a1a3 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -84,7 +84,8 @@ temperature) and throttle appropriate devices.
>  
>  1.3 interface for binding a thermal zone device with a thermal cooling device
>  1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
> -		int trip, struct thermal_cooling_device *cdev);
> +	int trip, struct thermal_cooling_device *cdev,
> +	unsigned long upper, unsigned long lower);
>  
>      This interface function bind a thermal cooling device to the certain trip
>      point of a thermal zone device.
> @@ -93,6 +94,12 @@ temperature) and throttle appropriate devices.
>      cdev: thermal cooling device
>      trip: indicates which trip point the cooling devices is associated with
>  	  in this thermal zone.
> +    upper:the Maximum cooling state for this trip point.
> +          THERMAL_NO_LIMIT means no upper limit,
> +	  and the cooling device can be in max_state.
> +    lower:the Minimum cooling state can be used for this trip point.
> +          THERMAL_NO_LIMIT means no lower limit,
> +	  and the cooling device can be in cooling state 0.
>  
>  1.3.2 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  		int trip, struct thermal_cooling_device *cdev);
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 8275e7b..b48ec3e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -727,11 +727,9 @@ static int thermal_notify(struct thermal_zone_device *thermal, int trip,
>  	return 0;
>  }
>  
> -typedef int (*cb)(struct thermal_zone_device *, int,
> -		  struct thermal_cooling_device *);
>  static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev,
> -					cb action)
> +					bool bind)
>  {
>  	struct acpi_device *device = cdev->devdata;
>  	struct acpi_thermal *tz = thermal->devdata;
> @@ -755,11 +753,19 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  		    i++) {
>  			handle = tz->trips.passive.devices.handles[i];
>  			status = acpi_bus_get_device(handle, &dev);
> -			if (ACPI_SUCCESS(status) && (dev == device)) {
> -				result = action(thermal, trip, cdev);
> -				if (result)
> -					goto failed;
> -			}
> +			if (ACPI_FAILURE(status) || dev != device)
> +				continue;
> +			if (bind)
> +				result =
> +					thermal_zone_bind_cooling_device
> +					(thermal, trip, cdev,
> +					 THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
> +			else
> +				result =
> +					thermal_zone_unbind_cooling_device
> +					(thermal, trip, cdev);
> +			if (result)
> +				goto failed;
>  		}
>  	}
>  
> @@ -772,11 +778,17 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  		    j++) {
>  			handle = tz->trips.active[i].devices.handles[j];
>  			status = acpi_bus_get_device(handle, &dev);
> -			if (ACPI_SUCCESS(status) && (dev == device)) {
> -				result = action(thermal, trip, cdev);
> -				if (result)
> -					goto failed;
> -			}
> +			if (ACPI_FAILURE(status) || dev != device)
> +				continue;
> +			if (bind)
> +				result = thermal_zone_bind_cooling_device
> +					(thermal, trip, cdev,
> +					 THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
> +			else
> +				result = thermal_zone_unbind_cooling_device
> +					(thermal, trip, cdev);
> +			if (result)
> +				goto failed;
>  		}
>  	}
>  
> @@ -784,7 +796,14 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  		handle = tz->devices.handles[i];
>  		status = acpi_bus_get_device(handle, &dev);
>  		if (ACPI_SUCCESS(status) && (dev == device)) {
> -			result = action(thermal, -1, cdev);
> +			if (bind)
> +				result = thermal_zone_bind_cooling_device
> +						(thermal, -1, cdev,
> +						 THERMAL_NO_LIMIT,
> +						 THERMAL_NO_LIMIT);
> +			else
> +				result = thermal_zone_unbind_cooling_device
> +						(thermal, -1, cdev);
>  			if (result)
>  				goto failed;
>  		}
> @@ -798,16 +817,14 @@ static int
>  acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev)
>  {
> -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> -				thermal_zone_bind_cooling_device);
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, true);
>  }
>  
>  static int
>  acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev)
>  {
> -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> -				thermal_zone_unbind_cooling_device);
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
>  }
>  
>  static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 39abb15..a207466 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -329,7 +329,8 @@ static int acerhdf_bind(struct thermal_zone_device *thermal,
>  	if (cdev != cl_dev)
>  		return 0;
>  
> -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
> +	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
> +			THERMAL_NO_LIMIT, THERMAL_NO_LIMIT)) {
>  		pr_err("error binding cooling dev\n");
>  		return -EINVAL;
>  	}
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 008e2eb..62b4279 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -315,8 +315,9 @@ passive_store(struct device *dev, struct device_attribute *attr,
>  			if (!strncmp("Processor", cdev->type,
>  				     sizeof("Processor")))
>  				thermal_zone_bind_cooling_device(tz,
> -								 THERMAL_TRIPS_NONE,
> -								 cdev);
> +						THERMAL_TRIPS_NONE, cdev,
> +						THERMAL_NO_LIMIT,
> +						THERMAL_NO_LIMIT);
>  		}
>  		mutex_unlock(&thermal_list_lock);
>  		if (!tz->passive_delay)
> @@ -801,7 +802,8 @@ static void thermal_zone_device_check(struct work_struct *work)
>   */
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  				     int trip,
> -				     struct thermal_cooling_device *cdev)
> +				     struct thermal_cooling_device *cdev,
> +				     unsigned long upper, unsigned long lower)
>  {
>  	struct thermal_cooling_device_instance *dev;
>  	struct thermal_cooling_device_instance *pos;
> @@ -825,6 +827,15 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	if (tz != pos1 || cdev != pos2)
>  		return -EINVAL;
>  
> +	cdev->ops->get_max_state(cdev, &max_state);
> +
> +	/* lower default 0, upper default max_state */
> +	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
> +	upper = upper == THERMAL_NO_LIMIT ? max_state : upper;
> +
> +	if (lower > upper || upper > max_state)
> +		return -EINVAL;
> +
>  	dev =
>  	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
>  	if (!dev)
> @@ -832,10 +843,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	dev->tz = tz;
>  	dev->cdev = cdev;
>  	dev->trip = trip;
> -
> -	cdev->ops->get_max_state(cdev, &max_state);
> -	dev->upper = max_state;
> -	dev->lower = 0;
> +	dev->upper = upper;
> +	dev->lower = lower;
>  
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cfc8d90..a43b12c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -75,6 +75,8 @@ struct thermal_cooling_device_ops {
>  	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
>  };
>  
> +#define THERMAL_NO_LIMIT -1UL /* no upper/lower limit requirement */
> +
>  #define THERMAL_TRIPS_NONE -1
>  #define THERMAL_MAX_TRIPS 12
>  #define THERMAL_NAME_LENGTH 20
> @@ -157,7 +159,8 @@ struct thermal_zone_device *thermal_zone_device_register(char *, int, int,
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>  
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
> -				     struct thermal_cooling_device *);
> +				     struct thermal_cooling_device *,
> +				     unsigned long, unsigned long);
>  int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>  				       struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *);
> -- 
> 1.7.9.5
> 
