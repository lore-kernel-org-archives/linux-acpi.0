From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/3] device property: Move fwnode graph ops to firmware specific locations
Date: Fri, 24 Mar 2017 13:03:51 +0200
Message-ID: <1490353432-12017-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [134.134.136.24] ([134.134.136.24]:60250 "EHLO mga09.intel.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757217AbdCXLHW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 07:07:22 -0400
In-Reply-To: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Move firmware specific implementations of the fwnode graph operations to
firmware specific locations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 60 ++++++++++++++++++++++++++++++++
 drivers/base/property.c | 92 +++----------------------------------------------
 drivers/of/property.c   | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/fwnode.h  | 16 +++++++++
 4 files changed, 151 insertions(+), 87 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 99b81f5..d839563 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1186,6 +1186,61 @@ static struct fwnode_handle *acpi_fwnode_get_named_child_node(
 	return NULL;
 }
 
+static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
+	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+{
+	struct fwnode_handle *endpoint;
+
+	endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
+	if (IS_ERR(endpoint))
+		return NULL;
+
+	return endpoint;
+}
+
+static struct fwnode_handle *acpi_fwnode_graph_get_remote_endpoint(
+	struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	acpi_graph_get_remote_endpoint(fwnode, NULL, NULL, &endpoint);
+
+	return endpoint;
+}
+
+static struct fwnode_handle *acpi_fwnode_graph_get_remote_port(
+	struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *port = NULL;
+
+	acpi_graph_get_remote_endpoint(fwnode, NULL, &port, NULL);
+
+	return port;
+}
+
+static struct fwnode_handle *acpi_fwnode_graph_get_remote_port_parent(
+	struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = NULL;
+
+	acpi_graph_get_remote_endpoint(fwnode, &parent, NULL, NULL);
+
+	return parent;
+}
+
+static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+					    struct fwnode_endpoint *endpoint)
+{
+	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
+
+	endpoint->local_fwnode = fwnode;
+
+	fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
+	fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
+
+	return 0;
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1193,4 +1248,9 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_parent = acpi_fwnode_get_parent,
 	.get_next_child_node = acpi_get_next_subnode,
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
+	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
+	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
+	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3fcb13c..4f355df 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1160,24 +1160,7 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	struct fwnode_handle *endpoint = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_graph_get_next_endpoint(to_of_node(fwnode),
-						  to_of_node(prev));
-
-		if (node)
-			endpoint = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
-		if (IS_ERR(endpoint))
-			endpoint = NULL;
-	}
-
-	return endpoint;
-
+	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
@@ -1190,24 +1173,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_graph_get_remote_port_parent(to_of_node(fwnode));
-		if (node)
-			parent = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		int ret;
-
-		ret = acpi_graph_get_remote_endpoint(fwnode, &parent, NULL,
-						     NULL);
-		if (ret)
-			return NULL;
-	}
-
-	return parent;
+	return fwnode_call_ptr_op(fwnode, graph_get_remote_port_parent);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
 
@@ -1219,23 +1185,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
  */
 struct fwnode_handle *fwnode_graph_get_remote_port(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *port = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_graph_get_remote_port(to_of_node(fwnode));
-		if (node)
-			port = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		int ret;
-
-		ret = acpi_graph_get_remote_endpoint(fwnode, NULL, &port, NULL);
-		if (ret)
-			return NULL;
-	}
-
-	return port;
+	return fwnode_call_ptr_op(fwnode, graph_get_remote_endpoint);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
 
@@ -1248,25 +1198,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
 struct fwnode_handle *
 fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *endpoint = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint",
-					0);
-		if (node)
-			endpoint = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		int ret;
-
-		ret = acpi_graph_get_remote_endpoint(fwnode, NULL, NULL,
-						     &endpoint);
-		if (ret)
-			return NULL;
-	}
-
-	return endpoint;
+	return fwnode_call_ptr_op(fwnode, graph_get_remote_endpoint);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 
@@ -1282,22 +1214,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint)
 {
-	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
-
 	memset(endpoint, 0, sizeof(*endpoint));
 
-	endpoint->local_fwnode = fwnode;
-
-	if (is_acpi_node(port_fwnode)) {
-		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
-		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
-	} else {
-		fwnode_property_read_u32(port_fwnode, "reg", &endpoint->port);
-		fwnode_property_read_u32(fwnode, "reg", &endpoint->id);
-	}
-
-	fwnode_handle_put(port_fwnode);
-
-	return 0;
+	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6a2d6c4..572c36c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -814,6 +814,71 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
 	return NULL;
 }
 
+static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
+	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+{
+	struct device_node *node;
+
+	node = of_graph_get_next_endpoint(to_of_node(fwnode),
+					  to_of_node(prev));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static struct fwnode_handle *of_fwnode_graph_get_remote_endpoint(
+	struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_parse_phandle(to_of_node(fwnode), "remote-endpoint", 0);
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static struct fwnode_handle *of_fwnode_graph_get_remote_port(
+	struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_graph_get_remote_port(to_of_node(fwnode));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static struct fwnode_handle *of_fwnode_graph_get_remote_port_parent(
+	struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_graph_get_remote_port_parent(to_of_node(fwnode));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
+static int of_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+					  struct fwnode_endpoint *endpoint)
+{
+	struct device_node *node = to_of_node(fwnode);
+	struct device_node *port_node = of_get_parent(node);
+
+	endpoint->local_fwnode = fwnode;
+
+	of_property_read_u32(port_node, "reg", &endpoint->port);
+	of_property_read_u32(node, "reg", &endpoint->id);
+
+	of_node_put(port_node);
+
+	return 0;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -823,4 +888,9 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
+	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
+	.graph_get_remote_port_parent = of_fwnode_graph_get_remote_port_parent,
+	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 };
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index e05aaef..351c38d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -57,6 +57,12 @@ struct fwnode_endpoint {
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
+ * @graph_get_next_endpoint: Return an endpoint node in an iteration.
+ * @graph_get_remote_endpoint: Return the remote endpoint node of an endpoint
+ *			       node.
+ * @graph_get_remote_port: Return the remote port node of an endpoint node.
+ * @graph_get_remote_port_parent: Return the parent of a port node of the
+ *				  remote endpoint node of an endpoint node.
  */
 struct fwnode_operations {
 	void (*get)(struct fwnode_handle *fwnode);
@@ -75,6 +81,16 @@ struct fwnode_operations {
 		struct fwnode_handle *fwnode, struct fwnode_handle *child);
 	struct fwnode_handle *(*get_named_child_node)(
 		struct fwnode_handle *fwnode, const char *name);
+	struct fwnode_handle *(*graph_get_next_endpoint)(
+		struct fwnode_handle *fwnode, struct fwnode_handle *prev);
+	struct fwnode_handle *(*graph_get_remote_endpoint)(
+		struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*graph_get_remote_port)(
+		struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*graph_get_remote_port_parent)(
+		struct fwnode_handle *fwnode);
+	int (*graph_parse_endpoint)(struct fwnode_handle *fwnode,
+				    struct fwnode_endpoint *endpoint);
 };
 
 #define fwnode_has_op(fwnode, op)				\
-- 
2.7.4

