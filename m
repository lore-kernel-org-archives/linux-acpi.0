From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 07/10] device property: Add fwnode_get_next_child_node()
Date: Wed,  1 Jul 2015 08:48:00 +0200
Message-ID: <1435733283-19244-8-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35697 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbbGAGsb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:31 -0400
Received: by wgjx7 with SMTP id x7so27774432wgj.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:30 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.29
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:29 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

So callers that have a handle to a firmware node but not any of the
devices related to it can iterate over their descendants.

Also adds fwnode_for_each_child_node().

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 30 ++++++++++++++++++++++--------
 include/linux/property.h |  7 +++++++
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3280b04..92cdbb3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -466,28 +466,42 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_property_read_string);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
- * @dev: Device to find the next child node for.
- * @child: Handle to one of the device's child nodes or a null handle.
+ * fwnode_get_next_child_node - Return the next child node handle for a fwnode
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the firmware node's child nodes or a null handle.
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
+	} else if (is_acpi_node(fwnode)) {
 		struct acpi_device *node;
 
-		node = acpi_get_next_child(dev, to_acpi_node(child));
+		node = acpi_dev_get_next_child(to_acpi_node(fwnode),
+					       to_acpi_node(child));
 		if (node)
 			return acpi_fwnode_handle(node);
 	}
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
+	return fwnode_get_next_child_node(dev->fwnode, child);
+}
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
diff --git a/include/linux/property.h b/include/linux/property.h
index 020a53c..cfd1eb2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -63,6 +63,9 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
+						 struct fwnode_handle *child);
+
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
 
 const char *fwnode_get_name(struct fwnode_handle *fwnode);
@@ -71,6 +74,10 @@ const char *fwnode_get_name(struct fwnode_handle *fwnode);
 	for (child = device_get_next_child_node(dev, NULL); child; \
 	     child = device_get_next_child_node(dev, child))
 
+#define fwnode_for_each_child_node(fwnode, child) \
+	for (child = fwnode_get_next_child_node(fwnode, NULL); child; \
+	     child = fwnode_get_next_child_node(fwnode, child))
+
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.4.1

