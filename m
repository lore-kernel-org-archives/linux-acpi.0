From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCHv2 05/14] Thermal: Obtain platform data for thermal zone
Date: Mon, 27 Aug 2012 08:29:00 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926321014A@SHSMSX101.ccr.corp.intel.com>
References: <1346041706-29642-1-git-send-email-durgadoss.r@intel.com>
 <1346041706-29642-6-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10176 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab2H0I3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Aug 2012 04:29:13 -0400
In-Reply-To: <1346041706-29642-6-git-send-email-durgadoss.r@intel.com>
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
> Subject: [PATCHv2 05/14] Thermal: Obtain platform data for thermal zone
> Importance: High
> 
> This patch retrieves the platform level data for a zone during its
> registration. It is not an error to not have any platform data.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c index 92a187c..6adda39 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -1339,6 +1339,22 @@ static void remove_trip_attrs(struct
> thermal_zone_device *tz)
>  	kfree(tz->trip_hyst_attrs);
>  }
> 
> +static int retrieve_zone_params(struct thermal_zone_device *tz) {
> +	int ret;
> +
> +	/* Check whether the platform data pointer is defined */
> +	if (!get_platform_thermal_params)
> +		return 0;
> +
> +	/* It is not an error to not have any platform data */
> +	ret = get_platform_thermal_params(tz);
> +	if (ret)
> +		tz->tzp = NULL;
> +
> +	return 0;
> +}
> +
>  /**
>   * thermal_zone_device_register - register a new thermal zone device
>   * @type:	the thermal zone device type
> @@ -1443,6 +1459,11 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
>  	if (result)
>  		goto unregister;
> 
> +	/* Retrieve platform level parameters for this zone */
> +	result = retrieve_zone_params(tz);
> +	if (result)
> +		goto unregister;
> +

As I said, if we need it, we should ask user to provide it during registration. What do you think?

Thanks,
rui

>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	if (ops->bind)
> --
> 1.7.9.5

