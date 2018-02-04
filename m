From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/6] dmaengine: hidma: Constify returned by
 device_get_match_data() value
Date: Sun, 04 Feb 2018 16:06:55 +0200
Message-ID: <1517753215.7000.1505.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42786 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeBDOG6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 4 Feb 2018 09:06:58 -0500
In-Reply-To: <20180201202012.36524-5-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-01 at 22:20 +0200, Andy Shevchenko wrote:
> The value under the hood is constant in any case.
> It makes sense to show this explicitly.
> 

This patch is wrong, sorry.

> Fixes: 95fbfb7aa28d ("dmaengine: qcom_hidma: Add support for the new
> revision")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/qcom/hidma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 963cc5228d05..24e163cefb7c 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -743,9 +743,9 @@ static int hidma_request_msi(struct hidma_dev
> *dmadev,
>  
>  static bool hidma_test_capability(struct device *dev, enum hidma_cap
> test_cap)
>  {
> -	enum hidma_cap cap;
> +	const enum hidma_cap cap;
>  
> -	cap = (enum hidma_cap) device_get_match_data(dev);
> +	cap = (const enum hidma_cap) device_get_match_data(dev);
>  	return cap ? ((cap & test_cap) > 0) : 0;
>  }
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
