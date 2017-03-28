From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 02/12] device property: Add fwnode_get_parent()
Date: Tue, 28 Mar 2017 10:52:17 +0300
Message-ID: <1490687547-18311-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27528 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbdC1Hxj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:39 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Now that ACPI has support for returning parent firmware node for both types
of nodes we can expose this to others as well. This adds a new function
fwnode_get_parent() that can be used for DT and ACPI nodes to retrieve the
parent firmware node.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 25 +++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c458c63..a252334 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -932,6 +932,31 @@ int device_add_properties(struct device *dev,
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_parent - Return parent firwmare node
+ * @fwnode: Firmware whose parent is retrieved
+ *
+ * Return parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
+ */
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_get_parent(to_of_node(fwnode));
+		if (node)
+			parent = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		parent = acpi_node_get_parent(fwnode);
+	}
+
+	return parent;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_parent);
+
+/**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
diff --git a/include/linux/property.h b/include/linux/property.h
index 64e3a9c..ab0a816 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -70,6 +70,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
+struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
+
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
-- 
2.7.4

