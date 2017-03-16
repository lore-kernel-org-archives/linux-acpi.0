From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5.1 10/13] device property: Add support for fwnode endpoints
Date: Thu, 16 Mar 2017 15:22:52 +0200
Message-ID: <1489670572-19984-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-11-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:60140 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdCPNYk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 09:24:40 -0400
In-Reply-To: <1489667481-28521-11-git-send-email-sakari.ailus@linux.intel.com>
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
since v5:

- Read the "endpoint" property on ACPI to read the endpoint number.

 drivers/base/property.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   | 12 ++++++++++++
 include/linux/property.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4c7956e..a4fe66c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1353,3 +1353,35 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
 	return endpoint;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
+
+/**
+ * fwnode_graph_parse_endpoint - parse common endpoint node properties
+ * @fwnode: pointer to endpoint fwnode_handle
+ * @endpoint: pointer to the fwnode endpoint data structure
+ *
+ * Parse @fwnode representing a graph endpoint node and store the
+ * information in @endpoint. The caller must hold a reference to
+ * @fwnode.
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
index 8bd28ce..3dff239 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -27,4 +27,16 @@ struct fwnode_handle {
 	struct fwnode_handle *secondary;
 };
 
+/**
+ * struct fwnode_endpoint - Fwnode graph endpoint
+ * @port: Port number
+ * @id: Endpoint id
+ * @local_fwnode: reference to the related fwnode
+ */
+struct fwnode_endpoint {
+	unsigned int port;
+	unsigned int id;
+	const struct fwnode_handle *local_fwnode;
+};
+
 #endif
diff --git a/include/linux/property.h b/include/linux/property.h
index 6e20a12..3a4e435 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -280,4 +280,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	struct fwnode_handle *fwnode);
 
+int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+				struct fwnode_endpoint *endpoint);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

