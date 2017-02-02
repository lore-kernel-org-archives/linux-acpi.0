From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 07/16] device property: Add fwnode_handle_get()
Date: Thu,  2 Feb 2017 18:22:17 +0200
Message-ID: <1486052546-19257-8-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

fwnode_handle_get() is used to obtain a reference to a fwnode_handle
container. In this case this is OF specific struct device_node.

This complements fwnode_handle_put() which is already implemented.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  | 11 +++++++++++
 include/linux/property.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 63a30dc..760c6c5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -976,6 +976,17 @@ struct fwnode_handle *device_get_named_child_node(struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_named_child_node);
 
 /**
+ * fwnode_handle_get - Obtain a reference to a device node
+ * @fwnode: Pointer to the device node to obtain the reference to.
+ */
+void fwnode_handle_get(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		of_node_get(to_of_node(fwnode));
+}
+EXPORT_SYMBOL_GPL(fwnode_handle_get);
+
+/**
  * fwnode_handle_put - Drop reference to a device node
  * @fwnode: Pointer to the device node to drop the reference to.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 86c47ad..b4b1545 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -90,6 +90,7 @@ struct fwnode_handle *fwnode_get_named_child_node(struct fwnode_handle *fwnode,
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
+void fwnode_handle_get(struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 unsigned int device_get_child_node_count(struct device *dev);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
