From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 12/15] device property: Add support for fwnode endpoints
Date: Wed,  5 Oct 2016 01:45:45 +0300
Message-ID: <1475621148-21427-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11570 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbcJDWr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:29 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

Similar to OF endpoints, endpoint type nodes can be also supported on
ACPI. In order to make it possible for drivers to ignore the matter,
add a type for fwnode_endpoint and a function to parse them.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  6 ++++++
 include/linux/property.h |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1ade4b7..d173960 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1244,3 +1244,36 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
 	return endpoint;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
+
+/*
+ * fwnode_graph_parse_endpoint() - parse common endpoint node properties
+ * @node: pointer to endpoint device_node
+ * @endpoint: pointer to the fwnode endpoint data structure
+ *
+ * The caller should hold a reference to @node.
+ */
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint)
+{
+	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
+
+	memset(endpoint, 0, sizeof(*endpoint));
+
+	endpoint->local_fwnode = fwnode;
+	/*
+	 * It doesn't matter whether the two calls below succeed.
+	 * If they don't then the default value 0 is used.
+	 */
+	if (is_acpi_node(port_fwnode)) {
+		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
+		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
+	} else {
+		fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
+		fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
+	}
+
+	fwnode_handle_put(port_fwnode);
+
+	return 0;
+}
+EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8516717..7940b79 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -26,4 +26,10 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 };
 
+struct fwnode_endpoint {
+	unsigned int port;
+	unsigned int id;
+	const struct fwnode_handle *local_fwnode;
+};
+
 #endif
diff --git a/include/linux/property.h b/include/linux/property.h
index b1c5365c..33fbca6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -284,4 +284,7 @@ static inline struct fwnode_handle *device_fwnode_handle(struct device *dev)
 		return dev->fwnode;
 }
 
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

