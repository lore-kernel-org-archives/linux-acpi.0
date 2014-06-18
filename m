From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Take I2C host controllers out of reset
Date: Thu, 19 Jun 2014 01:49:17 +0200
Message-ID: <3055901.MX8kzq0LJr@vostro.rjw.lan>
References: <1403004819-8906-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49233 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753396AbaFRXbl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 19:31:41 -0400
In-Reply-To: <1403004819-8906-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, linux-acpi@vger.kernel.org

On Tuesday, June 17, 2014 02:33:39 PM Mika Westerberg wrote:
> On Intel Baytrail, some I2C host controllers are held in reset when the OS
> gets control. This causes the driver to fail to detect the hardware
> properly.
> 
> Fix this so that we make sure that the I2C host controller is not in reset
> when the driver gets probe'd.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks!

> ---
>  drivers/acpi/acpi_lpss.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 63407d264885..9cb65b0e7597 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -34,6 +34,9 @@ ACPI_MODULE_NAME("acpi_lpss");
>  
>  /* Offsets relative to LPSS_PRIVATE_OFFSET */
>  #define LPSS_CLK_DIVIDER_DEF_MASK	(BIT(1) | BIT(16))
> +#define LPSS_RESETS			0x04
> +#define LPSS_RESETS_RESET_FUNC		BIT(0)
> +#define LPSS_RESETS_RESET_APB		BIT(1)
>  #define LPSS_GENERAL			0x08
>  #define LPSS_GENERAL_LTR_MODE_SW	BIT(2)
>  #define LPSS_GENERAL_UART_RTS_OVRD	BIT(3)
> @@ -99,6 +102,17 @@ static void lpss_uart_setup(struct lpss_private_data *pdata)
>  	writel(reg | LPSS_GENERAL_UART_RTS_OVRD, pdata->mmio_base + offset);
>  }
>  
> +static void lpss_i2c_setup(struct lpss_private_data *pdata)
> +{
> +	unsigned int offset;
> +	u32 val;
> +
> +	offset = pdata->dev_desc->prv_offset + LPSS_RESETS;
> +	val = readl(pdata->mmio_base + offset);
> +	val |= LPSS_RESETS_RESET_APB | LPSS_RESETS_RESET_FUNC;
> +	writel(val, pdata->mmio_base + offset);
> +}
> +
>  static struct lpss_device_desc lpt_dev_desc = {
>  	.clk_required = true,
>  	.prv_offset = 0x800,
> @@ -171,6 +185,7 @@ static struct lpss_device_desc byt_i2c_dev_desc = {
>  	.prv_offset = 0x800,
>  	.save_ctx = true,
>  	.shared_clock = &i2c_clock,
> +	.setup = lpss_i2c_setup,
>  };
>  
>  #else
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
