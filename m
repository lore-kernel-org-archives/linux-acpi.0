From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RESEND PATCH v4 3/3] of: Support const and non-const use for to_of_node()
Date: Thu, 18 May 2017 14:12:39 +0300
Message-ID: <1495105959-20146-1-git-send-email-sakari.ailus@linux.intel.com>
References: <1495104163-17165-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:3017 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934241AbdERLN4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 May 2017 07:13:56 -0400
In-Reply-To: <1495104163-17165-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com

Turn to_of_node() into a macro in order to support both const and
non-const use. Additionally make the fwnode argument to is_of_node() const
as well.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
This was actually in another set, but fits better here.

(Now with correct In-Reply-To header.)

 include/linux/of.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index a7ccf34..03dbc94 100644
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
+		typeof(__fwnode) __to_of_node_fwnode = __fwnode;	\
+									\
+		is_of_node(__to_of_node_fwnode) ?			\
+			container_of(__to_of_node_fwnode,		\
+				     struct device_node, fwnode) :	\
+			NULL;						\
+	})
 
 #define of_fwnode_handle(node)						\
 	({								\
-- 
2.7.4

