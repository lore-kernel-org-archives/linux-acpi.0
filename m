From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 4/4] RFC Thermal: Platform layer changes to provide
 thermal data
Date: Tue, 12 Jun 2012 16:02:33 +0300
Message-ID: <20120612130233.GE8724@besouro>
References: <1339436374-26881-1-git-send-email-durgadoss.r@intel.com>
 <1339436374-26881-5-git-send-email-durgadoss.r@intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46630 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916Ab2FLNCl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jun 2012 09:02:41 -0400
Received: by yhr47 with SMTP id 47so4360234yhr.14
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jun 2012 06:02:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339436374-26881-5-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, eduardo.valentin@ti.com, amit.kachhap@linaro.org

Hello Rui,

On Mon, Jun 11, 2012 at 11:09:34PM +0530, Durgadoss R wrote:
> This patch shows how can we add platform specific thermal data
> required by the enhanced thermal framework.
> This is just an example patch, and _not_ for merge.

Nice! Thanks for sending an example. This makes things a lot easier.

> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  arch/x86/platform/mrst/mrst.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
> index e31bcd8..eeb3cd0 100644
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
> @@ -78,6 +79,27 @@ struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
>  EXPORT_SYMBOL_GPL(sfi_mrtc_array);
>  int sfi_mrtc_num;
>  
> +#define MRST_THERMAL_ZONES	3
> +struct thermal_zone_params tzp[MRST_THERMAL_ZONES] = {
> +	{ .thermal_zone_name = "CPU",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 2,
> +	.cdevs_name = {"CPU", "Battery"},
> +	.weights = {80, 20}, },
> +
> +	{ .thermal_zone_name = "Battery",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 1,
> +	.cdevs_name = {"Battery"},
> +	.weights = {100}, },
> +
> +	{ .thermal_zone_name = "Skin",
> +	.throttle_policy = THERMAL_FAIR_SHARE,
> +	.num_cdevs = 2,
> +	.cdevs_name = {"Display", "Battery"},
> +	.weights = {50, 50}, }
> +};

Please consider the ordering comment I sent on your patch 01/04.

> +
>  static void mrst_power_off(void)
>  {
>  }
> @@ -983,10 +1005,27 @@ static int __init sfi_parse_devs(struct sfi_table_header *table)
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

If you send the pdata while registering the zone, and store it in the zone data structures,
you wont need to be iterating on all pdata array and matching strings.

Besides, I suppose the pdata you are talking about it actually board specifics, right?

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
> 1.7.0.4
> 
