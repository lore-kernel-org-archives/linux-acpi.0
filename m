From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 3/3] of: Support const and non-const use for to_of_node()
Date: Wed, 24 May 2017 17:53:55 +0300
Message-ID: <1495637635-26057-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15644 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937237AbdEXOzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 10:55:09 -0400
In-Reply-To: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, kieran.bingham@ideasonboard.com

Turn to_of_node() into a macro in order to support both const and
non-const use. Additionally make the fwnode argument to is_of_node() const
as well.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 include/linux/of.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index f05c87f..29b7b738b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -148,16 +148,20 @@ extern raw_spinlock_t devtree_lock;
 #ifdef CONFIG_OF
 void of_core_init(void);
 
-static inline bool is_of_node(struct fwnode_handle *fwnode)
+static inline bool is_of_node(const struct fwnode_handle *fwnode)
 {
 	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
 }
 
-static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
-{
-	return is_of_node(fwnode) ?
-		container_of(fwnode, struct device_node, fwnode) : NULL;
-}
+#define to_of_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) __to_of_node_fwnode = (__fwnode);	\
+									\
+		is_of_node(__to_of_node_fwnode) ?			\
+			container_of(__to_of_node_fwnode,		\
+				     struct device_node, fwnode) :	\
+			NULL;						\
+	})
 
 #define of_fwnode_handle(node)						\
 	({								\
@@ -539,12 +543,12 @@ static inline void of_core_init(void)
 {
 }
 
-static inline bool is_of_node(struct fwnode_handle *fwnode)
+static inline bool is_of_node(const struct fwnode_handle *fwnode)
 {
 	return false;
 }
 
-static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
+static inline struct device_node *to_of_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
-- 
2.7.4

