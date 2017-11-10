From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] gpiolib: acpi: Assign polarity when call acpi_populate_gpio_lookup()
Date: Fri, 10 Nov 2017 15:40:28 +0200
Message-ID: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbdKJNkh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Nov 2017 08:40:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need, since we preserve firmware settings, to override
polarity for GpioInt() resources.

While Documentation/gpio-properties.txt refers to any from GpioIo() /
GpioInt() resources, the active_low flag has been introduced to fill the
gap only for GpioIo() which lacks of that information.

Moreover, in case of GpioInt() existed solution was broken anyway, it
overrides only in one direction, i.e. from 0 to 1, otherwise it would be
still 1 as defined in the resource macro.

So, move the assignment to a right place and forbid to (semi-)override
polarity for GpioInt() type of resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index eb4528c87c0b..2a85d27eb028 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -531,8 +531,8 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 			lookup->info.triggering = agpio->triggering;
 		} else {
 			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
+			lookup->info.polarity = lookup->active_low;
 		}
-
 	}
 
 	return 1;
@@ -557,11 +557,8 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 	if (!lookup->desc)
 		return -ENOENT;
 
-	if (info) {
+	if (info)
 		*info = lookup->info;
-		if (lookup->active_low)
-			info->polarity = lookup->active_low;
-	}
 	return 0;
 }
 
-- 
2.14.2

