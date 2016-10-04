From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 08/15] of: Add of_fwnode_handle() to convert device nodes to fwnode_handle
Date: Wed,  5 Oct 2016 01:45:41 +0300
Message-ID: <1475621148-21427-9-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54632 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbcJDWr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:29 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

of_fwnode_handle() returns a struct fwnode_handle of the struct
device_node. This may be used on the fwnode property API.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/of.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 3d9ff8e..c9a7962 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -159,6 +159,11 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
 		container_of(fwnode, struct device_node, fwnode) : NULL;
 }
 
+static inline struct fwnode_handle *of_fwnode_handle(struct device_node *node)
+{
+	return &node->fwnode;
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return of_root != NULL;
@@ -481,6 +486,11 @@ static inline struct device_node *of_find_node_with_property(
 	return NULL;
 }
 
+static inline struct fwnode_handle *of_fwnode_handle(struct device_node *node)
+{
+	return NULL;
+}
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
2.7.4

