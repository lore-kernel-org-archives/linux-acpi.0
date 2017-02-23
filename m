From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 19/20] device property: Use fwnode_operations for parsing graph endpoint
Date: Thu, 23 Feb 2017 19:01:15 +0200
Message-ID: <1487869276-25244-20-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22536 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbdBWRKJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:10:09 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_graph_parse_endpoint() function to
use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 19 +++++++++++++++++++
 drivers/base/property.c | 22 +---------------------
 drivers/of/base.c       | 17 +++++++++++++++++
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1790256..23bc12d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1214,6 +1214,24 @@ static struct fwnode_handle *acpi_fwnode_graph_get_remote_port_parent(
 	return parent;
 }
 
+static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+					    struct fwnode_endpoint *endpoint)
+{
+	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
+	struct fwnode_handle *iter;
+
+	endpoint->local_fwnode = fwnode;
+
+	fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
+
+	for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
+	     iter != fwnode;
+	     iter = fwnode_get_next_child_node(port_fwnode, iter))
+		endpoint->id++;
+
+	return 0;
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1225,4 +1243,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
 	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
+	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 258c83d..f108469 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1134,28 +1134,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint)
 {
-	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
-
 	memset(endpoint, 0, sizeof(*endpoint));
 
-	endpoint->local_fwnode = fwnode;
-
-	if (is_acpi_node(port_fwnode)) {
-		struct fwnode_handle *iter;
-
-		fwnode_property_read_u32(port_fwnode, "port", &endpoint->port);
-
-		for (iter = fwnode_get_next_child_node(port_fwnode, NULL);
-		     iter != fwnode;
-		     iter = fwnode_get_next_child_node(port_fwnode, iter))
-			endpoint->id++;
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
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 2b4a13f..d3757ab 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2617,6 +2617,22 @@ static struct fwnode_handle *of_fwnode_graph_get_remote_port_parent(
 	return NULL;
 }
 
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
@@ -2630,4 +2646,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
 	.graph_get_remote_port_parent = of_fwnode_graph_get_remote_port_parent,
+	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 };
-- 
2.7.4

