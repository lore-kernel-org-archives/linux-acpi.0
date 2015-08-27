From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/6] ACPI / property: Extend fwnode_property_* to data-only subnodes
Date: Thu, 27 Aug 2015 04:40:05 +0200
Message-ID: <1656538.3VtrneeyAU@vostro.rjw.lan>
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

Modify is_acpi_node() to return "true" for ACPI data-only subnodes as
well as for ACPI device objects and change the name of to_acpi_node()
to to_acpi_device_node() so it is clear that it covers ACPI device
objects only.  Accordingly, introduce to_acpi_data_node() to cover
data-only subnodes in an analogous way.

With that, make the fwnode_property_* family of functions work with
ACPI data-only subnodes introduced previously.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c |  138 ++++++++++++++++++++++++++++++++++++------------
 drivers/base/property.c |   16 ++---
 drivers/gpio/gpiolib.c  |    6 +-
 include/acpi/acpi_bus.h |   21 ++++++-
 include/linux/acpi.h    |   53 +++++++++++++-----
 5 files changed, 173 insertions(+), 61 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -425,15 +425,32 @@ static inline bool acpi_check_dma(struct
 
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
+	return fwnode && (fwnode->type == FWNODE_ACPI
+		|| fwnode->type == FWNODE_ACPI_DATA);
+}
+
+static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
+{
 	return fwnode && fwnode->type == FWNODE_ACPI;
 }
 
-static inline struct acpi_device *to_acpi_node(struct fwnode_handle *fwnode)
+static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
 {
-	return is_acpi_node(fwnode) ?
+	return is_acpi_device_node(fwnode) ?
 		container_of(fwnode, struct acpi_device, fwnode) : NULL;
 }
 
+static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
+}
+
+static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
+{
+	return is_acpi_data_node(fwnode) ?
+		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
+}
+
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 {
 	return &adev->fwnode;
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -49,7 +49,7 @@ static inline acpi_handle acpi_device_ha
 	return adev ? adev->handle : NULL;
 }
 
-#define ACPI_COMPANION(dev)		to_acpi_node((dev)->fwnode)
+#define ACPI_COMPANION(dev)		to_acpi_device_node((dev)->fwnode)
 #define ACPI_COMPANION_SET(dev, adev)	set_primary_fwnode(dev, (adev) ? \
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
@@ -69,7 +69,7 @@ static inline acpi_handle acpi_device_ha
 
 static inline bool has_acpi_companion(struct device *dev)
 {
-	return is_acpi_node(dev->fwnode);
+	return is_acpi_device_node(dev->fwnode);
 }
 
 static inline void acpi_preset_companion(struct device *dev,
@@ -461,7 +461,22 @@ static inline bool is_acpi_node(struct f
 	return false;
 }
 
-static inline struct acpi_device *to_acpi_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
+{
+	return false;
+}
+
+static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
+static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
+{
+	return false;
+}
+
+static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
@@ -743,17 +758,16 @@ struct acpi_reference_args {
 #ifdef CONFIG_ACPI
 int acpi_dev_get_property(struct acpi_device *adev, const char *name,
 			  acpi_object_type type, const union acpi_object **obj);
-int acpi_dev_get_property_array(struct acpi_device *adev, const char *name,
-				acpi_object_type type,
-				const union acpi_object **obj);
 int acpi_dev_get_property_reference(struct acpi_device *adev,
 				    const char *name, size_t index,
 				    struct acpi_reference_args *args);
 
-int acpi_dev_prop_get(struct acpi_device *adev, const char *propname,
-		      void **valptr);
+int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
+		       void **valptr);
 int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
 			      enum dev_prop_type proptype, void *val);
+int acpi_node_prop_read(struct fwnode_handle *fwnode, const char *propname,
+		        enum dev_prop_type proptype, void *val, size_t nval);
 int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
@@ -766,13 +780,7 @@ static inline int acpi_dev_get_property(
 {
 	return -ENXIO;
 }
-static inline int acpi_dev_get_property_array(struct acpi_device *adev,
-					      const char *name,
-					      acpi_object_type type,
-					      const union acpi_object **obj)
-{
-	return -ENXIO;
-}
+
 static inline int acpi_dev_get_property_reference(struct acpi_device *adev,
 				const char *name, const char *cells_name,
 				size_t index, struct acpi_reference_args *args)
@@ -780,6 +788,13 @@ static inline int acpi_dev_get_property_
 	return -ENXIO;
 }
 
+static inline int acpi_node_prop_get(struct fwnode_handle *fwnode,
+				     const char *propname,
+				     void **valptr)
+{
+	return -ENXIO;
+}
+
 static inline int acpi_dev_prop_get(struct acpi_device *adev,
 				    const char *propname,
 				    void **valptr)
@@ -794,6 +809,14 @@ static inline int acpi_dev_prop_read_sin
 {
 	return -ENXIO;
 }
+
+static inline int acpi_node_prop_read(struct fwnode_handle *fwnode,
+				      const char *propname,
+				      enum dev_prop_type proptype,
+				      void *val, size_t nval)
+{
+	return -ENXIO;
+}
 
 static inline int acpi_dev_prop_read(struct acpi_device *adev,
 				     const char *propname,
Index: linux-pm/drivers/gpio/gpiolib.c
===================================================================
--- linux-pm.orig/drivers/gpio/gpiolib.c
+++ linux-pm/drivers/gpio/gpiolib.c
@@ -2056,11 +2056,11 @@ struct gpio_desc *fwnode_get_named_gpiod
 						&flags);
 		if (!IS_ERR(desc))
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
-	} else if (is_acpi_node(fwnode)) {
+	} else if (is_acpi_device_node(fwnode)) {
 		struct acpi_gpio_info info;
 
-		desc = acpi_get_gpiod_by_index(to_acpi_node(fwnode), propname, 0,
-					       &info);
+		desc = acpi_get_gpiod_by_index(to_acpi_device_node(fwnode),
+					       propname, 0, &info);
 		if (!IS_ERR(desc))
 			active_low = info.active_low;
 	}
Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -132,7 +132,7 @@ bool fwnode_property_present(struct fwno
 	if (is_of_node(fwnode))
 		return of_property_read_bool(to_of_node(fwnode), propname);
 	else if (is_acpi_node(fwnode))
-		return !acpi_dev_prop_get(to_acpi_node(fwnode), propname, NULL);
+		return !acpi_node_prop_get(fwnode, propname, NULL);
 
 	return !!pset_prop_get(to_pset(fwnode), propname);
 }
@@ -290,8 +290,8 @@ EXPORT_SYMBOL_GPL(device_property_read_s
 		_ret_ = OF_DEV_PROP_READ_ARRAY(to_of_node(_fwnode_), _propname_, \
 					       _type_, _val_, _nval_); \
 	else if (is_acpi_node(_fwnode_)) \
-		_ret_ = acpi_dev_prop_read(to_acpi_node(_fwnode_), _propname_, \
-					   _proptype_, _val_, _nval_); \
+		_ret_ = acpi_node_prop_read(_fwnode_, _propname_, _proptype_, \
+					    _val_, _nval_); \
 	else \
 		_ret_ = pset_prop_read_array(to_pset(_fwnode_), _propname_, \
 					     _proptype_, _val_, _nval_); \
@@ -430,8 +430,8 @@ int fwnode_property_read_string_array(st
 						      propname, val, nval) :
 			of_property_count_strings(to_of_node(fwnode), propname);
 	else if (is_acpi_node(fwnode))
-		return acpi_dev_prop_read(to_acpi_node(fwnode), propname,
-					  DEV_PROP_STRING, val, nval);
+		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					   val, nval);
 
 	return pset_prop_read_array(to_pset(fwnode), propname,
 				    DEV_PROP_STRING, val, nval);
@@ -459,8 +459,8 @@ int fwnode_property_read_string(struct f
 	if (is_of_node(fwnode))
 		return of_property_read_string(to_of_node(fwnode), propname, val);
 	else if (is_acpi_node(fwnode))
-		return acpi_dev_prop_read(to_acpi_node(fwnode), propname,
-					  DEV_PROP_STRING, val, 1);
+		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					   val, 1);
 
 	return -ENXIO;
 }
@@ -483,7 +483,7 @@ struct fwnode_handle *device_get_next_ch
 	} else if (IS_ENABLED(CONFIG_ACPI)) {
 		struct acpi_device *node;
 
-		node = acpi_get_next_child(dev, to_acpi_node(child));
+		node = acpi_get_next_child(dev, to_acpi_device_node(child));
 		if (node)
 			return acpi_fwnode_handle(node);
 	}
Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -19,6 +19,11 @@
 
 #include "internal.h"
 
+static int acpi_data_get_property_array(struct acpi_device_data *data,
+					const char *name,
+					acpi_object_type type,
+					const union acpi_object **obj);
+
 /* ACPI _DSD device properties UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
 static const u8 prp_uuid[16] = {
 	0x14, 0xd8, 0xff, 0xda, 0xba, 0x6e, 0x8c, 0x4d,
@@ -191,8 +196,8 @@ static void acpi_init_of_compatible(stru
 	const union acpi_object *of_compatible;
 	int ret;
 
-	ret = acpi_dev_get_property_array(adev, "compatible", ACPI_TYPE_STRING,
-					  &of_compatible);
+	ret = acpi_data_get_property_array(&adev->data, "compatible",
+					   ACPI_TYPE_STRING, &of_compatible);
 	if (ret) {
 		ret = acpi_dev_get_property(adev, "compatible",
 					    ACPI_TYPE_STRING, &of_compatible);
@@ -320,8 +325,8 @@ void acpi_free_properties(struct acpi_de
 }
 
 /**
- * acpi_dev_get_property - return an ACPI property with given name
- * @adev: ACPI device to get property
+ * acpi_data_get_property - return an ACPI property with given name
+ * @data: ACPI device deta object to get the property from
  * @name: Name of the property
  * @type: Expected property type
  * @obj: Location to store the property value (if not %NULL)
@@ -330,26 +335,27 @@ void acpi_free_properties(struct acpi_de
  * object at the location pointed to by @obj if found.
  *
  * Callers must not attempt to free the returned objects.  These objects will be
- * freed by the ACPI core automatically during the removal of @adev.
+ * freed by the ACPI core automatically during the removal of @data.
  *
  * Return: %0 if property with @name has been found (success),
  *         %-EINVAL if the arguments are invalid,
  *         %-ENODATA if the property doesn't exist,
  *         %-EPROTO if the property value type doesn't match @type.
  */
-int acpi_dev_get_property(struct acpi_device *adev, const char *name,
-			  acpi_object_type type, const union acpi_object **obj)
+static int acpi_data_get_property(struct acpi_device_data *data,
+				  const char *name, acpi_object_type type,
+				  const union acpi_object **obj)
 {
 	const union acpi_object *properties;
 	int i;
 
-	if (!adev || !name)
+	if (!data || !name)
 		return -EINVAL;
 
-	if (!adev->data.pointer || !adev->data.properties)
+	if (!data->pointer || !data->properties)
 		return -ENODATA;
 
-	properties = adev->data.properties;
+	properties = data->properties;
 	for (i = 0; i < properties->package.count; i++) {
 		const union acpi_object *propname, *propvalue;
 		const union acpi_object *property;
@@ -370,11 +376,50 @@ int acpi_dev_get_property(struct acpi_de
 	}
 	return -ENODATA;
 }
+
+/**
+ * acpi_dev_get_property - return an ACPI property with given name.
+ * @adev: ACPI device to get the property from.
+ * @name: Name of the property.
+ * @type: Expected property type.
+ * @obj: Location to store the property value (if not %NULL).
+ */
+int acpi_dev_get_property(struct acpi_device *adev, const char *name,
+			  acpi_object_type type, const union acpi_object **obj)
+{
+	return adev ? acpi_data_get_property(&adev->data, name, type, obj) : -EINVAL;
+}
 EXPORT_SYMBOL_GPL(acpi_dev_get_property);
 
+static struct acpi_device_data *acpi_device_data_of_node(struct fwnode_handle *fwnode)
+{
+	if (fwnode->type == FWNODE_ACPI) {
+		struct acpi_device *adev = to_acpi_device_node(fwnode);
+		return &adev->data;
+	} else if (fwnode->type == FWNODE_ACPI_DATA) {
+		struct acpi_data_node *dn = to_acpi_data_node(fwnode);
+		return &dn->data;
+	}
+	return NULL;
+}
+
 /**
- * acpi_dev_get_property_array - return an ACPI array property with given name
- * @adev: ACPI device to get property
+ * acpi_node_prop_get - return an ACPI property with given name.
+ * @fwnode: Firmware node to get the property from.
+ * @propname: Name of the property.
+ * @valptr: Location to store a pointer to the property value (if not %NULL).
+ */
+int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
+		       void **valptr)
+{
+	return acpi_data_get_property(acpi_device_data_of_node(fwnode),
+				      propname, ACPI_TYPE_ANY,
+				      (const union acpi_object **)valptr);
+}
+
+/**
+ * acpi_data_get_property_array - return an ACPI array property with given name
+ * @adev: ACPI data object to get the property from
  * @name: Name of the property
  * @type: Expected type of array elements
  * @obj: Location to store a pointer to the property value (if not NULL)
@@ -383,7 +428,7 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_property)
  * ACPI object at the location pointed to by @obj if found.
  *
  * Callers must not attempt to free the returned objects.  Those objects will be
- * freed by the ACPI core automatically during the removal of @adev.
+ * freed by the ACPI core automatically during the removal of @data.
  *
  * Return: %0 if array property (package) with @name has been found (success),
  *         %-EINVAL if the arguments are invalid,
@@ -391,14 +436,15 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_property)
  *         %-EPROTO if the property is not a package or the type of its elements
  *           doesn't match @type.
  */
-int acpi_dev_get_property_array(struct acpi_device *adev, const char *name,
-				acpi_object_type type,
-				const union acpi_object **obj)
+static int acpi_data_get_property_array(struct acpi_device_data *data,
+					const char *name,
+					acpi_object_type type,
+					const union acpi_object **obj)
 {
 	const union acpi_object *prop;
 	int ret, i;
 
-	ret = acpi_dev_get_property(adev, name, ACPI_TYPE_PACKAGE, &prop);
+	ret = acpi_data_get_property(data, name, ACPI_TYPE_PACKAGE, &prop);
 	if (ret)
 		return ret;
 
@@ -413,7 +459,6 @@ int acpi_dev_get_property_array(struct a
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_get_property_array);
 
 /**
  * acpi_dev_get_property_reference - returns handle to the referenced object
@@ -518,15 +563,9 @@ int acpi_dev_get_property_reference(stru
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_property_reference);
 
-int acpi_dev_prop_get(struct acpi_device *adev, const char *propname,
-		      void **valptr)
-{
-	return acpi_dev_get_property(adev, propname, ACPI_TYPE_ANY,
-				     (const union acpi_object **)valptr);
-}
-
-int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
-			      enum dev_prop_type proptype, void *val)
+static int acpi_data_prop_read_single(struct acpi_device_data *data,
+				      const char *propname,
+				      enum dev_prop_type proptype, void *val)
 {
 	const union acpi_object *obj;
 	int ret;
@@ -535,7 +574,7 @@ int acpi_dev_prop_read_single(struct acp
 		return -EINVAL;
 
 	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
-		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_INTEGER, &obj);
+		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
 		if (ret)
 			return ret;
 
@@ -560,7 +599,7 @@ int acpi_dev_prop_read_single(struct acp
 			break;
 		}
 	} else if (proptype == DEV_PROP_STRING) {
-		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_STRING, &obj);
+		ret = acpi_data_get_property(data, propname, ACPI_TYPE_STRING, &obj);
 		if (ret)
 			return ret;
 
@@ -571,6 +610,12 @@ int acpi_dev_prop_read_single(struct acp
 	return ret;
 }
 
+int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
+			      enum dev_prop_type proptype, void *val)
+{
+	return adev ? acpi_data_prop_read_single(&adev->data, propname, proptype, val) : -EINVAL;
+}
+
 static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
 				       size_t nval)
 {
@@ -647,20 +692,22 @@ static int acpi_copy_property_array_stri
 	return 0;
 }
 
-int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
-		       enum dev_prop_type proptype, void *val, size_t nval)
+static int acpi_data_prop_read(struct acpi_device_data *data,
+			       const char *propname,
+			       enum dev_prop_type proptype,
+			       void *val, size_t nval)
 {
 	const union acpi_object *obj;
 	const union acpi_object *items;
 	int ret;
 
 	if (val && nval == 1) {
-		ret = acpi_dev_prop_read_single(adev, propname, proptype, val);
+		ret = acpi_data_prop_read_single(data, propname, proptype, val);
 		if (!ret)
 			return ret;
 	}
 
-	ret = acpi_dev_get_property_array(adev, propname, ACPI_TYPE_ANY, &obj);
+	ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
 	if (ret)
 		return ret;
 
@@ -695,3 +742,28 @@ int acpi_dev_prop_read(struct acpi_devic
 	}
 	return ret;
 }
+
+int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
+		       enum dev_prop_type proptype, void *val, size_t nval)
+{
+	return adev ? acpi_data_prop_read(&adev->data, propname, proptype, val, nval) : -EINVAL;
+}
+
+/**
+ * acpi_node_prop_read - retrieve the value of an ACPI property with given name.
+ * @fwnode: Firmware node to get the property from.
+ * @propname: Name of the property.
+ * @proptype: Expected property type.
+ * @val: Location to store the property value (if not %NULL).
+ * @nval: Size of the array pointed to by @val.
+ *
+ * If @val is %NULL, return the number of array elements comprising the value
+ * of the property.  Otherwise, read at most @nval values to the array at the
+ * location pointed to by @val.
+ */
+int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
+		        enum dev_prop_type proptype, void *val, size_t nval)
+{
+	return acpi_data_prop_read(acpi_device_data_of_node(fwnode),
+				   propname, proptype, val, nval);
+}
