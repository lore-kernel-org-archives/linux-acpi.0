From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Thu, 20 Aug 2015 15:38:05 +0300
Message-ID: <20150820123805.GG30005@lahna.fi.intel.com>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4571 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbbHTMiM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Aug 2015 08:38:12 -0400
Content-Disposition: inline
In-Reply-To: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

+Heikki

On Thu, Aug 20, 2015 at 10:46:07PM +0530, Srinidhi Kasagar wrote:
> LPSS devices in Braswell and Baytrail does not need the default
> 10ms d3_delay imposed by PCI specification. Removing this
> unnecessary delay significantly reduces the resume time
> (~200ms on Braswell/Cherrytrail) on these platforms.
> 
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>

Have you tested this on Asus T100? The delay was actually needed in
order to restore the context IIRC.

Also you are saying Braswell and Baytrail but...

> ---
>  drivers/acpi/acpi_lpss.c |   59 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 37fb19047603..9437b5fa59c3 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -60,6 +60,7 @@ ACPI_MODULE_NAME("acpi_lpss");
>  #define LPSS_CLK_DIVIDER		BIT(2)
>  #define LPSS_LTR			BIT(3)
>  #define LPSS_SAVE_CTX			BIT(4)
> +#define LPSS_NO_D3_DELAY		BIT(5)
>  
>  struct lpss_private_data;
>  
> @@ -134,6 +135,17 @@ static struct lpss_device_desc lpt_dev_desc = {
>  	.prv_offset = 0x800,
>  };
>  
> +static struct lpss_device_desc bsw_lpt_dev_desc = {
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
> +			| LPSS_NO_D3_DELAY,
> +	.prv_offset = 0x800,
> +};
> +
> +static struct lpss_device_desc bsw_lpt_i2c_dev_desc = {
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR | LPSS_NO_D3_DELAY,
> +	.prv_offset = 0x800,
> +};
> +
>  static struct lpss_device_desc lpt_i2c_dev_desc = {
>  	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
>  	.prv_offset = 0x800,
> @@ -146,18 +158,33 @@ static struct lpss_device_desc lpt_uart_dev_desc = {
>  	.setup = lpss_uart_setup,
>  };
>  
> +static struct lpss_device_desc bsw_lpt_uart_dev_desc = {
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
> +			| LPSS_NO_D3_DELAY,
> +	.clk_con_id = "baudclk",
> +	.prv_offset = 0x800,
> +	.setup = lpss_uart_setup,
> +};
> +
>  static struct lpss_device_desc lpt_sdio_dev_desc = {
>  	.flags = LPSS_LTR,
>  	.prv_offset = 0x1000,
>  	.prv_size_override = 0x1018,
>  };
>  
> +static struct lpss_device_desc bsw_lpt_sdio_dev_desc = {
> +	.flags = LPSS_LTR | LPSS_NO_D3_DELAY,
> +	.prv_offset = 0x1000,
> +	.prv_size_override = 0x1018,
> +};
> +
>  static struct lpss_device_desc byt_pwm_dev_desc = {
> -	.flags = LPSS_SAVE_CTX,
> +	.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
>  };
>  
>  static struct lpss_device_desc byt_uart_dev_desc = {
> -	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
> +			| LPSS_NO_D3_DELAY,
>  	.clk_con_id = "baudclk",
>  	.prv_offset = 0x800,
>  	.setup = lpss_uart_setup,
> @@ -173,13 +200,14 @@ static struct lpss_device_desc byt_sdio_dev_desc = {
>  };
>  
>  static struct lpss_device_desc byt_i2c_dev_desc = {
> -	.flags = LPSS_CLK | LPSS_SAVE_CTX,
> +	.flags = LPSS_CLK | LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
>  	.prv_offset = 0x800,
>  	.setup = byt_i2c_setup,
>  };
>  
>  static struct lpss_device_desc bsw_spi_dev_desc = {
> -	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX
> +			| LPSS_NO_D3_DELAY,
>  	.prv_offset = 0x400,
>  	.setup = lpss_deassert_reset,
>  };
> @@ -219,13 +247,13 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>  	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
>  	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
>  
> -	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
> -	{ "INT3431", LPSS_ADDR(lpt_dev_desc) },
> -	{ "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
> -	{ "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
> -	{ "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
> -	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
> -	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
> +	{ "INT3430", LPSS_ADDR(bsw_lpt_dev_desc) },
> +	{ "INT3431", LPSS_ADDR(bsw_lpt_dev_desc) },
> +	{ "INT3432", LPSS_ADDR(bsw_lpt_i2c_dev_desc) },
> +	{ "INT3433", LPSS_ADDR(bsw_lpt_i2c_dev_desc) },
> +	{ "INT3434", LPSS_ADDR(bsw_lpt_uart_dev_desc) },
> +	{ "INT3435", LPSS_ADDR(bsw_lpt_uart_dev_desc) },
> +	{ "INT3436", LPSS_ADDR(bsw_lpt_sdio_dev_desc) },

... these are Broadwell devices. Have you tested that this won't break
existing Broadwell systems?
