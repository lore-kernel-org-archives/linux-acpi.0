From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI/IORT: Fix error handling
Date: Tue, 24 Jan 2017 09:26:37 +0800
Message-ID: <09887257-491f-8f9c-58bb-ae6a361f856f@linaro.org>
References: <20170123205008.10065-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170123205008.10065-1-christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Christophe,

On 2017/1/24 4:50, Christophe JAILLET wrote:
> If 'platform_device_alloc()' returns NULL, the current code returns
> 0, which means success. Return -ENOMEM instead.
>
> Fixes: 846f0e9e74a0 ("ACPI/IORT: Add support for ARM SMMU platform devices creation")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e6e40c..655407ad112e 100644
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

Thanks for the fix, but Dan beats you to this fix [1] :)

[1]: http://www.spinics.net/lists/linux-acpi/msg71383.html

Thanks
Hanjun
