From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/6] ACPI / gpio: Split acpi_get_gpiod_by_index()
Date: Thu, 27 Aug 2015 04:41:33 +0200
Message-ID: <8402685.WoxEi8zV68@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Split acpi_get_gpiod_by_index() into three smaller routines to
allow the subsequent change of the generic firmware node properties
code to be more strarightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c |  113 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 48 deletions(-)

Index: linux-pm/drivers/gpio/gpiolib-acpi.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib-acpi.c
+++ linux-pm/drivers/gpio/gpiolib-acpi.c
@@ -389,6 +389,8 @@ struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
 	int index;
 	int pin_index;
+	bool active_low;
+	struct acpi_device *adev;
 	struct gpio_desc *desc;
 	int n;
 };
@@ -425,6 +427,59 @@ static int acpi_find_gpio(struct acpi_re
 	return 1;
 }
 
+static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
+				     struct acpi_gpio_info *info)
+{
+	struct list_head res_list;
+	int ret;
+
+	INIT_LIST_HEAD(&res_list);
+
+	ret = acpi_dev_get_resources(lookup->adev, &res_list, acpi_find_gpio,
+				     lookup);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&res_list);
+
+	if (!lookup->desc)
+		return -ENOENT;
+
+	if (info) {
+		*info = lookup->info;
+		if (lookup->active_low)
+			info->active_low = lookup->active_low;
+	}
+	return 0;
+}
+
+static int acpi_gpio_property_lookup(struct acpi_device *adev,
+				     const char *propname, int index,
+				     struct acpi_gpio_lookup *lookup)
+{
+	struct acpi_reference_args args;
+	int ret;
+
+	memset(&args, 0, sizeof(args));
+	ret = acpi_dev_get_property_reference(adev, propname, index, &args);
+	if (ret && !acpi_get_driver_gpio_data(adev, propname, index, &args))
+		return ret;
+
+	/*
+	 * The property was found and resolved, so need to lookup the GPIO based
+	 * on returned args.
+	 */
+	lookup->adev = args.adev;
+	if (args.nargs >= 2) {
+		lookup->index = args.args[0];
+		lookup->pin_index = args.args[1];
+		/* 3rd argument, if present is used to specify active_low. */
+		if (args.nargs >= 3)
+			lookup->active_low = !!args.args[2];
+	}
+	return 0;
+}
+
 /**
  * acpi_get_gpiod_by_index() - get a GPIO descriptor from device resources
  * @adev: pointer to a ACPI device to get GPIO from
@@ -452,8 +507,6 @@ struct gpio_desc *acpi_get_gpiod_by_inde
 					  struct acpi_gpio_info *info)
 {
 	struct acpi_gpio_lookup lookup;
-	struct list_head resource_list;
-	bool active_low = false;
 	int ret;
 
 	if (!adev)
@@ -463,58 +516,22 @@ struct gpio_desc *acpi_get_gpiod_by_inde
 	lookup.index = index;
 
 	if (propname) {
-		struct acpi_reference_args args;
-
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
 
-		memset(&args, 0, sizeof(args));
-		ret = acpi_dev_get_property_reference(adev, propname,
-						      index, &args);
-		if (ret) {
-			bool found = acpi_get_driver_gpio_data(adev, propname,
-							       index, &args);
-			if (!found)
-				return ERR_PTR(ret);
-		}
-
-		/*
-		 * The property was found and resolved so need to
-		 * lookup the GPIO based on returned args instead.
-		 */
-		adev = args.adev;
-		if (args.nargs >= 2) {
-			lookup.index = args.args[0];
-			lookup.pin_index = args.args[1];
-			/*
-			 * 3rd argument, if present is used to
-			 * specify active_low.
-			 */
-			if (args.nargs >= 3)
-				active_low = !!args.args[2];
-		}
-
-		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %zd %llu %llu %llu\n",
-			dev_name(&adev->dev), args.nargs,
-			args.args[0], args.args[1], args.args[2]);
+		ret = acpi_gpio_property_lookup(adev, propname, index, &lookup);
+		if (ret)
+			return ERR_PTR(ret);
+
+		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %d %d %u\n",
+			dev_name(&lookup.adev->dev), lookup.index,
+			lookup.pin_index, lookup.active_low);
 	} else {
 		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
+		lookup.adev = adev;
 	}
 
-	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, acpi_find_gpio,
-				     &lookup);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	acpi_dev_free_resource_list(&resource_list);
-
-	if (lookup.desc && info) {
-		*info = lookup.info;
-		if (active_low)
-			info->active_low = active_low;
-	}
-
-	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
+	ret = acpi_gpio_resource_lookup(&lookup, info);
+	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
 /**

