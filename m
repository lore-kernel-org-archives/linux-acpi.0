From: Jiandi An <anjiandi@codeaurora.org>
Subject: Re: [PATCH v2] ACPI : Update platform device numa node based on _PXM
 method
Date: Fri, 14 Apr 2017 17:42:23 -0500
Message-ID: <5e24c684-d460-7522-35e4-2bceb9ef35d1@codeaurora.org>
References: <1490787559-15722-1-git-send-email-shankerd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdDNWm0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2017 18:42:26 -0400
In-Reply-To: <1490787559-15722-1-git-send-email-shankerd@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shanker Donthineni <shankerd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Viram Sethi <vikrams@codeaurora.org>


On 03/29/2017 06:39 AM, Shanker Donthineni wrote:
> The optional _PXM method evaluates to an integer that identifies the
> proximity domain of a device object. On ACPI based kernel boot, the
> field numa_node in 'struct device' is always set to -1 irrespective
> of _PXM value that is specified in the ACPI device object. But in
> case of device-tree based kernel boot the numa_node field is populated
> and reflects to a DT property that is specified in DTS according to
> the below document.
>
> https://www.kernel.org/doc/Documentation/devicetree/bindings/numa.txt
> http://lxr.free-electrons.com/source/drivers/of/device.c#L54
>
> Without this patch dev_to_node() always returns a value of -1 for all
> platform devices. This patch implements support for ACPI _PXM method
> and updates the platform device numa node id using acpi_get_node(),
> which provides the PXM to NUMA mapping information. The individual
> platform device drivers should be able to use the NUMA aware memory
> allocation functions kmalloc_node() and alloc_pages_node() to improve
> the performance.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

Tested-by: Jiandi An <anjiandi@codeaurora.org>

> ---
> Changes since v1: Edited commit text.
>
> Not all the platform devices are attached to NUMA node 0 on Qualcomm
> Datacenter Technologies server chips. Platform device drivers needs
> to be aware of NUMA information to improve performance.
>
>  drivers/acpi/acpi_platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index b4c1a6a..83d953e 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -119,11 +119,14 @@ struct platform_device
> *acpi_create_platform_device(struct acpi_device *adev,
>  	if (IS_ERR(pdev))
>  		dev_err(&adev->dev, "platform device creation failed:
> %ld\n",
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

-- 
Jiandi An
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
