From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 03/15] ACPI / property: Add fwnode_get_next_child_node()
Date: Wed,  5 Oct 2016 01:45:36 +0300
Message-ID: <1475621148-21427-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45153 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbcJDWr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:28 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

The ACPI _DSD hierarchical data extension [1] makes it possible to have
hierarchies deeper than one level in similar way than DT allows. These
"subsubnodes" have not been accessible because device property
implementation only provides device_get_next_child_node() that is limited
to direct descendants of a device.

We need this ability in order support things like remote endpoints
currently supported in DT with of_graph_* APIs.

Modify acpi_get_next_subnode() to accept fwnode handle instead and update
callers accordingly. Also add a new function fwnode_get_next_child_node()
that works directly with fwnodes and modify device_get_next_child_node() to
call it directly. While there add a macro fwnode_for_each_child_node()
analogous to the current device_for_each_child_node() but it works with
fwnodes instead of devices.

[1] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c  | 27 +++++++++++++++++----------
 drivers/base/property.c  | 38 ++++++++++++++++++++++++++++++--------
 include/linux/acpi.h     |  8 ++++----
 include/linux/property.h |  6 ++++++
 4 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 181e4c5..f4e812e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -802,21 +802,22 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
 }
 
 /**
- * acpi_get_next_subnode - Return the next child node handle for a device.
- * @dev: Device to find the next child node for.
+ * acpi_get_next_subnode - Return the next child node handle for a fwnode
+ * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct list_head *head, *next;
 
-	if (!adev)
-		return NULL;
-
 	if (!child || child->type == FWNODE_ACPI) {
-		head = &adev->children;
+		if (adev)
+			head = &adev->children;
+		else
+			goto nondev;
+
 		if (list_empty(head))
 			goto nondev;
 
@@ -825,7 +826,6 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 			next = adev->node.next;
 			if (next == head) {
 				child = NULL;
-				adev = ACPI_COMPANION(dev);
 				goto nondev;
 			}
 			adev = list_entry(next, struct acpi_device, node);
@@ -837,9 +837,16 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 
  nondev:
 	if (!child || child->type == FWNODE_ACPI_DATA) {
+		struct acpi_data_node *data = to_acpi_data_node(fwnode);
 		struct acpi_data_node *dn;
 
-		head = &adev->data.subnodes;
+		if (adev)
+			head = &adev->data.subnodes;
+		else if (data)
+			head = &data->data.subnodes;
+		else
+			return NULL;
+
 		if (list_empty(head))
 			return NULL;
 
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 384998a..15403f7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -892,24 +892,46 @@ struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_parent);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
- * @dev: Device to find the next child node for.
- * @child: Handle to one of the device's child nodes or a null handle.
+ * fwnode_get_next_child_node - Return the next child node handle for a node
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the node's child nodes or a %NULL handle.
  */
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child)
 {
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+	if (is_of_node(fwnode)) {
 		struct device_node *node;
 
-		node = of_get_next_available_child(dev->of_node, to_of_node(child));
+		node = of_get_next_available_child(to_of_node(fwnode),
+						   to_of_node(child));
 		if (node)
 			return &node->fwnode;
-	} else if (IS_ENABLED(CONFIG_ACPI)) {
-		return acpi_get_next_subnode(dev, child);
+	} else if (is_acpi_node(fwnode)) {
+		return acpi_get_next_subnode(fwnode, child);
 	}
+
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
+
+/**
+ * device_get_next_child_node - Return the next child node handle for a device
+ * @dev: Device to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ */
+struct fwnode_handle *device_get_next_child_node(struct device *dev,
+						 struct fwnode_handle *child)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct fwnode_handle *fwnode = NULL;
+
+	if (dev->of_node)
+		fwnode = &dev->of_node->fwnode;
+	else if (adev)
+		fwnode = acpi_fwnode_handle(adev);
+
+	return fwnode_get_next_child_node(fwnode, child);
+}
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6906f7a..1424cce 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -959,8 +959,8 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode, const char *propname,
 int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
-					    struct fwnode_handle *subnode);
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
+					    struct fwnode_handle *child);
 struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode);
 
 struct acpi_probe_entry;
@@ -1070,8 +1070,8 @@ static inline int acpi_dev_prop_read(struct acpi_device *adev,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
-						struct fwnode_handle *subnode)
+static inline struct fwnode_handle *
+acpi_get_next_subnode(struct fwnode_handle *fwnode, struct fwnode_handle *child)
 {
 	return NULL;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 85060bf..a3d4f52 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -71,6 +71,12 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
+						 struct fwnode_handle *child);
+
+#define fwnode_for_each_child_node(fwnode, child)			\
+	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
+	     child = fwnode_get_next_child_node(fwnode, child))
 
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
-- 
2.7.4

