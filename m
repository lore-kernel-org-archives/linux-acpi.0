From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/3] pinctrl: intel: Allow custom GPIO base for pad groups
Date: Mon, 27 Nov 2017 16:54:43 +0300
Message-ID: <20171127135444.66735-3-mika.westerberg@linux.intel.com>
References: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:26514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbdK0NzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Nov 2017 08:55:19 -0500
In-Reply-To: <20171127135444.66735-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Currently we always have direct mapping between GPIO numbers and the
hardware pin numbers. However, there are cases where that's not the case
anymore (more about this in the next patch). Instead we need to be able
to specify custom GPIO base for certain pad groups.

To support this, add a new field (gpio_base) to the pad group structure
and update the core Intel pinctrl driver to handle this accordingly.
Passing 0 as gpio_base will use direct mapping so the existing drivers
do not need to be modified. Passing -1 excludes the whole pad group from
having GPIO mapping.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 156 +++++++++++++++++++++++++---------
 drivers/pinctrl/intel/pinctrl-intel.h |   3 +
 2 files changed, 120 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3544c9fcf598..f54d66723892 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -811,22 +811,63 @@ static const struct gpio_chip intel_gpio_chip = {
 	.set_config = gpiochip_generic_config,
 };
 
+/**
+ * intel_gpio_to_pin() - Translate from GPIO offset to pin number
+ * @pctrl: Pinctrl structure
+ * @offset: GPIO offset from gpiolib
+ * @commmunity: Community is filled here if not %NULL
+ * @padgrp: Pad group is filled here if not %NULL
+ *
+ * When coming through gpiolib irqchip, the GPIO offset is not
+ * automatically translated to pinctrl pin number. This function can be
+ * used to find out the corresponding pinctrl pin.
+ */
+static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
+			     const struct intel_community **community,
+			     const struct intel_padgroup **padgrp)
+{
+	int i;
+
+	for (i = 0; i < pctrl->ncommunities; i++) {
+		const struct intel_community *comm = &pctrl->communities[i];
+		int j;
+
+		for (j = 0; j < comm->ngpps; j++) {
+			const struct intel_padgroup *pgrp = &comm->gpps[j];
+
+			if (pgrp->gpio_base < 0)
+				continue;
+
+			if (offset >= pgrp->gpio_base &&
+			    offset < pgrp->gpio_base + pgrp->size) {
+				int pin;
+
+				pin = pgrp->base + offset - pgrp->gpio_base;
+				if (community)
+					*community = comm;
+				if (padgrp)
+					*padgrp = pgrp;
+
+				return pin;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
 static void intel_gpio_irq_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
-	unsigned pin = irqd_to_hwirq(d);
+	const struct intel_padgroup *padgrp;
+	int pin;
 
-	community = intel_get_community(pctrl, pin);
-	if (community) {
-		const struct intel_padgroup *padgrp;
+	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
+	if (pin >= 0) {
 		unsigned gpp, gpp_offset, is_offset;
 
-		padgrp = intel_community_get_padgroup(community, pin);
-		if (!padgrp)
-			return;
-
 		gpp = padgrp->reg_num;
 		gpp_offset = padgroup_offset(padgrp, pin);
 		is_offset = community->is_offset + gpp * 4;
@@ -842,19 +883,15 @@ static void intel_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
-	unsigned pin = irqd_to_hwirq(d);
+	const struct intel_padgroup *padgrp;
+	int pin;
 
-	community = intel_get_community(pctrl, pin);
-	if (community) {
-		const struct intel_padgroup *padgrp;
+	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
+	if (pin >= 0) {
 		unsigned gpp, gpp_offset, is_offset;
 		unsigned long flags;
 		u32 value;
 
-		padgrp = intel_community_get_padgroup(community, pin);
-		if (!padgrp)
-			return;
-
 		gpp = padgrp->reg_num;
 		gpp_offset = padgroup_offset(padgrp, pin);
 		is_offset = community->is_offset + gpp * 4;
@@ -875,20 +912,16 @@ static void intel_gpio_irq_mask_unmask(struct irq_data *d, bool mask)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	const struct intel_community *community;
-	unsigned pin = irqd_to_hwirq(d);
+	const struct intel_padgroup *padgrp;
+	int pin;
 
-	community = intel_get_community(pctrl, pin);
-	if (community) {
-		const struct intel_padgroup *padgrp;
+	pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), &community, &padgrp);
+	if (pin >= 0) {
 		unsigned gpp, gpp_offset;
 		unsigned long flags;
 		void __iomem *reg;
 		u32 value;
 
-		padgrp = intel_community_get_padgroup(community, pin);
-		if (!padgrp)
-			return;
-
 		gpp = padgrp->reg_num;
 		gpp_offset = padgroup_offset(padgrp, pin);
 
@@ -919,7 +952,7 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	unsigned pin = irqd_to_hwirq(d);
+	unsigned pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
 	unsigned long flags;
 	void __iomem *reg;
 	u32 value;
@@ -976,7 +1009,7 @@ static int intel_gpio_irq_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	unsigned pin = irqd_to_hwirq(d);
+	unsigned pin = intel_gpio_to_pin(pctrl, irqd_to_hwirq(d), NULL, NULL);
 
 	if (on)
 		enable_irq_wake(pctrl->irq);
@@ -1007,14 +1040,10 @@ static irqreturn_t intel_gpio_community_irq_handler(struct intel_pinctrl *pctrl,
 		pending &= enabled;
 
 		for_each_set_bit(gpp_offset, &pending, padgrp->size) {
-			unsigned padno, irq;
-
-			padno = padgrp->base - community->pin_base + gpp_offset;
-			if (padno >= community->npins)
-				break;
+			unsigned irq;
 
 			irq = irq_find_mapping(gc->irq.domain,
-					       community->pin_base + padno);
+					       padgrp->gpio_base + gpp_offset);
 			generic_handle_irq(irq);
 
 			ret |= IRQ_HANDLED;
@@ -1051,13 +1080,56 @@ static struct irq_chip intel_gpio_irqchip = {
 	.flags = IRQCHIP_MASK_ON_SUSPEND,
 };
 
+static int intel_gpio_add_pin_ranges(struct intel_pinctrl *pctrl,
+				     const struct intel_community *community)
+{
+	int ret, i;
+
+	for (i = 0; i < community->ngpps; i++) {
+		const struct intel_padgroup *gpp = &community->gpps[i];
+
+		if (gpp->gpio_base < 0)
+			continue;
+
+		ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
+					     gpp->gpio_base, gpp->base,
+					     gpp->size);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static unsigned intel_gpio_ngpio(const struct intel_pinctrl *pctrl)
+{
+	const struct intel_community *community;
+	unsigned ngpio = 0;
+	int i, j;
+
+	for (i = 0; i < pctrl->ncommunities; i++) {
+		community = &pctrl->communities[i];
+		for (j = 0; j < community->ngpps; j++) {
+			const struct intel_padgroup *gpp = &community->gpps[j];
+
+			if (gpp->gpio_base < 0)
+				continue;
+
+			if (gpp->gpio_base + gpp->size > ngpio)
+				ngpio = gpp->gpio_base + gpp->size;
+		}
+	}
+
+	return ngpio;
+}
+
 static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 {
-	int ret;
+	int ret, i;
 
 	pctrl->chip = intel_gpio_chip;
 
-	pctrl->chip.ngpio = pctrl->soc->npins;
+	pctrl->chip.ngpio = intel_gpio_ngpio(pctrl);
 	pctrl->chip.label = dev_name(pctrl->dev);
 	pctrl->chip.parent = pctrl->dev;
 	pctrl->chip.base = -1;
@@ -1069,11 +1141,14 @@ static int intel_gpio_probe(struct intel_pinctrl *pctrl, int irq)
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
-				     0, 0, pctrl->soc->npins);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add GPIO pin range\n");
-		return ret;
+	for (i = 0; i < pctrl->ncommunities; i++) {
+		struct intel_community *community = &pctrl->communities[i];
+
+		ret = intel_gpio_add_pin_ranges(pctrl, community);
+		if (ret) {
+			dev_err(pctrl->dev, "failed to add GPIO pin range\n");
+			return ret;
+		}
 	}
 
 	/*
@@ -1133,6 +1208,9 @@ static int intel_pinctrl_add_padgroups(struct intel_pinctrl *pctrl,
 		if (gpps[i].size > 32)
 			return -EINVAL;
 
+		if (!gpps[i].gpio_base)
+			gpps[i].gpio_base = gpps[i].base;
+
 		gpps[i].padown_num = padown_num;
 
 		/*
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 13b0bd6eb2a2..98fdf9adf623 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -51,6 +51,8 @@ struct intel_function {
  * @reg_num: GPI_IS register number
  * @base: Starting pin of this group
  * @size: Size of this group (maximum is 32).
+ * @gpio_base: Starting GPIO base of this group (%0 if matches with @base,
+ *	       and %-1 if no GPIO mapping should be created)
  * @padown_num: PAD_OWN register number (assigned by the core driver)
  *
  * If pad groups of a community are not the same size, use this structure
@@ -60,6 +62,7 @@ struct intel_padgroup {
 	unsigned reg_num;
 	unsigned base;
 	unsigned size;
+	int gpio_base;
 	unsigned padown_num;
 };
 
-- 
2.15.0

