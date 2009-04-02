From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 81/98] thermal: support forcing support for passive cooling
Date: Thu, 2 Apr 2009 14:35:37 +0200
Message-ID: <200904021435.38561.trenn@suse.de>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <03a971a2899886006f19f3495973bbd646d8bdae.1238214620.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45498 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbZDBMfm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 08:35:42 -0400
In-Reply-To: <03a971a2899886006f19f3495973bbd646d8bdae.1238214620.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

On Saturday 28 March 2009 05:31:56 Len Brown wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Due to poor thermal design or Linux driving hardware outside its thermal
> envelope, some systems will reach critical temperature and shut down
> under high load. This patch adds support for forcing a polling-based
> passive trip point if the firmware doesn't provide one. The assumption
> is made that the processor is the most practical means to reduce the
> dynamic heat generation, so hitting the passive thermal limit will cause
> the CPU to be throttled until the temperature stabalises around the
> defined value.
> 
> UI is provided via a "passive" sysfs entry in the thermal zone
> directory. It accepts a decimal value in millidegrees celsius, or "0" to
> disable the functionality. Default behaviour is for this functionality
> to be disabled.
Isn't the last paragraph worth adding to:
Documentation/thermal/sysfs-api.txt
or have I missed this part?

    Thomas
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   77 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 6378741..d0b093b 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -214,9 +214,69 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%ld\n", temperature);
>  }
>  
> +static ssize_t
> +passive_store(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	struct thermal_cooling_device *cdev = NULL;
> +	int state;
> +
> +	if (!sscanf(buf, "%d\n", &state))
> +		return -EINVAL;
> +
> +	if (state && !tz->forced_passive) {
> +		mutex_lock(&thermal_list_lock);
> +		list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +			if (!strncmp("Processor", cdev->type,
> +				     sizeof("Processor")))
> +				thermal_zone_bind_cooling_device(tz,
> +								 THERMAL_TRIPS_NONE,
> +								 cdev);
> +		}
> +		mutex_unlock(&thermal_list_lock);
> +	} else if (!state && tz->forced_passive) {
> +		mutex_lock(&thermal_list_lock);
> +		list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +			if (!strncmp("Processor", cdev->type,
> +				     sizeof("Processor")))
> +				thermal_zone_unbind_cooling_device(tz,
> +								   THERMAL_TRIPS_NONE,
> +								   cdev);
> +		}
> +		mutex_unlock(&thermal_list_lock);
> +	}
> +
> +	tz->tc1 = 1;
> +	tz->tc2 = 1;
> +
> +	if (!tz->passive_delay)
> +		tz->passive_delay = 1000;
> +
> +	if (!tz->polling_delay)
> +		tz->polling_delay = 10000;
> +
> +	tz->forced_passive = state;
> +
> +	thermal_zone_device_update(tz);
> +
> +	return count;
> +}
> +
> +static ssize_t
> +passive_show(struct device *dev, struct device_attribute *attr,
> +		   char *buf)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +
> +	return sprintf(buf, "%d\n", tz->forced_passive);
> +}
> +
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> +static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
> +		   passive_store);
>  
>  static struct device_attribute trip_point_attrs[] = {
>  	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
> @@ -939,6 +999,11 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  			break;
>  		}
>  	}
> +
> +	if (tz->forced_passive)
> +		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> +					    THERMAL_TRIPS_NONE);
> +
>  	tz->last_temperature = temp;
>  	if (tz->passive)
>  		thermal_zone_device_set_polling(tz, tz->passive_delay);
> @@ -977,8 +1042,10 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
>  {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *pos;
> +	enum thermal_trip_type trip_type;
>  	int result;
>  	int count;
> +	int passive = 0;
>  
>  	if (strlen(type) >= THERMAL_NAME_LENGTH)
>  		return ERR_PTR(-EINVAL);
> @@ -1041,8 +1108,18 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
>  		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
>  		if (result)
>  			goto unregister;
> +		tz->ops->get_trip_type(tz, count, &trip_type);
> +		if (trip_type == THERMAL_TRIP_PASSIVE)
> +			passive = 1;
>  	}
>  
> +	if (!passive)
> +		result = device_create_file(&tz->device,
> +					    &dev_attr_passive);
> +
> +	if (result)
> +		goto unregister;
> +
>  	result = thermal_add_hwmon_sysfs(tz);
>  	if (result)
>  		goto unregister;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a81c615..1de8b9e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -113,6 +113,7 @@ struct thermal_zone_device {
>  	int polling_delay;
>  	int last_temperature;
>  	bool passive;
> +	unsigned int forced_passive;
>  	struct thermal_zone_device_ops *ops;
>  	struct list_head cooling_devices;
>  	struct idr idr;
> -- 
> 1.6.0.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


