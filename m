From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 07/12] device property: Add fwnode_handle_get()
Date: Tue, 28 Mar 2017 10:52:22 +0300
Message-ID: <1490687547-18311-8-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34094 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754632AbdC1Hxw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:52 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

fwnode_handle_get() is used to obtain a reference to a fwnode_handle
container. In this case this is OF specific struct device_node.

This complements fwnode_handle_put() which is already implemented.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 11 +++++++++++
 include/linux/property.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4e98a6f..23514bf6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1041,6 +1041,17 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
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

