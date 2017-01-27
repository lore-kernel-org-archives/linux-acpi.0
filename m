From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 01/15] ACPI / property: Add possiblity to retrieve parent firmware node
Date: Fri, 27 Jan 2017 18:02:56 +0200
Message-ID: <1485532990-8431-2-git-send-email-sakari.ailus@linux.intel.com>
References: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5617 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754781AbdA0QL1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Jan 2017 11:11:27 -0500
In-Reply-To: <1485532990-8431-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

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
 drivers/acpi/property.c | 71 ++++++++++++++++++++++++++++++++++++++-----------
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  7 +++++
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3afddcd..65a0606 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -37,14 +37,16 @@ static const u8 ads_uuid[16] = {
 
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 					   const union acpi_object *desc,
-					   struct acpi_device_data *data);
+					   struct acpi_device_data *data,
+					   struct fwnode_handle *parent);
 static bool acpi_extract_properties(const union acpi_object *desc,
 				    struct acpi_device_data *data);
 
 static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 					acpi_handle handle,
 					const union acpi_object *link,
-					struct list_head *list)
+					struct list_head *list,
+					struct fwnode_handle *parent)
 {
 	struct acpi_data_node *dn;
 	bool result;
@@ -55,6 +57,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 
 	dn->name = link->package.elements[0].string.pointer;
 	dn->fwnode.type = FWNODE_ACPI_DATA;
+	dn->parent = parent;
 	INIT_LIST_HEAD(&dn->data.subnodes);
 
 	result = acpi_extract_properties(desc, &dn->data);
@@ -71,9 +74,11 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 		 */
 		status = acpi_get_parent(handle, &scope);
 		if (ACPI_SUCCESS(status)
-		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data))
+		    && acpi_enumerate_nondev_subnodes(scope, desc, &dn->data,
+						      &dn->fwnode))
 			result = true;
-	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data)) {
+	} else if (acpi_enumerate_nondev_subnodes(NULL, desc, &dn->data,
+						  &dn->fwnode)) {
 		result = true;
 	}
 
@@ -91,7 +96,8 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
 
 static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 					const union acpi_object *link,
-					struct list_head *list)
+					struct list_head *list,
+					struct fwnode_handle *parent)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	acpi_status status;
@@ -101,7 +107,7 @@ static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 	if (ACPI_FAILURE(status))
 		return false;
 
-	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list))
+	if (acpi_nondev_subnode_extract(buf.pointer, handle, link, list, parent))
 		return true;
 
 	ACPI_FREE(buf.pointer);
@@ -110,7 +116,8 @@ static bool acpi_nondev_subnode_data_ok(acpi_handle handle,
 
 static bool acpi_nondev_subnode_ok(acpi_handle scope,
 				   const union acpi_object *link,
-				   struct list_head *list)
+				   struct list_head *list,
+				   struct fwnode_handle *parent)
 {
 	acpi_handle handle;
 	acpi_status status;
@@ -123,12 +130,13 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
 	if (ACPI_FAILURE(status))
 		return false;
 
-	return acpi_nondev_subnode_data_ok(handle, link, list);
+	return acpi_nondev_subnode_data_ok(handle, link, list, parent);
 }
 
 static int acpi_add_nondev_subnodes(acpi_handle scope,
 				    const union acpi_object *links,
-				    struct list_head *list)
+				    struct list_head *list,
+				    struct fwnode_handle *parent)
 {
 	bool ret = false;
 	int i;
@@ -150,15 +158,18 @@ static int acpi_add_nondev_subnodes(acpi_handle scope,
 		/* The second one may be a string, a reference or a package. */
 		switch (link->package.elements[1].type) {
 		case ACPI_TYPE_STRING:
-			result = acpi_nondev_subnode_ok(scope, link, list);
+			result = acpi_nondev_subnode_ok(scope, link, list,
+							 parent);
 			break;
 		case ACPI_TYPE_LOCAL_REFERENCE:
 			handle = link->package.elements[1].reference.handle;
-			result = acpi_nondev_subnode_data_ok(handle, link, list);
+			result = acpi_nondev_subnode_data_ok(handle, link, list,
+							     parent);
 			break;
 		case ACPI_TYPE_PACKAGE:
 			desc = &link->package.elements[1];
-			result = acpi_nondev_subnode_extract(desc, NULL, link, list);
+			result = acpi_nondev_subnode_extract(desc, NULL, link, list,
+							     parent);
 			break;
 		default:
 			result = false;
@@ -172,7 +183,8 @@ static int acpi_add_nondev_subnodes(acpi_handle scope,
 
 static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 					   const union acpi_object *desc,
-					   struct acpi_device_data *data)
+					   struct acpi_device_data *data,
+					   struct fwnode_handle *parent)
 {
 	int i;
 
@@ -194,7 +206,8 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
 		if (memcmp(uuid->buffer.pointer, ads_uuid, sizeof(ads_uuid)))
 			continue;
 
-		return acpi_add_nondev_subnodes(scope, links, &data->subnodes);
+		return acpi_add_nondev_subnodes(scope, links, &data->subnodes,
+						parent);
 	}
 
 	return false;
@@ -345,7 +358,8 @@ void acpi_init_properties(struct acpi_device *adev)
 		if (acpi_of)
 			acpi_init_of_compatible(adev);
 	}
-	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer, &adev->data))
+	if (acpi_enumerate_nondev_subnodes(adev->handle, buf.pointer,
+					&adev->data, acpi_fwnode_handle(adev)))
 		adev->data.pointer = buf.pointer;
 
 	if (!adev->data.pointer) {
@@ -920,3 +934,30 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
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
index 4242c31..81129e2 100644
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
index 5b36974..868f923 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1001,6 +1001,7 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 
 struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 					    struct fwnode_handle *subnode);
+struct fwnode_handle *acpi_node_get_parent(struct fwnode_handle *fwnode);
 
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
@@ -1123,6 +1124,12 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
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

