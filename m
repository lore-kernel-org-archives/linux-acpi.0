From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 13/13] Thermal: Platform layer changes to provide thermal
 data
Date: Tue, 21 Aug 2012 08:39:50 +0300
Message-ID: <20120821053950.GC9833@besouro>
References: <1344516365-7230-1-git-send-email-durgadoss.r@intel.com>
 <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35194 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011Ab2HUFj7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Aug 2012 01:39:59 -0400
Received: by wgbfa7 with SMTP id fa7so4627042wgb.28
        for <linux-acpi@vger.kernel.org>; Mon, 20 Aug 2012 22:39:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344516365-7230-14-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org, wni@nvidia.com

Hello,

On Thu, Aug 09, 2012 at 06:16:05PM +0530, Durgadoss R wrote:
> This patch shows how can we add platform specific thermal data
> required by the thermal framework. This is just an example
> patch, and _not_ for merge.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  arch/x86/platform/mrst/mrst.c |   42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
> index fd41a92..0440db5 100644
> --- a/arch/x86/platform/mrst/mrst.c
> +++ b/arch/x86/platform/mrst/mrst.c
> @@ -30,6 +30,7 @@
>  #include <linux/mfd/intel_msic.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c/tc35876x.h>
> +#include <linux/thermal.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mpspec_def.h>
> @@ -78,6 +79,30 @@ struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
>  EXPORT_SYMBOL_GPL(sfi_mrtc_array);
>  int sfi_mrtc_num;
>  
> +#define MRST_THERMAL_ZONES	3
> +struct thermal_zone_params tzp[MRST_THERMAL_ZONES] = {
> +	{ .thermal_zone_name = "CPU",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 2,
> +	.cdevs_name = {"CPU", "Battery"},
> +	.trip_mask = {0x0F, 0x08},
> +	.weights = {80, 20}, },
> +
> +	{ .thermal_zone_name = "Battery",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 1,
> +	.cdevs_name = {"Battery"},
> +	.trip_mask = {0x0F},
> +	.weights = {100}, },
> +
> +	{ .thermal_zone_name = "Skin",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 2,
> +	.cdevs_name = {"Display", "Battery"},
> +	.trip_mask = {0x0F, 0x0F},
> +	.weights = {50, 50}, }

Please consider the comment I sent on your data definition and also the comment I made on this patch on your RFC series.

> +};
> +
>  static void mrst_power_off(void)
>  {
>  }
> @@ -983,10 +1008,27 @@ static int __init sfi_parse_devs(struct sfi_table_header *table)
>  	return 0;
>  }
>  
> +static int mrst_get_thermal_params(struct thermal_zone_device *tz)
> +{
> +	int i;
> +
> +	for (i = 0; i < MRST_THERMAL_ZONES; i++) {
> +		if (!strcmp(tzp[i].thermal_zone_name, tz->type)) {
> +			tz->tzp = &tzp[i];
> +			return 0;
> +		}
> +	}
> +	return -ENODEV;
> +}
> +
>  static int __init mrst_platform_init(void)
>  {
>  	sfi_table_parse(SFI_SIG_GPIO, NULL, NULL, sfi_parse_gpio);
>  	sfi_table_parse(SFI_SIG_DEVS, NULL, NULL, sfi_parse_devs);
> +
> +	/* Set platform thermal data pointer */
> +	get_platform_thermal_params = mrst_get_thermal_params;
> +
>  	return 0;
>  }
>  arch_initcall(mrst_platform_init);
> -- 
> 1.7.9.5
> 
