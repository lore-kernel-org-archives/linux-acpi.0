From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1.1 3/3] device property: fwnode_property_read_string_array() returns nr of strings
Date: Wed, 15 Mar 2017 15:31:28 +0200
Message-ID: <1489584688-15624-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43548 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdCONbv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Mar 2017 09:31:51 -0400
In-Reply-To: <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Functionally fwnode_property_read_string_array() should match
of_property_read_string_array() and work as a drop-in substitute for the
latter. of_property_read_string_array() returns the number of strings read
if the target string pointer array is non-NULL. Make
fwnode_property_read_string_array() do the same.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
This patch replaces v1 3/3 patch in this set.

Instead of changing the return value of fwnode / device property API
string array access on OF, change the behaviour on pset and ACPI instead.
This makes them to return the number of strings read on success.

I can merge this with patch 2/3 which is changing the same part of the
file, however I'm sending this separately at least for now as I think it's
easier to review this way, rather than making a bugfix and a change of the
behaviour in the same patch.

Regards,
Sakari

 drivers/base/property.c | 64 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c98390..82187ac 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -340,8 +340,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
  * Function reads an array of string properties with @propname from the device
  * firmware description and stores them to @val if found.
  *
- * Return: number of values if @val was %NULL,
- *         %0 if the property was found (success),
+ * Return: number of values read on success if @val is non-NULL,
+ *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
@@ -549,29 +549,57 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 			of_property_read_string_array(to_of_node(fwnode),
 						      propname, val, nval) :
 			of_property_count_strings(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
-					   val, nval);
-	else if (is_pset_node(fwnode)) {
+	else if (is_acpi_node(fwnode)) {
+		int array_len =
+			acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					    NULL, nval);
+		int read_len;
+		int ret;
+
+		/* Return if val is NULL or if there was an error */
+		if (!val || array_len < 0)
+			return array_len;
+
+		read_len = min_t(int, nval, array_len);
+
+		ret = acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
+					  val, read_len);
+		if (ret < 0)
+			return ret;
+
+		return read_len;
+	} else if (is_pset_node(fwnode)) {
 		struct property_set *node = to_pset_node(fwnode);
 		const struct property_entry *prop;
-
-		/* Read properties if val is non-NULL */
-		if (val)
-			return pset_prop_read_string_array(node, propname,
-							   val, nval);
+		/* The array length for a non-array string property is 1. */
+		int array_len = 1;
+		int read_len;
+		int ret;
 
 		prop = pset_prop_get(node, propname);
 		if (!prop)
 			return -EINVAL;
 
-		/* The array length for a non-array string property is 1. */
-		if (!prop->is_array)
-			return 1;
+		/* Read the length of an array property. */
+		if (prop->is_array)
+			array_len = pset_prop_count_elems_of_size(
+				node, propname, sizeof(const char *));
+
+
+		/* Return if val is NULL or if there was an error */
+		if (!val || array_len < 0)
+			return array_len;
+
+		read_len = min_t(int, nval, array_len);
+
+		ret = pset_prop_read_string_array(node, propname, val,
+						  read_len);
+
+		if (ret < 0)
+			return ret;
 
 		/* Return the length of an array. */
-		return pset_prop_count_elems_of_size(node, propname,
-						     sizeof(const char *));
+		return read_len;
 	}
 	return -ENXIO;
 }
@@ -599,8 +627,8 @@ static int __fwnode_property_read_string(struct fwnode_handle *fwnode,
  * Read an string list property @propname from the given firmware node and store
  * them to @val if found.
  *
- * Return: number of values if @val was %NULL,
- *         %0 if the property was found (success),
+ * Return: number of values read on success if @val is non-NULL,
+ *	   number of values available on success if @val is NULL,
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO or %-EILSEQ if the property is not an array of strings,
-- 
2.7.4

