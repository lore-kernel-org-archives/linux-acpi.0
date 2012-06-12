From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 3/4] RFC Thermal: Introduce a step-wise thermal governor
Date: Tue, 12 Jun 2012 15:59:01 +0300
Message-ID: <20120612125901.GD8724@besouro>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-4-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:56486 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751752Ab2FLM7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 08:59:08 -0400
Received: by obbwd20 with SMTP id wd20so11636118obb.18
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jun 2012 05:59:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339436374-26881-4-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org

Hello Rui,

On Mon, Jun 11, 2012 at 11:09:33PM +0530, Durgadoss R wrote:
> This patch adds a simple step-wise governor to the
> generic thermal layer. This algorithm throttles the
> cooling devices in a linear fashion. If the 'trend'
> is heating, it throttles by one step. And if the
> thermal trend is cooling it de-throttles by one step.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/Kconfig     |    7 +++
>  drivers/thermal/Makefile    |    1 +
>  drivers/thermal/step_wise.c |   86 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/thermal/step_wise.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index f5132f3..74992cd 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -32,3 +32,10 @@ config FAIR_SHARE
>  	depends on THERMAL
>  	help
>  	  Enable this to manage platform thermals using fair-share governor.
> +
> +config STEP_WISE
> +	bool "step_wise thermal governor"
> +	depends on THERMAL
> +	help
> +	  Enable this to manage platform thermals using a simple linear
> +          throttling algorithm

Same as before, add some description of the governor-policy.

> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 4ffe1a8..c2c0ce0 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -5,3 +5,4 @@
>  obj-$(CONFIG_THERMAL)		+= thermal_sys.o
>  obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
>  obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
> +obj-$(CONFIG_STEP_WISE)			+= step_wise.o
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> new file mode 100644
> index 0000000..7ce923a
> --- /dev/null
> +++ b/drivers/thermal/step_wise.c
> @@ -0,0 +1,86 @@
> +/*
> + *  step_wise.c - A step-by-step Thermal throttling governor
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
> +unsigned long get_new_state(unsigned long cur_state, enum thermal_trend trend)
> +{
> +	switch (trend) {
> +	case THERMAL_TREND_HEATING:
> +		return cur_state + 1;
> +	case THERMAL_TREND_COOLING:
> +		return cur_state - 1;
> +	default:
> +		return cur_state + 1;
> +	}
> +}
> +
> +/**
> + * step_wise_throttle - throttles devices asscciated with the given zone
> + * @tz - thermal_zone_device
> + *
> + * Throttling Logic: This uses the trend of the thermal zone to throttle.
> + * If the thermal zone is 'heating up' this throttles all the cooling
> + * devices associated with the zone by one step. If the zone is
> + * 'cooling down' it brings back the performance of the devices by one step.
> + */
> +int step_wise_throttle(struct thermal_zone_device *tz,
> +			int trip, enum thermal_trip_type trip_type)
> +{
> +	struct thermal_zone_params *tzp = tz->tzp;
> +	struct thermal_cooling_device *cdev;
> +	unsigned long max_state, cur_state, new_state;
> +	enum thermal_trend trend;
> +	int i;
> +
> +	if (!tz->ops->get_trend || tz->ops->get_trend(tz, trip, &trend))
> +		trend = THERMAL_TREND_DEFAULT;
> +
> +	for (i = 0; i < tzp->num_cdevs; i++) {
> +		if (!tzp->cdevs[i])
> +			continue;
> +
> +		cdev = tzp->cdevs[i];
> +		cdev->ops->get_cur_state(cdev, &cur_state);
> +		cdev->ops->get_max_state(cdev, &max_state);
> +
> +		new_state = get_new_state(cur_state, trend);
> +		if (new_state >= max_state)
> +			cdev->ops->set_cur_state(cdev, max_state);
> +		else if (new_state <= 0)

new_state can not be negative as it is declared as unsigned.

> +			cdev->ops->set_cur_state(cdev, 0);
> +		else
> +			cdev->ops->set_cur_state(cdev, new_state);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(step_wise_throttle);


Again, what was the difference between linear and step_wise?

Is it so that linear applies only to the passive trip points and
step wise applies to all cooling devices in the specific zone?

I guess we need some more clarity on the differences.

> +
> +MODULE_AUTHOR("Durgadoss R");
> +MODULE_DESCRIPTION("A step-by-step thermal throttling governor");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.0.4
> 
