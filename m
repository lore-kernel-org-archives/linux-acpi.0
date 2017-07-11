From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/1] device property: Introduce fwnode_call_bool_op() for ops that return bool
Date: Tue, 11 Jul 2017 18:20:20 +0300
Message-ID: <1499786420-25103-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31273 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755296AbdGKPWN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jul 2017 11:22:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org

fwnode_call_int_op() isn't suitable for calling ops that return bool since
it effectively causes the result returned to the user to be true when an
op hasn't been defined or the fwnode is NULL. Address this by introducing
fwnode_call_bool_op() for calling ops that return bool.

Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_available()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 6 +++---
 include/linux/fwnode.h  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 692007e..edf02c1 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -253,10 +253,10 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 {
 	bool ret;
 
-	ret = fwnode_call_int_op(fwnode, property_present, propname);
+	ret = fwnode_call_bool_op(fwnode, property_present, propname);
 	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
 	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(fwnode->secondary, property_present,
+		ret = fwnode_call_bool_op(fwnode->secondary, property_present,
 					 propname);
 	return ret;
 }
@@ -1027,7 +1027,7 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  */
 bool fwnode_device_is_available(struct fwnode_handle *fwnode)
 {
-	return fwnode_call_int_op(fwnode, device_is_available);
+	return fwnode_call_bool_op(fwnode, device_is_available);
 }
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9ab3754..50893a1 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -99,6 +99,10 @@ struct fwnode_operations {
 	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
 		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
 	 -EINVAL)
+#define fwnode_call_bool_op(fwnode, op, ...)				\
+	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
+		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : false) : \
+	 false)
 #define fwnode_call_ptr_op(fwnode, op, ...)		\
 	(fwnode_has_op(fwnode, op) ?			\
 	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : NULL)
-- 
2.7.4

