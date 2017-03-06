From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 09/17] device property: Use fwnode_operations for obtaining parent node
Date: Mon,  6 Mar 2017 17:42:55 +0200
Message-ID: <1488814983-25695-10-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
index 62bd59d..f8ac9f2 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -928,19 +928,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
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
index 18e51b5..190107b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2597,10 +2597,22 @@ static int of_fwnode_property_read_string_array(
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
