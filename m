From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 09/13] Thermal: Rename thermal_instance.node to
 thermal_instance.tz_node.
Date: Mon, 20 Aug 2012 18:47:01 +0300
Message-ID: <20120820154701.GF9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-10-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46552 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440Ab2HTPrJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:47:09 -0400
Received: by weyr1 with SMTP id r1so3817651wey.15
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:47:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-10-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:19PM +0800, Zhang Rui wrote:
> thermal_instance should be referenced by both thermal zone devices
> and thermal cooling devices.
> 
> Rename thermal_instance.node to thermal_instance.tz_node in this patch
> and thermal_instanace.cdev_node will be introduced in next patch.
> 
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/thermal_sys.c |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 112227e..b2a2d48 100644
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
> @@ -746,7 +746,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  		/* Heating up? */
>  		if (trend == THERMAL_TREND_RAISING) {
>  			list_for_each_entry(instance, &tz->thermal_instances,
> -					    node) {
> +					    tz_node) {
>  				if (instance->trip != trip)
>  					continue;
>  				cdev = instance->cdev;
> @@ -757,7 +757,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  			}
>  		} else if (trend == THERMAL_TREND_DROPPING) { /* Cooling off? */
>  			list_for_each_entry(instance, &tz->thermal_instances,
> -					    node) {
> +					    tz_node) {
>  				if (instance->trip != trip)
>  					continue;
>  				cdev = instance->cdev;
> @@ -777,7 +777,7 @@ static void thermal_zone_device_passive(struct thermal_zone_device *tz,
>  	 * and avoid thrashing around the passive trip point.  Note that we
>  	 * assume symmetry.
>  	 */
> -	list_for_each_entry(instance, &tz->thermal_instances, node) {
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  		if (instance->trip != trip)
>  			continue;
>  		cdev = instance->cdev;
> @@ -873,13 +873,13 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
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
> @@ -912,9 +912,9 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
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
> @@ -1117,7 +1117,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  	}
>  
>  	if (temp >= trip_temp) {
> -		list_for_each_entry(instance, &tz->thermal_instances, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> @@ -1136,7 +1136,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  			cdev->ops->set_cur_state(cdev, cur_state);
>  		}
>  	} else {	/* below trip */
> -		list_for_each_entry(instance, &tz->thermal_instances, node) {
> +		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> -- 
> 1.7.9.5
> 
