From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 10/13] Thermal: List thermal_instance in
 thermal_cooling_device.
Date: Mon, 20 Aug 2012 18:46:41 +0300
Message-ID: <20120820154641.GE9833@besouro>
References: <1343292083-2047-1-git-send-email-rui.zhang@intel.com>
 <1343292083-2047-11-git-send-email-rui.zhang@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:60506 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752543Ab2HTPqx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 11:46:53 -0400
Received: by wibhq4 with SMTP id hq4so3222331wib.14
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 08:46:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343292083-2047-11-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jul 26, 2012 at 04:41:20PM +0800, Zhang Rui wrote:
> List thermal_instance in thermal_cooling_device so that
> cooling device can know the cooling state requirement
> of all the thermal instances.
> 
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/thermal_sys.c |    7 ++++++-
>  include/linux/thermal.h       |    1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index b2a2d48..9906717 100644
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
> @@ -878,8 +879,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
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
> @@ -915,6 +918,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>  	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
>  		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
>  			list_del(&pos->tz_node);
> +			list_del(&pos->cdev_node);
>  			mutex_unlock(&tz->lock);
>  			goto unbind;
>  		}
> @@ -984,6 +988,7 @@ thermal_cooling_device_register(char *type, void *devdata,
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
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
