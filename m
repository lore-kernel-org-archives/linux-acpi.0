From: Jiang Qiu <qiujiang@huawei.com>
Subject: [PATCH v9 2/3] gpio: dwapb: convert device node to fwnode
Date: Wed, 20 Apr 2016 15:13:48 +0800
Message-ID: <1461136429-85114-3-git-send-email-qiujiang@huawei.com>
References: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1461136429-85114-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, delicious.quinoa@gmail.com, jamie@jamieiles.com, charles.chenxin@huawei.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Jiang Qiu <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patch converts device node to fwnode for dwapb driver, so
as to provide a unified fwnode for DT and ACPI bindings.

Tested-by: Alan Tull <delicious.quinoa@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jiang Qiu <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c                | 37 ++++++++++++++++----------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 772d743..92bc204 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -22,6 +22,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/slab.h>
@@ -290,14 +291,14 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 				 struct dwapb_port_property *pp)
 {
 	struct gpio_chip *gc = &port->gc;
-	struct device_node *node = pp->node;
+	struct fwnode_handle  *fwnode = pp->fwnode;
 	struct irq_chip_generic	*irq_gc = NULL;
 	unsigned int hwirq, ngpio = gc->ngpio;
 	struct irq_chip_type *ct;
 	int err, i;
 
-	gpio->domain = irq_domain_add_linear(node, ngpio,
-					     &irq_generic_chip_ops, gpio);
+	gpio->domain = irq_domain_create_linear(fwnode, ngpio,
+						 &irq_generic_chip_ops, gpio);
 	if (!gpio->domain)
 		return;
 
@@ -415,7 +416,8 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	}
 
 #ifdef CONFIG_OF_GPIO
-	port->gc.of_node = pp->node;
+	port->gc.of_node = is_of_node(pp->fwnode) ?
+		to_of_node(pp->fwnode) : NULL;
 #endif
 	port->gc.ngpio = pp->ngpio;
 	port->gc.base = pp->gpio_base;
@@ -447,19 +449,15 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 }
 
 static struct dwapb_platform_data *
-dwapb_gpio_get_pdata_of(struct device *dev)
+dwapb_gpio_get_pdata(struct device *dev)
 {
-	struct device_node *node, *port_np;
+	struct fwnode_handle *fwnode;
 	struct dwapb_platform_data *pdata;
 	struct dwapb_port_property *pp;
 	int nports;
 	int i;
 
-	node = dev->of_node;
-	if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
-		return ERR_PTR(-ENODEV);
-
-	nports = of_get_child_count(node);
+	nports = device_get_child_node_count(dev);
 	if (nports == 0)
 		return ERR_PTR(-ENODEV);
 
@@ -474,18 +472,18 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 	pdata->nports = nports;
 
 	i = 0;
-	for_each_child_of_node(node, port_np) {
+	device_for_each_child_node(dev, fwnode)  {
 		pp = &pdata->properties[i++];
-		pp->node = port_np;
+		pp->fwnode = fwnode;
 
-		if (of_property_read_u32(port_np, "reg", &pp->idx) ||
+		if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||
 		    pp->idx >= DWAPB_MAX_PORTS) {
 			dev_err(dev,
 				"missing/invalid port index for port%d\n", i);
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (of_property_read_u32(port_np, "snps,nr-gpios",
+		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
 					 &pp->ngpio)) {
 			dev_info(dev,
 				 "failed to get number of gpios for port%d\n",
@@ -497,9 +495,10 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		 * Only port A can provide interrupts in all configurations of
 		 * the IP.
 		 */
-		if (pp->idx == 0 &&
-		    of_property_read_bool(port_np, "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(port_np, 0);
+		if (dev->of_node && pp->idx == 0 &&
+			fwnode_property_read_bool(fwnode,
+						  "interrupt-controller")) {
+			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
 			if (!pp->irq)
 				dev_warn(dev, "no irq for port%d\n", pp->idx);
 		}
@@ -521,7 +520,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	struct dwapb_platform_data *pdata = dev_get_platdata(dev);
 
 	if (!pdata) {
-		pdata = dwapb_gpio_get_pdata_of(dev);
+		pdata = dwapb_gpio_get_pdata(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index a4ef99b..a24b35f 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -219,7 +219,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 		return -ENOMEM;
 
 	/* Set the properties for portA */
-	pdata->properties->node		= NULL;
+	pdata->properties->fwnode	= NULL;
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
 	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 955b579..2dc7f4a 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -15,7 +15,7 @@
 #define GPIO_DW_APB_H
 
 struct dwapb_port_property {
-	struct device_node *node;
+	struct fwnode_handle *fwnode;
 	unsigned int	idx;
 	unsigned int	ngpio;
 	unsigned int	gpio_base;
-- 
1.9.1

