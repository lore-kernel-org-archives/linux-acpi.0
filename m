From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/6] gpiolib: acpi: Don't contaminate return parameter in case of error
Date: Fri, 10 Nov 2017 15:40:29 +0200
Message-ID: <20171110134033.85461-2-andriy.shevchenko@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

If error occurs, leave lookup parameter untouched.

There is no functional change, since all current callers just bail out
in case of error without using the assigned pieces.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2a85d27eb028..f640445099ab 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -585,7 +585,6 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	 * The property was found and resolved, so need to lookup the GPIO based
 	 * on returned args.
 	 */
-	lookup->adev = args.adev;
 	if (args.nargs != 3)
 		return -EPROTO;
 
@@ -593,6 +592,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	lookup->pin_index = args.args[1];
 	lookup->active_low = !!args.args[2];
 
+	lookup->adev = args.adev;
 	return 0;
 }
 
-- 
2.14.2

