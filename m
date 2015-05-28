From: Y Vo <yvo@apm.com>
Subject: [PATCH v0] gpio: xgene: add ACPI support for APM X-Gene GPIO standby
 driver
Date: Thu, 28 May 2015 13:46:28 +0700
Message-ID: <1432795588-17476-1-git-send-email-yvo@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: patches@apm.com, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, Y Vo <yvo@apm.com>, Phong Vo <pvo@apm.com>
List-Id: linux-acpi@vger.kernel.org

Add ACPI support for APM X-Gene GPIO standby driver.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/gpio-xgene-sb.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index b6a15c3..50aaae5 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -25,8 +25,11 @@
 #include <linux/of_gpio.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
+#include <linux/acpi.h>
 #include <linux/basic_mmio_gpio.h>
 
+#include "gpiolib.h"
+
 #define XGENE_MAX_GPIO_DS		22
 #define XGENE_MAX_GPIO_DS_IRQ		6
 
@@ -129,6 +132,13 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	else
 		dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
 
+#ifdef CONFIG_ACPI
+	if (priv->nirq > 0) {
+		/* Register interrupt handlers for gpio signaled acpi events */
+		acpi_gpiochip_request_interrupts(&priv->bgc.gc);
+	}
+#endif
+
 	return ret;
 }
 
@@ -145,10 +155,19 @@ static const struct of_device_id xgene_gpio_sb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
+	{"APMC0D15", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
+#endif
+
 static struct platform_driver xgene_gpio_sb_driver = {
 	.driver = {
 		   .name = "xgene-gpio-sb",
 		   .of_match_table = xgene_gpio_sb_of_match,
+		   .acpi_match_table = ACPI_PTR(xgene_gpio_sb_acpi_match),
 		   },
 	.probe = xgene_gpio_sb_probe,
 	.remove = xgene_gpio_sb_remove,
-- 
1.7.1
