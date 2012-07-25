From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 06/16] Thermal: set upper and lower limits
Date: Wed, 25 Jul 2012 22:14:42 +0200
Message-ID: <201207252214.43030.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-7-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57093 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab2GYUI5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:08:57 -0400
In-Reply-To: <1343182273-32096-7-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> set upper and lower limits when binding
> a thermal cooling device to a thermal zone device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
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
> index 8275e7b..0154eac 100644
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
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, 1);

That should be

+	return acpi_thermal_cooling_device_cb(thermal, cdev, true);

I suppose.

>  }
>  
>  static int
>  acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev)
>  {
> -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> -				thermal_zone_unbind_cooling_device);
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, 0);

And that should be

+	return acpi_thermal_cooling_device_cb(thermal, cdev, false);

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
> 

Looks good apart from the above nits (arguably minor).

Thanks,
Rafael
