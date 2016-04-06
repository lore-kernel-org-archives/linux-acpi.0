From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v7 1/3] gpio: dwapb: remove name from dwapb_port_property
Date: Wed, 6 Apr 2016 15:07:58 +0800
Message-ID: <1459926480-32966-2-git-send-email-qiujiang@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:29009 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbcDFG7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2016 02:59:08 -0400
In-Reply-To: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, delicious.quinoa@gmail.com, jamie@jamieiles.com, charles.chenxin@huawei.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, qiujiang <qiujiang@huawei.com>

This patch removed the name property from dwapb_port_property.
The name property is redundant because we can get those info
from dwapb_gpio dev and pp->idx property.

Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c                | 22 +++++++++-------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  1 -
 include/linux/platform_data/gpio-dwapb.h |  1 -
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 597de1e..91afec8 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -409,8 +409,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	err = bgpio_init(&port->gc, gpio->dev, 4, dat, set, NULL, dirout,
 			 NULL, false);
 	if (err) {
-		dev_err(gpio->dev, "failed to init gpio chip for %s\n",
-			pp->name);
+		dev_err(gpio->dev, "failed to init gpio chip\n");
 		return err;
 	}
 
@@ -429,8 +428,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 
 	err = gpiochip_add_data(&port->gc, port);
 	if (err)
-		dev_err(gpio->dev, "failed to register gpiochip for %s\n",
-			pp->name);
+		dev_err(gpio->dev, "failed to register gpiochip\n");
 	else
 		port->is_registered = true;
 
@@ -480,15 +478,16 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 
 		if (of_property_read_u32(port_np, "reg", &pp->idx) ||
 		    pp->idx >= DWAPB_MAX_PORTS) {
-			dev_err(dev, "missing/invalid port index for %s\n",
-				port_np->full_name);
+			dev_err(dev,
+				"missing/invalid port index for port%d\n", i);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (of_property_read_u32(port_np, "snps,nr-gpios",
 					 &pp->ngpio)) {
-			dev_info(dev, "failed to get number of gpios for %s\n",
-				 port_np->full_name);
+			dev_info(dev,
+				 "failed to get number of gpios for port%d\n",
+				 i);
 			pp->ngpio = 32;
 		}
 
@@ -499,15 +498,12 @@ dwapb_gpio_get_pdata_of(struct device *dev)
 		if (pp->idx == 0 &&
 		    of_property_read_bool(port_np, "interrupt-controller")) {
 			pp->irq = irq_of_parse_and_map(port_np, 0);
-			if (!pp->irq) {
-				dev_warn(dev, "no irq for bank %s\n",
-					 port_np->full_name);
-			}
+			if (!pp->irq)
+				dev_warn(dev, "no irq for this bank\n");
 		}
 
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
-		pp->name	= port_np->full_name;
 	}
 
 	return pdata;
diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index bdc5e27..a4ef99b 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -220,7 +220,6 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
 
 	/* Set the properties for portA */
 	pdata->properties->node		= NULL;
-	pdata->properties->name		= "intel-quark-x1000-gpio-portA";
 	pdata->properties->idx		= 0;
 	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
 	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
index 28702c8..955b579 100644
--- a/include/linux/platform_data/gpio-dwapb.h
+++ b/include/linux/platform_data/gpio-dwapb.h
@@ -16,7 +16,6 @@
 
 struct dwapb_port_property {
 	struct device_node *node;
-	const char	*name;
 	unsigned int	idx;
 	unsigned int	ngpio;
 	unsigned int	gpio_base;
-- 
1.9.1

