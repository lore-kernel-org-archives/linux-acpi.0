From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 08/13] of: Add of_fwnode_handle() to convert device nodes to fwnode_handle
Date: Thu, 16 Mar 2017 14:31:16 +0200
Message-ID: <1489667481-28521-9-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:42134 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbdCPMcE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 08:32:04 -0400
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

of_fwnode_handle() returns a struct fwnode_handle of the struct
device_node. This may be used on the fwnode property API.

Use a macro instead of a function in order to support const and non-const
arguments.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/of.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 21e6323..e5d4225f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -159,6 +159,8 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
 		container_of(fwnode, struct device_node, fwnode) : NULL;
 }
 
+#define of_fwnode_handle(node) (&(node)->fwnode)
+
 static inline bool of_have_populated_dt(void)
 {
 	return of_root != NULL;
@@ -602,6 +604,8 @@ static inline struct device_node *of_find_node_with_property(
 	return NULL;
 }
 
+#define of_fwnode_handle(node) NULL
+
 static inline bool of_have_populated_dt(void)
 {
 	return false;
-- 
2.7.4

