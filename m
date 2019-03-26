From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 10/25] coresight: tpiu: Clean up device specific data
Date: Tue, 26 Mar 2019 15:54:40 -0600
Message-ID: <20190326215440.GB1658@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553107783-3340-11-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:27PM +0000, Suzuki K Poulose wrote:
> Switch to using the coresight device instead of the parent
> amba device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index b2f72a1..9763721 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -48,15 +48,13 @@
>  
>  /**
>   * @base:	memory mapped base address for this component.
> - * @dev:	the device entity associated to this component.
> + * @dev:	the coresight device entity associated to this component.
>   * @atclk:	optional clock for the core parts of the TPIU.
> - * @csdev:	component vitals needed by the framework.
>   */
>  struct tpiu_drvdata {
>  	void __iomem		*base;
>  	struct device		*dev;
>  	struct clk		*atclk;
> -	struct coresight_device	*csdev;

Here again I would get rid of @dev rather than @csdev to be consistent with what
was done previously.

Mathieu

>  };
>  
>  static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
> @@ -121,6 +119,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct tpiu_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> +	struct coresight_device *csdev;
>  	struct device_node *np = adev->dev.of_node;
>  
>  	if (np) {
> @@ -134,7 +133,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> @@ -160,9 +158,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &tpiu_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	drvdata->csdev = coresight_register(&desc);
> +	csdev = coresight_register(&desc);
> +	if (!IS_ERR(csdev))
> +		drvdata->dev = &csdev->dev;
>  
> -	return PTR_ERR_OR_ZERO(drvdata->csdev);
> +	return PTR_ERR_OR_ZERO(csdev);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.7.4
> 
