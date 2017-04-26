From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: lpss: call pwm_add_table() for Bay Trail PWM device
Date: Wed, 26 Apr 2017 23:48:13 +0200
Message-ID: <2384740.tOO8Zgodss@aspire.rjw.lan>
References: <20170421073507.10945-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54041 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031064AbdDZVy1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 17:54:27 -0400
In-Reply-To: <20170421073507.10945-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org

On Friday, April 21, 2017 09:35:07 AM Hans de Goede wrote:
> On Bay Trail systems with a Crystal Cove PMIC the Crystal Cove's PWM is
> used to control the backlight brightness. On systems without one, the
> Crystal Cove SoC's PWM is used and we need to call pwm_add_table() so
> that the i915 driver can find the pwm for controlling the backlight.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Mika, Andy, comments?

> ---
>  drivers/acpi/acpi_lpss.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5edfd9c..10347e3 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -143,6 +143,22 @@ static void lpss_deassert_reset(struct lpss_private_data *pdata)
>  	writel(val, pdata->mmio_base + offset);
>  }
>  
> +/*
> + * BYT PWM used for backlight control by the i915 driver on systems without
> + * the Crystal Cove PMIC.
> + */
> +static struct pwm_lookup byt_pwm_lookup[] = {
> +	PWM_LOOKUP_WITH_MODULE("80860F09:00", 0, "0000:00:02.0",
> +			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
> +			       "pwm-lpss-platform"),
> +};
> +
> +static void byt_pwm_setup(struct lpss_private_data *pdata)
> +{
> +	if (!acpi_dev_present("INT33FD", NULL, -1))
> +		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
> +}
> +
>  #define LPSS_I2C_ENABLE			0x6c
>  
>  static void byt_i2c_setup(struct lpss_private_data *pdata)
> @@ -200,6 +216,7 @@ static const struct lpss_device_desc lpt_sdio_dev_desc = {
>  
>  static const struct lpss_device_desc byt_pwm_dev_desc = {
>  	.flags = LPSS_SAVE_CTX,
> +	.setup = byt_pwm_setup,
>  };
>  
>  static const struct lpss_device_desc bsw_pwm_dev_desc = {
> 

