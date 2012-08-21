From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 06/13] Thermal: Add a policy sysfs attribute
Date: Tue, 21 Aug 2012 08:31:23 +0300
Message-ID: <20120821053123.GX9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-7-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:33225 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079Ab2HUFbc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:31:32 -0400
Received: by weyx10 with SMTP id x10so3841759wey.10
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-7-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

Hello,

On Thu, Aug 09, 2012 at 06:15:58PM +0530, Durgadoss R wrote:
> This patch adds a policy sysfs attribute to a thermal zone.
> This attribute will give us the throttling policy used
> for the zone. This is a RO attribute.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 243a3f0..195e529 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -411,6 +411,27 @@ passive_show(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%d\n", tz->forced_passive);
>  }
>  
> +static ssize_t show_throttle_policy(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	struct thermal_zone_params *tzp = tz->tzp;
> +
> +	if (!tzp)
> +		return sprintf(buf, "step_wise(default)\n");
> +
> +	switch (tzp->throttle_policy) {
> +	case THERMAL_FAIR_SHARE:
> +		return sprintf(buf, "fair_share\n");
> +	case THERMAL_STEP_WISE:
> +		return sprintf(buf, "step_wise\n");
> +	case THERMAL_USER_SPACE:
> +		return sprintf(buf, "user_space\n");
> +	default:
> +		return sprintf(buf, "unknown\n");
> +	}

Assume you store the policy type under platform data tzp, does it mean that
zones which does not have the tzp won't be capable to change the policy?

> +}
> +
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> @@ -1269,6 +1290,15 @@ leave:
>  }
>  EXPORT_SYMBOL(thermal_zone_device_update);
>  
> +static int create_policy_attr(struct thermal_zone_device *tz)
> +{
> +	sysfs_attr_init(&tz->policy_attr.attr);
> +	tz->policy_attr.attr.name = "throttle_policy";
> +	tz->policy_attr.attr.mode = S_IRUGO | S_IWUSR;
> +	tz->policy_attr.show = show_throttle_policy;
> +	return device_create_file(&tz->device, &tz->policy_attr);
> +}
> +
>  /**
>   * create_trip_attrs - create attributes for trip points
>   * @tz:		the thermal zone device
> @@ -1479,6 +1509,14 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	/* Retrieve platform level parameters for this zone */
>  	retrieve_zone_params(tz);
>  
> +	result = create_policy_attr(tz);
> +	if (result) {
> +		dev_err(&tz->device,
> +			"create_policy_attr for zone %s failed:%d\n",
> +			tz->type, result);
> +		goto unregister;
> +	}
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	if (ops->bind)
> @@ -1539,6 +1577,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	remove_trip_attrs(tz);
>  
> +	device_remove_file(&tz->device, &tz->policy_attr);
> +
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	idr_destroy(&tz->idr);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f9ce1e2..1d49f05 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -173,6 +173,7 @@ struct thermal_zone_device {
>  	struct list_head node;
>  	struct delayed_work poll_queue;
>  	struct thermal_zone_params *tzp;
> +	struct device_attribute policy_attr;
>  };
>  
>  /*
> -- 
> 1.7.9.5
> 
