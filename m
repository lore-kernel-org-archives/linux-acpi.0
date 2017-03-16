From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 09/13] device property: Make dev_fwnode() public
Date: Thu, 16 Mar 2017 14:31:17 +0200
Message-ID: <1489667481-28521-10-git-send-email-sakari.ailus@linux.intel.com>
References: <1489667481-28521-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489667481-28521-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The function to obtain a fwnode related to a struct device is useful for
drivers that use the fwnode property API: it allows not being aware of the
underlying firmware implementation.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/property.c  | 3 ++-
 include/linux/property.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6a8d8ae..4c7956e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -183,11 +183,12 @@ static int pset_prop_read_string(struct property_set *pset,
 	return 0;
 }
 
-static inline struct fwnode_handle *dev_fwnode(struct device *dev)
+struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		&dev->of_node->fwnode : dev->fwnode;
 }
+EXPORT_SYMBOL_GPL(dev_fwnode);
 
 /**
  * device_property_present - check if a property of a device is present
diff --git a/include/linux/property.h b/include/linux/property.h
index 0ae7d20..6e20a12 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -33,6 +33,8 @@ enum dev_dma_attr {
 	DEV_DMA_COHERENT,
 };
 
+struct fwnode_handle *dev_fwnode(struct device *dev);
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
