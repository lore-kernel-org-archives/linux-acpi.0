From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v2 1/2] gpio: designware: switch device node to fwnode
Date: Tue, 23 Feb 2016 15:02:51 +0800
Message-ID: <1456210972-60639-2-git-send-email-qiujiang@huawei.com>
References: <1456210972-60639-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1456210972-60639-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

This patch switch device node to fwnode in dwapb_port_property,
so as to apply a unified data structure for DT and ACPI.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c                | 36 ++++++++++++++++----------------
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 597de1e..0ebbdf1 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -290,14 +290,14 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
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
 
@@ -415,7 +415,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	}
 
 #ifdef CONFIG_OF_GPIO
-	port->gc.of_node = pp->node;
+	port->gc.of_node = to_of_node(pp->fwnode);
 #endif
 	port->gc.ngpio = pp->ngpio;
 	port->gc.base = pp->gpio_base;
@@ -449,17 +449,16 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
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
+	if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
 		return ERR_PTR(-ENODEV);
 
-	nports = of_get_child_count(node);
+	nports = device_get_child_node_count(dev);
 	if (nports == 0)
 		return ERR_PTR(-ENODEV);
 
@@ -474,21 +473,21 @@ dwapb_gpio_get_pdata_of(struct device *dev)
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
 			dev_err(dev, "missing/invalid port index for %s\n",
-				port_np->full_name);
+				to_of_node(fwnode)->full_name);
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (of_property_read_u32(port_np, "snps,nr-gpios",
+		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
 					 &pp->ngpio)) {
 			dev_info(dev, "failed to get number of gpios for %s\n",
-				 port_np->full_name);
+				 to_of_node(fwnode)->full_name);
 			pp->ngpio = 32;
 		}
 
@@ -497,17 +496,18 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		 * the IP.
 		 */
 		if (pp->idx == 0 &&
-		    of_property_read_bool(port_np, "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(port_np, 0);
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
+		pp->name = to_of_node(fwnode)->full_name;
 	}
 
 	return pdata;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 28702c8..80954f2 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -15,7 +15,7 @@
 #define GPIO_DW_APB_H
 
 struct dwapb_port_property {
-	struct device_node *node;
+	struct fwnode_handle  *fwnode;
 	const char	*name;
 	unsigned int	idx;
 	unsigned int	ngpio;
-- 
1.9.1

