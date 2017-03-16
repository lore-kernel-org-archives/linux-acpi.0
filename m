From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 05/13] ACPI / property: Add support for remote endpoints
Date: Thu, 16 Mar 2017 14:31:13 +0200
Message-ID: <1489667481-28521-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

DT has had concept of remote endpoints for some time already. It makes
possible to reference another firmware node through a property called
remote-endpoint. This is already used by some subsystems like v4l2 for
parsing hardware properties related to camera.

This patch adds ACPI support for remote endpoints utilizing _DSD
hierarchical data extensions.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |  23 ++++++++
 2 files changed, 161 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8730ce7..9eb7c13 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -969,3 +969,141 @@ struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode)
 
 	return NULL;
 }
+
+/**
+ * acpi_graph_get_next_endpoint - Get next endpoint ACPI firmware node
+ * @fwnode: Pointer to the parent firmware node
+ * @prev: Previous endpoint node or %NULL to get the first
+ *
+ * Looks up next endpoint ACPI firmware node below a given @fwnode. Returns
+ * %NULL if there is no next endpoint, ERR_PTR() in case of error. In case
+ * of success the next endpoint is returned.
+ */
+struct fwnode_handle *acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+						   struct fwnode_handle *prev)
+{
+	struct fwnode_handle *port = NULL;
+	struct fwnode_handle *endpoint;
+
+	if (!prev) {
+		do {
+			port = fwnode_get_next_child_node(fwnode, port);
+			/* Ports must have port property */
+			if (fwnode_property_present(port, "port"))
+				break;
+		} while (port);
+	} else {
+		port = fwnode_get_parent(prev);
+	}
+
+	if (!port)
+		return NULL;
+
+	endpoint = fwnode_get_next_child_node(port, prev);
+	while (!endpoint) {
+		port = fwnode_get_next_child_node(fwnode, port);
+		if (!port)
+			break;
+		if (fwnode_property_present(port, "port"))
+			endpoint = fwnode_get_next_child_node(port, NULL);
+	}
+
+	if (endpoint) {
+		/* Endpoints must have "endpoint" property */
+		if (!fwnode_property_present(endpoint, "endpoint"))
+			return ERR_PTR(-EPROTO);
+	}
+
+	return endpoint;
+}
+
+/**
+ * acpi_graph_get_child_prop_value - Return a child with a given property value
+ * @fwnode: device fwnode
+ * @prop_name: The name of the property to look for
+ * @val: the desired property value
+ *
+ * Return the port node corresponding to a given port number. Returns
+ * the child node on success, NULL otherwise.
+ */
+static struct fwnode_handle *acpi_graph_get_child_prop_value(
+	struct fwnode_handle *fwnode, const char *prop_name, unsigned int val)
+{
+	struct fwnode_handle *child;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		u32 nr;
+
+		if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
+			continue;
+
+		if (val == nr)
+			return child;
+	}
+
+	return NULL;
+}
+
+
+/**
+ * acpi_graph_get_remote_enpoint - Parses and returns remote end of an endpoint
+ * @fwnode: Endpoint firmware node pointing to a remote device
+ * @parent: Firmware node of remote port parent is filled here if not %NULL
+ * @port: Firmware node of remote port is filled here if not %NULL
+ * @endpoint: Firmware node of remote endpoint is filled here if not %NULL
+ *
+ * Function parses remote end of ACPI firmware remote endpoint and fills in
+ * fields requested by the caller. Returns %0 in case of success and
+ * negative errno otherwise.
+ */
+int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+				   struct fwnode_handle **parent,
+				   struct fwnode_handle **port,
+				   struct fwnode_handle **endpoint)
+{
+	unsigned int port_nr, endpoint_nr;
+	struct acpi_reference_args args;
+	int ret;
+
+	memset(&args, 0, sizeof(args));
+	ret = acpi_node_get_property_reference(fwnode, "remote-endpoint", 0,
+					       &args);
+	if (ret)
+		return ret;
+
+	/*
+	 * Always require two arguments with the reference: port and
+	 * endpoint indices.
+	 */
+	if (args.nargs != 2)
+		return -EPROTO;
+
+	fwnode = acpi_fwnode_handle(args.adev);
+	port_nr = args.args[0];
+	endpoint_nr = args.args[1];
+
+	if (parent)
+		*parent = fwnode;
+
+	if (!port && !endpoint)
+		return 0;
+
+	fwnode = acpi_graph_get_child_prop_value(fwnode, "port", port_nr);
+	if (!fwnode)
+		return -EPROTO;
+
+	if (port)
+		*port = fwnode;
+
+	if (!endpoint)
+		return 0;
+
+	fwnode = acpi_graph_get_child_prop_value(fwnode, "endpoint",
+						 endpoint_nr);
+	if (!fwnode)
+		return -EPROTO;
+
+	*endpoint = fwnode;
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8096b3a..9d920c0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,6 +1004,13 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
 struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode);
 
+struct fwnode_handle *acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+						   struct fwnode_handle *prev);
+int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+				   struct fwnode_handle **remote,
+				   struct fwnode_handle **port,
+				   struct fwnode_handle **endpoint);
+
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
 						 struct acpi_probe_entry *);
@@ -1131,6 +1138,22 @@ acpi_node_get_parent(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline struct fwnode_handle *
+acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+			     struct fwnode_handle *prev)
+{
+	return ERR_PTR(-ENXIO);
+}
+
+static inline int
+acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+			       struct fwnode_handle **remote,
+			       struct fwnode_handle **port,
+			       struct fwnode_handle **endpoint)
+{
+	return -ENXIO;
+}
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn) \
 	static const void * __acpi_table_##name[]			\
 		__attribute__((unused))					\
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
