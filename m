From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 01/17] device property: Add operations struct for fwnode operations
Date: Mon,  6 Mar 2017 17:42:47 +0200
Message-ID: <1488814983-25695-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753649AbdCFPnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:33 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Prepare moving firmware specific implementations of the fwnode properties
under a common ops struct. This will allow having a single implementation
of firmware independent portions of the fwnode framework.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/fwnode.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index cb60f29..ede74fb 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -33,4 +33,53 @@ struct fwnode_endpoint {
 	const struct fwnode_handle *local_fwnode;
 };
 
+/**
+ * struct fwnode_operations - Operations for fwnode interface
+ * @get: Get a reference to an fwnode.
+ * @put: Put a reference to an fwnode.
+ * @property_present: Return true if a property is present.
+ * @property_read_integer_array: Read an array of integer properties. Return
+ *				 zero on success, a negative error code
+ *				 otherwise.
+ * @property_read_string_array: Read an array of string properties. Return zero
+ *				on success, a negative error code otherwise.
+ * @get_parent: Return the parent of an fwnode.
+ * @get_next_child_node: Return the next child node in an iteration.
+ * @get_named_child_node: Return a child node with a given name.
+ * @graph_get_next_endpoint: Return an endpoint node in an iteration.
+ * @graph_get_remote_endpoint: Return the remote endpoint node of an endpoint
+ *			       node.
+ * @graph_get_remote_port: Return the remote port node of an endpoint node.
+ * @graph_get_remote_port_parent: Return the parent of a port node of the
+ *				  remote endpoint node of an endpoint node.
+ */
+struct fwnode_operations {
+	void (*get)(struct fwnode_handle *fwnode);
+	void (*put)(struct fwnode_handle *fwnode);
+	bool (*property_present)(struct fwnode_handle *fwnode,
+				 const char *propname);
+	int (*property_read_int_array)(struct fwnode_handle *fwnode,
+				       const char *propname,
+				       unsigned int elem_size, void *val,
+				       size_t nval);
+	int (*property_read_string_array)(struct fwnode_handle *fwnode_handle,
+					  const char *propname,
+					  const char **val, size_t nval);
+	struct fwnode_handle *(*get_parent)(struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*get_next_child_node)(
+		struct fwnode_handle *fwnode, struct fwnode_handle *child);
+	struct fwnode_handle *(*get_named_child_node)(
+		struct fwnode_handle *fwnode, const char *name);
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
+};
+
 #endif
-- 
2.7.4

