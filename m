From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 13/25] coresight: etb10: Clean up device specific data
Date: Wed, 27 Mar 2019 15:39:03 -0600
Message-ID: <20190327213903.GA778@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553107783-3340-14-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:30PM +0000, Suzuki K Poulose wrote:
> Track the coresight device instead of the real device.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 105782e..a471cbd 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -97,12 +97,12 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
>  {
>  	u32 depth = 0;
>  
> -	pm_runtime_get_sync(drvdata->dev);
> +	pm_runtime_get_sync(drvdata->dev->parent);
>  
>  	/* RO registers don't need locking */
>  	depth = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
>  
> -	pm_runtime_put(drvdata->dev);
> +	pm_runtime_put(drvdata->dev->parent);
>  	return depth;
>  }
>  
> @@ -701,7 +701,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->dev = &adev->dev;
>  	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>  	if (!IS_ERR(drvdata->atclk)) {
>  		ret = clk_prepare_enable(drvdata->atclk);
> @@ -740,6 +739,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(drvdata->csdev))
>  		return PTR_ERR(drvdata->csdev);
>  
> +	drvdata->dev = &drvdata->csdev->dev;

For patch 11, 12, 13 - same comment as earlier.  Let's use drvdata::csdev
and get rid of drvdata::dev.

>  	drvdata->miscdev.name = pdata->name;
>  	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	drvdata->miscdev.fops = &etb_fops;
> -- 
> 2.7.4
> 
