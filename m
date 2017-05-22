From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 5/7] device property: Constify fwnode property API
Date: Mon, 22 May 2017 12:07:40 +0300
Message-ID: <1495444062-23867-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52104 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757666AbdEVJJU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:09:20 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Make fwnode arguments to the fwnode property API const.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c  | 39 +++++++++++++++++++-------------
 drivers/base/property.c  | 54 +++++++++++++++++++++++---------------------
 drivers/of/property.c    | 29 ++++++++++++------------
 include/linux/acpi.h     | 20 +++++++++--------
 include/linux/fwnode.h   | 25 +++++++++++----------
 include/linux/property.h | 58 +++++++++++++++++++++++++-----------------------
 6 files changed, 121 insertions(+), 104 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 7ae4ba3b..a518f4c 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -899,7 +899,7 @@ int acpi_node_prop_read(const struct fwnode_handle *fwnode,
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
+struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child)
 {
 	const struct acpi_device *adevc = to_acpi_device_node(fwnode);
@@ -969,7 +969,7 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
  * Returns parent node of an ACPI device or data firmware node or %NULL if
  * not available.
  */
-struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode)
+struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	if (is_acpi_data_node(fwnode)) {
 		/* All data nodes have parent pointer so just return that */
@@ -998,8 +998,8 @@ struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode)
  * %NULL if there is no next endpoint, ERR_PTR() in case of error. In case
  * of success the next endpoint is returned.
  */
-struct fwnode_handle *acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
-						   struct fwnode_handle *prev)
+struct fwnode_handle *acpi_graph_get_next_endpoint(
+	const struct fwnode_handle *fwnode, struct fwnode_handle *prev)
 {
 	struct fwnode_handle *port = NULL;
 	struct fwnode_handle *endpoint;
@@ -1076,17 +1076,18 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
  * fields requested by the caller. Returns %0 in case of success and
  * negative errno otherwise.
  */
-int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+int acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode,
 				   struct fwnode_handle **parent,
 				   struct fwnode_handle **port,
 				   struct fwnode_handle **endpoint)
 {
+	struct fwnode_handle *fwnode;
 	unsigned int port_nr, endpoint_nr;
 	struct acpi_reference_args args;
 	int ret;
 
 	memset(&args, 0, sizeof(args));
-	ret = acpi_node_get_property_reference(fwnode, "remote-endpoint", 0,
+	ret = acpi_node_get_property_reference(__fwnode, "remote-endpoint", 0,
 					       &args);
 	if (ret)
 		return ret;
@@ -1128,7 +1129,7 @@ int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static bool acpi_fwnode_device_is_available(struct fwnode_handle *fwnode)
+static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	if (!is_acpi_device_node(fwnode))
 		return false;
@@ -1136,14 +1137,14 @@ static bool acpi_fwnode_device_is_available(struct fwnode_handle *fwnode)
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }
 
-static bool acpi_fwnode_property_present(struct fwnode_handle *fwnode,
+static bool acpi_fwnode_property_present(const struct fwnode_handle *fwnode,
 					 const char *propname)
 {
 	return !acpi_node_prop_get(fwnode, propname, NULL);
 }
 
 static int acpi_fwnode_property_read_int_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	unsigned int elem_size, void *val, size_t nval)
 {
 	enum dev_prop_type type;
@@ -1169,15 +1170,21 @@ static int acpi_fwnode_property_read_int_array(
 }
 
 static int acpi_fwnode_property_read_string_array(
-	struct fwnode_handle *fwnode, const char *propname, const char **val,
-	size_t nval)
+	const struct fwnode_handle *fwnode, const char *propname,
+	const char **val, size_t nval)
 {
 	return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
 				   val, nval);
 }
 
+static struct fwnode_handle *
+acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	return acpi_node_get_parent(fwnode);
+}
+
 static struct fwnode_handle *acpi_fwnode_get_named_child_node(
-	struct fwnode_handle *fwnode, const char *childname)
+	const struct fwnode_handle *fwnode, const char *childname)
 {
 	struct fwnode_handle *child;
 
@@ -1193,7 +1200,7 @@ static struct fwnode_handle *acpi_fwnode_get_named_child_node(
 }
 
 static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
-	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+	const struct fwnode_handle *fwnode, struct fwnode_handle *prev)
 {
 	struct fwnode_handle *endpoint;
 
@@ -1205,7 +1212,7 @@ static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
 }
 
 static struct fwnode_handle *acpi_fwnode_graph_get_remote_endpoint(
-	struct fwnode_handle *fwnode)
+	const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *endpoint = NULL;
 
@@ -1214,7 +1221,7 @@ static struct fwnode_handle *acpi_fwnode_graph_get_remote_endpoint(
 	return endpoint;
 }
 
-static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 					    struct fwnode_endpoint *endpoint)
 {
 	struct fwnode_handle *port_fwnode = fwnode_get_parent(fwnode);
@@ -1237,6 +1244,6 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
-	.graph_get_port_parent = acpi_node_get_parent,
+	.graph_get_port_parent = acpi_fwnode_get_parent,
 	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index e0c9489..c00192e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -190,17 +190,17 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
-static bool pset_fwnode_property_present(struct fwnode_handle *fwnode,
+static bool pset_fwnode_property_present(const struct fwnode_handle *fwnode,
 					 const char *propname)
 {
 	return !!pset_prop_get(to_pset_node(fwnode), propname);
 }
 
 static int pset_fwnode_read_int_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	unsigned int elem_size, void *val, size_t nval)
 {
-	struct property_set *node = to_pset_node(fwnode);
+	const struct property_set *node = to_pset_node(fwnode);
 
 	if (!val)
 		return pset_prop_count_elems_of_size(node, propname, elem_size);
@@ -220,7 +220,7 @@ static int pset_fwnode_read_int_array(
 }
 
 static int pset_fwnode_property_read_string_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	const char **val, size_t nval)
 {
 	return pset_prop_read_string_array(to_pset_node(fwnode), propname,
@@ -251,7 +251,8 @@ EXPORT_SYMBOL_GPL(device_property_present);
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
  */
-bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
+bool fwnode_property_present(const struct fwnode_handle *fwnode,
+			     const char *propname)
 {
 	bool ret;
 
@@ -434,7 +435,7 @@ int device_property_match_string(struct device *dev, const char *propname,
 EXPORT_SYMBOL_GPL(device_property_match_string);
 
 static int fwnode_property_read_int_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	unsigned int elem_size, void *val, size_t nval)
 {
 	int ret;
@@ -468,7 +469,7 @@ static int fwnode_property_read_int_array(
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val, size_t nval)
 {
 	return fwnode_property_read_int_array(fwnode, propname, sizeof(u8),
@@ -494,7 +495,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_u16_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u16_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u16 *val, size_t nval)
 {
 	return fwnode_property_read_int_array(fwnode, propname, sizeof(u16),
@@ -520,7 +521,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_u32_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u32_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u32 *val, size_t nval)
 {
 	return fwnode_property_read_int_array(fwnode, propname, sizeof(u32),
@@ -546,7 +547,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u64_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u64 *val, size_t nval)
 {
 	return fwnode_property_read_int_array(fwnode, propname, sizeof(u64),
@@ -572,7 +573,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
  *	   %-EOVERFLOW if the size of the property is not as expected,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 				      const char *propname, const char **val,
 				      size_t nval)
 {
@@ -604,7 +605,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
  *	   %-EPROTO or %-EILSEQ if the property is not a string,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_read_string(struct fwnode_handle *fwnode,
+int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 				const char *propname, const char **val)
 {
 	int ret = fwnode_property_read_string_array(fwnode, propname, val, 1);
@@ -628,7 +629,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string);
  *	   %-EPROTO if the property is not an array of strings,
  *	   %-ENXIO if no suitable firmware interface is present.
  */
-int fwnode_property_match_string(struct fwnode_handle *fwnode,
+int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 	const char *propname, const char *string)
 {
 	const char **values;
@@ -936,7 +937,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  * Return parent firmware node of the given node if possible or %NULL if no
  * parent was available.
  */
-struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
 {
 	return fwnode_call_ptr_op(fwnode, get_parent);
 }
@@ -947,8 +948,9 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
  */
-struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
-						 struct fwnode_handle *child)
+struct fwnode_handle *
+fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
+			   struct fwnode_handle *child)
 {
 	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
 }
@@ -979,8 +981,9 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
  * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
  */
-struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
-						  const char *childname)
+struct fwnode_handle *
+fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
+			    const char *childname)
 {
 	return fwnode_call_ptr_op(fwnode, get_named_child_node, childname);
 }
@@ -1026,7 +1029,7 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
  */
-bool fwnode_device_is_available(struct fwnode_handle *fwnode)
+bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return fwnode_call_int_op(fwnode, device_is_available);
 }
@@ -1164,7 +1167,7 @@ EXPORT_SYMBOL(device_get_mac_address);
  * are available.
  */
 struct fwnode_handle *
-fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
 	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
@@ -1178,7 +1181,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
  * Extracts firmware node of a remote device the @fwnode points to.
  */
 struct fwnode_handle *
-fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
+fwnode_graph_get_remote_port_parent(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *port, *parent;
 
@@ -1197,7 +1200,8 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
  *
  * Extracts firmware node of a remote port the @fwnode points to.
  */
-struct fwnode_handle *fwnode_graph_get_remote_port(struct fwnode_handle *fwnode)
+struct fwnode_handle *
+fwnode_graph_get_remote_port(const struct fwnode_handle *fwnode)
 {
 	return fwnode_get_next_parent(fwnode_graph_get_remote_endpoint(fwnode));
 }
@@ -1210,7 +1214,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
  * Extracts firmware node of a remote endpoint the @fwnode points to.
  */
 struct fwnode_handle *
-fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode)
+fwnode_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 {
 	return fwnode_call_ptr_op(fwnode, graph_get_remote_endpoint);
 }
@@ -1226,7 +1230,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_endpoint);
  *	   to @node. Use fwnode_node_put() on it when done.
  */
 struct fwnode_handle *fwnode_graph_get_remote_node(
-	struct fwnode_handle *fwnode, u32 port_id, u32 endpoint_id)
+	const struct fwnode_handle *fwnode, u32 port_id, u32 endpoint_id)
 {
 	struct fwnode_handle *endpoint = NULL;
 
@@ -1262,7 +1266,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_node);
  * information in @endpoint. The caller must hold a reference to
  * @fwnode.
  */
-int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint)
 {
 	memset(endpoint, 0, sizeof(*endpoint));
diff --git a/drivers/of/property.c b/drivers/of/property.c
index d3ca942..8a15c70 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -772,22 +772,22 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
-static bool of_fwnode_device_is_available(struct fwnode_handle *fwnode)
+static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return of_device_is_available(to_of_node(fwnode));
 }
 
-static bool of_fwnode_property_present(struct fwnode_handle *fwnode,
+static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
 	return of_property_read_bool(to_of_node(fwnode), propname);
 }
 
 static int of_fwnode_property_read_int_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	unsigned int elem_size, void *val, size_t nval)
 {
-	struct device_node *node = to_of_node(fwnode);
+	const struct device_node *node = to_of_node(fwnode);
 
 	if (!val)
 		return of_property_count_elems_of_size(node, propname,
@@ -808,32 +808,33 @@ static int of_fwnode_property_read_int_array(
 }
 
 static int of_fwnode_property_read_string_array(
-	struct fwnode_handle *fwnode, const char *propname,
+	const struct fwnode_handle *fwnode, const char *propname,
 	const char **val, size_t nval)
 {
-	struct device_node *node = to_of_node(fwnode);
+	const struct device_node *node = to_of_node(fwnode);
 
 	return val ?
 		of_property_read_string_array(node, propname, val, nval) :
 		of_property_count_strings(node, propname);
 }
 
-static struct fwnode_handle *of_fwnode_get_parent(struct fwnode_handle *fwnode)
+static struct fwnode_handle *of_fwnode_get_parent(
+	const struct fwnode_handle *fwnode)
 {
 	return of_fwnode_handle(of_get_parent(to_of_node(fwnode)));
 }
 
 static struct fwnode_handle *of_fwnode_get_next_child_node(
-	struct fwnode_handle *fwnode, struct fwnode_handle *child)
+	const struct fwnode_handle *fwnode, struct fwnode_handle *child)
 {
 	return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
 							    to_of_node(child)));
 }
 
 static struct fwnode_handle *of_fwnode_get_named_child_node(
-	struct fwnode_handle *fwnode, const char *childname)
+	const struct fwnode_handle *fwnode, const char *childname)
 {
-	struct device_node *node = to_of_node(fwnode);
+	const struct device_node *node = to_of_node(fwnode);
 	struct device_node *child;
 
 	for_each_available_child_of_node(node, child)
@@ -844,14 +845,14 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
 }
 
 static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
-	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+	const struct fwnode_handle *fwnode, struct fwnode_handle *prev)
 {
 	return of_fwnode_handle(of_graph_get_next_endpoint(to_of_node(fwnode),
 							   to_of_node(prev)));
 }
 
 static struct fwnode_handle *of_fwnode_graph_get_remote_endpoint(
-	struct fwnode_handle *fwnode)
+	const struct fwnode_handle *fwnode)
 {
 	return of_fwnode_handle(of_parse_phandle(to_of_node(fwnode),
 						 "remote-endpoint", 0));
@@ -874,10 +875,10 @@ static struct fwnode_handle *of_fwnode_graph_get_port_parent(
 	return of_fwnode_handle(of_get_next_parent(np));
 }
 
-static int of_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 					  struct fwnode_endpoint *endpoint)
 {
-	struct device_node *node = to_of_node(fwnode);
+	const struct device_node *node = to_of_node(fwnode);
 	struct device_node *port_node = of_get_parent(node);
 
 	endpoint->local_fwnode = fwnode;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b06f31d..65f67166 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1026,13 +1026,14 @@ int acpi_node_prop_read(const struct fwnode_handle *fwnode,
 int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
-struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
+struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child);
-struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode);
+struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode);
 
-struct fwnode_handle *acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
-						   struct fwnode_handle *prev);
-int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+struct fwnode_handle *
+acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
+			     struct fwnode_handle *prev);
+int acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
 				   struct fwnode_handle **remote,
 				   struct fwnode_handle **port,
 				   struct fwnode_handle **endpoint);
@@ -1154,26 +1155,27 @@ static inline int acpi_dev_prop_read(const struct acpi_device *adev,
 }
 
 static inline struct fwnode_handle *
-acpi_get_next_subnode(struct fwnode_handle *fwnode, struct fwnode_handle *child)
+acpi_get_next_subnode(const struct fwnode_handle *fwnode,
+		      struct fwnode_handle *child)
 {
 	return NULL;
 }
 
 static inline struct fwnode_handle *
-acpi_node_get_parent(struct fwnode_handle *fwnode)
+acpi_node_get_parent(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
 
 static inline struct fwnode_handle *
-acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
+acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *prev)
 {
 	return ERR_PTR(-ENXIO);
 }
 
 static inline int
-acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
+acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle **remote,
 			       struct fwnode_handle **port,
 			       struct fwnode_handle **endpoint)
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2100644..0229f8e 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -66,28 +66,29 @@ struct fwnode_endpoint {
 struct fwnode_operations {
 	void (*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
-	bool (*device_is_available)(struct fwnode_handle *fwnode);
-	bool (*property_present)(struct fwnode_handle *fwnode,
+	bool (*device_is_available)(const struct fwnode_handle *fwnode);
+	bool (*property_present)(const struct fwnode_handle *fwnode,
 				 const char *propname);
-	int (*property_read_int_array)(struct fwnode_handle *fwnode,
+	int (*property_read_int_array)(const struct fwnode_handle *fwnode,
 				       const char *propname,
 				       unsigned int elem_size, void *val,
 				       size_t nval);
-	int (*property_read_string_array)(struct fwnode_handle *fwnode_handle,
-					  const char *propname,
-					  const char **val, size_t nval);
-	struct fwnode_handle *(*get_parent)(struct fwnode_handle *fwnode);
+	int (*property_read_string_array)(
+		const struct fwnode_handle *fwnode_handle,
+		const char *propname, const char **val, size_t nval);
+	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_next_child_node)(
-		struct fwnode_handle *fwnode, struct fwnode_handle *child);
+		const struct fwnode_handle *fwnode,
+		struct fwnode_handle *child);
 	struct fwnode_handle *(*get_named_child_node)(
-		struct fwnode_handle *fwnode, const char *name);
+		const struct fwnode_handle *fwnode, const char *name);
 	struct fwnode_handle *(*graph_get_next_endpoint)(
-		struct fwnode_handle *fwnode, struct fwnode_handle *prev);
+		const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 	struct fwnode_handle *(*graph_get_remote_endpoint)(
-		struct fwnode_handle *fwnode);
+		const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*graph_get_port_parent)(
 		struct fwnode_handle *fwnode);
-	int (*graph_parse_endpoint)(struct fwnode_handle *fwnode,
+	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
 				    struct fwnode_endpoint *endpoint);
 };
 
diff --git a/include/linux/property.h b/include/linux/property.h
index b9f4838..dd457cc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -51,46 +51,48 @@ int device_property_read_string(struct device *dev, const char *propname,
 int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
-bool fwnode_device_is_available(struct fwnode_handle *fwnode);
-bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname);
-int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
+bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
+bool fwnode_property_present(const struct fwnode_handle *fwnode,
+			     const char *propname);
+int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
 				  size_t nval);
-int fwnode_property_read_u16_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u16_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u16 *val,
 				   size_t nval);
-int fwnode_property_read_u32_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u32_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u32 *val,
 				   size_t nval);
-int fwnode_property_read_u64_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_u64_array(const struct fwnode_handle *fwnode,
 				   const char *propname, u64 *val,
 				   size_t nval);
-int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
+int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 				      const char *propname, const char **val,
 				      size_t nval);
-int fwnode_property_read_string(struct fwnode_handle *fwnode,
+int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 				const char *propname, const char **val);
-int fwnode_property_match_string(struct fwnode_handle *fwnode,
+int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
-struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
-struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
-struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
-						 struct fwnode_handle *child);
+struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_parent(
+	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_child_node(
+	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 
 #define fwnode_for_each_child_node(fwnode, child)			\
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
 	     child = fwnode_get_next_child_node(fwnode, child))
 
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
-						 struct fwnode_handle *child);
+struct fwnode_handle *device_get_next_child_node(
+	struct device *dev, struct fwnode_handle *child);
 
 #define device_for_each_child_node(dev, child)				\
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
-struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
-						  const char *childname);
+struct fwnode_handle *fwnode_get_named_child_node(
+	const struct fwnode_handle *fwnode, const char *childname);
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
@@ -129,31 +131,31 @@ static inline int device_property_read_u64(struct device *dev,
 	return device_property_read_u64_array(dev, propname, val, 1);
 }
 
-static inline bool fwnode_property_read_bool(struct fwnode_handle *fwnode,
+static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
 	return fwnode_property_present(fwnode, propname);
 }
 
-static inline int fwnode_property_read_u8(struct fwnode_handle *fwnode,
+static inline int fwnode_property_read_u8(const struct fwnode_handle *fwnode,
 					  const char *propname, u8 *val)
 {
 	return fwnode_property_read_u8_array(fwnode, propname, val, 1);
 }
 
-static inline int fwnode_property_read_u16(struct fwnode_handle *fwnode,
+static inline int fwnode_property_read_u16(const struct fwnode_handle *fwnode,
 					   const char *propname, u16 *val)
 {
 	return fwnode_property_read_u16_array(fwnode, propname, val, 1);
 }
 
-static inline int fwnode_property_read_u32(struct fwnode_handle *fwnode,
+static inline int fwnode_property_read_u32(const struct fwnode_handle *fwnode,
 					   const char *propname, u32 *val)
 {
 	return fwnode_property_read_u32_array(fwnode, propname, val, 1);
 }
 
-static inline int fwnode_property_read_u64(struct fwnode_handle *fwnode,
+static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
 					   const char *propname, u64 *val)
 {
 	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
@@ -274,17 +276,17 @@ int device_get_phy_mode(struct device *dev);
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
-	struct fwnode_handle *fwnode, struct fwnode_handle *prev);
+	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *fwnode_graph_get_remote_port_parent(
-	struct fwnode_handle *fwnode);
+	const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_port(
-	struct fwnode_handle *fwnode);
+	const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
-	struct fwnode_handle *fwnode);
+	const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_graph_get_remote_node(
-	struct fwnode_handle *fwnode, u32 port, u32 endpoint);
+	const struct fwnode_handle *fwnode, u32 port, u32 endpoint);
 
-int fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
+int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

