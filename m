From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] gpio / ACPI: return -ENOENT when no mapping exists
Date: Tue, 10 Dec 2013 12:00:27 +0200
Message-ID: <1386669627-31365-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alex Courbot <acourbot@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Doing this allows drivers to distinguish between a real error case (if
there was an error when we tried to resolve the GPIO) and when the optional
GPIO line was not available.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 8506e4ce41f7..716ee9843110 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -307,7 +307,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct device *dev, int index,
 	if (lookup.desc && info)
 		*info = lookup.info;
 
-	return lookup.desc ? lookup.desc : ERR_PTR(-ENODEV);
+	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
 }
 
 void acpi_gpiochip_add(struct gpio_chip *chip)
-- 
1.8.5.1

