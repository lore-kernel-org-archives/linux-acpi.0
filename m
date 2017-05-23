From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 02/12] gpio: acpi: Align acpi_find_gpio() with DT version
Date: Tue, 23 May 2017 20:03:17 +0300
Message-ID: <20170523170327.18055-3-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

By some reason acpi_find_gpio() and acpi_gpio_count() have compared
connection ID to "gpios" when tries to check if suffix is needed or not.

Don't do any assumptions about what connection ID can be and, when defined,
use it only with suffix as it's done in the device tree version.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2185232da823..055a8a255a40 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -599,7 +599,7 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id && strcmp(con_id, "gpios")) {
+		if (con_id) {
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
 		} else {
@@ -1089,7 +1089,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 
 	/* Try first from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id && strcmp(con_id, "gpios"))
+		if (con_id)
 			snprintf(propname, sizeof(propname), "%s-%s",
 				 con_id, gpio_suffixes[i]);
 		else
-- 
2.11.0

