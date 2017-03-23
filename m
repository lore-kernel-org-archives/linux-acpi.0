From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/8] gpio: acpi: Factor out acpi_gpio_to_gpiod_flags() helper
Date: Thu, 23 Mar 2017 21:46:17 +0200
Message-ID: <20170323194618.26548-8-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

The helper function acpi_gpio_to_gpiod_flags() will be used later to configure
pin properly whenever it's requested.

While here, introduce a checking error code returned by gpiod_configure_flags()
and bail out if it's not okay.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 61 ++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 61518273e360..d4de84670c5b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -417,6 +417,31 @@ static bool acpi_get_driver_gpio_data(struct acpi_device *adev,
 	return false;
 }
 
+static enum gpiod_flags
+acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio)
+{
+	bool pull_up = agpio->pin_config == ACPI_PIN_CONFIG_PULLUP;
+
+	switch (agpio->io_restriction) {
+	case ACPI_IO_RESTRICT_INPUT:
+		return GPIOD_IN;
+	case ACPI_IO_RESTRICT_OUTPUT:
+		/*
+		 * ACPI GPIO resources don't contain an initial value for the
+		 * GPIO. Therefore we deduce that value from the pull field
+		 * instead. If the pin is pulled up we assume default to be
+		 * high, otherwise low.
+		 */
+		return pull_up ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	default:
+		/*
+		 * Assume that the BIOS has configured the direction and pull
+		 * accordingly.
+		 */
+		return GPIOD_ASIS;
+	}
+}
+
 struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
 	int index;
@@ -732,7 +757,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_resource *ares;
 	int pin_index = (int)address;
 	acpi_status status;
-	bool pull_up;
 	int length;
 	int i;
 
@@ -747,7 +771,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 	}
 
 	agpio = &ares->data.gpio;
-	pull_up = agpio->pin_config == ACPI_PIN_CONFIG_PULLUP;
 
 	if (WARN_ON(agpio->io_restriction == ACPI_IO_RESTRICT_INPUT &&
 	    function == ACPI_WRITE)) {
@@ -798,35 +821,23 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		}
 
 		if (!found) {
-			desc = gpiochip_request_own_desc(chip, pin,
-							 "ACPI:OpRegion");
+			enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio);
+			const char *label = "ACPI:OpRegion";
+			int err;
+
+			desc = gpiochip_request_own_desc(chip, pin, label);
 			if (IS_ERR(desc)) {
 				status = AE_ERROR;
 				mutex_unlock(&achip->conn_lock);
 				goto out;
 			}
 
-			switch (agpio->io_restriction) {
-			case ACPI_IO_RESTRICT_INPUT:
-				gpiod_direction_input(desc);
-				break;
-			case ACPI_IO_RESTRICT_OUTPUT:
-				/*
-				 * ACPI GPIO resources don't contain an
-				 * initial value for the GPIO. Therefore we
-				 * deduce that value from the pull field
-				 * instead. If the pin is pulled up we
-				 * assume default to be high, otherwise
-				 * low.
-				 */
-				gpiod_direction_output(desc, pull_up);
-				break;
-			default:
-				/*
-				 * Assume that the BIOS has configured the
-				 * direction and pull accordingly.
-				 */
-				break;
+			err = gpiod_configure_flags(desc, label, 0, flags);
+			if (err < 0) {
+				status = AE_NOT_CONFIGURED;
+				gpiochip_free_own_desc(desc);
+				mutex_unlock(&achip->conn_lock);
+				goto out;
 			}
 
 			conn = kzalloc(sizeof(*conn), GFP_KERNEL);
-- 
2.11.0
