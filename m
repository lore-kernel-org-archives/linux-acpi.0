From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] Display a DMA error message
Date: Fri, 14 Aug 2015 23:19:46 +0200
Message-ID: <2099290.n6l88bWDgg@wuerfel>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com> <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54721 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbHNVUp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2015 17:20:45 -0400
In-Reply-To: <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>, rafael.j.wysocki@intel.com, Catalin.Marinas@arm.com, linux-usb@vger.kernel.org, linux@prisktech.co.nz, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, suravee.suthikulpanit@amd.com

On Wednesday 12 August 2015 16:51:29 Jeremy Linton wrote:
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2593def..82e396f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>         err = dma_coerce_mask_and_coherent(&dev->dev,
>                 pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> -       if (err)
> +       if (err) {
> +               dev_err(&dev->dev, "Error: DMA setup failed\n");
>                 return err;
> +       }

We should really stop doing this: the platform should provide the
correct dma mask when creating the device, instead of setting a
bogus pdata field. Do not duplicate this bug for ACPI.

	Arnd
