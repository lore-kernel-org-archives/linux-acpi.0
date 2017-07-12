From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] device property: Introduce fwnode_call_bool_op() for ops that return bool
Date: Wed, 12 Jul 2017 14:20:33 +0300
Message-ID: <1499858433-17655-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

fwnode_call_int_op() isn't suitable for calling ops that return bool since
it effectively causes the result returned to the user to be true when an
op hasn't been defined or the fwnode is NULL. Address this by introducing
fwnode_call_bool_op() for calling ops that return bool.

Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_available()")
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
since v1:

- Added missing Reported-by: tag.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
