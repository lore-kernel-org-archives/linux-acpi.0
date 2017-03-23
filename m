From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/8] gpio: acpi: Override GPIO initialization flags
Date: Thu, 23 Mar 2017 21:46:18 +0200
Message-ID: <20170323194618.26548-9-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754779AbdCWTq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Mar 2017 15:46:29 -0400
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This allows ACPI GPIO code to modify flags based on
ACPI GpioIo() / GpioInt() resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/gpio/gpiolib.c      |  8 ++++++--
 drivers/gpio/gpiolib.h      | 15 ++++++++++++--
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d4de84670c5b..5506b0736aba 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -442,6 +442,34 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio)
 	}
 }
 
+int
+acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
+{
+	int ret = 0;
+
+	/*
+	 * Check if the BIOS has IoRestriction with explicitly set direction
+	 * and update @flags accordingly. Otherwise use whatever caller asked
+	 * for.
+	 */
+	if (update & GPIOD_FLAGS_BIT_DIR_SET) {
+		enum gpiod_flags diff = *flags ^ update;
+
+		/*
+		 * Check if caller supplied incompatible GPIO initialization
+		 * flags.
+		 *
+		 * Return %-EINVAL to notify that firmware has different
+		 * settings and we are going to use them.
+		 */
+		if (((*flags & GPIOD_FLAGS_BIT_DIR_SET) && (diff & GPIOD_FLAGS_BIT_DIR_OUT)) ||
+		    ((*flags & GPIOD_FLAGS_BIT_DIR_OUT) && (diff & GPIOD_FLAGS_BIT_DIR_VAL)))
+			ret = -EINVAL;
+		*flags = update;
+	}
+	return ret;
+}
+
 struct acpi_gpio_lookup {
 	struct acpi_gpio_info info;
 	int index;
@@ -479,8 +507,11 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		 * - ACPI_ACTIVE_HIGH == GPIO_ACTIVE_HIGH
 		 */
 		if (lookup->info.gpioint) {
+			lookup->info.flags = GPIOD_IN;
 			lookup->info.polarity = agpio->polarity;
 			lookup->info.triggering = agpio->triggering;
+		} else {
+			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
 		}
 
 	}
@@ -607,13 +638,14 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 struct gpio_desc *acpi_find_gpio(struct device *dev,
 				 const char *con_id,
 				 unsigned int idx,
-				 enum gpiod_flags flags,
+				 enum gpiod_flags *dflags,
 				 enum gpio_lookup_flags *lookupflags)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
+	int err;
 	int i;
 
 	/* Try first from _DSD */
@@ -642,7 +674,7 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 	}
 
 	if (info.gpioint &&
-	    (flags == GPIOD_OUT_LOW || flags == GPIOD_OUT_HIGH)) {
+	    (*dflags == GPIOD_OUT_LOW || *dflags == GPIOD_OUT_HIGH)) {
 		dev_dbg(dev, "refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
 		return ERR_PTR(-ENOENT);
 	}
@@ -650,6 +682,10 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 	if (info.polarity == GPIO_ACTIVE_LOW)
 		*lookupflags |= GPIO_ACTIVE_LOW;
 
+	err = acpi_gpio_update_gpiod_flags(dflags, info.flags);
+	if (err)
+		dev_dbg(dev, "Override GPIO initialization flags\n");
+
 	return desc;
 }
 
@@ -703,12 +739,16 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * used to translate from the GPIO offset in the resource to the Linux IRQ
  * number.
  *
+ * The function is idempotent, though each time it runs it will configure GPIO
+ * pin direction according to the flags in GpioInt resource.
+ *
  * Return: Linux IRQ number (>%0) on success, negative errno on failure.
  */
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
 	int idx, i;
 	unsigned int irq_flags;
+	int ret;
 
 	for (i = 0, idx = 0; idx <= index; i++) {
 		struct acpi_gpio_info info;
@@ -721,6 +761,7 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 			return PTR_ERR(desc);
 
 		if (info.gpioint && idx++ == index) {
+			char label[32];
 			int irq;
 
 			if (IS_ERR(desc))
@@ -730,6 +771,11 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 			if (irq < 0)
 				return irq;
 
+			snprintf(label, sizeof(label), "GpioInt() %d", index);
+			ret = gpiod_configure_flags(desc, label, 0, info.flags);
+			if (ret < 0)
+				return ret;
+
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
 							  info.polarity);
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3752785d31ab..6110fd62277a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3272,7 +3272,7 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 			desc = of_find_gpio(dev, con_id, idx, &lookupflags);
 		} else if (ACPI_COMPANION(dev)) {
 			dev_dbg(dev, "using ACPI for GPIO lookup\n");
-			desc = acpi_find_gpio(dev, con_id, idx, flags, &lookupflags);
+			desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
 		}
 	}
 
@@ -3351,8 +3351,12 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 		struct acpi_gpio_info info;
 
 		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
-		if (!IS_ERR(desc))
+		if (!IS_ERR(desc)) {
 			active_low = info.polarity == GPIO_ACTIVE_LOW;
+			ret = acpi_gpio_update_gpiod_flags(&dflags, info.flags);
+			if (ret)
+				pr_debug("Override GPIO initialization flags\n");
+		}
 	}
 
 	if (IS_ERR(desc))
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index e36a0bdc7740..cff398cbb545 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -75,11 +75,13 @@ struct gpio_device {
 
 /**
  * struct acpi_gpio_info - ACPI GPIO specific information
+ * @flags: GPIO initialization flags
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
  */
 struct acpi_gpio_info {
+	enum gpiod_flags flags;
 	bool gpioint;
 	int polarity;
 	int triggering;
@@ -121,10 +123,13 @@ void acpi_gpiochip_remove(struct gpio_chip *chip);
 void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
 
+int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
+				 enum gpiod_flags update);
+
 struct gpio_desc *acpi_find_gpio(struct device *dev,
 				 const char *con_id,
 				 unsigned int idx,
-				 enum gpiod_flags flags,
+				 enum gpiod_flags *dflags,
 				 enum gpio_lookup_flags *lookupflags);
 struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      const char *propname, int index,
@@ -143,9 +148,15 @@ acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
 static inline void
 acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
 
+static inline int
+acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, enum gpiod_flags update)
+{
+	return 0;
+}
+
 static inline struct gpio_desc *
 acpi_find_gpio(struct device *dev, const char *con_id,
-	       unsigned int idx, enum gpiod_flags flags,
+	       unsigned int idx, enum gpiod_flags *dflags,
 	       enum gpio_lookup_flags *lookupflags)
 {
 	return ERR_PTR(-ENOENT);
-- 
2.11.0

