From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH v3 06/15] gpio: Support for unified device properties interface
Date: Wed, 01 Oct 2014 04:14:20 +0200
Message-ID: <3027081.751AscUWII@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1852462.V1jlbi8OPt-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

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

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

Linus, does this look better than the previous one to you?

---
 drivers/gpio/devres.c         |   34 +++++++++++++++++++++++++
 drivers/gpio/gpiolib.c        |   56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |    5 +++
 3 files changed, 95 insertions(+)

Index: linux-pm/drivers/gpio/devres.c
===================================================================
--- linux-pm.orig/drivers/gpio/devres.c
+++ linux-pm/drivers/gpio/devres.c
@@ -109,6 +109,40 @@ struct gpio_desc *__must_check __devm_gp
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
+struct gpio_desc *devm_get_named_gpiod_from_child(struct device *dev, void *child,
+						  const char *propname, int index)
+{
+	struct gpio_desc **dr;
+	struct gpio_desc *desc;
+
+	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
+			  GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	desc = dev_get_named_gpiod_from_child(dev, child, propname, index);
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
@@ -1717,6 +1717,62 @@ struct gpio_desc *__must_check __gpiod_g
 EXPORT_SYMBOL_GPL(__gpiod_get_index);
 
 /**
+ * dev_get_named_gpiod_from_child - obtain a GPIO from firmware node
+ * @dev:	parent device
+ * @child:	firmware node (child of @dev)
+ * @propname:	name of the firmware property
+ * @idx:	index of the GPIO in the property value in case of many
+ *
+ * This function can be used for drivers that get their configuration
+ * from firmware in such a way that some properties are described as child
+ * nodes for the parent device in DT or ACPI.
+ *
+ * Function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct gpio_desc *dev_get_named_gpiod_from_child(struct device *dev, void *child,
+						 const char *propname, int index)
+{
+	struct gpio_desc *desc = ERR_PTR(-ENODEV);
+	bool active_low = false;
+	int ret;
+
+	if (!child)
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		enum of_gpio_flags flags;
+
+		desc = of_get_named_gpiod_flags(child, propname, index, &flags);
+		if (!IS_ERR(desc))
+			active_low = flags & OF_GPIO_ACTIVE_LOW;
+	} else if (ACPI_COMPANION(dev)) {
+		struct acpi_gpio_info info;
+
+		desc = acpi_get_gpiod_by_index(child, propname, index, &info);
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
+EXPORT_SYMBOL_GPL(dev_get_named_gpiod_from_child);
+
+/**
  * gpiod_get_index_optional - obtain an optional GPIO from a multi-index GPIO
  *                            function
  * @dev: GPIO consumer, can be NULL for system-global GPIOs
Index: linux-pm/include/linux/gpio/consumer.h
===================================================================
--- linux-pm.orig/include/linux/gpio/consumer.h
+++ linux-pm/include/linux/gpio/consumer.h
@@ -94,6 +94,11 @@ int gpiod_to_irq(const struct gpio_desc
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
+/* Child properties interface */
+struct gpio_desc *dev_get_named_gpiod_from_child(struct device *dev, void *child,
+						 const char *propname, int index);
+struct gpio_desc *devm_get_named_gpiod_from_child(struct device *dev, void *child,
+						  const char *propname, int index);
 #else /* CONFIG_GPIOLIB */
 
 static inline struct gpio_desc *__must_check __gpiod_get(struct device *dev,

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
