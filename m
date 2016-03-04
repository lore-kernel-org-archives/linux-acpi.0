From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v5 2/3] gpio: designware: add acpi binding
Date: Fri, 4 Mar 2016 15:44:33 +0800
Message-ID: <1457077474-124064-3-git-send-email-qiujiang@huawei.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, qiujiang <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patch adds acpi binding for designware gpio driver,
because it is used to support power button on hisilicon
d02 board.

These two bindings, DT and acpi, are compatible in this
driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 49f6e5d..2ae506f 100644
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
@@ -449,7 +450,7 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 }
 
 static struct dwapb_platform_data *
-dwapb_gpio_get_pdata_of(struct device *dev)
+dwapb_gpio_get_pdata(struct device *dev)
 {
 	struct fwnode_handle *fwnode;
 	struct dwapb_platform_data *pdata;
@@ -502,9 +503,17 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 			}
 		}
 
+		if (has_acpi_companion(dev) && pp->idx == 0)
+			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
-		pp->name	= to_of_node(fwnode)->full_name;
+
+		if (dev->of_node)
+			pp->name = to_of_node(fwnode)->full_name;
+
+		if (has_acpi_companion(dev))
+			pp->name = acpi_dev_name(to_acpi_device_node(fwnode));
 	}
 
 	return pdata;
@@ -520,7 +529,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	struct dwapb_platform_data *pdata = dev_get_platdata(dev);
 
 	if (!pdata) {
-		pdata = dwapb_gpio_get_pdata_of(dev);
+		pdata = dwapb_gpio_get_pdata(dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
@@ -577,6 +586,12 @@ static const struct of_device_id dwapb_of_match[] = {
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
@@ -671,6 +686,7 @@ static struct platform_driver dwapb_gpio_driver = {
 		.name	= "gpio-dwapb",
 		.pm	= &dwapb_gpio_pm_ops,
 		.of_match_table = of_match_ptr(dwapb_of_match),
+		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
 	},
 	.probe		= dwapb_gpio_probe,
 	.remove		= dwapb_gpio_remove,
-- 
1.9.1

