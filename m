From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/2] device property: Make fwnode_handle_get() return the fwnode
Date: Tue, 19 Sep 2017 12:39:11 +0300
Message-ID: <20170919093912.32356-2-sakari.ailus@linux.intel.com>
References: <20170919093912.32356-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:58464 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751509AbdISJjP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Sep 2017 05:39:15 -0400
In-Reply-To: <20170919093912.32356-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, mika.westerberg@linux.intel.com, rafael@kernel.org, hverkuil@xs4all.nl

The fwnode_handle_get() function is used to obtain a reference to an
fwnode. A common usage pattern for the OF equivalent of the function is:

	mynode = of_node_get(node);

Similarly make fwnode_handle_get() return the fwnode to which the
reference was obtained.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 9 +++++++--
 drivers/of/property.c    | 4 ++--
 include/linux/fwnode.h   | 2 +-
 include/linux/property.h | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d0b65bbe7e15..0c8958747c8b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1037,10 +1037,15 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
 /**
  * fwnode_handle_get - Obtain a reference to a device node
  * @fwnode: Pointer to the device node to obtain the reference to.
+ *
+ * Returns the fwnode handle.
  */
-void fwnode_handle_get(struct fwnode_handle *fwnode)
+struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
 {
-	fwnode_call_void_op(fwnode, get);
+	if (!fwnode_has_op(fwnode, get))
+		return fwnode;
+
+	return fwnode_call_ptr_op(fwnode, get);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_get);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index fbb72116e9d4..487195551b7f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -817,9 +817,9 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
 
-static void of_fwnode_get(struct fwnode_handle *fwnode)
+static struct fwnode_handle *of_fwnode_get(struct fwnode_handle *fwnode)
 {
-	of_node_get(to_of_node(fwnode));
+	return of_fwnode_handle(of_node_get(to_of_node(fwnode)));
 }
 
 static void of_fwnode_put(struct fwnode_handle *fwnode)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0c35b6caf0f6..411a84c6c400 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -68,7 +68,7 @@ struct fwnode_reference_args {
  * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
  */
 struct fwnode_operations {
-	void (*get)(struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	bool (*property_present)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 6bebee13c5e0..42069c20caee 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -100,7 +100,7 @@ struct fwnode_handle *fwnode_get_named_child_node(
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
-void fwnode_handle_get(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.11.0

