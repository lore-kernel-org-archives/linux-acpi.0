From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 04/15] device property: Add fwnode_get_named_child_node()
Date: Fri, 27 Jan 2017 18:02:59 +0200
Message-ID: <1485532990-8431-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:26473 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbdA0QIL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Jan 2017 11:08:11 -0500
In-Reply-To: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Since now we have means to enumerate all children of any fwnode even in
ACPI we can implement fwnode_get_named_child_node(). This is similar than
device_get_named_child_node() with the exception that it can be called to
any fwnode handle. Make device_get_named_child_node() call directly this
new function.

This is useful in cases where we need to be able to find child nodes which
are not direct descendants of the parent device.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 22 +++++++++++++++++-----
 include/linux/property.h |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 15403f7..c0011cf 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -935,20 +935,20 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
- * device_get_named_child_node - Return first matching named child node handle
- * @dev: Device to find the named child node for.
+ * fwnode_get_named_child_node - Return first matching named child node handle
+ * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
  */
-struct fwnode_handle *device_get_named_child_node(struct device *dev,
+struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 						  const char *childname)
 {
 	struct fwnode_handle *child;
 
 	/*
-	 * Find first matching named child node of this device.
+	 * Find first matching named child node of this fwnode.
 	 * For ACPI this will be a data only sub-node.
 	 */
-	device_for_each_child_node(dev, child) {
+	fwnode_for_each_child_node(fwnode, child) {
 		if (is_of_node(child)) {
 			if (!of_node_cmp(to_of_node(child)->name, childname))
 				return child;
@@ -960,6 +960,18 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
+
+/**
+ * device_get_named_child_node - Return first matching named child node handle
+ * @dev: Device to find the named child node for.
+ * @childname: String to match child node name against.
+ */
+struct fwnode_handle *device_get_named_child_node(struct device *dev,
+						  const char *childname)
+{
+	return fwnode_get_named_child_node(dev_fwnode(dev), childname);
+}
 EXPORT_SYMBOL_GPL(device_get_named_child_node);
 
 /**
diff --git a/include/linux/property.h b/include/linux/property.h
index a3d4f52..66530c3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -85,6 +85,8 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
+struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
+						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
-- 
2.7.4

