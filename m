From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 01/15] ACPI / property: Add possiblity to retrieve parent firmware node
Date: Wed,  5 Oct 2016 01:45:34 +0300
Message-ID: <1475621148-21427-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16959 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbcJDWr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:28 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Sometimes it is useful to be able to navigate firmware node hierarchy
upwards toward parent nodes. ACPI device nodes are pretty much already
supported because ACPICA provides acpi_get_parent(). ACPI data nodes,
however, are all below the same parent ACPI device. Their hierarchy is
created by "linking" each other using references in the value field.

Add parent pointer to the parent data node while we create them so it is
easy to navigate the hierarchy backwards. We use this parent pointer in a
new function acpi_node_get_parent() that is able to extract parent of both
ACPI firmware node types.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c | 52 +++++++++++++++++++++++++++++++++++++++++--------
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  7 +++++++
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f2fd3fe..181e4c5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -37,13 +37,16 @@ static const u8 ads_uuid[16] = {
 
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 					   const union acpi_object *desc,
-					   struct acpi_device_data *data);
+					   struct acpi_device_data *data,
+					   struct fwnode_handle *parent);
 static bool acpi_extract_properties(const union acpi_object *desc,
 				    struct acpi_device_data *data);
 
+
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
 				   const union acpi_object *link,
-				   struct list_head *list)
+				   struct list_head *list,
+				   struct fwnode_handle *parent)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	struct acpi_data_node *dn;
@@ -56,6 +59,7 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 
 	dn->name = link->package.elements[0].string.pointer;
 	dn->fwnode.type = FWNODE_ACPI_DATA;
+	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
 	status = acpi_get_handle(scope, link->package.elements[1].string.pointer,
@@ -78,7 +82,8 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	 */
 	status = acpi_get_parent(handle, &scope);
 	if (ACPI_SUCCESS(status)
-	    && acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
+	    && acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data,
+					      &dn->fwnode))
 		dn->handle = handle;
 
 	if (dn->handle) {
@@ -97,7 +102,8 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 
 static int acpi_add_nondev_subnodes(acpi_handle scope,
 				    const union acpi_object *links,
-				    struct list_head *list)
+				    struct list_head *list,
+				    struct fwnode_handle *parent)
 {
 	bool ret = false;
 	int i;
@@ -110,7 +116,7 @@ static int acpi_add_nondev_subnodes(acpi_handle scope,
 		if (link->package.count == 2
 		    && link->package.elements[0].type == ACPI_TYPE_STRING
 		    && link->package.elements[1].type == ACPI_TYPE_STRING
-		    && acpi_nondev_subnode_ok(scope, link, list))
+		    && acpi_nondev_subnode_ok(scope, link, list, parent))
 			ret = true;
 	}
 
@@ -119,7 +125,8 @@ static int acpi_add_nondev_subnodes(acpi_handle scope,
 
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 					   const union acpi_object *desc,
-					   struct acpi_device_data *data)
+					   struct acpi_device_data *data,
+					   struct fwnode_handle *parent)
 {
 	int i;
 
@@ -141,7 +148,8 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 		if (memcmp(uuid->buffer.pointer, ads_uuid, sizeof(ads_uuid)))
 			continue;
 
-		return acpi_add_nondev_subnodes(scope, links, &data->subnodes);
+		return acpi_add_nondev_subnodes(scope, links, &data->subnodes,
+						parent);
 	}
 
 	return false;
@@ -292,7 +300,8 @@ void acpi_init_properties(struct acpi_device *adev)
 		if (acpi_of)
 			acpi_init_of_compatible(adev);
 	}
-	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer, &adev->data))
+	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer,
+					&adev->data, acpi_fwnode_handle(adev)))
 		adev->data.pointer = buf.pointer;
 
 	if (!adev->data.pointer) {
@@ -848,3 +857,30 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 	}
 	return NULL;
 }
+
+/**
+ * acpi_node_get_parent - Return parent fwnode of this fwnode
+ * @fwnode: Firmware node whose parent to get
+ *
+ * Returns parent node of an ACPI device or data firmware node or %NULL if
+ * not available.
+ */
+struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode)
+{
+	if (is_acpi_data_node(fwnode)) {
+		/* All data nodes have parent pointer so just return that */
+		return to_acpi_data_node(fwnode)->parent;
+	} else if (is_acpi_device_node(fwnode)) {
+		acpi_handle handle, parent_handle;
+
+		handle = to_acpi_device_node(fwnode)->handle;
+		if (ACPI_SUCCESS(acpi_get_parent(handle, &parent_handle))) {
+			struct acpi_device *adev;
+
+			if (!acpi_bus_get_device(parent_handle, &adev))
+				return acpi_fwnode_handle(adev);
+		}
+	}
+
+	return NULL;
+}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c1a524d..8504716 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -386,6 +386,7 @@ struct acpi_data_node {
 	const char *name;
 	acpi_handle handle;
 	struct fwnode_handle fwnode;
+	struct fwnode_handle *parent;
 	struct acpi_device_data data;
 	struct list_head sibling;
 	struct kobject kobj;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 19e650c..6906f7a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -961,6 +961,7 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 
 struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 					    struct fwnode_handle *subnode);
+struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode);
 
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
@@ -1075,6 +1076,12 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 	return NULL;
 }
 
+static inline struct fwnode_handle *
+acpi_node_get_parent(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn) \
 	static const void * __acpi_table_##name[]			\
 		__attribute__((unused))					\
-- 
2.7.4

