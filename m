From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/3] device property: Add FW type agnostic fwnode_graph_get_remote_node
Date: Fri, 24 Mar 2017 13:03:52 +0200
Message-ID: <1490353432-12017-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1490353432-12017-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490353432-12017-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add fwnode_graph_get_remote_node() function which is equivalent to
of_graph_get_remote_node() on OF.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/base/property.c  | 16 ++++++++++++++++
 drivers/of/property.c    | 11 +++++++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  2 ++
 5 files changed, 64 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index d839563..0efcabb 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1228,6 +1228,38 @@ static struct fwnode_handle *acpi_fwnode_graph_get_remote_port_parent(
 	return parent;
 }
 
+static struct fwnode_handle *acpi_fwnode_graph_get_remote_node(
+	struct fwnode_handle *fwnode, u32 port_id, u32 endpoint_id)
+{
+	struct fwnode_handle *endpoint = NULL;
+
+	while ((endpoint = fwnode_graph_get_next_endpoint(fwnode, endpoint))) {
+		struct fwnode_endpoint fwnode_ep;
+		struct fwnode_handle *remote;
+		struct acpi_device *adev;
+		int ret;
+
+		ret = fwnode_graph_parse_endpoint(endpoint, &fwnode_ep);
+		if (ret < 0)
+			continue;
+
+		if (fwnode_ep.port != port_id || fwnode_ep.id != endpoint_id)
+			continue;
+
+		remote = fwnode_graph_get_remote_port_parent(endpoint);
+		if (!remote)
+			return NULL;
+
+		adev = to_acpi_device_node(remote);
+		if (!adev)
+			return NULL;
+
+		return acpi_device_is_present(adev) ? remote : NULL;
+	}
+
+	return NULL;
+}
+
 static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 					    struct fwnode_endpoint *endpoint)
 {
@@ -1252,5 +1284,6 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
 	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
+	.graph_get_remote_node = acpi_fwnode_graph_get_remote_node,
 	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 4f355df..ce98e01 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1203,6 +1203,22 @@ fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
 
 /**
+ * fwnode_graph_get_remote_node - get remote parent fwnode_handle for given port/endpoint
+ * @fwnode: pointer to parent fwnode_handle containing graph port/endpoint
+ * @port: identifier of the parent port node
+ * @endpoint: identifier of the endpoint node
+ *
+ * Return: Remote fwnode handle associated with remote endpoint node linked
+ *	   to @node. Use fwnode_node_put() on it when done.
+ */
+struct fwnode_handle *fwnode_graph_get_remote_node(
+	struct fwnode_handle *fwnode, u32 port, u32 endpoint)
+{
+	return fwnode_call_ptr_op(fwnode, graph_get_remote_node, port, endpoint);
+}
+EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
+
+/**
  * fwnode_graph_parse_endpoint - parse common endpoint node properties
  * @fwnode: pointer to endpoint fwnode_handle
  * @endpoint: pointer to the fwnode endpoint data structure
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 572c36c..c73d181 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -863,6 +863,16 @@ static struct fwnode_handle *of_fwnode_graph_get_remote_port_parent(
 	return NULL;
 }
 
+static struct fwnode_handle_node *of_fwnode_graph_get_remote_node(
+	const struct fwnode_handle *fwnode, u32 port, u32 endpoint)
+{
+	struct fwnode_handle *remote;
+
+	remote = of_graph_get_remote_node(to_of_node(fwnode), port, endpoint);
+
+	return remote ? of_fwnode_handle(remote) : NULL;
+}
+
 static int of_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 					  struct fwnode_endpoint *endpoint)
 {
@@ -892,5 +902,6 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
 	.graph_get_remote_port_parent = of_fwnode_graph_get_remote_port_parent,
+	.graph_get_remote_node = of_fwnode_graph_get_remote_node,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 };
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 351c38d..e1168c0 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -89,6 +89,8 @@ struct fwnode_operations {
 		struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*graph_get_remote_port_parent)(
 		struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*graph_get_remote_node)(
+		struct fwnode_handle *fwnode, u32 port, u32 endpoint);
 	int (*graph_parse_endpoint)(struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
 };
diff --git a/include/linux/property.h b/include/linux/property.h
index 2f48261..720c30a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -280,6 +280,8 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 	struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_graph_get_remote_node(
+	struct fwnode_handle *fwnode, u32 port, u32 endpoint);
 
 int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
