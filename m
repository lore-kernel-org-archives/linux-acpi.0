From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/8] gpio: acpi: Do sanity check for GpioInt in acpi_find_gpio()
Date: Thu, 23 Mar 2017 21:46:13 +0200
Message-ID: <20170323194618.26548-4-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Check that we don't ask for output direction on GpioInt resource in cases with
or without _DSD defined.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 3bda3166d418..21e4930ca2db 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -614,12 +614,12 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
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

