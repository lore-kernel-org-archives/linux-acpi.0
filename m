From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4 07/15] Thermal: Add a policy sysfs attribute
Date: Fri, 21 Sep 2012 16:07:07 +0800
Message-ID: <1348214827.10877.138.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-8-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20947 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347Ab2IUIGX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2012 04:06:23 -0400
In-Reply-To: <1347946506-18449-8-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com

On =E4=BA=8C, 2012-09-18 at 11:04 +0530, Durgadoss R wrote:
> This patch adds a policy sysfs attribute to a thermal zone.
> This attribute denotes the throttling governor used for the
> zone. This is a RW attribute.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   42 +++++++++++++++++++++++++++++++=
+++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index a67c6c0..0948a60 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -454,10 +454,41 @@ passive_show(struct device *dev, struct device_=
attribute *attr,
>  	return sprintf(buf, "%d\n", tz->forced_passive);
>  }
> =20
> +static ssize_t
> +policy_store(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t count)
> +{
> +	int ret =3D -EINVAL;
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +	struct thermal_governor *gov;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	gov =3D __find_governor(buf);
> +	if (!gov)
> +		goto exit;
> +
> +	tz->governor =3D gov;
> +	ret =3D count;
> +
> +exit:
> +	mutex_unlock(&thermal_governor_lock);
> +	return ret;
> +}
> +
> +static ssize_t
> +policy_show(struct device *dev, struct device_attribute *devattr, ch=
ar *buf)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +
> +	return sprintf(buf, "%s\n", tz->governor->name);
> +}
> +

we should introduce an API for platform thermal drivers to switch their
policy.
say they may want to switch to "userspace" to disable the kernel therma=
l
control.
and policy_store should invoke that function directly.

BTW, IMO, deactiving all the thermal_instances and updating the cooling
devices when a thermal zone switches to "userspace" governor is
reasonable.

thanks,
rui
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive=
_store);
> +static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_st=
ore);
> =20
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)	\
> @@ -1512,10 +1543,14 @@ struct thermal_zone_device *thermal_zone_devi=
ce_register(const char *type,
>  			passive =3D 1;
>  	}
> =20
> -	if (!passive)
> -		result =3D device_create_file(&tz->device,
> -					    &dev_attr_passive);
> +	if (!passive) {
> +		result =3D device_create_file(&tz->device, &dev_attr_passive);
> +		if (result)
> +			goto unregister;
> +	}
> =20
> +	/* Create policy attribute */
> +	result =3D device_create_file(&tz->device, &dev_attr_policy);
>  	if (result)
>  		goto unregister;
> =20
> @@ -1591,6 +1626,7 @@ void thermal_zone_device_unregister(struct ther=
mal_zone_device *tz)
>  	device_remove_file(&tz->device, &dev_attr_temp);
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
> +	device_remove_file(&tz->device, &dev_attr_policy);
>  	remove_trip_attrs(tz);
>  	tz->governor =3D NULL;
> =20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
