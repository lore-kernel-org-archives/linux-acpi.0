From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 11/16] Thermal: Rename thermal_zone_device.cooling_devices
Date: Wed, 25 Jul 2012 22:33:30 +0200
Message-ID: <201207252233.30942.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-12-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57162 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab2GYU1q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:27:46 -0400
In-Reply-To: <1343182273-32096-12-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> Rename thermal_zone_device.cooling_devices
> to thermal_zone_device.thermal_instances
> 
> thermal_zone_device.cooling_devices is not accurate
> as this is a list for thermal instances, rather than cooling devices.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |   18 +++++++++---------
>  include/linux/thermal.h       |    4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 6f245c8..5f362e1 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -749,7 +749,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  
>  		/* Heating up? */
>  		if (trend == THERMAL_TREND_RAISING) {
> -			list_for_each_entry(instance, &tz->cooling_devices,
> +			list_for_each_entry(instance, &tz->thermal_instances,
>  					    node) {
>  				if (instance->trip != trip)
>  					continue;
> @@ -760,7 +760,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  					cdev->ops->set_cur_state(cdev, state);
>  			}
>  		} else if (trend == THERMAL_TREND_DROPPING) { /* Cooling off? */
> -			list_for_each_entry(instance, &tz->cooling_devices,
> +			list_for_each_entry(instance, &tz->thermal_instances,
>  					    node) {
>  				if (instance->trip != trip)
>  					continue;
> @@ -781,7 +781,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  	 * and avoid thrashing around the passive trip point.  Note that we
>  	 * assume symmetry.
>  	 */
> -	list_for_each_entry(instance, &tz->cooling_devices, node) {
> +	list_for_each_entry(instance, &tz->thermal_instances, node) {
>  		if (instance->trip != trip)
>  			continue;
>  		cdev = instance->cdev;
> @@ -877,13 +877,13 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		goto remove_symbol_link;
>  
>  	mutex_lock(&tz->lock);
> -	list_for_each_entry(pos, &tz->cooling_devices, node)
> +	list_for_each_entry(pos, &tz->thermal_instances, node)
>  	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  		result = -EEXIST;
>  		break;
>  	}
>  	if (!result)
> -		list_add_tail(&dev->node, &tz->cooling_devices);
> +		list_add_tail(&dev->node, &tz->thermal_instances);
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -916,7 +916,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
> -	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
> +	list_for_each_entry_safe(pos, next, &tz->thermal_instances, node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  			list_del(&pos->node);
>  			mutex_unlock(&tz->lock);
> @@ -1110,7 +1110,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  	if (temp >= trip_temp) {
>  		thermal_get_trend(tz, trip, &trend);
>  
> -		list_for_each_entry(instance, &tz->cooling_devices, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> @@ -1129,7 +1129,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  			cdev->ops->set_cur_state(cdev, cur_state);
>  		}
>  	} else {	/* below trip */
> -		list_for_each_entry(instance, &tz->cooling_devices, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> @@ -1358,7 +1358,7 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
>  	if (!tz)
>  		return ERR_PTR(-ENOMEM);
>  
> -	INIT_LIST_HEAD(&tz->cooling_devices);
> +	INIT_LIST_HEAD(&tz->thermal_instances);
>  	idr_init(&tz->idr);
>  	mutex_init(&tz->lock);
>  	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index d18dcf6..b11db1e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -122,9 +122,9 @@ struct thermal_zone_device {
>  	bool passive;
>  	unsigned int forced_passive;
>  	const struct thermal_zone_device_ops *ops;
> -	struct list_head cooling_devices;
> +	struct list_head thermal_instances;
>  	struct idr idr;
> -	struct mutex lock;	/* protect cooling devices list */
> +	struct mutex lock; /* protect thermal_instances list */
>  	struct list_head node;
>  	struct delayed_work poll_queue;
>  };
> 

