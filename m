From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/8] gpio: acpi: Align acpi_find_gpio() with DT version
Date: Thu, 23 Mar 2017 21:46:12 +0200
Message-ID: <20170323194618.26548-3-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44442 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751309AbdCWTqY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Mar 2017 15:46:24 -0400
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

By some reason acpi_find_gpio() and acpi_gpio_count() have compared connection
ID to "gpios" when tries to check if suffix is needed or not.

Don't do any assumptions about what connection ID can be and, when defined, use
it only with suffix as it's done in the device tree version.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 56a6b1be3a17..3bda3166d418 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -593,7 +593,7 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id && strcmp(con_id, "gpios")) {
+		if (con_id) {
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
 		} else {
@@ -1081,7 +1081,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id && strcmp(con_id, "gpios"))
+		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
 		else
-- 
2.11.0

