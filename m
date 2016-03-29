From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v2] device property: don't bother the drivers with struct property_set
Date: Tue, 29 Mar 2016 11:07:20 +0300
Message-ID: <1459238840-14776-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 arch/arm/mach-pxa/raumfeld.c      |  8 ++------
 arch/arm/mach-tegra/board-paz00.c |  6 +-----
 drivers/base/platform.c           | 19 ++++++++++---------
 drivers/base/property.c           | 34 +++++++++++++++++++++-------------
 drivers/mfd/intel-lpss-acpi.c     | 12 ++----------
 drivers/mfd/intel-lpss-pci.c      | 20 ++++----------------
 drivers/mfd/intel-lpss.c          |  2 +-
 drivers/mfd/intel-lpss.h          |  4 ++--
 drivers/mfd/mfd-core.c            |  4 ++--
 include/linux/mfd/core.h          |  4 ++--
 include/linux/platform_device.h   |  6 +++---
 include/linux/property.h          | 15 +++------------
 12 files changed, 53 insertions(+), 81 deletions(-)

Hi,

Changes since v1:
- Added the new users of the property framework


diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 5a941bd..5f628fc 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -385,10 +385,6 @@ static struct property_entry raumfeld_rotary_properties[] = {
 	{ },
 };
 
-static struct property_set raumfeld_rotary_property_set = {
-	.properties = raumfeld_rotary_properties,
-};
-
 static struct platform_device rotary_encoder_device = {
 	.name		= "rotary-encoder",
 	.id		= 0,
@@ -1064,7 +1060,7 @@ static void __init __maybe_unused raumfeld_controller_init(void)
 
 	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
 	device_add_property_set(&rotary_encoder_device.dev,
-				&raumfeld_rotary_property_set);
+				raumfeld_rotary_properties);
 	platform_device_register(&rotary_encoder_device);
 
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
@@ -1104,7 +1100,7 @@ static void __init __maybe_unused raumfeld_speaker_init(void)
 
 	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
 	device_add_property_set(&rotary_encoder_device.dev,
-				&raumfeld_rotary_property_set);
+				raumfeld_rotary_properties);
 	platform_device_register(&rotary_encoder_device);
 
 	raumfeld_audio_init();
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
index 9b1a65d..210423d 100644
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
@@ -801,14 +806,14 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
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
 
@@ -831,24 +836,27 @@ void device_remove_property_set(struct device *dev)
 		}
 	}
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
+int device_add_properties(struct device *dev, struct property_entry *properties)
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
 
@@ -856,7 +864,7 @@ int device_add_property_set(struct device *dev, const struct property_set *pset)
 	set_secondary_fwnode(dev, &p->fwnode);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(device_add_property_set);
+EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
  * device_get_next_child_node - Return the next child node handle for a device
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 5a8d9c7..7ddc4a9 100644
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
@@ -51,13 +47,9 @@ static struct property_entry bxt_i2c_properties[] = {
 	{ },
 };
 
-static struct property_set bxt_i2c_pset = {
-	.properties = bxt_i2c_properties,
-};
-
 static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.clk_rate = 133000000,
-	.pset = &bxt_i2c_pset,
+	.properties = bxt_i2c_properties,
 };
 
 static const struct acpi_device_id intel_lpss_acpi_ids[] = {
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index a19e571..1d79a3c 100644
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
 
 static struct property_entry bxt_i2c_properties[] = {
@@ -114,13 +106,9 @@ static struct property_entry bxt_i2c_properties[] = {
 	{ },
 };
 
-static struct property_set bxt_i2c_pset = {
-	.properties = bxt_i2c_properties,
-};
-
 static const struct intel_lpss_platform_info bxt_i2c_info = {
 	.clk_rate = 133000000,
-	.pset = &bxt_i2c_pset,
+	.properties = bxt_i2c_properties,
 };
 
 static const struct pci_device_id intel_lpss_pci_ids[] = {
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 85ad9ec..d9353c7 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -409,7 +409,7 @@ int intel_lpss_probe(struct device *dev,
 	if (ret)
 		return ret;
 
-	lpss->cell->pset = info->pset;
+	lpss->cell->properties = info->properties;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 0dcea9e..6941166 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -16,14 +16,14 @@
 
 struct device;
 struct resource;
-struct property_set;
+struct property_entry;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
 	int irq;
 	unsigned long clk_rate;
 	const char *clk_con_id;
-	struct property_set *pset;
+	struct property_entry *properties;
 };
 
 int intel_lpss_probe(struct device *dev,
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 409da01..86bc01d 100644
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
index bc6f7e0..9837f1e 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 
 struct irq_domain;
-struct property_set;
+struct property_entry;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
 struct mfd_cell_acpi_match {
@@ -47,7 +47,7 @@ struct mfd_cell {
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-	const struct property_set *pset;
+	struct property_entry *properties;
 
 	/*
 	 * Device Tree compatible string
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 03b7555..98c2a7c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -18,7 +18,7 @@
 #define PLATFORM_DEVID_AUTO	(-2)
 
 struct mfd_cell;
-struct property_set;
+struct property_entry;
 
 struct platform_device {
 	const char	*name;
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
2.8.0.rc3
