From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 11/12] device property: Add fwnode_get_next_parent()
Date: Tue, 28 Mar 2017 10:52:26 +0300
Message-ID: <1490687547-18311-12-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754656AbdC1Hxa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:30 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

In order to differentiate the functionality between dropping a reference
to the node (or not) for the benefit of OF, introduce
fwnode_get_next_parent().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 21 +++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8a53b8f..627ebc9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -934,6 +934,27 @@ int device_add_properties(struct device *dev,
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
+	struct fwnode_handle *parent = fwnode_get_parent(fwnode);
+
+	fwnode_handle_put(fwnode);
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
index 3a4e435..2f48261 100644
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

