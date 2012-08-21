From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 08/13] Thermal: Introduce fair_share thermal governor
Date: Tue, 21 Aug 2012 08:33:13 +0300
Message-ID: <20120821053313.GY9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-9-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:60289 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752143Ab2HUFdW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:33:22 -0400
Received: by wgx1 with SMTP id 1so4647832wgx.11
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:33:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-9-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

Hello,

On Thu, Aug 09, 2012 at 06:16:00PM +0530, Durgadoss R wrote:
> This patch introduces a simple 'weight' based
> governor named fair_share governor. Whenever the
> thermal framework gets notified of the trip point
> violation, this governor (if configured), throttles
> the cooling devices associated with a thermal zone.
> 
> This mapping between a thermal zone and a cooling device
> and the effectiveness of cooling are provided in the
> platform layer.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/Kconfig      |    6 ++
>  drivers/thermal/Makefile     |    3 +-
>  drivers/thermal/fair_share.c |  128 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h      |    9 +++
>  4 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/fair_share.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 3ab2bd5..f5110c0 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -27,3 +27,9 @@ config SPEAR_THERMAL
>  	help
>  	  Enable this to plug the SPEAr thermal sensor driver into the Linux
>  	  thermal framework
> +
> +config FAIR_SHARE
> +	bool "Fair-share thermal governor"
> +	depends on THERMAL
> +	help
> +	  Enable this to manage platform thermals using fair-share governor.
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index a9fff0b..4ffe1a8 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -3,4 +3,5 @@
>  #
>  
>  obj-$(CONFIG_THERMAL)		+= thermal_sys.o
> -obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
> \ No newline at end of file
> +obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
> +obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> new file mode 100644
> index 0000000..b8c8d45
> --- /dev/null
> +++ b/drivers/thermal/fair_share.c
> @@ -0,0 +1,128 @@
> +/*
> + *  fair_share.c - A simple weight based Thermal governor
> + *
> + *  Copyright (C) 2012 Intel Corp
> + *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +
> +/**
> + * get_trip_level: - obtains the current trip level for a zone
> + * @tz:		thermal zone device
> + */
> +static int get_trip_level(struct thermal_zone_device *tz)
> +{
> +	int count = 0;
> +	unsigned long trip_temp;
> +
> +	if (tz->trips == 0 || !tz->ops->get_trip_temp)
> +		return 0;
> +
> +	for (count = 0; count < tz->trips; count++) {
> +		tz->ops->get_trip_temp(tz, count, &trip_temp);
> +		if (tz->temperature < trip_temp)
> +			break;
> +	}
> +	return count;
> +}
> +
> +static long get_target_state(struct thermal_zone_device *tz,
> +		struct thermal_cooling_device *cdev, int weight, int level)
> +{
> +	unsigned long max_state;
> +
> +	cdev->ops->get_max_state(cdev, &max_state);
> +
> +	return (long)(weight * level * max_state) / (100 * tz->trips);
> +}
> +
> +static void thermal_cdev_update(struct thermal_cooling_device *cdev)
> +{
> +	struct thermal_instance *instance;
> +	unsigned long target = 0;
> +
> +	mutex_lock(&cdev->lock);
> +
> +	/* Make sure cdev enters the deepest cooling state */
> +	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
> +		if (instance->target > target)
> +			target = instance->target;
> +	}
> +
> +	mutex_unlock(&cdev->lock);
> +
> +	cdev->ops->set_cur_state(cdev, target);
> +}

I believe Rui has already provided an arbitrator, can we reuse it here as well?

> +
> +/**
> + * fair_share_throttle - throttles devices asscciated with the given zone
> + * @tz - thermal_zone_device
> + *
> + * Throttling Logic: This uses three parameters to calculate the new
> + * throttle state of the cooling devices associated with the given zone.
> + *
> + * Parameters used for Throttling:
> + * P1. max_state: Maximum throttle state exposed by the cooling device.
> + * P2. weight[i]/100:
> + *	How 'effective' the 'i'th device is, in cooling the given zone.
> + * P3. cur_trip_level/max_no_of_trips:
> + *	This describes the extent to which the devices should be throttled.
> + *	We do not want to throttle too much when we trip a lower temperature,
> + *	whereas the throttling is at full swing if we trip critical levels.
> + *	(Heavily assumes the trip points are in ascending order)
> + * new_state of cooling device = P3 * P2 * P1
> + */
> +void fair_share_throttle(struct thermal_zone_device *tz, int trip)
> +{
> +	struct thermal_zone_params *tzp;
> +	struct thermal_cooling_device *cdev;
> +	struct thermal_instance *instance;
> +	int i;
> +	int cur_trip_level = get_trip_level(tz);
> +
> +	if (!tz->tzp)
> +		return;
> +
> +	tzp = tz->tzp;
> +
> +	for (i = 0; i < tzp->num_cdevs; i++) {
> +		cdev = get_cdev_by_name(tzp->cdevs_name[i]);
> +		if (!cdev)
> +			continue;
> +
> +		instance = get_thermal_instance(tz, cdev, trip);
> +		if (!instance)
> +			continue;
> +
> +		instance->target = get_target_state(tz, cdev,
> +					tzp->weights[i], cur_trip_level);
> +
> +		thermal_cdev_update(cdev);
> +	}
> +}
> +EXPORT_SYMBOL(fair_share_throttle);
> +
> +MODULE_AUTHOR("Durgadoss R");
> +MODULE_DESCRIPTION("A simple weight based thermal throttling governor");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 1d49f05..4e2dc2c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -257,6 +257,15 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>   */
>  extern int (*get_platform_thermal_params)(struct thermal_zone_device *);
>  
> +#ifdef CONFIG_FAIR_SHARE
> +extern void fair_share_throttle(struct thermal_zone_device *tz, int trip);
> +#else
> +static inline void fair_share_throttle(struct thermal_zone_device *tz, int trip)
> +{
> +	return;
> +}
> +#endif
> +
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events event);
>  #else
> -- 
> 1.7.9.5
> 
