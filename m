From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 09/10] device: property: add fwnode_driver_match_device()
Date: Wed,  1 Jul 2015 08:48:02 +0200
Message-ID: <1435733283-19244-10-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35723 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbGAGsd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:33 -0400
Received: by wgjx7 with SMTP id x7so27775077wgj.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:32 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.31
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:31 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

So buses can match drivers to devices without having to care about what
firmware is used to describe the device.

The introduction of this function will also allow us to introduce
matching behavior common to the different type of firmwares.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/property.c  | 18 ++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9c8be31..8528eb9 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/property.h>
 
 /**
@@ -594,3 +595,20 @@ bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible)
 	return false;
 }
 EXPORT_SYMBOL_GPL(fwnode_is_compatible);
+
+/**
+ * fwnode_driver_match_device - Tell if a driver matches a device.
+ * @drv: the device_driver structure to test
+ * @dev: the device structure to match against
+ */
+bool fwnode_driver_match_device(struct device *dev,
+				const struct device_driver *drv)
+{
+	if (is_of_node(dev->fwnode))
+		return of_driver_match_device(dev, drv);
+	else if (is_acpi_node(dev->fwnode))
+		return acpi_driver_match_device(dev, drv);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(fwnode_driver_match_device);
diff --git a/include/linux/property.h b/include/linux/property.h
index bf10074..4e453c4 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 struct device;
+struct device_driver;
 
 enum dev_prop_type {
 	DEV_PROP_U8,
@@ -82,6 +83,9 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 bool fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compatible);
 
+bool fwnode_driver_match_device(struct device *dev,
+				const struct device_driver *drv);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.4.1

