From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 2/4] device property: constify property arrays values
Date: Thu,  2 Feb 2017 17:41:26 -0800
Message-ID: <20170203014128.317-3-dmitry.torokhov@gmail.com>
References: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203014128.317-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-acpi@vger.kernel.org

Data that is fed into property arrays should not be modified, so let's mark
relevant pointers as const. This will allow us making source arrays as
const/__initconst.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  | 10 +++++-----
 include/linux/property.h | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e9fa75645d69..31b942a29fdc 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -718,7 +718,8 @@ static void pset_free_set(struct property_set *pset)
 static int pset_copy_entry(struct property_entry *dst,
 			   const struct property_entry *src)
 {
-	const char **d, **s;
+	const char * const *s;
+	char **d;
 	size_t i, nval;
 
 	dst->name = kstrdup(src->name, GFP_KERNEL);
@@ -731,12 +732,11 @@ static int pset_copy_entry(struct property_entry *dst,
 
 		if (src->is_string) {
 			nval = src->length / sizeof(const char *);
-			dst->pointer.str = kcalloc(nval, sizeof(const char *),
-						   GFP_KERNEL);
-			if (!dst->pointer.str)
+			d = kcalloc(nval, sizeof(const char *), GFP_KERNEL);
+			if (!d)
 				return -ENOMEM;
 
-			d = dst->pointer.str;
+			dst->pointer.raw_data = d;
 			s = src->pointer.str;
 			for (i = 0; i < nval; i++) {
 				d[i] = kstrdup(s[i], GFP_KERNEL);
diff --git a/include/linux/property.h b/include/linux/property.h
index d37a4498b3ac..7a0a1cce5165 100644
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
