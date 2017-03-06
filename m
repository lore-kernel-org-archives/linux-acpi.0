From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 05/17] device property: Use fwnode_operations for fwnode_property_present()
Date: Mon,  6 Mar 2017 17:42:51 +0200
Message-ID: <1488814983-25695-6-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Change the implementation of fwnode_property_present() to use struct
fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 10 +++++++++-
 drivers/base/property.c | 27 ++++++++++++---------------
 drivers/of/base.c       |  7 +++++++
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 0651a74..14b96ec 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1110,4 +1110,12 @@ int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-const struct fwnode_operations acpi_fwnode_ops;
+static bool acpi_fwnode_property_present(struct fwnode_handle *fwnode,
+					 const char *propname)
+{
+	return !acpi_node_prop_get(fwnode, propname, NULL);
+}
+
+const struct fwnode_operations acpi_fwnode_ops = {
+	.property_present = acpi_fwnode_property_present,
+};
diff --git a/drivers/base/property.c b/drivers/base/property.c
index faa4fa6..e150df0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -183,7 +183,15 @@ static int pset_prop_read_string(struct property_set *pset,
 	return 0;
 }
 
-static const struct fwnode_operations pset_fwnode_ops;
+static bool pset_fwnode_property_present(struct fwnode_handle *fwnode,
+					 const char *propname)
+{
+	return !!pset_prop_get(to_pset_node(fwnode), propname);
+}
+
+static const struct fwnode_operations pset_fwnode_ops = {
+	.property_present = pset_fwnode_property_present,
+};
 
 /**
  * device_property_present - check if a property of a device is present
@@ -198,18 +206,6 @@ bool device_property_present(struct device *dev, const char *propname)
 }
 EXPORT_SYMBOL_GPL(device_property_present);
 
-static bool __fwnode_property_present(struct fwnode_handle *fwnode,
-				      const char *propname)
-{
-	if (is_of_node(fwnode))
-		return of_property_read_bool(to_of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return !acpi_node_prop_get(fwnode, propname, NULL);
-	else if (is_pset_node(fwnode))
-		return !!pset_prop_get(to_pset_node(fwnode), propname);
-	return false;
-}
-
 /**
  * fwnode_property_present - check if a property of a firmware node is present
  * @fwnode: Firmware node whose property to check
@@ -219,10 +215,11 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 {
 	bool ret;
 
-	ret = __fwnode_property_present(fwnode, propname);
+	ret = fwnode_call_int_op(fwnode, property_present, propname);
 	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
 	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = __fwnode_property_present(fwnode->secondary, propname);
+		ret = fwnode_call_int_op(fwnode->secondary, property_present,
+					 propname);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
diff --git a/drivers/of/base.c b/drivers/of/base.c
index c18da80..46e0b2a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2546,7 +2546,14 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static bool of_fwnode_property_present(struct fwnode_handle *fwnode,
+				       const char *propname)
+{
+	return of_property_read_bool(to_of_node(fwnode), propname);
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.property_present = of_fwnode_property_present,
 };
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
