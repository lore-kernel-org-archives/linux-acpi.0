From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/3] device property: Move FW type specific functionality to FW specific files
Date: Fri, 24 Mar 2017 13:03:50 +0200
Message-ID: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The device and fwnode property API supports Devicetree, ACPI and pset
properties. The implementation of this functionality for each firmware
type was embedded in the fwnode property core. Move it out to firmware
type specific locations, making it easier to maintain.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c |  87 +++++++++++++++
 drivers/acpi/scan.c     |   1 +
 drivers/base/property.c | 280 +++++++++++++++++++-----------------------------
 drivers/of/property.c   |  99 +++++++++++++++++
 include/linux/acpi.h    |   4 +
 include/linux/fwnode.h  |  53 +++++++++
 include/linux/of.h      |   2 +
 7 files changed, 355 insertions(+), 171 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 9eb7c13..99b81f5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -57,6 +57,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 
 	dn->name = link->package.elements[0].string.pointer;
 	dn->fwnode.type = FWNODE_ACPI_DATA;
+	dn->fwnode.ops = &acpi_fwnode_ops;
 	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
@@ -1107,3 +1108,89 @@ int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
 
 	return 0;
 }
+
+static bool acpi_fwnode_property_present(struct fwnode_handle *fwnode,
+					 const char *propname)
+{
+	return !acpi_node_prop_get(fwnode, propname, NULL);
+}
+
+static int acpi_fwnode_property_read_int_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	unsigned int elem_size, void *val, size_t nval)
+{
+	enum dev_prop_type type;
+
+	switch (elem_size) {
+	case sizeof(u8):
+		type = DEV_PROP_U8;
+		break;
+	case sizeof(u16):
+		type = DEV_PROP_U16;
+		break;
+	case sizeof(u32):
+		type = DEV_PROP_U32;
+		break;
+	case sizeof(u64):
+		type = DEV_PROP_U64;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	return acpi_node_prop_read(fwnode, propname, type, val, nval);
+}
+
+static int acpi_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname, const char **val,
+	size_t nval)
+{
+	int array_len = acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					    NULL, nval);
+	int read_len;
+	int ret;
+
+	/* Return if val is NULL or if there was an error */
+	if (!val || array_len < 0)
+		return array_len;
+
+	read_len = min_t(int, nval, array_len);
+
+	ret = acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+				  val, read_len);
+	if (ret < 0)
+		return ret;
+
+	return read_len;
+}
+
+static struct fwnode_handle *acpi_fwnode_get_parent(
+	struct fwnode_handle *fwnode)
+{
+	return acpi_node_get_parent(fwnode);
+}
+
+static struct fwnode_handle *acpi_fwnode_get_named_child_node(
+	struct fwnode_handle *fwnode, const char *childname)
+{
+	struct fwnode_handle *child;
+
+	/*
+	 * Find first matching named child node of this fwnode.
+	 * For ACPI this will be a data only sub-node.
+	 */
+	fwnode_for_each_child_node(fwnode, child)
+		if (acpi_data_node_match(child, childname))
+			return child;
+
+	return NULL;
+}
+
+const struct fwnode_operations acpi_fwnode_ops = {
+	.property_present = acpi_fwnode_property_present,
+	.property_read_int_array = acpi_fwnode_property_read_int_array,
+	.property_read_string_array = acpi_fwnode_property_read_string_array,
+	.get_parent = acpi_fwnode_get_parent,
+	.get_next_child_node = acpi_get_next_subnode,
+	.get_named_child_node = acpi_fwnode_get_named_child_node,
+};
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..901720f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1441,6 +1441,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
 	device->fwnode.type = FWNODE_ACPI;
+	device->fwnode.ops = &acpi_fwnode_ops;
 	acpi_set_device_status(device, sta);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 325dd7f..3fcb13c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -165,6 +165,77 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
+static bool pset_fwnode_property_present(struct fwnode_handle *fwnode,
+					 const char *propname)
+{
+	return !!pset_prop_get(to_pset_node(fwnode), propname);
+}
+
+static int pset_fwnode_read_int_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	unsigned int elem_size, void *val, size_t nval)
+{
+	struct property_set *node = to_pset_node(fwnode);
+
+	if (!val)
+		return pset_prop_count_elems_of_size(node, propname, elem_size);
+
+	switch (elem_size) {
+	case sizeof(u8):
+		return pset_prop_read_u8_array(node, propname, val, nval);
+	case sizeof(u16):
+		return pset_prop_read_u16_array(node, propname, val, nval);
+	case sizeof(u32):
+		return pset_prop_read_u32_array(node, propname, val, nval);
+	case sizeof(u64):
+		return pset_prop_read_u64_array(node, propname, val, nval);
+	}
+
+	return -ENXIO;
+}
+
+static int pset_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname, const char **val,
+	size_t nval)
+{
+	struct property_set *node = to_pset_node(fwnode);
+	const struct property_entry *prop;
+	/* The array length for a non-array string property is 1. */
+	int array_len = 1;
+	int read_len;
+	int ret;
+
+	prop = pset_prop_get(node, propname);
+	if (!prop)
+		return -EINVAL;
+
+	/* Read the length of an array property. */
+	if (prop->is_array)
+		array_len = pset_prop_count_elems_of_size(
+			node, propname, sizeof(const char *));
+
+
+	/* Return if val is NULL or if there was an error */
+	if (!val || array_len < 0)
+		return array_len;
+
+	read_len = min_t(int, nval, array_len);
+
+	ret = pset_prop_read_string_array(node, propname, val, read_len);
+
+	if (ret < 0)
+		return ret;
+
+	/* Return the length of an array. */
+	return read_len;
+}
+
+static const struct fwnode_operations pset_fwnode_ops = {
+	.property_present = pset_fwnode_property_present,
+	.property_read_int_array = pset_fwnode_read_int_array,
+	.property_read_string_array = pset_fwnode_property_read_string_array,
+};
+
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
@@ -178,18 +249,6 @@ bool device_property_present(struct device *dev, const char *propname)
 }
 EXPORT_SYMBOL_GPL(device_property_present);
 
-static bool __fwnode_property_present(struct fwnode_handle *fwnode,
-				      const char *propname)
-{
-	if (is_of_node(fwnode))
-		return of_property_read_bool(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return !acpi_node_prop_get(fwnode, propname, NULL);
-	else if (is_pset_node(fwnode))
-		return !!pset_prop_get(to_pset_node(fwnode), propname);
-	return false;
-}
-
 /**
  * fwnode_property_present - check if a property of a firmware node is present
  * @fwnode: Firmware node whose property to check
@@ -199,10 +258,11 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 {
 	bool ret;
 
-	ret = __fwnode_property_present(fwnode, propname);
+	ret = fwnode_call_int_op(fwnode, property_present, propname);
 	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
 	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = __fwnode_property_present(fwnode->secondary, propname);
+		ret = fwnode_call_int_op(fwnode->secondary, property_present,
+					 propname);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
@@ -376,42 +436,22 @@ int device_property_match_string(struct device *dev, const char *propname,
 }
 EXPORT_SYMBOL_GPL(device_property_match_string);
 
-#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)				\
-	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval))	\
-	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
-
-#define PSET_PROP_READ_ARRAY(node, propname, type, val, nval)				\
-	(val) ? pset_prop_read_##type##_array((node), (propname), (val), (nval))	\
-	      : pset_prop_count_elems_of_size((node), (propname), sizeof(type))
-
-#define FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
-({											\
-	int _ret_;									\
-	if (is_of_node(_fwnode_))							\
-		_ret_ = OF_DEV_PROP_READ_ARRAY(to_of_node(_fwnode_), _propname_,	\
-					       _type_, _val_, _nval_);			\
-	else if (is_acpi_node(_fwnode_))						\
-		_ret_ = acpi_node_prop_read(_fwnode_, _propname_, _proptype_,		\
-					    _val_, _nval_);				\
-	else if (is_pset_node(_fwnode_)) 						\
-		_ret_ = PSET_PROP_READ_ARRAY(to_pset_node(_fwnode_), _propname_,	\
-					     _type_, _val_, _nval_);			\
-	else										\
-		_ret_ = -ENXIO;								\
-	_ret_;										\
-})
-
-#define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_)	\
-({											\
-	int _ret_;									\
-	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
-				 _val_, _nval_);					\
-	if (_ret_ == -EINVAL && !IS_ERR_OR_NULL(_fwnode_) &&				\
-	    !IS_ERR_OR_NULL(_fwnode_->secondary))					\
-		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
-				_proptype_, _val_, _nval_);				\
-	_ret_;										\
-})
+static int fwnode_property_read_int_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	unsigned int elem_size, void *val, size_t nval)
+{
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
+				 elem_size, val, nval);
+	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
+	    !IS_ERR_OR_NULL(fwnode->secondary))
+		ret = fwnode_call_int_op(
+			fwnode->secondary, property_read_int_array, propname,
+			elem_size, val, nval);
+
+	return ret;
+}
 
 /**
  * fwnode_property_read_u8_array - return a u8 array property of firmware node
@@ -434,8 +474,8 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u8, DEV_PROP_U8,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u8),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
 
@@ -460,8 +500,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
 int fwnode_property_read_u16_array(struct fwnode_handle *fwnode,
 				   const char *propname, u16 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u16, DEV_PROP_U16,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u16),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
 
@@ -486,8 +526,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
 int fwnode_property_read_u32_array(struct fwnode_handle *fwnode,
 				   const char *propname, u32 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u32, DEV_PROP_U32,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u32),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
 
@@ -512,75 +552,11 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
 int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
 				   const char *propname, u64 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u64, DEV_PROP_U64,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u64),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
 
-static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
-					       const char *propname,
-					       const char **val, size_t nval)
-{
-	if (is_of_node(fwnode))
-		return val ?
-			of_property_read_string_array(to_of_node(fwnode),
-						      propname, val, nval) :
-			of_property_count_strings(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode)) {
-		int array_len =
-			acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					    NULL, nval);
-		int read_len;
-		int ret;
-
-		/* Return if val is NULL or if there was an error */
-		if (!val || array_len < 0)
-			return array_len;
-
-		read_len = min_t(int, nval, array_len);
-
-		ret = acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					  val, read_len);
-		if (ret < 0)
-			return ret;
-
-		return read_len;
-	} else if (is_pset_node(fwnode)) {
-		struct property_set *node = to_pset_node(fwnode);
-		const struct property_entry *prop;
-		/* The array length for a non-array string property is 1. */
-		int array_len = 1;
-		int read_len;
-		int ret;
-
-		prop = pset_prop_get(node, propname);
-		if (!prop)
-			return -EINVAL;
-
-		/* Read the length of an array property. */
-		if (prop->is_array)
-			array_len = pset_prop_count_elems_of_size(
-				node, propname, sizeof(const char *));
-
-
-		/* Return if val is NULL or if there was an error */
-		if (!val || array_len < 0)
-			return array_len;
-
-		read_len = min_t(int, nval, array_len);
-
-		ret = pset_prop_read_string_array(node, propname, val,
-						  read_len);
-
-		if (ret < 0)
-			return ret;
-
-		/* Return the length of an array. */
-		return read_len;
-	}
-	return -ENXIO;
-}
-
 /**
  * fwnode_property_read_string_array - return string array property of a node
  * @fwnode: Firmware node to get the property of
@@ -605,11 +581,13 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 {
 	int ret;
 
-	ret = __fwnode_property_read_string_array(fwnode, propname, val, nval);
+	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
+				 val, nval);
 	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
 	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = __fwnode_property_read_string_array(fwnode->secondary,
-							  propname, val, nval);
+		ret = fwnode_call_int_op(fwnode->secondary,
+					 property_read_string_array, propname,
+					 val, nval);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
@@ -927,6 +905,7 @@ int device_add_properties(struct device *dev,
 		return PTR_ERR(p);
 
 	p->fwnode.type = FWNODE_PDATA;
+	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
 	return 0;
 }
@@ -962,19 +941,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  */
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_get_parent(to_of_node(fwnode));
-		if (node)
-			parent = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		parent = acpi_node_get_parent(fwnode);
-	}
-
-	return parent;
+	return fwnode_call_ptr_op(fwnode, get_parent);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_parent);
 
@@ -986,18 +953,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
 struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child)
 {
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_get_next_available_child(to_of_node(fwnode),
-						   to_of_node(child));
-		if (node)
-			return &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		return acpi_get_next_subnode(fwnode, child);
-	}
-
-	return NULL;
+	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
@@ -1029,23 +985,7 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
 struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 						  const char *childname)
 {
-	struct fwnode_handle *child;
-
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child) {
-		if (is_of_node(child)) {
-			if (!of_node_cmp(to_of_node(child)->name, childname))
-				return child;
-		} else if (is_acpi_data_node(child)) {
-			if (acpi_data_node_match(child, childname))
-				return child;
-		}
-	}
-
-	return NULL;
+	return fwnode_call_ptr_op(fwnode, get_named_child_node, childname);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
@@ -1067,8 +1007,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  */
 void fwnode_handle_get(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_get(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, get);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_get);
 
@@ -1082,8 +1021,7 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
  */
 void fwnode_handle_put(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_put(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, put);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index afcf00a..6a2d6c4 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -725,3 +725,102 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 	return remote;
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
+
+static void of_fwnode_get(struct fwnode_handle *fwnode)
+{
+	of_node_get(to_of_node(fwnode));
+}
+
+static void of_fwnode_put(struct fwnode_handle *fwnode)
+{
+	of_node_put(to_of_node(fwnode));
+}
+
+static bool of_fwnode_property_present(struct fwnode_handle *fwnode,
+				       const char *propname)
+{
+	return of_property_read_bool(to_of_node(fwnode), propname);
+}
+
+static int of_fwnode_property_read_int_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	unsigned int elem_size, void *val, size_t nval)
+{
+	struct device_node *node = to_of_node(fwnode);
+
+	if (!val)
+		return of_property_count_elems_of_size(node, propname,
+						       elem_size);
+
+	switch (elem_size) {
+	case sizeof(u8):
+		return of_property_read_u8_array(node, propname, val, nval);
+	case sizeof(u16):
+		return of_property_read_u16_array(node, propname, val, nval);
+	case sizeof(u32):
+		return of_property_read_u32_array(node, propname, val, nval);
+	case sizeof(u64):
+		return of_property_read_u64_array(node, propname, val, nval);
+	}
+
+	return -ENXIO;
+}
+
+static int of_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	const char **val, size_t nval)
+{
+	struct device_node *node = to_of_node(fwnode);
+
+	return val ?
+		of_property_read_string_array(node, propname, val, nval) :
+		of_property_count_strings(node, propname);
+}
+
+static struct fwnode_handle *of_fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_get_parent(to_of_node(fwnode));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static struct fwnode_handle *of_fwnode_get_next_child_node(
+	struct fwnode_handle *fwnode, struct fwnode_handle *child)
+{
+	struct device_node *node;
+
+	node = of_get_next_available_child(to_of_node(fwnode),
+					   to_of_node(child));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static struct fwnode_handle *of_fwnode_get_named_child_node(
+	struct fwnode_handle *fwnode, const char *childname)
+{
+	struct device_node *node = to_of_node(fwnode);
+	struct device_node *child;
+
+	for_each_available_child_of_node(node, child)
+		if (!of_node_cmp(child->name, childname))
+			return of_fwnode_handle(child);
+
+	return NULL;
+}
+
+const struct fwnode_operations of_fwnode_ops = {
+	.get = of_fwnode_get,
+	.put = of_fwnode_put,
+	.property_present = of_fwnode_property_present,
+	.property_read_int_array = of_fwnode_property_read_int_array,
+	.property_read_string_array = of_fwnode_property_read_string_array,
+	.get_parent = of_fwnode_get_parent,
+	.get_next_child_node = of_fwnode_get_next_child_node,
+	.get_named_child_node = of_fwnode_get_named_child_node,
+};
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34674053..4307182 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -56,6 +56,9 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+
+extern const struct fwnode_operations acpi_fwnode_ops;
+
 static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 {
 	struct fwnode_handle *fwnode;
@@ -65,6 +68,7 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 		return NULL;
 
 	fwnode->type = FWNODE_ACPI_STATIC;
+	fwnode->ops = &acpi_fwnode_ops;
 
 	return fwnode;
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 3dff239..e05aaef 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -12,6 +12,8 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
+#include <linux/types.h>
+
 enum fwnode_type {
 	FWNODE_INVALID = 0,
 	FWNODE_OF,
@@ -22,9 +24,12 @@ enum fwnode_type {
 	FWNODE_IRQCHIP
 };
 
+struct fwnode_operations;
+
 struct fwnode_handle {
 	enum fwnode_type type;
 	struct fwnode_handle *secondary;
+	const struct fwnode_operations *ops;
 };
 
 /**
@@ -39,4 +44,52 @@ struct fwnode_endpoint {
 	const struct fwnode_handle *local_fwnode;
 };
 
+/**
+ * struct fwnode_operations - Operations for fwnode interface
+ * @get: Get a reference to an fwnode.
+ * @put: Put a reference to an fwnode.
+ * @property_present: Return true if a property is present.
+ * @property_read_integer_array: Read an array of integer properties. Return
+ *				 zero on success, a negative error code
+ *				 otherwise.
+ * @property_read_string_array: Read an array of string properties. Return zero
+ *				on success, a negative error code otherwise.
+ * @get_parent: Return the parent of an fwnode.
+ * @get_next_child_node: Return the next child node in an iteration.
+ * @get_named_child_node: Return a child node with a given name.
+ */
+struct fwnode_operations {
+	void (*get)(struct fwnode_handle *fwnode);
+	void (*put)(struct fwnode_handle *fwnode);
+	bool (*property_present)(struct fwnode_handle *fwnode,
+				 const char *propname);
+	int (*property_read_int_array)(struct fwnode_handle *fwnode,
+				       const char *propname,
+				       unsigned int elem_size, void *val,
+				       size_t nval);
+	int (*property_read_string_array)(struct fwnode_handle *fwnode_handle,
+					  const char *propname,
+					  const char **val, size_t nval);
+	struct fwnode_handle *(*get_parent)(struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*get_next_child_node)(
+		struct fwnode_handle *fwnode, struct fwnode_handle *child);
+	struct fwnode_handle *(*get_named_child_node)(
+		struct fwnode_handle *fwnode, const char *name);
+};
+
+#define fwnode_has_op(fwnode, op)				\
+	((fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+#define fwnode_call_int_op(fwnode, op, ...)				\
+	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
+		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
+	 -EINVAL)
+#define fwnode_call_ptr_op(fwnode, op, ...)		\
+	(fwnode_has_op(fwnode, op) ?			\
+	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : NULL)
+#define fwnode_call_void_op(fwnode, op, ...)				\
+	do {								\
+		if (fwnode_has_op(fwnode, op))				\
+			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);	\
+	} while (false)
+
 #endif
diff --git a/include/linux/of.h b/include/linux/of.h
index e5d4225f..3b3eb5b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -100,10 +100,12 @@ struct of_reconfig_data {
 
 /* initialize a node */
 extern struct kobj_type of_node_ktype;
+extern const struct fwnode_operations of_fwnode_ops;
 static inline void of_node_init(struct device_node *node)
 {
 	kobject_init(&node->kobj, &of_node_ktype);
 	node->fwnode.type = FWNODE_OF;
+	node->fwnode.ops = &of_fwnode_ops;
 }
 
 /* true when node is initialized */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
