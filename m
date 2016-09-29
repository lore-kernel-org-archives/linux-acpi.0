From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 4/4] ACPI / gpio: Allow holes in list of GPIOs for a device
Date: Thu, 29 Sep 2016 16:39:44 +0300
Message-ID: <20160929133944.158596-5-mika.westerberg@linux.intel.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45660 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbcI2Nj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Sep 2016 09:39:56 -0400
In-Reply-To: <20160929133944.158596-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Make it possible to have an empty GPIOs in a GPIO list for device. For
example a SPI master may use both GPIOs and native pins as chip selects and
we need to be able to distinguish between the two.

This makes it mandatory to have exactly 3 arguments for GPIOs and then
converts gpiolib to use of __acpi_node_get_property_reference() instead. In
addition we make acpi_gpio_package_count() to handle holes as well (this
matches the DT version).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/gpio-properties.txt | 15 +++++++++++++++
 drivers/gpio/gpiolib-acpi.c            | 32 +++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index 46df91c3512b..2ccb70893122 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -51,6 +51,21 @@ it to 1 marks the GPIO as active low.
 In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
 resource, second pin in that resource with the GPIO number of 31.
 
+It is possible to leave holes in the array of GPIOs. This is useful in
+cases like with SPI host controllers where some chip selects may be
+implemented as GPIOs and some as native signals. For example a SPI host
+controller can have chip selects 0 and 2 implemented as GPIOs and 1 as
+native:
+
+  Package () {
+      "cs-gpios",
+      Package () {
+          ^GPIO, 19, 0, 0, // chip select 0: GPIO
+          0,               // chip select 1: native signal
+          ^GPIO, 20, 0, 0, // chip select 2: GPIO
+      }
+  }
+
 Other supported properties
 --------------------------
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 4e50f8f5d597..096a94ee96e7 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -467,7 +467,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	int ret;
 
 	memset(&args, 0, sizeof(args));
-	ret = acpi_node_get_property_reference(fwnode, propname, index, &args);
+	ret = __acpi_node_get_property_reference(fwnode, propname, index, 3,
+						 &args);
 	if (ret) {
 		struct acpi_device *adev = to_acpi_device_node(fwnode);
 
@@ -482,13 +483,13 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	 * on returned args.
 	 */
 	lookup->adev = args.adev;
-	if (args.nargs >= 2) {
-		lookup->index = args.args[0];
-		lookup->pin_index = args.args[1];
-		/* 3rd argument, if present is used to specify active_low. */
-		if (args.nargs >= 3)
-			lookup->active_low = !!args.args[2];
-	}
+	if (args.nargs != 3)
+		return -EPROTO;
+
+	lookup->index = args.args[0];
+	lookup->pin_index = args.args[1];
+	lookup->active_low = !!args.args[2];
+
 	return 0;
 }
 
@@ -979,18 +980,27 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
 	kfree(acpi_gpio);
 }
 
-static unsigned int acpi_gpio_package_count(const union acpi_object *obj)
+static int acpi_gpio_package_count(const union acpi_object *obj)
 {
 	const union acpi_object *element = obj->package.elements;
 	const union acpi_object *end = element + obj->package.count;
 	unsigned int count = 0;
 
 	while (element < end) {
-		if (element->type == ACPI_TYPE_LOCAL_REFERENCE)
+		switch (element->type) {
+		case ACPI_TYPE_LOCAL_REFERENCE:
+			element += 3;
+			/* Fallthrough */
+		case ACPI_TYPE_INTEGER:
+			element++;
 			count++;
+			break;
 
-		element++;
+		default:
+			return -EPROTO;
+		}
 	}
+
 	return count;
 }
 
-- 
2.9.3

