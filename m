From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4 11/15] Thermal: Introduce a step_wise thermal governor
Date: Tue, 18 Sep 2012 15:13:30 +0800
Message-ID: <1347952410.1682.1227.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-12-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59314 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756849Ab2IRHM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2012 03:12:56 -0400
In-Reply-To: <1347946506-18449-12-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com

On =E4=BA=8C, 2012-09-18 at 11:05 +0530, Durgadoss R wrote:
> This patch adds a simple step_wise governor to the
> generic thermal layer. This algorithm throttles the
> cooling devices in a linear fashion. If the 'trend'
> is heating, it throttles by one step. And if the
> thermal trend is cooling it de-throttles by one step.
>=20
> This actually moves the throttling logic from thermal_sys.c
> and puts inside step_wise.c, without any change. This is
> always selected as the default governor.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/Kconfig     |    7 ++
>  drivers/thermal/Makefile    |    1 +
>  drivers/thermal/step_wise.c |  194 +++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/thermal/step_wise.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2200912..9f6a3aa 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -4,6 +4,7 @@
> =20
>  menuconfig THERMAL
>  	tristate "Generic Thermal sysfs driver"
> +	select STEP_WISE
>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
>  	  thermal management. Usually it's made up of one or more thermal
> @@ -59,3 +60,9 @@ config FAIR_SHARE
>  	depends on THERMAL
>  	help
>  	  Enable this to manage platform thermals using fair-share governor=
=2E
> +
> +config STEP_WISE
> +	bool "Step_wise thermal governor"
> +	depends on THERMAL
> +	help
> +	  Enable this to manage platform thermals using a simple linear

if we always wants CONFIG_STEP_WISE built in, why bother to export this
config option to users?

IMO, something like
 menuconfig THERMAL
  	tristate "Generic Thermal sysfs driver"
	select STEP_WISE

 config STEP_WISE
	bool
	depends on THERMAL

is enough, SETP_WISE will always be selected.

further more, we even do not need a config option for this governor,
just "obj-y +=3D step_wise.o" in Makefile.

another question would be,
as this governor registration function is fs_initcall(),
what if a platform thermal driver is registered and gets a thermal even=
t
before this governor being registered?

thanks,
rui

> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 30540dd..4e53c00 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SPEAR_THERMAL)		+=3D spear_thermal.o
>  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
>  obj-$(CONFIG_EXYNOS_THERMAL)		+=3D exynos_thermal.o
>  obj-$(CONFIG_FAIR_SHARE)		+=3D fair_share.o
> +obj-$(CONFIG_STEP_WISE)			+=3D step_wise.o
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.=
c
> new file mode 100644
> index 0000000..3f9cfcf
> --- /dev/null
> +++ b/drivers/thermal/step_wise.c
> @@ -0,0 +1,194 @@
> +/*
> + *  step_wise.c - A step-by-step Thermal throttling governor
> + *
> + *  Copyright (C) 2012 Intel Corp
> + *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or mo=
dify
> + *  it under the terms of the GNU General Public License as publishe=
d by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, =
but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public Licens=
e along
> + *  with this program; if not, write to the Free Software Foundation=
, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +/*
> + * If the temperature is higher than a trip point,
> + *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> + *       state for this trip point
> + *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> + *       state for this trip point
> + */
> +static unsigned long get_target_state(struct thermal_instance *insta=
nce,
> +					enum thermal_trend trend)
> +{
> +	struct thermal_cooling_device *cdev =3D instance->cdev;
> +	unsigned long cur_state;
> +
> +	cdev->ops->get_cur_state(cdev, &cur_state);
> +
> +	if (trend =3D=3D THERMAL_TREND_RAISING) {
> +		cur_state =3D cur_state < instance->upper ?
> +			    (cur_state + 1) : instance->upper;
> +	} else if (trend =3D=3D THERMAL_TREND_DROPPING) {
> +		cur_state =3D cur_state > instance->lower ?
> +			    (cur_state - 1) : instance->lower;
> +	}
> +
> +	return cur_state;
> +}
> +
> +static void update_passive_instance(struct thermal_zone_device *tz,
> +				enum thermal_trip_type type, int value)
> +{
> +	/*
> +	 * If value is +1, activate a passive instance.
> +	 * If value is -1, deactivate a passive instance.
> +	 */
> +	if (type =3D=3D THERMAL_TRIP_PASSIVE || type =3D=3D THERMAL_TRIPS_N=
ONE)
> +		tz->passive +=3D value;
> +}
> +
> +static void update_instance_for_throttle(struct thermal_zone_device =
*tz,
> +				int trip, enum thermal_trip_type trip_type,
> +				enum thermal_trend trend)
> +{
> +	struct thermal_instance *instance;
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (instance->trip !=3D trip)
> +			continue;
> +
> +		instance->target =3D get_target_state(instance, trend);
> +
> +		/* Activate a passive thermal instance */
> +		if (instance->target =3D=3D THERMAL_NO_TARGET)
> +			update_passive_instance(tz, trip_type, 1);
> +
> +		instance->cdev->updated =3D false; /* cdev needs update */
> +	}
> +}
> +
> +static void update_instance_for_dethrottle(struct thermal_zone_devic=
e *tz,
> +				int trip, enum thermal_trip_type trip_type)
> +{
> +	struct thermal_instance *instance;
> +	struct thermal_cooling_device *cdev;
> +	unsigned long cur_state;
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +		if (instance->trip !=3D trip ||
> +			instance->target =3D=3D THERMAL_NO_TARGET)
> +			continue;
> +
> +		cdev =3D instance->cdev;
> +		cdev->ops->get_cur_state(cdev, &cur_state);
> +
> +		instance->target =3D cur_state > instance->lower ?
> +			    (cur_state - 1) : THERMAL_NO_TARGET;
> +
> +		/* Deactivate a passive thermal instance */
> +		if (instance->target =3D=3D THERMAL_NO_TARGET)
> +			update_passive_instance(tz, trip_type, -1);
> +
> +		cdev->updated =3D false; /* cdev needs update */
> +	}
> +}
> +
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,=
 int trip)
> +{
> +	long trip_temp;
> +	enum thermal_trip_type trip_type;
> +	enum thermal_trend trend;
> +
> +	if (trip =3D=3D THERMAL_TRIPS_NONE) {
> +		trip_temp =3D tz->forced_passive;
> +		trip_type =3D THERMAL_TRIPS_NONE;
> +	} else {
> +		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +		tz->ops->get_trip_type(tz, trip, &trip_type);
> +	}
> +
> +	trend =3D get_tz_trend(tz, trip);
> +
> +	mutex_lock(&tz->lock);
> +
> +	if (tz->temperature >=3D trip_temp)
> +		update_instance_for_throttle(tz, trip, trip_type, trend);
> +	else
> +		update_instance_for_dethrottle(tz, trip, trip_type);
> +
> +	mutex_unlock(&tz->lock);
> +}
> +
> +/**
> + * step_wise_throttle - throttles devices asscciated with the given =
zone
> + * @tz - thermal_zone_device
> + * @trip - the trip point
> + * @trip_type - type of the trip point
> + *
> + * Throttling Logic: This uses the trend of the thermal zone to thro=
ttle.
> + * If the thermal zone is 'heating up' this throttles all the coolin=
g
> + * devices associated with the zone and its particular trip point, b=
y one
> + * step. If the zone is 'cooling down' it brings back the performanc=
e of
> + * the devices by one step.
> + */
> +int step_wise_throttle(struct thermal_zone_device *tz, int trip)
> +{
> +	struct thermal_instance *instance;
> +
> +	thermal_zone_trip_update(tz, trip);
> +
> +	if (tz->forced_passive)
> +		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
> +
> +	mutex_lock(&tz->lock);
> +
> +	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> +		thermal_cdev_update(instance->cdev);
> +
> +	mutex_unlock(&tz->lock);
> +
> +	return 0;
> +}
> +
> +struct thermal_governor thermal_gov_step_wise =3D {
> +	.name		=3D DEFAULT_THERMAL_GOVERNOR,
> +	.throttle	=3D step_wise_throttle,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static int __init thermal_gov_step_wise_init(void)
> +{
> +	return thermal_register_governor(&thermal_gov_step_wise);
> +}
> +
> +static void __exit thermal_gov_step_wise_exit(void)
> +{
> +	thermal_unregister_governor(&thermal_gov_step_wise);
> +}
> +
> +/* This should load after thermal framework */
> +fs_initcall(thermal_gov_step_wise_init);
> +module_exit(thermal_gov_step_wise_exit);
> +
> +MODULE_AUTHOR("Durgadoss R");
> +MODULE_DESCRIPTION("A step-by-step thermal throttling governor");
> +MODULE_LICENSE("GPL");


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
