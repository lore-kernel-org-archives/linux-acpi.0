From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 05/13] Thermal: Obtain platform data for thermal zone
Date: Tue, 21 Aug 2012 08:20:42 +0300
Message-ID: <20120821052042.GW9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-6-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37097 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196Ab2HUFUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:20:52 -0400
Received: by wibhn17 with SMTP id hn17so3622011wib.11
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:20:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-6-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

Hello,

On Thu, Aug 09, 2012 at 06:15:57PM +0530, Durgadoss R wrote:
> This patch retrieves the platform level data for
> a zone during its registration. It is not an error
> to not have any platform data.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index f043cd6..243a3f0 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -142,6 +142,22 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
>  }
>  EXPORT_SYMBOL(get_thermal_instance);
>  
> +static void retrieve_zone_params(struct thermal_zone_device *tz)
> +{
> +	int ret;
> +
> +	/* Check whether the platform data pointer is defined */
> +	if (!get_platform_thermal_params)
> +		return;
> +
> +	ret = get_platform_thermal_params(tz);
> +	if (ret) {
> +		dev_err(&tz->device,
> +		"parameters for zone %s not defined:%d\n", tz->type, ret);

If it is not an error to be without pdata, we should not be farty at the console log.
This may generate several prints during boot, for instance.


> +		tz->tzp = NULL;
> +	}
> +}
> +
>  /* sys I/F for thermal zone */
>  
>  #define to_thermal_zone(_dev) \
> @@ -1460,6 +1476,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	if (result)
>  		goto unregister;
>  
> +	/* Retrieve platform level parameters for this zone */
> +	retrieve_zone_params(tz);
> +

Should it be any sanity check on the pdata passed?

>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	if (ops->bind)
> -- 
> 1.7.9.5
> 
