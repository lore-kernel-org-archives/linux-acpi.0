Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793602021;
	b=P2XoKGt70ltm6SIEXupgQ7xlTQQlACyjycJdKDN1IUT0sjzSqrXIROSR2uF2Zwwjsebc
	 UCRKnfDjoFbkTmgZn1ABpGCwsU6L1rTUQZYkV/pQXMEXvO6d3tsAktZH9YVcr8WF0OUTs
	 cdn7QEOtGiU1MtOpOrTQW+mqy42++3Hc+TmcuaiN4eRxmu99XBB5H/IoCxMYDO4kh+J6m
	 tjUoO0gKr58Vzye7kiP/QSYX+koOIlKftsO7LAc238h4vzIpqjOfNqs3ENUkjWS9JOdCi
	 ErFLsi3+L1NaXrFZVldA58LiPo2vggKviPgIKpLrnKxFrl5h0ERiXGpoOQQQI4AJyyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602021;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SkQph/c6/2XkrgK8QPCf/DZW8MfWZLXyizZFQ7xmM9c=;
	b=H8Ryx6CA738c5V5nS7x+qb/zHvHwqHrvjTMg1expeLoqMNjhcDxe165zzf+rhxIYXknF
	 PgIpJ2RFHXeKPtvNKSXxxjfDu7rglzlf7WSkEwIBfBSpBxaJKRGB/aZYsIeSq/RSqDBCO
	 otfyPluiO5j9ZFj/AWSbl5Y94bO4q9P5wAsXml+F8kk+HqiXSyFJFpF4GxpAdtlM/TRUi
	 OrmobBkSozYengHDDZ3U2DDD5GdwnpG9+bK2LQfH6Tvzsy7eA5ED/u55Y5xHndnOzAns3
	 6swO72c3Abt87b2ZbNdfChNNErgMtuBCXeU9DDzVDYWg10eemFfduz7kgP6nTVZ8u/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Eh8k/PYI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3D60A380B;
	Mon,  2 Nov 2026 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eh8k/PYI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793602021;
	b=xfgl0rbDmOoWFhB3lWDpptKvI5cQ7Yv+k8aLRl0GwmTKF5BuuVqbpg7p5XxGGf53G+oA
	 rxT8migfPJcjrxMZNLWwhXF5uLEjiYSTuYrLDv4byH+4VS2d38qLwhnftFDGXK+aXAQ57
	 wRKxlULlfAwqqb1SnFo8Lit+YiEj5cYqt33lK7TDGoF+9hMwfYOAB7IZU9tChgkd1q8rL
	 HUu3YnQdZ6cDJdttM2IVsdyvb9dvEdftYxqZE5aCguKb2Q6IfyvNFZaF0FknOvXKLngoe
	 npheuWyavA+yMXzR1dS2tJNtOBYYw+HtvZlBG23w7N9aD009hQYcn2PWUKffEpx71Jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793602021;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SkQph/c6/2XkrgK8QPCf/DZW8MfWZLXyizZFQ7xmM9c=;
	b=CJSCD6l5i30MUpMEprt5gKBFs454Mx1oP8J/iVqXgaS0Aj2BhcAnPKhqaa6HSOR1V7fb
	 kCqjzTHQ1n1hWxvX3vRG8JYJCvdnU8qLYxzgkIdm/SGwAaVwt+/3HFqw5aQBtYHBepjaL
	 hbNMgr7b96pMaxY+4HJrsR0oPKJJmGIzF+OPgALNaQbbF93CVhcziLuvcOofGFxuW7Ovx
	 HQiS0GxnpS31VX+D/nrqlozwDz89EiGbu6kCCtzxjPv2B/ma0QomcUSjVwt3Svu2Aitdj
	 UYvM5BQwrVrUCM7ljGJ5cKjfaorXcadPwPjKY2ZDqUMVx55r2nOFj/7iZ+pjL93Smew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 56E451F00A1C;
	Mon,  2 Nov 2026 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793602021;
	bh=SkQph/c6/2XkrgK8QPCf/DZW8MfWZLXyizZFQ7xmM9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Eh8k/PYIAJHaka1Feptx68cmIRyApsvP7r2oCVLVuR8vWGuTAM2K1TQWU0k5lh+a3
	 IKNkuyHscF2eysazut1umwCDNjxlBaHMAdtdyJLZIFQ9cAU1Nv57yfzfVdrejw+YEw
	 oh7zWYTHrmIGsJz3weg9br/kc+HH6Z8+S/SUQebK/qm32K0Eak+65TL9StmXQifz9c
	 XDEveuvgu4q52XGy0XJeHUawA9pjGz4Xwc8Icicga7Vj8IqDo1t8u5PpRAI9oKaRH8
	 +ai7MJOR6Mv6rv/U6+DvU6YzAyaGevE2cKvWQUYrmIfFKoF40UJmKoBlMeUUyLuMef
	 noeZZFNAGXtrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06ACE463CF;
	Mon,  2 Nov 2026 06:46:56 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 02 Nov 2026 14:46:03 +0800
Subject: [PATCH v13 10/13] gpio: pl061: switch data path to gpio-regmap
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-cv75-gpio-v13-10-4f93114ea204@ambarella.com>
References: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
In-Reply-To: <20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793602013; l=20081;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=XfUXAXjWP5eT79MklBxlIIEi8DWwpYOozYSBvSoTHlo=;
 b=gUyspnLM09NzSvsjOgCiwV0Do4DzOrv45pSWXydOoDOM9gk96pVOLsxO9QzX+nhMGGRY6nGCi
 m4rzakrgk19AAtKTK6vXzAu3u6y/9gb/LbXoDx2LDeFMMSYy4DQC6KD
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Move get, set and direction onto gpio-regmap. ARM PL061 sets
GPIO_REGMAP_QUIRK_SET_AFTER_DIR so the output value is written after
the direction change.

Keep a custom irqchip and irq domain. Create the domain with the PL061
private data and let gpio-regmap attach it.

Leave the chained handler's regmap_read() unchecked. mis stays 0 on
failure, so the pending loop does nothing, and chained_irq_exit()
still runs. irq_type still ignores MMIO write returns.

The irqchip uses its own child IRQ lockdep class. Split teardown into
two devm actions: dispose mappings while the domain is still alive,
and clear the chained handler only after it was installed. Checked
with lockdep on the CV75 board. irq_set_parent() nests the GPIO
irq_desc under the AMBA parent for irq_set_wake(). The gpiochip IRQ
resource helpers cannot be kept here: the gpio_chip is not reachable
through gpio-regmap's external irq_domain path, so
GPIOD_FLAG_USED_AS_IRQ is never tracked. This matches the other users
of that path (gpio-idio-16, gpio-pcie-idio-24, gpio-104-idi-48).

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/Kconfig      |   1 +
 drivers/gpio/gpio-pl061.c | 419 +++++++++++++++++++++++++++-------------------
 2 files changed, 249 insertions(+), 171 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2a1487bd1a94..55a129836158 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -583,6 +583,7 @@ config GPIO_PL061
 	depends on ARM_AMBA || COMPILE_TEST
 	select IRQ_DOMAIN
 	select GPIOLIB_IRQCHIP
+	select GPIO_REGMAP
 	select REGMAP_MMIO
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device.
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 27ed759486ca..cb1ef0f3774c 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -12,21 +12,19 @@
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/log2.h>
 #include <linux/module.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
-#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #define GPIODIR 0x400
@@ -41,23 +39,40 @@
 #define PL061_GPIO_NR	8
 #define PL061_DATA_OFFSET	2
 
-struct pl061_context_save_regs {
-	u8 gpio_data;
-	u8 gpio_dir;
-	u8 gpio_is;
-	u8 gpio_ibe;
-	u8 gpio_iev;
-	u8 gpio_ie;
+struct pl061_regs {
+	unsigned int dat;
+	unsigned int dir;
+	unsigned int is;
+	unsigned int ibe;
+	unsigned int iev;
+	unsigned int ie;
+	unsigned int mis;
+	unsigned int ic;
+	unsigned int mask;
+	unsigned int enable;
+};
+
+struct pl061_drvdata {
+	const struct regmap_config *regmap_config;
+	const struct pl061_regs *regs;
+	unsigned int ngpio;
+	bool clear_irq_on_type;
+	bool pm;
+	unsigned long quirks;
+	int (*reg_mask_xlate)(struct gpio_regmap *gpio,
+			      unsigned int base, unsigned int offset,
+			      unsigned int *reg, unsigned int *mask);
 };
 
 struct pl061 {
 	raw_spinlock_t		lock;
 
 	struct regmap		*regmap;
-	struct gpio_chip	gc;
+	const struct pl061_drvdata *data;
+	struct irq_domain	*irq_domain;
 	int			parent_irq;
 
-	struct pl061_context_save_regs csave_regs;
+	unsigned int		saved_dat;
 };
 
 static bool pl061_arm_is_data_reg(unsigned int reg)
@@ -88,82 +103,36 @@ static const struct regmap_config pl061_arm_regmap_config = {
 	.use_raw_spinlock = true,
 };
 
-static int pl061_get_direction(struct gpio_chip *gc, unsigned offset)
+static unsigned int pl061_line_mask(struct pl061 *pl061, irq_hw_number_t hwirq)
 {
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	int ret;
-
-	ret = regmap_test_bits(pl061->regmap, GPIODIR, BIT(offset));
-	if (ret < 0)
-		return ret;
-
-	if (ret)
-		return GPIO_LINE_DIRECTION_OUT;
-
-	return GPIO_LINE_DIRECTION_IN;
+	return BIT(hwirq % pl061->data->ngpio);
 }
 
-static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
+static int pl061_arm_reg_mask_xlate(struct gpio_regmap *gpio,
+				    unsigned int base, unsigned int offset,
+				    unsigned int *reg, unsigned int *mask)
 {
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-
-	guard(raw_spinlock_irqsave)(&pl061->lock);
-
-	regmap_clear_bits(pl061->regmap, GPIODIR, BIT(offset));
-
-	return 0;
-}
-
-static int pl061_direction_output(struct gpio_chip *gc, unsigned offset,
-		int value)
-{
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	unsigned int mask = BIT(offset);
-
-	guard(raw_spinlock_irqsave)(&pl061->lock);
-
-	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
-			   BIT(offset), value);
-	regmap_set_bits(pl061->regmap, GPIODIR, mask);
-
-	/*
-	 * gpio value is set again, because pl061 doesn't allow to set value of
-	 * a gpio pin before configuring it in OUT mode.
-	 */
-	regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
-			   BIT(offset), value);
+	if (base == 0)
+		*reg = BIT(offset + PL061_DATA_OFFSET);
+	else
+		*reg = base;
+	*mask = BIT(offset);
 
 	return 0;
 }
 
-static int pl061_get_value(struct gpio_chip *gc, unsigned offset)
-{
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-
-	return regmap_test_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
-				BIT(offset));
-}
-
-static int pl061_set_value(struct gpio_chip *gc, unsigned int offset, int value)
-{
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-
-	return regmap_assign_bits(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
-				  BIT(offset), value);
-}
-
 static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	struct device *parent = gc->parent;
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(d);
+	struct device *parent = regmap_get_device(pl061->regmap);
+	const struct pl061_regs *regs = pl061->data->regs;
 	int offset = irqd_to_hwirq(d);
 	unsigned int bit = BIT(offset);
 	unsigned int gpioiev = 0;
 	unsigned int gpioibe = 0;
 	unsigned int gpiois = 0;
 
-	if (offset < 0 || offset >= PL061_GPIO_NR)
+	if (offset < 0 || offset >= pl061->data->ngpio)
 		return -EINVAL;
 
 	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {
@@ -176,9 +145,9 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 
 	guard(raw_spinlock_irqsave)(&pl061->lock);
 
-	regmap_read(pl061->regmap, GPIOIEV, &gpioiev);
-	regmap_read(pl061->regmap, GPIOIS, &gpiois);
-	regmap_read(pl061->regmap, GPIOIBE, &gpioibe);
+	regmap_read(pl061->regmap, regs->iev, &gpioiev);
+	regmap_read(pl061->regmap, regs->is, &gpiois);
+	regmap_read(pl061->regmap, regs->ibe, &gpioibe);
 
 	if (trigger & IRQ_TYPE_LEVEL_MASK) {
 		bool polarity = trigger & IRQ_TYPE_LEVEL_HIGH;
@@ -229,54 +198,47 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 		dev_warn(parent, "no trigger selected for line %d\n", offset);
 	}
 
-	regmap_write(pl061->regmap, GPIOIS, gpiois);
-	regmap_write(pl061->regmap, GPIOIBE, gpioibe);
-	regmap_write(pl061->regmap, GPIOIEV, gpioiev);
+	regmap_write(pl061->regmap, regs->is, gpiois);
+	regmap_write(pl061->regmap, regs->ibe, gpioibe);
+	regmap_write(pl061->regmap, regs->iev, gpioiev);
+	if (pl061->data->clear_irq_on_type)
+		regmap_write(pl061->regmap, regs->ic, bit);
 
 	return 0;
 }
 
 static void pl061_irq_handler(struct irq_desc *desc)
 {
-	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct pl061 *pl061 = irq_desc_get_handler_data(desc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
 	unsigned long pending;
 	unsigned int mis = 0;
 	int offset;
 
 	chained_irq_enter(irqchip, desc);
 
-	regmap_read(pl061->regmap, GPIOMIS, &mis);
+	regmap_read(pl061->regmap, pl061->data->regs->mis, &mis);
 	pending = mis;
-	for_each_set_bit(offset, &pending, PL061_GPIO_NR)
-		generic_handle_domain_irq(gc->irq.domain, offset);
+	for_each_set_bit(offset, &pending, pl061->data->ngpio)
+		generic_handle_domain_irq(pl061->irq_domain, offset);
 
 	chained_irq_exit(irqchip, desc);
 }
 
 static void pl061_irq_mask(struct irq_data *d)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(d);
+	unsigned int mask = pl061_line_mask(pl061, irqd_to_hwirq(d));
 
-	scoped_guard(raw_spinlock, &pl061->lock)
-		regmap_clear_bits(pl061->regmap, GPIOIE, mask);
-
-	gpiochip_disable_irq(gc, d->hwirq);
+	regmap_clear_bits(pl061->regmap, pl061->data->regs->ie, mask);
 }
 
 static void pl061_irq_unmask(struct irq_data *d)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
-
-	gpiochip_enable_irq(gc, d->hwirq);
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(d);
+	unsigned int mask = pl061_line_mask(pl061, irqd_to_hwirq(d));
 
-	scoped_guard(raw_spinlock, &pl061->lock)
-		regmap_set_bits(pl061->regmap, GPIOIE, mask);
+	regmap_set_bits(pl061->regmap, pl061->data->regs->ie, mask);
 }
 
 /**
@@ -289,25 +251,23 @@ static void pl061_irq_unmask(struct irq_data *d)
  */
 static void pl061_irq_ack(struct irq_data *d)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
-	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(d);
+	unsigned int mask = pl061_line_mask(pl061, irqd_to_hwirq(d));
 
-	regmap_write(pl061->regmap, GPIOIC, mask);
+	regmap_write(pl061->regmap, pl061->data->regs->ic, mask);
 }
 
 static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	struct pl061 *pl061 = gpiochip_get_data(gc);
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(d);
 
 	return irq_set_irq_wake(pl061->parent_irq, state);
 }
 
 static void pl061_irq_print_chip(struct irq_data *data, struct seq_file *p)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
-	struct device *parent = gc->parent;
+	struct pl061 *pl061 = irq_data_get_irq_chip_data(data);
+	struct device *parent = regmap_get_device(pl061->regmap);
 
 	seq_puts(p, dev_name(parent));
 }
@@ -320,67 +280,169 @@ static const struct irq_chip pl061_irq_chip = {
 	.irq_set_wake		= pl061_irq_set_wake,
 	.irq_print_chip		= pl061_irq_print_chip,
 	.flags			= IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static struct lock_class_key pl061_irq_lock_class;
+static struct lock_class_key pl061_irq_request_class;
+
+static int pl061_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				irq_hw_number_t hwirq)
+{
+	struct pl061 *pl061 = d->host_data;
+
+	irq_set_chip_data(virq, pl061);
+	irq_set_lockdep_class(virq, &pl061_irq_lock_class, &pl061_irq_request_class);
+	irq_set_chip_and_handler(virq, &pl061_irq_chip, handle_bad_irq);
+	irq_set_noprobe(virq);
+	irq_set_parent(virq, pl061->parent_irq);
+
+	return 0;
+}
+
+static void pl061_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
+{
+	irq_set_chip_and_handler(virq, NULL, NULL);
+	irq_set_chip_data(virq, NULL);
+}
+
+static const struct irq_domain_ops pl061_irq_domain_ops = {
+	.map	= pl061_irq_domain_map,
+	.unmap	= pl061_irq_domain_unmap,
+	.xlate	= irq_domain_xlate_twothreecell,
+};
+
+static void pl061_dispose_irq_mappings(void *data)
+{
+	struct pl061 *pl061 = data;
+
+	for (unsigned int i = 0; i < pl061->data->ngpio; i++)
+		irq_dispose_mapping(irq_find_mapping(pl061->irq_domain, i));
+}
+
+static void pl061_remove_chained_handler(void *data)
+{
+	struct pl061 *pl061 = data;
+
+	irq_set_chained_handler_and_data(pl061->parent_irq, NULL, NULL);
+}
+
+static const struct pl061_regs pl061_arm_regs = {
+	.dir	= GPIODIR,
+	.is	= GPIOIS,
+	.ibe	= GPIOIBE,
+	.iev	= GPIOIEV,
+	.ie	= GPIOIE,
+	.mis	= GPIOMIS,
+	.ic	= GPIOIC,
+};
+
+static const struct pl061_drvdata pl061_arm = {
+	.regmap_config		= &pl061_arm_regmap_config,
+	.regs			= &pl061_arm_regs,
+	.ngpio			= PL061_GPIO_NR,
+	.quirks			= GPIO_REGMAP_QUIRK_SET_AFTER_DIR,
+	.pm			= true,
+	.reg_mask_xlate		= pl061_arm_reg_mask_xlate,
 };
 
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
+	struct gpio_regmap_config config = {};
+	const struct pl061_drvdata *data;
 	struct device *dev = &adev->dev;
-	struct gpio_irq_chip *girq;
+	struct gpio_regmap *gpio_regmap;
+	const struct pl061_regs *regs;
 	struct pl061 *pl061;
 	void __iomem *base;
 	int ret, irq;
 
+	data = id->data;
+	if (!data)
+		return -ENODATA;
+
+	regs = data->regs;
+
 	pl061 = devm_kzalloc(dev, sizeof(*pl061), GFP_KERNEL);
 	if (pl061 == NULL)
 		return -ENOMEM;
 
+	pl061->data = data;
+
 	base = devm_ioremap_resource(dev, &adev->res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	pl061->regmap = devm_regmap_init_mmio(dev, base, &pl061_arm_regmap_config);
+	pl061->regmap = devm_regmap_init_mmio(dev, base, data->regmap_config);
 	if (IS_ERR(pl061->regmap))
 		return PTR_ERR(pl061->regmap);
 
 	raw_spin_lock_init(&pl061->lock);
-	pl061->gc.request = gpiochip_generic_request;
-	pl061->gc.free = gpiochip_generic_free;
-	pl061->gc.base = -1;
-	pl061->gc.get_direction = pl061_get_direction;
-	pl061->gc.direction_input = pl061_direction_input;
-	pl061->gc.direction_output = pl061_direction_output;
-	pl061->gc.get = pl061_get_value;
-	pl061->gc.set = pl061_set_value;
-	pl061->gc.ngpio = PL061_GPIO_NR;
-	pl061->gc.label = dev_name(dev);
-	pl061->gc.parent = dev;
-	pl061->gc.owner = THIS_MODULE;
+
+	if (regs->enable) {
+		ret = regmap_write(pl061->regmap, regs->enable, ~0U);
+		if (ret)
+			return ret;
+	}
+	if (regs->mask) {
+		ret = regmap_write(pl061->regmap, regs->mask, ~0U);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * irq_chip support
 	 */
-	regmap_write(pl061->regmap, GPIOIE, 0); /* disable irqs */
+	regmap_write(pl061->regmap, regs->ie, 0); /* disable irqs */
+
 	irq = adev->irq[0];
 	if (!irq)
-		dev_warn(&adev->dev, "IRQ support disabled\n");
+		dev_warn(dev, "IRQ support disabled\n");
 	pl061->parent_irq = irq;
 
-	girq = &pl061->gc.irq;
-	gpio_irq_chip_set_chip(girq, &pl061_irq_chip);
-	girq->parent_handler = pl061_irq_handler;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
-				     GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-	girq->parents[0] = irq;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_bad_irq;
+	if (irq) {
+		const struct irq_domain_info info = {
+			.fwnode		= dev_fwnode(dev),
+			.size		= data->ngpio,
+			.hwirq_max	= data->ngpio,
+			.ops		= &pl061_irq_domain_ops,
+			.host_data	= pl061,
+		};
+
+		pl061->irq_domain = devm_irq_domain_instantiate(dev, &info);
+		if (IS_ERR(pl061->irq_domain))
+			return PTR_ERR(pl061->irq_domain);
+
+		/*
+		 * Registered before the gpiochip so unbind runs it after
+		 * gpiochip_free_remaining_irqs(), while the domain is still
+		 * alive. devm removes the domain after this action.
+		 */
+		ret = devm_add_action_or_reset(dev, pl061_dispose_irq_mappings, pl061);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_gpiochip_add_data(dev, &pl061->gc, pl061);
-	if (ret)
-		return ret;
+	config.parent = dev;
+	config.regmap = pl061->regmap;
+	config.ngpio = data->ngpio;
+	config.reg_dat_base = GPIO_REGMAP_ADDR(regs->dat);
+	config.reg_set_base = GPIO_REGMAP_ADDR(regs->dat);
+	config.reg_dir_out_base = GPIO_REGMAP_ADDR(regs->dir);
+	config.reg_mask_xlate = data->reg_mask_xlate;
+	config.quirks = data->quirks;
+	config.irq_domain = pl061->irq_domain;
+	config.drvdata = pl061;
+
+	gpio_regmap = devm_gpio_regmap_register(dev, &config);
+	if (IS_ERR(gpio_regmap))
+		return PTR_ERR(gpio_regmap);
+
+	if (irq) {
+		irq_set_chained_handler_and_data(irq, pl061_irq_handler, pl061);
+		ret = devm_add_action_or_reset(dev, pl061_remove_chained_handler, pl061);
+		if (ret)
+			return ret;
+	}
 
 	amba_set_drvdata(adev, pl061);
 	dev_info(dev, "PL061 GPIO chip registered\n");
@@ -388,28 +450,38 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
+static void pl061_cache_ctrl_regs(struct pl061 *pl061, unsigned int *dir)
+{
+	const struct pl061_regs *regs = pl061->data->regs;
+	unsigned int val;
+
+	regmap_read(pl061->regmap, regs->dir, dir);
+	regmap_read(pl061->regmap, regs->is, &val);
+	regmap_read(pl061->regmap, regs->ibe, &val);
+	regmap_read(pl061->regmap, regs->iev, &val);
+	regmap_read(pl061->regmap, regs->ie, &val);
+}
+
 static int pl061_suspend(struct device *dev)
 {
 	struct pl061 *pl061 = dev_get_drvdata(dev);
-	unsigned int val = 0;
-	int offset;
-
-	pl061->csave_regs.gpio_data = 0;
-	regmap_read(pl061->regmap, GPIODIR, &val);
-	pl061->csave_regs.gpio_dir = val;
-	regmap_read(pl061->regmap, GPIOIS, &val);
-	pl061->csave_regs.gpio_is = val;
-	regmap_read(pl061->regmap, GPIOIBE, &val);
-	pl061->csave_regs.gpio_ibe = val;
-	regmap_read(pl061->regmap, GPIOIEV, &val);
-	pl061->csave_regs.gpio_iev = val;
-	regmap_read(pl061->regmap, GPIOIE, &val);
-	pl061->csave_regs.gpio_ie = val;
-
-	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
-		if (pl061->csave_regs.gpio_dir & (BIT(offset)))
-			pl061->csave_regs.gpio_data |=
-				pl061_get_value(&pl061->gc, offset) << offset;
+	unsigned long dir_mask;
+	unsigned int dir = 0;
+	unsigned int offset;
+	unsigned int val;
+
+	if (!pl061->data->pm)
+		return 0;
+
+	pl061_cache_ctrl_regs(pl061, &dir);
+
+	pl061->saved_dat = 0;
+	dir_mask = dir;
+	for_each_set_bit(offset, &dir_mask, pl061->data->ngpio) {
+		val = 0;
+		regmap_read_bypassed(pl061->regmap,
+				     BIT(offset + PL061_DATA_OFFSET), &val);
+		pl061->saved_dat |= val;
 	}
 
 	return 0;
@@ -418,23 +490,27 @@ static int pl061_suspend(struct device *dev)
 static int pl061_resume(struct device *dev)
 {
 	struct pl061 *pl061 = dev_get_drvdata(dev);
-	int offset;
+	const struct pl061_regs *regs;
+	unsigned long dir_mask;
+	unsigned int dir = 0;
+	unsigned int offset;
 
-	for (offset = 0; offset < PL061_GPIO_NR; offset++) {
-		if (pl061->csave_regs.gpio_dir & (BIT(offset)))
-			pl061_direction_output(&pl061->gc, offset,
-					pl061->csave_regs.gpio_data &
-					(BIT(offset)));
-		else
-			pl061_direction_input(&pl061->gc, offset);
-	}
+	if (!pl061->data->pm)
+		return 0;
 
-	regmap_write(pl061->regmap, GPIOIS, pl061->csave_regs.gpio_is);
-	regmap_write(pl061->regmap, GPIOIBE, pl061->csave_regs.gpio_ibe);
-	regmap_write(pl061->regmap, GPIOIEV, pl061->csave_regs.gpio_iev);
-	regmap_write(pl061->regmap, GPIOIE, pl061->csave_regs.gpio_ie);
+	regs = pl061->data->regs;
 
-	return 0;
+	regmap_read(pl061->regmap, regs->dir, &dir);
+
+	regcache_mark_dirty(pl061->regmap);
+	regcache_sync_region(pl061->regmap, regs->dir, regs->dir);
+
+	dir_mask = dir;
+	for_each_set_bit(offset, &dir_mask, pl061->data->ngpio)
+		regmap_write(pl061->regmap, BIT(offset + PL061_DATA_OFFSET),
+			     pl061->saved_dat & BIT(offset));
+
+	return regcache_sync_region(pl061->regmap, regs->is, regs->ie);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(pl061_dev_pm_ops, pl061_suspend, pl061_resume);
@@ -443,6 +519,7 @@ static const struct amba_id pl061_ids[] = {
 	{
 		.id	= 0x00041061,
 		.mask	= 0x000fffff,
+		.data	= (void *)&pl061_arm,
 	},
 	{ 0, 0 },
 };

-- 
2.34.1


