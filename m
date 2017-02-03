From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 1/4] device property: allow to constify properties
Date: Thu,  2 Feb 2017 17:41:25 -0800
Message-ID: <20170203014128.317-2-dmitry.torokhov@gmail.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35018 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdBCBlc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2017 20:41:32 -0500
In-Reply-To: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

There is no reason why statically defined properties should be modifiable,
so let's make device_add_properties() and the rest of pset_*() functions to
take const pointers to properties.

This will allow us to mark properties as const/__initconst at definition
sites.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 41 +++++++++++++++++++++--------------------
 include/linux/property.h |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 43a36d68c3fd..e9fa75645d69 100644
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
@@ -776,7 +776,7 @@ static int pset_copy_entry(struct property_entry *dst,
  */
 static struct property_set *pset_copy_set(const struct property_set *pset)
 {
-	const struct property_entry *entry;
+	struct property_entry *props;
 	struct property_set *p;
 	size_t i, n = 0;
 
@@ -787,14 +787,14 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 	while (pset->properties[n].name)
 		n++;
 
-	p->properties = kcalloc(n + 1, sizeof(*entry), GFP_KERNEL);
+	p->properties = props = kcalloc(n + 1, sizeof(*props), GFP_KERNEL);
 	if (!p->properties) {
 		kfree(p);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	for (i = 0; i < n; i++) {
-		int ret = pset_copy_entry(&p->properties[i],
+		int ret = pset_copy_entry(&props[i],
 					  &pset->properties[i]);
 		if (ret) {
 			pset_free_set(p);
@@ -847,7 +847,8 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
  * @dev as its secondary firmware node. The function takes a copy of
  * @properties.
  */
-int device_add_properties(struct device *dev, struct property_entry *properties)
+int device_add_properties(struct device *dev,
+			  const struct property_entry *properties)
 {
 	struct property_set *p, pset;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 856e50b2140c..d37a4498b3ac 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -242,7 +242,7 @@ struct property_entry {
 }
 
 int device_add_properties(struct device *dev,
-			  struct property_entry *properties);
+			  const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
 bool device_dma_supported(struct device *dev);
-- 
2.11.0.483.g087da7b7c-goog

