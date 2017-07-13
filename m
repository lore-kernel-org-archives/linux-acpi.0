From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 4/7] ACPI: Constify acpi_bus helper functions, switch to macros
Date: Thu, 13 Jul 2017 16:27:04 +0300
Message-ID: <1499952427-16130-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:16139 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdGMN3b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Jul 2017 09:29:31 -0400
In-Reply-To: <1499952427-16130-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Constify arguments to is_acpi_node(), is_acpi_device_node(),
is_acpi_static_node() and acpi_data_node_match(). Make
to_acpi_device_node() and to_acpi_data_node() macros that can cope with
const and non-const arguments.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/acpi/acpi_bus.h | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 91b1e58..89bc213 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -399,43 +399,51 @@ extern const struct fwnode_operations acpi_device_fwnode_ops;
 extern const struct fwnode_operations acpi_data_fwnode_ops;
 extern const struct fwnode_operations acpi_static_fwnode_ops;
 
-static inline bool is_acpi_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) &&
 		(fwnode->ops == &acpi_device_fwnode_ops
 		 || fwnode->ops == &acpi_data_fwnode_ops);
 }
 
-static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
+static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) &&
 		fwnode->ops == &acpi_device_fwnode_ops;
 }
 
-static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
-{
-	return is_acpi_device_node(fwnode) ?
-		container_of(fwnode, struct acpi_device, fwnode) : NULL;
-}
-
-static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
+#define to_acpi_device_node(__fwnode)					\
+	({								\
+		typeof(__fwnode) __to_acpi_device_node_fwnode = __fwnode; \
+									\
+		is_acpi_device_node(__to_acpi_device_node_fwnode) ?	\
+			container_of(__to_acpi_device_node_fwnode,	\
+				     struct acpi_device, fwnode) :	\
+			NULL;						\
+	})
+
+static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &acpi_data_fwnode_ops;
 }
 
-static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
-{
-	return is_acpi_data_node(fwnode) ?
-		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
-}
-
-static inline bool is_acpi_static_node(struct fwnode_handle *fwnode)
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
+static inline bool is_acpi_static_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) &&
 		fwnode->ops == &acpi_static_fwnode_ops;
 }
 
-static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 					const char *name)
 {
 	return is_acpi_data_node(fwnode) ?
-- 
2.7.4

