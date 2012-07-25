From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 16/16] Thermal: Introduce locking for cdev.thermal_instances list.
Date: Wed, 25 Jul 2012 20:54:14 +0200
Message-ID: <201207252054.14648.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-17-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56893 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab2GYSs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 14:48:28 -0400
In-Reply-To: <1343182273-32096-17-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:

Can you please say something about the motivation in the changelog?

Thanks,
Rafael


> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    8 ++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 23a5c86..531480a 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -814,6 +814,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		goto remove_symbol_link;
>  
>  	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);
>  	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>  	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  		result = -EEXIST;
> @@ -823,6 +824,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
>  		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>  	}
> +	mutex_unlock(&cdev->lock);
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -855,14 +857,17 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
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
> @@ -928,6 +933,7 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	}
>  
>  	strcpy(cdev->type, type);
> +	mutex_init(&cdev->lock);
>  	INIT_LIST_HEAD(&cdev->thermal_instances);
>  	cdev->ops = ops;
>  	cdev->updated = true;
> @@ -1031,6 +1037,7 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
>  	if (cdev->updated)
>  		return;
>  
> +	mutex_lock(&cdev->lock);
>  	/* Make sure cdev enters the deepest cooling state */
>  	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
>  		if (instance->target == THERMAL_NO_TARGET)
> @@ -1038,6 +1045,7 @@ static void thermal_cdev_do_update(struct thermal_cooling_device *cdev)
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
> 

