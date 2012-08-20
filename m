From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 13/13] Thermal: Introduce locking for
 cdev.thermal_instances list.
Date: Mon, 20 Aug 2012 18:45:18 +0300
Message-ID: <20120820154518.GB9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-14-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57127 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410Ab2HTPp1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:45:27 -0400
Received: by weyx8 with SMTP id x8so3969962wey.19
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-14-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hello Rui,

On Thu, Jul 26, 2012 at 04:41:23PM +0800, Zhang Rui wrote:
> we need to go over all the thermal_instance list of a cooling device
> to decide which cooling state to put the cooling device to.
> 
> But at this time, as a cooling device may be referenced in multiple
> thermal zones, we need to lock the list first in case
> another thermal zone is updating this cooling device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

A minor comment bellow.

> ---
>  drivers/thermal/thermal_sys.c |    8 ++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 7f3a891..356a59d 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -799,6 +799,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		goto remove_symbol_link;
>  
>  	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);

Why do you need to lock while going through the tz thermal_instances?

>  	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>  	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  		result = -EEXIST;
> @@ -808,6 +809,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
>  		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);

Locking the above operation should be enough, no?

>  	}
> +	mutex_unlock(&cdev->lock);
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -840,14 +842,17 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);
>  	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  			list_del(&pos->tz_node);
>  			list_del(&pos->cdev_node);
> +			mutex_unlock(&cdev->lock);
>  			mutex_unlock(&tz->lock);
>  			goto unbind;
>  		}
>  	}
> +	mutex_unlock(&cdev->lock);
>  	mutex_unlock(&tz->lock);
>  
>  	return -ENODEV;
> @@ -913,6 +918,7 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	}
>  
>  	strcpy(cdev->type, type);
> +	mutex_init(&cdev->lock);
>  	INIT_LIST_HEAD(&cdev->thermal_instances);
>  	cdev->ops = ops;
>  	cdev->updated = true;
> @@ -1016,6 +1022,7 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
>  	if (cdev->updated)
>  		return;
>  
> +	mutex_lock(&cdev->lock);
>  	/* Make sure cdev enters the deepest cooling state */
>  	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
>  		if (instance->target == THERMAL_NO_TARGET)
> @@ -1023,6 +1030,7 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
>  		if (instance->target > target)
>  			target = instance->target;
>  	}
> +	mutex_unlock(&cdev->lock);
>  	cdev->ops->set_cur_state(cdev, target);
>  	cdev->updated = true;
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 06fd04d..d02d06d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -95,6 +95,7 @@ struct thermal_cooling_device {
>  	void *devdata;
>  	const struct thermal_cooling_device_ops *ops;
>  	bool updated; /* true if the cooling device does not need update */
> +	struct mutex lock; /* protect thermal_instances list */
>  	struct list_head thermal_instances;
>  	struct list_head node;
>  };
> -- 
> 1.7.9.5
> 
