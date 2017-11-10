From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/6] gpiolib: acpi: Move adev member to struct acpi_gpio_info
Date: Fri, 10 Nov 2017 15:40:30 +0200
Message-ID: <20171110134033.85461-3-andriy.shevchenko@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58736 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752728AbdKJNk7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Nov 2017 08:40:59 -0500
In-Reply-To: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The further improvements are based on this change since
struct acpi_gpio_lookup is not available in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++-----
 drivers/gpio/gpiolib.h      |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index f640445099ab..7d0664a3d1b9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -494,7 +494,6 @@ struct acpi_gpio_lookup {
 	int index;
 	int pin_index;
 	bool active_low;
-	struct acpi_device *adev;
 	struct gpio_desc *desc;
 	int n;
 };
@@ -541,12 +540,13 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 				     struct acpi_gpio_info *info)
 {
+	struct acpi_device *adev = lookup->info.adev;
 	struct list_head res_list;
 	int ret;
 
 	INIT_LIST_HEAD(&res_list);
 
-	ret = acpi_dev_get_resources(lookup->adev, &res_list,
+	ret = acpi_dev_get_resources(adev, &res_list,
 				     acpi_populate_gpio_lookup,
 				     lookup);
 	if (ret < 0)
@@ -592,7 +592,7 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 	lookup->pin_index = args.args[1];
 	lookup->active_low = !!args.args[2];
 
-	lookup->adev = args.adev;
+	lookup->info.adev = args.adev;
 	return 0;
 }
 
@@ -640,11 +640,11 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 			return ERR_PTR(ret);
 
 		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %d %d %u\n",
-			dev_name(&lookup.adev->dev), lookup.index,
+			dev_name(&lookup.info.adev->dev), lookup.index,
 			lookup.pin_index, lookup.active_low);
 	} else {
 		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
-		lookup.adev = adev;
+		lookup.info.adev = adev;
 	}
 
 	ret = acpi_gpio_resource_lookup(&lookup, info);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index af48322839c3..e8d0bfa57288 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -75,12 +75,14 @@ struct gpio_device {
 
 /**
  * struct acpi_gpio_info - ACPI GPIO specific information
+ * @adev: reference to ACPI device which consumes GPIO resource
  * @flags: GPIO initialization flags
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
  */
 struct acpi_gpio_info {
+	struct acpi_device *adev;
 	enum gpiod_flags flags;
 	bool gpioint;
 	int polarity;
-- 
2.14.2

