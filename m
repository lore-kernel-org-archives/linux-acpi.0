From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] ACPI / PMIC: xpower: Add support for the GPI1
 regulator to the OpRegion handler
Date: Mon, 15 May 2017 11:58:44 +0300
Message-ID: <1494838724.6967.50.camel@linux.intel.com>
References: <20170514213539.20231-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759829AbdEOJEn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 May 2017 05:04:43 -0400
In-Reply-To: <20170514213539.20231-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org

On Sun, 2017-05-14 at 23:35 +0200, Hans de Goede wrote:
> Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
> their 0x8d power OpRegion, add support for this.
> 
> This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
> fixes these errors causing these devices to not suspend.

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Simplify reg == 0x92 handling (suggested by Andy Shevchenko)
> -Add special handling for reg == 0x92 to intel_xpower_pmic_get_power()
> too
> Changes in v3:
> -Use defines for GPI1 reg and bits, rather then hardcoded hex values
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c
> b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 1a76c784cd4c..3b7d5be5b7ed 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -21,6 +21,11 @@
>  #include "intel_pmic.h"
>  
>  #define XPOWER_GPADC_LOW	0x5b
> +#define XPOWER_GPI1_CTRL	0x92
> +
> +#define GPI1_LDO_MASK		GENMASK(2, 0)
> +#define GPI1_LDO_ON		(3 << 0)
> +#define GPI1_LDO_OFF		(4 << 0)
>  
>  static struct pmic_table power_table[] = {
>  	{
> @@ -118,6 +123,10 @@ static struct pmic_table power_table[] = {
>  		.reg = 0x10,
>  		.bit = 0x00
>  	}, /* BUC6 */
> +	{
> +		.address = 0x4c,
> +		.reg = 0x92,
> +	}, /* GPI1 */
>  };
>  
>  /* TMP0 - TMP5 are the same, all from GPADC */
> @@ -156,7 +165,12 @@ static int intel_xpower_pmic_get_power(struct
> regmap *regmap, int reg,
>  	if (regmap_read(regmap, reg, &data))
>  		return -EIO;
>  
> -	*value = (data & BIT(bit)) ? 1 : 0;
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == XPOWER_GPI1_CTRL)
> +		*value = ((data & GPI1_LDO_MASK) == GPI1_LDO_ON);
> +	else
> +		*value = (data & BIT(bit)) ? 1 : 0;
> +
>  	return 0;
>  }
>  
> @@ -165,6 +179,11 @@ static int intel_xpower_pmic_update_power(struct
> regmap *regmap, int reg,
>  {
>  	int data;
>  
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == XPOWER_GPI1_CTRL)
> +		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> +					  on ? GPI1_LDO_ON :
> GPI1_LDO_OFF);
> +
>  	if (regmap_read(regmap, reg, &data))
>  		return -EIO;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
