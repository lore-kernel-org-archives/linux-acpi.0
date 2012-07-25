From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 12/16] Thermal: Rename thermal_instance.node to thermal_instance.tz_node.
Date: Wed, 25 Jul 2012 22:34:38 +0200
Message-ID: <201207252234.39014.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-13-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57175 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab2GYU2w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:28:52 -0400
In-Reply-To: <1343182273-32096-13-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> thermal_instance should be referenced by both thermal zone devices
> and thermal cooling devices.
> 
> Rename thermal_instance.node to thermal_instance.tz_node in this patch
> and thermal_instanace.cdev_node will be introduced in next patch.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 5f362e1..b76e55f 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -56,7 +56,7 @@ struct thermal_instance {
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
> -	struct list_head node;
> +	struct list_head tz_node; /* node in tz->thermal_instances */
>  };
>  
>  static DEFINE_IDR(thermal_tz_idr);
> @@ -750,7 +750,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  		/* Heating up? */
>  		if (trend == THERMAL_TREND_RAISING) {
>  			list_for_each_entry(instance, &tz->thermal_instances,
> -					    node) {
> +					    tz_node) {
>  				if (instance->trip != trip)
>  					continue;
>  				cdev = instance->cdev;
> @@ -761,7 +761,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  			}
>  		} else if (trend == THERMAL_TREND_DROPPING) { /* Cooling off? */
>  			list_for_each_entry(instance, &tz->thermal_instances,
> -					    node) {
> +					    tz_node) {
>  				if (instance->trip != trip)
>  					continue;
>  				cdev = instance->cdev;
> @@ -781,7 +781,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  	 * and avoid thrashing around the passive trip point.  Note that we
>  	 * assume symmetry.
>  	 */
> -	list_for_each_entry(instance, &tz->thermal_instances, node) {
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  		if (instance->trip != trip)
>  			continue;
>  		cdev = instance->cdev;
> @@ -877,13 +877,13 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		goto remove_symbol_link;
>  
>  	mutex_lock(&tz->lock);
> -	list_for_each_entry(pos, &tz->thermal_instances, node)
> +	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>  	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  		result = -EEXIST;
>  		break;
>  	}
>  	if (!result)
> -		list_add_tail(&dev->node, &tz->thermal_instances);
> +		list_add_tail(&dev->tz_node, &tz->thermal_instances);
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -916,9 +916,9 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
> -	list_for_each_entry_safe(pos, next, &tz->thermal_instances, node) {
> +	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> -			list_del(&pos->node);
> +			list_del(&pos->tz_node);
>  			mutex_unlock(&tz->lock);
>  			goto unbind;
>  		}
> @@ -1110,7 +1110,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  	if (temp >= trip_temp) {
>  		thermal_get_trend(tz, trip, &trend);
>  
> -		list_for_each_entry(instance, &tz->thermal_instances, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> @@ -1129,7 +1129,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  			cdev->ops->set_cur_state(cdev, cur_state);
>  		}
>  	} else {	/* below trip */
> -		list_for_each_entry(instance, &tz->thermal_instances, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> 

