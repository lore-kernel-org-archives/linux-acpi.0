From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 14/17] device property: Use fwnode_operations for obtaining the remote port
Date: Mon,  6 Mar 2017 17:43:00 +0200
Message-ID: <1488814983-25695-15-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42750 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932357AbdCFPnk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:40 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_graph_get_remote_port() function to
use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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
index 32b68a1..b9643d7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1189,23 +1189,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
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
index 68c9c7f..7a4d6e9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2659,6 +2659,18 @@ static struct fwnode_handle *of_fwnode_graph_get_remote_endpoint(
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
@@ -2670,4 +2682,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_named_child_node = of_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
+	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
 };
-- 
2.7.4

