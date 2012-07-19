From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 16/16] Thermal: use plist instead of list
Date: Thu, 19 Jul 2012 23:45:20 +0200
Message-ID: <201207192345.20753.rjw@sisk.pl>
References: <1342679480-5336-1-git-send-email-rui.zhang@intel.com> <1342679480-5336-17-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48760 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab2GSVjl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2012 17:39:41 -0400
In-Reply-To: <1342679480-5336-17-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Amit Kachhap <amit.kachhap@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Wei Ni <wni@nvidia.com>

On Thursday, July 19, 2012, Zhang Rui wrote:
> so that the thermal manager can easily find out
> the deepest cooling state request for a cooling device.
> 
> cdev->lock is also introduced in this patch to protect this plist.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

I'm not sure if this is actually better than without the plist.

The plist manipulations in thermal_zone_trip_update() look like they
can add quite some overhead in some situations.

Do you have any quantitative justification for this change?

Rafael


> ---
>  drivers/thermal/thermal_sys.c |   84 ++++++++++++++++++++++++++---------------
>  include/linux/thermal.h       |    4 +-
>  2 files changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index a40dda1..9f56250 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -54,11 +54,10 @@ struct thermal_instance {
>  	int trip;
>  	unsigned long upper;	/* Highest cooling state for this trip point */
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
> -	unsigned long target;	/* expected cooling state */
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
>  	struct list_head tz_node; /* node in tz->instances */
> -	struct list_head cdev_node; /* node in cdev->instances */
> +	struct plist_node cdev_node; /* node in cdev->instances */
>  };
>  
>  static DEFINE_IDR(thermal_tz_idr);
> @@ -787,7 +786,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	dev->trip = trip;
>  	dev->upper = upper;
>  	dev->lower = lower;
> -	dev->target = -1;
> +	plist_node_init(&dev->cdev_node, -1);
>  
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> @@ -809,6 +808,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		goto remove_symbol_link;
>  
>  	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);
>  	list_for_each_entry(pos, &tz->instances, tz_node)
>  	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  		result = -EEXIST;
> @@ -816,8 +816,9 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  	}
>  	if (!result) {
>  		list_add_tail(&dev->tz_node, &tz->instances);
> -		list_add_tail(&dev->cdev_node, &cdev->instances);
> +		plist_add(&dev->cdev_node, &cdev->instances);
>  	}
> +	mutex_unlock(&cdev->lock);
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -850,14 +851,17 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	struct thermal_instance *pos, *next;
>  
>  	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);
>  	list_for_each_entry_safe(pos, next, &tz->instances, tz_node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  			list_del(&pos->tz_node);
> -			list_del(&pos->cdev_node);
> +			plist_del(&pos->cdev_node, &pos->cdev->instances);
> +			mutex_unlock(&cdev->lock);
>  			mutex_unlock(&tz->lock);
>  			goto unbind;
>  		}
>  	}
> +	mutex_unlock(&cdev->lock);
>  	mutex_unlock(&tz->lock);
>  
>  	return -ENODEV;
> @@ -923,7 +927,8 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	}
>  
>  	strcpy(cdev->type, type);
> -	INIT_LIST_HEAD(&cdev->instances);
> +	plist_head_init(&cdev->instances);
> +	mutex_init(&cdev->lock);
>  	cdev->ops = ops;
>  	cdev->updated = 1;
>  	cdev->device.class = &thermal_class;
> @@ -1019,26 +1024,21 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  
>  static void thermal_zone_do_update(struct thermal_zone_device *tz)
>  {
> -	struct thermal_instance *instance1, *instance2;
> +	struct thermal_instance *instance;
> +	struct plist_node *node;
>  	struct thermal_cooling_device *cdev;
> -	int target;
>  
> -	list_for_each_entry(instance1, &tz->instances, tz_node) {
> -		cdev = instance1->cdev;
> +	list_for_each_entry(instance, &tz->instances, tz_node) {
> +		cdev = instance->cdev;
>  
>  		/* cooling device has already been updated*/
>  		if (cdev->updated)
>  			continue;
>  
> -		target = 0;
> -		/* Make sure cdev enters the deepest cooling state */
> -		list_for_each_entry(instance2, &cdev->instances, cdev_node) {
> -			if (instance2->target == -1)
> -				continue;
> -			if (instance2->target > target)
> -				target = instance2->target;
> -		}
> -		cdev->ops->set_cur_state(cdev, target);
> +		/* Deepest cooling state required */
> +		node = plist_last(&cdev->instances);
> +
> +		cdev->ops->set_cur_state(cdev, node->prio < 0 ? 0 : node->prio);
>  		cdev->updated = 1;
>  	}
>  }
> @@ -1064,7 +1064,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  {
>  	struct thermal_instance *instance;
>  	struct thermal_cooling_device *cdev = NULL;
> -	unsigned long cur_state, max_state;
> +	unsigned long cur_state, max_state, target_state;
>  	long trip_temp;
>  	enum thermal_trip_type trip_type;
>  	enum thermal_trend trend;
> @@ -1088,21 +1088,29 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  
>  			cdev->ops->get_cur_state(cdev, &cur_state);
>  			cdev->ops->get_max_state(cdev, &max_state);
> -
> +			target_state = cur_state;
>  			if (trend == THERMAL_TREND_RAISING) {
> -				cur_state = cur_state < instance->upper ?
> +				target_state = cur_state < instance->upper ?
>  					    (cur_state + 1) : instance->upper;
>  			} else if (trend == THERMAL_TREND_DROPPING) {
> -				cur_state = cur_state > instance->lower ?
> +				target_state = cur_state > instance->lower ?
>  				    (cur_state - 1) : instance->lower;
>  			}
>  
> +			if (target_state == cur_state)
> +				continue;
> +
>  			/* activate a passive thermal instance */
>  			if (trip_type == THERMAL_TRIP_PASSIVE &&
> -			    instance->target == -1)
> +			    instance->cdev_node.prio == -1)
>  				tz->passive++;
>  
> -			instance->target = cur_state;
> +			mutex_lock(&cdev->lock);
> +			plist_del(&instance->cdev_node, &cdev->instances);
> +			plist_node_init(&instance->cdev_node, target_state);
> +			plist_add(&instance->cdev_node, &cdev->instances);
> +			mutex_unlock(&cdev->lock);
> +
>  			cdev->updated = 0; /* cooling device needs update */
>  		}
>  	} else {	/* below trip */
> @@ -1111,20 +1119,36 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz,
>  				continue;
>  
>  			/* Do not use the deacitve thermal instance */
> -			if (instance->target == -1)
> +			if (instance->cdev_node.prio == -1)
>  				continue;
>  			cdev = instance->cdev;
>  			cdev->ops->get_cur_state(cdev, &cur_state);
>  
> -			cur_state = cur_state > instance->lower ?
> +			target_state = cur_state > instance->lower ?
>  				    (cur_state - 1) : -1;
>  
> +			if (target_state == cur_state)
> +				continue;
> +
>  			/* deactivate a passive thermal instance */
>  			if (trip_type == THERMAL_TRIP_PASSIVE &&
> -			    cur_state == -1)
> +			    target_state == -1)
>  				tz->passive--;
> -			instance->target = cur_state;
> -			cdev->updated = 0; /* cooling device needs update */
> +
> +			mutex_lock(&cdev->lock);
> +			plist_del(&instance->cdev_node, &cdev->instances);
> +			plist_node_init(&instance->cdev_node, target_state);
> +			plist_add(&instance->cdev_node, &cdev->instances);
> +			mutex_unlock(&cdev->lock);
> +
> +			/*
> +			 * cooling device needs update.
> +			 * But if the target_state is -1, it means that
> +			 * the cooling device is already in cooling state 0,
> +			 * thus we do not need update
> +			 */
> +			if (target_state != -1)
> +				cdev->updated = 0;
>  		}
>  	}
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f725eb9..376a59e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -28,6 +28,7 @@
>  #include <linux/idr.h>
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
> +#include <linux/plist.h>
>  
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
> @@ -93,7 +94,8 @@ struct thermal_cooling_device {
>  	void *devdata;
>  	const struct thermal_cooling_device_ops *ops;
>  	int updated; /* 1 if the cooling device does not need update */
> -	struct list_head instances;
> +	struct mutex lock;
> +	struct plist_head instances;
>  	struct list_head node;
>  };
>  
> 

