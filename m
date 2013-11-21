From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/5] net: rfkill: gpio: convert to descriptor-based GPIO
 interface
Date: Thu, 21 Nov 2013 17:24:25 +0200
Message-ID: <20131121152425.GA5557@xps8300>
References: <1385045153-25160-1-git-send-email-mika.westerberg@linux.intel.com>
 <1385045153-25160-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385045153-25160-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rhyland,

On Thu, Nov 21, 2013 at 04:45:49PM +0200, Mika Westerberg wrote:
> +static int rfkill_gpio_convert_to_desc(struct platform_device *pdev,
> +				       struct rfkill_gpio_data *rfkill)
> +{
> +	struct rfkill_gpio_platform_data *pdata = pdev->dev.platform_data;
> +	int ret = 0;
> +
> +	if (gpio_is_valid(pdata->reset_gpio)) {
> +		ret = devm_gpio_request_one(&pdev->dev, pdata->reset_gpio,
> +					    0, rfkill->reset_name);
> +		if (ret) {
> +			pr_warn("%s: failed to get reset gpio.\n", __func__);
> +			return ret;
> +		}
> +		rfkill->reset_gpio = gpio_to_desc(pdata->reset_gpio);
> +	}
> +
> +	if (gpio_is_valid(pdata->shutdown_gpio)) {
> +		ret = devm_gpio_request_one(&pdev->dev, pdata->shutdown_gpio,
> +					    0, rfkill->shutdown_name);
> +		if (ret) {
> +			pr_warn("%s: failed to get shutdown gpio.\n", __func__);
> +			return ret;
> +		}
> +		rfkill->shutdown_gpio = gpio_to_desc(pdata->shutdown_gpio);
> +	}
> +
> +	return 0;
> +}

We could drop this conversion if you guys added gpiod_lookup table to
your platform code. I think something like this is enough. Please note
that I have not even tried compile it but you get the idea from it.

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 06f0240..19bce88 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -18,13 +18,12 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/gpio/driver.h>
 #include <linux/rfkill-gpio.h>
 #include "board.h"
 
 static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
        .name           = "wifi_rfkill",
-       .reset_gpio     = 25, /* PD1 */
-       .shutdown_gpio  = 85, /* PK5 */
        .type   = RFKILL_TYPE_WLAN,
 };
 
@@ -36,7 +35,13 @@ static struct platform_device wifi_rfkill_device = {
        },
 };
 
+static struct gpiod_lookup wifi_gpio_lookup[] = {
+       GPIO_LOOKUP_IDX("tegra-gpio", 25, "rfkill_gpio", NULL, 0, NULL),
+       GPIO_LOOKUP_IDX("tegra-gpio", 85, "rfkill_gpio", NULL, 1, NULL),
+};
+
 void __init tegra_paz00_wifikill_init(void)
 {
+       gpiod_add_table(wifi_lookup, ARRAY_SIZE(wifi_gpio_lookup));
        platform_device_register(&wifi_rfkill_device);
 }


-- 
heikki
