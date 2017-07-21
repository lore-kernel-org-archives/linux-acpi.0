From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 6/8] device property: Constify argument to pset fwnode backend
Date: Fri, 21 Jul 2017 14:39:35 +0300
Message-ID: <1500637177-16095-7-git-send-email-sakari.ailus@linux.intel.com>
References: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32662 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbdGULmM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 07:42:12 -0400
In-Reply-To: <1500637177-16095-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com, erik.veijola@intel.com, andriy.shevchenko@linux.intel.com

Internally constify pset fwnode backend. Do not touch the pset fwnode
operations yet.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 857e4d3..8fde824 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -27,19 +27,23 @@ struct property_set {
 
 static const struct fwnode_operations pset_fwnode_ops;
 
-static inline bool is_pset_node(struct fwnode_handle *fwnode)
+static inline bool is_pset_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
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
+		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
+									\
+		is_pset_node(__to_pset_node_fwnode) ?			\
+			container_of(__to_pset_node_fwnode,		\
+				     struct property_set, fwnode) :	\
+			NULL;						\
+	})
+
+static const struct property_entry *
+pset_prop_get(const struct property_set *pset, const char *name)
 {
 	const struct property_entry *prop;
 
@@ -53,7 +57,7 @@ static const struct property_entry *pset_prop_get(struct property_set *pset,
 	return NULL;
 }
 
-static const void *pset_prop_find(struct property_set *pset,
+static const void *pset_prop_find(const struct property_set *pset,
 				  const char *propname, size_t length)
 {
 	const struct property_entry *prop;
@@ -73,7 +77,7 @@ static const void *pset_prop_find(struct property_set *pset,
 	return pointer;
 }
 
-static int pset_prop_read_u8_array(struct property_set *pset,
+static int pset_prop_read_u8_array(const struct property_set *pset,
 				   const char *propname,
 				   u8 *values, size_t nval)
 {
@@ -88,7 +92,7 @@ static int pset_prop_read_u8_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u16_array(struct property_set *pset,
+static int pset_prop_read_u16_array(const struct property_set *pset,
 				    const char *propname,
 				    u16 *values, size_t nval)
 {
@@ -103,7 +107,7 @@ static int pset_prop_read_u16_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u32_array(struct property_set *pset,
+static int pset_prop_read_u32_array(const struct property_set *pset,
 				    const char *propname,
 				    u32 *values, size_t nval)
 {
@@ -118,7 +122,7 @@ static int pset_prop_read_u32_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_read_u64_array(struct property_set *pset,
+static int pset_prop_read_u64_array(const struct property_set *pset,
 				    const char *propname,
 				    u64 *values, size_t nval)
 {
@@ -133,7 +137,7 @@ static int pset_prop_read_u64_array(struct property_set *pset,
 	return 0;
 }
 
-static int pset_prop_count_elems_of_size(struct property_set *pset,
+static int pset_prop_count_elems_of_size(const struct property_set *pset,
 					 const char *propname, size_t length)
 {
 	const struct property_entry *prop;
@@ -145,7 +149,7 @@ static int pset_prop_count_elems_of_size(struct property_set *pset,
 	return prop->length / length;
 }
 
-static int pset_prop_read_string_array(struct property_set *pset,
+static int pset_prop_read_string_array(const struct property_set *pset,
 				       const char *propname,
 				       const char **strings, size_t nval)
 {
-- 
2.7.4

