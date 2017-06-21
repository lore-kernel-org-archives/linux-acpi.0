From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [v3] ACPI / PMIC: xpower: Add support for the GPI1 regulator to
 the OpRegion handler
Date: Wed, 21 Jun 2017 15:27:30 +0200
Message-ID: <3aaa700d-168a-9f4e-bf1b-06e3694359a8@redhat.com>
References: <20170514213539.20231-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFUN1e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Jun 2017 09:27:34 -0400
In-Reply-To: <20170514213539.20231-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org

Hi,

On 14-05-17 23:35, Hans de Goede wrote:
> Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
> their 0x8d power OpRegion, add support for this.
> 
> This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
> fixes these errors causing these devices to not suspend.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Changes in v2:
> -Simplify reg == 0x92 handling (suggested by Andy Shevchenko)
> -Add special handling for reg == 0x92 to intel_xpower_pmic_get_power() too
> Changes in v3:
> -Use defines for GPI1 reg and bits, rather then hardcoded hex values

What is the status of this patch ? AFAICT this patch has not been
merged yet, even though it has a Reviewe-by.

Note this patch is necessary to fix suspend/resume on some devices,
as such it would be nic if we can get this merged soon.

Regards,

Hans



> ---
>   drivers/acpi/pmic/intel_pmic_xpower.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 1a76c784cd4c..3b7d5be5b7ed 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -21,6 +21,11 @@
>   #include "intel_pmic.h"
>   
>   #define XPOWER_GPADC_LOW	0x5b
> +#define XPOWER_GPI1_CTRL	0x92
> +
> +#define GPI1_LDO_MASK		GENMASK(2, 0)
> +#define GPI1_LDO_ON		(3 << 0)
> +#define GPI1_LDO_OFF		(4 << 0)
>   
>   static struct pmic_table power_table[] = {
>   	{
> @@ -118,6 +123,10 @@ static struct pmic_table power_table[] = {
>   		.reg = 0x10,
>   		.bit = 0x00
>   	}, /* BUC6 */
> +	{
> +		.address = 0x4c,
> +		.reg = 0x92,
> +	}, /* GPI1 */
>   };
>   
>   /* TMP0 - TMP5 are the same, all from GPADC */
> @@ -156,7 +165,12 @@ static int intel_xpower_pmic_get_power(struct regmap *regmap, int reg,
>   	if (regmap_read(regmap, reg, &data))
>   		return -EIO;
>   
> -	*value = (data & BIT(bit)) ? 1 : 0;
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == XPOWER_GPI1_CTRL)
> +		*value = ((data & GPI1_LDO_MASK) == GPI1_LDO_ON);
> +	else
> +		*value = (data & BIT(bit)) ? 1 : 0;
> +
>   	return 0;
>   }
>   
> @@ -165,6 +179,11 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>   {
>   	int data;
>   
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == XPOWER_GPI1_CTRL)
> +		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> +					  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
> +
>   	if (regmap_read(regmap, reg, &data))
>   		return -EIO;
>   
> 
