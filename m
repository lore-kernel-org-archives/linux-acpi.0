From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v2 2/2] gpio: designware: add gpio-signaled acpi event for power button
Date: Tue, 23 Feb 2016 15:02:52 +0800
Message-ID: <1456210972-60639-3-git-send-email-qiujiang@huawei.com>
References: <1456210972-60639-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1456210972-60639-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

This patch modifies the designware gpio controller driver to
support the gpio-signaled acpi events. This is used for power
button on hisilicon D02 board(an arm64 platform).

The corresponding DSDT table is defined as follows:
Device(GPI0) {
        Name(_HID, "HISI0181")
        Name(_ADR, 0)
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

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 0ebbdf1..d961d3b 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -7,6 +7,7 @@
  *
  * All enquiries to support@picochip.com
  */
+#include <linux/acpi.h>
 #include <linux/gpio/driver.h>
 /* FIXME: for gpio_get_value(), replace this with direct register read */
 #include <linux/gpio.h>
@@ -25,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/slab.h>
+#include "gpiolib.h"
 
 #define GPIO_SWPORTA_DR		0x00
 #define GPIO_SWPORTA_DDR	0x04
@@ -434,6 +436,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	else
 		port->is_registered = true;
 
+	/* Add GPIO-signaled ACPI event support */
+	if (pp->irq)
+		acpi_gpiochip_request_interrupts(&(port->gc));
+
 	return err;
 }
 
@@ -447,7 +453,7 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 }
 
 static struct dwapb_platform_data *
-dwapb_gpio_get_pdata_of(struct device *dev)
+dwapb_gpio_get_pdata(struct device *dev)
 {
 	struct fwnode_handle *fwnode;
 	struct dwapb_platform_data *pdata;
@@ -455,9 +461,6 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 	int nports;
 	int i;
 
-	if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
-		return ERR_PTR(-ENODEV);
-
 	nports = device_get_child_node_count(dev);
 	if (nports == 0)
 		return ERR_PTR(-ENODEV);
@@ -479,15 +482,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 
 		if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||
 		    pp->idx >= DWAPB_MAX_PORTS) {
-			dev_err(dev, "missing/invalid port index for %s\n",
-				to_of_node(fwnode)->full_name);
+			dev_err(dev, "missing/invalid port index\n");
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",
 					 &pp->ngpio)) {
-			dev_info(dev, "failed to get number of gpios for %s\n",
-				 to_of_node(fwnode)->full_name);
+			dev_info(dev, "failed to get number of gpios\n");
 			pp->ngpio = 32;
 		}
 
@@ -495,7 +496,7 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		 * Only port A can provide interrupts in all configurations of
 		 * the IP.
 		 */
-		if (pp->idx == 0 &&
+		if (dev->of_node && pp->idx == 0 &&
 			of_property_read_bool(to_of_node(fwnode),
 				"interrupt-controller")) {
 			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
@@ -505,9 +506,17 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 			}
 		}
 
+		if (has_acpi_companion(dev) && pp->idx == 0)
+			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
-		pp->name = to_of_node(fwnode)->full_name;
+
+		if (dev->of_node)
+			pp->name = to_of_node(fwnode)->full_name;
+
+		if (has_acpi_companion(dev))
+			pp->name = acpi_dev_name(to_acpi_device_node(fwnode));
 	}
 
 	return pdata;
@@ -523,7 +532,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	struct dwapb_platform_data *pdata = dev_get_platdata(dev);
 
 	if (!pdata) {
-		pdata = dwapb_gpio_get_pdata_of(dev);
+		pdata = dwapb_gpio_get_pdata(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
@@ -580,6 +589,12 @@ static const struct of_device_id dwapb_of_match[] = {
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
@@ -674,6 +689,7 @@ static struct platform_driver dwapb_gpio_driver = {
 		.name	= "gpio-dwapb",
 		.pm	= &dwapb_gpio_pm_ops,
 		.of_match_table = of_match_ptr(dwapb_of_match),
+		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
 	},
 	.probe		= dwapb_gpio_probe,
 	.remove		= dwapb_gpio_remove,
-- 
1.9.1

