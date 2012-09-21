From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4 04/15] Thermal: Add platform level information to
 thermal.h
Date: Fri, 21 Sep 2012 15:12:49 +0800
Message-ID: <1348211569.10877.125.camel@rui.sh.intel.com>
References: <1347946506-18449-1-git-send-email-durgadoss.r@intel.com>
	 <1347946506-18449-5-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5646 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab2IUHMF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2012 03:12:05 -0400
In-Reply-To: <1347946506-18449-5-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com

On =E4=BA=8C, 2012-09-18 at 11:04 +0530, Durgadoss R wrote:
> This patch adds platform level information to thermal.h
> by introducing two structures to hold:
>  * bind parameters for a thermal zone,
>  * zone level platform parameters
>=20
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  include/linux/thermal.h |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 32af124..4caa32e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -157,6 +157,7 @@ struct thermal_zone_device {
>  	int passive;
>  	unsigned int forced_passive;
>  	const struct thermal_zone_device_ops *ops;
> +	const struct thermal_zone_params *tzp;
>  	struct list_head thermal_instances;
>  	struct idr idr;
>  	struct mutex lock; /* protect thermal_instances list */
> @@ -164,6 +165,34 @@ struct thermal_zone_device {
>  	struct delayed_work poll_queue;
>  };
> =20
> +/* Structure that holds binding parameters for a zone */
> +struct thermal_bind_params {
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
> +	 * This is a bit mask that gives the binding relation between this
> +	 * thermal zone and cdev, for a particular trip point.
> +	 * See Documentation/thermal/sysfs-api.txt for more information.
> +	 */
> +	int trip_mask;
> +	int (*match) (struct thermal_zone_device *tz,
> +			struct thermal_cooling_device *cdev);
> +};

we do not have field to describe the upper and lower limit?

thanks.
rui
> +
> +/* Structure to define Thermal Zone parameters */
> +struct thermal_zone_params {
> +	int num_tbps;	/* Number of tbp entries */
> +	struct thermal_bind_params *tbp;
> +};
> +
>  struct thermal_genl_event {
>  	u32 orig;
>  	enum events event;


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
