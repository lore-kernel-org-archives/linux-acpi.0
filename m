From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 2/4] device property: allow to constify properties
Date: Wed,  1 Feb 2017 09:31:23 -0800
Message-ID: <20170201173125.40354-3-dmitry.torokhov@gmail.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

There is no reason why statically defined properties should be modifiable,
so let's make device_add_properties() and the rest of pset_*() functions to
take const pointers to properties.

This will allow us to mark properties as const/__initconst at definition
sites.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 35 ++++++++++++++++++-----------------
 include/linux/property.h |  2 +-
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 934845fc72e5..edc09854520b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -21,7 +21,7 @@
 
 struct property_set {
 	struct fwnode_handle fwnode;
-	struct property_entry *properties;
+	const struct property_entry *properties;
 };
 
 static inline bool is_pset_node(struct fwnode_handle *fwnode)
@@ -35,10 +35,10 @@ static inline struct property_set *to_pset_node(struct fwnode_handle *fwnode)
 		container_of(fwnode, struct property_set, fwnode) : NULL;
 }
 
-static struct property_entry *pset_prop_get(struct property_set *pset,
-					    const char *name)
+static const struct property_entry *pset_prop_get(struct property_set *pset,
+						  const char *name)
 {
-	struct property_entry *prop;
+	const struct property_entry *prop;
 
 	if (!pset || !pset->properties)
 		return NULL;
@@ -50,11 +50,11 @@ static struct property_entry *pset_prop_get(struct property_set *pset,
 	return NULL;
 }
 
-static void *pset_prop_find(struct property_set *pset, const char *propname,
-			    size_t length)
+static const void *pset_prop_find(struct property_set *pset,
+				  const char *propname, size_t length)
 {
-	struct property_entry *prop;
-	void *pointer;
+	const struct property_entry *prop;
+	const void *pointer;
 
 	prop = pset_prop_get(pset, propname);
 	if (!prop)
@@ -74,7 +74,7 @@ static int pset_prop_read_u8_array(struct property_set *pset,
 				   const char *propname,
 				   u8 *values, size_t nval)
 {
-	void *pointer;
+	const void *pointer;
 	size_t length = nval * sizeof(*values);
 
 	pointer = pset_prop_find(pset, propname, length);
@@ -89,7 +89,7 @@ static int pset_prop_read_u16_array(struct property_set *pset,
 				    const char *propname,
 				    u16 *values, size_t nval)
 {
-	void *pointer;
+	const void *pointer;
 	size_t length = nval * sizeof(*values);
 
 	pointer = pset_prop_find(pset, propname, length);
@@ -104,7 +104,7 @@ static int pset_prop_read_u32_array(struct property_set *pset,
 				    const char *propname,
 				    u32 *values, size_t nval)
 {
-	void *pointer;
+	const void *pointer;
 	size_t length = nval * sizeof(*values);
 
 	pointer = pset_prop_find(pset, propname, length);
@@ -119,7 +119,7 @@ static int pset_prop_read_u64_array(struct property_set *pset,
 				    const char *propname,
 				    u64 *values, size_t nval)
 {
-	void *pointer;
+	const void *pointer;
 	size_t length = nval * sizeof(*values);
 
 	pointer = pset_prop_find(pset, propname, length);
@@ -133,7 +133,7 @@ static int pset_prop_read_u64_array(struct property_set *pset,
 static int pset_prop_count_elems_of_size(struct property_set *pset,
 					 const char *propname, size_t length)
 {
-	struct property_entry *prop;
+	const struct property_entry *prop;
 
 	prop = pset_prop_get(pset, propname);
 	if (!prop)
@@ -146,7 +146,7 @@ static int pset_prop_read_string_array(struct property_set *pset,
 				       const char *propname,
 				       const char **strings, size_t nval)
 {
-	void *pointer;
+	const void *pointer;
 	size_t length = nval * sizeof(*strings);
 
 	pointer = pset_prop_find(pset, propname, length);
@@ -160,8 +160,8 @@ static int pset_prop_read_string_array(struct property_set *pset,
 static int pset_prop_read_string(struct property_set *pset,
 				 const char *propname, const char **strings)
 {
-	struct property_entry *prop;
-	const char **pointer;
+	const struct property_entry *prop;
+	const char * const *pointer;
 
 	prop = pset_prop_get(pset, propname);
 	if (!prop)
@@ -880,7 +880,8 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
  * @dev as its secondary firmware node. The function takes a copy of
  * @properties.
  */
-int device_add_properties(struct device *dev, struct property_entry *properties)
+int device_add_properties(struct device *dev,
+			  const struct property_entry *properties)
 {
 	struct property_set *p, pset;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 48f154ae7e99..5746e9927016 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -247,7 +247,7 @@ property_entries_dup(const struct property_entry *properties);
 void property_entries_free(const struct property_entry *properties);
 
 int device_add_properties(struct device *dev,
-			  struct property_entry *properties);
+			  const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
 bool device_dma_supported(struct device *dev);
-- 
2.11.0.483.g087da7b7c-goog
