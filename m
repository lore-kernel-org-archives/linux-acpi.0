From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Fri, 4 Mar 2016 15:44:32 +0800
Message-ID: <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, qiujiang <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patch converts device node to fwnode in
dwapb_port_property for designware gpio driver,
so as to provide a unified data structure for DT
and ACPI bindings.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c                | 43 +++++++++++++++-----------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 597de1e..49f6e5d 100644
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
@@ -449,17 +451,13 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 static struct dwapb_platform_data *
 dwapb_gpio_get_pdata_of(struct device *dev)
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
 
@@ -474,21 +472,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
-			dev_err(dev, "missing/invalid port index for %s\n",
-				port_np->full_name);
+			dev_err(dev, "missing/invalid port index\n");
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (of_property_read_u32(port_np, "snps,nr-gpios",
+		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
 					 &pp->ngpio)) {
-			dev_info(dev, "failed to get number of gpios for %s\n",
-				 port_np->full_name);
+			dev_info(dev, "failed to get number of gpios\n");
 			pp->ngpio = 32;
 		}
 
@@ -496,18 +492,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		 * Only port A can provide interrupts in all configurations of
 		 * the IP.
 		 */
-		if (pp->idx == 0 &&
-		    of_property_read_bool(port_np, "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(port_np, 0);
+		if (dev->of_node && pp->idx == 0 &&
+			of_property_read_bool(to_of_node(fwnode),
+				"interrupt-controller")) {
+			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
 			if (!pp->irq) {
 				dev_warn(dev, "no irq for bank %s\n",
-					 port_np->full_name);
+					 to_of_node(fwnode)->full_name);
 			}
 		}
 
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
-		pp->name	= port_np->full_name;
+		pp->name	= to_of_node(fwnode)->full_name;
 	}
 
 	return pdata;
diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 0421374..265bd3c 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -227,7 +227,7 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 		return -ENOMEM;
 
 	/* Set the properties for portA */
-	pdata->properties->node		= NULL;
+	pdata->properties->fwnode	= NULL;
 	pdata->properties->name		= "intel-quark-x1000-gpio-portA";
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 28702c8..c5bd1f2 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -15,7 +15,7 @@
 #define GPIO_DW_APB_H
 
 struct dwapb_port_property {
-	struct device_node *node;
+	struct fwnode_handle *fwnode;
 	const char	*name;
 	unsigned int	idx;
 	unsigned int	ngpio;
-- 
1.9.1

