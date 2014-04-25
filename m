From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI / LPSS: Support for fractional divider clock
Date: Fri, 25 Apr 2014 16:44:14 +0300
Message-ID: <1398433454.11914.268.camel@smile.fi.intel.com>
References: <1398428541-912-1-git-send-email-heikki.krogerus@linux.intel.com>
	 <1398428541-912-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46601 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbaDYNo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Apr 2014 09:44:26 -0400
In-Reply-To: <1398428541-912-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mturquette@linaro.org>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, Loic Poulain <loic.poulain@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2014-04-25 at 15:22 +0300, Heikki Krogerus wrote:
> The dividers are available for UART and SPI on both
> Lynxpoint and Baytrail. With SPI, handling the dividers is
> optional, but in case of UART they should be adjusted
> according to the requested baud rate.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 69e29f4..508ac9f 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -58,6 +58,7 @@ struct lpss_device_desc {
>  	unsigned int prv_offset;
>  	size_t prv_size_override;
>  	bool clk_gate;
> +	bool clk_divider;
>  	struct lpss_shared_clock *shared_clock;
>  	void (*setup)(struct lpss_private_data *pdata);
>  };
> @@ -119,16 +120,11 @@ static struct lpss_device_desc byt_pwm_dev_desc = {
>  	.shared_clock = &pwm_clock,
>  };
>  
> -static struct lpss_shared_clock uart_clock = {
> -	.name = "uart_clk",
> -	.rate = 44236800,
> -};
> -
>  static struct lpss_device_desc byt_uart_dev_desc = {
>  	.clk_required = true,
>  	.prv_offset = 0x800,
>  	.clk_gate = true,
> -	.shared_clock = &uart_clock,
> +	.clk_divider = true,
>  	.setup = lpss_uart_setup,
>  };
>  
> @@ -246,8 +242,35 @@ static int register_device_clock(struct acpi_device *adev,
>  		parent = shared_clock->name;
>  	}
>  
> +	if (dev_desc->clk_divider) {
> +		char *name = kzalloc(strlen(dev_name(&adev->dev)) + 8,
> +				     GFP_KERNEL);
> +		if (!name)
> +			return -ENOMEM;
> +		strcpy(name, "div_clk-");
> +		strcat(name, dev_name(&adev->dev));

Just kasprintf() instead of a few LOCs?

> +
> +		clk = clk_register_fractional_divider(NULL, name, parent, 0,
> +					pdata->mmio_base + dev_desc->prv_offset,
> +					1, 15, 16, 15, 0, NULL);
> +		parent = name;
> +
> +		name = kzalloc(strlen(dev_name(&adev->dev)) + 11, GFP_KERNEL);
> +		if (!name)
> +			return -ENOMEM;
> +		strcpy(name, "clk_update-");
> +		strcat(name, dev_name(&adev->dev));

Ditto.

> +
> +		clk = clk_register_gate(NULL, name, parent,
> +					CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
> +					pdata->mmio_base + dev_desc->prv_offset,
> +					31, 0, NULL);
> +		parent = name;
> +	}
> +
>  	if (dev_desc->clk_gate) {
> -		clk = clk_register_gate(NULL, dev_name(&adev->dev), parent, 0,
> +		clk = clk_register_gate(NULL, dev_name(&adev->dev), parent,
> +					CLK_SET_RATE_PARENT,
>  					pdata->mmio_base + dev_desc->prv_offset,
>  					0, 0, NULL);
>  		pdata->clk = clk;


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

