From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 3/4] driver property: constify property arrays values
Date: Tue, 31 Jan 2017 18:11:29 -0800
Message-ID: <20170201021130.20586-4-dmitry.torokhov@gmail.com>
References: <20170201021130.20586-1-dmitry.torokhov@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34169 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdBACLl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2017 21:11:41 -0500
In-Reply-To: <20170201021130.20586-1-dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

Data that is fed into property arrays should not be modified, so let's mark
relevant pointers as const. This will allow us making source arrays as
const/__initconst.

Also fix memory leaks on errors in property_entry_copy().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 65 +++++++++++++++++++++++++++++++++---------------
 include/linux/property.h | 12 ++++-----
 2 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index edc09854520b..fd91e0891665 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -682,44 +682,65 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_match_string);
 
+static int property_copy_string_array(struct property_entry *dst,
+				      const struct property_entry *src)
+{
+	char **d;
+	size_t nval = src->length / sizeof(*d);
+	size_t i;
+
+	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	for (i = 0; i < nval; i++) {
+		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
+		if (!d[i] && src->pointer.str[i]) {
+			while (--i >= 0)
+				kfree(d[i]);
+			return -ENOMEM;
+		}
+	}
+
+	dst->pointer.str = (void *)d;
+	return 0;
+}
+
 static int property_entry_copy(struct property_entry *dst,
 			       const struct property_entry *src)
 {
-	const char **d, **s;
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
-			dst->pointer.str = kcalloc(nval, sizeof(const char *),
-						   GFP_KERNEL);
-			if (!dst->pointer.str)
-				return -ENOMEM;
-
-			d = dst->pointer.str;
-			s = src->pointer.str;
-			for (i = 0; i < nval; i++) {
-				d[i] = kstrdup(s[i], GFP_KERNEL);
-				if (!d[i] && s[i])
-					return -ENOMEM;
+			error = property_copy_string_array(dst, src);
+			if (error) {
+				error = -ENOMEM;
+				goto out_free_name;
 			}
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
@@ -729,6 +750,10 @@ static int property_entry_copy(struct property_entry *dst,
 	dst->is_string = src->is_string;
 
 	return 0;
+
+out_free_name:
+	kfree(dst->name);
+	return error;
 }
 
 /**
diff --git a/include/linux/property.h b/include/linux/property.h
index 5746e9927016..64e3a9c6d95f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -160,12 +160,12 @@ struct property_entry {
 	bool is_string;
 	union {
 		union {
-			void *raw_data;
-			u8 *u8_data;
-			u16 *u16_data;
-			u32 *u32_data;
-			u64 *u64_data;
-			const char **str;
+			const void *raw_data;
+			const u8 *u8_data;
+			const u16 *u16_data;
+			const u32 *u32_data;
+			const u64 *u64_data;
+			const char * const *str;
 		} pointer;
 		union {
 			unsigned long long raw_data;
-- 
2.11.0.483.g087da7b7c-goog

