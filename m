From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 2/4] ACPI / gpio: Add hogging support
Date: Fri, 21 Oct 2016 17:21:30 +0300
Message-ID: <20161021142132.80539-3-mika.westerberg@linux.intel.com>
References: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11213 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933385AbcJUOWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 10:22:24 -0400
In-Reply-To: <20161021142132.80539-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org

GPIO hogging means that the GPIO controller can "hog" and configure certain
GPIOs without need for a driver or userspace to do that. This is useful in
open-connected boards where BIOS cannot possibly know beforehand which
devices will be connected to the board.

This adds GPIO hogging mechanism to ACPI analogous to Device Tree.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/acpi/gpio-properties.txt | 35 +++++++++++++++++
 drivers/gpio/gpiolib-acpi.c            | 71 ++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index 09cff657b82c..ce7bc5c33c24 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -66,6 +66,41 @@ native:
       }
   }
 
+Other supported properties
+--------------------------
+
+Following Device Tree compatible device properties are also supported by
+_DSD device properties for GPIO controllers:
+
+- gpio-hog
+- output-high
+- output-low
+- input
+- line-name
+
+Example:
+
+  Name (_DSD, Package () {
+      // _DSD Hierarchical Properties Extension UUID
+      ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+      Package () {
+          Package () {"hog-gpio8", "G8PU"}
+      }
+  })
+
+  Name (G8PU, Package () {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+      Package () {
+          Package () {"gpio-hog", 1},
+          Package () {"gpios", Package () {8, 0}},
+          Package () {"output-high", 1},
+          Package () {"line-name", "gpio8-pullup"},
+      }
+  })
+
+See Documentation/devicetree/bindings/gpio/gpio.tx for more information
+about these properties.
+
 ACPI GPIO Mappings Provided by Drivers
 --------------------------------------
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 700ea6ad609b..4f46982ce982 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -857,6 +857,76 @@ static void acpi_gpiochip_free_regions(struct acpi_gpio_chip *achip)
 	}
 }
 
+struct gpio_desc *acpi_gpiochip_parse_own_gpio(struct acpi_gpio_chip *achip,
+	struct fwnode_handle *fwnode, const char **name, unsigned int *lflags,
+	unsigned int *dflags)
+{
+	struct gpio_chip *chip = achip->chip;
+	struct gpio_desc *desc;
+	u32 gpios[2];
+	int ret;
+
+	ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios,
+					     ARRAY_SIZE(gpios));
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ret = acpi_gpiochip_pin_to_gpio_offset(chip->gpiodev, gpios[0]);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	desc = gpiochip_get_desc(chip, ret);
+	if (IS_ERR(desc))
+		return desc;
+
+	*lflags = 0;
+	*dflags = 0;
+	*name = NULL;
+
+	if (gpios[1])
+		*lflags |= GPIO_ACTIVE_LOW;
+
+	if (fwnode_property_present(fwnode, "input"))
+		*dflags |= GPIOD_IN;
+	else if (fwnode_property_present(fwnode, "output-low"))
+		*dflags |= GPIOD_OUT_LOW;
+	else if (fwnode_property_present(fwnode, "output-high"))
+		*dflags |= GPIOD_OUT_HIGH;
+	else
+		return ERR_PTR(-EINVAL);
+
+	fwnode_property_read_string(fwnode, "line-name", name);
+
+	return desc;
+}
+
+static void acpi_gpiochip_scan_gpios(struct acpi_gpio_chip *achip)
+{
+	struct gpio_chip *chip = achip->chip;
+	struct fwnode_handle *fwnode;
+
+	device_for_each_child_node(chip->parent, fwnode) {
+		unsigned int lflags, dflags;
+		struct gpio_desc *desc;
+		const char *name;
+		int ret;
+
+		if (!fwnode_property_present(fwnode, "gpio-hog"))
+			continue;
+
+		desc = acpi_gpiochip_parse_own_gpio(achip, fwnode, &name,
+						    &lflags, &dflags);
+		if (IS_ERR(desc))
+			continue;
+
+		ret = gpiod_hog(desc, name, lflags, dflags);
+		if (ret) {
+			dev_err(chip->parent, "Failed to hog GPIO\n");
+			return;
+		}
+	}
+}
+
 void acpi_gpiochip_add(struct gpio_chip *chip)
 {
 	struct acpi_gpio_chip *acpi_gpio;
@@ -888,6 +958,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
 	}
 
 	acpi_gpiochip_request_regions(acpi_gpio);
+	acpi_gpiochip_scan_gpios(acpi_gpio);
 	acpi_walk_dep_device_list(handle);
 }
 
-- 
2.9.3

