From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI / LPSS: Make condition local to lpt_register_clock_device
Date: Tue, 26 Mar 2013 14:37:25 +0100
Message-ID: <1573535.APTRRvZTSj@vostro.rjw.lan>
References: <1363781670-28775-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43095 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933705Ab3CZN37 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:29:59 -0400
In-Reply-To: <1363781670-28775-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wednesday, March 20, 2013 02:14:29 PM Andy Shevchenko wrote:
> It seems more logical to have the check of lpss_clk_dev variable in
> lpt_register_clock_device() because last one actually assignes the variable.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Actually, I came to the opposite conclusion when I was working on the code
in question. :-)

Not applied.

Thanks,
Rafael


> ---
>  drivers/acpi/acpi_lpss.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c87db0e..c695841 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -84,6 +84,9 @@ static struct platform_device *lpss_clk_dev;
>  
>  static inline void lpt_register_clock_device(void)
>  {
> +	if (lpss_clk_dev)
> +		return;
> +
>  	lpss_clk_dev = platform_device_register_simple("clk-lpt", -1, NULL, 0);
>  }
>  
> @@ -92,8 +95,7 @@ static int register_device_clock(struct acpi_device *adev,
>  {
>  	const struct lpss_device_desc *dev_desc = pdata->dev_desc;
>  
> -	if (!lpss_clk_dev)
> -		lpt_register_clock_device();
> +	lpt_register_clock_device();
>  
>  	if (!dev_desc->clk_parent || !pdata->mmio_base
>  	    || pdata->mmio_size < dev_desc->prv_offset + LPSS_CLK_SIZE)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
