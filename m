From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI : Update platform device numa node based on _PXM method
Date: Tue, 28 Mar 2017 23:43:12 +0200
Message-ID: <1932728.uFK6bUjlgv@aspire.rjw.lan>
References: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43557 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754318AbdC1Vsz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 17:48:55 -0400
In-Reply-To: <1490108070-24061-1-git-send-email-shankerd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vikram Sethi <vikrams@codeaurora.org>

On Tuesday, March 21, 2017 09:54:30 AM Shanker Donthineni wrote:
> The optional _PXM method evaluates to an integer that identifies the
> proximity domain of a device object. This patch implements support for
> ACPI _PXM method and updates the platform device numa node id using
> acpi_get_node(), which provides the PXM to NUMA mapping information.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

What exactly is the motivation here?

> ---
>  drivers/acpi/acpi_platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index b4c1a6a..83d953e 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -119,11 +119,14 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>  	if (IS_ERR(pdev))
>  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
>  			PTR_ERR(pdev));
> -	else
> +	else {
> +		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
>  		dev_dbg(&adev->dev, "created platform device %s\n",
>  			dev_name(&pdev->dev));
> +	}
>  
>  	kfree(resources);
> +
>  	return pdev;
>  }
>  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
> 

