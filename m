From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 10/12] PNP / ACPI: add support for GpioInt resource type
Date: Tue, 23 May 2017 20:03:25 +0300
Message-ID: <20170523170327.18055-11-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764788AbdEWRDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 13:03:48 -0400
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>

The PNP ACPI driver parses ACPI interrupt resource but not
GpioInt resource. When the firmware passes GpioInt resource
for IRQ the PNP ACPI driver ignores it and hence the interrupt for
the particular driver will not work.
One such example is 8042 keyboard which uses PNP driver for obtaining
the interrupt resource. On Intel Braswell project GpioInt is used
instead of interrupt resource and the keyboard driver fails to
register interrupt.
Fix the issue by parsing GpioInt resource type.

Signed-off-by: Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 4b717c699313..af44e57f5148 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -180,6 +180,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	struct pnp_dev *dev = data;
 	struct acpi_resource_dma *dma;
 	struct acpi_resource_vendor_typed *vendor_typed;
+	struct acpi_resource_gpio *gpio;
 	struct resource_win win = {{0}, 0};
 	struct resource *r = &win.res;
 	int i, flags;
@@ -210,6 +211,20 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 			}
 		}
 		return AE_OK;
+	} else if (acpi_gpio_get_irq_resource(res, &gpio)) {
+		/*
+		 * If the resource is GpioInt() type then extract the IRQ
+		 * from GPIO resource and fill it into IRQ resource type.
+		 */
+		i = acpi_dev_gpio_irq_get(dev->data, 0);
+		if (i >= 0) {
+			flags = acpi_dev_irq_flags(gpio->triggering,
+						   gpio->polarity,
+						   gpio->sharable);
+		} else
+			flags = IORESOURCE_DISABLED;
+		pnp_add_irq_resource(dev, i, flags);
+		return AE_OK;
 	} else if (r->flags & IORESOURCE_DISABLED) {
 		pnp_add_irq_resource(dev, 0, IORESOURCE_DISABLED);
 		return AE_OK;
-- 
2.11.0

