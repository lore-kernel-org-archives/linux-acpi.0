From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/6] ACPI / property: Extend device_get_next_child_node() to data-only nodes
Date: Thu, 27 Aug 2015 04:42:33 +0200
Message-ID: <1476191.4Mv7radvfC@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596179.pGEt0Ullqu@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make device_get_next_child_node() work with ACPI data-only subnodes
introduced previously.

Namely, replace acpi_get_next_child() with acpi_get_next_subnode()
that can handle (and return) child device objects as well as child
data-only subnodes of the given device and modify the ACPI part
of the GPIO subsystem to handle data-only subnodes returned by it.

To that end, introduce acpi_node_get_gpiod() taking a struct
fwnode_handle pointer as the first argument.  That argument may
point to an ACPI device object as well as to a data-only subnode
and the function should do the right thing (ie. look for the matching
GPIO descriptor correctly) in either case.

Next, modify fwnode_get_named_gpiod() to use acpi_node_get_gpiod()
instead of acpi_get_gpiod_by_index() which automatically causes
devm_get_gpiod_from_child() to work with ACPI data-only subnodes
that may be returned by device_get_next_child_node() which in turn
is required by the users of that function (the gpio_keys_polled
and gpio-leds drivers).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c     |   88 ++++++++++++++++++++++++++++++++++++++++----
 drivers/acpi/scan.c         |   20 ----------
 drivers/base/property.c     |    6 ---
 drivers/gpio/gpiolib-acpi.c |   58 ++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.c      |    5 +-
 drivers/gpio/gpiolib.h      |   10 ++++-
 include/linux/acpi.h        |   17 ++++----
 7 files changed, 153 insertions(+), 51 deletions(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -461,9 +461,9 @@ static int acpi_data_get_property_array(
 }
 
 /**
- * acpi_dev_get_property_reference - returns handle to the referenced object
- * @adev: ACPI device to get property
- * @name: Name of the property
+ * acpi_data_get_property_reference - returns handle to the referenced object
+ * @data: ACPI device data object containing the property
+ * @propname: Name of the property
  * @index: Index of the reference to return
  * @args: Location to store the returned reference with optional arguments
  *
@@ -477,16 +477,16 @@ static int acpi_data_get_property_array(
  *
  * Return: %0 on success, negative error code on failure.
  */
-int acpi_dev_get_property_reference(struct acpi_device *adev,
-				    const char *name, size_t index,
-				    struct acpi_reference_args *args)
+static int acpi_data_get_property_reference(struct acpi_device_data *data,
+					    const char *propname, size_t index,
+					    struct acpi_reference_args *args)
 {
 	const union acpi_object *element, *end;
 	const union acpi_object *obj;
 	struct acpi_device *device;
 	int ret, idx = 0;
 
-	ret = acpi_dev_get_property(adev, name, ACPI_TYPE_ANY, &obj);
+	ret = acpi_data_get_property(data, propname, ACPI_TYPE_ANY, &obj);
 	if (ret)
 		return ret;
 
@@ -561,7 +561,23 @@ int acpi_dev_get_property_reference(stru
 
 	return -EPROTO;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_get_property_reference);
+
+/**
+ * acpi_node_get_property_reference - get a handle to the referenced object.
+ * @fwnode: Firmware node to get the property from.
+ * @propname: Name of the property.
+ * @index: Index of the reference to return.
+ * @args: Location to store the returned reference with optional arguments.
+ */
+int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+				     const char *name, size_t index,
+				     struct acpi_reference_args *args)
+{
+	struct acpi_device_data *data = acpi_device_data_of_node(fwnode);
+
+	return data ? acpi_data_get_property_reference(data, name, index, args) : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(acpi_node_get_property_reference);
 
 static int acpi_data_prop_read_single(struct acpi_device_data *data,
 				      const char *propname,
@@ -767,3 +783,59 @@ int acpi_node_prop_read(struct fwnode_ha
 	return acpi_data_prop_read(acpi_device_data_of_node(fwnode),
 				   propname, proptype, val, nval);
 }
+
+/**
+ * acpi_get_next_subnode - Return the next child node handle for a device.
+ * @dev: Device to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ */
+struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+					    struct fwnode_handle *child)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct list_head *head, *next;
+
+	if (!adev)
+		return NULL;
+
+	if (!child || child->type == FWNODE_ACPI) {
+		head = &adev->children;
+		if (list_empty(head))
+			goto nondev;
+
+		if (child) {
+			adev = to_acpi_device_node(child);
+			next = adev->node.next;
+			if (next == head) {
+				child = NULL;
+				goto nondev;
+			}
+			adev = list_entry(next, struct acpi_device, node);
+		} else {
+			adev = list_first_entry(head, struct acpi_device, node);
+		}
+		return acpi_fwnode_handle(adev);
+	}
+
+ nondev:
+	if (!child || child->type == FWNODE_ACPI_DATA) {
+		struct acpi_data_node *dn;
+
+		head = &adev->data.subnodes;
+		if (list_empty(head))
+			return NULL;
+
+		if (child) {
+			dn = to_acpi_data_node(child);
+			next = dn->sibling.next;
+			if (next == head)
+				return NULL;
+
+			dn = list_entry(next, struct acpi_data_node, sibling);
+		} else {
+			dn = list_first_entry(head, struct acpi_data_node, sibling);
+		}
+		return &dn->fwnode;
+	}
+	return NULL;
+}
Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -481,11 +481,7 @@ struct fwnode_handle *device_get_next_ch
 		if (node)
 			return &node->fwnode;
 	} else if (IS_ENABLED(CONFIG_ACPI)) {
-		struct acpi_device *node;
-
-		node = acpi_get_next_child(dev, to_acpi_device_node(child));
-		if (node)
-			return acpi_fwnode_handle(node);
+		return acpi_get_next_subnode(dev, child);
 	}
 	return NULL;
 }
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -758,9 +758,9 @@ struct acpi_reference_args {
 #ifdef CONFIG_ACPI
 int acpi_dev_get_property(struct acpi_device *adev, const char *name,
 			  acpi_object_type type, const union acpi_object **obj);
-int acpi_dev_get_property_reference(struct acpi_device *adev,
-				    const char *name, size_t index,
-				    struct acpi_reference_args *args);
+int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+				     const char *name, size_t index,
+				     struct acpi_reference_args *args);
 
 int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
@@ -771,8 +771,8 @@ int acpi_node_prop_read(struct fwnode_ha
 int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
-struct acpi_device *acpi_get_next_child(struct device *dev,
-					struct acpi_device *child);
+struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+					    struct fwnode_handle *subnode);
 #else
 static inline int acpi_dev_get_property(struct acpi_device *adev,
 					const char *name, acpi_object_type type,
@@ -781,7 +781,7 @@ static inline int acpi_dev_get_property(
 	return -ENXIO;
 }
 
-static inline int acpi_dev_get_property_reference(struct acpi_device *adev,
+static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
 				const char *name, const char *cells_name,
 				size_t index, struct acpi_reference_args *args)
 {
@@ -826,12 +826,11 @@ static inline int acpi_dev_prop_read(str
 	return -ENXIO;
 }
 
-static inline struct acpi_device *acpi_get_next_child(struct device *dev,
-						      struct acpi_device *child)
+static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+						struct fwnode_handle *subnode)
 {
 	return NULL;
 }
-
 #endif
 
 #endif	/*_LINUX_ACPI_H*/
Index: linux-pm/drivers/gpio/gpiolib.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib.c
+++ linux-pm/drivers/gpio/gpiolib.c
@@ -2056,11 +2056,10 @@ struct gpio_desc *fwnode_get_named_gpiod
 						&flags);
 		if (!IS_ERR(desc))
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
-	} else if (is_acpi_device_node(fwnode)) {
+	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
 
-		desc = acpi_get_gpiod_by_index(to_acpi_device_node(fwnode),
-					       propname, 0, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, 0, &info);
 		if (!IS_ERR(desc))
 			active_low = info.active_low;
 	}
Index: linux-pm/drivers/gpio/gpiolib-acpi.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib-acpi.c
+++ linux-pm/drivers/gpio/gpiolib-acpi.c
@@ -453,7 +453,7 @@ static int acpi_gpio_resource_lookup(str
 	return 0;
 }
 
-static int acpi_gpio_property_lookup(struct acpi_device *adev,
+static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode,
 				     const char *propname, int index,
 				     struct acpi_gpio_lookup *lookup)
 {
@@ -461,10 +461,16 @@ static int acpi_gpio_property_lookup(str
 	int ret;
 
 	memset(&args, 0, sizeof(args));
-	ret = acpi_dev_get_property_reference(adev, propname, index, &args);
-	if (ret && !acpi_get_driver_gpio_data(adev, propname, index, &args))
-		return ret;
+	ret = acpi_node_get_property_reference(fwnode, propname, index, &args);
+	if (ret) {
+		struct acpi_device *adev = to_acpi_device_node(fwnode);
 
+		if (!adev)
+			return ret;
+
+		if (!acpi_get_driver_gpio_data(adev, propname, index, &args))
+			return ret;
+	}
 	/*
 	 * The property was found and resolved, so need to lookup the GPIO based
 	 * on returned args.
@@ -518,7 +524,8 @@ struct gpio_desc *acpi_get_gpiod_by_inde
 	if (propname) {
 		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
 
-		ret = acpi_gpio_property_lookup(adev, propname, index, &lookup);
+		ret = acpi_gpio_property_lookup(acpi_fwnode_handle(adev),
+						propname, index, &lookup);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -532,6 +539,47 @@ struct gpio_desc *acpi_get_gpiod_by_inde
 
 	ret = acpi_gpio_resource_lookup(&lookup, info);
 	return ret ? ERR_PTR(ret) : lookup.desc;
+}
+
+/**
+ * acpi_node_get_gpiod() - get a GPIO descriptor from ACPI resources
+ * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
+ * @propname: Property name of the GPIO
+ * @index: index of GpioIo/GpioInt resource (starting from %0)
+ * @info: info pointer to fill in (optional)
+ *
+ * If @fwnode is an ACPI device object, call %acpi_get_gpiod_by_index() for it.
+ * Otherwise (ie. it is a data-only non-device object), use the property-based
+ * GPIO lookup to get to the GPIO resource with the relevant information and use
+ * that to obtain the GPIO descriptor to return.
+ */
+struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
+				      const char *propname, int index,
+				      struct acpi_gpio_info *info)
+{
+	struct acpi_gpio_lookup lookup;
+	struct acpi_device *adev;
+	int ret;
+
+	adev = to_acpi_device_node(fwnode);
+	if (adev)
+		return acpi_get_gpiod_by_index(adev, propname, index, info);
+
+	if (!is_acpi_data_node(fwnode))
+		return ERR_PTR(-ENODEV);
+
+	if (!propname)
+		return ERR_PTR(-EINVAL);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.index = index;
+
+	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = acpi_gpio_resource_lookup(&lookup, info);
+	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
 /**
Index: linux-pm/drivers/gpio/gpiolib.h
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib.h
+++ linux-pm/drivers/gpio/gpiolib.h
@@ -42,6 +42,9 @@ void acpi_gpiochip_free_interrupts(struc
 struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 					  const char *propname, int index,
 					  struct acpi_gpio_info *info);
+struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
+				      const char *propname, int index,
+				      struct acpi_gpio_info *info);
 
 int acpi_gpio_count(struct device *dev, const char *con_id);
 #else
@@ -60,7 +63,12 @@ acpi_get_gpiod_by_index(struct acpi_devi
 {
 	return ERR_PTR(-ENOSYS);
 }
-
+static inline struct gpio_desc *
+acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
+		    int index, struct acpi_gpio_info *info)
+{
+	return ERR_PTR(-ENXIO);
+}
 static inline int acpi_gpio_count(struct device *dev, const char *con_id)
 {
 	return -ENODEV;
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -695,26 +695,6 @@ int acpi_device_add(struct acpi_device *
 	return result;
 }
 
-struct acpi_device *acpi_get_next_child(struct device *dev,
-					struct acpi_device *child)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct list_head *head, *next;
-
-	if (!adev)
-		return NULL;
-
-	head = &adev->children;
-	if (list_empty(head))
-		return NULL;
-
-	if (!child)
-		return list_first_entry(head, struct acpi_device, node);
-
-	next = child->node.next;
-	return next == head ? NULL : list_entry(next, struct acpi_device, node);
-}
-
 /* --------------------------------------------------------------------------
                                  Device Enumeration
    -------------------------------------------------------------------------- */
