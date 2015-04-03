From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] device property: Introduce firmware node type for platform data
Date: Fri, 03 Apr 2015 16:05:11 +0200
Message-ID: <3619014.N4Tg0UgJKE@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <1594911.7FXIhSfjIv@vostro.rjw.lan> <1845472.ky0kR6YsnQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51424 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751753AbbDCNlS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2015 09:41:18 -0400
In-Reply-To: <1845472.ky0kR6YsnQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce data structures and code allowing "built-in" properties
to be associated with devices in such a way that they will be used
by the device_property_* API if no proper firmware node (neither DT
nor ACPI) is present for the given device.

Each property is to be represented by a property_entry structure.
An array of property_entry structures (terminated with a null
entry) can be pointed to by the properties field of struct
property_set that can be added as a firmware node to a struct
device using device_add_property_set().  That will cause the
device_property_* API to use that property_set as the source
of properties if the given device does not have a DT node or
an ACPI companion device object associated with it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Greg, any objections?

---
 drivers/base/property.c  |   98 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/fwnode.h   |    1 
 include/linux/property.h |   33 +++++++++++++++
 3 files changed, 127 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/fwnode.h
===================================================================
--- linux-pm.orig/include/linux/fwnode.h
+++ linux-pm/include/linux/fwnode.h
@@ -16,6 +16,7 @@ enum fwnode_type {
 	FWNODE_INVALID = 0,
 	FWNODE_OF,
 	FWNODE_ACPI,
+	FWNODE_PDATA,
 };
 
 struct fwnode_handle {
Index: linux-pm/include/linux/property.h
===================================================================
--- linux-pm.orig/include/linux/property.h
+++ linux-pm/include/linux/property.h
@@ -131,4 +131,37 @@ static inline int fwnode_property_read_u
 	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
 }
 
+/**
+ * struct property_entry - "Built-in" device property representation.
+ * @name: Name of the property.
+ * @type: Type of the property.
+ * @nval: Number of items of type @type making up the value.
+ * @value: Value of the property (an array of @nval items of type @type).
+ */
+struct property_entry {
+	const char *name;
+	enum dev_prop_type type;
+	size_t nval;
+	union {
+		void *raw_data;
+		u8 *u8_data;
+		u16 *u16_data;
+		u32 *u32_data;
+		u64 *u64_data;
+		const char **str;
+	} value;
+};
+
+/**
+ * struct property_set - Collection of "built-in" device properties.
+ * @fwnode: Handle to be pointed to by the fwnode field of struct device.
+ * @properties: Array of properties terminated with a null entry.
+ */
+struct property_set {
+	struct fwnode_handle fwnode;
+	struct property_entry *properties;
+};
+
+void device_add_property_set(struct device *dev, struct property_set *pset);
+
 #endif /* _LINUX_PROPERTY_H_ */
Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -10,10 +10,96 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/property.h>
-#include <linux/export.h>
 #include <linux/acpi.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/property.h>
+
+/**
+ * device_add_property_set - Add a collection of properties to a device object.
+ * @dev: Device to add properties to.
+ * @pset: Collection of properties to add.
+ *
+ * Associate a collection of device properties represented by @pset with @dev
+ * as its secondary firmware node.
+ */
+void device_add_property_set(struct device *dev, struct property_set *pset)
+{
+	if (pset)
+		pset->fwnode.type = FWNODE_PDATA;
+
+	set_secondary_fwnode(dev, &pset->fwnode);
+}
+EXPORT_SYMBOL_GPL(device_add_property_set);
+
+static inline bool is_pset(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_PDATA;
+}
+
+static inline struct property_set *to_pset(struct fwnode_handle *fwnode)
+{
+	return is_pset(fwnode) ?
+		container_of(fwnode, struct property_set, fwnode) : NULL;
+}
+
+static struct property_entry *pset_prop_get(struct property_set *pset,
+					    const char *name)
+{
+	struct property_entry *prop;
+
+	if (!pset || !pset->properties)
+		return NULL;
+
+	for (prop = pset->properties; prop->name; prop++)
+		if (!strcmp(name, prop->name))
+			return prop;
+
+	return NULL;
+}
+
+static int pset_prop_read_array(struct property_set *pset, const char *name,
+				enum dev_prop_type type, void *val, size_t nval)
+{
+	struct property_entry *prop;
+	unsigned int item_size;
+
+	prop = pset_prop_get(pset, name);
+	if (!prop)
+		return -ENODATA;
+
+	if (prop->type != type)
+		return -EPROTO;
+
+	if (!val)
+		return prop->nval;
+
+	if (prop->nval < nval)
+		return -EOVERFLOW;
+
+	switch (type) {
+	case DEV_PROP_U8:
+		item_size = sizeof(u8);
+		break;
+	case DEV_PROP_U16:
+		item_size = sizeof(u16);
+		break;
+	case DEV_PROP_U32:
+		item_size = sizeof(u32);
+		break;
+	case DEV_PROP_U64:
+		item_size = sizeof(u64);
+		break;
+	case DEV_PROP_STRING:
+		item_size = sizeof(const char *);
+		break;
+	default:
+		return -EINVAL;
+	}
+	memcpy(val, prop->value.raw_data, nval * item_size);
+	return 0;
+}
 
 static inline struct fwnode_handle *dev_fwnode(struct device *dev)
 {
@@ -46,7 +132,7 @@ bool fwnode_property_present(struct fwno
 	else if (is_acpi_node(fwnode))
 		return !acpi_dev_prop_get(acpi_node(fwnode), propname, NULL);
 
-	return false;
+	return !!pset_prop_get(to_pset(fwnode), propname);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -205,7 +291,8 @@ EXPORT_SYMBOL_GPL(device_property_read_s
 		_ret_ = acpi_dev_prop_read(acpi_node(_fwnode_), _propname_, \
 					   _proptype_, _val_, _nval_); \
 	else \
-		_ret_ = -ENXIO; \
+		_ret_ = pset_prop_read_array(to_pset(_fwnode_), _propname_, \
+					     _proptype_, _val_, _nval_); \
 	_ret_; \
 })
 
@@ -344,7 +431,8 @@ int fwnode_property_read_string_array(st
 		return acpi_dev_prop_read(acpi_node(fwnode), propname,
 					  DEV_PROP_STRING, val, nval);
 
-	return -ENXIO;
+	return pset_prop_read_array(to_pset(fwnode), propname,
+				    DEV_PROP_STRING, val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 

