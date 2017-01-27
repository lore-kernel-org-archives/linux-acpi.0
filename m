From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 12/15] device property: Add support for fwnode endpoints
Date: Fri, 27 Jan 2017 18:03:07 +0200
Message-ID: <1485532990-8431-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485532990-8431-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Similar to OF endpoints, endpoint type nodes can be also supported on
ACPI. In order to make it possible for drivers to ignore the matter,
add a type for fwnode_endpoint and a function to parse them.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  6 ++++++
 include/linux/property.h |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 51c0881..21b103f 100644
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
index 8bd28ce..cb60f29 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -27,4 +27,10 @@ struct fwnode_handle {
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
index 294418d..eb7ba73 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -283,4 +283,7 @@ static inline struct fwnode_handle *device_fwnode_handle(struct device *dev)
 		return dev->fwnode;
 }
 
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
