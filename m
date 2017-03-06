From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 17/17] device property: Implement fwnode_get_next_parent() using fwnode interface
Date: Mon,  6 Mar 2017 17:43:03 +0200
Message-ID: <1488814983-25695-18-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13979 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754100AbdCFPok (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 10:44:40 -0500
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
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
index c6399cf..7beafdf 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -903,17 +903,9 @@ EXPORT_SYMBOL_GPL(device_add_properties);
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

