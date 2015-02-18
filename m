From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPI / LPSS: Deassert resets for SPI host controllers on Braswell
Date: Wed, 18 Feb 2015 17:25:09 +0100
Message-ID: <3423831.zXJf7A6g9H@vostro.rjw.lan>
References: <1424260217-7719-1-git-send-email-mika.westerberg@linux.intel.com> <1424260217-7719-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59769 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751809AbbBRQBz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 11:01:55 -0500
In-Reply-To: <1424260217-7719-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yang A Fang <yang.a.fang@intel.com>, Yu Chen <yu.c.chen@intel.com>

On Wednesday, February 18, 2015 01:50:17 PM Mika Westerberg wrote:
> On some Braswell systems BIOS leaves resets for SPI host controllers
> active. This prevents the SPI driver from transferring messages on wire.
> 
> Fix this in similar way that we do for I2C already by deasserting resets
> for the SPI host controllers.
> 
> Reported-by: Yang A Fang <yang.a.fang@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

OK, so these two would need to go into "stable" I suppose?

What "stable" series we need them to go into?

> ---
>  drivers/acpi/acpi_lpss.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 64ccc3bb0826..7d5880ded78a 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -105,9 +105,7 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
>  	}
>  }
>  
> -#define LPSS_I2C_ENABLE			0x6c
> -
> -static void byt_i2c_setup(struct lpss_private_data *pdata)
> +static void lpss_deassert_reset(struct lpss_private_data *pdata)
>  {
>  	unsigned int offset;
>  	u32 val;
> @@ -116,6 +114,13 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
>  	val = readl(pdata->mmio_base + offset);
>  	val |= LPSS_RESETS_RESET_APB | LPSS_RESETS_RESET_FUNC;
>  	writel(val, pdata->mmio_base + offset);
> +}
> +
> +#define LPSS_I2C_ENABLE			0x6c
> +
> +static void byt_i2c_setup(struct lpss_private_data *pdata)
> +{
> +	lpss_deassert_reset(pdata);
>  
>  	if (readl(pdata->mmio_base + pdata->dev_desc->prv_offset))
>  		pdata->fixed_clk_rate = 133000000;
> @@ -170,6 +175,12 @@ static struct lpss_device_desc byt_i2c_dev_desc = {
>  	.setup = byt_i2c_setup,
>  };
>  
> +static struct lpss_device_desc bsw_spi_dev_desc = {
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
> +	.prv_offset = 0x400,
> +	.setup = lpss_deassert_reset,
> +};
> +
>  #else
>  
>  #define LPSS_ADDR(desc) (0UL)
> @@ -202,7 +213,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>  	/* Braswell LPSS devices */
>  	{ "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
>  	{ "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
> -	{ "8086228E", LPSS_ADDR(byt_spi_dev_desc) },
> +	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
>  	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
>  
>  	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
