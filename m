From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 04/14] Thermal: Add platform level information to
 thermal.h
Date: Mon, 27 Aug 2012 08:27:56 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263210135@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-5-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14698 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab2H0I2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 04:28:00 -0400
In-Reply-To: <1346041706-29642-5-git-send-email-durgadoss.r@intel.com>
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
> Subject: [PATCHv2 04/14] Thermal: Add platform level information to
> thermal.h
> Importance: High
> 
> This patch creates two structures; one to hold bind bind parameters for
> a thermal zone, and another to store platform layer data for a thermal
> zone, and defines an extern function to retrieve these parameters from
> thermal_sys.c. This patch also defines an enum that describes various
> policies for thermal throttling.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |    3 +++
>  include/linux/thermal.h       |   46
> +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c index 5e141b5..92a187c 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -51,6 +51,9 @@ static LIST_HEAD(thermal_tz_list);  static
> LIST_HEAD(thermal_cdev_list);  static DEFINE_MUTEX(thermal_list_lock);
> 
> +int (*get_platform_thermal_params)(struct thermal_zone_device *);
> +EXPORT_SYMBOL(get_platform_thermal_params);
> +
If this function is used by the thermal layer, and provided by the platform thermal driver, why not make it mandatory when registering a thermal zone?

Say,

+/* Structure to define Thermal Zone parameters */ struct 
+thermal_zone_params {
+	int trips,
+	int mask,
+	struct thermal_zone_device_ops *ops;
+	enum thermal_throttle_policy throttle_policy;
+	int num_tbps;	/* Number of tbp entries */
+	struct thermal_bind_params *tbp;
 };
And modify thermal_zone_device_register to
Struct thermal_zone_device *thermal_zone_device_register(const char *type, struct thermal_zone_params *params);

The first 3 fields are necessary for registering a zone, the thermal_bind_params can either be filled by platform thermal driver, or be NULL and filled by thermal layer later, when user invokes thermal_zone_bind_cooling_devices.

In this way, we do not need this API at all.

Thanks,
rui

>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)  {
>  	int err;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> 32af124..b644b8e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -67,6 +67,12 @@ enum thermal_trend {
>  	THERMAL_TREND_DROPPING, /* temperature is dropping */  };
> 
> +enum thermal_throttle_policy {
> +	THERMAL_USER_SPACE,
> +	THERMAL_FAIR_SHARE,
> +	THERMAL_STEP_WISE,
> +};
> +
>  /* Events supported by Thermal Netlink */  enum events {
>  	THERMAL_AUX0,
> @@ -162,6 +168,37 @@ struct thermal_zone_device {
>  	struct mutex lock; /* protect thermal_instances list */
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> +	struct thermal_zone_params *tzp;
> +};
> +
> +/* Structure that holds binding parameters for a zone */ struct
> +thermal_bind_params {
> +	struct thermal_cooling_device *cdev;
> +
> +	/*
> +	 * This is a measure of 'how effectively these devices can
> +	 * cool 'this' thermal zone. The shall be determined by platform
> +	 * characterization. This is on a 'percentage' scale.
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int weight;
> +
> +	/*
> +	 * This is a bit mask that gives the binding relation between
> this
> +	 * thermal zone and cdev, for a particular trip point.
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int trip_mask;
> +	int (*match) (struct thermal_zone_device *tz,
> +			struct thermal_cooling_device *cdev); };

You should start a new line here.

> +
> +/* Structure to define Thermal Zone parameters */ struct
> +thermal_zone_params {
> +	const char *zone_name;


What is this zone_name used for?

> +	enum thermal_throttle_policy throttle_policy;
> +	int num_tbps;	/* Number of tbp entries */
> +	struct thermal_bind_params *tbp;
>  };
> 
>  struct thermal_genl_event {
> @@ -188,6 +225,15 @@ void thermal_cooling_device_unregister(struct
> thermal_cooling_device *);  int get_tz_trend(struct thermal_zone_device
> *, int);  struct thermal_instance *get_thermal_instance(struct
> thermal_zone_device *,
>  		struct thermal_cooling_device *, int);
> +/*
> + * The platform layer shall define a 'function' that provides the
> + * parameters for all thermal zones in the platform. This pointer
> + * should point to that 'function'.
> + *
> + * In thermal_zone_device_register() we update the parameters
> + * for the particular thermal zone.
> + */
> +extern int (*get_platform_thermal_params)(struct thermal_zone_device
> +*);
> 
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(u32 orig, enum events event);
> --
> 1.7.9.5

