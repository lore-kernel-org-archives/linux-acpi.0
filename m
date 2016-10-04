From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 05/15] ACPI / property: Add support for remote endpoints
Date: Wed,  5 Oct 2016 01:45:38 +0300
Message-ID: <1475621148-21427-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16959 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbcJDWr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:29 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

DT has had concept of remote endpoins for some time already. It makes
possible to reference another firmware node through a property named
"remote-endpoint". This is already used by some subsystems such as V4L2
for parsing hardware properties related to camera.

This adds ACPI implementation of remote endpoints.

Each device must have data extension property with name "ports". This lists
all ports within the device. Each port hold similar data extension that
contains all the endpoints available. The "remote-endpoint" reference then
can be used to match the device, port and endpoind accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |  23 ++++++++
 2 files changed, 170 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f4e812e..6f561e7 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -891,3 +891,150 @@ struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode)
 
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
+	struct fwnode_handle *ports, *port, *endpoint;
+
+	ports = fwnode_get_named_child_node(fwnode, "ports");
+	if (!ports)
+		return NULL;
+
+	if (!prev) {
+		port = fwnode_get_next_child_node(ports, NULL);
+		if (!port)
+			return NULL;
+	} else {
+		port = fwnode_get_parent(prev);
+	}
+
+	/* Ports must have "port" property */
+	if (!fwnode_property_present(port, "port"))
+		return ERR_PTR(-EPROTO);
+
+	endpoint = fwnode_get_next_child_node(port, prev);
+	if (!endpoint) {
+		/* Find the next port under ports */
+		port = fwnode_get_next_child_node(ports, port);
+		if (port) {
+			if (!fwnode_property_present(port, "port"))
+				return ERR_PTR(-EPROTO);
+			endpoint = fwnode_get_next_child_node(port, NULL);
+		}
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
+ * acpi_graph_get_child_at - Return a data extension child at given index
+ * @fwnode: parent node
+ * @at: index of the child node in the data extension package
+ *
+ * Find the child node at index of a data extension. Returns the child
+ * node on success, NULL otherwise.
+ */
+static struct fwnode_handle *acpi_graph_get_child_at(
+	struct fwnode_handle *fwnode, unsigned int at)
+{
+	struct fwnode_handle *child;
+	unsigned int i = 0;
+
+	fwnode_for_each_child_node(fwnode, child) {
+		if (i++ < at)
+			continue;
+
+		return child;
+	}
+
+	return NULL;
+}
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
+	unsigned int ports_idx, port_idx, endpoint_idx;
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
+	 * Always require three arguments with the reference: ports
+	 * list and a given port and a given endpoint.
+	 */
+	if (args.nargs != 3)
+		return -EPROTO;
+
+	fwnode = acpi_fwnode_handle(args.adev);
+	ports_idx = args.args[0];
+	port_idx = args.args[1];
+	endpoint_idx = args.args[2];
+
+	if (parent)
+		*parent = fwnode;
+
+	fwnode = acpi_graph_get_child_at(fwnode, ports_idx);
+	if (!fwnode || !acpi_data_node_match(fwnode, "ports"))
+		return -EPROTO;
+
+	if (!port && !endpoint)
+		return 0;
+
+	fwnode = acpi_graph_get_child_at(fwnode, port_idx);
+	if (!fwnode)
+		return -EPROTO;
+
+	if (!fwnode_property_present(fwnode, "port"))
+		return -EPROTO;
+
+	if (port)
+		*port = fwnode;
+
+	if (!endpoint)
+		return 0;
+
+	fwnode = acpi_graph_get_child_at(fwnode, endpoint_idx);
+	if (!fwnode)
+		return -EPROTO;
+
+	if (!fwnode_property_present(fwnode, "endpoint"))
+		return -EPROTO;
+
+	*endpoint = fwnode;
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1424cce..5d7fabd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -963,6 +963,13 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
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
@@ -1082,6 +1089,22 @@ acpi_node_get_parent(struct fwnode_handle *fwnode)
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

