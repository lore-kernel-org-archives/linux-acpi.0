From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: support forcing support for passive cooling
Date: Wed, 17 Dec 2008 11:19:03 +0800
Message-ID: <1229483943.562.48.camel@rzhang-dt>
References: <20081127174813.GA24258@srcf.ucam.org>
	 <20081127174956.GB24258@srcf.ucam.org>
	 <20081203175532.GA20770@srcf.ucam.org>
	 <20081203180038.GB20770@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11717 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYLQDUX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 22:20:23 -0500
In-Reply-To: <20081203180038.GB20770@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

Len,

yes it's true that it's polling-based which may be malfunction in some
cases.
but this mechanism works only in a system overheating/critical stage.
=EF=BB=BFif the polling-base passive trip point doesn't work, the syste=
m goes to
critical shutdown just like it does without this patch.
But once it works, it can help a lot.
As it won't bring any side effect, I think this is =EF=BB=BFa good enha=
ncement
of the current thermal management.
Any comments on this?

thanks,
rui

On Thu, 2008-12-04 at 02:00 +0800, Matthew Garrett wrote:
> Due to poor thermal design or Linux driving hardware outside its ther=
mal=20
> envelope, some systems will reach critical temperature and shut down=20
> under high load. This patch adds support for forcing a polling-based=20
> passive trip point if the firmware doesn't provide one. The assumptio=
n=20
> is made that the processor is the most practical means to reduce the=20
> dynamic heat generation, so hitting the passive thermal limit will ca=
use=20
> the CPU to be throttled until the temperature stabalises around the=20
> defined value.
>    =20
> UI is provided via a "passive" sysfs entry in the thermal zone=20
> directory. It accepts a decimal value in millidegrees celsius, or "0"=
 to=20
> disable the functionality. Default behaviour is for this functionalit=
y=20
> to be disabled.
>    =20
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>=20
> Depends on the code to move the trip handling into the generic layer.=
=20
> Tested this on a couple of machines and it seems to work well - a=20
> logical followup might be to allow the passive trip point to be=20
> overridden on machines that provide it.
>=20
>  drivers/thermal/thermal_sys.c |   77 +++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 78 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index ac0f91f..c5351e5 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -214,9 +214,69 @@ trip_point_temp_show(struct device *dev, struct =
device_attribute *attr,
>  	return sprintf(buf, "%ld\n", temperature);
>  }
> =20
> +static ssize_t
> +passive_store(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +	struct thermal_cooling_device *cdev =3D NULL;
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
> +	tz->tc1 =3D 1;
> +	tz->tc2 =3D 1;
> +
> +	if (!tz->passive_delay)
> +		tz->passive_delay =3D 1000;
> +
> +	if (!tz->polling_delay)
> +		tz->polling_delay =3D 10000;
> +
> +	tz->forced_passive =3D state;
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
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +
> +	return sprintf(buf, "%d\n", tz->forced_passive);
> +}
> +
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> +static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, \
> +		   passive_store);
> =20
>  static struct device_attribute trip_point_attrs[] =3D {
>  	__ATTR(trip_point_0_type, 0444, trip_point_type_show, NULL),
> @@ -939,6 +999,11 @@ void thermal_zone_device_update(struct thermal_z=
one_device *tz)
>  			break;
>  		}
>  	}
> +
> +	if (tz->forced_passive)
> +		thermal_zone_device_passive(tz, temp, tz->forced_passive,
> +					    THERMAL_TRIPS_NONE);
> +
>  	tz->last_temperature =3D temp;
>  	if (tz->passive)
>  		thermal_zone_device_set_polling(tz, tz->passive_delay);
> @@ -977,8 +1042,10 @@ struct thermal_zone_device *thermal_zone_device=
_register(char *type,
>  {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *pos;
> +	enum thermal_trip_type trip_type;
>  	int result;
>  	int count;
> +	int passive=3D0;
> =20
>  	if (strlen(type) >=3D THERMAL_NAME_LENGTH)
>  		return ERR_PTR(-EINVAL);
> @@ -1041,8 +1108,18 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(char *type,
>  		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
>  		if (result)
>  			goto unregister;
> +		tz->ops->get_trip_type(tz, count, &trip_type);
> +		if (trip_type =3D=3D THERMAL_TRIP_PASSIVE)
> +			passive=3D1;
>  	}
> =20
> +	if (!passive)
> +		result =3D device_create_file(&tz->device,
> +					    &dev_attr_passive);
> +
> +	if (result)
> +		goto unregister;
> +
>  	result =3D thermal_add_hwmon_sysfs(tz);
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
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
