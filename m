From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 06/17] device property: Use fwnode_operations for reading integer arrays
Date: Mon,  6 Mar 2017 17:42:52 +0200
Message-ID: <1488814983-25695-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_property_read_*_array() class of
functions to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 27 +++++++++++++++
 drivers/base/property.c | 92 ++++++++++++++++++++++++++-----------------------
 drivers/of/base.c       | 25 ++++++++++++++
 3 files changed, 100 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 14b96ec..b84d0e5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1116,6 +1116,33 @@ static bool acpi_fwnode_property_present(struct fwnode_handle *fwnode,
 	return !acpi_node_prop_get(fwnode, propname, NULL);
 }
 
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
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
+	.property_read_int_array = acpi_fwnode_property_read_int_array,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index e150df0..77a1657 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -189,8 +189,32 @@ static bool pset_fwnode_property_present(struct fwnode_handle *fwnode,
 	return !!pset_prop_get(to_pset_node(fwnode), propname);
 }
 
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
 static const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
+	.property_read_int_array = pset_fwnode_read_int_array,
 };
 
 /**
@@ -393,42 +417,22 @@ int device_property_match_string(struct device *dev, const char *propname,
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
@@ -451,8 +455,8 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u8, DEV_PROP_U8,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u8),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
 
@@ -477,8 +481,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
 int fwnode_property_read_u16_array(struct fwnode_handle *fwnode,
 				   const char *propname, u16 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u16, DEV_PROP_U16,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u16),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
 
@@ -503,8 +507,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
 int fwnode_property_read_u32_array(struct fwnode_handle *fwnode,
 				   const char *propname, u32 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u32, DEV_PROP_U32,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u32),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
 
@@ -529,8 +533,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
 int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
 				   const char *propname, u64 *val, size_t nval)
 {
-	return FWNODE_PROP_READ_ARRAY(fwnode, propname, u64, DEV_PROP_U64,
-				      val, nval);
+	return fwnode_property_read_int_array(fwnode, propname, sizeof(u64),
+					      val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 46e0b2a..31caa48 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2552,8 +2552,33 @@ static bool of_fwnode_property_present(struct fwnode_handle *fwnode,
 	return of_property_read_bool(to_of_node(fwnode), propname);
 }
 
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
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
 	.property_present = of_fwnode_property_present,
+	.property_read_int_array = of_fwnode_property_read_int_array,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
