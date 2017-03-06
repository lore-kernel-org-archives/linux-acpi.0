From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 10/17] device property: Use fwnode_operations for obtaining next child node
Date: Mon,  6 Mar 2017 17:42:56 +0200
Message-ID: <1488814983-25695-11-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47932 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754637AbdCFPoJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:44:09 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_property_get_parent() function to use
struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c |  1 +
 drivers/base/property.c | 13 +------------
 drivers/of/base.c       | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a20b81f..fc1d5da 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1161,4 +1161,5 @@ const struct fwnode_operations acpi_fwnode_ops = {
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
 	.property_read_string_array = acpi_fwnode_property_read_string_array,
 	.get_parent = acpi_fwnode_get_parent,
+	.get_next_child_node = acpi_get_next_subnode,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index f8ac9f2..382463b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -940,18 +940,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
 struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child)
 {
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_get_next_available_child(to_of_node(fwnode),
-						   to_of_node(child));
-		if (node)
-			return &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		return acpi_get_next_subnode(fwnode, child);
-	}
-
-	return NULL;
+	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 190107b..aabb063 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2608,6 +2608,19 @@ static struct fwnode_handle *of_fwnode_get_parent(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static struct fwnode_handle *of_fwnode_get_next_child_node(
+	struct fwnode_handle *fwnode, struct fwnode_handle *child)
+{
+	struct device_node *node;
+
+	node = of_get_next_available_child(to_of_node(fwnode),
+					   to_of_node(child));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2615,4 +2628,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_parent = of_fwnode_get_parent,
+	.get_next_child_node = of_fwnode_get_next_child_node,
 };
-- 
2.7.4

