From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] ACPI / LPSS: drop clkdev_name member from
 lpss_device_desc
Date: Tue, 02 Sep 2014 11:43:16 +0300
Message-ID: <1409647396.30155.69.camel@linux.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
	 <1409644510-26397-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30200 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbaIBInT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 04:43:19 -0400
In-Reply-To: <1409644510-26397-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Tue, 2014-09-02 at 10:55 +0300, Heikki Krogerus wrote:
> It was used to provide the correct con_id for the dma
> driver, but it's not needed. Even if the driver requests a
> clock with the con_id, it still gets the correct clock. The

Maybe with -> without?

> device name is enough to match a single clock.

Since it affects DW DMA driver
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 4723a0e..db3498b 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -70,7 +70,6 @@ struct lpss_shared_clock {
>  struct lpss_private_data;
>  
>  struct lpss_device_desc {
> -	const char *clkdev_name;
>  	unsigned int flags;
>  	unsigned int prv_offset;
>  	size_t prv_size_override;
> @@ -79,7 +78,6 @@ struct lpss_device_desc {
>  };
>  
>  static struct lpss_device_desc lpss_dma_desc = {
> -	.clkdev_name = "hclk",
>  	.flags = LPSS_CLK,
>  };
>  
> @@ -268,12 +266,7 @@ static int register_device_clock(struct acpi_device *adev,
>  	clk_data = platform_get_drvdata(lpss_clk_dev);
>  	if (!clk_data)
>  		return -ENODEV;
> -
> -	if (dev_desc->clkdev_name) {
> -		clk_register_clkdev(clk_data->clk, dev_desc->clkdev_name,
> -				    devname);
> -		return 0;
> -	}
> +	clk = clk_data->clk;
>  
>  	if (!pdata->mmio_base
>  	    || pdata->mmio_size < dev_desc->prv_offset + LPSS_CLK_SIZE)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

