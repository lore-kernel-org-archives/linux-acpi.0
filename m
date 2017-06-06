From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v7 4/6] device property: Introduce fwnode_device_is_available()
Date: Tue,  6 Jun 2017 12:37:39 +0300
Message-ID: <1496741861-8240-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdFFJjF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jun 2017 05:39:05 -0400
In-Reply-To: <1496741861-8240-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, kieran.bingham@ideasonboard.com

Add fwnode_device_is_available() to tell whether the device corresponding
to a certain fwnode_handle is available for use.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c  |  9 +++++++++
 drivers/base/property.c  | 10 ++++++++++
 drivers/of/property.c    |  6 ++++++
 include/linux/fwnode.h   |  1 +
 include/linux/property.h |  1 +
 5 files changed, 27 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a24ca61..917c789 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1121,6 +1121,14 @@ int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static bool acpi_fwnode_device_is_available(struct fwnode_handle *fwnode)
+{
+	if (!is_acpi_device_node(fwnode))
+		return false;
+
+	return acpi_device_is_present(to_acpi_device_node(fwnode));
+}
+
 static bool acpi_fwnode_property_present(struct fwnode_handle *fwnode,
 					 const char *propname)
 {
@@ -1216,6 +1224,7 @@ static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 }
 
 const struct fwnode_operations acpi_fwnode_ops = {
+	.device_is_available = acpi_fwnode_device_is_available,
 	.property_present = acpi_fwnode_property_present,
 	.property_read_int_array = acpi_fwnode_property_read_int_array,
 	.property_read_string_array = acpi_fwnode_property_read_string_array,
diff --git a/drivers/base/property.c b/drivers/base/property.c
index e1a58ac..b979f8a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1022,6 +1022,16 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
 
 /**
+ * fwnode_device_is_available - check if a device is available for use
+ * @fwnode: Pointer to the fwnode of the device.
+ */
+bool fwnode_device_is_available(struct fwnode_handle *fwnode)
+{
+	return fwnode_call_int_op(fwnode, device_is_available);
+}
+EXPORT_SYMBOL_GPL(fwnode_device_is_available);
+
+/**
  * device_get_child_node_count - return the number of child nodes for device
  * @dev: Device to cound the child nodes for
  */
diff --git a/drivers/of/property.c b/drivers/of/property.c
index e859e41..c96389b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -775,6 +775,11 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static bool of_fwnode_device_is_available(struct fwnode_handle *fwnode)
+{
+	return of_device_is_available(to_of_node(fwnode));
+}
+
 static bool of_fwnode_property_present(struct fwnode_handle *fwnode,
 				       const char *propname)
 {
@@ -895,6 +900,7 @@ static int of_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.device_is_available = of_fwnode_device_is_available,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index e315d86..9ab3754 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -66,6 +66,7 @@ struct fwnode_endpoint {
 struct fwnode_operations {
 	void (*get)(struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
+	bool (*device_is_available)(struct fwnode_handle *fwnode);
 	bool (*property_present)(struct fwnode_handle *fwnode,
 				 const char *propname);
 	int (*property_read_int_array)(struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 2f48261..7be014a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -51,6 +51,7 @@ int device_property_read_string(struct device *dev, const char *propname,
 int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
+bool fwnode_device_is_available(struct fwnode_handle *fwnode);
 bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
-- 
2.7.4

