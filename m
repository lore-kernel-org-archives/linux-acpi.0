From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 08/12] of: Add of_fwnode_handle() to convert device nodes to fwnode_handle
Date: Tue, 28 Mar 2017 10:52:23 +0300
Message-ID: <1490687547-18311-9-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31538 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754660AbdC1Hxc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:53:32 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

of_fwnode_handle() returns a struct fwnode_handle of the struct
device_node. This may be used on the fwnode property API.

Use a macro instead of a function in order to support const and non-const
arguments.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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

