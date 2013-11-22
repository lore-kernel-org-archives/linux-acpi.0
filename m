From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 3/7] net: rfkill: gpio: remove gpio conversion support
Date: Fri, 22 Nov 2013 14:14:30 +0200
Message-ID: <1385122474-14926-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385122474-14926-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Johannes Berg <johannes@sipsolutions.net>, Rhyland Klein <rklein@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Rob Landley <rob@landley.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

All platforms using this driver are now converted to the new
descriptor-based GPIO interface.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 61 ++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 503432154616..bd2a5b90400c 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -68,35 +68,6 @@ static const struct rfkill_ops rfkill_gpio_ops = {
 	.set_block = rfkill_gpio_set_power,
 };
 
-static int rfkill_gpio_convert_to_desc(struct platform_device *pdev,
-				       struct rfkill_gpio_data *rfkill)
-{
-	struct rfkill_gpio_platform_data *pdata = pdev->dev.platform_data;
-	int ret;
-
-	if (gpio_is_valid(pdata->reset_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, pdata->reset_gpio,
-					    0, rfkill->reset_name);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get reset gpio.\n");
-			return ret;
-		}
-		rfkill->reset_gpio = gpio_to_desc(pdata->reset_gpio);
-	}
-
-	if (gpio_is_valid(pdata->shutdown_gpio)) {
-		ret = devm_gpio_request_one(&pdev->dev, pdata->shutdown_gpio,
-					    0, rfkill->shutdown_name);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get shutdown gpio.\n");
-			return ret;
-		}
-		rfkill->shutdown_gpio = gpio_to_desc(pdata->shutdown_gpio);
-	}
-
-	return 0;
-}
-
 static int rfkill_gpio_acpi_probe(struct device *dev,
 				  struct rfkill_gpio_data *rfkill)
 {
@@ -117,6 +88,7 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	struct rfkill_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct rfkill_gpio_data *rfkill;
 	const char *clk_name = NULL;
+	struct gpio_desc *gpio;
 	int ret;
 	int len;
 
@@ -150,29 +122,20 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	rfkill->clk = devm_clk_get(&pdev->dev, clk_name);
 
-	if (pdata && (pdata->reset_gpio || pdata->shutdown_gpio)) {
-		ret = rfkill_gpio_convert_to_desc(pdev, rfkill);
+	gpio = devm_gpiod_get_index(&pdev->dev, rfkill->reset_name, 0);
+	if (!IS_ERR(gpio)) {
+		ret = gpiod_direction_output(gpio, 0);
 		if (ret)
 			return ret;
-	} else {
-		struct gpio_desc *gpio;
-
-		gpio = devm_gpiod_get_index(&pdev->dev, rfkill->reset_name, 0);
-		if (!IS_ERR(gpio)) {
-			ret = gpiod_direction_output(gpio, 0);
-			if (ret)
-				return ret;
-			rfkill->reset_gpio = gpio;
-		}
+		rfkill->reset_gpio = gpio;
+	}
 
-		gpio = devm_gpiod_get_index(&pdev->dev,
-					    rfkill->shutdown_name, 1);
-		if (!IS_ERR(gpio)) {
-			ret = gpiod_direction_output(gpio, 0);
-			if (ret)
-				return ret;
-			rfkill->shutdown_gpio = gpio;
-		}
+	gpio = devm_gpiod_get_index(&pdev->dev, rfkill->shutdown_name, 1);
+	if (!IS_ERR(gpio)) {
+		ret = gpiod_direction_output(gpio, 0);
+		if (ret)
+			return ret;
+		rfkill->shutdown_gpio = gpio;
 	}
 
 	/* Make sure at-least one of the GPIO is defined and that
-- 
1.8.4.3
