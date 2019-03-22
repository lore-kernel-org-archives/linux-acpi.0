From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/5] device property: Add functions for accessing node's parents
Date: Fri, 22 Mar 2019 17:29:26 +0200
Message-ID: <20190322152930.16642-2-sakari.ailus@linux.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Add two convenience functions for accessing node's parents:

fwnode_count_parents() returns the number of parent nodes a given node
has. fwnode_get_nth_parent() returns node's parent at a given distance
from the node itself.

Also reorder fwnode_get_parent() in property.c according to the same order
as in property.h.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 61 ++++++++++++++++++++++++++++++++++++++++++------
 include/linux/property.h |  3 +++
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8b91ab380d14..3f5ff6b23ae4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,6 +533,19 @@ int device_add_properties(struct device *dev,
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_parent - Return parent firwmare node
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * Return parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
+ */
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_parent);
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
+/**
  * fwnode_get_next_parent - Iterate to the node's parent
  * @fwnode: Firmware whose parent is retrieved
  *
@@ -554,17 +567,51 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
 /**
- * fwnode_get_parent - Return parent firwmare node
- * @fwnode: Firmware whose parent is retrieved
+ * fwnode_count_parents - Return the number of parents a node has
  *
- * Return parent firmware node of the given node if possible or %NULL if no
- * parent was available.
+ * @fwnode: The node the parents of which are to be counted
+ *
+ * Returns the number of parents a node has.
  */
-struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
+unsigned int fwnode_count_parents(struct fwnode_handle *fwnode)
 {
-	return fwnode_call_ptr_op(fwnode, get_parent);
+	unsigned int count;
+
+	fwnode_handle_get(fwnode);
+
+	for (count = 0; fwnode; count++)
+		fwnode = fwnode_get_next_parent(fwnode);
+
+	return count - 1;
 }
-EXPORT_SYMBOL_GPL(fwnode_get_parent);
+EXPORT_SYMBOL_GPL(fwnode_count_parents);
+
+/**
+ * fwnode_get_nth_parent - Return an nth parent of a node
+ *
+ * @fwnode: The node the parent of which is requested
+ * @depth: Distance of the parent from the node
+ *
+ * Returns the nth parent of a node. If @depth is 0, the functionality is
+ * equivalent to fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent()
+ * and so on.
+ *
+ * The caller is responsible for calling fwnode_handle_put() for the returned
+ * node.
+ */
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
+					    unsigned int depth)
+{
+	unsigned int i;
+
+	fwnode_handle_get(fwnode);
+
+	for (i = 0; i < depth && fwnode; i++)
+		fwnode = fwnode_get_next_parent(fwnode);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
diff --git a/include/linux/property.h b/include/linux/property.h
index 65d3420dd5d1..1164ac974ee8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -81,6 +81,9 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+unsigned int fwnode_count_parents(struct fwnode_handle *fwn);
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
+					    unsigned int depth);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.11.0
