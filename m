From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 20/20] device property: Implement fwnode_get_next_parent() using fwnode interface
Date: Thu, 23 Feb 2017 19:01:16 +0200
Message-ID: <1487869276-25244-21-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:46610 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbdBWRIf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:35 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

fwnode_get_next_parent() can be implemented using fwnode interface. Do
that to avoid implementing an additional callback for the function in
struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f108469..6ee8f4f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -838,17 +838,9 @@ EXPORT_SYMBOL_GPL(device_add_properties);
  */
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
+	struct fwnode_handle *parent = fwnode_call_ptr_op(fwnode, get_parent);
 
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_get_next_parent(to_of_node(fwnode));
-		if (node)
-			parent = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		parent = acpi_node_get_parent(fwnode);
-	}
+	fwnode_handle_put(fwnode);
 
 	return parent;
 }
-- 
2.7.4

