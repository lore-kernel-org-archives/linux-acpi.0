From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 03/14] Thermal: Add get trend, get instance API's to
 thermal_sys
Date: Mon, 27 Aug 2012 08:11:59 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092632100DE@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-4-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53937 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab2H0IMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 04:12:03 -0400
In-Reply-To: <1346041706-29642-4-git-send-email-durgadoss.r@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>



> -----Original Message-----
> From: R, Durgadoss
> Sent: Monday, August 27, 2012 7:28 AM
> To: lenb@kernel.org; Zhang, Rui
> Cc: linux-acpi@vger.kernel.org; eduardo.valentin@ti.com; R, Durgadoss
> Subject: [PATCHv2 03/14] Thermal: Add get trend, get instance API's to
> thermal_sys
> Importance: High
> 
> This patch adds the following API's to thermal_sys.c, that can be used
> by other Thermal drivers.
>  * get_tz_trend: obtain the trend of the given thermal zone
>  * get_thermal_instance: obtain the instance corresponding
>    to the given tz, cdev and the trip point.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   40
> ++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h       |    4 ++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c index 0e71b00..5e141b5 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -82,6 +82,46 @@ static void release_idr(struct idr *idr, struct
> mutex *lock, int id)
>  		mutex_unlock(lock);
>  }
> 
> +int get_tz_trend(struct thermal_zone_device *tz, int trip) {
> +	enum thermal_trend trend;
> +
> +	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend))
> {
> +		if (tz->temperature > tz->last_temperature)
> +			trend = THERMAL_TREND_RAISING;
> +		else if (tz->temperature < tz->last_temperature)
> +			trend = THERMAL_TREND_DROPPING;
> +		else
> +			trend = THERMAL_TREND_STABLE;
> +	}
> +
> +	return trend;
> +}
> +EXPORT_SYMBOL(get_tz_trend);
> +
> +struct thermal_instance *get_thermal_instance(struct
> thermal_zone_device *tz,
> +			struct thermal_cooling_device *cdev, int trip) {
> +	struct thermal_instance *pos = NULL;
> +	struct thermal_instance *target_instance = NULL;
> +
> +	mutex_lock(&tz->lock);
> +	mutex_lock(&cdev->lock);
> +
> +	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
> +		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev)
> {
> +			target_instance = pos;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&cdev->lock);
> +	mutex_unlock(&tz->lock);
> +
> +	return target_instance;
> +}
> +EXPORT_SYMBOL(get_thermal_instance);
> +
>  /* sys I/F for thermal zone */
> 
>  #define to_thermal_zone(_dev) \
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> 8611e3e..32af124 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -185,6 +185,10 @@ struct thermal_cooling_device
> *thermal_cooling_device_register(char *, void *,
>  		const struct thermal_cooling_device_ops *);  void
> thermal_cooling_device_unregister(struct thermal_cooling_device *);
> 
> +int get_tz_trend(struct thermal_zone_device *, int); struct

Coding style.

Thanks,
rui
> +thermal_instance *get_thermal_instance(struct thermal_zone_device *,
> +		struct thermal_cooling_device *, int);
> +
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events event);
> #else
> --
> 1.7.9.5

