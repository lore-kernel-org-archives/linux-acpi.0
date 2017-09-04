From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v5 2/3] platform/x86: Add support for Dollar Cove TI power button
Date: Mon,  4 Sep 2017 16:43:39 +0200
Message-ID: <20170904144340.27693-3-tiwai@suse.de>
References: <20170904144340.27693-1-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904144340.27693-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This provides a new input driver for supporting the power button on
Dollar Cove TI PMIC, found on Cherrytrail-based devices.
The patch is based on the original work by Intel, found at:
  https://github.com/01org/ProductionKernelQuilts

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v4->v5:
* no change in this driver
v3->v4:
* Minor fixes suggested by Dmitry
* Rephrase Kconfig help texts
v2->v3:
* Rename dc_ti with chtdc_ti in all places
* Driver/kconfig renames accordingly
* Constification
* Added acks by Andy and Mika
v1->v2:
* Move power-button driver to platform/x86, driver renames accordingly
* Add missing wake-irq cleanup to power-button driver

 drivers/platform/x86/Kconfig                 | 11 ++++
 drivers/platform/x86/Makefile                |  1 +
 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c | 94 ++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/platform/x86/intel_chtdc_ti_pwrbtn.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 80b87954f6dd..c3c02b6b2a7f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1139,6 +1139,17 @@ config SILEAD_DMI
 	  with the OS-image for the device. This option supplies the missing
 	  information. Enable this for x86 tablets with Silead touchscreens.
 
+config INTEL_CHTDC_TI_PWRBTN
+	tristate "Intel Cherry Trail Dollar Cove TI power button driver"
+	depends on INTEL_SOC_PMIC_CHTDC_TI
+	depends on INPUT
+	---help---
+	  This option adds a power button driver driver for Dollar Cove TI
+	  PMIC on Intel Cherry Trail devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_chtdc_ti_pwrbtn.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 91cec1751461..6a14fdbcecbe 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -83,3 +83,4 @@ obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_MLX_CPLD_PLATFORM)	+= mlxcpld-hotplug.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
+obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
diff --git a/drivers/platform/x86/intel_chtdc_ti_pwrbtn.c b/drivers/platform/x86/intel_chtdc_ti_pwrbtn.c
new file mode 100644
index 000000000000..ddd5d9027e92
--- /dev/null
+++ b/drivers/platform/x86/intel_chtdc_ti_pwrbtn.c
@@ -0,0 +1,94 @@
+/*
+ * Power-button driver for Dollar Cove TI PMIC
+ * Copyright (C) 2014 Intel Corp
+ * Copyright (c) 2017 Takashi Iwai <tiwai@suse.de>
+ */
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/slab.h>
+
+#define CHTDC_TI_SIRQ_REG	0x3
+#define SIRQ_PWRBTN_REL		BIT(0)
+
+static irqreturn_t chtdc_ti_pwrbtn_interrupt(int irq, void *dev_id)
+{
+	struct input_dev *input = dev_id;
+	struct device *dev = input->dev.parent;
+	struct regmap *regmap = dev_get_drvdata(dev);
+	int state;
+
+	if (!regmap_read(regmap, CHTDC_TI_SIRQ_REG, &state)) {
+		dev_dbg(dev, "SIRQ_REG=0x%x\n", state);
+		input_report_key(input, KEY_POWER, !(state & SIRQ_PWRBTN_REL));
+		input_sync(input);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int chtdc_ti_pwrbtn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
+	struct input_dev *input;
+	int irq, err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	input->name = pdev->name;
+	input->phys = "power-button/input0";
+	input->id.bustype = BUS_HOST;
+	input_set_capability(input, EV_KEY, KEY_POWER);
+	err = input_register_device(input);
+	if (err)
+		return err;
+
+	dev_set_drvdata(dev, pmic->regmap);
+
+	err = devm_request_threaded_irq(dev, irq, NULL,
+					chtdc_ti_pwrbtn_interrupt,
+					0, KBUILD_MODNAME, input);
+	if (err)
+		return err;
+
+	device_init_wakeup(dev, true);
+	dev_pm_set_wake_irq(dev, irq);
+	return 0;
+}
+
+static int chtdc_ti_pwrbtn_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+	return 0;
+}
+
+static const struct platform_device_id chtdc_ti_pwrbtn_id_table[] = {
+	{ .name = "chtdc_ti_pwrbtn" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, chtdc_ti_pwrbtn_id_table);
+
+static struct platform_driver chtdc_ti_pwrbtn_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+	},
+	.probe		= chtdc_ti_pwrbtn_probe,
+	.remove		= chtdc_ti_pwrbtn_remove,
+	.id_table	= chtdc_ti_pwrbtn_id_table,
+};
+module_platform_driver(chtdc_ti_pwrbtn_driver);
+
+MODULE_DESCRIPTION("Power-button driver for Dollar Cove TI PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
