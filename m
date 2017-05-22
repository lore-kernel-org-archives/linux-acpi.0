From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 2/7] ACPI: Constify acpi_bus helper functions, switch to macros
Date: Mon, 22 May 2017 12:07:37 +0300
Message-ID: <1495444062-23867-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56117 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757659AbdEVJIx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:08:53 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Constify arguments to

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/acpi/acpi_bus.h | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 197f3ff..b2e6214 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -394,35 +394,44 @@ struct acpi_data_node {
 	struct completion kobj_done;
 };
 
-static inline bool is_acpi_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && (fwnode->type == FWNODE_ACPI
 		|| fwnode->type == FWNODE_ACPI_DATA);
 }
 
-static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI;
 }
 
-static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
-{
-	return is_acpi_device_node(fwnode) ?
-		container_of(fwnode, struct acpi_device, fwnode) : NULL;
-}
 
-static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
-{
-	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
-}
+#define to_acpi_device_node(__fwnode)					\
+	({								\
+		typeof(__fwnode) __to_acpi_device_node_fwnode = __fwnode; \
+									\
+		is_acpi_device_node(__to_acpi_device_node_fwnode) ?	\
+			container_of(__to_acpi_device_node_fwnode,	\
+				     struct acpi_device, fwnode) :	\
+			NULL;						\
+	})
 
-static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 {
-	return is_acpi_data_node(fwnode) ?
-		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
+	return fwnode && fwnode->type == FWNODE_ACPI_DATA;
 }
 
-static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+#define to_acpi_data_node(__fwnode)					\
+	({								\
+		typeof(__fwnode) __to_acpi_data_node_fwnode = __fwnode;	\
+									\
+		is_acpi_data_node(__to_acpi_data_node_fwnode) ?		\
+			container_of(__to_acpi_data_node_fwnode,	\
+				     struct acpi_data_node, fwnode) :	\
+			NULL;						\
+	})
+
+static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 					const char *name)
 {
 	return is_acpi_data_node(fwnode) ?
-- 
2.7.4

