From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 4/8] ACPI: Constify acpi_bus helper functions, switch to macros
Date: Fri, 21 Jul 2017 14:39:33 +0300
Message-ID: <1500637177-16095-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, erik.veijola-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Constify arguments to is_acpi_node(), is_acpi_device_node(),
is_acpi_static_node() and acpi_data_node_match(). Make
to_acpi_device_node() and to_acpi_data_node() macros that can cope with
const and non-const arguments.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
