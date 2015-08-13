From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/3] Display a DMA error message
Date: Thu, 13 Aug 2015 19:02:17 +0800
Message-ID: <55CC7939.7020800@huawei.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com> <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:17336 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbHMLDz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2015 07:03:55 -0400
In-Reply-To: <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, linux@prisktech.co.nz, suravee.suthikulpanit@amd.com, rafael.j.wysocki@intel.com, Catalin.Marinas@arm.com

On 2015/8/13 5:51, Jeremy Linton wrote:
> If the ehci driver fails to configure the dma settings then display
> a dev error instead of simply failing. This is triggered in an
> ACPI world if the user fails to set the _CCA on the device.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/usb/host/ehci-platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2593def..82e396f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  	err = dma_coerce_mask_and_coherent(&dev->dev,
>  		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> -	if (err)
> +	if (err) {
> +		dev_err(&dev->dev, "Error: DMA setup failed\n");
>  		return err;
> +	}
>  
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0) {

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

