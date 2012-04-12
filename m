From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4] ACPI-Thermal: Make Thermal trip points writeable
Date: Thu, 12 Apr 2012 14:40:15 +0800
Message-ID: <1334212815.2387.280.camel@rui.sh.intel.com>
References: <1333963101-29499-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16295 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab2DLGjs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Apr 2012 02:39:48 -0400
In-Reply-To: <1333963101-29499-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On =E4=B8=80, 2012-04-09 at 14:48 +0530, Durgadoss R wrote:
> Some of the thermal drivers using the Generic Thermal Framework
> require (all/some) trip points to be writeable. This patch makes
> the trip point temperatures writeable on a per-trip point basis,
> and modifies the required function call in thermal.c. This patch
> also updates the Documentation to reflect the new change.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
> v1
> * patch1/2: Code for making trip points writeable
> * patch2/2: Change the callee in thermal.c
> v2
> * Make both the changes in a single patch
> * Update Documentation/thermal/sysfs-api.txt
> v3
> * Re-submitting, on top of the latest mainline kernel
> v4
> * Added a check on the 'flag' parameter in tzd register function
> ---
>  Documentation/thermal/sysfs-api.txt |    4 +-
>  drivers/acpi/thermal.c              |    4 +-
>  drivers/thermal/thermal_sys.c       |  115 +++++++++++++++++++++++--=
---------
>  include/linux/thermal.h             |   10 ++-
>  4 files changed, 90 insertions(+), 43 deletions(-)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/ther=
mal/sysfs-api.txt
> index 1733ab9..0c7c423 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -32,7 +32,8 @@ temperature) and throttle appropriate devices.
> =20
>  1.1 thermal zone device interface
>  1.1.1 struct thermal_zone_device *thermal_zone_device_register(char =
*name,
> -		int trips, void *devdata, struct thermal_zone_device_ops *ops)
> +		int trips, int flag, void *devdata,
> +		struct thermal_zone_device_ops *ops)
> =20
>      This interface function adds a new thermal zone device (sensor) =
to
>      /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind=
 all the
> @@ -40,6 +41,7 @@ temperature) and throttle appropriate devices.
> =20
>      name: the thermal zone name.
>      trips: the total number of trip points this thermal zone support=
s.
> +    flag: Bit string: If 'n'th bit is set, then trip point 'n' is wr=
iteable.
>      devdata: device private data
>      ops: thermal zone device call-backs.
>  	.bind: bind the thermal zone device with a thermal cooling device.
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 7dbebea..2107d1b 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -845,7 +845,7 @@ static int acpi_thermal_register_thermal_zone(str=
uct acpi_thermal *tz)
> =20
>  	if (tz->trips.passive.flags.valid)
>  		tz->thermal_zone =3D
> -			thermal_zone_device_register("acpitz", trips, tz,
> +			thermal_zone_device_register("acpitz", trips, 0, tz,
>  						     &acpi_thermal_zone_ops,
>  						     tz->trips.passive.tc1,
>  						     tz->trips.passive.tc2,
> @@ -853,7 +853,7 @@ static int acpi_thermal_register_thermal_zone(str=
uct acpi_thermal *tz)
>  						     tz->polling_frequency*100);
>  	else
>  		tz->thermal_zone =3D
> -			thermal_zone_device_register("acpitz", trips, tz,
> +			thermal_zone_device_register("acpitz", trips, 0, tz,
>  						     &acpi_thermal_zone_ops,
>  						     0, 0, 0,
>  						     tz->polling_frequency*100);
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 022bacb..35b2e4d 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -196,6 +196,28 @@ trip_point_type_show(struct device *dev, struct =
device_attribute *attr,
>  }
> =20
>  static ssize_t
> +trip_point_temp_store(struct device *dev, struct device_attribute *a=
ttr,
> +		     const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
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
> +	ret =3D tz->ops->set_trip_temp(tz, trip, temperature);
> +
> +	return ret ? ret : count;
> +}
> +
> +static ssize_t
>  trip_point_temp_show(struct device *dev, struct device_attribute *at=
tr,
>  		     char *buf)
>  {
> @@ -283,33 +305,6 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive=
_store);
> =20
> -static struct device_attribute trip_point_attrs[] =3D {
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
> @@ -1089,9 +1084,54 @@ leave:
>  EXPORT_SYMBOL(thermal_zone_device_update);
> =20
>  /**
> + * create_trip_type_attr - creates a trip point type attribute
> + * @tz:		the thermal zone device
> + * @indx:	index into the trip_type_attrs array
> + */
> +static int create_trip_type_attr(struct thermal_zone_device *tz, int=
 indx)
> +{
> +	char attr_name[THERMAL_NAME_LENGTH];
> +
> +	snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_type", indx=
);
> +
> +	sysfs_attr_init(&tz->trip_type_attrs[indx].attr);
> +	tz->trip_type_attrs[indx].attr.name =3D attr_name;
> +	tz->trip_type_attrs[indx].attr.mode =3D S_IRUGO;
> +	tz->trip_type_attrs[indx].show =3D trip_point_type_show;
> +
> +	return device_create_file(&tz->device, &tz->trip_type_attrs[indx]);
> +}
> +
> +/**
> + * create_trip_temp_attr - creates a trip point temp attribute
> + * @tz:		the thermal zone device
> + * @indx:	index into the trip_type_attrs array
> + * @writeable:	A flag: If 1, 'this' trip point is writeable; otherwi=
se not
> + */
> +static int create_trip_temp_attr(struct thermal_zone_device *tz,
> +				int indx, int writeable)
> +{
> +	char attr_name[THERMAL_NAME_LENGTH];
> +
> +	snprintf(attr_name, THERMAL_NAME_LENGTH, "trip_point_%d_temp", indx=
);
> +
> +	sysfs_attr_init(&tz->trip_temp_attrs[indx].attr);
> +	tz->trip_temp_attrs[indx].attr.name =3D attr_name;
> +	tz->trip_temp_attrs[indx].attr.mode =3D S_IRUGO;
> +	tz->trip_temp_attrs[indx].show =3D trip_point_temp_show;
> +	if (writeable) {
> +		tz->trip_temp_attrs[indx].attr.mode |=3D S_IWUSR;
> +		tz->trip_temp_attrs[indx].store =3D trip_point_temp_store;
> +	}
> +
> +	return device_create_file(&tz->device, &tz->trip_temp_attrs[indx]);
> +}
> +
> +/**
>   * thermal_zone_device_register - register a new thermal zone device
>   * @type:	the thermal zone device type
>   * @trips:	the number of trip points the thermal zone support
> + * @flag:	a bit string indicating the writeablility of trip points
>   * @devdata:	private device data
>   * @ops:	standard thermal zone device callbacks
>   * @tc1:	thermal coefficient 1 for passive calculations
> @@ -1107,7 +1147,7 @@ EXPORT_SYMBOL(thermal_zone_device_update);
>   * section 11.1.5.1 of the ACPI specification 3.0.
>   */
>  struct thermal_zone_device *thermal_zone_device_register(char *type,
> -	int trips, void *devdata,
> +	int trips, int flag, void *devdata,
>  	const struct thermal_zone_device_ops *ops,
>  	int tc1, int tc2, int passive_delay, int polling_delay)
>  {
> @@ -1124,6 +1164,9 @@ struct thermal_zone_device *thermal_zone_device=
_register(char *type,
>  	if (trips > THERMAL_MAX_TRIPS || trips < 0)
>  		return ERR_PTR(-EINVAL);
> =20
> +	if (flag >> trips)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!ops || !ops->get_temp)
>  		return ERR_PTR(-EINVAL);
> =20
> @@ -1176,14 +1219,14 @@ struct thermal_zone_device *thermal_zone_devi=
ce_register(char *type,
>  	}
> =20
>  	for (count =3D 0; count < trips; count++) {
> -		result =3D device_create_file(&tz->device,
> -					    &trip_point_attrs[count * 2]);
> +		result =3D create_trip_type_attr(tz, count);
>  		if (result)
> -			break;
> -		result =3D device_create_file(&tz->device,
> -					    &trip_point_attrs[count * 2 + 1]);
> +			goto unregister;
> +		result =3D create_trip_temp_attr(tz, count,
> +						!!(flag & (1 << count)));
>  		if (result)
>  			goto unregister;
> +
>  		tz->ops->get_trip_type(tz, count, &trip_type);
>  		if (trip_type =3D=3D THERMAL_TRIP_PASSIVE)
>  			passive =3D 1;
> @@ -1261,10 +1304,8 @@ void thermal_zone_device_unregister(struct the=
rmal_zone_device *tz)
>  		device_remove_file(&tz->device, &dev_attr_mode);
> =20
>  	for (count =3D 0; count < tz->trips; count++) {
> -		device_remove_file(&tz->device,
> -				   &trip_point_attrs[count * 2]);
> -		device_remove_file(&tz->device,
> -				   &trip_point_attrs[count * 2 + 1]);
> +		device_remove_file(&tz->device, &tz->trip_type_attrs[count]);
> +		device_remove_file(&tz->device, &tz->trip_temp_attrs[count]);
>  	}
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 796f1ff..825d4b0 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -58,6 +58,8 @@ struct thermal_zone_device_ops {
>  		enum thermal_trip_type *);
>  	int (*get_trip_temp) (struct thermal_zone_device *, int,
>  			      unsigned long *);
> +	int (*set_trip_temp) (struct thermal_zone_device *, int,
> +			      unsigned long);
>  	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *=
);
>  	int (*notify) (struct thermal_zone_device *, int,
>  		       enum thermal_trip_type);
> @@ -89,6 +91,8 @@ struct thermal_zone_device {
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
>  	struct device device;
> +	struct device_attribute trip_temp_attrs[THERMAL_MAX_TRIPS];
> +	struct device_attribute trip_type_attrs[THERMAL_MAX_TRIPS];
>  	void *devdata;
>  	int trips;
>  	int tc1;
> @@ -137,9 +141,9 @@ enum {
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> =20
> -struct thermal_zone_device *thermal_zone_device_register(char *, int=
, void *,
> -		const struct thermal_zone_device_ops *, int tc1, int tc2,
> -		int passive_freq, int polling_freq);
> +struct thermal_zone_device *thermal_zone_device_register(char *, int=
, int,
> +		void *, const struct thermal_zone_device_ops *, int tc1,
> +		int tc2, int passive_freq, int polling_freq);
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
> =20
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, i=
nt,


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
