From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 12/17] device property: Use fwnode_operations for obtaining next graph endpoint
Date: Mon,  6 Mar 2017 17:42:58 +0200
Message-ID: <1488814983-25695-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8558 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932380AbdCFPnk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:40 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_graph_get_next_endpoint() function to
use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 13 +++++++++++++
 drivers/base/property.c | 19 +------------------
 drivers/of/base.c       | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b704a33..bf7b7f0 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1172,6 +1172,18 @@ static struct fwnode_handle *acpi_fwnode_get_named_child_node(
 	return NULL;
 }
 
+static struct fwnode_handle *acpi_fwnode_graph_get_next_endpoint(
+	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+{
+	struct fwnode_handle *endpoint;
+
+	endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
+	if (IS_ERR(endpoint))
+		return NULL;
+
+	return endpoint;
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
@@ -1179,4 +1191,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.get_parent = acpi_fwnode_get_parent,
 	.get_next_child_node = acpi_get_next_subnode,
 	.get_named_child_node = acpi_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 33dc5b1..d305f70 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1147,24 +1147,7 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	struct fwnode_handle *endpoint = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_graph_get_next_endpoint(to_of_node(fwnode),
-						  to_of_node(prev));
-
-		if (node)
-			endpoint = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		endpoint = acpi_graph_get_next_endpoint(fwnode, prev);
-		if (IS_ERR(endpoint))
-			endpoint = NULL;
-	}
-
-	return endpoint;
-
+	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6cde727..3e4be6e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2634,6 +2634,19 @@ static struct fwnode_handle *of_fwnode_get_named_child_node(
 	return NULL;
 }
 
+static struct fwnode_handle *of_fwnode_graph_get_next_endpoint(
+	struct fwnode_handle *fwnode, struct fwnode_handle *prev)
+{
+	struct device_node *node;
+
+	node = of_graph_get_next_endpoint(to_of_node(fwnode),
+					  to_of_node(prev));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2643,4 +2656,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 };
-- 
2.7.4

