From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 07/13] Thermal: Update binding logic based on platform
 data
Date: Mon, 13 Aug 2012 14:41:02 +0800
Message-ID: <1344840062.1682.786.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8006 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab2HMGj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 02:39:56 -0400
In-Reply-To: <1344516365-7230-8-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

On =E5=9B=9B, 2012-08-09 at 18:15 +0530, Durgadoss R wrote:
> This patch updates the binding logic in thermal_sys.c
> It uses the platform layer data to bind a thermal zone
> to a cdev for a particular trip point.
>=20
>  * If we do not have platform data and do not have
>    .bind defined, do not bind.
>  * If we do not have platform data but .bind is
>    defined, then use tz->ops->bind.
>  * If we have platform data, use it to create binding.
>=20
> The same logic sequence is followed for unbind also.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |  170 +++++++++++++++++++++++++++++++=
+++-------
>  1 file changed, 144 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 195e529..748b12f 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -158,6 +158,107 @@ static void retrieve_zone_params(struct thermal=
_zone_device *tz)
>  	}
>  }
> =20
> +static void print_bind_err_msg(struct thermal_zone_device *tz,
> +			struct thermal_cooling_device *cdev, int ret)
> +{
> +	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
> +				tz->type, cdev->type, ret);
> +}
> +
> +static void __bind(struct thermal_zone_device *tz, int mask,
> +			struct thermal_cooling_device *cdev)
> +{
> +	int i, ret;
> +
> +	for (i =3D 0; i < tz->trips; i++) {
> +		if (mask & (1 << i)) {
> +			ret =3D thermal_zone_bind_cooling_device(tz, i, cdev,
> +					THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
> +			if (ret)
> +				print_bind_err_msg(tz, cdev, ret);
> +		}
> +	}
> +}
> +
> +static void __unbind(struct thermal_zone_device *tz, int mask,
> +			struct thermal_cooling_device *cdev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < tz->trips; i++)
> +		if (mask & (1 << i))
> +			thermal_zone_unbind_cooling_device(tz, i, cdev);
> +}
> +
> +static void update_bind_info(struct thermal_cooling_device *cdev)
> +{
> +	int i, ret;
> +	struct thermal_zone_params *tzp;
> +	struct thermal_zone_device *pos =3D NULL;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (!pos->tzp && !pos->ops->bind)
> +			continue;
> +
> +		if (!pos->tzp && pos->ops->bind) {
> +			ret =3D pos->ops->bind(pos, cdev);
> +			if (ret)
> +				print_bind_err_msg(pos, cdev, ret);
> +		}
> +
> +		tzp =3D pos->tzp;
> +		for (i =3D 0; i < tzp->num_cdevs; i++) {
> +			if (!strcmp(tzp->cdevs_name[i], cdev->type)) {
> +				__bind(pos, tzp->trip_mask[i], cdev);
> +				break;
> +			}
> +		}
> +	}
> +	mutex_unlock(&thermal_list_lock);
> +}

I still do not understand why we need this kind of bind.
Say, the platform thermal driver knows the platform data, i.e. it knows
which cooling devices should be bound to which trip points.
why we can not move this kind of logic to the .bind() callback, offered
by the platform thermal driver?
say, in .bind() callback,
the platform thermal driver has the pointer of the platform data, right=
?
the .cdev parameter can be used to find the cooling device name,
and we can make the comparison there. instead of introducing new bindin=
g
functions in the generic thermal layer.

> +
> +static void do_binding(struct thermal_zone_device *tz)
> +{
> +	int i, ret;
> +	char *name;
> +	struct thermal_cooling_device *pos =3D NULL;
> +	struct thermal_zone_params *tzp =3D tz->tzp;
> +
> +	if (!tzp && !tz->ops->bind)
> +		return;
> +
> +	/* If there is no platform data, try to use ops->bind */
> +	if (!tzp && tz->ops->bind) {
> +		mutex_lock(&thermal_list_lock);
> +
> +		list_for_each_entry(pos, &thermal_cdev_list, node) {
> +			ret =3D tz->ops->bind(tz, pos);
> +			if (ret)
> +				print_bind_err_msg(tz, pos, ret);
> +		}
> +
> +		mutex_unlock(&thermal_list_lock);
> +		return;
> +	}
> +
> +	/* If platform data is available, use it to create binding */
> +	for (i =3D 0; i < tzp->num_cdevs; i++) {
> +		name =3D tzp->cdevs_name[i];
> +		pos =3D get_cdev_by_name(name);
> +
> +		if (!pos) {
> +			dev_err(&tz->device, "cannot find cdev %s\n", name);
> +			continue;
> +		}
> +
> +		mutex_lock(&thermal_list_lock);
> +		__bind(tz, tzp->trip_mask[i], pos);
> +		mutex_unlock(&thermal_list_lock);
> +	}
> +}
> +
>  /* sys I/F for thermal zone */
> =20
>  #define to_thermal_zone(_dev) \
> @@ -975,7 +1076,6 @@ thermal_cooling_device_register(char *type, void=
 *devdata,
>  				const struct thermal_cooling_device_ops *ops)
>  {
>  	struct thermal_cooling_device *cdev;
> -	struct thermal_zone_device *pos;
>  	int result;
> =20
>  	if (strlen(type) >=3D THERMAL_NAME_LENGTH)
> @@ -1025,20 +1125,15 @@ thermal_cooling_device_register(char *type, v=
oid *devdata,
>  	if (result)
>  		goto unregister;
> =20
> +	/* Add 'this' new cdev to the global cdev list */
>  	mutex_lock(&thermal_list_lock);
>  	list_add(&cdev->node, &thermal_cdev_list);
> -	list_for_each_entry(pos, &thermal_tz_list, node) {
> -		if (!pos->ops->bind)
> -			continue;
> -		result =3D pos->ops->bind(pos, cdev);
> -		if (result)
> -			break;
> -
> -	}
>  	mutex_unlock(&thermal_list_lock);
> =20
> -	if (!result)
> -		return cdev;
> +	/* Update binding information for 'this' new cdev */
> +	update_bind_info(cdev);
> +
> +	return cdev;
> =20
>  unregister:
>  	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
> @@ -1054,10 +1149,10 @@ EXPORT_SYMBOL(thermal_cooling_device_register=
);
>   * thermal_cooling_device_unregister() must be called when the devic=
e is no
>   * longer needed.
>   */
> -void thermal_cooling_device_unregister(struct
> -				       thermal_cooling_device
> -				       *cdev)
> +void thermal_cooling_device_unregister(struct thermal_cooling_device=
 *cdev)
>  {
> +	int i;
> +	struct thermal_zone_params *tzp;
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *pos =3D NULL;
> =20
> @@ -1074,12 +1169,23 @@ void thermal_cooling_device_unregister(struct
>  		return;
>  	}
>  	list_del(&cdev->node);
> +
> +	/* Unbind all thermal zones associated with 'this' cdev */
>  	list_for_each_entry(tz, &thermal_tz_list, node) {
> -		if (!tz->ops->unbind)
> +		tzp =3D tz->tzp;
> +		if (!tzp && !tz->ops->unbind)
>  			continue;
> -		tz->ops->unbind(tz, cdev);
> +
> +		if (!tzp && tz->ops->unbind)
> +			tz->ops->unbind(tz, cdev);
> +
> +		for (i =3D 0; i < tzp->num_cdevs; i++)
> +			if (!strcmp(cdev->type, tzp->cdevs_name[i]))
> +				__unbind(tz, tzp->trip_mask[i], cdev);
>  	}
> +
>  	mutex_unlock(&thermal_list_lock);
> +
>  	if (cdev->type[0])
>  		device_remove_file(&cdev->device, &dev_attr_cdev_type);
>  	device_remove_file(&cdev->device, &dev_attr_max_state);
> @@ -1424,7 +1530,6 @@ struct thermal_zone_device *thermal_zone_device=
_register(const char *type,
>  	int passive_delay, int polling_delay)
>  {
>  	struct thermal_zone_device *tz;
> -	struct thermal_cooling_device *pos;
>  	enum thermal_trip_type trip_type;
>  	int result;
>  	int count;
> @@ -1519,14 +1624,12 @@ struct thermal_zone_device *thermal_zone_devi=
ce_register(const char *type,
> =20
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
> -	if (ops->bind)
> -		list_for_each_entry(pos, &thermal_cdev_list, node) {
> -		result =3D ops->bind(tz, pos);
> -		if (result)
> -			break;
> -		}
>  	mutex_unlock(&thermal_list_lock);
> =20
> +	/* Bind cooling devices for this zone */
> +	do_binding(tz);
> +
> +
>  	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> =20
>  	thermal_zone_device_update(tz);
> @@ -1547,12 +1650,16 @@ EXPORT_SYMBOL(thermal_zone_device_register);
>   */
>  void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  {
> +	int i;
> +	struct thermal_zone_params *tzp;
>  	struct thermal_cooling_device *cdev;
>  	struct thermal_zone_device *pos =3D NULL;
> =20
>  	if (!tz)
>  		return;
> =20
> +	tzp =3D tz->tzp;
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_for_each_entry(pos, &thermal_tz_list, node)
>  	    if (pos =3D=3D tz)
> @@ -1563,9 +1670,20 @@ void thermal_zone_device_unregister(struct the=
rmal_zone_device *tz)
>  		return;
>  	}
>  	list_del(&tz->node);
> -	if (tz->ops->unbind)
> -		list_for_each_entry(cdev, &thermal_cdev_list, node)
> -		    tz->ops->unbind(tz, cdev);
> +
> +	/* Unbind all cdevs associated with 'this' thermal zone */
> +	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +		if (!tzp && !tz->ops->unbind)
> +			break;
> +
> +		if (!tzp && tz->ops->unbind)
> +			tz->ops->unbind(tz, cdev);
> +
> +		for (i =3D 0; i < tzp->num_cdevs; i++)
> +			if (!strcmp(cdev->type, tzp->cdevs_name[i]))
> +				__unbind(tz, tzp->trip_mask[i], cdev);
> +	}
> +
>  	mutex_unlock(&thermal_list_lock);
> =20
>  	thermal_zone_device_set_polling(tz, 0);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
