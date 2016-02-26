From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] device property: don't bother the drivers with struct property_set
Date: Fri, 26 Feb 2016 13:20:00 +0200
Message-ID: <1456485600-129229-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65117 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcBZLUE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 26 Feb 2016 06:20:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Since device_add_property_set() now always takes a copy of
the property_set, and also since the fwnode type is always
hard coded to be FWNODE_PDATA, there is no need for the
drivers to deliver the entire struct property_set. The
function can just create the instance of it on its own and
bind the properties from the drivers to it on the spot.

This renames device_add_property_set() to
device_add_properties(). The function now takes struct
property_entry as its parameter instead of struct
property_set.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 arch/arm/mach-tegra/board-paz00.c |  6 +-----
 drivers/base/platform.c           | 19 ++++++++++---------
 drivers/base/property.c           | 35 ++++++++++++++++++++++-------------
 drivers/mfd/intel-lpss-acpi.c     |  6 +-----
 drivers/mfd/intel-lpss-pci.c      | 14 +++-----------
 drivers/mfd/intel-lpss.c          |  2 +-
 drivers/mfd/intel-lpss.h          |  2 +-
 drivers/mfd/mfd-core.c            |  4 ++--
 include/linux/mfd/core.h          |  2 +-
 include/linux/platform_device.h   |  4 ++--
 include/linux/property.h          | 15 +++------------
 11 files changed, 47 insertions(+), 62 deletions(-)

Hi Rafael,

This depends on Johannes' wireless next tree:
git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git


diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 52db8bf..7478f6f 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -29,10 +29,6 @@ static struct property_entry __initdata wifi_rfkill_prop[] = {
 	{ },
 };
 
-static struct property_set __initdata wifi_rfkill_pset = {
-	.properties = wifi_rfkill_prop,
-};
-
 static struct platform_device wifi_rfkill_device = {
 	.name	= "rfkill_gpio",
 	.id	= -1,
@@ -49,7 +45,7 @@ static struct gpiod_lookup_table wifi_gpio_lookup = {
 
 void __init tegra_paz00_wifikill_init(void)
 {
-	platform_device_add_properties(&wifi_rfkill_device, &wifi_rfkill_pset);
+	platform_device_add_properties(&wifi_rfkill_device, wifi_rfkill_prop);
 	gpiod_add_lookup_table(&wifi_gpio_lookup);
 	platform_device_register(&wifi_rfkill_device);
 }
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f437afa..6482d47 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -322,16 +322,16 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
 /**
  * platform_device_add_properties - add built-in properties to a platform device
  * @pdev: platform device to add properties to
- * @pset: properties to add
+ * @properties: null terminated array of properties to add
  *
- * The function will take deep copy of the properties in @pset and attach
- * the copy to the platform device. The memory associated with properties
- * will be freed when the platform device is released.
+ * The function will take deep copy of @properties and attach the copy to the
+ * platform device. The memory associated with properties will be freed when the
+ * platform device is released.
  */
 int platform_device_add_properties(struct platform_device *pdev,
-				   const struct property_set *pset)
+				   struct property_entry *properties)
 {
-	return device_add_property_set(&pdev->dev, pset);
+	return device_add_properties(&pdev->dev, properties);
 }
 EXPORT_SYMBOL_GPL(platform_device_add_properties);
 
@@ -447,7 +447,7 @@ void platform_device_del(struct platform_device *pdev)
 				release_resource(r);
 		}
 
-		device_remove_property_set(&pdev->dev);
+		device_remove_properties(&pdev->dev);
 	}
 }
 EXPORT_SYMBOL_GPL(platform_device_del);
@@ -526,8 +526,9 @@ struct platform_device *platform_device_register_full(
 	if (ret)
 		goto err;
 
-	if (pdevinfo->pset) {
-		ret = platform_device_add_properties(pdev, pdevinfo->pset);
+	if (pdevinfo->properties) {
+		ret = platform_device_add_properties(pdev,
+						     pdevinfo->properties);
 		if (ret)
 			goto err;
 	}
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 167f0a9..8442033 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -19,6 +19,11 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 
+struct property_set {
+	struct fwnode_handle fwnode;
+	struct property_entry *properties;
+};
+
 static inline bool is_pset_node(struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->type == FWNODE_PDATA;
@@ -797,14 +802,14 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 }
 
 /**
- * device_remove_property_set - Remove properties from a device object.
+ * device_remove_properties - Remove properties from a device object.
  * @dev: Device whose properties to remove.
  *
  * The function removes properties previously associated to the device
- * secondary firmware node with device_add_property_set(). Memory allocated
+ * secondary firmware node with device_add_properties(). Memory allocated
  * to the properties will also be released.
  */
-void device_remove_property_set(struct device *dev)
+void device_remove_properties(struct device *dev)
 {
 	struct fwnode_handle *fwnode;
 
@@ -822,24 +827,28 @@ void device_remove_property_set(struct device *dev)
 		pset_free_set(to_pset_node(fwnode));
 	set_secondary_fwnode(dev, NULL);
 }
-EXPORT_SYMBOL_GPL(device_remove_property_set);
+EXPORT_SYMBOL_GPL(device_remove_properties);
 
 /**
- * device_add_property_set - Add a collection of properties to a device object.
+ * device_add_properties - Add a collection of properties to a device object.
  * @dev: Device to add properties to.
- * @pset: Collection of properties to add.
+ * @properties: Collection of properties to add.
  *
- * Associate a collection of device properties represented by @pset with @dev
- * as its secondary firmware node. The function takes a copy of @pset.
+ * Associate a collection of device properties represented by @properties with
+ * @dev as its secondary firmware node. The function takes a copy of
+ * @properties.
  */
-int device_add_property_set(struct device *dev, const struct property_set *pset)
+int device_add_properties(struct device *dev,
+			  struct property_entry *properties)
 {
-	struct property_set *p;
+	struct property_set *p, pset;
 
-	if (!pset)
+	if (!properties)
 		return -EINVAL;
 
-	p = pset_copy_set(pset);
+	pset.properties = properties;
+
+	p = pset_copy_set(&pset);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
@@ -847,7 +856,7 @@ int device_add_property_set(struct device *dev, const struct property_set *pset)
 	set_secondary_fwnode(dev, &p->fwnode);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(device_add_property_set);
+EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
  * device_get_next_child_node - Return the next child node handle for a device
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 06f00d6..8e94ad2 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -31,13 +31,9 @@ static struct property_entry spt_i2c_properties[] = {
 	{ },
 };
 
-static struct property_set spt_i2c_pset = {
-	.properties = spt_i2c_properties,
-};
-
 static const struct intel_lpss_platform_info spt_i2c_info = {
 	.clk_rate = 120000000,
-	.pset = &spt_i2c_pset,
+	.properties = spt_i2c_properties,
 };
 
 static const struct intel_lpss_platform_info bxt_info = {
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index afc7af9..5855cce 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -71,13 +71,9 @@ static struct property_entry spt_i2c_properties[] = {
 	{ },
 };
 
-static struct property_set spt_i2c_pset = {
-	.properties = spt_i2c_properties,
-};
-
 static const struct intel_lpss_platform_info spt_i2c_info = {
 	.clk_rate = 120000000,
-	.pset = &spt_i2c_pset,
+	.properties = spt_i2c_properties,
 };
 
 static struct property_entry uart_properties[] = {
@@ -87,14 +83,10 @@ static struct property_entry uart_properties[] = {
 	{ },
 };
 
-static struct property_set uart_pset = {
-	.properties = uart_properties,
-};
-
 static const struct intel_lpss_platform_info spt_uart_info = {
 	.clk_rate = 120000000,
 	.clk_con_id = "baudclk",
-	.pset = &uart_pset,
+	.properties = uart_properties,
 };
 
 static const struct intel_lpss_platform_info bxt_info = {
@@ -104,7 +96,7 @@ static const struct intel_lpss_platform_info bxt_info = {
 static const struct intel_lpss_platform_info bxt_uart_info = {
 	.clk_rate = 100000000,
 	.clk_con_id = "baudclk",
-	.pset = &uart_pset,
+	.properties = uart_properties,
 };
 
 static const struct intel_lpss_platform_info bxt_i2c_info = {
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 1bbbe87..6352aab 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -407,7 +407,7 @@ int intel_lpss_probe(struct device *dev,
 	if (ret)
 		return ret;
 
-	lpss->cell->pset = info->pset;
+	lpss->cell->properties = info->properties;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 0dcea9e..d064973 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -23,7 +23,7 @@ struct intel_lpss_platform_info {
 	int irq;
 	unsigned long clk_rate;
 	const char *clk_con_id;
-	struct property_set *pset;
+	struct property_entry *properties;
 };
 
 int intel_lpss_probe(struct device *dev,
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 88bd1b1..fc1c1fc 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -193,8 +193,8 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
-	if (cell->pset) {
-		ret = platform_device_add_properties(pdev, cell->pset);
+	if (cell->properties) {
+		ret = platform_device_add_properties(pdev, cell->properties);
 		if (ret)
 			goto fail_alias;
 	}
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 1a5a87f..ba9d79f 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -73,7 +73,7 @@ struct mfd_cell {
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-	const struct property_set *pset;
+	struct property_entry *properties;
 
 	/*
 	 * Device Tree compatible string
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 03b7555..66dca60 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -73,7 +73,7 @@ struct platform_device_info {
 		size_t size_data;
 		u64 dma_mask;
 
-		const struct property_set *pset;
+		struct property_entry *properties;
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
@@ -172,7 +172,7 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
 extern int platform_device_add_properties(struct platform_device *pdev,
-					  const struct property_set *pset);
+					  struct property_entry *properties);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
diff --git a/include/linux/property.h b/include/linux/property.h
index b51fcd3..ecab11e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -238,18 +238,9 @@ struct property_entry {
 	.name = _name_,				\
 }
 
-/**
- * struct property_set - Collection of "built-in" device properties.
- * @fwnode: Handle to be pointed to by the fwnode field of struct device.
- * @properties: Array of properties terminated with a null entry.
- */
-struct property_set {
-	struct fwnode_handle fwnode;
-	struct property_entry *properties;
-};
-
-int device_add_property_set(struct device *dev, const struct property_set *pset);
-void device_remove_property_set(struct device *dev);
+int device_add_properties(struct device *dev,
+			  struct property_entry *properties);
+void device_remove_properties(struct device *dev);
 
 bool device_dma_supported(struct device *dev);
 
-- 
2.7.0

