From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 23/25] coresight: stm: ACPI support for parsing stimulus
 base
Date: Thu, 28 Mar 2019 14:41:51 -0600
Message-ID: <20190328204151.GA7163@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:40PM +0000, Suzuki K Poulose wrote:
> The stimulus base for STM device must be listed as the second memory
> resource, followed by the programming base address. Add support for
> parsing the information for ACPI.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index d94ae22..995443a 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -16,6 +16,7 @@
>   * (C) 2015-2016 Chunyan Zhang <zhang.chunyan@linaro.org>
>   */
>  #include <asm/local.h>
> +#include <linux/acpi.h>
>  #include <linux/amba/bus.h>
>  #include <linux/bitmap.h>
>  #include <linux/clk.h>
> @@ -717,10 +718,52 @@ static inline int of_stm_get_stimulus_area(struct device *dev,
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
> +{
> +	int rc;
> +	bool found_base = false;
> +	struct resource_entry *rent;
> +	LIST_HEAD(res_list);
> +
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return -ENODEV;
> +	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = -ENOENT;
> +	list_for_each_entry(rent, &res_list, node) {
> +		if (resource_type(rent->res) != IORESOURCE_MEM)
> +			continue;
> +		if (found_base) {
> +			*res = *rent->res;
> +			rc = 0;
> +			break;
> +		}
> +
> +		found_base = true;

Is the ACPI binding crystal clear on the fact that the second resource region
has to be for stimulus ports?

> +	}
> +
> +	acpi_dev_free_resource_list(&res_list);
> +	return rc;
> +}
> +#else
> +static inline int acpi_stm_get_stimulus_area(struct device *dev,
> +					     struct resource *res)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +
>  static int stm_get_stimulus_area(struct device *dev, struct resource *res)
>  {
>  	if (dev->of_node)

Wouldn't it be better to use is_of_node()?

>  		return of_stm_get_stimulus_area(dev, res);
> +	else if (is_acpi_node(dev->fwnode)

is_acpi_device_node()?

> +		return acpi_stm_get_stimulus_area(dev, res);
>  	return -ENOENT;
>  }
>  
> -- 
> 2.7.4
> 
