From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 3/6] device property: Move fwnode graph ops to firmware specific locations
Date: Wed, 31 May 2017 15:27:09 +0300
Message-ID: <1496233632-25518-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1496233632-25518-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:26110 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdEaM2j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 08:28:39 -0400
In-Reply-To: <1496233632-25518-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

Move firmware specific implementations of the fwnode graph operations to
firmware specific locations.

Depends-on: ("of: Make of_fwnode_handle() safer")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c | 40 ++++++++++++++++++++++
 drivers/base/property.c | 91 +++++--------------------------------------------
 drivers/of/property.c   | 70 +++++++++++++++++++++++++++++--------
 include/linux/fwnode.h  | 14 ++++++++
 4 files changed, 117 insertions(+), 98 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 14013f6..a24ca61 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1179,6 +1179,42 @@ acpi_fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static struct fwnode_handle *
+acpi_fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+				    struct fwnode_handle *prev)
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
+static struct fwnode_handle *
+acpi_fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	acpi_graph_get_remote_endpoint(fwnode, NULL, NULL, &endpoint);
+
+	return endpoint;
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
@@ -1186,4 +1222,8 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_parent = acpi_node_get_parent,
 	.get_next_child_node = acpi_get_next_subnode,
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
+	.graph_get_port_parent = acpi_node_get_parent,
+	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index fee0705..e1a58ac 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1156,24 +1156,7 @@ struct fwnode_handle *
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
 
@@ -1186,22 +1169,12 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
+	struct fwnode_handle *port, *parent;
 
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
+	port = fwnode_graph_get_remote_port(fwnode);
+	parent = fwnode_call_ptr_op(port, graph_get_port_parent);
 
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
+	fwnode_handle_put(port);
 
 	return parent;
 }
@@ -1215,23 +1188,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
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
+	return fwnode_get_next_parent(fwnode_graph_get_remote_endpoint(fwnode));
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
 
@@ -1244,25 +1201,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
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
 
@@ -1278,22 +1217,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
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
index 90f86cc..e859e41 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -819,27 +819,15 @@ static int of_fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 
 static struct fwnode_handle *of_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
-	struct device_node *node;
-
-	node = of_get_parent(to_of_node(fwnode));
-	if (node)
-		return of_fwnode_handle(node);
-
-	return NULL;
+	return of_fwnode_handle(of_get_parent(to_of_node(fwnode)));
 }
 
 static struct fwnode_handle *
 of_fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 			      struct fwnode_handle *child)
 {
-	struct device_node *node;
-
-	node = of_get_next_available_child(to_of_node(fwnode),
-					   to_of_node(child));
-	if (node)
-		return of_fwnode_handle(node);
-
-	return NULL;
+	return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
+							    to_of_node(child)));
 }
 
 static struct fwnode_handle *
@@ -856,6 +844,54 @@ of_fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static struct fwnode_handle *
+of_fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+				  struct fwnode_handle *prev)
+{
+	return of_fwnode_handle(of_graph_get_next_endpoint(to_of_node(fwnode),
+							   to_of_node(prev)));
+}
+
+static struct fwnode_handle *
+of_fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
+{
+	return of_fwnode_handle(of_parse_phandle(to_of_node(fwnode),
+						 "remote-endpoint", 0));
+}
+
+static struct fwnode_handle *
+of_fwnode_graph_get_port_parent(struct fwnode_handle *fwnode)
+{
+	struct device_node *np;
+
+	/* Get the parent of the port */
+	np = of_get_next_parent(to_of_node(fwnode));
+	if (!np)
+		return NULL;
+
+	/* Is this the "ports" node? If not, it's the port parent. */
+	if (of_node_cmp(np->name, "ports"))
+		return of_fwnode_handle(np);
+
+	return of_fwnode_handle(of_get_next_parent(np));
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
@@ -865,4 +901,8 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
+	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
+	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 };
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8f64b3a..e315d86 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -57,6 +57,11 @@ struct fwnode_endpoint {
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
+ * @graph_get_next_endpoint: Return an endpoint node in an iteration.
+ * @graph_get_remote_endpoint: Return the remote endpoint node of a local
+ *			       endpoint node.
+ * @graph_get_port_parent: Return the parent node of a port node.
+ * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
  */
 struct fwnode_operations {
 	void (*get)(struct fwnode_handle *fwnode);
@@ -76,6 +81,15 @@ struct fwnode_operations {
 			       struct fwnode_handle *child);
 	struct fwnode_handle *
 	(*get_named_child_node)(struct fwnode_handle *fwnode, const char *name);
+	struct fwnode_handle *
+	(*graph_get_next_endpoint)(struct fwnode_handle *fwnode,
+				   struct fwnode_handle *prev);
+	struct fwnode_handle *
+	(*graph_get_remote_endpoint)(struct fwnode_handle *fwnode);
+	struct fwnode_handle *
+	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
+	int (*graph_parse_endpoint)(struct fwnode_handle *fwnode,
+				    struct fwnode_endpoint *endpoint);
 };
 
 #define fwnode_has_op(fwnode, op)				\
-- 
2.7.4

