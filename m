From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 06/13] Thermal: Add a policy sysfs attribute
Date: Mon, 13 Aug 2012 14:28:51 +0800
Message-ID: <1344839331.1682.779.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-7-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:24399 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab2HMG1p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 02:27:45 -0400
In-Reply-To: <1344516365-7230-7-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

On =E5=9B=9B, 2012-08-09 at 18:15 +0530, Durgadoss R wrote:
> This patch adds a policy sysfs attribute to a thermal zone.
> This attribute will give us the throttling policy used
> for the zone. This is a RO attribute.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   40 +++++++++++++++++++++++++++++++=
+++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 243a3f0..195e529 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -411,6 +411,27 @@ passive_show(struct device *dev, struct device_a=
ttribute *attr,
>  	return sprintf(buf, "%d\n", tz->forced_passive);
>  }
> =20
> +static ssize_t show_throttle_policy(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +	struct thermal_zone_params *tzp =3D tz->tzp;
> +
> +	if (!tzp)
> +		return sprintf(buf, "step_wise(default)\n");
> +
> +	switch (tzp->throttle_policy) {
> +	case THERMAL_FAIR_SHARE:
> +		return sprintf(buf, "fair_share\n");
> +	case THERMAL_STEP_WISE:
> +		return sprintf(buf, "step_wise\n");
> +	case THERMAL_USER_SPACE:
> +		return sprintf(buf, "user_space\n");
> +	default:
> +		return sprintf(buf, "unknown\n");
> +	}
> +}
> +
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> @@ -1269,6 +1290,15 @@ leave:
>  }
>  EXPORT_SYMBOL(thermal_zone_device_update);
> =20
> +static int create_policy_attr(struct thermal_zone_device *tz)
> +{
> +	sysfs_attr_init(&tz->policy_attr.attr);
> +	tz->policy_attr.attr.name =3D "throttle_policy";
> +	tz->policy_attr.attr.mode =3D S_IRUGO | S_IWUSR;
> +	tz->policy_attr.show =3D show_throttle_policy;
> +	return device_create_file(&tz->device, &tz->policy_attr);
> +}
> +
>  /**
>   * create_trip_attrs - create attributes for trip points
>   * @tz:		the thermal zone device
> @@ -1479,6 +1509,14 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(const char *type,
>  	/* Retrieve platform level parameters for this zone */
>  	retrieve_zone_params(tz);
> =20
> +	result =3D create_policy_attr(tz);
> +	if (result) {
> +		dev_err(&tz->device,
> +			"create_policy_attr for zone %s failed:%d\n",
> +			tz->type, result);
> +		goto unregister;
> +	}
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	if (ops->bind)
> @@ -1539,6 +1577,8 @@ void thermal_zone_device_unregister(struct ther=
mal_zone_device *tz)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	remove_trip_attrs(tz);
> =20
> +	device_remove_file(&tz->device, &tz->policy_attr);
> +
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	idr_destroy(&tz->idr);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f9ce1e2..1d49f05 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -173,6 +173,7 @@ struct thermal_zone_device {
>  	struct list_head node;
>  	struct delayed_work poll_queue;
>  	struct thermal_zone_params *tzp;
> +	struct device_attribute policy_attr;

do we need a device_attribute for each thermal zone?
I think we can share one static DEVICE_ATTR here.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
