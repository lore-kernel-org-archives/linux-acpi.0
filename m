From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 1/4] device property: export code duplicating array of property entries
Date: Wed,  1 Feb 2017 09:31:22 -0800
Message-ID: <20170201173125.40354-2-dmitry.torokhov@gmail.com>
References: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201173125.40354-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

When augmenting ACPI-enumerated devices with additional property data based
on DMI info, a module has often several potential property sets, with only
one being active on a given box. In order to save memory it should be
possible to mark everything and __initdata or __initconst, execute DMI
match early, and duplicate relevant properties. Then kernel will discard
the rest of them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 137 +++++++++++++++++++++++++++++------------------
 include/linux/property.h |   5 ++
 2 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 43a36d68c3fd..934845fc72e5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -682,41 +682,8 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
 
-/**
- * pset_free_set - releases memory allocated for copied property set
- * @pset: Property set to release
- *
- * Function takes previously copied property set and releases all the
- * memory allocated to it.
- */
-static void pset_free_set(struct property_set *pset)
-{
-	const struct property_entry *prop;
-	size_t i, nval;
-
-	if (!pset)
-		return;
-
-	for (prop = pset->properties; prop->name; prop++) {
-		if (prop->is_array) {
-			if (prop->is_string && prop->pointer.str) {
-				nval = prop->length / sizeof(const char *);
-				for (i = 0; i < nval; i++)
-					kfree(prop->pointer.str[i]);
-			}
-			kfree(prop->pointer.raw_data);
-		} else if (prop->is_string) {
-			kfree(prop->value.str);
-		}
-		kfree(prop->name);
-	}
-
-	kfree(pset->properties);
-	kfree(pset);
-}
-
-static int pset_copy_entry(struct property_entry *dst,
-			   const struct property_entry *src)
+static int property_entry_copy(struct property_entry *dst,
+			       const struct property_entry *src)
 {
 	const char **d, **s;
 	size_t i, nval;
@@ -765,6 +732,84 @@ static int pset_copy_entry(struct property_entry *dst,
 }
 
 /**
+ * property_entries_dup - duplicate array of properties
+ * @properties: array of properties to copy
+ *
+ * This function creates a deep copy of the given NULL-terminated array
+ * of property entries.
+ */
+struct property_entry *
+property_entries_dup(const struct property_entry *properties)
+{
+	struct property_entry *p;
+	int i, n = 0;
+
+	while (properties[n].name)
+		n++;
+
+	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < n; i++) {
+		int ret = property_entry_copy(&p[i], &properties[i]);
+		if (ret) {
+			kfree(p);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(property_entries_dup);
+
+/**
+ * property_entries_free - free previously allocated array of properties
+ * @properties: array of properties to destroy
+ *
+ * This function frees given NULL-terminated array of property entries,
+ * along with their data.
+ */
+void property_entries_free(const struct property_entry *properties)
+{
+	const struct property_entry *p;
+	size_t i, nval;
+
+	for (p = properties; p->name; p++) {
+		if (p->is_array) {
+			if (p->is_string && p->pointer.str) {
+				nval = p->length / sizeof(const char *);
+				for (i = 0; i < nval; i++)
+					kfree(p->pointer.str[i]);
+			}
+			kfree(p->pointer.raw_data);
+		} else if (p->is_string) {
+			kfree(p->value.str);
+		}
+		kfree(p->name);
+	}
+
+	kfree(properties);
+}
+EXPORT_SYMBOL_GPL(property_entries_free);
+
+/**
+ * pset_free_set - releases memory allocated for copied property set
+ * @pset: Property set to release
+ *
+ * Function takes previously copied property set and releases all the
+ * memory allocated to it.
+ */
+static void pset_free_set(struct property_set *pset)
+{
+	if (!pset)
+		return;
+
+	property_entries_free(pset->properties);
+	kfree(pset);
+}
+
+/**
  * pset_copy_set - copies property set
  * @pset: Property set to copy
  *
@@ -776,32 +821,20 @@ static int pset_copy_entry(struct property_entry *dst,
  */
 static struct property_set *pset_copy_set(const struct property_set *pset)
 {
-	const struct property_entry *entry;
+	struct property_entry *properties;
 	struct property_set *p;
-	size_t i, n = 0;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-	while (pset->properties[n].name)
-		n++;
-
-	p->properties = kcalloc(n + 1, sizeof(*entry), GFP_KERNEL);
-	if (!p->properties) {
+	properties = property_entries_dup(pset->properties);
+	if (IS_ERR(properties)) {
 		kfree(p);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	for (i = 0; i < n; i++) {
-		int ret = pset_copy_entry(&p->properties[i],
-					  &pset->properties[i]);
-		if (ret) {
-			pset_free_set(p);
-			return ERR_PTR(ret);
-		}
+		return ERR_CAST(properties);
 	}
 
+	p->properties = properties;
 	return p;
 }
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 856e50b2140c..48f154ae7e99 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -241,6 +241,11 @@ struct property_entry {
 	.name = _name_,				\
 }
 
+struct property_entry *
+property_entries_dup(const struct property_entry *properties);
+
+void property_entries_free(const struct property_entry *properties);
+
 int device_add_properties(struct device *dev,
 			  struct property_entry *properties);
 void device_remove_properties(struct device *dev);
-- 
2.11.0.483.g087da7b7c-goog
