From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 07/14] Thermal: Update binding logic based on platform
 data
Date: Mon, 27 Aug 2012 09:50:04 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926321029F@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-8-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55215 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2H0JuZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 05:50:25 -0400
In-Reply-To: <1346041706-29642-8-git-send-email-durgadoss.r@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>



> -----Original Message-----
> From: R, Durgadoss
> Sent: Monday, August 27, 2012 7:28 AM
> To: lenb@kernel.org; Zhang, Rui
> Cc: linux-acpi@vger.kernel.org; eduardo.valentin@ti.com; R, Durgadoss
> Subject: [PATCHv2 07/14] Thermal: Update binding logic based on
> platform data
> Importance: High
> 
> This patch updates the binding logic in thermal_sys.c It uses the
> platform layer data to bind a thermal zone to a cdev for a particular
> trip point.
> 
>  * If we do not have platform data and do not have
>    .bind defined, do not bind.
>  * If we do not have platform data but .bind is
>    defined, then use tz->ops->bind.
>  * If we have platform data, use it to create binding.
> 
> The same logic sequence is followed for unbind also.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |  184
> +++++++++++++++++++++++++++++++++++------
>  1 file changed, 158 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c index 8aa4200a6..5d38501 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -125,6 +125,111 @@ struct thermal_instance
> *get_thermal_instance(struct thermal_zone_device *tz,  }
> EXPORT_SYMBOL(get_thermal_instance);
> 
> +static void print_bind_err_msg(struct thermal_zone_device *tz,
> +			struct thermal_cooling_device *cdev, int ret) {
> +	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
> +				tz->type, cdev->type, ret);
> +}
> +
> +static void __bind(struct thermal_zone_device *tz, int mask,
> +			struct thermal_cooling_device *cdev) {
> +	int i, ret;
> +
> +	for (i = 0; i < tz->trips; i++) {
> +		if (mask & (1 << i)) {
> +			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
> +					THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
> +			if (ret)
> +				print_bind_err_msg(tz, cdev, ret);
> +		}
> +	}
> +}
> +
> +static void __unbind(struct thermal_zone_device *tz, int mask,
> +			struct thermal_cooling_device *cdev) {
> +	int i;
> +
> +	for (i = 0; i < tz->trips; i++)
> +		if (mask & (1 << i))
> +			thermal_zone_unbind_cooling_device(tz, i, cdev); }
> +
> +static void update_bind_info(struct thermal_cooling_device *cdev) {

I do not think this function name is accurate.

Update_bind_info is called when a new cooling device comes
and do_binding is called when a new zone is registered, right?
I think we should reflect this in the function name.
Maybe something like this:
Int do_bind(tz, cdev) {
	If (tz->ops->bind)
		Tz->ops->bind(tz, cdev);
	Else {
		Blabla
		...
	}
}

Bind_cdev(cdev) {
	List_for_each_entry(tz, thermal_tz_list) {
		 Do_bind(tz, cdev);
	}
}

Bind_tz(tz) {
	List_for_each_entry(cdev, thermal_cdev_list) {
		 Do_bind(tz, cdev);
	}
}

Thanks,
rui
> +	int i, ret;
> +	struct thermal_zone_params *tzp;
> +	struct thermal_zone_device *pos = NULL;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	list_for_each_entry(pos, &thermal_tz_list, node) {
> +		if (!pos->tzp && !pos->ops->bind)
> +			continue;
> +
> +		if (!pos->tzp && pos->ops->bind) {
> +			ret = pos->ops->bind(pos, cdev);
> +			if (ret)
> +				print_bind_err_msg(pos, cdev, ret);
> +		}
> +
> +		tzp = pos->tzp;
> +		if (!tzp->tbp)
> +			return;
> +
> +		for (i = 0; i < tzp->num_tbps; i++) {
> +			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> +				continue;
> +			if (tzp->tbp[i].match(pos, cdev))	
> +				continue;
> +			tzp->tbp[i].cdev = cdev;
> +			__bind(pos, tzp->tbp[i].trip_mask, cdev);
> +		}
> +	}
> +
> +	mutex_unlock(&thermal_list_lock);
> +}
> +
> +static void do_binding(struct thermal_zone_device *tz) {
> +	int i, ret;
> +	struct thermal_cooling_device *pos = NULL;
> +	struct thermal_zone_params *tzp = tz->tzp;
> +
> +	if (!tzp && !tz->ops->bind)
> +		return;
> +
> +	mutex_lock(&thermal_list_lock);
> +
> +	/* If there is no platform data, try to use ops->bind */
> +	if (!tzp && tz->ops->bind) {
> +		list_for_each_entry(pos, &thermal_cdev_list, node) {
> +			ret = tz->ops->bind(tz, pos);
> +			if (ret)
> +				print_bind_err_msg(tz, pos, ret);
> +		}
> +		goto exit;
> +	}
> +
> +	if (!tzp->tbp)
> +		goto exit;
> +
> +	list_for_each_entry(pos, &thermal_cdev_list, node) {
> +		for (i = 0; i < tzp->num_tbps; i++) {
> +			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
> +				continue;
> +			if (tzp->tbp[i].match(tz, pos))
> +				continue;
> +			tzp->tbp[i].cdev = pos;
> +			__bind(tz, tzp->tbp[i].trip_mask, pos);
> +		}
> +	}
> +exit:
> +	mutex_unlock(&thermal_list_lock);
> +}
> +
>  /* sys I/F for thermal zone */
> 
>  #define to_thermal_zone(_dev) \
> @@ -943,7 +1048,6 @@ thermal_cooling_device_register(char *type, void
> *devdata,
>  				const struct thermal_cooling_device_ops *ops)
> {
>  	struct thermal_cooling_device *cdev;
> -	struct thermal_zone_device *pos;
>  	int result;
> 
>  	if (strlen(type) >= THERMAL_NAME_LENGTH) @@ -993,20 +1097,15 @@
> thermal_cooling_device_register(char *type, void *devdata,
>  	if (result)
>  		goto unregister;
> 
> +	/* Add 'this' new cdev to the global cdev list */
>  	mutex_lock(&thermal_list_lock);
>  	list_add(&cdev->node, &thermal_cdev_list);
> -	list_for_each_entry(pos, &thermal_tz_list, node) {
> -		if (!pos->ops->bind)
> -			continue;
> -		result = pos->ops->bind(pos, cdev);
> -		if (result)
> -			break;
> -
> -	}
>  	mutex_unlock(&thermal_list_lock);
> 
> -	if (!result)
> -		return cdev;
> +	/* Update binding information for 'this' new cdev */
> +	update_bind_info(cdev);
> +
> +	return cdev;
> 
>  unregister:
>  	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id); @@ -
> 1022,10 +1121,10 @@ EXPORT_SYMBOL(thermal_cooling_device_register);
>   * thermal_cooling_device_unregister() must be called when the device
> is no
>   * longer needed.
>   */
> -void thermal_cooling_device_unregister(struct
> -				       thermal_cooling_device
> -				       *cdev)
> +void thermal_cooling_device_unregister(struct thermal_cooling_device
> +*cdev)
>  {
> +	int i;
> +	struct thermal_zone_params *tzp;
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *pos = NULL;
> 
> @@ -1042,12 +1141,28 @@ void thermal_cooling_device_unregister(struct
>  		return;
>  	}
>  	list_del(&cdev->node);
> +
> +	/* Unbind all thermal zones associated with 'this' cdev */
>  	list_for_each_entry(tz, &thermal_tz_list, node) {
> -		if (!tz->ops->unbind)
> +		if (tz->ops->unbind) {
> +			tz->ops->unbind(tz, cdev);
>  			continue;
> -		tz->ops->unbind(tz, cdev);
> +		}
> +
> +		if (!tz->tzp || !tz->tzp->tbp)
> +			continue;
> +
> +		tzp = tz->tzp;
> +		for (i = 0; i < tzp->num_tbps; i++) {
> +			if (tzp->tbp[i].cdev == cdev) {
> +				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
> +				tzp->tbp[i].cdev = NULL;
> +			}
> +		}
>  	}
> +
>  	mutex_unlock(&thermal_list_lock);
> +
>  	if (cdev->type[0])
>  		device_remove_file(&cdev->device, &dev_attr_cdev_type);
>  	device_remove_file(&cdev->device, &dev_attr_max_state); @@ -
> 1405,7 +1520,6 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
>  	int passive_delay, int polling_delay)
>  {
>  	struct thermal_zone_device *tz;
> -	struct thermal_cooling_device *pos;
>  	enum thermal_trip_type trip_type;
>  	int result;
>  	int count;
> @@ -1494,14 +1608,12 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
> 
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
> -	if (ops->bind)
> -		list_for_each_entry(pos, &thermal_cdev_list, node) {
> -		result = ops->bind(tz, pos);
> -		if (result)
> -			break;
> -		}
>  	mutex_unlock(&thermal_list_lock);
> 
> +	/* Bind cooling devices for this zone */
> +	do_binding(tz);
> +
> +
>  	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
> 
>  	thermal_zone_device_update(tz);
> @@ -1522,12 +1634,16 @@ EXPORT_SYMBOL(thermal_zone_device_register);
>   */
>  void thermal_zone_device_unregister(struct thermal_zone_device *tz)  {
> +	int i;
> +	struct thermal_zone_params *tzp;
>  	struct thermal_cooling_device *cdev;
>  	struct thermal_zone_device *pos = NULL;
> 
>  	if (!tz)
>  		return;
> 
> +	tzp = tz->tzp;
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_for_each_entry(pos, &thermal_tz_list, node)
>  	    if (pos == tz)
> @@ -1538,9 +1654,25 @@ void thermal_zone_device_unregister(struct
> thermal_zone_device *tz)
>  		return;
>  	}
>  	list_del(&tz->node);
> -	if (tz->ops->unbind)
> -		list_for_each_entry(cdev, &thermal_cdev_list, node)
> -		    tz->ops->unbind(tz, cdev);
> +
> +	/* Unbind all cdevs associated with 'this' thermal zone */
> +	list_for_each_entry(cdev, &thermal_cdev_list, node) {
> +		if (tz->ops->unbind) {
> +			tz->ops->unbind(tz, cdev);
> +			continue;
> +		}
> +
> +		if (!tzp || !tzp->tbp)
> +			break;
> +
> +		for (i = 0; i < tzp->num_tbps; i++) {
> +			if (tzp->tbp[i].cdev == cdev) {
> +				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
> +				tzp->tbp[i].cdev = NULL;
> +			}
> +		}
> +	}
> +
>  	mutex_unlock(&thermal_list_lock);
> 
>  	thermal_zone_device_set_polling(tz, 0);
> --
> 1.7.9.5

