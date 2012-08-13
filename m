From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 04/13] Thermal: Add platform level information to
 thermal.h
Date: Mon, 13 Aug 2012 14:27:49 +0800
Message-ID: <1344839269.1682.778.camel@rui.sh.intel.com>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
	 <1344516365-7230-5-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51129 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab2HMG0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2012 02:26:42 -0400
In-Reply-To: <1344516365-7230-5-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

On =E5=9B=9B, 2012-08-09 at 18:15 +0530, Durgadoss R wrote:
> This patch creates a structure to hold a thermal zone's
> platform level info, and also defines an extern function to
> retrieve zone parameters from thermal_sys.c.
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    3 +++
>  include/linux/thermal.h       |   43 +++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_=
sys.c
> index 998c16e..f043cd6 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -49,6 +49,9 @@ static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static DEFINE_MUTEX(thermal_list_lock);
> =20
> +int (*get_platform_thermal_params)(struct thermal_zone_device *);
> +EXPORT_SYMBOL(get_platform_thermal_params);
> +
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int err;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 757a007..f9ce1e2 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -33,6 +33,8 @@
>  #define THERMAL_MAX_TRIPS	12
>  #define THERMAL_NAME_LENGTH	20
> =20
> +#define MAX_COOLING_DEVS	THERMAL_MAX_TRIPS
> +
why MAX_COOLING_DEVS equals THERMAL_MAX_TRIPS?
if this is an arbitrary number, please use the number instead, or else
this would be confusing.

>  /* Initial state of a cooling device during binding */
>  #define THERMAL_NO_TARGET	-1UL
> =20
> @@ -49,6 +51,11 @@
>  #define THERMAL_GENL_VERSION                    0x01
>  #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
> =20
> +/* Thermal policies */
> +#define THERMAL_USER_SPACE	0
> +#define THERMAL_FAIR_SHARE	1
> +#define	THERMAL_STEP_WISE	2

coding style.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
