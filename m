From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/8] gpio: acpi: Synchronize acpi_find_gpio() and acpi_gpio_count()
Date: Thu, 23 Mar 2017 21:46:15 +0200
Message-ID: <20170323194618.26548-6-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

If we pass connection ID to the both functions and at the same time
acpi_can_fallback_to_crs() returns false we will get different results, i.e.
the number of GPIO resourses returned by acpi_gpio_count() might be not
correct.

Fix this by calling acpi_can_fallback_to_crs() in acpi_gpio_count() before
trying to fallback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index e516b7a0cc50..61518273e360 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1111,6 +1111,9 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
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
