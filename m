From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 14/15] device property: Add fwnode_get_next_parent()
Date: Fri, 27 Jan 2017 18:03:09 +0200
Message-ID: <1485532990-8431-15-git-send-email-sakari.ailus@linux.intel.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485532990-8431-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In order to differentiate the functionality between dropping a reference
to the node (or not) for the benefit of OF, introduce
fwnode_get_next_parent().

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 21b103f..d31a31f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -868,6 +868,35 @@ int device_add_properties(struct device *dev, struct property_entry *properties)
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_next_parent - Iterate to the node's parent
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * This is like fwnode_get_parent() except that it drops the refcount
+ * on the passed node, making it suitable for iterating through a
+ * node's parents.
+ *
+ * Returns a node pointer with refcount incremented, use
+ * fwnode_handle_node() on it when done.
+ */
+struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_get_next_parent(to_of_node(fwnode));
+		if (node)
+			parent = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		parent = acpi_node_get_parent(fwnode);
+	}
+
+	return parent;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
+
+/**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index eb7ba73..760df98 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -73,6 +73,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
