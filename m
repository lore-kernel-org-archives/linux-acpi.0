From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v4 12/16] device property: Move dev_fwnode() to linux/property.h
Date: Mon,  6 Mar 2017 16:19:26 +0200
Message-ID: <1488809970-25568-13-git-send-email-sakari.ailus@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488809970-25568-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The function to obtain a fwnode related to a struct device is useful for
drivers that use the fwnode property API: it allows not being aware of the
underlying firmware implementation.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  |  6 ------
 include/linux/property.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 111049b..860e160 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -183,12 +183,6 @@ static int pset_prop_read_string(struct property_set *pset,
 	return 0;
 }
 
-static inline struct fwnode_handle *dev_fwnode(struct device *dev)
-{
-	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-		&dev->of_node->fwnode : dev->fwnode;
-}
-
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
diff --git a/include/linux/property.h b/include/linux/property.h
index 0ae7d20..0b61ea4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -13,11 +13,11 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/device.h>
 #include <linux/fwnode.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
-struct device;
-
 enum dev_prop_type {
 	DEV_PROP_U8,
 	DEV_PROP_U16,
@@ -33,6 +33,12 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
+static inline struct fwnode_handle *dev_fwnode(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
+		&dev->of_node->fwnode : dev->fwnode;
+}
+
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
 				  u8 *val, size_t nval);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
