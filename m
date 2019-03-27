From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 15/25] coresight: etm3x: Rearrange cp14 access detection
Date: Wed, 27 Mar 2019 16:05:59 -0600
Message-ID: <20190327220559.GB778@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:32PM +0000, Suzuki K Poulose wrote:
> As we are about to about refactor the platform specific handling,

s/about//

> move the DT property handling to generic helpers.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 1b9ae3a..7137f06 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -800,9 +800,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  			return PTR_ERR(pdata);
>  
>  		adev->dev.platform_data = pdata;
> -		drvdata->use_cp14 = of_property_read_bool(np, "arm,cp14");
>  	}
>  
> +	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
>  	dev_set_drvdata(dev, drvdata);
>  
>  	/* Validity for the resource is already checked by the AMBA core */
> -- 
> 2.7.4
> 
