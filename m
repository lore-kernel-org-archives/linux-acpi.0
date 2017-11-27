From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/3] gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
Date: Mon, 27 Nov 2017 16:54:42 +0300
Message-ID: <20171127135444.66735-2-mika.westerberg@linux.intel.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We added acpi_gpiochip_pin_to_gpio_offset() because there was a need to
translate from ACPI GpioIo/GpioInt number to Linux GPIO number in the
Cherryview pinctrl driver. This translation is necessary because
Cherryview has gaps in the pin list and the driver used continuous GPIO
number space in Linux side as follows:

  created GPIO range 0->7 ==> INT33FF:03 PIN 0->7
  created GPIO range 8->19 ==> INT33FF:03 PIN 15->26
  created GPIO range 20->25 ==> INT33FF:03 PIN 30->35
  created GPIO range 26->33 ==> INT33FF:03 PIN 45->52
  created GPIO range 34->43 ==> INT33FF:03 PIN 60->69
  created GPIO range 44->54 ==> INT33FF:03 PIN 75->85

For example when ACPI GpioInt resource refers to GPIO 81 (SDMMC3_CD_B)
we translate from pin 81 to the corresponding Linux GPIO number, which
is 50. This number is then used when the GPIO is accessed through gpiolib.

It turns out, this is not necessary at all. We can just pass 1:1 mapping
between Linux GPIO numbers and pin numbers (including gaps) and the
pinctrl core handles all the details automatically:

  created GPIO range 0->7 ==> INT33FF:03 PIN 0->7
  created GPIO range 15->26 ==> INT33FF:03 PIN 15->26
  created GPIO range 30->35 ==> INT33FF:03 PIN 30->35
  created GPIO range 45->52 ==> INT33FF:03 PIN 45->52
  created GPIO range 60->69 ==> INT33FF:03 PIN 60->69
  created GPIO range 75->85 ==> INT33FF:03 PIN 75->85

Here GPIO 81 is exactly same than the hardware pin 81 (SDMMC3_CD_B).

As an added bonus this simplifies both the ACPI GPIO core code and the
Cherryview pinctrl driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c                | 75 +-----------------------------
 drivers/pinctrl/intel/pinctrl-cherryview.c | 59 ++++++++---------------
 2 files changed, 22 insertions(+), 112 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index eb4528c87c0b..b77c544bf7e2 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -58,58 +58,6 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 	return ACPI_HANDLE(gc->parent) == data;
 }
 
-#ifdef CONFIG_PINCTRL
-/**
- * acpi_gpiochip_pin_to_gpio_offset() - translates ACPI GPIO to Linux GPIO
- * @gdev: GPIO device
- * @pin: ACPI GPIO pin number from GpioIo/GpioInt resource
- *
- * Function takes ACPI GpioIo/GpioInt pin number as a parameter and
- * translates it to a corresponding offset suitable to be passed to a
- * GPIO controller driver.
- *
- * Typically the returned offset is same as @pin, but if the GPIO
- * controller uses pin controller and the mapping is not contiguous the
- * offset might be different.
- */
-static int acpi_gpiochip_pin_to_gpio_offset(struct gpio_device *gdev, int pin)
-{
-	struct gpio_pin_range *pin_range;
-
-	/* If there are no ranges in this chip, use 1:1 mapping */
-	if (list_empty(&gdev->pin_ranges))
-		return pin;
-
-	list_for_each_entry(pin_range, &gdev->pin_ranges, node) {
-		const struct pinctrl_gpio_range *range = &pin_range->range;
-		int i;
-
-		if (range->pins) {
-			for (i = 0; i < range->npins; i++) {
-				if (range->pins[i] == pin)
-					return range->base + i - gdev->base;
-			}
-		} else {
-			if (pin >= range->pin_base &&
-			    pin < range->pin_base + range->npins) {
-				unsigned gpio_base;
-
-				gpio_base = range->base - gdev->base;
-				return gpio_base + pin - range->pin_base;
-			}
-		}
-	}
-
-	return -EINVAL;
-}
-#else
-static inline int acpi_gpiochip_pin_to_gpio_offset(struct gpio_device *gdev,
-						   int pin)
-{
-	return pin;
-}
-#endif
-
 /**
  * acpi_get_gpiod() - Translate ACPI GPIO pin to GPIO descriptor usable with GPIO API
  * @path:	ACPI GPIO controller full path name, (e.g. "\\_SB.GPO1")
@@ -125,7 +73,6 @@ static struct gpio_desc *acpi_get_gpiod(char *path, int pin)
 	struct gpio_chip *chip;
 	acpi_handle handle;
 	acpi_status status;
-	int offset;
 
 	status = acpi_get_handle(NULL, path, &handle);
 	if (ACPI_FAILURE(status))
@@ -135,11 +82,7 @@ static struct gpio_desc *acpi_get_gpiod(char *path, int pin)
 	if (!chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	offset = acpi_gpiochip_pin_to_gpio_offset(chip->gpiodev, pin);
-	if (offset < 0)
-		return ERR_PTR(offset);
-
-	return gpiochip_get_desc(chip, offset);
+	return gpiochip_get_desc(chip, pin);
 }
 
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
@@ -216,10 +159,6 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 	if (!handler)
 		return AE_OK;
 
-	pin = acpi_gpiochip_pin_to_gpio_offset(chip->gpiodev, pin);
-	if (pin < 0)
-		return AE_BAD_PARAMETER;
-
 	desc = gpiochip_request_own_desc(chip, pin, "ACPI:Event");
 	if (IS_ERR(desc)) {
 		dev_err(chip->parent, "Failed to request GPIO\n");
@@ -852,12 +791,6 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		struct gpio_desc *desc;
 		bool found;
 
-		pin = acpi_gpiochip_pin_to_gpio_offset(chip->gpiodev, pin);
-		if (pin < 0) {
-			status = AE_BAD_PARAMETER;
-			goto out;
-		}
-
 		mutex_lock(&achip->conn_lock);
 
 		found = false;
@@ -990,11 +923,7 @@ static struct gpio_desc *acpi_gpiochip_parse_own_gpio(
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = acpi_gpiochip_pin_to_gpio_offset(chip->gpiodev, gpios[0]);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	desc = gpiochip_get_desc(chip, ret);
+	desc = gpiochip_get_desc(chip, gpios[0]);
 	if (IS_ERR(desc))
 		return desc;
 
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index bdedb6325c72..aa6c9f569c2b 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -131,10 +131,8 @@ struct chv_gpio_pinrange {
  * @ngroups: Number of groups
  * @functions: All functions in this community
  * @nfunctions: Number of functions
- * @ngpios: Number of GPIOs in this community
  * @gpio_ranges: An array of GPIO ranges in this community
  * @ngpio_ranges: Number of GPIO ranges
- * @ngpios: Total number of GPIOs in this community
  * @nirqs: Total number of IRQs this community can generate
  */
 struct chv_community {
@@ -147,7 +145,6 @@ struct chv_community {
 	size_t nfunctions;
 	const struct chv_gpio_pinrange *gpio_ranges;
 	size_t ngpio_ranges;
-	size_t ngpios;
 	size_t nirqs;
 	acpi_adr_space_type acpi_space_id;
 };
@@ -399,7 +396,6 @@ static const struct chv_community southwest_community = {
 	.nfunctions = ARRAY_SIZE(southwest_functions),
 	.gpio_ranges = southwest_gpio_ranges,
 	.ngpio_ranges = ARRAY_SIZE(southwest_gpio_ranges),
-	.ngpios = ARRAY_SIZE(southwest_pins),
 	/*
 	 * Southwest community can benerate GPIO interrupts only for the
 	 * first 8 interrupts. The upper half (8-15) can only be used to
@@ -489,7 +485,6 @@ static const struct chv_community north_community = {
 	.npins = ARRAY_SIZE(north_pins),
 	.gpio_ranges = north_gpio_ranges,
 	.ngpio_ranges = ARRAY_SIZE(north_gpio_ranges),
-	.ngpios = ARRAY_SIZE(north_pins),
 	/*
 	 * North community can generate GPIO interrupts only for the first
 	 * 8 interrupts. The upper half (8-15) can only be used to trigger
@@ -538,7 +533,6 @@ static const struct chv_community east_community = {
 	.npins = ARRAY_SIZE(east_pins),
 	.gpio_ranges = east_gpio_ranges,
 	.ngpio_ranges = ARRAY_SIZE(east_gpio_ranges),
-	.ngpios = ARRAY_SIZE(east_pins),
 	.nirqs = 16,
 	.acpi_space_id = 0x93,
 };
@@ -665,7 +659,6 @@ static const struct chv_community southeast_community = {
 	.nfunctions = ARRAY_SIZE(southeast_functions),
 	.gpio_ranges = southeast_gpio_ranges,
 	.ngpio_ranges = ARRAY_SIZE(southeast_gpio_ranges),
-	.ngpios = ARRAY_SIZE(southeast_pins),
 	.nirqs = 16,
 	.acpi_space_id = 0x94,
 };
@@ -1253,21 +1246,14 @@ static struct pinctrl_desc chv_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
-static unsigned chv_gpio_offset_to_pin(struct chv_pinctrl *pctrl,
-				       unsigned offset)
-{
-	return pctrl->community->pins[offset].number;
-}
-
 static int chv_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct chv_pinctrl *pctrl = gpiochip_get_data(chip);
-	int pin = chv_gpio_offset_to_pin(pctrl, offset);
 	unsigned long flags;
 	u32 ctrl0, cfg;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
-	ctrl0 = readl(chv_padreg(pctrl, pin, CHV_PADCTRL0));
+	ctrl0 = readl(chv_padreg(pctrl, offset, CHV_PADCTRL0));
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
 	cfg = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
@@ -1281,14 +1267,13 @@ static int chv_gpio_get(struct gpio_chip *chip, unsigned offset)
 static void chv_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct chv_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned pin = chv_gpio_offset_to_pin(pctrl, offset);
 	unsigned long flags;
 	void __iomem *reg;
 	u32 ctrl0;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
-	reg = chv_padreg(pctrl, pin, CHV_PADCTRL0);
+	reg = chv_padreg(pctrl, offset, CHV_PADCTRL0);
 	ctrl0 = readl(reg);
 
 	if (value)
@@ -1304,12 +1289,11 @@ static void chv_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	struct chv_pinctrl *pctrl = gpiochip_get_data(chip);
-	unsigned pin = chv_gpio_offset_to_pin(pctrl, offset);
 	u32 ctrl0, direction;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
-	ctrl0 = readl(chv_padreg(pctrl, pin, CHV_PADCTRL0));
+	ctrl0 = readl(chv_padreg(pctrl, offset, CHV_PADCTRL0));
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
 	direction = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
@@ -1345,7 +1329,7 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct chv_pinctrl *pctrl = gpiochip_get_data(gc);
-	int pin = chv_gpio_offset_to_pin(pctrl, irqd_to_hwirq(d));
+	int pin = irqd_to_hwirq(d);
 	u32 intr_line;
 
 	raw_spin_lock(&chv_lock);
@@ -1362,7 +1346,7 @@ static void chv_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct chv_pinctrl *pctrl = gpiochip_get_data(gc);
-	int pin = chv_gpio_offset_to_pin(pctrl, irqd_to_hwirq(d));
+	int pin = irqd_to_hwirq(d);
 	u32 value, intr_line;
 	unsigned long flags;
 
@@ -1407,8 +1391,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_NONE) {
 		struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 		struct chv_pinctrl *pctrl = gpiochip_get_data(gc);
-		unsigned offset = irqd_to_hwirq(d);
-		int pin = chv_gpio_offset_to_pin(pctrl, offset);
+		unsigned pin = irqd_to_hwirq(d);
 		irq_flow_handler_t handler;
 		unsigned long flags;
 		u32 intsel, value;
@@ -1426,7 +1409,7 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 
 		if (!pctrl->intr_lines[intsel]) {
 			irq_set_handler_locked(d, handler);
-			pctrl->intr_lines[intsel] = offset;
+			pctrl->intr_lines[intsel] = pin;
 		}
 		raw_spin_unlock_irqrestore(&chv_lock, flags);
 	}
@@ -1439,8 +1422,7 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct chv_pinctrl *pctrl = gpiochip_get_data(gc);
-	unsigned offset = irqd_to_hwirq(d);
-	int pin = chv_gpio_offset_to_pin(pctrl, offset);
+	unsigned pin = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 value;
 
@@ -1486,7 +1468,7 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned type)
 	value &= CHV_PADCTRL0_INTSEL_MASK;
 	value >>= CHV_PADCTRL0_INTSEL_SHIFT;
 
-	pctrl->intr_lines[value] = offset;
+	pctrl->intr_lines[value] = pin;
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
@@ -1576,12 +1558,12 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
 	const struct chv_gpio_pinrange *range;
 	struct gpio_chip *chip = &pctrl->chip;
 	bool need_valid_mask = !dmi_check_system(chv_no_valid_mask);
-	int ret, i, offset;
-	int irq_base;
+	const struct chv_community *community = pctrl->community;
+	int ret, i, irq_base;
 
 	*chip = chv_gpio_chip;
 
-	chip->ngpio = pctrl->community->ngpios;
+	chip->ngpio = community->pins[community->npins - 1].number + 1;
 	chip->label = dev_name(pctrl->dev);
 	chip->parent = pctrl->dev;
 	chip->base = -1;
@@ -1593,30 +1575,29 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
 		return ret;
 	}
 
-	for (i = 0, offset = 0; i < pctrl->community->ngpio_ranges; i++) {
-		range = &pctrl->community->gpio_ranges[i];
-		ret = gpiochip_add_pin_range(chip, dev_name(pctrl->dev), offset,
-					     range->base, range->npins);
+	for (i = 0; i < community->ngpio_ranges; i++) {
+		range = &community->gpio_ranges[i];
+		ret = gpiochip_add_pin_range(chip, dev_name(pctrl->dev),
+					     range->base, range->base,
+					     range->npins);
 		if (ret) {
 			dev_err(pctrl->dev, "failed to add GPIO pin range\n");
 			return ret;
 		}
-
-		offset += range->npins;
 	}
 
 	/* Do not add GPIOs that can only generate GPEs to the IRQ domain */
-	for (i = 0; i < pctrl->community->npins; i++) {
+	for (i = 0; i < community->npins; i++) {
 		const struct pinctrl_pin_desc *desc;
 		u32 intsel;
 
-		desc = &pctrl->community->pins[i];
+		desc = &community->pins[i];
 
 		intsel = readl(chv_padreg(pctrl, desc->number, CHV_PADCTRL0));
 		intsel &= CHV_PADCTRL0_INTSEL_MASK;
 		intsel >>= CHV_PADCTRL0_INTSEL_SHIFT;
 
-		if (need_valid_mask && intsel >= pctrl->community->nirqs)
+		if (need_valid_mask && intsel >= community->nirqs)
 			clear_bit(i, chip->irq.valid_mask);
 	}
 
-- 
2.15.0
