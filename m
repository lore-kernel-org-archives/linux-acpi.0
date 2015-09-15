From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-dma: Use ACPI_COMPANION() instead of acpi_bus_get_device()
Date: Tue, 15 Sep 2015 02:18:32 +0200
Message-ID: <20340602.Zly2mnObfT@vostro.rjw.lan>
References: <1441372350-11630-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56096 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751617AbbINXug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2015 19:50:36 -0400
In-Reply-To: <1441372350-11630-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-acpi@vger.kernel.org

On Friday, September 04, 2015 04:12:30 PM Jarkko Nikula wrote:
> Get pointer to the struct acpi_device by using ACPI_COMPANION() macro. This
> is more efficient than using ACPI_HANDLE() and acpi_bus_get_device().
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/dma/acpi-dma.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
> index 5a635646e05c..04257432c482 100644
> --- a/drivers/dma/acpi-dma.c
> +++ b/drivers/dma/acpi-dma.c
> @@ -160,10 +160,8 @@ int acpi_dma_controller_register(struct device *dev,
>  		return -EINVAL;
>  
>  	/* Check if the device was enumerated by ACPI */
> -	if (!ACPI_HANDLE(dev))
> -		return -EINVAL;
> -
> -	if (acpi_bus_get_device(ACPI_HANDLE(dev), &adev))
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
>  		return -EINVAL;
>  
>  	adma = kzalloc(sizeof(*adma), GFP_KERNEL);
> @@ -358,10 +356,11 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
>  	int found;
>  
>  	/* Check if the device was enumerated by ACPI */
> -	if (!dev || !ACPI_HANDLE(dev))
> +	if (!dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (acpi_bus_get_device(ACPI_HANDLE(dev), &adev))
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
>  		return ERR_PTR(-ENODEV);
>  
>  	memset(&pdata, 0, sizeof(pdata));
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
