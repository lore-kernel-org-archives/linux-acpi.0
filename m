From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: xpower: Fix power_table addresses
Date: Fri, 21 Apr 2017 12:32:01 +0300
Message-ID: <1492767121.24567.115.camel@linux.intel.com>
References: <20170421073433.10897-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037313AbdDUJcY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 05:32:24 -0400
In-Reply-To: <20170421073433.10897-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, russianneuromancer@ya.ru

On Fri, 2017-04-21 at 09:34 +0200, Hans de Goede wrote:
> The power table addresses should be contiguous, but there was a hole
> where 0x34 was missing. On most devices this is not a problem as
> addresses above 0x34 are used for the BUC# convertors which are not
> used in the DSDTs I've access to but after the BUC# convertors
> there is a field named GPI1 in the DSTDs, which does get used in some
> cases and ended up turning BUC6 on and off due to the wrong addresses,
> resulting in turning the entire device off (or causing it to reboot).
> 
> Removing the hole in the addresses fixes this, fixing one of my
> Bay Trail tablets turning off while booting the mainline kernel.
> 
> While at it add comments with the field names used in the DSDTs to
> make it easier to compare the register and bits used at each address
> with the datasheet.

Makes sense.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Cc: russianneuromancer@ya.ru
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 50 +++++++++++++++++---------
> ---------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c
> b/drivers/acpi/pmic/intel_pmic_xpower.c
> index 55f5111..1a76c78 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -27,97 +27,97 @@ static struct pmic_table power_table[] = {
>  		.address = 0x00,
>  		.reg = 0x13,
>  		.bit = 0x05,
> -	},
> +	}, /* ALD1 */
>  	{
>  		.address = 0x04,
>  		.reg = 0x13,
>  		.bit = 0x06,
> -	},
> +	}, /* ALD2 */
>  	{
>  		.address = 0x08,
>  		.reg = 0x13,
>  		.bit = 0x07,
> -	},
> +	}, /* ALD3 */
>  	{
>  		.address = 0x0c,
>  		.reg = 0x12,
>  		.bit = 0x03,
> -	},
> +	}, /* DLD1 */
>  	{
>  		.address = 0x10,
>  		.reg = 0x12,
>  		.bit = 0x04,
> -	},
> +	}, /* DLD2 */
>  	{
>  		.address = 0x14,
>  		.reg = 0x12,
>  		.bit = 0x05,
> -	},
> +	}, /* DLD3 */
>  	{
>  		.address = 0x18,
>  		.reg = 0x12,
>  		.bit = 0x06,
> -	},
> +	}, /* DLD4 */
>  	{
>  		.address = 0x1c,
>  		.reg = 0x12,
>  		.bit = 0x00,
> -	},
> +	}, /* ELD1 */
>  	{
>  		.address = 0x20,
>  		.reg = 0x12,
>  		.bit = 0x01,
> -	},
> +	}, /* ELD2 */
>  	{
>  		.address = 0x24,
>  		.reg = 0x12,
>  		.bit = 0x02,
> -	},
> +	}, /* ELD3 */
>  	{
>  		.address = 0x28,
>  		.reg = 0x13,
>  		.bit = 0x02,
> -	},
> +	}, /* FLD1 */
>  	{
>  		.address = 0x2c,
>  		.reg = 0x13,
>  		.bit = 0x03,
> -	},
> +	}, /* FLD2 */
>  	{
>  		.address = 0x30,
>  		.reg = 0x13,
>  		.bit = 0x04,
> -	},
> +	}, /* FLD3 */
>  	{
> -		.address = 0x38,
> +		.address = 0x34,
>  		.reg = 0x10,
>  		.bit = 0x03,
> -	},
> +	}, /* BUC1 */
>  	{
> -		.address = 0x3c,
> +		.address = 0x38,
>  		.reg = 0x10,
>  		.bit = 0x06,
> -	},
> +	}, /* BUC2 */
>  	{
> -		.address = 0x40,
> +		.address = 0x3c,
>  		.reg = 0x10,
>  		.bit = 0x05,
> -	},
> +	}, /* BUC3 */
>  	{
> -		.address = 0x44,
> +		.address = 0x40,
>  		.reg = 0x10,
>  		.bit = 0x04,
> -	},
> +	}, /* BUC4 */
>  	{
> -		.address = 0x48,
> +		.address = 0x44,
>  		.reg = 0x10,
>  		.bit = 0x01,
> -	},
> +	}, /* BUC5 */
>  	{
> -		.address = 0x4c,
> +		.address = 0x48,
>  		.reg = 0x10,
>  		.bit = 0x00
> -	},
> +	}, /* BUC6 */
>  };
>  
>  /* TMP0 - TMP5 are the same, all from GPADC */

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
