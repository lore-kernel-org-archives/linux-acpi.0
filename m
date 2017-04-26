From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: xpower: Add support for the GPI1 regulator to the OpRegion handler
Date: Thu, 27 Apr 2017 00:01:42 +0200
Message-ID: <2873076.4YlPq2sVU6@aspire.rjw.lan>
References: <20170421114809.17468-1-hdegoede@redhat.com> <20170421114809.17468-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56424 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934850AbdDZWH4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 18:07:56 -0400
In-Reply-To: <20170421114809.17468-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, russianneuromancer@ya.ru

On Friday, April 21, 2017 01:48:09 PM Hans de Goede wrote:
> Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
> their 0x8d power OpRegion, add support for this.
> 
> This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
> fixes these errors causing these devices to not suspend.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Srinivas, Andy, any concerns here?

> ---
> Changes in v2:
> -Simplify reg == 0x92 handling (suggested by Andy Shevchenko)
> -Add special handling for reg == 0x92 to intel_xpower_pmic_get_power() too
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 1a76c78..c9be430 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -118,6 +118,10 @@ static struct pmic_table power_table[] = {
>  		.reg = 0x10,
>  		.bit = 0x00
>  	}, /* BUC6 */
> +	{
> +		.address = 0x4c,
> +		.reg = 0x92,
> +	}, /* GPI1 */
>  };
>  
>  /* TMP0 - TMP5 are the same, all from GPADC */
> @@ -156,7 +160,12 @@ static int intel_xpower_pmic_get_power(struct regmap *regmap, int reg,
>  	if (regmap_read(regmap, reg, &data))
>  		return -EIO;
>  
> -	*value = (data & BIT(bit)) ? 1 : 0;
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == 0x92)
> +		*value = ((data & 0x07) == 0x03);
> +	else
> +		*value = (data & BIT(bit)) ? 1 : 0;
> +
>  	return 0;
>  }
>  
> @@ -165,6 +174,10 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>  {
>  	int data;
>  
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == 0x92)
> +		return regmap_update_bits(regmap, reg, 0x07, on ? 0x03 : 0x04);
> +
>  	if (regmap_read(regmap, reg, &data))
>  		return -EIO;
>  
> 

