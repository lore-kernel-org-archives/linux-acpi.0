From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RESEND 13/16] Thermal: List thermal_instance in thermal_cooling_device.
Date: Wed, 25 Jul 2012 22:35:16 +0200
Message-ID: <201207252235.16540.rjw@sisk.pl>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com> <1343182273-32096-14-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:57185 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab2GYU3b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 16:29:31 -0400
In-Reply-To: <1343182273-32096-14-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, July 25, 2012, Zhang Rui wrote:
> List thermal_instance in thermal_cooling_device so that
> cooling device can know the cooling state requirement
> of all the thermal instances.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/thermal/thermal_sys.c |    7 ++++++-
>  include/linux/thermal.h       |    1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index b76e55f..0a06ea4 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -57,6 +57,7 @@ struct thermal_instance {
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
>  	struct list_head tz_node; /* node in tz->thermal_instances */
> +	struct list_head cdev_node; /* node in cdev->thermal_instances */
>  };
>  
>  static DEFINE_IDR(thermal_tz_idr);
> @@ -882,8 +883,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  		result = -EEXIST;
>  		break;
>  	}
> -	if (!result)
> +	if (!result) {
>  		list_add_tail(&dev->tz_node, &tz->thermal_instances);
> +		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
> +	}
>  	mutex_unlock(&tz->lock);
>  
>  	if (!result)
> @@ -919,6 +922,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  			list_del(&pos->tz_node);
> +			list_del(&pos->cdev_node);
>  			mutex_unlock(&tz->lock);
>  			goto unbind;
>  		}
> @@ -988,6 +992,7 @@ thermal_cooling_device_register(char *type, void *devdata,
>  	}
>  
>  	strcpy(cdev->type, type);
> +	INIT_LIST_HEAD(&cdev->thermal_instances);
>  	cdev->ops = ops;
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index b11db1e..bcf3384 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -94,6 +94,7 @@ struct thermal_cooling_device {
>  	struct device device;
>  	void *devdata;
>  	const struct thermal_cooling_device_ops *ops;
> +	struct list_head thermal_instances;
>  	struct list_head node;
>  };
>  
> 

