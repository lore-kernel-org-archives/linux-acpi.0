From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 12/16] device property: Obtain device's fwnode independently of FW type
Date: Thu,  2 Feb 2017 18:22:22 +0200
Message-ID: <1486052546-19257-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbdBBQX5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 11:23:57 -0500
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

OF uses struct device's of_node field (of type struct device_node) to
refer to the device's OF properties. ACPI employs the fwnode field
instead. The latter is of type fwnode_handle, which is also embedded in
struct device_node.

The struct fwnode_handle pointer in both cases can be used as an argument
for the device property API which is firmware agnostic. Also make
obtaining the firmware node independent of the type of the firmware.

On ACPI, rely on the endpoint node child index in determining the endpoint
ID. There's no need for a separate "endpoint" property as such: this is a
software concept and the value is deterministically derived from the ACPI
table.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 33 +++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  6 ++++++
 include/linux/property.h | 13 +++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 760c6c5..3f77404 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1245,3 +1245,36 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
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
index b4b1545..eb7ba73 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -13,7 +13,9 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/device.h>
 #include <linux/fwnode.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
 struct device;
@@ -273,4 +275,15 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	struct fwnode_handle *fwnode);
 
+static inline struct fwnode_handle *device_fwnode_handle(struct device *dev)
+{
+	if (dev->of_node)
+		return of_fwnode_handle(dev->of_node);
+	else
+		return dev->fwnode;
+}
+
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

