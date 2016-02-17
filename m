From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v1] GPIO/ACPI: DesignWare: Add GPIO-signaled ACPI events support for power button
Date: Wed, 17 Feb 2016 15:28:10 +0800
Message-ID: <1455694090-41713-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, mika.westerberg@linux.intel.com
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, qiujiang <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patch modifies the DesignWare GPIO controller driver to
support the GPIO-signaled ACPI Events. This is used for power
button function on ARM server.

To make it work, the _AEI and _EVT object must be defined in
the corresponding GPIO driver's dsdt table in UEFI as follow:

Device(GPI0) {
        Name(_HID, "HISI0181")
	Name(_ADR, 0) // _ADR: Address
        Name(_UID, 0)

	Name (_CRS, ResourceTemplate ()  {
		Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
		Interrupt (ResourceConsumer, Level, ActiveHigh,
		Exclusive,,,) {344}
	})

	Device(PRTa) {
		Name (_DSD, Package () {
			Package () {
				Package () {"reg",0},
				Package () {"snps,nr-gpios",32},
		}
		})
	}

	Name (_AEI, ResourceTemplate () {
		GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp, ,
		" \\_SB.GPI0") {8}
	})

	Method (_E08, 0x0, NotSerialized) {
		Notify (\_SB.PWRB, 0x80)
	}
}

Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c                | 71 ++++++++++++++++++++------------
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index fcd5b0a..e482e32 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -7,6 +7,7 @@
  *
  * All enquiries to support@picochip.com
  */
+#include <linux/acpi.h>
 #include <linux/basic_mmio_gpio.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -24,6 +25,8 @@
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/slab.h>
 
+#include "gpiolib.h"
+
 #define GPIO_SWPORTA_DR		0x00
 #define GPIO_SWPORTA_DDR	0x04
 #define GPIO_SWPORTB_DR		0x0c
@@ -296,14 +299,14 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 				 struct dwapb_port_property *pp)
 {
 	struct gpio_chip *gc = &port->bgc.gc;
-	struct device_node *node = pp->node;
+	struct fwnode_handle  *fwnode = pp->fwnode;
 	struct irq_chip_generic	*irq_gc = NULL;
 	unsigned int hwirq, ngpio = gc->ngpio;
 	struct irq_chip_type *ct;
 	int err, i;
 
-	gpio->domain = irq_domain_add_linear(node, ngpio,
-					     &irq_generic_chip_ops, gpio);
+	gpio->domain = irq_domain_create_linear(fwnode,
+				ngpio, &irq_generic_chip_ops, gpio);
 	if (!gpio->domain)
 		return;
 
@@ -421,7 +424,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	}
 
 #ifdef CONFIG_OF_GPIO
-	port->bgc.gc.of_node = pp->node;
+	port->bgc.gc.of_node = to_of_node(pp->fwnode);
 #endif
 	port->bgc.gc.ngpio = pp->ngpio;
 	port->bgc.gc.base = pp->gpio_base;
@@ -440,6 +443,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	else
 		port->is_registered = true;
 
+	/* Add GPIO-signaled ACPI event support */
+	if (pp->irq)
+		acpi_gpiochip_request_interrupts(&(port->bgc.gc));
+
 	return err;
 }
 
@@ -453,19 +460,15 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
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
 
@@ -480,21 +483,19 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 	pdata->nports = nports;
 
 	i = 0;
-	for_each_child_of_node(node, port_np) {
-		pp = &pdata->properties[i++];
-		pp->node = port_np;
+	device_for_each_child_node(dev, fwnode) {
+		pp = &pdata->properties[i];
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
 
@@ -502,18 +503,27 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		 * Only port A can provide interrupts in all configurations of
 		 * the IP.
 		 */
-		if (pp->idx == 0 &&
-		    of_property_read_bool(port_np, "interrupt-controller")) {
-			pp->irq = irq_of_parse_and_map(port_np, 0);
+		 if (dev->of_node && pp->idx == 0 &&
+			 of_property_read_bool(to_of_node(fwnode),
+			 "interrupt-controller")) {
+			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
 			if (!pp->irq) {
-				dev_warn(dev, "no irq for bank %s\n",
-					 port_np->full_name);
+			dev_warn(dev, "no irq for bank %s\n",
+				  to_of_node(fwnode)->full_name);
 			}
 		}
 
+		if (has_acpi_companion(dev) && pp->idx == 0)
+			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
-		pp->name	= port_np->full_name;
+
+		if (dev->of_node)
+			pp->name = to_of_node(fwnode)->full_name;
+
+		if (has_acpi_companion(dev))
+			pp->name = acpi_dev_name(to_acpi_device_node(fwnode));
 	}
 
 	return pdata;
@@ -529,7 +539,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	struct dwapb_platform_data *pdata = dev_get_platdata(dev);
 
 	if (!pdata) {
-		pdata = dwapb_gpio_get_pdata_of(dev);
+		pdata = dwapb_gpio_get_pdata(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
@@ -586,6 +596,12 @@ static const struct of_device_id dwapb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dwapb_of_match);
 
+static const struct acpi_device_id dwapb_acpi_match[] = {
+	{"HISI0181", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
+
 #ifdef CONFIG_PM_SLEEP
 static int dwapb_gpio_suspend(struct device *dev)
 {
@@ -680,6 +696,7 @@ static struct platform_driver dwapb_gpio_driver = {
 		.name	= "gpio-dwapb",
 		.pm	= &dwapb_gpio_pm_ops,
 		.of_match_table = of_match_ptr(dwapb_of_match),
+		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
 	},
 	.probe		= dwapb_gpio_probe,
 	.remove		= dwapb_gpio_remove,
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

