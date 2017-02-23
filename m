From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 12/20] device property: Use fwnode_operations for obtaining parent node
Date: Thu, 23 Feb 2017 19:01:08 +0200
Message-ID: <1487869276-25244-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_property_get_parent() function to use
struct fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c |  7 +++++++
 drivers/base/property.c | 14 +-------------
 drivers/of/base.c       | 12 ++++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 4e76b31..a20b81f 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1150,8 +1150,15 @@ static int acpi_fwnode_property_read_string_array(
 				   val, nval);
 }
 
+static struct fwnode_handle *acpi_fwnode_get_parent(
+	struct fwnode_handle *fwnode)
+{
+	return acpi_node_get_parent(fwnode);
+}
+
 const struct fwnode_operations acpi_fwnode_ops = {
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
 	.property_read_string_array = acpi_fwnode_property_read_string_array,
+	.get_parent = acpi_fwnode_get_parent,
 };
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 136ba66..e730f4f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -863,19 +863,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  */
 struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *parent = NULL;
-
-	if (is_of_node(fwnode)) {
-		struct device_node *node;
-
-		node = of_get_parent(to_of_node(fwnode));
-		if (node)
-			parent = &node->fwnode;
-	} else if (is_acpi_node(fwnode)) {
-		parent = acpi_node_get_parent(fwnode);
-	}
-
-	return parent;
+	return fwnode_call_ptr_op(fwnode, get_parent);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_parent);
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7bd9eec..5825eda 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2531,10 +2531,22 @@ static int of_fwnode_property_read_string_array(
 	return -EOVERFLOW;
 }
 
+static struct fwnode_handle *of_fwnode_get_parent(struct fwnode_handle *fwnode)
+{
+	struct device_node *node;
+
+	node = of_get_parent(to_of_node(fwnode));
+	if (node)
+		return of_fwnode_handle(node);
+
+	return NULL;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.get_parent = of_fwnode_get_parent,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
