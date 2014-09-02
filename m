From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/4] ACPI / LPSS: introduce flags
Date: Tue, 02 Sep 2014 11:45:30 +0300
Message-ID: <1409647530.30155.70.camel@linux.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
	 <1409644510-26397-2-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30581 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbaIBIpv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 04:45:51 -0400
In-Reply-To: <1409644510-26397-2-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Tue, 2014-09-02 at 10:55 +0300, Heikki Krogerus wrote:
> Replace the booleans with a single flags member variable.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>  drivers/acpi/acpi_lpss.c | 79 ++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 9dfec48..4723a0e 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -54,6 +54,13 @@ ACPI_MODULE_NAME("acpi_lpss");
>  
>  #define LPSS_PRV_REG_COUNT		9
>  
> +/* LPSS Flags */
> +#define LPSS_CLK			BIT(0)
> +#define LPSS_CLK_GATE			BIT(1)
> +#define LPSS_CLK_DIVIDER		BIT(2)
> +#define LPSS_LTR			BIT(3)
> +#define LPSS_SAVE_CTX			BIT(4)
> +
>  struct lpss_shared_clock {
>  	const char *name;
>  	unsigned long rate;
> @@ -63,21 +70,17 @@ struct lpss_shared_clock {
>  struct lpss_private_data;
>  
>  struct lpss_device_desc {
> -	bool clk_required;
>  	const char *clkdev_name;
> -	bool ltr_required;
> +	unsigned int flags;
>  	unsigned int prv_offset;
>  	size_t prv_size_override;
> -	bool clk_divider;
> -	bool clk_gate;
> -	bool save_ctx;
>  	struct lpss_shared_clock *shared_clock;
>  	void (*setup)(struct lpss_private_data *pdata);
>  };
>  
>  static struct lpss_device_desc lpss_dma_desc = {
> -	.clk_required = true,
>  	.clkdev_name = "hclk",
> +	.flags = LPSS_CLK,
>  };
>  
>  struct lpss_private_data {
> @@ -113,42 +116,26 @@ static void lpss_i2c_setup(struct lpss_private_data *pdata)
>  	writel(val, pdata->mmio_base + offset);
>  }
>  
> -static struct lpss_device_desc wpt_dev_desc = {
> -	.clk_required = true,
> -	.prv_offset = 0x800,
> -	.ltr_required = true,
> -	.clk_divider = true,
> -	.clk_gate = true,
> -};
> -
>  static struct lpss_device_desc lpt_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
>  	.prv_offset = 0x800,
> -	.ltr_required = true,
> -	.clk_divider = true,
> -	.clk_gate = true,
>  };
>  
>  static struct lpss_device_desc lpt_i2c_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
>  	.prv_offset = 0x800,
> -	.ltr_required = true,
> -	.clk_gate = true,
>  };
>  
>  static struct lpss_device_desc lpt_uart_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
>  	.prv_offset = 0x800,
> -	.ltr_required = true,
> -	.clk_divider = true,
> -	.clk_gate = true,
>  	.setup = lpss_uart_setup,
>  };
>  
>  static struct lpss_device_desc lpt_sdio_dev_desc = {
> +	.flags = LPSS_LTR,
>  	.prv_offset = 0x1000,
>  	.prv_size_override = 0x1018,
> -	.ltr_required = true,
>  };
>  
>  static struct lpss_shared_clock pwm_clock = {
> @@ -157,30 +144,23 @@ static struct lpss_shared_clock pwm_clock = {
>  };
>  
>  static struct lpss_device_desc byt_pwm_dev_desc = {
> -	.clk_required = true,
> -	.save_ctx = true,
> +	.flags = LPSS_CLK | LPSS_SAVE_CTX,
>  	.shared_clock = &pwm_clock,
>  };
>  
>  static struct lpss_device_desc byt_uart_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
>  	.prv_offset = 0x800,
> -	.clk_divider = true,
> -	.clk_gate = true,
> -	.save_ctx = true,
>  	.setup = lpss_uart_setup,
>  };
>  
>  static struct lpss_device_desc byt_spi_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_SAVE_CTX,
>  	.prv_offset = 0x400,
> -	.clk_divider = true,
> -	.clk_gate = true,
> -	.save_ctx = true,
>  };
>  
>  static struct lpss_device_desc byt_sdio_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK,
>  };
>  
>  static struct lpss_shared_clock i2c_clock = {
> @@ -189,9 +169,8 @@ static struct lpss_shared_clock i2c_clock = {
>  };
>  
>  static struct lpss_device_desc byt_i2c_dev_desc = {
> -	.clk_required = true,
> +	.flags = LPSS_CLK | LPSS_SAVE_CTX,
>  	.prv_offset = 0x800,
> -	.save_ctx = true,
>  	.shared_clock = &i2c_clock,
>  	.setup = lpss_i2c_setup,
>  };
> @@ -202,8 +181,7 @@ static struct lpss_shared_clock bsw_pwm_clock = {
>  };
>  
>  static struct lpss_device_desc bsw_pwm_dev_desc = {
> -	.clk_required = true,
> -	.save_ctx = true,
> +	.flags = LPSS_CLK | LPSS_SAVE_CTX,
>  	.shared_clock = &bsw_pwm_clock,
>  };
>  
> @@ -251,7 +229,8 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>  	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
>  	{ "INT3437", },
>  
> -	{ "INT3438", LPSS_ADDR(wpt_dev_desc) },
> +	/* Wildcat Point LPSS devices */
> +	{ "INT3438", LPSS_ADDR(lpt_dev_desc) },
>  
>  	{ }
>  };
> @@ -314,13 +293,13 @@ static int register_device_clock(struct acpi_device *adev,
>  		parent = shared_clock->name;
>  	}
>  
> -	if (dev_desc->clk_gate) {
> +	if (dev_desc->flags & LPSS_CLK_GATE) {
>  		clk = clk_register_gate(NULL, devname, parent, 0,
>  					prv_base, 0, 0, NULL);
>  		parent = devname;
>  	}
>  
> -	if (dev_desc->clk_divider) {
> +	if (dev_desc->flags & LPSS_CLK_DIVIDER) {
>  		/* Prevent division by zero */
>  		if (!readl(prv_base))
>  			writel(LPSS_CLK_DIVIDER_DEF_MASK, prv_base);
> @@ -392,7 +371,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>  
>  	pdata->dev_desc = dev_desc;
>  
> -	if (dev_desc->clk_required) {
> +	if (dev_desc->flags & LPSS_CLK) {
>  		ret = register_device_clock(adev, pdata);
>  		if (ret) {
>  			/* Skip the device, but continue the namespace scan. */
> @@ -693,19 +672,19 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
>  
>  	switch (action) {
>  	case BUS_NOTIFY_BOUND_DRIVER:
> -		if (pdata->dev_desc->save_ctx)
> +		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>  			pdev->dev.pm_domain = &acpi_lpss_pm_domain;
>  		break;
>  	case BUS_NOTIFY_UNBOUND_DRIVER:
> -		if (pdata->dev_desc->save_ctx)
> +		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
>  			pdev->dev.pm_domain = NULL;
>  		break;
>  	case BUS_NOTIFY_ADD_DEVICE:
> -		if (pdata->dev_desc->ltr_required)
> +		if (pdata->dev_desc->flags & LPSS_LTR)
>  			return sysfs_create_group(&pdev->dev.kobj,
>  						  &lpss_attr_group);
>  	case BUS_NOTIFY_DEL_DEVICE:
> -		if (pdata->dev_desc->ltr_required)
> +		if (pdata->dev_desc->flags & LPSS_LTR)
>  			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
>  	default:
>  		break;
> @@ -722,7 +701,7 @@ static void acpi_lpss_bind(struct device *dev)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>  
> -	if (!pdata || !pdata->mmio_base || !pdata->dev_desc->ltr_required)
> +	if (!pdata || !pdata->mmio_base || !(pdata->dev_desc->flags & LPSS_LTR))
>  		return;
>  
>  	if (pdata->mmio_size >= pdata->dev_desc->prv_offset + LPSS_LTR_SIZE)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

