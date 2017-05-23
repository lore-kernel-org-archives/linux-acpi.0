From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/12] gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
Date: Tue, 23 May 2017 20:03:18 +0300
Message-ID: <20170523170327.18055-4-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17199 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761453AbdEWREN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 13:04:13 -0400
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Check that we don't ask for output direction on GpioInt resource
in cases with or without _DSD defined.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 055a8a255a40..28f35a9de86b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -622,12 +622,12 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
 		if (IS_ERR(desc))
 			return desc;
+	}
 
-		if ((flags == GPIOD_OUT_LOW || flags == GPIOD_OUT_HIGH) &&
-		    info.gpioint) {
-			dev_dbg(dev, "refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
-			return ERR_PTR(-ENOENT);
-		}
+	if (info.gpioint &&
+	    (flags == GPIOD_OUT_LOW || flags == GPIOD_OUT_HIGH)) {
+		dev_dbg(dev, "refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
+		return ERR_PTR(-ENOENT);
 	}
 
 	if (info.polarity == GPIO_ACTIVE_LOW)
-- 
2.11.0

