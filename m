From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 11/15] device property: Obtain device's fwnode independently of FW type
Date: Wed,  5 Oct 2016 01:45:44 +0300
Message-ID: <1475621148-21427-12-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11570 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753480AbcJDWra (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:30 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

OF uses struct device's of_node field (of type struct device_node) to
refer to the device's OF properties. ACPI employs the fwnode field
instead. The latter is of type fwnode_handle, which is also embedded in
struct device_node.

The struct fwnode_handle pointer in both cases can be used as an argument
for the device property API which is firmware agnostic. Also make
obtaining the firmware node independent of the type of the firmware.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/property.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 305a065..b1c5365c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -13,7 +13,9 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/device.h>
 #include <linux/fwnode.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
 struct device;
@@ -274,4 +276,12 @@ fwnode_graph_get_remote_port(struct fwnode_handle *fwnode);
 struct fwnode_handle *
 fwnode_graph_get_remote_endpoint(struct fwnode_handle *fwnode);
 
+static inline struct fwnode_handle *device_fwnode_handle(struct device *dev)
+{
+	if (dev->of_node)
+		return of_fwnode_handle(dev->of_node);
+	else
+		return dev->fwnode;
+}
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.7.4

