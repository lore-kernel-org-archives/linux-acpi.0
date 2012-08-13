From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 11/13] Thermal: Add a notification API
Date: Mon, 13 Aug 2012 15:02:44 +0800
Message-ID: <1344841364.1682.796.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-12-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13352 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab2HMHBi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 03:01:38 -0400
In-Reply-To: <1344516365-7230-12-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

On =E5=9B=9B, 2012-08-09 at 18:16 +0530, Durgadoss R wrote:
> This patch adds a notification API which the sensor drivers'
> can use to notify the framework. The framework then takes
> care of the throttling according to the configured policy.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
>  include/linux/thermal.h       |    1 +
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 193d071..6931d81 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1309,6 +1309,24 @@ void thermal_cooling_device_unregister(struct =
thermal_cooling_device *cdev)
>  }
>  EXPORT_SYMBOL(thermal_cooling_device_unregister);
> =20
> +/**
> + * notify_thermal_framework - Sensor drivers use this API to notify =
framework
> + * @tz:		thermal zone device
> + * @trip:	indicates which trip point has been crossed
> + *
> + * This function handles the trip events from sensor drivers. It sta=
rts
> + * throttling the cooling devices according to the policy configured=
=2E
> + * For CRITICAL and HOT trip points, this notifies the respective dr=
ivers,
> + * and does actual throttling for other trip points i.e ACTIVE and P=
ASSIVE.
> + * The throttling policy is based on the configured platform data; i=
f no
> + * platform data is provided, this uses the step_wise throttling pol=
icy.
> + */
> +void notify_thermal_framework(struct thermal_zone_device *tz, int tr=
ip)
> +{
> +	handle_thermal_trip(tz, trip);
> +}
> +EXPORT_SYMBOL(notify_thermal_framework);
> +
why thermal_zone_device_update() can not work here?

thanks,
rui
>  static int create_policy_attr(struct thermal_zone_device *tz)
>  {
>  	sysfs_attr_init(&tz->policy_attr.attr);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3bdf5f2..a3a0144 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -246,6 +246,7 @@ int get_tz_trend(struct thermal_zone_device *, in=
t);
>  struct thermal_cooling_device *get_cdev_by_name(const char *);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_de=
vice *,
>  		struct thermal_cooling_device *, int);
> +void notify_thermal_framework(struct thermal_zone_device *, int);
> =20
>  /*
>   * The platform layer shall define a 'function' that provides the


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
