From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Wed, 24 May 2017 12:42:16 +0200
Message-ID: <20170524104216.23643-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758541AbdEXKmU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 May 2017 06:42:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
PMC to wakeup the system. When this happens software needs to clear the
PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.

This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.

This commit adds a driver which registers the Virtual GPIOs expected
by the DSDT on these devices, letting gpiolib-acpi claim the
virtual GPIO and install a GPIO-interrupt handler which call the _L02
handler as it would for a real GPIO controller.

Cc: joeyli <jlee@suse.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
-Remove dev_err after malloc failure
-Remove unused empty runtime pm callbacks
-s/GPE0A_PME_/GPE0A_PME_B0_/
-Fixed some checkpatch warnings (I forgot to run checkpatch on v1)
Changes in v3:
-Rewrite as gpiochip driver letting gpiolib-acpi deal with claiming the pin
 0x0002 and calling the _L02 event handler when the virtual gpio-irq triggers
-Rebase on 4.12-rc1
Changes in v4:
-Drop device_init_wakeup() from _probe(), use pm_system_wakeup() instead
 of pm_wakeup_hard_event(chip->parent)
-Improve commit message
Changes in v5:
-Use BIT() macro for FOO_BIT defines
-Drop unneeded ACPI_PTR macro usage
---
 drivers/gpio/Kconfig        |  14 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-int0002.c | 210 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/gpio/gpio-int0002.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 23ca51ee6b28..11e7f9b464d4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -608,6 +608,20 @@ config GPIO_GPIO_MM
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config GPIO_INT0002
+	tristate "Intel ACPI INT0002 Virtual GPIO"
+	depends on ACPI
+	select GPIOLIB_IRQCHIP
+	---help---
+	  Some peripherals on Baytrail and Cherrytrail platforms signal
+	  PME to the PMC to wakeup the system. When this happens software
+	  needs to explicitly clear the interrupt source to avoid an IRQ
+	  storm on IRQ 9. This is modelled in ACPI through the INT0002
+	  Virtual GPIO ACPI device.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio_int0002.
+
 config GPIO_IT87
 	tristate "IT87xx GPIO support"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 68b96277d9fa..1f76c5694079 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_INT0002)	+= gpio-int0002.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-int0002.c b/drivers/gpio/gpio-int0002.c
new file mode 100644
index 000000000000..50b4e0a213d0
--- /dev/null
+++ b/drivers/gpio/gpio-int0002.c
@@ -0,0 +1,210 @@
+/*
+ * Intel INT0002 "Virtual GPIO" driver
+ *
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Loosely based on android x86 kernel code which is:
+ *
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * Author: Dyut Kumar Sil <dyut.k.sil@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
+ * PMC to wakeup the system. When this happens software needs to clear the
+ * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
+ *
+ * This is modelled in ACPI through the INT0002 ACPI device, which is
+ * called a "Virtual GPIO controller" in ACPI because it defines the event
+ * handler to call when the PME triggers through _AEI and _L02 / _E02
+ * methods as would be done for a real GPIO interrupt in ACPI.
+ *
+ * This driver will bind to the INT0002 device, and register as a GPIO
+ * controller, letting gpiolib-acpi.c call the _L02 handler as it would
+ * for a real GPIO controller.
+ */
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <linux/acpi.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+
+#define DRV_NAME			"INT0002 Virtual GPIO"
+
+/* For some reason the virtual GPIO pin tied to the GPE is numbered pin 2 */
+#define GPE0A_PME_B0_VIRT_GPIO_PIN	2
+
+#define GPE0A_PME_B0_STS_BIT		BIT(13)
+#define GPE0A_PME_B0_EN_BIT		BIT(13)
+#define GPE0A_STS_PORT			0x420
+#define GPE0A_EN_PORT			0x428
+
+#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+
+static const struct x86_cpu_id int0002_cpu_ids[] = {
+/*
+ * Limit ourselves to Cherry Trail for now, until testing shows we
+ * need to handle the INT0002 device on Baytrail too.
+ *	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	 * Valleyview, Bay Trail *
+ */
+	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
+	{}
+};
+
+static int int0002_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	return 0;
+}
+
+static void int0002_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+}
+
+static int int0002_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned int offset, int value)
+{
+	return 0;
+}
+
+static void int0002_irq_ack(struct irq_data *data)
+{
+	outl(GPE0A_PME_B0_STS_BIT, GPE0A_STS_PORT);
+}
+
+static void int0002_irq_unmask(struct irq_data *data)
+{
+	u32 gpe_en_reg;
+
+	gpe_en_reg = inl(GPE0A_EN_PORT);
+	gpe_en_reg |= GPE0A_PME_B0_EN_BIT;
+	outl(gpe_en_reg, GPE0A_EN_PORT);
+}
+
+static void int0002_irq_mask(struct irq_data *data)
+{
+	u32 gpe_en_reg;
+
+	gpe_en_reg = inl(GPE0A_EN_PORT);
+	gpe_en_reg &= ~GPE0A_PME_B0_EN_BIT;
+	outl(gpe_en_reg, GPE0A_EN_PORT);
+}
+
+static irqreturn_t int0002_irq(int irq, void *data)
+{
+	struct gpio_chip *chip = data;
+	u32 gpe_sts_reg;
+
+	gpe_sts_reg = inl(GPE0A_STS_PORT);
+	if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
+		return IRQ_NONE;
+
+	generic_handle_irq(irq_find_mapping(chip->irqdomain,
+					    GPE0A_PME_B0_VIRT_GPIO_PIN));
+
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
+
+static struct irq_chip int0002_irqchip = {
+	.name			= DRV_NAME,
+	.irq_ack		= int0002_irq_ack,
+	.irq_mask		= int0002_irq_mask,
+	.irq_unmask		= int0002_irq_unmask,
+};
+
+static int int0002_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct x86_cpu_id *cpu_id;
+	struct gpio_chip *chip;
+	int i, irq, ret;
+
+	/* Menlow has a different INT0002 device? <sigh> */
+	cpu_id = x86_match_cpu(int0002_cpu_ids);
+	if (!cpu_id)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Error getting IRQ: %d\n", irq);
+		return irq;
+	}
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->label = DRV_NAME;
+	chip->parent = dev;
+	chip->owner = THIS_MODULE;
+	chip->get = int0002_gpio_get;
+	chip->set = int0002_gpio_set;
+	chip->direction_input = int0002_gpio_get;
+	chip->direction_output = int0002_gpio_direction_output;
+	chip->base = -1;
+	chip->ngpio = GPE0A_PME_B0_VIRT_GPIO_PIN + 1;
+	chip->irq_need_valid_mask = true;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, chip, NULL);
+	if (ret) {
+		dev_err(dev, "Error adding gpio chip: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
+		clear_bit(i, chip->irq_valid_mask);
+
+	/*
+	 * We manually request the irq here instead of passing a flow-handler
+	 * to gpiochip_set_chained_irqchip, because the irq is shared.
+	 */
+	ret = devm_request_irq(dev, irq, int0002_irq,
+			       IRQF_SHARED | IRQF_NO_THREAD, "INT0002", chip);
+	if (ret) {
+		dev_err(dev, "Error requesting IRQ %d: %d\n", irq, ret);
+		return ret;
+	}
+
+	ret = gpiochip_irqchip_add(chip, &int0002_irqchip, 0, handle_edge_irq,
+				   IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev, "Error adding irqchip: %d\n", ret);
+		return ret;
+	}
+
+	gpiochip_set_chained_irqchip(chip, &int0002_irqchip, irq, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id int0002_acpi_ids[] = {
+	{ "INT0002", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, int0002_acpi_ids);
+
+static struct platform_driver int0002_driver = {
+	.driver = {
+		.name			= DRV_NAME,
+		.acpi_match_table	= int0002_acpi_ids,
+	},
+	.probe	= int0002_probe,
+};
+
+module_platform_driver(int0002_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Intel INT0002 Virtual GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.13.0

