From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH] ACPI: introduce ACPI GPIO controller driver
Date: Tue, 25 Sep 2012 09:51:04 +0800
Message-ID: <1348537864.10877.189.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:44226 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab2IYBuX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 21:50:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Len, Brown" <lenb@kernel.org>

>From 998bd309b8cf758a26b35d3802429452aba8090d Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 25 Sep 2012 09:40:08 +0800
Subject: [PATCH] ACPI: Introduce ACPI GPIO controller driver

Hardware Reduced ACPI platforms do not have SCI.
Instead, it uses GPIO Interrupt connections to signal ACPI events.
Thus there are GPIO Controller devices described in ACPI namespace.
These GPIO controllers can either be used for ACPI events,
or be used by other devices directly as Interrupt resources.

This patch introduces ACPI GPIO controller driver, together with
ACPI 5.0 event model support.

If you want to get more details on ACPI 5 event model,
please refer to section 5.6.6, ACPI 5.0 specification.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Makefile       |    1 +
 drivers/acpi/bus.c          |    1 +
 drivers/acpi/gpio.c         |  450 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h     |    5 +
 include/acpi/acpi_drivers.h |    4 +
 5 files changed, 461 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/gpio.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 47199e2..6b1d535 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -34,6 +34,7 @@ acpi-y				+= bus.o glue.o
 acpi-y				+= scan.o
 acpi-y				+= processor_core.o
 acpi-y				+= ec.o
+acpi-y				+= gpio.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
 acpi-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 acpi-y				+= power.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9628652..0a3fd9d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1071,6 +1071,7 @@ static int __init acpi_init(void)
 	pci_mmcfg_late_init();
 	acpi_scan_init();
 	acpi_ec_init();
+	acpi_gpio_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
diff --git a/drivers/acpi/gpio.c b/drivers/acpi/gpio.c
new file mode 100644
index 0000000..e16084a
--- /dev/null
+++ b/drivers/acpi/gpio.c
@@ -0,0 +1,450 @@
+/*
+ *  gpio.c - ACPI GPIO Controller Driver and ACPI 5.0 Event Model (v1.0)
+ *
+ *  Copyright (c) 2012 Intel Corp
+ *  Copyright (c) 2012 Zhang Rui <rui.zhang@intel.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/spinlock.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/pnp.h>
+#include <linux/gpio.h>
+
+#undef PREFIX
+#define PREFIX				"ACPI: GPIO: "
+
+#define ACPI_GPIO_CLASS "gpio_controller"
+#define ACPI_GPIO_DEVICE_NAME "General Purpose I/O controller"
+
+#define ACPI_GPIO_IRQ_BASE	0x100
+#define ACPI_GPIO_IRQ_LENGTH	0x60
+
+static LIST_HEAD(acpi_gpio_list);
+static DEFINE_MUTEX(acpi_gpio_lock);
+
+struct acpi_gpio {
+	struct gpio_chip chip;
+	spinlock_t lock;
+	int irq;
+	void *reg_base;		/* base addr for GPIO registers */
+	unsigned irq_base;	/* irq for pin 0 */
+	struct acpi_device *adev;
+	unsigned long *pins;	/* BITMAP : 0: generic interrupt, 1 : ACPI 5 event model */
+	unsigned long *mode;	/* BITMAP : 0: Level, 1 : Edge */
+	struct list_head node;
+};
+
+enum GPIO_REG {
+	GPLR = 0,		/* pin level read-only */
+	GPDR,			/* pin direction */
+	GPSR,			/* pin set */
+	GPCR,			/* pin clear */
+	GRER,			/* rising edge detect */
+	GFER,			/* falling edge detect */
+	GEDR,			/* edge detect result */
+};
+
+static void __iomem *gpio_reg(struct gpio_chip *chip, unsigned offset,
+			      enum GPIO_REG reg_type)
+{
+	struct acpi_gpio *gpio = container_of(chip, struct acpi_gpio, chip);
+	unsigned nreg = chip->ngpio / 32;
+	u8 reg = offset / 32;
+	void __iomem *ptr;
+
+	ptr = (void __iomem *)(gpio->reg_base + reg_type * nreg * 4 + reg * 4);
+	return ptr;
+}
+
+static int acpi_irq_type(struct irq_data *d, unsigned type)
+{
+	struct acpi_gpio *gpio = irq_data_get_irq_chip_data(d);
+	u32 pin = d->irq - gpio->irq_base;
+	unsigned long flags;
+	u32 value;
+	void __iomem *grer = gpio_reg(&gpio->chip, pin, GRER);
+	void __iomem *gfer = gpio_reg(&gpio->chip, pin, GFER);
+
+	if (pin >= gpio->chip.ngpio)
+		return -EINVAL;
+
+	spin_lock_irqsave(&gpio->lock, flags);
+	if (type & IRQ_TYPE_EDGE_RISING)
+		value = readl(grer) | BIT(pin % 32);
+	else
+		value = readl(grer) & (~BIT(pin % 32));
+	writel(value, grer);
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		value = readl(gfer) | BIT(pin % 32);
+	else
+		value = readl(gfer) & (~BIT(pin % 32));
+	writel(value, gfer);
+	spin_unlock_irqrestore(&gpio->lock, flags);
+
+	return 0;
+}
+
+static void acpi_irq_unmask(struct irq_data *d)
+{
+}
+
+static void acpi_irq_mask(struct irq_data *d)
+{
+}
+
+static struct irq_chip acpi_irqchip = {
+	.name = "ACPI-GPIO",
+	.irq_mask = acpi_irq_mask,
+	.irq_unmask = acpi_irq_unmask,
+	.irq_set_type = acpi_irq_type,
+};
+
+static int acpi_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *gplr = gpio_reg(chip, offset, GPLR);
+
+	return readl(gplr) & BIT(offset % 32);
+}
+
+static void acpi_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	void __iomem *gpsr, *gpcr;
+
+	if (value) {
+		gpsr = gpio_reg(chip, offset, GPSR);
+		writel(BIT(offset % 32), gpsr);
+	} else {
+		gpcr = gpio_reg(chip, offset, GPCR);
+		writel(BIT(offset % 32), gpcr);
+	}
+}
+
+static int acpi_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct acpi_gpio *gpio = container_of(chip, struct acpi_gpio, chip);
+	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
+	u32 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio->lock, flags);
+	value = readl(gpdr);
+	value &= ~BIT(offset % 32);
+	writel(value, gpdr);
+	spin_unlock_irqrestore(&gpio->lock, flags);
+
+	return 0;
+}
+
+static int acpi_gpio_direction_output(struct gpio_chip *chip,
+				      unsigned offset, int value)
+{
+	struct acpi_gpio *gpio = container_of(chip, struct acpi_gpio, chip);
+	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
+	unsigned long flags;
+	acpi_gpio_set(chip, offset, value);
+
+	spin_lock_irqsave(&gpio->lock, flags);
+	value = readl(gpdr);
+	value |= BIT(offset % 32);
+	writel(value, gpdr);
+	spin_unlock_irqrestore(&gpio->lock, flags);
+
+	return 0;
+}
+
+static int acpi_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct acpi_gpio *gpio = container_of(chip, struct acpi_gpio, chip);
+	return gpio->irq_base + offset;
+}
+
+static void acpi_gpio_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct acpi_gpio *gpio = irq_data_get_irq_handler_data(data);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	u32 base, pin, mask;
+	int i;
+	unsigned long pending;
+	void __iomem *gedr;
+	char buf[5];
+	acpi_handle handle;
+	acpi_status status;
+
+	/* check which pin triggers the interrupt */
+	for (base = 0; base < gpio->chip.ngpio; base += BITS_PER_LONG) {
+		i = base / BITS_PER_LONG;
+		gedr = gpio_reg(&gpio->chip, base, GEDR);
+		pending = readl(gedr);
+		while (pending) {
+			pin = __ffs(pending);
+			mask = BIT(pin);
+			pending &= ~mask;
+			if (test_bit(pin, &gpio->pins[i])) {
+				/* ACPI5 event model */
+				sprintf(buf, "_%c%02X",
+					test_bit(pin,
+						 &gpio->mode[i]) ? 'E' : 'L',
+					pin);
+				status =
+				    acpi_get_handle(gpio->adev->handle, buf,
+						    &handle);
+				if (ACPI_FAILURE(status)) {
+					writel(mask, gedr);
+					goto end;
+				}
+				if (test_bit(pin, &gpio->mode[i])) {
+					/* Clear the mask first if it is EDGE triggered */
+					writel(mask, gedr);
+					acpi_evaluate_object(handle, NULL, NULL,
+							     NULL);
+				} else {
+					acpi_evaluate_object(handle, NULL, NULL,
+							     NULL);
+					writel(mask, gedr);
+				}
+			} else {
+				/* Clear before handling so we can't lose an edge */
+				writel(mask, gedr);
+				generic_handle_irq(gpio->irq_base + base + pin);
+			}
+		}
+	}
+end:
+	chip->irq_eoi(data);
+}
+
+static __init acpi_status gpio_parse_resource(struct acpi_resource *res,
+					      void *data)
+{
+	struct acpi_gpio *gpio = data;
+	u32 start, len;
+	static int irq_base = ACPI_GPIO_IRQ_BASE;
+	static int gpio_base = 0;
+	acpi_status status = AE_OK;
+
+	switch (res->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		gpio->irq = res->data.irq.interrupts[0];
+		break;
+	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
+		if (gpio->reg_base) {
+			dev_err(&gpio->adev->dev, "duplicate register base\n");
+			status = AE_ERROR;
+			break;
+		}
+		/* get register base addr */
+		start = res->data.fixed_memory32.address;
+		len = res->data.fixed_memory32.address_length;
+		gpio->reg_base = ioremap_nocache(start, len);
+		if (!gpio->reg_base) {
+			status = AE_ERROR;
+			break;
+		}
+		gpio->irq_base = irq_base;
+		gpio->chip.base = gpio_base;
+		irq_base += ACPI_GPIO_IRQ_LENGTH;
+		gpio_base += ACPI_GPIO_IRQ_LENGTH;
+		break;
+	default:
+		break;
+	}
+
+	return status;
+}
+
+static int acpi_gpio_add(struct acpi_device *device)
+{
+	struct acpi_gpio *gpio = NULL;
+	int i;
+	struct acpi_resource *res;
+	struct acpi_resource_gpio *gpio_res;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	int result = -ENODEV;
+	acpi_status status;
+
+	if (acpi_disabled)
+		goto err;
+
+	gpio = kzalloc(sizeof(struct acpi_gpio), GFP_KERNEL);
+	if (!gpio) {
+		dev_err(&device->dev, "can't allocate acpi_gpio chip data\n");
+		result = -ENOMEM;
+		goto err;
+	}
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     gpio_parse_resource, gpio);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&device->dev, "can't get GPIO resoure\n");
+		goto err_unmap;
+	}
+	if (!gpio->reg_base) {
+		dev_err(&device->dev, "can't get GPIO register address\n");
+		goto err_unmap;
+	}
+
+	gpio->chip.label = dev_name(&device->dev);
+	gpio->chip.direction_input = acpi_gpio_direction_input;
+	gpio->chip.direction_output = acpi_gpio_direction_output;
+	gpio->chip.get = acpi_gpio_get;
+	gpio->chip.set = acpi_gpio_set;
+	gpio->chip.to_irq = acpi_gpio_to_irq;
+	gpio->chip.ngpio = ACPI_GPIO_IRQ_LENGTH;
+	gpio->chip.can_sleep = 0;
+	gpio->adev = device;
+	gpio->pins =
+	    kzalloc((gpio->chip.ngpio / BITS_PER_BYTE) * 2, GFP_KERNEL);
+	if (!gpio->pins) {
+		dev_err(&device->dev, "can't allocate bitmap\n");
+		result = -ENOMEM;
+		goto err_unmap;
+	}
+	gpio->mode = gpio->pins + gpio->chip.ngpio / BITS_PER_LONG;
+	result = gpiochip_add(&gpio->chip);
+	if (result) {
+		dev_err(&device->dev, "acpi gpiochip_add error %d\n", result);
+		goto err_freemem;
+	}
+
+	device->driver_data = gpio;
+
+	/* Find all the pins that follow ACPI 5.0 event model */
+	status = acpi_get_event_resources(device->handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			dev_err(&device->dev,
+				"failed to get GPIOINT resources\n");
+			goto err_freemem;
+		}
+	} else {
+		for (res = buffer.pointer;
+		     res && (res->type != ACPI_RESOURCE_TYPE_END_TAG);
+		     res = ACPI_NEXT_RESOURCE(res)) {
+			unsigned long offset, bit;
+			if (res->type != ACPI_RESOURCE_TYPE_GPIO)
+				continue;
+			gpio_res = &res->data.gpio;
+			if (gpio_res->connection_type !=
+			    ACPI_RESOURCE_GPIO_TYPE_INT)
+				continue;
+			if (gpio_res->pin_table_length > 1) {
+				dev_err(&device->dev,
+					"multiple pin table not supported\n");
+				goto err_freemem;
+			}
+			offset = gpio_res->pin_table[0] / BITS_PER_LONG;
+			bit = gpio_res->pin_table[0] % BITS_PER_LONG;
+			set_bit(bit, &gpio->pins[offset]);
+			if (gpio_res->triggering)
+				set_bit(bit, &gpio->mode[offset]);
+		}
+	}
+
+	irq_set_handler_data(gpio->irq, gpio);
+	irq_set_chained_handler(gpio->irq, acpi_gpio_irq_handler);
+	for (i = 0; i < gpio->chip.ngpio; i++) {
+		irq_set_chip_and_handler_name(i + gpio->irq_base, &acpi_irqchip,
+					      handle_simple_irq, "demux");
+		irq_set_chip_data(i + gpio->irq_base, gpio);
+	}
+
+	spin_lock_init(&gpio->lock);
+
+	mutex_lock(&acpi_gpio_lock);
+	list_add(&gpio->node, &acpi_gpio_list);
+	mutex_unlock(&acpi_gpio_lock);
+done:
+	return result;
+err_freemem:
+	kfree(gpio->pins);
+err_unmap:
+	if (gpio->reg_base)
+		iounmap(gpio->reg_base);
+	kfree(gpio);
+err:
+	goto done;
+}
+
+static int acpi_gpio_remove(struct acpi_device *device, int type)
+{
+	struct acpi_gpio *gpio = acpi_driver_data(device);
+
+	gpiochip_remove(&gpio->chip);
+	kfree(gpio->pins);
+	iounmap(gpio->reg_base);
+	kfree(gpio);
+	return 0;
+}
+
+static struct acpi_device_id gpio_device_ids[] = {
+	{.id = "INT33B2", 0},
+	{.id = "", 0},
+};
+
+static struct acpi_driver acpi_gpio_driver = {
+	.name = "gpio",
+	.class = ACPI_GPIO_CLASS,
+	.ids = gpio_device_ids,
+	.ops = {
+		.add = acpi_gpio_add,
+		.remove = acpi_gpio_remove,
+		},
+};
+
+int __init acpi_gpio_init(void)
+{
+	return acpi_bus_register_driver(&acpi_gpio_driver);
+}
+
+int acpi_device_get_gpio_irq(char *path, int pin, int *irq)
+{
+	struct acpi_gpio *gpio;
+	struct acpi_device *device;
+	acpi_handle handle;
+	acpi_status status;
+	int result;
+
+	status = acpi_get_handle(NULL, path, &handle);
+	if (ACPI_FAILURE(status))
+		goto err;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		goto err;
+
+	gpio = acpi_driver_data(device);
+	if (!gpio)
+		goto err;
+
+	*irq = pin + gpio->irq_base;
+
+	return 0;
+
+err:
+	return -ENODEV;
+}
+
+EXPORT_SYMBOL(acpi_device_get_gpio_irq);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ca75b9c..8f70003 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -74,6 +74,11 @@ void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
 void acpi_ec_unblock_transactions_early(void);
 
+/* --------------------------------------------------------------------------
+                                  GPIO Controller
+   -------------------------------------------------------------------------- */
+int acpi_gpio_init(void);
+
 /*--------------------------------------------------------------------------
                                   Suspend/Resume
   -------------------------------------------------------------------------- */
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index bb145e4..b75a408 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -79,6 +79,10 @@
 #define ACPI_FIXED_HARDWARE_EVENT	0x100
 
 /* --------------------------------------------------------------------------
+                                       GPIO
+   -------------------------------------------------------------------------- */
+int acpi_device_get_gpio_irq(char *path, int pin, int *irq);
+/* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
 
-- 
1.7.7.6



