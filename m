From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 09/12] gpio: acpi: Split out acpi_gpio_get_irq_resource() helper
Date: Tue, 23 May 2017 20:03:24 +0300
Message-ID: <20170523170327.18055-10-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The helper does retrieve pointer to struct acpi_resource_gpio from
struct acpi_resource if it represents GpioInt() resource.

It will be used by PNP code later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 23 ++++++++++++++++++-----
 include/linux/acpi.h        |  7 +++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index e431222edc2b..6bea176b066c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -165,6 +165,23 @@ static void acpi_gpio_chip_dh(acpi_handle handle, void *data)
 	/* The address of this function is used as a key. */
 }
 
+bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
+				struct acpi_resource_gpio **agpio)
+{
+	struct acpi_resource_gpio *gpio;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
+		return false;
+
+	gpio = &ares->data.gpio;
+	if (gpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
+		return false;
+
+	*agpio = gpio;
+	return true;
+}
+EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
+
 static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 						   void *context)
 {
@@ -178,11 +195,7 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 	unsigned long irqflags;
 	int ret, pin, irq;
 
-	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
-		return AE_OK;
-
-	agpio = &ares->data.gpio;
-	if (agpio->connection_type != ACPI_RESOURCE_GPIO_TYPE_INT)
+	if (!acpi_gpio_get_irq_resource(ares, &agpio))
 		return AE_OK;
 
 	handle = ACPI_HANDLE(chip->parent);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 137e4a3d89c5..d5aa3c42f64d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -964,6 +964,8 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,
 				   const struct acpi_gpio_mapping *gpios);
 void devm_acpi_dev_remove_driver_gpios(struct device *dev);
 
+bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
+				struct acpi_resource_gpio **agpio);
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
 #else
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
@@ -980,6 +982,11 @@ static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
 }
 static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev) {}
 
+static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
+					      struct acpi_resource_gpio **agpio)
+{
+	return false;
+}
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
 	return -ENXIO;
-- 
2.11.0
