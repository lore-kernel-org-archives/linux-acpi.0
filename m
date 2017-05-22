From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 3/7] ACPI: Constify internal fwnode arguments
Date: Mon, 22 May 2017 12:07:38 +0300
Message-ID: <1495444062-23867-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23105 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757664AbdEVJJY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:09:24 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Constify internal ACPI fwnode arguments in preparation for the same in
fwnode API.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 37 ++++++++++++++++++++-----------------
 include/linux/acpi.h    | 40 ++++++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index bfa726c..7ae4ba3b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -19,7 +19,7 @@
 
 #include "internal.h"
 
-static int acpi_data_get_property_array(struct acpi_device_data *data,
+static int acpi_data_get_property_array(const struct acpi_device_data *data,
 					const char *name,
 					acpi_object_type type,
 					const union acpi_object **obj);
@@ -418,7 +418,7 @@ void acpi_free_properties(struct acpi_device *adev)
  *         %-EINVAL if the property doesn't exist,
  *         %-EPROTO if the property value type doesn't match @type.
  */
-static int acpi_data_get_property(struct acpi_device_data *data,
+static int acpi_data_get_property(const struct acpi_device_data *data,
 				  const char *name, acpi_object_type type,
 				  const union acpi_object **obj)
 {
@@ -460,20 +460,21 @@ static int acpi_data_get_property(struct acpi_device_data *data,
  * @type: Expected property type.
  * @obj: Location to store the property value (if not %NULL).
  */
-int acpi_dev_get_property(struct acpi_device *adev, const char *name,
+int acpi_dev_get_property(const struct acpi_device *adev, const char *name,
 			  acpi_object_type type, const union acpi_object **obj)
 {
 	return adev ? acpi_data_get_property(&adev->data, name, type, obj) : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_property);
 
-static struct acpi_device_data *acpi_device_data_of_node(struct fwnode_handle *fwnode)
+static const struct acpi_device_data *
+acpi_device_data_of_node(const struct fwnode_handle *fwnode)
 {
 	if (fwnode->type == FWNODE_ACPI) {
-		struct acpi_device *adev = to_acpi_device_node(fwnode);
+		const struct acpi_device *adev = to_acpi_device_node(fwnode);
 		return &adev->data;
 	} else if (fwnode->type == FWNODE_ACPI_DATA) {
-		struct acpi_data_node *dn = to_acpi_data_node(fwnode);
+		const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
 		return &dn->data;
 	}
 	return NULL;
@@ -485,8 +486,8 @@ static struct acpi_device_data *acpi_device_data_of_node(struct fwnode_handle *f
  * @propname: Name of the property.
  * @valptr: Location to store a pointer to the property value (if not %NULL).
  */
-int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
-		       void **valptr)
+int acpi_node_prop_get(const struct fwnode_handle *fwnode,
+		       const char *propname, void **valptr)
 {
 	return acpi_data_get_property(acpi_device_data_of_node(fwnode),
 				      propname, ACPI_TYPE_ANY,
@@ -512,7 +513,7 @@ int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
  *         %-EPROTO if the property is not a package or the type of its elements
  *           doesn't match @type.
  */
-static int acpi_data_get_property_array(struct acpi_device_data *data,
+static int acpi_data_get_property_array(const struct acpi_device_data *data,
 					const char *name,
 					acpi_object_type type,
 					const union acpi_object **obj)
@@ -572,13 +573,13 @@ static int acpi_data_get_property_array(struct acpi_device_data *data,
  *
  * Return: %0 on success, negative error code on failure.
  */
-int __acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 	const char *propname, size_t index, size_t num_args,
 	struct acpi_reference_args *args)
 {
 	const union acpi_object *element, *end;
 	const union acpi_object *obj;
-	struct acpi_device_data *data;
+	const struct acpi_device_data *data;
 	struct acpi_device *device;
 	int ret, idx = 0;
 
@@ -674,7 +675,7 @@ int __acpi_node_get_property_reference(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
 
-static int acpi_data_prop_read_single(struct acpi_device_data *data,
+static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				      const char *propname,
 				      enum dev_prop_type proptype, void *val)
 {
@@ -813,7 +814,7 @@ static int acpi_copy_property_array_string(const union acpi_object *items,
 	return nval;
 }
 
-static int acpi_data_prop_read(struct acpi_device_data *data,
+static int acpi_data_prop_read(const struct acpi_device_data *data,
 			       const char *propname,
 			       enum dev_prop_type proptype,
 			       void *val, size_t nval)
@@ -867,7 +868,7 @@ static int acpi_data_prop_read(struct acpi_device_data *data,
 	return ret;
 }
 
-int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
+int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval)
 {
 	return adev ? acpi_data_prop_read(&adev->data, propname, proptype, val, nval) : -EINVAL;
@@ -885,8 +886,9 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
  * of the property.  Otherwise, read at most @nval values to the array at the
  * location pointed to by @val.
  */
-int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
-		        enum dev_prop_type proptype, void *val, size_t nval)
+int acpi_node_prop_read(const struct fwnode_handle *fwnode,
+			const char *propname, enum dev_prop_type proptype,
+			void *val, size_t nval)
 {
 	return acpi_data_prop_read(acpi_device_data_of_node(fwnode),
 				   propname, proptype, val, nval);
@@ -1044,7 +1046,8 @@ struct fwnode_handle *acpi_graph_get_next_endpoint(struct fwnode_handle *fwnode,
  * the child node on success, NULL otherwise.
  */
 static struct fwnode_handle *acpi_graph_get_child_prop_value(
-	struct fwnode_handle *fwnode, const char *prop_name, unsigned int val)
+	struct fwnode_handle *fwnode, const char *prop_name,
+	unsigned int val)
 {
 	struct fwnode_handle *child;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b8f23c5..b06f31d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1000,13 +1000,14 @@ struct acpi_reference_args {
 };
 
 #ifdef CONFIG_ACPI
-int acpi_dev_get_property(struct acpi_device *adev, const char *name,
+int acpi_dev_get_property(const struct acpi_device *adev, const char *name,
 			  acpi_object_type type, const union acpi_object **obj);
-int __acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 				const char *name, size_t index, size_t num_args,
 				struct acpi_reference_args *args);
 
-static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+static inline int acpi_node_get_property_reference(
+				const struct fwnode_handle *fwnode,
 				const char *name, size_t index,
 				struct acpi_reference_args *args)
 {
@@ -1014,13 +1015,15 @@ static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
 		MAX_ACPI_REFERENCE_ARGS, args);
 }
 
-int acpi_node_prop_get(struct fwnode_handle *fwnode, const char *propname,
+int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
-int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
-			      enum dev_prop_type proptype, void *val);
-int acpi_node_prop_read(struct fwnode_handle *fwnode, const char *propname,
-		        enum dev_prop_type proptype, void *val, size_t nval);
-int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
+int acpi_dev_prop_read_single(struct acpi_device *adev,
+			      const char *propname, enum dev_prop_type proptype,
+			      void *val);
+int acpi_node_prop_read(const struct fwnode_handle *fwnode,
+			const char *propname, enum dev_prop_type proptype,
+			void *val, size_t nval);
+int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
 struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
@@ -1097,35 +1100,36 @@ static inline int acpi_dev_get_property(struct acpi_device *adev,
 }
 
 static inline int
-__acpi_node_get_property_reference(struct fwnode_handle *fwnode,
+__acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 				const char *name, size_t index, size_t num_args,
 				struct acpi_reference_args *args)
 {
 	return -ENXIO;
 }
 
-static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
-				const char *name, size_t index,
-				struct acpi_reference_args *args)
+static inline int
+acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
+				 const char *name, size_t index,
+				 struct acpi_reference_args *args)
 {
 	return -ENXIO;
 }
 
-static inline int acpi_node_prop_get(struct fwnode_handle *fwnode,
+static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 				     const char *propname,
 				     void **valptr)
 {
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_get(struct acpi_device *adev,
+static inline int acpi_dev_prop_get(const struct acpi_device *adev,
 				    const char *propname,
 				    void **valptr)
 {
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_read_single(struct acpi_device *adev,
+static inline int acpi_dev_prop_read_single(const struct acpi_device *adev,
 					    const char *propname,
 					    enum dev_prop_type proptype,
 					    void *val)
@@ -1133,7 +1137,7 @@ static inline int acpi_dev_prop_read_single(struct acpi_device *adev,
 	return -ENXIO;
 }
 
-static inline int acpi_node_prop_read(struct fwnode_handle *fwnode,
+static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
 				      const char *propname,
 				      enum dev_prop_type proptype,
 				      void *val, size_t nval)
@@ -1141,7 +1145,7 @@ static inline int acpi_node_prop_read(struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline int acpi_dev_prop_read(struct acpi_device *adev,
+static inline int acpi_dev_prop_read(const struct acpi_device *adev,
 				     const char *propname,
 				     enum dev_prop_type proptype,
 				     void *val, size_t nval)
-- 
2.7.4

