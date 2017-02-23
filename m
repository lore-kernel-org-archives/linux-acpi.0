From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 18/20] device property: Use fwnode_operations for obtaining the remote port parent
Date: Thu, 23 Feb 2017 19:01:14 +0200
Message-ID: <1487869276-25244-19-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:51735 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdBWRLl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:11:41 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_graph_get_remote_port_parent()
function to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 11 +++++++++++
 drivers/base/property.c | 19 +------------------
 drivers/of/base.c       | 13 +++++++++++++
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 623260d..1790256 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1204,6 +1204,16 @@ static struct fwnode_handle *acpi_fwnode_graph_get_remote_port(
 	return port;
 }
 
+static struct fwnode_handle *acpi_fwnode_graph_get_remote_port_parent(
+	struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent = NULL;
+
+	acpi_graph_get_remote_endpoint(fwnode, &parent, NULL, NULL);
+
+	return parent;
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1214,4 +1224,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = acpi_fwnode_graph_get_remote_port,
+	.graph_get_remote_port_parent = acpi_fwnode_graph_get_remote_port_parent,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 5636290..258c83d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1095,24 +1095,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
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
-
-	return parent;
+	return fwnode_call_ptr_op(fwnode, graph_get_remote_port_parent);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index bdc195c..2b4a13f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2605,6 +2605,18 @@ static struct fwnode_handle *of_fwnode_graph_get_remote_port(
 	return NULL;
 }
 
+static struct fwnode_handle *of_fwnode_graph_get_remote_port_parent(
+	struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_graph_get_remote_port_parent(to_of_node(fwnode));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2617,4 +2629,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_remote_port = of_fwnode_graph_get_remote_port,
+	.graph_get_remote_port_parent = of_fwnode_graph_get_remote_port_parent,
 };
-- 
2.7.4

