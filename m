From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH -next] ACPI/IORT: Fix the error return code in
 iort_add_smmu_platform_device()
Date: Mon, 6 Feb 2017 10:04:11 +0000
Message-ID: <20170206100411.GA12444@red-moon>
References: <20170205154559.31664-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbdBFKCJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Feb 2017 05:02:09 -0500
Content-Disposition: inline
In-Reply-To: <20170205154559.31664-1-weiyj.lk@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, rjw@rjwysocki.net
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

On Sun, Feb 05, 2017 at 03:45:59PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The error return code PTR_ERR(pdev) is always 0 since pdev is
> equal to 0 in this error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It has been reported twice already:

https://patchwork.kernel.org/patch/9521003/

Rafael, do you expect me to send you a pull request with IORT fixes ?

I can't see Dan's patch in linux-acpi patchwork anymore, and there
is another fix pending:

https://patchwork.kernel.org/patch/9507041/

Please let me know how you want to handle them.

Thanks !
Lorenzo

> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e..655407a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -828,7 +828,7 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  
>  	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
>  	if (!pdev)
> -		return PTR_ERR(pdev);
> +		return -ENOMEM;
>  
>  	count = ops->iommu_count_resources(node);


