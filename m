From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 11/17] device property: Use fwnode_operations for obtaining a named child node
Date: Mon,  6 Mar 2017 17:42:57 +0200
Message-ID: <1488814983-25695-12-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8558 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932341AbdCFPnj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:43:39 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_property_get_parent() function to use
struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 17 +++++++++++++++++
 drivers/base/property.c | 18 +-----------------
 drivers/of/base.c       | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index fc1d5da..b704a33 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1156,10 +1156,27 @@ static struct fwnode_handle *acpi_fwnode_get_parent(
 	return acpi_node_get_parent(fwnode);
 }
 
+static struct fwnode_handle *acpi_fwnode_get_named_child_node(
+	struct fwnode_handle *fwnode, const char *childname)
+{
+	struct fwnode_handle *child;
+
+	/*
+	 * Find first matching named child node of this fwnode.
+	 * For ACPI this will be a data only sub-node.
+	 */
+	fwnode_for_each_child_node(fwnode, child)
+		if (acpi_data_node_match(child, childname))
+			return child;
+
+	return NULL;
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
 	.property_read_string_array = acpi_fwnode_property_read_string_array,
 	.get_parent = acpi_fwnode_get_parent,
 	.get_next_child_node = acpi_get_next_subnode,
+	.get_named_child_node = acpi_fwnode_get_named_child_node,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 382463b..33dc5b1 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -972,23 +972,7 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
 struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 						  const char *childname)
 {
-	struct fwnode_handle *child;
-
-	/*
-	 * Find first matching named child node of this fwnode.
-	 * For ACPI this will be a data only sub-node.
-	 */
-	fwnode_for_each_child_node(fwnode, child) {
-		if (is_of_node(child)) {
-			if (!of_node_cmp(to_of_node(child)->name, childname))
-				return child;
-		} else if (is_acpi_data_node(child)) {
-			if (acpi_data_node_match(child, childname))
-				return child;
-		}
-	}
-
-	return NULL;
+	return fwnode_call_ptr_op(fwnode, get_named_child_node, childname);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index aabb063..6cde727 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2621,6 +2621,19 @@ static struct fwnode_handle *of_fwnode_get_next_child_node(
 	return NULL;
 }
 
+static struct fwnode_handle *of_fwnode_get_named_child_node(
+	struct fwnode_handle *fwnode, const char *childname)
+{
+	struct device_node *node = to_of_node(fwnode);
+	struct device_node *child;
+
+	for_each_available_child_of_node(node, child)
+		if (!of_node_cmp(child->name, childname))
+			return of_fwnode_handle(child);
+
+	return NULL;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -2629,4 +2642,5 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
+	.get_named_child_node = of_fwnode_get_named_child_node,
 };
-- 
2.7.4

