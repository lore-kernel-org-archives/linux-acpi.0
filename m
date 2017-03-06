From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 15/16] device property: Add fwnode_get_next_parent()
Date: Mon,  6 Mar 2017 16:19:29 +0200
Message-ID: <1488809970-25568-16-git-send-email-sakari.ailus@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932322AbdCFOTz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 09:19:55 -0500
In-Reply-To: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

In order to differentiate the functionality between dropping a reference
to the node (or not) for the benefit of OF, introduce
fwnode_get_next_parent().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b8c1017..defeba9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -953,6 +953,35 @@ int device_add_properties(struct device *dev,
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
index 45ef00a..19dd35e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -77,6 +77,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child);
 
-- 
2.7.4

