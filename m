From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 17/20] device property: Use fwnode_operations for obtaining the remote port
Date: Thu, 23 Feb 2017 19:01:13 +0200
Message-ID: <1487869276-25244-18-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_graph_get_remote_port() function to
use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 11 +++++++++++
 drivers/base/property.c | 18 +-----------------
 drivers/of/base.c       | 13 +++++++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 39bffd3..623260d 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1194,6 +1194,16 @@ static struct fwnode_handle *acpi_fwnode_graph_get_remote_endpoint(
 	return endpoint;
 }
 
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
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1203,4 +1213,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
+	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index fbdd0a0..5636290 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1124,23 +1124,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
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
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 17fce20..bdc195c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2593,6 +2593,18 @@ static struct fwnode_handle *of_fwnode_graph_get_remote_endpoint(
 	return NULL;
 }
 
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
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2604,4 +2616,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_named_child_node = of_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
+	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
