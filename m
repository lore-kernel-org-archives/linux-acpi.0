From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v5 10/12] gpio: Support for unified device properties interface
Date: Fri, 17 Oct 2014 14:16 +0200
Message-ID: <1510578.dSiEYPPI9m@vostro.rjw.lan>
References: <2660541.BycO7TFnA2@vostro.rjw.lan> <11223831.j9KAEfSQsY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11223831.j9KAEfSQsY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Some drivers need to deal with only firmware representation of its
GPIOs. An example would be a GPIO button array driver where each button
is described as a separate firmware node in device tree. Typically these
child nodes do not have physical representation in the Linux device
model.

In order to help device drivers to handle such firmware child nodes we
add dev[m]_get_named_gpiod_from_child() that takes a child firmware
node pointer as its second argument (the first one is the parent device
itself), finds the GPIO using whatever is the underlying firmware
method, and requests the GPIO properly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpio/devres.c         |   36 +++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c        |   56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |    8 ++++++
 3 files changed, 100 insertions(+)

Index: linux-pm/drivers/gpio/devres.c
===================================================================
--- linux-pm.orig/drivers/gpio/devres.c
+++ linux-pm/drivers/gpio/devres.c
@@ -109,6 +109,42 @@ struct gpio_desc *__must_check __devm_gp
 EXPORT_SYMBOL(__devm_gpiod_get_index);
 
 /**
+ * devm_get_named_gpiod_from_child - managed dev_get_named_gpiod_from_child()
+ * @dev:	GPIO consumer
+ * @child:	firmware node (child of @dev)
+ * @propname:	name of the firmware property
+ * @index:	index of the GPIO in the property value in case of many
+ *
+ * GPIO descriptors returned from this function are automatically disposed on
+ * driver detach.
+ */
+struct gpio_desc *devm_get_named_gpiod_from_child(struct device *dev,
+						  struct fwnode_handle *child,
+						  const char *propname,
+						  int index)
+{
+	struct gpio_desc **dr;
+	struct gpio_desc *desc;
+
+	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
+			  GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	desc = fwnode_get_named_gpiod(child, propname, index);
+	if (IS_ERR(desc)) {
+		devres_free(dr);
+		return desc;
+	}
+
+	*dr = desc;
+	devres_add(dev, dr);
+
+	return desc;
+}
+EXPORT_SYMBOL(devm_get_named_gpiod_from_child);
+
+/**
  * devm_gpiod_get_index_optional - Resource-managed gpiod_get_index_optional()
  * @dev: GPIO consumer
  * @con_id: function within the GPIO consumer
Index: linux-pm/drivers/gpio/gpiolib.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib.c
+++ linux-pm/drivers/gpio/gpiolib.c
@@ -1735,6 +1735,62 @@ struct gpio_desc *__must_check __gpiod_g
 EXPORT_SYMBOL_GPL(__gpiod_get_index);
 
 /**
+ * fwnode_get_named_gpiod - obtain a GPIO from firmware node
+ * @fwnode:	handle of the firmware node
+ * @propname:	name of the firmware property
+ * @idx:	index of the GPIO in the property value in case of many
+ *
+ * This function can be used for drivers that get their configuration
+ * from firmware.
+ *
+ * Function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+					 const char *propname, int index)
+{
+	struct gpio_desc *desc = ERR_PTR(-ENODEV);
+	bool active_low = false;
+	int ret;
+
+	if (!fwnode)
+		return ERR_PTR(-EINVAL);
+
+	if (is_of_node(fwnode)) {
+		enum of_gpio_flags flags;
+
+		desc = of_get_named_gpiod_flags(of_node(fwnode), propname,
+						index, &flags);
+		if (!IS_ERR(desc))
+			active_low = flags & OF_GPIO_ACTIVE_LOW;
+	} else if (is_acpi_node(fwnode)) {
+		struct acpi_gpio_info info;
+
+		desc = acpi_get_gpiod_by_index(acpi_node(fwnode), propname,
+					       index, &info);
+		if (!IS_ERR(desc))
+			active_low = info.active_low;
+	}
+
+	if (IS_ERR(desc))
+		return desc;
+
+	ret = gpiod_request(desc, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* Only value flag can be set from both DT and ACPI is active_low */
+	if (active_low)
+		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_named_gpiod);
+
+/**
  * gpiod_get_index_optional - obtain an optional GPIO from a multi-index GPIO
  *                            function
  * @dev: GPIO consumer, can be NULL for system-global GPIOs
Index: linux-pm/include/linux/gpio/consumer.h
===================================================================
--- linux-pm.orig/include/linux/gpio/consumer.h
+++ linux-pm/include/linux/gpio/consumer.h
@@ -94,6 +94,14 @@ int gpiod_to_irq(const struct gpio_desc
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
+/* Child properties interface */
+struct fwnode_handle;
+
+struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+					 const char *propname, int index);
+struct gpio_desc *devm_get_named_gpiod_from_child(struct device *dev,
+						  struct fwnode_handle *child,
+						  const char *propname, int index);
 #else /* CONFIG_GPIOLIB */
 
 static inline struct gpio_desc *__must_check __gpiod_get(struct device *dev,
