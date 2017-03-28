From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 04/12] device property: Add fwnode_get_named_child_node()
Date: Tue, 28 Mar 2017 10:52:19 +0300
Message-ID: <1490687547-18311-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5046 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754652AbdC1HxK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:10 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

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
index bc0f07a..538b248 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1000,20 +1000,20 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
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
@@ -1025,6 +1025,18 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 
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
index f4786a86..514b195 100644
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

