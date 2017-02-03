From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 3/4] device property: export code duplicating array of property entries
Date: Thu,  2 Feb 2017 17:41:27 -0800
Message-ID: <20170203014128.317-4-dmitry.torokhov@gmail.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33533 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdBCBle (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2017 20:41:34 -0500
In-Reply-To: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

When augmenting ACPI-enumerated devices with additional property data based
on DMI info, a module has often several potential property sets, with only
one being active on a given box. In order to save memory it should be
possible to mark everything and __initdata or __initconst, execute DMI
match early, and duplicate relevant properties. Then kernel will discard
the rest of them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 194 +++++++++++++++++++++++++++++++----------------
 include/linux/property.h |   5 ++
 2 files changed, 134 insertions(+), 65 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 31b942a29fdc..c458c63e353f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -682,77 +682,64 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
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
+static int property_copy_string_array(struct property_entry *dst,
+				      const struct property_entry *src)
 {
-	const struct property_entry *prop;
-	size_t i, nval;
+	char **d;
+	size_t nval = src->length / sizeof(*d);
+	int i;
 
-	if (!pset)
-		return;
+	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
 
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
+	for (i = 0; i < nval; i++) {
+		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
+		if (!d[i] && src->pointer.str[i]) {
+			while (--i >= 0)
+				kfree(d[i]);
+			kfree(d);
+			return -ENOMEM;
 		}
-		kfree(prop->name);
 	}
 
-	kfree(pset->properties);
-	kfree(pset);
+	dst->pointer.raw_data = d;
+	return 0;
 }
 
-static int pset_copy_entry(struct property_entry *dst,
-			   const struct property_entry *src)
+static int property_entry_copy_data(struct property_entry *dst,
+				    const struct property_entry *src)
 {
-	const char * const *s;
-	char **d;
-	size_t i, nval;
+	int error;
 
 	dst->name = kstrdup(src->name, GFP_KERNEL);
 	if (!dst->name)
 		return -ENOMEM;
 
 	if (src->is_array) {
-		if (!src->length)
-			return -ENODATA;
+		if (!src->length) {
+			error = -ENODATA;
+			goto out_free_name;
+		}
 
 		if (src->is_string) {
-			nval = src->length / sizeof(const char *);
-			d = kcalloc(nval, sizeof(const char *), GFP_KERNEL);
-			if (!d)
-				return -ENOMEM;
-
-			dst->pointer.raw_data = d;
-			s = src->pointer.str;
-			for (i = 0; i < nval; i++) {
-				d[i] = kstrdup(s[i], GFP_KERNEL);
-				if (!d[i] && s[i])
-					return -ENOMEM;
-			}
+			error = property_copy_string_array(dst, src);
+			if (error)
+				goto out_free_name;
 		} else {
 			dst->pointer.raw_data = kmemdup(src->pointer.raw_data,
 							src->length, GFP_KERNEL);
-			if (!dst->pointer.raw_data)
-				return -ENOMEM;
+			if (!dst->pointer.raw_data) {
+				error = -ENOMEM;
+				goto out_free_name;
+			}
 		}
 	} else if (src->is_string) {
 		dst->value.str = kstrdup(src->value.str, GFP_KERNEL);
-		if (!dst->value.str && src->value.str)
-			return -ENOMEM;
+		if (!dst->value.str && src->value.str) {
+			error = -ENOMEM;
+			goto out_free_name;
+		}
 	} else {
 		dst->value.raw_data = src->value.raw_data;
 	}
@@ -762,6 +749,95 @@ static int pset_copy_entry(struct property_entry *dst,
 	dst->is_string = src->is_string;
 
 	return 0;
+
+out_free_name:
+	kfree(dst->name);
+	return error;
+}
+
+static void property_entry_free_data(const struct property_entry *p)
+{
+	size_t i, nval;
+
+	if (p->is_array) {
+		if (p->is_string && p->pointer.str) {
+			nval = p->length / sizeof(const char *);
+			for (i = 0; i < nval; i++)
+				kfree(p->pointer.str[i]);
+		}
+		kfree(p->pointer.raw_data);
+	} else if (p->is_string) {
+		kfree(p->value.str);
+	}
+	kfree(p->name);
+}
+
+/**
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
+		int ret = property_entry_copy_data(&p[i], &properties[i]);
+		if (ret) {
+			while (--i >= 0)
+				property_entry_free_data(&p[i]);
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
+
+	for (p = properties; p->name; p++)
+		property_entry_free_data(p);
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
 }
 
 /**
@@ -776,32 +852,20 @@ static int pset_copy_entry(struct property_entry *dst,
  */
 static struct property_set *pset_copy_set(const struct property_set *pset)
 {
-	struct property_entry *props;
+	struct property_entry *properties;
 	struct property_set *p;
-	size_t i, n = 0;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-	while (pset->properties[n].name)
-		n++;
-
-	p->properties = props = kcalloc(n + 1, sizeof(*props), GFP_KERNEL);
-	if (!p->properties) {
+	properties = property_entries_dup(pset->properties);
+	if (IS_ERR(properties)) {
 		kfree(p);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	for (i = 0; i < n; i++) {
-		int ret = pset_copy_entry(&props[i],
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
index 7a0a1cce5165..64e3a9c6d95f 100644
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
 			  const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
-- 
2.11.0.483.g087da7b7c-goog

