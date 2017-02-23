From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 08/20] device property: Use fwnode_operations for fwnode_property_present()
Date: Thu, 23 Feb 2017 19:01:04 +0200
Message-ID: <1487869276-25244-9-git-send-email-sakari.ailus@linux.intel.com>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36211 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbdBWRId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 12:08:33 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

Change the implementation of fwnode_property_present() to use struct
fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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
index 0ab2ea5..37aea12 100644
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
index cbc4998..84f2530 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2480,7 +2480,14 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
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

