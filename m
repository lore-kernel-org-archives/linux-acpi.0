From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 08/17] device property: Use fwnode_operations for reading string arrays
Date: Mon,  6 Mar 2017 17:42:54 +0200
Message-ID: <1488814983-25695-9-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27187 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753601AbdCFPng (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:36 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_property_read_string_array() function
to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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
index 2ee09a1..62bd59d 100644
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
+	const struct property_entry *prop;
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
index 31caa48..18e51b5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2576,9 +2576,31 @@ static int of_fwnode_property_read_int_array(
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

