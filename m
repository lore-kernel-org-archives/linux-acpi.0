From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v6 09/12] device property: Make dev_fwnode() public
Date: Tue, 28 Mar 2017 10:52:24 +0300
Message-ID: <1490687547-18311-10-git-send-email-sakari.ailus@linux.intel.com>
References: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:59867 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754620AbdC1HyS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Mar 2017 03:54:18 -0400
In-Reply-To: <1490687547-18311-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, rafael@kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com, frowand.list@gmail.com

The function to obtain a fwnode related to a struct device is useful for
drivers that use the fwnode property API: it allows not being aware of the
underlying firmware implementation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/property.c  | 3 ++-
 include/linux/property.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 23514bf6..22849a8 100644
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

