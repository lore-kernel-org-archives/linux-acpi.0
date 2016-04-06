From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Wed, 6 Apr 2016 15:08:00 +0800
Message-ID: <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, delicious.quinoa@gmail.com, jamie@jamieiles.com, charles.chenxin@huawei.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, qiujiang <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patch adds gpio-signaled acpi event support. It is used for
power button on hisilicon D02 board, an arm64 platform.

The corresponding DSDT file is defined as follows:
 Device(GPI0) {
        Name(_HID, "HISI0181")
	Name(_ADR, 0)
        Name(_UID, 0)

	Name (_CRS, ResourceTemplate ()  {
		Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
		Interrupt (ResourceConsumer, Level, ActiveHigh,
		Exclusive,,,)  {344}
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
		GpioInt(Edge, ActiveLow, ExclusiveAndWake,
		PullUp, , " \\_SB.GPI0") {8}
	})

	Method (_E08, 0x0, NotSerialized) {
		Notify (\_SB.PWRB, 0x80)
	}
}

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/gpio/gpio-dwapb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 3c4d8e6..1cd8c20 100644
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
@@ -27,6 +28,8 @@
 #include <linux/platform_data/gpio-dwapb.h>
 #include <linux/slab.h>
 
+#include "gpiolib.h"
+
 #define GPIO_SWPORTA_DR		0x00
 #define GPIO_SWPORTA_DDR	0x04
 #define GPIO_SWPORTB_DR		0x0c
@@ -434,6 +437,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	else
 		port->is_registered = true;
 
+	/* Add GPIO-signaled ACPI event support */
+	if (pp->irq)
+		acpi_gpiochip_request_interrupts(&port->gc);
+
 	return err;
 }
 
@@ -501,6 +508,9 @@ dwapb_gpio_get_pdata(struct device *dev)
 				dev_warn(dev, "no irq for this bank\n");
 		}
 
+		if (has_acpi_companion(dev) && pp->idx == 0)
+			pp->irq = platform_get_irq(to_platform_device(dev), 0);
+
 		pp->irq_shared	= false;
 		pp->gpio_base	= -1;
 	}
@@ -575,6 +585,12 @@ static const struct of_device_id dwapb_of_match[] = {
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
@@ -669,6 +685,7 @@ static struct platform_driver dwapb_gpio_driver = {
 		.name	= "gpio-dwapb",
 		.pm	= &dwapb_gpio_pm_ops,
 		.of_match_table = of_match_ptr(dwapb_of_match),
+		.acpi_match_table = ACPI_PTR(dwapb_acpi_match),
 	},
 	.probe		= dwapb_gpio_probe,
 	.remove		= dwapb_gpio_remove,
-- 
1.9.1
