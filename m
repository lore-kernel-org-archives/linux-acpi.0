From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 16/20] device property: Use fwnode_operations for obtaining the remote endpoint
Date: Thu, 23 Feb 2017 19:01:12 +0200
Message-ID: <1487869276-25244-17-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:60701 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdBWRIf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:35 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_graph_get_remote_endpoint() function to
use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 11 +++++++++++
 drivers/base/property.c | 20 +-------------------
 drivers/of/base.c       | 13 +++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index bf7b7f0..39bffd3 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1184,6 +1184,16 @@ static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
 	return endpoint;
 }
 
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
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1192,4 +1202,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_next_child_node = acpi_get_next_subnode,
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 01add33..fbdd0a0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1153,25 +1153,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
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
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index b7adfb6..17fce20 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2581,6 +2581,18 @@ static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
 	return NULL;
 }
 
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
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2591,4 +2603,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
+	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 };
-- 
2.7.4

