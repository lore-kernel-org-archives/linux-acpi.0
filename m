From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 4/4] ACPI / gpio: Add support for naming GPIOs
Date: Fri, 21 Oct 2016 17:21:32 +0300
Message-ID: <20161021142132.80539-5-mika.westerberg@linux.intel.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Now that we have the new helper function that sets nice names for GPIO
lines based on "gpio-line-names" device property, we can take advantage of
this in acpi_gpiochip_add().

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/gpio-properties.txt | 12 ++++++++++++
 drivers/gpio/gpiolib-acpi.c            |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index ce7bc5c33c24..08fdc0ddee48 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -98,6 +98,18 @@ Example:
       }
   })
 
+- gpio-line-names
+
+Example:
+
+  Package () {
+      "gpio-line-names",
+      Package () {
+          "SPI0_CS_N", "EXP2_INT", "MUX6_IO", "UART0_RXD", "MUX7_IO",
+          "LVL_C_A1", "MUX0_IO", "SPI1_MISO"
+      }
+  }
+
 See Documentation/devicetree/bindings/gpio/gpio.tx for more information
 about these properties.
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 4f46982ce982..53266ef12008 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -957,6 +957,9 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 		return;
 	}
 
+	if (!chip->names)
+		devprop_gpiochip_set_names(chip);
+
 	acpi_gpiochip_request_regions(acpi_gpio);
 	acpi_gpiochip_scan_gpios(acpi_gpio);
 	acpi_walk_dep_device_list(handle);
-- 
2.9.3
