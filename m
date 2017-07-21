From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 2/8] device property: Get rid of struct fwnode_handle type field
Date: Fri, 21 Jul 2017 14:39:31 +0300
Message-ID: <1500637177-16095-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdGULlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 07:41:40 -0400
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com, andriy.shevchenko@linux.intel.com

Instead of relying on the struct fwnode_handle type field, define
fwnode_operations structs for all separate types of fwnodes. To find out
the type, compare to the ops field to relevant ops structs.

This change has two benefits:

1. it avoids adding the type field to each and every instance of struct
fwnode_handle, thus saving memory and

2. makes the ops field the single factor that defines both the types of
the fwnode as well as defines the implementation of its operations,
decreasing the possibility of bugs when developing code dealing with
fwnode internals.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c   | 47 ++++++++++++++++++++++++++++-------------------
 drivers/acpi/scan.c       |  3 +--
 drivers/base/property.c   |  5 +++--
 drivers/of/property.c     |  1 +
 include/acpi/acpi_bus.h   | 20 ++++++++++++++++----
 include/linux/acpi.h      |  8 ++------
 include/linux/fwnode.h    | 11 -----------
 include/linux/irqdomain.h |  4 +++-
 include/linux/of.h        |  3 +--
 kernel/irq/irqdomain.c    | 10 +++++-----
 10 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 917c789..cb6a3b3 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -56,8 +56,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 		return false;
 
 	dn->name = link->package.elements[0].string.pointer;
-	dn->fwnode.type = FWNODE_ACPI_DATA;
-	dn->fwnode.ops = &acpi_fwnode_ops;
+	dn->fwnode.ops = &acpi_data_fwnode_ops;
 	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
@@ -469,10 +468,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_property);
 
 static struct acpi_device_data *acpi_device_data_of_node(struct fwnode_handle *fwnode)
 {
-	if (fwnode->type == FWNODE_ACPI) {
+	if (is_acpi_device_node(fwnode)) {
 		struct acpi_device *adev = to_acpi_device_node(fwnode);
 		return &adev->data;
-	} else if (fwnode->type == FWNODE_ACPI_DATA) {
+	} else if (is_acpi_data_node(fwnode)) {
 		struct acpi_data_node *dn = to_acpi_data_node(fwnode);
 		return &dn->data;
 	}
@@ -903,7 +902,7 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct list_head *head, *next;
 
-	if (!child || child->type == FWNODE_ACPI) {
+	if (!child || is_acpi_device_node(child)) {
 		if (adev)
 			head = &adev->children;
 		else
@@ -927,7 +926,7 @@ struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 	}
 
  nondev:
-	if (!child || child->type == FWNODE_ACPI_DATA) {
+	if (!child || is_acpi_data_node(child)) {
 		struct acpi_data_node *data = to_acpi_data_node(fwnode);
 		struct acpi_data_node *dn;
 
@@ -1223,16 +1222,26 @@ static int acpi_fwnode_graph_parse_endpoint(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-const struct fwnode_operations acpi_fwnode_ops = {
-	.device_is_available = acpi_fwnode_device_is_available,
-	.property_present = acpi_fwnode_property_present,
-	.property_read_int_array = acpi_fwnode_property_read_int_array,
-	.property_read_string_array = acpi_fwnode_property_read_string_array,
-	.get_parent = acpi_node_get_parent,
-	.get_next_child_node = acpi_get_next_subnode,
-	.get_named_child_node = acpi_fwnode_get_named_child_node,
-	.graph_get_next_endpoint = acpi_fwnode_graph_get_next_endpoint,
-	.graph_get_remote_endpoint = acpi_fwnode_graph_get_remote_endpoint,
-	.graph_get_port_parent = acpi_node_get_parent,
-	.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint,
-};
+#define DECLARE_ACPI_FWNODE_OPS(ops) \
+	const struct fwnode_operations ops = {				\
+		.device_is_available = acpi_fwnode_device_is_available, \
+		.property_present = acpi_fwnode_property_present,	\
+		.property_read_int_array =				\
+			acpi_fwnode_property_read_int_array,		\
+		.property_read_string_array =				\
+			acpi_fwnode_property_read_string_array,		\
+		.get_parent = acpi_node_get_parent,			\
+		.get_next_child_node = acpi_get_next_subnode,		\
+		.get_named_child_node = acpi_fwnode_get_named_child_node, \
+		.graph_get_next_endpoint =				\
+			acpi_fwnode_graph_get_next_endpoint,		\
+		.graph_get_remote_endpoint =				\
+			acpi_fwnode_graph_get_remote_endpoint,		\
+		.graph_get_port_parent = acpi_node_get_parent,		\
+		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
+	};								\
+	EXPORT_SYMBOL_GPL(ops)
+
+DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
+DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
+const struct fwnode_operations acpi_static_fwnode_ops;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3389729..943536c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1467,8 +1467,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->device_type = type;
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
-	device->fwnode.type = FWNODE_ACPI;
-	device->fwnode.ops = &acpi_fwnode_ops;
+	device->fwnode.ops = &acpi_device_fwnode_ops;
 	acpi_set_device_status(device, sta);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index edf02c1..857e4d3 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -25,9 +25,11 @@ struct property_set {
 	const struct property_entry *properties;
 };
 
+static const struct fwnode_operations pset_fwnode_ops;
+
 static inline bool is_pset_node(struct fwnode_handle *fwnode)
 {
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_PDATA;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
 }
 
 static inline struct property_set *to_pset_node(struct fwnode_handle *fwnode)
@@ -900,7 +902,6 @@ int device_add_properties(struct device *dev,
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
-	p->fwnode.type = FWNODE_PDATA;
 	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
 	return 0;
diff --git a/drivers/of/property.c b/drivers/of/property.c
index eda50b4..2d59888 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -952,3 +952,4 @@ const struct fwnode_operations of_fwnode_ops = {
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
 };
+EXPORT_SYMBOL_GPL(of_fwnode_ops);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7569123..91b1e58 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -395,15 +395,21 @@ struct acpi_data_node {
 	struct completion kobj_done;
 };
 
+extern const struct fwnode_operations acpi_device_fwnode_ops;
+extern const struct fwnode_operations acpi_data_fwnode_ops;
+extern const struct fwnode_operations acpi_static_fwnode_ops;
+
 static inline bool is_acpi_node(struct fwnode_handle *fwnode)
 {
-	return !IS_ERR_OR_NULL(fwnode) && (fwnode->type == FWNODE_ACPI
-		|| fwnode->type == FWNODE_ACPI_DATA);
+	return !IS_ERR_OR_NULL(fwnode) &&
+		(fwnode->ops == &acpi_device_fwnode_ops
+		 || fwnode->ops == &acpi_data_fwnode_ops);
 }
 
 static inline bool is_acpi_device_node(struct fwnode_handle *fwnode)
 {
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI;
+	return !IS_ERR_OR_NULL(fwnode) &&
+		fwnode->ops == &acpi_device_fwnode_ops;
 }
 
 static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
@@ -414,7 +420,7 @@ static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwno
 
 static inline bool is_acpi_data_node(struct fwnode_handle *fwnode)
 {
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_ACPI_DATA;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &acpi_data_fwnode_ops;
 }
 
 static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
@@ -423,6 +429,12 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
 		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
 }
 
+static inline bool is_acpi_static_node(struct fwnode_handle *fwnode)
+{
+	return !IS_ERR_OR_NULL(fwnode) &&
+		fwnode->ops == &acpi_static_fwnode_ops;
+}
+
 static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
 					const char *name)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c749eef..71b763f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -57,9 +57,6 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
-
-extern const struct fwnode_operations acpi_fwnode_ops;
-
 static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 {
 	struct fwnode_handle *fwnode;
@@ -68,15 +65,14 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 	if (!fwnode)
 		return NULL;
 
-	fwnode->type = FWNODE_ACPI_STATIC;
-	fwnode->ops = &acpi_fwnode_ops;
+	fwnode->ops = &acpi_static_fwnode_ops;
 
 	return fwnode;
 }
 
 static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
 {
-	if (WARN_ON(!fwnode || fwnode->type != FWNODE_ACPI_STATIC))
+	if (WARN_ON(!is_acpi_static_node(fwnode)))
 		return;
 
 	kfree(fwnode);
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 50893a1..c5dbc48 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -14,20 +14,9 @@
 
 #include <linux/types.h>
 
-enum fwnode_type {
-	FWNODE_INVALID = 0,
-	FWNODE_OF,
-	FWNODE_ACPI,
-	FWNODE_ACPI_DATA,
-	FWNODE_ACPI_STATIC,
-	FWNODE_PDATA,
-	FWNODE_IRQCHIP
-};
-
 struct fwnode_operations;
 
 struct fwnode_handle {
-	enum fwnode_type type;
 	struct fwnode_handle *secondary;
 	const struct fwnode_operations *ops;
 };
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index cac77a5..d242738 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,9 +265,11 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 	return node ? &node->fwnode : NULL;
 }
 
+extern const struct fwnode_operations irqchip_fwnode_ops;
+
 static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
 {
-	return fwnode && fwnode->type == FWNODE_IRQCHIP;
+	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }
 
 extern void irq_domain_update_bus_token(struct irq_domain *domain,
diff --git a/include/linux/of.h b/include/linux/of.h
index 4a8a709..cfc3411 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -104,7 +104,6 @@ extern const struct fwnode_operations of_fwnode_ops;
 static inline void of_node_init(struct device_node *node)
 {
 	kobject_init(&node->kobj, &of_node_ktype);
-	node->fwnode.type = FWNODE_OF;
 	node->fwnode.ops = &of_fwnode_ops;
 }
 
@@ -152,7 +151,7 @@ void of_core_init(void);
 
 static inline bool is_of_node(const struct fwnode_handle *fwnode)
 {
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &of_fwnode_ops;
 }
 
 #define to_of_node(__fwnode)						\
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f1f2514..e064fd1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -41,6 +41,8 @@ static inline void debugfs_add_domain_dir(struct irq_domain *d) { }
 static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
 #endif
 
+const struct fwnode_operations irqchip_fwnode_ops;
+
 /**
  * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
  *                           identifying an irq domain
@@ -86,7 +88,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 	fwid->type = type;
 	fwid->name = n;
 	fwid->data = data;
-	fwid->fwnode.type = FWNODE_IRQCHIP;
+	fwid->fwnode.ops = &irqchip_fwnode_ops;
 	return &fwid->fwnode;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_alloc_fwnode);
@@ -193,10 +195,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	}
 
 	if (!domain->name) {
-		if (fwnode) {
-			pr_err("Invalid fwnode type (%d) for irqdomain\n",
-			       fwnode->type);
-		}
+		if (fwnode)
+			pr_err("Invalid fwnode type for irqdomain\n");
 		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
 					 atomic_inc_return(&unknown_domains));
 		if (!domain->name) {
-- 
2.7.4

