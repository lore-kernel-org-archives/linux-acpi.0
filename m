From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 2/6] device property: Add fwnode_get_name for returning the name of a node
Date: Tue, 26 Mar 2019 14:41:02 +0200
Message-ID: <20190326124106.27694-3-sakari.ailus@linux.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The fwnode framework did not have means to obtain the name of a node. Add
that now, in form of the fwnode_get_name() function and a corresponding
get_name fwnode op. OF and ACPI support is included.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
 drivers/base/property.c  | 11 +++++++++++
 drivers/of/property.c    |  6 ++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  1 +
 5 files changed, 44 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 77abe0ec4043..8c9a4c02cde2 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1291,6 +1291,29 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 						  args_count, args);
 }
 
+static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	const struct acpi_device *adev;
+	struct fwnode_handle *parent;
+
+	parent = fwnode_get_parent(fwnode);
+	/* Is this the root node? */
+	if (!parent)
+		return "\\";
+
+	fwnode_handle_put(parent);
+
+	if (is_acpi_data_node(fwnode)) {
+		const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
+
+		return dn->name;
+	}
+
+	adev = to_acpi_device_node(fwnode);
+
+	return adev ? acpi_device_bid(adev) : NULL;
+}
+
 static struct fwnode_handle *
 acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
@@ -1331,6 +1354,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 		.get_parent = acpi_node_get_parent,			\
 		.get_next_child_node = acpi_get_next_subnode,		\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
+		.get_name = acpi_fwnode_get_name,			\
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 61eb6ceacc3f..04a8591cd1b0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,6 +533,17 @@ int device_add_properties(struct device *dev,
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_name - Return the name of a node
+ * @fwnode: The firmware node
+ *
+ * Returns a pointer to the node name.
+ */
+const char *fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_name);
+}
+
+/**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8631efa1daa1..f0a7b78f2d9f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -872,6 +872,11 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 		of_property_count_strings(node, propname);
 }
 
+static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return kbasename(to_of_node(fwnode)->full_name);
+}
+
 static struct fwnode_handle *
 of_fwnode_get_parent(const struct fwnode_handle *fwnode)
 {
@@ -993,6 +998,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.get_name = of_fwnode_get_name,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index faebf0ca0686..85b7fa4dc727 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -59,6 +59,7 @@ struct fwnode_reference_args {
  *				 otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @get_name: Return the name of an fwnode.
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
@@ -85,6 +86,7 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *
 	(*get_next_child_node)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 1164ac974ee8..2f5df900e310 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -78,6 +78,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
 
+const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.11.0
