From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 2/3] of: Make of_fwnode_handle() safer
Date: Wed, 24 May 2017 17:53:54 +0300
Message-ID: <1495637635-26057-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15644 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935545AbdEXOzI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 10:55:08 -0400
In-Reply-To: <1495637635-26057-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com, kieran.bingham@ideasonboard.com

On the expense of a little bit more complexity in the of_fwnode_handle()
macro, make the macro result in NULL in case its argument is NULL while
still referencing it only once.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 include/linux/of.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50fcdb5..f05c87f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -159,7 +159,13 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
 		container_of(fwnode, struct device_node, fwnode) : NULL;
 }
 
-#define of_fwnode_handle(node) (&(node)->fwnode)
+#define of_fwnode_handle(node)						\
+	({								\
+		typeof(node) __of_fwnode_handle_node = (node);		\
+									\
+		__of_fwnode_handle_node ?				\
+			&__of_fwnode_handle_node->fwnode : NULL;	\
+	})
 
 static inline bool of_have_populated_dt(void)
 {
-- 
2.7.4

