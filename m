From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4/7] gpio: acpi: Fixup kerneldoc
Date: Mon, 24 Jul 2017 16:57:25 +0200
Message-ID: <20170724145728.7662-4-thierry.reding@gmail.com>
References: <20170724145728.7662-1-thierry.reding@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34841 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756333AbdGXO5g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 10:57:36 -0400
In-Reply-To: <20170724145728.7662-1-thierry.reding@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Fix up a parameter description to match the code and fix markup for a
constant to prettify output.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c9b42dd12dfa..4d2113530735 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -61,7 +61,7 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 #ifdef CONFIG_PINCTRL
 /**
  * acpi_gpiochip_pin_to_gpio_offset() - translates ACPI GPIO to Linux GPIO
- * @chip: GPIO chip
+ * @gdev: GPIO device
  * @pin: ACPI GPIO pin number from GpioIo/GpioInt resource
  *
  * Function takes ACPI GpioIo/GpioInt pin number as a parameter and
@@ -763,7 +763,7 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * The function is idempotent, though each time it runs it will configure GPIO
  * pin direction according to the flags in GpioInt resource.
  *
- * Return: Linux IRQ number (>%0) on success, negative errno on failure.
+ * Return: Linux IRQ number (> %0) on success, negative errno on failure.
  */
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
-- 
2.13.3

