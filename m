From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 04/17] device property: Use fwnode_operations for fwnode_handle_{get,put}
Date: Mon,  6 Mar 2017 17:42:50 +0200
Message-ID: <1488814983-25695-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_handle_get() and fwnode_handle_put()
to use struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c |  6 ++----
 drivers/of/base.c       | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e4794bf..faa4fa6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1098,8 +1098,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  */
 void fwnode_handle_get(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_get(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, get);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_get);
 
@@ -1113,8 +1112,7 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
  */
 void fwnode_handle_put(struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		of_node_put(to_of_node(fwnode));
+	fwnode_call_void_op(fwnode, put);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index b07af01..c18da80 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2536,4 +2536,17 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
