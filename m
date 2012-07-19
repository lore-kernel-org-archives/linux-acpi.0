From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 01/16] Thermal: Make Thermal trip points writeable
Date: Thu, 19 Jul 2012 10:35:59 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB591666FA@BGSMSX101.gar.corp.intel.com>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com>
 <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28987 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab2GSKgF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2012 06:36:05 -0400
In-Reply-To: <1342679480-5336-2-git-send-email-rui.zhang@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <eduardo.valentin@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>

Hi Rui,


> -----Original Message-----
> From: Zhang, Rui
> Sent: Thursday, July 19, 2012 12:01 PM
> To: linux-acpi@vger.kernel.org; linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki; Matthew Garrett; Len Brown; R, Durgadoss; Eduardo
> Valentin; Amit Kachhap; Wei Ni; Zhang, Rui
> Subject: [PATCH 01/16] Thermal: Make Thermal trip points writeable
> 
> From: Durgadoss R <dugardoss.r@intel.com>

[cut.]

> 
>  static ssize_t
> +trip_point_temp_store(struct device *dev, struct device_attribute *attr,
> +		     const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	int trip, ret;
> +	unsigned long temperature;
> +
> +	if (!tz->ops->set_trip_temp)
> +		return -EPERM;
> +
> +	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
> +		return -EINVAL;
> +
> +	if (kstrtoul(buf, 10, &temperature))
> +		return -EINVAL;
> +
> +	ret = tz->ops->set_trip_temp(tz, trip, temperature);
> +
> +	return ret ? ret : count;
> +}
> +
> +static ssize_t
>  trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>  		     char *buf)
>  {
> @@ -283,33 +305,6 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show,
> passive_store);
> 
> -static struct device_attribute trip_point_attrs[] = {
> -	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_0_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_1_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_1_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_2_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_2_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_3_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_3_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_4_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_4_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_5_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_5_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_6_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_6_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_7_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_7_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_8_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_8_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_9_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_9_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_10_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_10_temp, 0444, trip_point_temp_show, NULL),
> -	__ATTR(trip_point_11_type, 0444, trip_point_type_show, NULL),
> -	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
> -};
> -
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)	\
>  	container_of(_dev, struct thermal_cooling_device, device)
> @@ -1089,9 +1084,83 @@ void thermal_zone_device_update(struct
> thermal_zone_device *tz)
>  EXPORT_SYMBOL(thermal_zone_device_update);
> 
>  /**
> + * create_trip_attrs - create attributes for trip points
> + * @tz:		the thermal zone device
> + * @flag:	Writeable trip point bitmap.
> + */
> +static int create_trip_attrs(struct thermal_zone_device *tz, int flag)
> +{
> +	int indx;
> +	int writeable;
> +
> +	tz->trip_type_attrs =
> +		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
> +	if (!tz->trip_type_attrs)
> +		return -ENOMEM;
> +
> +	tz->trip_temp_attrs =
> +		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
> +	if (!tz->trip_temp_attrs) {
> +		kfree(tz->trip_type_attrs);
> +		return -ENOMEM;
> +	}
> +
> +	for (indx = 0; indx < tz->trips; indx++) {
> +
> +		/* create trip type attribute */
> +		snprintf(tz->trip_type_attrs[indx].name,
> THERMAL_NAME_LENGTH,
> +			 "trip_point_%d_type", indx);
> +
> +		sysfs_attr_init(&tz->trip_type_attrs[count].attr.attr);

Shouldn't the 'count' be 'indx' ?

> +		tz->trip_type_attrs[indx].attr.attr.name =

Thanks,
Durga
