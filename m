From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 07/13] device property: Add fwnode_handle_get()
Date: Thu, 16 Mar 2017 14:31:15 +0200
Message-ID: <1489667481-28521-8-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdCPMc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 08:32:56 -0400
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

fwnode_handle_get() is used to obtain a reference to a fwnode_handle
container. In this case this is OF specific struct device_node.

This complements fwnode_handle_put() which is already implemented.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 11 +++++++++++
 include/linux/property.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 851b33f..6a8d8ae 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1083,6 +1083,17 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_named_child_node);
 
 /**
+ * fwnode_handle_get - Obtain a reference to a device node
+ * @fwnode: Pointer to the device node to obtain the reference to.
+ */
+void fwnode_handle_get(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		of_node_get(to_of_node(fwnode));
+}
+EXPORT_SYMBOL_GPL(fwnode_handle_get);
+
+/**
  * fwnode_handle_put - Drop reference to a device node
  * @fwnode: Pointer to the device node to drop the reference to.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 8d7809c..0ae7d20 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -90,6 +90,7 @@ struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
+void fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.7.4

