From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 03/17] device property: Introduce firmware property operations, set them
Date: Mon,  6 Mar 2017 17:42:49 +0200
Message-ID: <1488814983-25695-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1488814983-25695-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488814983-25695-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add ops field for the firmware operations to struct fwnode_handle. Set the
ops pointer based on firmware type in fwnode initialisation.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c | 3 +++
 drivers/acpi/scan.c     | 1 +
 drivers/base/property.c | 3 +++
 drivers/of/base.c       | 2 ++
 include/linux/acpi.h    | 4 ++++
 include/linux/fwnode.h  | 5 +++++
 include/linux/of.h      | 2 ++
 7 files changed, 20 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 6e776de..0651a74 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -57,6 +57,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 
 	dn->name = link->package.elements[0].string.pointer;
 	dn->fwnode.type = FWNODE_ACPI_DATA;
+	dn->fwnode.ops = &acpi_fwnode_ops;
 	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
@@ -1108,3 +1109,5 @@ int acpi_graph_get_remote_endpoint(struct fwnode_handle *fwnode,
 
 	return 0;
 }
+
+const struct fwnode_operations acpi_fwnode_ops;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..901720f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1441,6 +1441,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->handle = handle;
 	device->parent = acpi_bus_get_parent(handle);
 	device->fwnode.type = FWNODE_ACPI;
+	device->fwnode.ops = &acpi_fwnode_ops;
 	acpi_set_device_status(device, sta);
 	acpi_device_get_busid(device);
 	acpi_set_pnp_ids(handle, &device->pnp, type);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index defeba9..e4794bf 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -183,6 +183,8 @@ static int pset_prop_read_string(struct property_set *pset,
 	return 0;
 }
 
+static const struct fwnode_operations pset_fwnode_ops;
+
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
@@ -947,6 +949,7 @@ int device_add_properties(struct device *dev,
 		return PTR_ERR(p);
 
 	p->fwnode.type = FWNODE_PDATA;
+	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
 	return 0;
 }
diff --git a/drivers/of/base.c b/drivers/of/base.c
index d7c4629..b07af01 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2535,3 +2535,5 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 	return remote;
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
+
+const struct fwnode_operations of_fwnode_ops;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9d920c0..8035af8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -56,6 +56,9 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+
+extern const struct fwnode_operations acpi_fwnode_ops;
+
 static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 {
 	struct fwnode_handle *fwnode;
@@ -65,6 +68,7 @@ static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
 		return NULL;
 
 	fwnode->type = FWNODE_ACPI_STATIC;
+	fwnode->ops = &acpi_fwnode_ops;
 
 	return fwnode;
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 75e2a00..f1ceb43 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -12,6 +12,8 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
+#include <linux/types.h>
+
 enum fwnode_type {
 	FWNODE_INVALID = 0,
 	FWNODE_OF,
@@ -22,9 +24,12 @@ enum fwnode_type {
 	FWNODE_IRQCHIP
 };
 
+struct fwnode_operations;
+
 struct fwnode_handle {
 	enum fwnode_type type;
 	struct fwnode_handle *secondary;
+	const struct fwnode_operations *ops;
 };
 
 struct fwnode_endpoint {
diff --git a/include/linux/of.h b/include/linux/of.h
index c05fe25..652d2d4 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -100,10 +100,12 @@ struct of_reconfig_data {
 
 /* initialize a node */
 extern struct kobj_type of_node_ktype;
+extern const struct fwnode_operations of_fwnode_ops;
 static inline void of_node_init(struct device_node *node)
 {
 	kobject_init(&node->kobj, &of_node_ktype);
 	node->fwnode.type = FWNODE_OF;
+	node->fwnode.ops = &of_fwnode_ops;
 }
 
 /* true when node is initialized */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
