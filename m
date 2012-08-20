From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 04/13] Thermal: Add platform level information to
 thermal.h
Date: Tue, 21 Aug 2012 00:11:46 +0300
Message-ID: <20120820211146.GS9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-5-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38945 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754967Ab2HTVLy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2012 17:11:54 -0400
Received: by wibhq4 with SMTP id hq4so3425523wib.8
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 14:11:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-5-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

On Thu, Aug 09, 2012 at 06:15:56PM +0530, Durgadoss R wrote:
> This patch creates a structure to hold a thermal zone's
> platform level info, and also defines an extern function to
> retrieve zone parameters from thermal_sys.c.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    3 +++
>  include/linux/thermal.h       |   43 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 998c16e..f043cd6 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -49,6 +49,9 @@ static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  
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
>  
> +#define MAX_COOLING_DEVS	THERMAL_MAX_TRIPS
> +
>  /* Initial state of a cooling device during binding */
>  #define THERMAL_NO_TARGET	-1UL
>  
> @@ -49,6 +51,11 @@
>  #define THERMAL_GENL_VERSION                    0x01
>  #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
>  
> +/* Thermal policies */
> +#define THERMAL_USER_SPACE	0
> +#define THERMAL_FAIR_SHARE	1
> +#define	THERMAL_STEP_WISE	2
> +
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
>  
> @@ -165,6 +172,7 @@ struct thermal_zone_device {
>  	struct mutex lock; /* protect thermal_instances list */
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> +	struct thermal_zone_params *tzp;
>  };
>  
>  /*
> @@ -187,6 +195,31 @@ struct thermal_instance {
>  	struct list_head cdev_node; /* node in cdev->thermal_instances */
>  };
>  
> +/* Platform level parameters associated with a thermal zone */
> +struct thermal_zone_params {
> +	char *thermal_zone_name;

I suppose this will be plat data definition right? does it make sense to make the above a const?

> +	int throttle_policy;
> +
> +	/* Number of cooling devices associated with this thermal zone */
> +	int num_cdevs;
> +	char *cdevs_name[MAX_COOLING_DEVS];

dito

> +
> +	/*
> +	 * This is a measure of 'how effectively these devices can
> +	 * cool 'this' thermal zone. The shall be determined by platform
> +	 * characterization. This is on a 'percentage' scale.
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int weights[MAX_COOLING_DEVS];
> +
> +	/*
> +	 * This is a bit mask that gives the binding relation between this
> +	 * thermal zone and cdev, for a particular trip point.
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int trip_mask[MAX_COOLING_DEVS];

just a matter of taste, but how about defining a struct with cdev_name, weight, trip_max, and then declaring an array in thermal_zone_params?

> +};
> +
>  struct thermal_genl_event {
>  	u32 orig;
>  	enum events event;
> @@ -213,6 +246,16 @@ struct thermal_cooling_device *get_cdev_by_name(const char *);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>  		struct thermal_cooling_device *, int);
>  
> +/*
> + * The platform layer shall define a 'function' that provides the
> + * parameters for all thermal zones in the platform. This pointer
> + * should point to that 'function'.
> + *
> + * In thermal_zone_device_register() we update the parameters
> + * for the particular thermal zone.
> + */
> +extern int (*get_platform_thermal_params)(struct thermal_zone_device *);
> +
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events event);
>  #else
> -- 
> 1.7.9.5
> 
