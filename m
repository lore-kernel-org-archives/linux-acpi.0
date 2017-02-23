From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 07/20] device property: Use fwnode_operations for fwnode_handle_{get,put}
Date: Thu, 23 Feb 2017 19:01:03 +0200
Message-ID: <1487869276-25244-8-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41112 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751596AbdBWRId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:33 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_handle_get() and fwnode_handle_put()
to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c |  6 ++----
 drivers/of/base.c       | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 906411e..0ab2ea5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1033,8 +1033,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  */
 void fwnode_handle_get(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_get(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, get);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_get);
 
@@ -1048,8 +1047,7 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
  */
 void fwnode_handle_put(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_put(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, put);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index c08ed0e..cbc4998 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2470,4 +2470,17 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
 }
 EXPORT_SYMBOL(of_graph_get_remote_port);
 
-const struct fwnode_operations of_fwnode_ops;
+static void of_fwnode_get(struct fwnode_handle *fwnode)
+{
+	of_node_get(to_of_node(fwnode));
+}
+
+static void of_fwnode_put(struct fwnode_handle *fwnode)
+{
+	of_node_put(to_of_node(fwnode));
+}
+
+const struct fwnode_operations of_fwnode_ops = {
+	.get = of_fwnode_get,
+	.put = of_fwnode_put,
+};
-- 
2.7.4

