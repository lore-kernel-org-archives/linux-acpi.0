From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/12] gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
Date: Tue, 23 May 2017 20:03:20 +0300
Message-ID: <20170523170327.18055-6-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

If we pass connection ID to the both functions and at the same time
acpi_can_fallback_to_crs() returns false we will get different results,
i.e. the number of GPIO resources returned by acpi_gpio_count() might be
not correct.

Fix this by calling acpi_can_fallback_to_crs() in acpi_gpio_count()
before trying to fallback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 0392d8ed332f..740df0e9dcb3 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1119,6 +1119,9 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
 		struct list_head resource_list;
 		unsigned int crs_count = 0;
 
+		if (!acpi_can_fallback_to_crs(adev, con_id))
+			return count;
+
 		INIT_LIST_HEAD(&resource_list);
 		acpi_dev_get_resources(adev, &resource_list,
 				       acpi_find_gpio_count, &crs_count);
-- 
2.11.0
