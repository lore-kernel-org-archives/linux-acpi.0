From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 2/2] of: Make of_fwnode_handle() safer
Date: Thu, 18 May 2017 13:42:43 +0300
Message-ID: <1495104163-17165-3-git-send-email-sakari.ailus@linux.intel.com>
References: <1495104163-17165-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:50996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752920AbdERKnv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 May 2017 06:43:51 -0400
In-Reply-To: <1495104163-17165-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com

On the expense of a little bit more complexity in the of_fwnode_handle()
macro, make the macro result in NULL in case its argument is NULL while
still referencing it only once.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/of.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50fcdb5..a7ccf34 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -159,7 +159,13 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
 		container_of(fwnode, struct device_node, fwnode) : NULL;
 }
 
-#define of_fwnode_handle(node) (&(node)->fwnode)
+#define of_fwnode_handle(node)						\
+	({								\
+		typeof(node) __of_fwnode_handle_node = node;		\
+									\
+		__of_fwnode_handle_node ?				\
+			&__of_fwnode_handle_node->fwnode : NULL;	\
+	})
 
 static inline bool of_have_populated_dt(void)
 {
-- 
2.7.4

