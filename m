From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5.1 12/13] device property: Add fwnode_get_next_parent()
Date: Fri, 24 Mar 2017 11:21:59 +0200
Message-ID: <1490347319-9531-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-13-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15724 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934157AbdCXJXY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 05:23:24 -0400
In-Reply-To: <1489667481-28521-13-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

In order to differentiate the functionality between dropping a reference
to the node (or not) for the benefit of OF, introduce
fwnode_get_next_parent().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v5:

- Call fwnode_get_parent() to get the parent, independently of the FW
  type. In other words, squashed "device property: Implement
  fwnode_get_next_parent() using fwnode interface" to this one.

 drivers/base/property.c  | 21 +++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a4fe66c..0a120e3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -976,6 +976,27 @@ int device_add_properties(struct device *dev,
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

