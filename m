From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 4/4] gpio: dln2: add support for ACPI pin configuration
Date: Tue, 16 Dec 2014 18:12:33 +0200
Message-ID: <1418746353-3481-5-git-send-email-octavian.purdila@intel.com>
References: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, lee.jones@linaro.org, rjw@rjwysocki.net
Cc: johan@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, heikki.krogerus@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-acpi@vger.kernel.org

This patch configures the pull-up/pull-down properties based on the
ACPI configuration. It scans the children of the DLN2 root entry and
looks for GPIO resources and applies the pull-up/pull-down
configurations on the pins.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/gpio/gpio-dln2.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 2fdb138..98189d5 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -19,6 +19,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/dln2.h>
+#include <linux/acpi.h>
 
 #define DLN2_GPIO_ID			0x01
 
@@ -36,6 +37,10 @@
 #define DLN2_GPIO_PIN_GET_DIRECTION	DLN2_CMD(0x14, DLN2_GPIO_ID)
 #define DLN2_GPIO_PIN_SET_EVENT_CFG	DLN2_CMD(0x1E, DLN2_GPIO_ID)
 #define DLN2_GPIO_PIN_GET_EVENT_CFG	DLN2_CMD(0x1F, DLN2_GPIO_ID)
+#define CMD_GPIO_PIN_PULLUP_ENABLE	DLN2_CMD(0x18, DLN2_GPIO_ID)
+#define CMD_GPIO_PIN_PULLUP_DISABLE	DLN2_CMD(0x19, DLN2_GPIO_ID)
+#define CMD_GPIO_PIN_PULLDOWN_ENABLE	DLN2_CMD(0x20, DLN2_GPIO_ID)
+#define CMD_GPIO_PIN_PULLDOWN_DISABLE	DLN2_CMD(0x21, DLN2_GPIO_ID)
 
 #define DLN2_GPIO_EVENT_NONE		0
 #define DLN2_GPIO_EVENT_CHANGE		1
@@ -428,6 +433,75 @@ static void dln2_gpio_event(struct platform_device *pdev, u16 echo,
 	}
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
+static int dln2_gpio_do_acpi_setup(struct acpi_resource *ares, void *data)
+{
+	int i;
+	u16 cmd[2];
+	const char *info;
+	struct dln2_gpio *dln2 = data;
+	const struct acpi_resource_gpio *agpio = &ares->data.gpio;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
+		return 1;
+
+	switch (agpio->pin_config) {
+	case  ACPI_PIN_CONFIG_PULLUP:
+		info = "pullup";
+		cmd[0] = CMD_GPIO_PIN_PULLDOWN_DISABLE;
+		cmd[1] = CMD_GPIO_PIN_PULLUP_ENABLE;
+		break;
+	case  ACPI_PIN_CONFIG_PULLDOWN:
+		info = "pulldown";
+		cmd[0] = CMD_GPIO_PIN_PULLDOWN_ENABLE;
+		cmd[1] = CMD_GPIO_PIN_PULLUP_DISABLE;
+		break;
+	case  ACPI_PIN_CONFIG_NOPULL:
+		info = "nopull";
+		cmd[0] = CMD_GPIO_PIN_PULLDOWN_DISABLE;
+		cmd[1] = CMD_GPIO_PIN_PULLUP_DISABLE;
+		break;
+	default:
+		return 1;
+	}
+
+	for (i = 0; i < agpio->pin_table_length; i++) {
+		int pin = agpio->pin_table[i];
+
+		dev_info(dln2->gpio.dev, "setting %s on pin %d\n", info, pin);
+		dln2_gpio_pin_cmd(dln2, cmd[0], pin);
+		dln2_gpio_pin_cmd(dln2, cmd[1], pin);
+	}
+
+	return 1;
+}
+
+static void dln2_gpio_acpi_setup(struct dln2_gpio *dln2)
+{
+	struct acpi_device *adev, *child;
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(dln2->gpio.dev);
+	if (!handle || acpi_bus_get_device(handle, &adev))
+		return;
+
+	list_for_each_entry(child, &adev->children, node) {
+		LIST_HEAD(res);
+		int ret;
+
+		ret = acpi_dev_get_resources(child, &res,
+					     dln2_gpio_do_acpi_setup, dln2);
+		if (ret < 0)
+			continue;
+		acpi_dev_free_resource_list(&res);
+	}
+}
+#else
+static void dln2_gpio_acpi_setup(struct dln2_gpio *dln2)
+{
+}
+#endif
+
 static int dln2_gpio_probe(struct platform_device *pdev)
 {
 	struct dln2_gpio *dln2;
@@ -492,6 +566,8 @@ static int dln2_gpio_probe(struct platform_device *pdev)
 		goto out_gpiochip_remove;
 	}
 
+	dln2_gpio_acpi_setup(dln2);
+
 	return 0;
 
 out_gpiochip_remove:
-- 
1.9.1
