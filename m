From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 11/20] device property: Use fwnode_operations for reading string arrays
Date: Thu, 23 Feb 2017 19:01:07 +0200
Message-ID: <1487869276-25244-12-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_property_read_string_array() function
to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c |  9 ++++++
 drivers/base/property.c | 81 ++++++++++++++++++-------------------------------
 drivers/of/base.c       | 22 ++++++++++++++
 3 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b84d0e5..4e76b31 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1142,7 +1142,16 @@ static int acpi_fwnode_property_read_int_array(
 	return acpi_node_prop_read(fwnode, propname, type, val, nval);
 }
 
+static int acpi_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname, const char **val,
+	size_t nval)
+{
+	return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+				   val, nval);
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
+	.property_read_string_array = acpi_fwnode_property_read_string_array,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index b251525..136ba66 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -187,9 +187,34 @@ static int pset_fwnode_read_int_array(
 	return -ENXIO;
 }
 
+static int pset_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname, const char **val,
+	size_t nval)
+{
+	struct property_set *node = to_pset_node(fwnode);
+	struct property_entry *prop;
+
+	/* Read properties if val is non-NULL */
+	if (val)
+		return pset_prop_read_string_array(node, propname, val, nval);
+
+	prop = pset_prop_get(node, propname);
+	if (!prop)
+		return -EINVAL;
+
+	/* The array length for a non-array string property is 1. */
+	if (!prop->is_array)
+		return 1;
+
+	/* Return the length of an array. */
+	return pset_prop_count_elems_of_size(node, propname,
+					     sizeof(const char *));
+}
+
 static const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
 	.property_read_int_array = pset_fwnode_read_int_array,
+	.property_read_string_array = pset_fwnode_property_read_string_array,
 };
 
 /**
@@ -513,54 +538,6 @@ int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
 
-static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
-					       const char *propname,
-					       const char **val, size_t nval)
-{
-	if (is_of_node(fwnode)) {
-		int rval;
-
-		if (!val)
-			return of_property_count_strings(to_of_node(fwnode),
-							 propname);
-
-		rval = of_property_read_string_array(to_of_node(fwnode),
-						     propname, val, nval);
-
-		if (rval < 0)
-			return rval;
-
-		if (rval == nval)
-			return 0;
-
-		return -EOVERFLOW;
-	} else if (is_acpi_node(fwnode))
-		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					   val, nval);
-	else if (is_pset_node(fwnode)) {
-		struct property_set *node = to_pset_node(fwnode);
-		struct property_entry *prop;
-
-		/* Read properties if val is non-NULL */
-		if (val)
-			return pset_prop_read_string_array(node, propname,
-							   val, nval);
-
-		prop = pset_prop_get(node, propname);
-		if (!prop)
-			return -EINVAL;
-
-		/* The array length for a non-array string property is 1. */
-		if (!prop->is_array)
-			return 1;
-
-		/* Return the length of an array. */
-		return pset_prop_count_elems_of_size(node, propname,
-						     sizeof(const char *));
-	}
-	return -ENXIO;
-}
-
 /**
  * fwnode_property_read_string_array - return string array property of a node
  * @fwnode: Firmware node to get the property of
@@ -585,11 +562,13 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
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
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 80f736d..7bd9eec 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2510,9 +2510,31 @@ static int of_fwnode_property_read_int_array(
 	return -ENXIO;
 }
 
+static int of_fwnode_property_read_string_array(
+	struct fwnode_handle *fwnode, const char *propname,
+	const char **val, size_t nval)
+{
+	struct device_node *node = to_of_node(fwnode);
+	int rval;
+
+	if (!val)
+		return of_property_count_strings(node, propname);
+
+	rval = of_property_read_string_array(node, propname, val, nval);
+
+	if (rval < 0)
+		return rval;
+
+	if (rval == nval)
+		return 0;
+
+	return -EOVERFLOW;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
+	.property_read_string_array = of_fwnode_property_read_string_array,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
