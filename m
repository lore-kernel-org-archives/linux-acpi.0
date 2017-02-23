From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 13/16] device property: Add support for fwnode endpoints
Date: Thu, 23 Feb 2017 18:19:33 +0200
Message-ID: <1487866776-24578-14-git-send-email-sakari.ailus@linux.intel.com>
References: <1487866776-24578-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27860 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdBWQVo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 11:21:44 -0500
In-Reply-To: <1487866776-24578-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Similar to OF endpoints, endpoint type nodes can be also supported on
ACPI. In order to make it possible for drivers to ignore the matter,
add a type for fwnode_endpoint and a function to parse them.

On ACPI, find the child node index instead of relying on the "endpoint"
property.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  6 ++++++
 include/linux/property.h |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index cf8bc2f..a866e80 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1239,3 +1239,39 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
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
+
+	if (is_acpi_node(port_fwnode)) {
+		struct fwnode_handle *iter;
+
+		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
+
+		for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
+		     iter != fwnode;
+		     iter = fwnode_get_next_child_node(port_fwnode, iter))
+			endpoint->id++;
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
index 09a75b1..df29a5f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -279,4 +279,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	struct fwnode_handle *fwnode);
 
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

