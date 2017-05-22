From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 4/7] device property: Constify argument to pset fwnode backend
Date: Mon, 22 May 2017 12:07:39 +0300
Message-ID: <1495444062-23867-5-git-send-email-sakari.ailus@linux.intel.com>
References: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:16662 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757571AbdEVJK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 May 2017 05:10:57 -0400
In-Reply-To: <1495444062-23867-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

Internally constify pset fwnode backend. Do not touch the pset fwnode
operations yet.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b311a6f..e0c9489 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -25,19 +25,22 @@ struct property_set {
 	const struct property_entry *properties;
 };
 
-static inline bool is_pset_node(struct fwnode_handle *fwnode)
+static inline bool is_pset_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_PDATA;
 }
 
-static inline struct property_set *to_pset_node(struct fwnode_handle *fwnode)
-{
-	return is_pset_node(fwnode) ?
-		container_of(fwnode, struct property_set, fwnode) : NULL;
-}
-
-static const struct property_entry *pset_prop_get(struct property_set *pset,
-						  const char *name)
+#define to_pset_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) fwnode = __fwnode;			\
+									\
+		is_pset_node(fwnode) ?					\
+			container_of(fwnode, struct property_set, fwnode) : \
+			NULL;						\
+	})
+
+static const struct property_entry *
+pset_prop_get(const struct property_set *pset, const char *name)
 {
 	const struct property_entry *prop;
 
@@ -51,7 +54,7 @@ static const struct property_entry *pset_prop_get(struct property_set *pset,
 	return NULL;
 }
 
-static const void *pset_prop_find(struct property_set *pset,
+static const void *pset_prop_find(const struct property_set *pset,
 				  const char *propname, size_t length)
 {
 	const struct property_entry *prop;
@@ -71,7 +74,7 @@ static const void *pset_prop_find(struct property_set *pset,
 	return pointer;
 }
 
-static int pset_prop_read_u8_array(struct property_set *pset,
+static int pset_prop_read_u8_array(const struct property_set *pset,
 				   const char *propname,
 				   u8 *values, size_t nval)
 {
@@ -86,7 +89,7 @@ static int pset_prop_read_u8_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u16_array(struct property_set *pset,
+static int pset_prop_read_u16_array(const struct property_set *pset,
 				    const char *propname,
 				    u16 *values, size_t nval)
 {
@@ -101,7 +104,7 @@ static int pset_prop_read_u16_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u32_array(struct property_set *pset,
+static int pset_prop_read_u32_array(const struct property_set *pset,
 				    const char *propname,
 				    u32 *values, size_t nval)
 {
@@ -116,7 +119,7 @@ static int pset_prop_read_u32_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u64_array(struct property_set *pset,
+static int pset_prop_read_u64_array(const struct property_set *pset,
 				    const char *propname,
 				    u64 *values, size_t nval)
 {
@@ -131,7 +134,7 @@ static int pset_prop_read_u64_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_count_elems_of_size(struct property_set *pset,
+static int pset_prop_count_elems_of_size(const struct property_set *pset,
 					 const char *propname, size_t length)
 {
 	const struct property_entry *prop;
@@ -143,7 +146,7 @@ static int pset_prop_count_elems_of_size(struct property_set *pset,
 	return prop->length / length;
 }
 
-static int pset_prop_read_string_array(struct property_set *pset,
+static int pset_prop_read_string_array(const struct property_set *pset,
 				       const char *propname,
 				       const char **strings, size_t nval)
 {
@@ -217,8 +220,8 @@ static int pset_fwnode_read_int_array(
 }
 
 static int pset_fwnode_property_read_string_array(
-	struct fwnode_handle *fwnode, const char *propname, const char **val,
-	size_t nval)
+	struct fwnode_handle *fwnode, const char *propname,
+	const char **val, size_t nval)
 {
 	return pset_prop_read_string_array(to_pset_node(fwnode), propname,
 					   val, nval);
-- 
2.7.4

