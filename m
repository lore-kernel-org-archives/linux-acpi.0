From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 06/15] device property: Add support for remote endpoints
Date: Fri, 27 Jan 2017 18:03:01 +0200
Message-ID: <1485532990-8431-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485532990-8431-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This follows DT implementation of of_graph_* APIs but we call them
fwnode_graph_* instead. For DT nodes the existing of_graph_* implementation
will be used. For ACPI we use the new ACPI graph implementation instead.

This commit includes code from Sakari Ailus.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   9 ++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0011cf..cf602c3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/property.h>
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
@@ -1111,3 +1112,124 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
 	return device_get_mac_addr(dev, "address", addr, alen);
 }
 EXPORT_SYMBOL(device_get_mac_address);
+
+/**
+ * device_graph_get_next_endpoint - Get next endpoint firmware node
+ * @fwnode: Pointer to the parent firmware node
+ * @prev: Previous endpoint node or %NULL to get the first
+ *
+ * Returns an endpoint firmware node pointer or %NULL if no more endpoints
+ * are available.
+ */
+struct fwnode_handle *
+fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+			       struct fwnode_handle *prev)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_graph_get_next_endpoint(to_of_node(fwnode),
+						  to_of_node(prev));
+
+		if (node)
+			endpoint = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
+		if (IS_ERR(endpoint))
+			endpoint = NULL;
+	}
+
+	return endpoint;
+
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
+
+/**
+ * fwnode_graph_get_remote_port_parent - Return fwnode of a remote device
+ * @fwnode: Endpoint firmware node pointing to the remote endpoint
+ *
+ * Extracts firmware node of a remote device the @fwnode points to.
+ */
+struct fwnode_handle *
+fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_graph_get_remote_port_parent(to_of_node(fwnode));
+		if (node)
+			parent = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		int ret;
+
+		ret = acpi_graph_get_remote_endpoint(fwnode, &parent, NULL,
+						     NULL);
+		if (ret)
+			return NULL;
+	}
+
+	return parent;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
+
+/**
+ * fwnode_graph_get_remote_port - Return fwnode of a remote port
+ * @fwnode: Endpoint firmware node pointing to the remote endpoint
+ *
+ * Extracts firmware node of a remote port the @fwnode points to.
+ */
+struct fwnode_handle *fwnode_graph_get_remote_port(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *port = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_graph_get_remote_port(to_of_node(fwnode));
+		if (node)
+			port = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		int ret;
+
+		ret = acpi_graph_get_remote_endpoint(fwnode, NULL, &port, NULL);
+		if (ret)
+			return NULL;
+	}
+
+	return port;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
+
+/**
+ * fwnode_graph_get_remote_endpoint - Return fwnode of a remote endpoint
+ * @fwnode: Endpoint firmware node pointing to the remote endpoint
+ *
+ * Extracts firmware node of a remote endpoint the @fwnode points to.
+ */
+struct fwnode_handle *
+fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	if (is_of_node(fwnode)) {
+		struct device_node *node;
+
+		node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint", 0);
+		if (node)
+			endpoint = &node->fwnode;
+	} else if (is_acpi_node(fwnode)) {
+		int ret;
+
+		ret = acpi_graph_get_remote_endpoint(fwnode, NULL, NULL,
+						     &endpoint);
+		if (ret)
+			return NULL;
+	}
+
+	return endpoint;
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
diff --git a/include/linux/property.h b/include/linux/property.h
index 66530c3..86c47ad 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -263,4 +263,13 @@ int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
+struct fwnode_handle *fwnode_graph_get_next_endpoint(
+	struct fwnode_handle *fwnode, struct fwnode_handle *prev);
+struct fwnode_handle *fwnode_graph_get_remote_port_parent(
+	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_graph_get_remote_port(
+	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_graph_get_remote_endpoint(
+	struct fwnode_handle *fwnode);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
