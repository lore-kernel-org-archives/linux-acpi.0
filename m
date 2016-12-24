From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: Remove misplaced acpi_dma_deconfigure() call in
 acpi_bind_one()
Date: Sat, 24 Dec 2016 15:46:56 +0800
Message-ID: <585E27F0.6070703@huawei.com>
References: <20161216144356.24628-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:12035 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcLXHrN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Dec 2016 02:47:13 -0500
In-Reply-To: <20161216144356.24628-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 2016/12/16 22:43, Lorenzo Pieralisi wrote:
> The acpi_bind_one() error return path can be hit either on physical node
> allocation failure or if the device being configured is already
> associated with an ACPI node and its ACPI companion does not match the
> one acpi_bind_one() is setting it up with. In both cases the error
> return path is executed before DMA is configured for a device therefore
> there is no need to call acpi_dma_deconfigure() on the function error
> return path.
>
> Furthermore, if acpi_bind_one() does configure DMA for a device (ie it
> successfully executes acpi_dma_configure()) acpi_bind_one() always
> completes execution successfully hence there is no need to add an exit
> path to deconfigure the DMA set-up (ie by calling acpi_dma_deconfigure()).
>
> Remove the misplaced acpi_dma_deconfigure() in acpi_bind_one() to
> reinstate its correct error return path behaviour.
>
> Fixes: d760a1baf20e ("ACPI: Implement acpi_dma_configure")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/glue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index f8d6564..eb709e7 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -250,7 +250,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	return 0;
>  
>   err:
> -	acpi_dma_deconfigure(dev);
>  	ACPI_COMPANION_SET(dev, NULL);
>  	put_device(dev);
>  	put_device(&acpi_dev->dev);

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

